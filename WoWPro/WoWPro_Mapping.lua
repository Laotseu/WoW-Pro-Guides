-------------------------------------------------------------------------------
-- Localized Lua globals
-------------------------------------------------------------------------------
local _G = getfenv(0)

local LibStub = _G.LibStub
local TomTom = _G.TomTom

local function err(msg,...) _G.geterrorhandler()(msg:format(_G.tostringall(...)) .. " - " .. _G.time()) end

----------------------------------
--      WoWPro_Mapping.lua      --
----------------------------------

local L = WoWPro_Locale
local cache = {}	
local B = LibStub("LibBabble-Zone-3.0")
local BL = B:GetUnstrictLookupTable()
local AL = DongleStub and pcall(DongleStub,"Astrolabe-1.0") and DongleStub("Astrolabe-1.0")

-- placeholder flags in case you want to implement options to disable
-- later on TomTom tooltips and right-clicking drop-down menus
local SHOW_MINIMAP_MENU = true
local SHOW_WORLDMAP_MENU = true
local SHOW_MINIMAP_TOOLTIP = true
local SHOW_WORLDMAP_TOOLTIP = true


-- For debug
-- local oldrm = TomTom.RemoveWaypoint
-- function TomTom.RemoveWaypoint(...)
-- 	err("RemoveWaypoint")
-- 	return oldrm(...)
-- end

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
		tooltip:AddLine(string.format(L["%s yards away"], math.floor(dist)), 1, 1, 1)
	else
		tooltip:AddLine(L["Unknown distance"])
	end
	tooltip:AddLine(string.format(L["%s (%.2f, %.2f)"], zone, x, y), 0.7, 0.7, 0.7)
	-- if #cache > 1 then
	-- 	tooltip:AddLine(string.format(L["Waypoint %d of %d"], jcoord, #cache), 1, 1, 1)
	-- end
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

local autoarrival	-- flag to indicate if the step should autocomplete
			-- when final position is reached; defined inside WoWPro:MapPoint from guide tag

local OldCleardistance	-- saves TomTom's option to restore it

-- Function to handle the distance callback in TomTom, when player gets to the final destination
local function WoWProMapping_distance(event, uid, range, distance, lastdistance)
--err("Distance callback: event = %s, title = %s, range = %s, distance = %s, lastdistance = %s", event, uid.title, range, distance, lastdistance)
	if UnitOnTaxi("player") then return end

	-- Replicate normal TomTom arrival functionality
	if TomTom.profile.arrow.enablePing then
	  PlaySoundFile("Interface\\AddOns\\TomTom\\Media\\ping.mp3")
	end

   
--	if not autoarrival then
--	     WoWPro:dbp("WoWProMapping_distance: no autoarrival")
--	    return
--	end

	local iactual
    WoWPro:dbp("WoWProMapping_distance: autoarrival for uid %s at range %g",tostring(uid),range)
    
	for i,waypoint in ipairs(cache) do
		if (waypoint.uid == uid) then
		    WoWPro:dbp("Mapping: Located waypoint UID %s @ idx %d, autoarrival = %d",tostring(uid),i,autoarrival)
			iactual = i
			break
		end
	end
	
	if not iactual then
		err("Can't find uid in cache: event = %s, uid = %s, range = %s, distance = %s, lastdistance = %s", event, uid, range, distance, lastdistance)
			    WoWPro:Warning("Mapping: Unable to locate UID %s in cache.",tostring(uid))
	    return
	end
	local autoarrival = cache[iactual].autoarrival

	if not autoarrival or autoarrival == 1 then

		for i=iactual,#cache,1 do
			TomTom:RemoveWaypoint(cache[i].uid)
		end

		-- TomTom.db.profile.arrow.setclosest = true
		local closest_uid = TomTom:GetClosestWaypoint()

		if closest_uid then

			for i,waypoint in ipairs(cache) do
				if (waypoint.uid == closest_uid) then
					iactual = i break end
			end
			TomTom:SetCrazyArrow(cache[iactual].uid, 1, cache[iactual].desc)

			if iactual then
				for i=iactual+1,#cache,1 do
					TomTom:RemoveWaypoint(cache[i].uid)
				end
			end
		end

		if autoarrival and iactual == 1 then
			TomTom:RemoveWaypoint(cache[iactual].uid)
			-- F, R, b and H steps with |CC| complete when the last points is reached
			local action = WoWPro.action[cache[iactual].index]
		   if action == "F" or action == "R" or action == "b" or action == "H" then
				WoWPro.CompleteStep(cache[iactual].index)
			end
		end

	elseif autoarrival == 2 or autoarrival == 3 then

		--if iactual ~= #cache then return
		if iactual == 1 and autoarrival == 2 then
			TomTom:RemoveWaypoint(cache[iactual].uid)
			local action = WoWPro.action[cache[iactual].index]
			-- F, R, b and H steps with |CS| complete when the last points is reached
		   if action == "F" or action == "R" or action == "b" or action == "H" then
				WoWPro.CompleteStep(cache[iactual].index)
			end
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
	[806] = "The Jade Forest",
	[807] = "Valley of the Four Winds",
	[809] = "Kun-Lai Summit",
	[810] = "Townlong Steppes",
	[811] = "Vale of Eternal Blossoms",
	[857] = "Krasarang Wilds",
	[858] = "Dread Wastes",
	[873] = "The Veiled Stair",
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

local QIDs = {}
function WoWPro:findBlizzCoords(questId)

	local QID = tonumber(questId)
	wipe(QIDs)
	if QID then
		tinsert(QIDs, QID)
	else
		for qid in questId:gmatch("[^;]+") do
			tinsert(QIDs, tonumber(qid))
		end
	end

	if #QIDs == 0 then return nil, nil end

	local POIFrame

    	-- Try to find the correct quest frame
    	for i = 1, MAX_NUM_QUESTS do
        	local questFrame = _G["WorldMapQuestFrame"..i];
        	if ( questFrame ) then
        		for _, qid in ipairs(QIDs) do
        			if ( questFrame.questId == qid ) then
             		POIFrame = questFrame.poiIcon
          			break
          		end
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


function WoWPro:DistanceBetweenSteps(i,j)
    if not WoWPro.map[i] then return 1e197 end
    if not WoWPro.map[j] then return 1e196 end
    local icoord = select(1, string.split(";", WoWPro.map[i]))
    local jcoord = select(1, string.split(";", WoWPro.map[j]))
    local ix = tonumber(icoord:match("([^|]*),"))/100
    local iy = tonumber(icoord:match(",([^|]*)"))/100
    local jx = tonumber(jcoord:match("([^|]*),"))/100
    local jy = tonumber(jcoord:match(",([^|]*)"))/100
    local im
    local jm
    local ifl
    local jfl 
    local izone = WoWPro.zone[i] or WoWPro.Guides[GID].zone or ""
    if izone:match("/") then
        local nzone , floor = string.split("/",izone)
        im = WoWPro.Zone2MapID[nzone].mapID
        ifl = tonumber(floor)
    else
        im = WoWPro.Zone2MapID[izone].mapID
        ifl = WoWPro.Zone2MapID[izone].floor or 0
    end
    local jzone = WoWPro.zone[j] or WoWPro.Guides[GID].zone or ""
    if jzone:match("/") then
        local nzone , floor = string.split("/",jzone)
        jm = WoWPro.Zone2MapID[nzone].mapID
        jfl = tonumber(floor)
    else
        jm = WoWPro.Zone2MapID[jzone].mapID
        jfl = WoWPro.Zone2MapID[jzone].floor or 0
    end

--    WoWPro:Print("Distance between (%2.2f,%2.2f,%d) and (%2.2f,%2.2f,%d)",ix*100,iy*100,im, jx*100,jy*100,jm)
    local distance = AL:ComputeDistance(im,ifl,ix,iy, jm,jfl,jx,jy)
    return (distance or 1e198)
end

function WoWPro:DistanceToStep(i)
    if not WoWPro.map[i] then return 1e200 end
    local GID = WoWProDB.char.currentguide
    if WoWProCharDB.Guide[GID].completion[i] or WoWProCharDB.Guide[GID].skipped[index] then return 1e-6 end
    local icoord = select(1, string.split(";", WoWPro.map[i]))
--    WoWPro:Print("Step %d is at %s/%s",i,tostring(icoord),tostring(WoWPro.zone[i]))
    local ix = tonumber(icoord:match("([^|]*),"))/100
    local iy = tonumber(icoord:match(",([^|]*)"))/100
    local im
    local ifl
    local izone = WoWPro.zone[i] or WoWPro.Guides[GID].zone or ""
    if izone:match("/") then
        local nzone , floor = string.split("/",izone)
        im = WoWPro.Zone2MapID[nzone].mapID
        ifl = tonumber(floor)
    else
        im = WoWPro.Zone2MapID[izone].mapID
        ifl = WoWPro.Zone2MapID[izone].floor or 0
    end
--    WoWPro:Print("Zone %s mapped to %d",WoWPro.zone[i],im)
    local x, y = GetPlayerMapPosition("player");
    local m = GetCurrentMapAreaID()
    local f = GetCurrentMapDungeonLevel()
--    WoWPro:Print("Computing distance between (%2.2f,%2.2f,%d) and (%2.2f,%2.2f,%d)",x*100,y*100,m, ix*100,iy*100,im)
    local distance = AL:ComputeDistance(m,f,x,y, im,ifl,ix,iy)

    return (distance or 1e199)
end    
    

    
    
function WoWPro:ValidZone(zone)
	if zone then
	    if tonumber(zone) then
	        -- Using a numeric zone ID
            return tostring(tonumber(zone))
	    elseif WoWPro.Zone2MapID[zone] then
	        -- Zone found in DB
	        return WoWPro.Zone2MapID[zone].mapID
	    elseif zone:match("/") then
	        local nzone , floor = string.split("/",zone)
	        return WoWPro:ValidZone(nzone)
	    end
    end    
    return false
end
    
    
function WoWPro:TryRemap(z,s,f,x,y)
	local nx , ny = AL:TranslateWorldMapPosition(z,f,x/100,y/100,s,f)
	WoWPro:dbp("Remapping1 to %d,%g,%g",s,nx,ny)
	if nx >= 0 and nx <= 1 and ny >=0 and ny <= 1 then
		-- Successfull translation, remap
		WoWPro:dbp("Remapping! %d/%g,%g to %d/%g,%g",z,x,y,s,nx*100,ny*100)
		return s,nx*100,ny*100
	end
	return nil,nil,nil
end

function WoWPro:MaybeRemap(z,f,x,y)
    if (not WoWPro.SubZone[z])  or (not AL) or (not AL.TranslateWorldMapPosition) then return nil,nil,nil end
    WoWPro:dbp("Remap? %d/%g,%g %s",z,x,y,tostring(WoWPro.SubZone[z]))
    if type(WoWPro.SubZone[z]) == "number" then
        return WoWPro:TryRemap(z,WoWPro.SubZone[z],f,x,y)
    end
    if type(WoWPro.SubZone[z]) == "table" then
        for idx, val in ipairs(WoWPro.SubZone[z]) do
            local z,x,y = WoWPro:TryRemap(z,val,f,x,y)
            if z then return z,x,y end
        end
    end
	return nil,nil,nil
end

function WoWPro:ValidateMapCoords(guide,action,step,coords)
	local numcoords = select("#", string.split(";", coords))
	for j=1,numcoords do
		local jcoord = select(numcoords-j+1, string.split(";", coords))
		if not jcoord or jcoord == "" then
		    WoWPro:Error("Missing coordinate, %d/%d in guide %s, line [%s %s].",numcoords-j+1,numcoords,guide,action,step)
		    return
		end
		local x = tonumber(jcoord:match("([^|]*),"))
		if not x or x > 100  then
		    WoWPro:Error("Bad X coordinate %s, %d/%d in guide %s, line [%s %s].",jcoord,numcoords-j+1,numcoords,guide,action,step)
		    return
		end
		local y = tonumber(jcoord:match(",([^|]*)"))
		if not y or y > 100 then
		    WoWPro:Error("Bad Y coordinate %s, %d/%d in guide %s, line [%s %s].",jcoord,numcoords-j+1,numcoords,guide,action,step)
		    return
		end
	end
end

eric_map = nil
function WoWPro:MapPoint(row, forceBlizCoord)

	if eric_map then err("MapPoint: row = %s, forceBlizCoord = %s", row, forceBlizCoord) end

	local GID = WoWProDB.char.currentguide
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
		-- i = WoWPro:NextStepNotSticky(WoWPro.ActiveStep)
		i = WoWPro.CurrentIndex or WoWPro.ActiveStep or 1
	end
	if not i then return end

	local coords; if WoWPro.map then coords = WoWPro.map[i] else coords = nil end
	local desc = WoWPro.step[i]
	local zone
	local floor = 0
	if row then
		zone = WoWPro.rows[row].zone
	end 
	zone = zone or WoWPro.zone[i] or strtrim(string.match(WoWPro.Guides[GID].zone, "([^%(]+)"))
	local autoarrival = WoWPro.waypcomplete[i]

	if zone:match("/") then
		-- Well, they have a floor specified
		zone , floor = string.split("/",zone)
		floor = tonumber(floor)
		if not zone then
			zone = strtrim(string.match(WoWPro.Guides[GID].zone, "([^%(]+)"))
		end
	end

	if eric_map then err("zone = %s,floor = %s,desc = %s",zone,floor,desc) end

	-- Loading Blizzard Coordinates for this objective, if coordinates aren't provided --
	if (WoWPro.action[i]=="T" or WoWPro.action[i]=="C") and WoWPro.QID and WoWPro.QID[i] and (not coords or forceBlizCoord) then
		QuestMapUpdateAllQuests()
		QuestPOIUpdateIcons()
		WorldMapFrame_UpdateQuests()
		local x, y = WoWPro:findBlizzCoords(WoWPro.QID[i])
		if x and y then coords = tostring(x)..","..tostring(y) end
	end
	
	-- Set working objective based on QID
	if WoWPro.QID[i] then
		local QID = tonumber(WoWPro.QID[i])
		wipe(QIDs) -- define before WoWPro:findBlizzCoords
		if QID then
			tinsert(QIDs, QID)
		else
			for qid in WoWPro.QID[i]:gmatch("[^;]+") do
				tinsert(QIDs, tonumber(qid))
			end
		end

		for _, qid in ipairs(QIDs) do
			if IsQuestWatched(GetQuestLogIndexByID(qid)) then
				WORLDMAP_SETTINGS.selectedQuestId = qid
				QuestPOI_SelectButtonByQuestId("WatchFrameLines", qid, true)
				SetSuperTrackedQuestID(qid)
				break
			end
		end
	end

	-- If there aren't coords to map, ending map function --
	if not coords then return end
	
	-- Finding the zone --
	local zm,zf,zc,zi
	zm = nil
	if zone then
		if tonumber(zone) then
	        -- Using a numeric zone ID
	        zm = tonumber(zone)
	        zf = floor
	   elseif WoWPro.Zone2MapID[zone] then
			-- Zone found in DB
			zm = WoWPro.Zone2MapID[zone].mapID
			zf = WoWPro.Zone2MapID[zone].floor or floor
			zc = WoWPro.Zone2MapID[zone].cont
			zi = WoWPro.Zone2MapID[zone].zonei

			-- Hack for Tomtom
			if (not zf or zf == 0) and WoWPro.Zone2MapID[zone].numFloors and WoWPro.Zone2MapID[zone].numFloors > 1 then
				zf = 1 -- use 1 instead of 0 when there is more then one floor and the floor is not specified
			end
	   end
	end

	  if not zm then
	  	zm = GetCurrentMapAreaID()
	  	zf = GetCurrentMapDungeonLevel()
	  	WoWPro:Error("Zone ["..tostring(zone).."] not found. Using map id "..tostring(zm))
	  end

	  if TomTom and TomTom.AddMFWaypoint then
		--TomTom.db.profile.arrow.setclosest = true
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
 		WoWProMapping_callbacks_tomtom.distance[arrivaldistance] = WoWProMapping_distance

 		-- prevents TomTom from clearing waypoints that are not final destination
		--if autoarrival == 2 then TomTom.db.profile.persistence.cleardistance = 0 end
		if autoarrival == 2 or autoarrival == 3 then my_cleardistance = 0 end
		WoWPro:dbp("MapPoint: autoarrival = %s, arrivaldistance=%s, TomTom..cleardistance = %d, OldCleardistance == %d",
			tostring(autoarrival),tostring(arrivaldistance),tostring(TomTom.db.profile.persistence.cleardistance), tostring(OldCleardistance))
		
		-- Parsing and mapping coordinates --
		WoWPro:dbp("WoWPro:MapPoint1(%s@%s/%s)",coords,tostring(zone),tostring(zm))
		local numcoords = select("#", string.split(";", coords))
		-- err("numcoords = %s, coords = %s, autoarrival = %s", numcoords, coords, autoarrival)
		for j=1,numcoords do
			local waypoint = {}
			local jcoord = select(numcoords-j+1, string.split(";", coords))
			local x = tonumber(jcoord:match("([^|]*),"))
			local y = tonumber(jcoord:match(",([^|]*)"))
			if not x or x > 100 or not y or y > 100 then
				WoWPro:Error("Bad coordiate %s, %d out of %d. Please file a bug with the faction, guide and step description",jcoord,numcoords-j+1,numcoords)
				return
			end
			local uid

			if numcoords > 1 or autoarrival == 1 or autoarrival == 2 then
				-- err("zm = %s, zf = %s, x/100 = %s, y/100 = %s, uid = %s",zm, zf,x/100, y/100, uid)
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

				if eric_map then err("zm = %s, zf = %s, x/100 = %s, y/100 = %s, uid = %s",zm, zf,x/100, y/100, uid) end

			end
			--err("Add WP: j = %s / %s, x = %s, y = %s, zm = %s, zf = %s, uid_x = %s, uid_y = %s, title = %s", j, numcoords, x, y, zm, zf, uid[3], uid[4], desc)
			if not uid then
				WoWPro:Error("Failed to set waypoint!  Please report a bug: Guide %s, Step %s [%s]",GID,WoWPro.action[i],WoWPro.step[i])
			end

			local wp_desc = desc
			if numcoords > 1 and autoarrival == 2 then
				wp_desc = ("%s\nWaypoint %d of %d"):format(desc, numcoords-j+1, numcoords)
			end

			waypoint.uid = uid
			waypoint.index = i
			waypoint.zone = zone
			waypoint.x = x
			waypoint.y = y
			waypoint.desc = wp_desc
			waypoint.j = numcoords-j+1
			waypoint.autoarrival = autoarrival
			waypoint.real_arrivaldistance = arrivaldistance

			table.insert(cache, waypoint)
			--FinalCoord = { x , y }
			FinalCoord[1] = x
			FinalCoord[2] = y
		end
		
		if Nx then
			return
		end
		if #cache > 0 then

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
						WoWPro:Error("No closest waypoint? Please report a bug: Guide %s, Step %s [%s]",GID,WoWPro.action[i],WoWPro.step[i])
					end

--			elseif autoarrival == 2 or autoarrival == 3 then
			else
				--TomTom.db.profile.arrow.setclosest = false
				-- Set the arrow to the last one in the cache
				TomTom:SetCrazyArrow(cache[#cache].uid, 1, cache[#cache].desc)
			end
			
		end
		TomTom.db.profile.persistence.cleardistance = OldCleardistance
		elseif TomTom then
		-- WoWPro:Print("WoWPro:MapPoint2(%s@%s/%s)",coords,tostring(zone),tostring(zm))
		-- Legacy Parsing and mapping coordinates for Carbonite --
		local numcoords = select("#", string.split(";", coords))
		for j=1,numcoords do
			local jcoord = select(numcoords-j+1, string.split(";", coords))
			local x = tonumber(jcoord:match("([^|]*),"))
			local y = tonumber(jcoord:match(",([^|]*)"))
			if not x or x > 100 then return end
			if not y or y > 100 then return end
			table.insert(cache, TomTom:AddZWaypoint(zc, zi, x, y, desc, false))
			FinalCoord = { x , y }
		end

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


function WoWPro:ZoneInfo()
     WoWPro.eBox = WoWPro.eBox or CreateFrame("EditBox", nil,UIParent,ChatFrameEditBoxTemplate)
    local eBox = WoWPro.eBox
    eBox:SetWidth(512)
    eBox:SetHeight(256)
    eBox:SetMultiLine(true)
    eBox:SetAutoFocus(true)
    eBox:SetFontObject(GameFontHighlight)
    local text=""
    for zi=0, 1000 do
        local z=GetRealZoneText(zi)
        local line = string.format("[%d]='%s'",zi,z)
        if z ~= "" then
            text = text .. line .. "\n"
        end
    end
    eBox:SetText(text)
    eBox:SetPoint("CENTER")
    eBox:Show()
    eBox:SetScript("OnEscapePressed", function (self) self:Hide() end)
end
