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
local HBD = LibStub("HereBeDragons-1.0")
WoWPro.HBD = HBD

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
				WoWPro.CompleteStep(cache[iactual].index, "autoarrival=1 (|CC|)")
			end
		end

	-- elseif autoarrival == 2 or autoarrival == 3 then
	else

		--if iactual ~= #cache then return
		if iactual == 1 and autoarrival == 2 then
			TomTom:RemoveWaypoint(cache[iactual].uid)
			local action = WoWPro.action[cache[iactual].index]
			-- F, R, b and H steps with |CS| complete when the last points is reached
		   if action == "F" or action == "R" or action == "b" or action == "H" then
				WoWPro.CompleteStep(cache[iactual].index, "autoarrival=2 (|CS|)")
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
    local GID = WoWProDB.char.currentguide
    if WoWProCharDB.Guide[GID].completion[i] and WoWProCharDB.Guide[GID].completion[j] then return 0 end
    if WoWProCharDB.Guide[GID].skipped[i] and WoWProCharDB.Guide[GID].skipped[j] then return 0 end
    if WoWProCharDB.Guide[GID].completion[i] and WoWProCharDB.Guide[GID].skipped[j] then return 9e-5 end
    if WoWProCharDB.Guide[GID].skipped[i] and WoWProCharDB.Guide[GID].completion[j] then return 9e-5 end
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

    
    local distance = HBD:GetZoneDistance(im,ifl,ix,iy, jm,jfl,jx,jy) or 1e198
    WoWPro:dbp("Dx %s(%2.2f,%2.2f,%d) and %s(%2.2f,%2.2f,%d) -> %g",WoWPro.step[i],ix*100,iy*100,im, WoWPro.step[j],jx*100,jy*100,jm,distance)
    return distance
end

function WoWPro:DistanceToStep(i)
    if not WoWPro.map[i] then return 1e200 end
    local GID = WoWProDB.char.currentguide
    if WoWProCharDB.Guide[GID].completion[i] then return 1e-6 end
    if WoWProCharDB.Guide[GID].skipped[i] then return 1e-5 end
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
    
    local distance = HBD:GetZoneDistance(m,f,x,y, im,ifl,ix,iy) or 1e199
    WoWPro:dbp("IDx (%2.2f,%2.2f,%d) and %s(%2.2f,%2.2f,%d) -> %g",x*100,y*100,m, WoWPro.step[i],ix*100,iy*100,im,distance)
    return distance
end    
    

    
    
function WoWPro:ValidZone(zone)
	if zone then
		if tonumber(zone) then
		  -- Using a numeric zone ID
		   return tostring(tonumber(zone))
		elseif WoWPro.Zone2MapID[zone] then
		  -- Zone found in DB
	        return zone
		elseif zone:match("/") then
		   local nzone , floor = string.split("/",zone)
		   if nzone == zone then
		   	err("Can't parse zone %s", zone)
		   	return false
		   else
		   	return WoWPro:ValidZone(nzone)
		   end
		elseif zone:match(";") then
		    local nzone , floor = string.split(";",zone)
		    if nzone == zone then
				err("Can't parse zone %s", zone)
				return false
	   	 else
		    	return WoWPro:ValidZone(nzone)
		    end
	    end
    end    
    return false
end


function WoWPro:ValidateMapCoords(guide,action,step,coords)
	local numcoords = select("#", string.split(";", coords))
	for j=1,numcoords do
		local jcoord = select(numcoords-j+1, string.split(";", coords))
		if not jcoord or jcoord == "" then
		    WoWPro:Error("Missing coordinate, %d/%d in guide %s, line [%s %s].",numcoords-j+1,numcoords,guide,action,step)
		    return
		end
		if jcoord ~= "0,0" then
			local x = tonumber(jcoord:match("([^|]*),"))
			if x == nil or x < 0 or x > 100  then
			    WoWPro:Error("Bad X coordinate %s, %d/%d in guide %s, line [%s %s].",jcoord,numcoords-j+1,numcoords,guide,action,step)
			    return
			end
			local y = tonumber(jcoord:match(",([^|]*)"))
			if y == nil or y < 0 or y > 100 then
			    WoWPro:Error("Bad Y coordinate %s, %d/%d in guide %s, line [%s %s].",jcoord,numcoords-j+1,numcoords,guide,action,step)
			    return
			end
		end
	end
end

