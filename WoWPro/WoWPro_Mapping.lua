-------------------------------------------------------------------------------
-- Localized Lua globals
-------------------------------------------------------------------------------
local _G = getfenv(0)

local _
local assert = _G.assert
local floor = _G.floor
local math = _G.math
local sqrt = _G.sqrt
local string = _G.string
local strreplace = _G.strreplace
local strsplit = _G.strsplit
local strtrim = _G.strtrim
local strupper = _G.strupper
local tonumber = _G.tonumber
local tostring = _G.tostring
local type = _G.type

local table = _G.table
local ipairs = _G.ipairs
local pairs = _G.pairs
local select = _G.select
local wipe = _G.wipe

local LightHeaded = _G.LightHeaded
local TomTom = _G.TomTom

local MAX_NUM_QUESTS = _G.MAX_NUM_QUESTS
local WorldMapDetailFrame = _G.WorldMapDetailFrame

local GetCurrentMapAreaID = _G.GetCurrentMapAreaID
local GetCurrentMapDungeonLevel = _G.GetCurrentMapDungeonLevel
local GetPlayerMapPosition = _G.GetPlayerMapPosition
local GetQuestLogIndexByID = _G.GetQuestLogIndexByID
local IsQuestWatched = _G.IsQuestWatched
local PlaySoundFile = _G.PlaySoundFile
local QuestMapUpdateAllQuests = _G.QuestMapUpdateAllQuests
local QuestPOIUpdateIcons = _G.QuestPOIUpdateIcons
local QuestPOI_SelectButtonByQuestId = _G.QuestPOI_SelectButtonByQuestId
local SetSuperTrackedQuestID = _G.SetSuperTrackedQuestID
local ToggleDropDownMenu = _G.ToggleDropDownMenu
local UnitOnTaxi = _G.UnitOnTaxi
local WORLDMAP_SETTINGS = _G.WORLDMAP_SETTINGS
local WorldMapFrame_UpdateQuests = _G.WorldMapFrame_UpdateQuests

local LibStub = _G.LibStub

local err_params = {}
local function err(msg, ...)
	if not _G.WoWPro.map_debug then return end
	msg = tostring(msg)
	wipe(err_params)
	for i=1,select('#',...) do err_params[i] = tostring(select(i,...)) end
	_G.geterrorhandler()(msg:format(_G.unpack(err_params)) .. " - " .. _G.time())
end

----------------------------------
--      WoWPro_Mapping.lua      --
----------------------------------
local WoWPro = LibStub("AceAddon-3.0"):GetAddon("WoWPro")

local L = _G.WoWPro_Locale
local cache = {}
local B = LibStub("LibBabble-Zone-3.0")
local BL = B:GetUnstrictLookupTable()

-- Map dat
--local LMD = LibStub("LibMapData-1.0")
-- Debug
WoWPro.mappoints_cache = cache
WoWPro.map_debug = false

-- placeholder flags in case you want to implement options to disable
-- later on TomTom tooltips and right-clicking drop-down menus
local SHOW_MINIMAP_MENU = true
local SHOW_WORLDMAP_MENU = true
local SHOW_MINIMAP_TOOLTIP = true
local SHOW_WORLDMAP_TOOLTIP = true


-- WoWPro customized callback functions for TomTom --

-- Function to customize the drop-down menu when right-clicking
-- the TomTom waypoint on the minimap
local function WoWProMapping_minimap_onclick(event, uid, self, button)
	if SHOW_MINIMAP_MENU then
		TomTom:InitializeDropdown(uid)
		ToggleDropDownMenu(1, nil, TomTom.dropdown, "cursor", 0, 0)
	end
end

-- Function to customize the drop-down menu when right-clicking
-- the TomTom waypoint on the world map
local function WoWProMapping_worldmap_onclick(event, uid, self, button)
	if SHOW_WORLDMAP_MENU then
		TomTom:InitializeDropdown(uid)
		ToggleDropDownMenu(1, nil, TomTom.dropdown, "cursor", 0, 0)
	end