eric_map = nil
function WoWPro:MapPoint(row, forceBlizCoord)

	if eric_map then err("MapPoint: row = %s, forceBlizCoord = %s", row, forceBlizCoord) end

	local GID = WoWProDB.char.currentguide
	if not GID or not WoWPro.Guides[GID] then return end
	-- if WoWPro.InitLockdown then return end


	-- Removing old map point --
	WoWPro:RemoveMapPoint()
	--FinalCoord = nil
	wipe(FinalCoord)

	-- Loading Variables for this step --
	local i
	if row then 
		i = WoWPro.rows[row].index 
	else 
		-- i = WoWPro:NextStepNotSticky(WoWPro.ActiveStep)
		i = WoWPro.CurrentIndex or WoWPro.ActiveStep or 1
	end
	if not i then return end

	local coords
	if WoWPro.map then coords = WoWPro.map[i] else coords = nil end
	-- Special case for |M|0,0| which means not to set the arrow.
	if coords == "0,0" then return end

	local desc = WoWPro.step[i]
	local zone
	local floor = 0
	if row then
		zone = WoWPro.rows[row].zone
	end 
	zone = zone or WoWPro.zone[i] or strtrim(string.match(WoWPro.Guides[GID].zone, "([^%(]+)") or "") or GetRealZoneText()
	local autoarrival = WoWPro.waypcomplete[i]

	-- Accept |Z|zone name;floor| since / can be a valid character for zone name
	if zone:match(";") then
		-- Well, they have a floor specified
		zone , floor = string.split(";",zone)
		floor = tonumber(floor)
		if not zone then
			zone = strtrim(string.match(WoWPro.Guides[GID].zone, "([^%(]+)") or "") or GetRealZoneText()
		end
	end

	if zone:match("/") then
		-- Well, they have a floor specified
		zone , floor = string.split("/",zone)
		floor = tonumber(floor)
		if not zone then
			zone = strtrim(string.match(WoWPro.Guides[GID].zone, "([^%(]+)") or "") or GetRealZoneText()
		end
	end

	if eric_map then err("zone = %s, floor = %s, desc = %s",zone,floor,desc) end

	-- Loading Blizzard Coordinates for this objective, if coordinates aren't provided --
	if (WoWPro.action[i]=="T" or WoWPro.action[i]=="C") and WoWPro.QID and WoWPro.QID[i] and (not coords or forceBlizCoord) then
		QuestMapUpdateAllQuests()
		QuestPOIUpdateIcons()
		--WorldMapFrame_UpdateQuests()
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
				--QuestPOI_SelectButtonByQuestId("WatchFrameLines", qid, true)
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
	        WoWPro:dbp("MapPoint: zone [%s] mapped to %d/%d", zone, zm, zf)
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
		WoWPro:print("WoWPro:MapPoint1(%d,%s@%s=%s/%s)",i,coords,tostring(zone),tostring(zm),tostring(zf))
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

				if eric_map then 
					err("zm = %s, zf = %s, x/100 = %s, y/100 = %s, uid = %s",zm, zf,x/100, y/100, uid) 
					eric_uid = uid
				end

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

function  WoWPro.CheckHBDData(force)
    local map, pizo = HBD:GetPlayerZonePosition()
    if not (map and pizo) then
        WoWPro:dbp("CheckHBDData(): No player position yet!")
        -- We are not mapped yet.
        return
    end
    local width, height = HBD:GetZoneSize(map, pizo)
    if (not force) and width > 0 and height > 0 then
        -- We have data
        WoWPro:dbp("Map data present for %d/%d", map, pizo)
        return
    end
    -- Hey!  No data!
    local mapData = {}
    local l, TLx, TLy, BRx, BRy =  GetCurrentMapDungeonLevel();
    if not TLx then
        WoWPro:dbp("GCMDL failed for %d/%d", map, pizo)
        return
    end
	mapData.width = BRx - TLx
	mapData.height = BRy - TLy
	mapData.xOffset = -TLx
	mapData.yOffset = -TLy
	
	WoWPro:print("You discovered new map info for %s:%s. Please report this on the WoWPro.com website.", GetZoneText(), string.trim(GetSubZoneText()))
	-- WorldMapSize[27][10] = { xOffset =  -500.000000, height = 380.000000, yOffset =  5242.500000, width = 570.000000 , __index = zeroDataFunc };
	WoWPro:print("[%d][%d] = { xOffset = %f, height = %f, yOffset = %f, width = %f}", map, pizo, mapData.xOffset,  mapData.height,  mapData.yOffset, mapData.width)
end

function WoWPro:LogLocation()
    local x, y, mapID, level, mapFile, isMicroDungeon = HBD:GetPlayerZonePosition()

    if not (map and level) then
        WoWPro:print("Player map and floor unknown")
    else
        WoWPro:print("Player [%.2f,%.2f@%d/%d] '%s' aka '%s'", map, pizo, x*100 , y*100, GetZoneText(), string.trim(GetSubZoneText()))
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