end

-- Function to customize the tooltip when mouse-over the TomTom waypoint,
-- can be called by both minimap and world map tooltip functions
local function WoWProMapping_tooltip(event, tooltip, uid, dist)

	local iactual
	for i,waypoint in ipairs(cache) do
		if (waypoint.uid == uid) then
			iactual = i break
		end
	end

	local zone = cache[iactual].zone
	local x = cache[iactual].x
	local y = cache[iactual].y
	local desc = cache[iactual].desc
	local jcoord = cache[iactual].j

	tooltip:SetText(desc or L["WoWPro waypoint"])
	if dist and tonumber(dist) then
		tooltip:AddLine((L["%s yards away"]):format(math.floor(dist)), 1, 1, 1)
	else
		tooltip:AddLine(L["Unknown distance"])
	end
	tooltip:AddLine((L["%s (%.2f, %.2f)"]):format(zone, x, y), 0.7, 0.7, 0.7)
	if #cache > 1 then
		tooltip:AddLine((L["Waypoint %d of %d"]):format(jcoord, #cache), 1, 1, 1)
	end
	tooltip:Show()
end

-- Function to customize the tooltip when mouse-over the TomTom waypoint on the minimap
local function WoWProMapping_tooltip_minimap(event, tooltip, uid, dist)
	if not SHOW_MINIMAP_TOOLTIP then
		tooltip:Hide()
		return
	end
	return WoWProMapping_tooltip(event, tooltip, uid, dist)
end

-- Function to customize the tooltip when mouse-over the TomTom waypoint on the world map
local function WoWProMapping_tooltip_worldmap(event, tooltip, uid, dist)
	if not SHOW_WORLDMAP_TOOLTIP then
		tooltip:Hide()
		return
	end
	return WoWProMapping_tooltip(event, tooltip, uid, dist)
end

-- Function to update customized tooltips, for both minimap and world map
-- (could be changed later so they can be different)
local function WoWProMapping_tooltip_update_both(event, tooltip, uid, dist)
	if dist and tonumber(dist) then
		tooltip.lines[2]:SetFormattedText(L["%s yards away"], math.floor(dist), 1, 1, 1)
	else
		tooltip.lines[2]:SetText(L["Unknown distance"])
	end
end

--local autoarrival	-- flag to indicate if the step should autocomplete
			-- when final position is reached; defined inside WoWPro:MapPoint from guide tag

local OldCleardistance	-- saves TomTom's option to restore it

-- Function to handle the distance callback in TomTom, when player gets to the final destination
local function WoWProMapping_distance(event, uid, range, distance, lastdistance)
err("Distance callback: event = %s, title = %s, range = %s, distance = %s, lastdistance = %s", event, uid.title, range, distance, lastdistance)
	if UnitOnTaxi("player") then return end

	-- Replicate normal TomTom arrival functionality
	if TomTom.profile.arrow.enablePing then
	  PlaySoundFile("Interface\\AddOns\\TomTom\\Media\\ping.mp3")
	end

	--if not autoarrival then return end

	local iactual
	for i,waypoint in ipairs(cache) do
		if (waypoint.uid == uid) then
			iactual = i break
		end
	end

	if not iactual then
		err("Can't find uid in cache: event = %s, uid = %s, range = %s, distance = %s, lastdistance = %s", event, uid, range, distance, lastdistance)
		return
	end
	local autoarrival = cache[iactual].autoarrival

	if autoarrival == 1 then
		for i=iactual,#cache,1 do
			TomTom:RemoveWaypoint(cache[i].uid)
		end

		-- TomTom.db.profile.arrow.setclosest = true
		local closest_uid = TomTom:GetClosestWaypoint()

		if closest_uid then
			TomTom:SetCrazyArrow(cache[iactual-1].uid, 1, cache[iactual-1].desc)

			local iactual
			for i,waypoint in ipairs(cache) do
				if (waypoint.uid == closest_uid) then
					iactual = i break end
			end

			if iactual then
				for i=iactual+1,#cache,1 do
					TomTom:RemoveWaypoint(cache[i].uid)
				end
			end
		end

		if iactual == 1 then
			WoWPro.CompleteStep(cache[iactual].index)
		end


	elseif autoarrival == 2 or autoarrival == 3 then
		--if iactual ~= #cache then return
		if iactual == 1 and autoarrival == 2 then
			WoWPro.CompleteStep(cache[iactual].index)
		else
--			TomTom:SetCrazyArrow(cache[iactual-1].uid, TomTom.db.profile.arrow.arrival, cache[iactual-1].desc)
			if iactual > 1 then
				TomTom:SetCrazyArrow(cache[iactual-1].uid, cache[iactual-1].real_arrivaldistance-1, cache[iactual-1].desc)
			end
			for i=#cache,iactual,-1 do
				TomTom:RemoveWaypoint(cache[i].uid)
				table.remove(cache, i)
			end
			for i=1,#cache,1 do
				cache[i].j = cache[i].j - 1
			end
		end
	end

end

-- table with custom callback functions to use in TomTom
local WoWProMapping_callbacks_tomtom = {
			minimap = {
				onclick = WoWProMapping_minimap_onclick,
				tooltip_show = WoWProMapping_tooltip_minimap,
				tooltip_update = WoWProMapping_tooltip_update_both,
			},
			world = {
				onclick = WoWProMapping_worldmap_onclick,
				tooltip_show = WoWProMapping_tooltip_worldmap,
				tooltip_update = WoWProMapping_tooltip_update_both,
			},
			distance = {

			},
}

-- parameters for Lightheaded
local zidmap = {
   [1] = "Dun Morogh",
   [3] = "Badlands",
   [4] = "Blasted Lands",
   [8] = "Swamp Of Sorrows",
   [10] = "Duskwood",
   [11] = "Wetlands",
   [12] = "Elwynn Forest",
   [14] = "Durotar",
   [15] = "Dustwallow",
   [16] = "Aszhara",
   [17] = "The Barrens",
   [28] = "Western Plaguelands",
   [33] = "Stranglethorn Vale",
   [36] = "Alterac Mountains",
   [38] = "Loch Modan",
   [40] = "Westfall",
   [41] = "Deadwind Pass",
   [44] = "Redridge Mountains",
   [45] = "Arathi Basin",
   [46] = "Burning Steppes",
   [47] = "The Hinterlands",
   [51] = "Searing Gorge",
   [65] = "Dragonblight",
   [66] = "Zul'Drak",
   [67] = "The Storm Peaks",
   [85] = "Tirisfal Glades",
   [130] = "Silverpine Forest",
   [139] = "Eastern Plaguelands",
   [141] = "Teldrassil",
   [148] = "Darkshore",
	[201] = "Un'Goro Crater",
   [210] = "Icecrown",
   [215] = "Mulgore",
   [261] = "Silithus",
   [267] = "Hilsbrad Foothills",
   [331] = "Ashenvale Forest",
   [357] = "Feralas",
   [361] = "Felwood",
--   [394] = "Grizzly Hills",
   [400] = "Thousand Needles",
   [405] = "Desolace",
   [406] = "Stonetalon Mountains",
   [440] = "Tanaris",
   [490] = "Grizzly Hills",
--   [490] = "Un'Goro Crater",
   [493] = "Moonglade",
   [495] = "Howling Fjord",
   [618] = "Winterspring",
   [640] = "Deepholm",
--   [1377] = "Silithus",
	[795] = "Molten Front",
   [1497] = "Undercity",
   [1519] = "Stormwind City",
   [1537] = "Ironforge",
   [1637] = "Ogrimmar",
   [1638] = "Thunder Bluff",
   [1657] = "Darnassus",
   [3430] = "Eversong Woods",
   [3433] = "Ghostlands",
   [3483] = "Hellfire",
   [3487] = "Silvermoon City",
   [3518] = "Nagrand",
   [3519] = "Terokkar Forest",
   [3520] = "Shadowmoon Valley",
   [3521] = "Zangarmarsh",
   [3522] = "Blades Edge Mountains",
   [3523] = "Netherstorm",
   [3524] = "Azuremyst Isle",
   [3525] = "Bloodmyst Isle",
   [3537] = "Borean Tundra",
   [3557] = "The Exodar",
   [3703] = "Shattrath City",
   [3711] = "Sholazar Basin",
   [4080] = "Sunwell",
   [4197] = "Lake Wintergrasp",
   [4395] = "Dalaran",
}

function WoWPro:findBlizzCoords(questId)
	local POIFrame

    	-- Try to find the correct quest frame
    	for i = 1, MAX_NUM_QUESTS do
        	local questFrame = _G["WorldMapQuestFrame"..i];
        	if ( questFrame ) then
             		if ( questFrame.questId == questId ) then
                		POIFrame = questFrame.poiIcon
             			break
             		end
        	end
    	end

    	if not POIFrame then return nil, nil end

    	local _, _, _, x, y = POIFrame:GetPoint()

		-- sanity check if there's a problem with Blizzard's quest map POI APIs
		if (not x) or (not y) then
			return nil, nil
    	end

    	local frame = WorldMapDetailFrame
    	local width = frame:GetWidth()
    	local height = frame:GetHeight()
    	local scale = frame:GetScale() / POIFrame:GetScale()

    	local cx = (x / scale) / width
    	local cy = (-y / scale) / height

    	if cx < 0 or cx > 1 or cy < 0 or cy > 1 then
        	return nil, nil
    	end

    	return cx * 100, cy * 100
end

local FinalCoord = {}
function WoWPro:MapPointDelta()
    local x, y = GetPlayerMapPosition("player");
    if FinalCoord then
        local X,Y
        X=FinalCoord[1] or x
        Y=FinalCoord[2] or y
        x = x * 100.0
        y = y * 100.0
        return { sqrt((X-x)*(X-x)+(Y-y)*(Y-y)), X , Y , x , y }
    else
        return nil
    end
end

function WoWPro:ValidZone(zone)
	if zone then
--	    if tonumber(zone) then
	    if type(zone) == "number" then
	        -- Using a numeric zone ID
            return "NumericZone"
	    elseif WoWPro.Zone2MapID[zone] then
	        -- Zone found in DB
	        return WoWPro.Zone2MapID[zone].mapID
	    end
    end
    return false
end

function WoWPro:MapPoint(row, forceBlizCoord)
--err("MapPoint: row = %s, forceBlizCoord = %s", row, forceBlizCoord)
	local GID = WoWPro.DB.char.currentguide
	if not GID or not WoWPro.Guides[GID] then return end
	if WoWPro.InitLockdown then return end

	-- Removing old map point --
	WoWPro:RemoveMapPoint()
	--FinalCoord = nil
	wipe(FinalCoord)

	-- Loading Variables for this step --
	local i
	if row then i = WoWPro.rows[row].index
	else
		i = WoWPro:NextStepNotSticky(WoWPro.ActiveStep)
	end
	local coords
	if WoWPro.map then
		coords = WoWPro.map[i]
	else
		coords = nil
	end
	local desc = WoWPro.step[i]
	local zone
	--if row then
	--	zone = WoWPro.rows[row].zone or strtrim(string.match(WoWPro.Guides[GID].zone, "([^%(%-]+)"))
	--else
		zone = WoWPro.zone[i] or strtrim(string.match(WoWPro.Guides[GID].zone, "([^%(%-]+)"))
	--end
	local autoarrival = WoWPro.waypcomplete[i] or 3


	-- Loading Blizzard Coordinates for this objective, if coordinates aren't provided --
	if (WoWPro.action[i]=="T" or WoWPro.action[i]=="C") and WoWPro.QID and WoWPro.QID[i] and (not coords or forceBlizCoord)then
		QuestMapUpdateAllQuests()
		QuestPOIUpdateIcons()
		WorldMapFrame_UpdateQuests()
		local x, y = WoWPro:findBlizzCoords(WoWPro.QID[i])
		if x and y then coords = tostring(x)..","..tostring(y) end
	end

	-- Select the proper quest in the watch frame to set the minimap area and arrow for the quest
	-- (should probably make this an option, only select if the quest is actually watched)
	if WoWPro.QID[i] and IsQuestWatched(GetQuestLogIndexByID(WoWPro.QID[i])) then
		WORLDMAP_SETTINGS.selectedQuestId = WoWPro.QID[i]
		QuestPOI_SelectButtonByQuestId("WatchFrameLines", WoWPro.QID[i], true)
		SetSuperTrackedQuestID(WoWPro.QID[i])
	end


	-- Using LightHeaded if the user has it and if there aren't coords from anything else --
	if LightHeaded and WoWPro.QID and WoWPro.QID[i] and not coords then
		if type(WoWPro.QID[i]) ~= "number" then return end
		local npcid, npcname, stype
		if WoWPro.action[i]=="A" then _, _, _, _, stype, npcname, npcid = LightHeaded:GetQuestInfo(WoWPro.QID[i])
		else _, _, _, _, _, _, _, stype, npcname, npcid = LightHeaded:GetQuestInfo(WoWPro.QID[i]) end
		if stype == "npc" then
			local data = LightHeaded:LoadNPCData(tonumber(npcid))
			if not data then return end
			for zid,x,y in data:gmatch("([^,]+),([^,]+),([^:]+):") do
				zone = zidmap[tonumber(zid)]
				if not coords then coords = tostring(x)..","..tostring(y)
				else coords = coords..";"..tostring(x)..","..tostring(y)
				end
			end
		end
	end

	-- If there aren't coords to map, ending map function --
	if not coords then return end

	-- Finding the zone --
	local zm, zf = nil, nil
	if zone and zone ~= "" then
	    if type(zone) == "number" then
	        -- Using a numeric zone ID
	        zm = tonumber(zone)
	        zf = 0
	    elseif WoWPro.Zone2MapID[zone] then
	        -- Zone found in DB
	        zm = WoWPro.Zone2MapID[zone].mapID
	        zf = WoWPro.Zone2MapID[zone].floor or 0
	    end
    end

    if not zm then
	    zm = GetCurrentMapAreaID()
	    zf = GetCurrentMapDungeonLevel()
	    --if not zone  or zone == "" then
	    --	zone = LMD and LMD:MapLocalize(zm)
	    --end
	    WoWPro:Print("Zone ["..zone.."] not found. Using map id "..tostring(zm))
	end

	if TomTom and TomTom.db then
		--TomTom.db.profile.arrow.setclosest = true
		--local my_setclosest = true
		local my_cleardistance = TomTom.db.profile.persistence.cleardistance
		OldCleardistance = TomTom.db.profile.persistence.cleardistance

		-- arrival distance, so TomTom can call our customized distance function when player
		-- gets to the waypoints
		local arrivaldistance
		if (not my_cleardistance) or (my_cleardistance == 0) then
			arrivaldistance = 10
		else
			arrivaldistance = my_cleardistance + 1
		end
		wipe(WoWProMapping_callbacks_tomtom.distance)
		WoWProMapping_callbacks_tomtom.distance[arrivaldistance] = WoWProMapping_distance -- this is overwritten by TomTom

		-- prevents TomTom from clearing waypoints that are not final destination
		--if autoarrival == 2 then TomTom.db.profile.persistence.cleardistance = 0 end
		if autoarrival == 2 or autoarrival == 3 then my_cleardistance = 0 end


		-- Parsing and mapping coordinates --
--		WoWPro:Print("WoWPro:MapPoint(%s@%s/%s)",coords,tostring(zone),tostring(zm))
		local numcoords = select("#", string.split(";", coords))
		for j=1,numcoords do
			local waypoint = {}
			local jcoord = select(numcoords-j+1, string.split(";", coords))
			local x = tonumber(jcoord:match("([^|]*),"))
			local y = tonumber(jcoord:match(",([^|]*)"))
			if not x or x > 100 then return end
			if not y or y > 100 then return end
			if TomTom then
				local uid

				if numcoords > 1 or autoarrival == 1 or autoarrival == 2 then
					uid = TomTom:AddMFWaypoint(zm, zf, x/100, y/100, {
						title = desc,
						desc = desc,
						callbacks = WoWProMapping_callbacks_tomtom,
						cleardistance = 0,
						arrivaldistance = 1, -- The callback is set and we don't want it overwritten
						persistent = false,
						minimap = true,
						world = true,
						crazy = false -- We will set it with the callback if there is more then one
					})
				else
					uid = TomTom:AddMFWaypoint(zm, zf, x/100, y/100, {
						title = desc,
						desc = desc,
						persistent = false,
						minimap = true,
						world = true,
						crazy = true,
					})
				end
err("Add WP: j = %s / %s, x = %s, y = %s, uid_x = %s, uid_y = %s, title = %s", j, numcoords, x, y, uid[3], uid[4], desc)
				if not uid then
				    WoWPro:Print("Failed to set waypoint!  Please report a bug with the guide and step number.")
				end
				waypoint.uid = uid
				waypoint.index = i
				waypoint.zone = zone
				waypoint.x = x
				waypoint.y = y
				waypoint.desc = desc
				waypoint.j = numcoords-j+1
				waypoint.autoarrival = autoarrival
				waypoint.real_arrivaldistance = arrivaldistance

				table.insert(cache, waypoint)
				--FinalCoord = { x , y }
				FinalCoord[1] = x
				FinalCoord[2] = y
			end
		end

		if autoarrival and #cache > 0 then
			if autoarrival == 1 then
				-- TomTom.db.profile.arrow.setclosest = true
				local closest_uid = TomTom:GetClosestWaypoint()

				if closest_uid then
					local iactual
					for i,waypoint in ipairs(cache) do
						if (waypoint.uid == closest_uid) then
							iactual = i break end
					end

					if iactual then
						TomTom:SetCrazyArrow(closest_uid, 1, cache[iactual].desc)
						for i=iactual+1,#cache,1 do
							TomTom:RemoveWaypoint(cache[i].uid)
						end
					end
				else
				    WoWPro:Print("No closest waypoint?")
				end

			elseif autoarrival == 2 or autoarrival == 3 then
				--TomTom.db.profile.arrow.setclosest = false
				-- Set the arrow to the last one in the cache
				TomTom:SetCrazyArrow(cache[#cache].uid, 1, cache[#cache].desc)
			end

		end
		--TomTom.db.profile.persistence.cleardistance = OldCleardistance
	--elseif TomTom then
		-- Legacy Parsing and mapping coordinates for Carbonite --
	--	local numcoords = select("#", string.split(";", coords))
	--	for j=1,numcoords do
	--		local jcoord = select(numcoords-j+1, string.split(";", coords))
	--		local x = tonumber(jcoord:match("([^|]*),"))
	--		local y = tonumber(jcoord:match(",([^|]*)"))
	--		if not x or x > 100 then return end
	--		if not y or y > 100 then return end
	--		table.insert(cache, TomTom:AddZWaypoint(zc, zi, x, y, desc, false))
			--FinalCoord = { x , y }
	--		FinalCoord[1] = x
	--		FinalCoord[2] = y
	--	end

	end

end

function WoWPro:RemoveMapPoint()
	if TomTom and TomTom.db then
		for i=1,#cache,1 do
		    if cache[i].uid ~= nil then
			    TomTom:RemoveWaypoint(cache[i].uid)
			end
		end
		wipe(cache)
		wipe(WoWProMapping_callbacks_tomtom.distance)
	elseif TomTom then
		while cache[1] do TomTom:RemoveWaypoint(table.remove(cache)) end
	end
end
