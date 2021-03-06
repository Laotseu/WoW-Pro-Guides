--------------------------
--  WoWPro_Events.lua   --
--------------------------

local _G = getfenv(0)
local WoWPro = _G.WoWPro

local L = WoWPro_Locale
local HBD = WoWPro.HBD

local function err(msg,...) _G.geterrorhandler()(msg:format(_G.tostringall(...)) .. " - " .. _G.time()) end

-- Remember Taxi Locations
function WoWPro:RecordTaxiLocations(...)
	--err("Processing %s nodes.", NumTaxiNodes())
    for i = 1, NumTaxiNodes() do
		local nomen = TaxiNodeName(i)
		local fptype = TaxiNodeGetType(i)
		local location,zone = string.split(",",nomen)
		if fptype == "CURRENT" or fptype == "REACHABLE" then
			WoWProCharDB.Taxi[location] = true
			--err("location = %s, zone = %s, fptype = %s", location, zone, fptype)
			if not WoWProCharDB.Taxi[location] then
				WoWPro:Print("Discovered Flight Point: [%s]",location)

				-- Complete f steps for that location if present
				local GID = WoWProDB.char.currentguide
				if not GID or not WoWPro.Guides[GID] then return end

				if WoWProCharDB.Guide then
					for i=1,#WoWPro.action do
						if WoWPro.action[i] == 'f' and 
							WoWPro.step[i] == location and 
							not WoWProCharDB.Guide[GID].completion[i] then
								WoWPro.CompleteStep(i, "Detected new Taxi for "..location, "Flight point already known.", true)
						end
					end
				end
			end        	
		else
     		WoWProCharDB.Taxi[location] = nil
		end 

		-- Little fix to remove bogus Taxi entries
		WoWProCharDB.Taxi[""]  = nil
	end
end

-- Auto-Complete: Use flight point --
function WoWPro.TakeTaxi_OldStyle(index,destination)
    for i = 1, NumTaxiNodes() do
        local nomen = TaxiNodeName(i)
        local location,zone = string.split(",",nomen)
        -- We do a loose match and ignore Blizzards faction suffixes
        if strfind(location, destination,1,true) then
            WoWPro:Print("Taking flight to: [%s]",location)
            if IsMounted() then
                Dismount()
            end
            TaxiNodeOnButtonEnter(_G["TaxiButton"..i])
            TakeTaxiNode(i)
            WoWPro.CompleteStep(index,"Took taxi to "..location, "Took the taxi.")
            return
        end
    end
    WoWPro:Warning("Unable to find flight point to: [%s]",destination)
end

function WoWPro.TakeTaxi_NewStyle(index,destination)
    local taxiNodes = GetAllTaxiNodes()
    for i, taxiNodeData in ipairs(taxiNodes) do
        -- nodeID=1613, slotIndex=1, type=3, x=0.34, y=0.53, name="Azurewing Repose, Azuna"
        local location,zone = string.split(",", taxiNodeData.name)
        if strfind(location, destination,1,true) then
            WoWPro:Print("Taking flight to: [%s]",location)
            if IsMounted() then
                Dismount()
            end
            TakeTaxiNode(taxiNodeData.slotIndex)
            WoWPro.CompleteStep(index,"Took known new flight point")
            return
        end
    end
end

-- Auto-Complete: Get flight point --
function WoWPro:AutoCompleteGetFP(messageType, message)
	local zonetext = GetMinimapZoneText()
	if not zonetext or zonetext == "" then return end
	for i = 1,15 do
		local index = WoWPro.rows[i].index
		local step =  WoWPro.step[index]
		local altfp = WoWPro.altfp[index]
		if ((message == ERR_NEWTAXIPATH and WoWPro.action[index] == "f" and (zonetext == step or altfp == zonetext)) or
			 (WoWPro.action[index] == "f" and (WoWProCharDB.Taxi[step] or (altfp and WoWProCharDB.Taxi[altfp]))))
			and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then

			WoWProCharDB.Taxi[zonetext] = true -- keep track of the discovered flightpoints
			WoWPro:Print("Discovered Flight Point: [%s]",zonetext)
			WoWPro.CompleteStep(index, "Flightpoint discovered.")
		end
	end
end

-- This function expect a string of spellIDs or buff names separated by ;
-- ex. or valid |BUFF| tags: |BUFF|47014|, |BUFF|Budd's Attention Span|, |BUFF|47014;Budd's Attention Span|
-- Return the first Buff found or nil if none of the listed buff are found
function WoWPro:CheckPlayerForBuffs(buffs)
	for buff in buffs:gmatch("[^;]+") do
		-- We need the name for UnitBuff and UnitDebuff, they do not accept spellID
		local buffname = GetSpellInfo(buff) or buff 
		if UnitBuff("player", buffname) or UnitDebuff("player", buffname) then
			return buff
		end
	end
	return nil
end

-- function WoWPro:CheckPlayerForBuffs(buffs)
-- 	local buffies = {}
--     local buffIdx
--     for buffIdx = 1, select("#",string.split(";",buffs)) do
--         local buff = select(buffIdx,string.split(";",buffs))
--         buffies[buffIdx] = tonumber(buff)
--     end
--     -- UnitBuff, UnitAura and UnitDebuf wants a name.
--     for i, id in ipairs(buffies) do
--     	if tonumber(id) then
--     		buffies[i] = GetSpellInfo(id)
--     	end
--     	if UnitBuff("player", buffies[i]) or UnitDebuff("player", buffies[i]) then
--     		return true
--     	end
--     end
--     -- local BuffIndex = 1
--     -- local BuffName, _, _, _, _, _, _, _, _, _, BuffSpellId = UnitBuff("player",BuffIndex)
--     -- while BuffName do
--     --     for buffIdx = 1, #buffies do
--     --         if BuffSpellId == buffies[buffIdx] then
--     --             return BuffSpellId
--     --         end
--     --     end
--     --     BuffIndex = BuffIndex + 1
--     --     BuffName, _, _, _, _, _, _, _, _, _, BuffSpellId = UnitBuff("player",BuffIndex)
--     -- end
--     return nil
-- end

-- Auto-Complete: Do we have a buff? --
function WoWPro.AutoCompleteBuff(unit,...)
    if unit ~= "player" then return end
	for i = 1,15 do
		local index = WoWPro.rows[i].index
		if WoWPro.buff and WoWPro.buff[index] and  WoWPro:CheckPlayerForBuffs(WoWPro.buff[index]) then
		    -- Log only the usefull ones!
		    WoWPro:LogEvent("UNIT_AURA", unit, ...)
		    WoWPro.CompleteStep(index, ("Buff %s detected"):format(WoWPro.buff[index] ))
		end
		if WoWPro.nobuff and WoWPro.nobuff[index] and not WoWPro:CheckPlayerForBuffs(WoWPro.nobuff[index]) then
			WoWPro.CompleteStep(index, ("Absence of Buff %s detected"):format(WoWPro.nobuff[index] ))
		end
	end
end


-- Update Item Tracking --
function WoWPro.GetLootTrackingInfo(lootitem,lootqty)
--[[Purpose: Creates a string containing:
	- tracked item's name
	- how many the user has
	- how many the user needs
	- a complete symbol if the ammount the user has is equal to the ammount they need 
]]
	if not GetItemInfo(lootitem) then return "" end
	local track = "" 												--If the function did have a track string, adds a newline
	track = track.." - "..GetItemInfo(lootitem)..": " 	--Adds the item's name to the string
	numinbag = GetItemCount(lootitem)		--Finds the number in the bag, and adds a count if supplied
	track = track..numinbag										--Adds the number in bag to the string
	track = track.."/"..lootqty								--Adds the total number needed to the string
	if lootqty == numinbag then
		track = track.." (C)"									--If the user has the requisite number of items, adds a complete marker
	end
	return track													--Returns the track string to the calling function
end

-- Auto-Complete: Loot based --
function WoWPro.AutoCompleteLoot()
	if WoWPro.lootitem == nil then return end
	for i = 1,1+WoWPro.ActiveStickyCount do
	    local lootqtyi
		local index = WoWPro.rows[i].index
		if WoWPro.lootitem[index] then
    		if tonumber(WoWPro.lootqty[index]) ~= nil then lootqtyi = tonumber(WoWPro.lootqty[index]) else lootqtyi = 1 end
    		if WoWProDB.profile.track then
    			local track = WoWPro.GetLootTrackingInfo(WoWPro.lootitem[index],lootqtyi)
    			WoWPro.rows[i].track:SetText(strtrim(track))
    			WoWPro:dbp("AutoCompleteLoot: Update tracking text to %s",track)
    		end
    		local itemCount = GetItemCount(WoWPro.lootitem[index])
    		if itemCount >= lootqtyi and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
    		    WoWPro:dbp("AutoCompleteLoot: Time to complete step.")
    			WoWPro.CompleteStep(index)
    		else
    			WoWPro:dbp("AutoCompleteLoot: Not enough yet!")
    		end
    	end
	end
end

-- Save Garrison Building Locations for the BUILDING tag
function WoWPro.SaveGarrisonBuildings()
    local mapID = GetCurrentMapAreaID()
    if (mapID == WoWPro.Zone2MapID['Lunarfall'].mapID) or (mapID == WoWPro.Zone2MapID['Frostwall'].mapID) then
        WoWProCharDB.BuildingLocations = WoWProCharDB.BuildingLocations or {}
        -- We just moved into the zone
        local numPOIs = GetNumMapLandmarks();
        for i=2, numPOIs do
            local landmarkType, name, description, textureIndex, x, y, mapLinkID, inBattleMap, graveyardID, areaID, poiID, isObjectIcon, atlasIcon
            if WoWPro.WOL then
                landmarkType, name, description, textureIndex, x, y, mapLinkID, inBattleMap, graveyardID, areaID, poiID, isObjectIcon, atlasIcon = GetMapLandmarkInfo(i)
            else
                name, description, textureIndex, x, y, mapLinkID, inBattleMap, graveyardID, areaID, poiID, isObjectIcon, atlasIcon = GetMapLandmarkInfo(i)
            end
            WoWProCharDB.BuildingLocations[name] = {x=(100*x), y=(100*y)}
            WoWPro.dbp("Building %s @ %g,%g", name, 100*x, 100*y)
        end
    end
end

-- Auto-Complete: Quest Update --
function WoWPro:AutoCompleteQuestUpdate(questComplete)
	local GID = WoWProDB.char.currentguide
	if not GID or not WoWPro.Guides[GID] then return end

    WoWPro:dbp("Running: AutoCompleteQuestUpdate(questComplete=%s)",tostring(questComplete))
	if WoWProCharDB.Guide then
		for i=1,#WoWPro.action do
		
			local action = WoWPro.action[i]
			local completion = WoWProCharDB.Guide[GID].completion[i]
			local QIDs = WoWPro.QID[i]
		    
			if QIDs then
				-- Quest Turn-Ins --
				-- Quest is flaged as completed then any step with that QID is complete
				-- T steps are covered by this check
				if WoWPro:IsQuestFlaggedCompleted(QIDs) and not completion then
					WoWPro.CompleteStep(i, "Quest marked done (AutoCompleteQuestUpdate)", true)
				else

					local numQIDs = select("#", string.split(";",QIDs))
					for j=1,numQIDs do
						local QID = select(numQIDs-j+1, string.split(";", QIDs))
						QID = tonumber(QID)
						local quest_log_index = WoWPro.QuestLog[QID]

				      -- A quest was just abandoned, all the related steps that were marked
				      -- as completed need to be unmarked
						if WoWPro.abandonedQID == QID and
							( action == "A" or action == "C" ) and
							completion then

							WoWProCharDB.Guide[GID].completion[i] = nil
							completion = nil
							if not skipUIUpdate then
								WoWPro:UpdateGuide()
								WoWPro:UpdateQuestTracker()
							end
	               
	               -- Quests that are in the current log have been accepted
	               elseif action == "A" and quest_log_index and not completion then
	               	WoWPro.CompleteStep(i, "Quest active (AutoCompleteQuestUpdate)", true)

						-- Quest Completion: Any C, K or l step is considered completed if the quest is completed
						elseif (action == "C" or action == "K" or action == "l") and not completion and quest_log_index and select(6,GetQuestLogTitle(quest_log_index)) == 1 then
							WoWPro.CompleteStep(i, "Quest completed (AutoCompleteQuestUpdate)", true)

						-- If the flighpoint is already known, mark it. Not really related to the quest log but only
						-- place I can put it so that it check for things that are.
						elseif action == "f" and not completion and 
								 (WoWProCharDB.Taxi[WoWPro.step[i]] or (WoWPro.altfp[i] and WoWProCharDB.Taxi[WoWPro.altfp[i]])) then
							WoWPro.CompleteStep(i, "Flight point knowned (AutoCompleteQuestUpdate)", true)

						-- Partial Completion --
						elseif not completion and WoWPro.QuestLog[QID] and WoWPro.questtext[i] and quest_log_index and GetNumQuestLeaderBoards(quest_log_index) > 0 then
							local numquesttext = select("#", (";"):split(WoWPro.questtext[i]))
							local complete = true
							for l=1,numquesttext do
								local lquesttext = select(numquesttext-l+1, (";"):split(WoWPro.questtext[i]))
								local lcomplete = false
								local qoi = tonumber(lquesttext)
								if qoi and qoi ~= 0 then
									-- The |QO| argument is a number
									if select(3,GetQuestLogLeaderBoard(qoi, quest_log_index)) then
										lcomplete = true
									end
								else
									for j=1,GetNumQuestLeaderBoards(quest_log_index) do
										local itemtext, _, isdone = GetQuestLogLeaderBoard(j, quest_log_index)
										if (itemtext == lquesttext) or
											(itemtext:match("[0-9]+[/][0-9]+ (.+)") == lquesttext:match("[0-9]+[/][0-9]+ (.+)") and isdone) then
											lcomplete = true
											break
										end
									end
								end
								if not lcomplete then complete = false end --if one of the listed objectives isn't complete, then the step is not complete.
							end
							if complete then
								WoWPro.CompleteStep(i, "Quest objective completed (AutoCompleteQuestUpdate)", true)
							end --if the step has not been found to be incomplete, run the completion function
						end
				   end
			   end
			end		
		end
	end

	WoWPro.abandonedQID = nil
	
	-- First Map Point --
	if WoWPro.FirstMapCall then
		WoWPro:MapPoint()
		WoWPro.FirstMapCall = false
	end
	
end

			
-- Auto-Complete: Set hearth --
function WoWPro:AutoCompleteSetHearth(...)
	local msg = ...
	local _, _, loc = msg:find(L["(.*) is now your home."])
	if loc then
		WoWProCharDB.Guide.hearth = loc
		for i = 1,15 do
			local index = WoWPro.rows[i].index
			if WoWPro.action[index] == "h" and WoWPro.step[index] == loc 
			and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
				WoWPro.CompleteStep(index, "Hearthstone was set to "..loc)
			end
		end
	end	
end

-- Parse chat messages
function WoWPro:ParseChatMsg(msg, ...)
	-- Validate Hearthstone
	local loc = msg:match(L["(.*) is now your home."])
	if loc then
		WoWProCharDB.Guide.hearth = loc
		for i = 1,15 do
			local index = WoWPro.rows[i].index
			if WoWPro.action[index] == "h" and WoWPro.step[index] == loc 
			and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
				WoWPro.CompleteStep(index, "Hearthstone was set to "..loc)
			end
		end
		return
	end	

	-- New follower
	local follower = msg:match("%[(.+)%] is now your follower[.]")
	if follower then
		err("ParseChatMsg: %s, %s", follower, msg)
		WoWPro:EventHandler("QUEST_LOG_UPDATE")
		return
	end
end

-- Auto-Complete: Zone based --
function WoWPro:AutoCompleteZone()
	WoWPro.ActiveStickyCount = WoWPro.ActiveStickyCount or 0
	local currentindex = WoWPro.rows[1+WoWPro.ActiveStickyCount].index
	local action = WoWPro.action[currentindex]
	-- local waypcomplete = WoWPro.waypcomplete[currentindex]
	-- local step = WoWPro.step[currentindex]
	-- local coord = WoWPro.map[currentindex]
	-- local zonetext, subzonetext = GetZoneText(), string.trim(GetSubZoneText())
	-- local hbdzonetext = HBD:GetLocalizedMap(HBD:GetPlayerZone())
	if action == "F" or action == "H" or action == "b" or action == "P" or (action == "R" and not WoWPro.waypcomplete[currentindex]) then
		if WoWPro.IsAtDestination(WoWPro.step[currentindex]) or WoWPro.IsAtDestination(WoWPro.dest[currentindex])
		-- if step == zonetext or step == subzonetext  or step == hbdzonetext
		and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[currentindex] then
			WoWPro.CompleteStep(currentindex, ("Arrival at destination %s detected"):format(WoWPro.dest[currentindex] or WoWPro.step[currentindex]) )
		end
	end
end

-- Auto-Complete: Criteria Change
function WoWPro.AutoCompleteCriteria()
    if not WoWProDB.char.currentguide then return end

	local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
	local GID = WoWProDB.char.currentguide
	if WoWPro.QID[qidx] and WoWPro:IsQuestFlaggedCompleted(WoWPro.QID[qidx],true) then
		    WoWProCharDB.Guide[GID].completion[qidx] = true
		    WoWProCharDB.completedQIDs[WoWPro.QID[qidx]] = true
	end			

	WoWPro:UpdateGuide() 
end

-- Auto-Complete: Chest Loot, for the silly timeless isle chests
function WoWPro.AutoCompleteChest()
    if not WoWProDB.char.currentguide then return end
    if 951 ~= GetCurrentMapAreaID() then return end

	local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
	local GID = WoWProDB.char.currentguide
	if WoWPro.QID[qidx] and WoWPro:IsQuestFlaggedCompleted(WoWPro.QID[qidx],true) then
		    WoWProCharDB.Guide[GID].completion[qidx] = true
		    WoWProCharDB.completedQIDs[WoWPro.QID[qidx]] = true
	end			

	WoWPro:UpdateGuide() 
end

-- Auto-Complete: Level based --
function WoWPro:AutoCompleteLevel(...)
	local newlevel = ... or UnitLevel("player")
	if WoWProCharDB.Guide then
		local GID = WoWProDB.char.currentguide
		if not WoWProCharDB.Guide[GID] then return end
		for i=1,WoWPro.stepcount do
			if not WoWProCharDB.Guide[GID].completion[i] 
				and WoWPro.level[i] 
				and tonumber(WoWPro.level[i]) <= newlevel then
					WoWPro.CompleteStep(i, ("Level %s reached"):format(newlevel) )
			end
		end
	end
end


do -- closure

local THROTTLE_TIME = 0.4
local throt
local f = CreateFrame("Frame")
f:Hide()
f:SetScript("OnUpdate", function(self, elapsed)
	throt = throt - elapsed
	if throt < 0 and not MaybeCombatLockdown() then
		WoWPro:ResizeAndPad()
		f:Hide()
	end
end)

local function ResizeAndPad_bucket(delay)
	throt = delay or THROTTLE_TIME
	f:Show()
end

function WoWPro:ResizeAndPad(delay)
	if delay then
		ResizeAndPad_bucket(delay)
	elseif MaybeCombatLockdown() then
		ResizeAndPad_bucket()
	else
		WoWPro:TitlebarSet()
		WoWPro:PaddingSet()
		WoWPro:RowSizeSet()
	end
end

end -- closue

-- Update Quest Tracker --
local green = "FF00FF00"
local white = "FFFFFFFF"
function WoWPro:UpdateQuestTracker()
	if not WoWPro.GuideFrame:IsVisible() then return end
	local GID = WoWProDB.char.currentguide
	if not GID or not WoWPro.Guides[GID] then return end
	
	WoWPro:dbp("Running WoWPro:UpdateQuestTracker()")
	for i,row in ipairs(WoWPro.rows) do
		local index = row.index
		local questtext = WoWPro.questtext[index] 
		local action = WoWPro.action[index] 
		local lootitem = WoWPro.lootitem[index]
		local step = WoWPro.step[index] 
		local lootqty = WoWPro.lootqty[index] 
		local QID = tonumber(WoWPro.QID[index])
		local isActive = nil
		local track = ""

		-- If more then one QIDs, find if a QID is active
		if WoWPro.QID[index] then
			for qid in (WoWPro.QID[index]):gmatch("[^;]+") do
				if WoWPro.QuestLog[tonumber(qid)] then 
					QID = tonumber(qid)
					isActive = true
					break
				end
			end
		end
	--err("QID = %s,index = %s,action = %s,step = %s",QID,index,action,step)
		
		if tonumber(lootqty) ~= nil then lootqty = tonumber(lootqty) else lootqty = 1 end
		-- Setting up quest tracker --
		row.trackcheck = false
		
		-- Display the QID if needed.
		if step then
			if WoWProCharDB.ShowQID then
				row.step:SetText(("[|c%s%s|r] %s"):format(isActive and green or white, QID or WoWPro.QID[index] or "---", step))
			else
				row.step:SetText(step)
			end
		end
		
        -- Clean up any leftovers
		row.track:SetText(track)

        if action then
            WoWPro:dbp("profile.track=%s action=%s questtext=%s lootitem=%s",tostring(WoWProDB.profile.track),tostring(action),tostring(questtext),tostring(lootitem))		
        end

      if WoWProDB.profile.track and ( action == "C" or action == "K"or questtext or lootitem) then
      	if WoWPro.QuestLog[QID] and GetNumQuestLeaderBoards(WoWPro.QuestLog[QID]) > 0 then
      		local j = WoWPro.QuestLog[QID]
      		row.trackcheck = true
      		if not questtext and (action == "C" or action == "K") then
      			for l=1,GetNumQuestLeaderBoards(j) do
      				local itemtext, _, isdone = GetQuestLogLeaderBoard(l, j)
      				track = ("%s%s- %s%s"):format(track, l>1 and "\n" or "", itemtext, isdone and " (C)" or "")
      			end
      		elseif questtext then --Partial completion steps only track pertinent objective.
      			local numquesttext = select("#", (";"):split(questtext))
      			for l=1,numquesttext do
      				local lquesttext = select(l, (";"):split(questtext))
      				local qoi = tonumber(lquesttext)
      				if qoi and qoi ~= 0 then
      					-- Numerical quest objectif
      					local itemtext, _, isdone = GetQuestLogLeaderBoard(qoi, j)
      					if itemtext then
      						track = ("%s%s- %s%s"):format(track, l>1 and "\n" or "", itemtext, isdone and " (C)" or "")
      					else
      						track = ("%s%s|cFFFF0000*** Invalid quest objectif number '%s' in ||QO||%s|| ***|r"):format(track, l>1 and "\n" or "", qoi, questtext)
      					end
      				else
      					-- Text quest objectif
	      				--local litemname = lquesttext:match("(.+):") -- Everything before the : is the item name
	      				local litemname = lquesttext:match("[0-9]+[/][0-9]+ (.+)") -- New format "1/2 Objective"
	      				for m=1,GetNumQuestLeaderBoards(j) do
	      					if GetQuestLogLeaderBoard(m, j) then
	      						local itemtext, _, isdone = GetQuestLogLeaderBoard(m, j)
	      						--local itemName = itemtext:match("(.+):") -- Everything before the : is the item name
	      						local itemName = itemtext:match("[0-9]+[/][0-9]+ (.+)") -- New format "1/2 Objective"
	      						if itemName and itemName == litemname then
	      							track = ("%s%s- %s%s"):format(track, l>1 and "\n" or "", itemtext, isdone and " (C)" or "")
	      						end
	      					end
	      				end
      				end
      			end
      		end
      	end

			if lootitem then
				row.trackcheck = true
				if tonumber(lootqty) ~= nil then lootqty = tonumber(lootqty) else lootqty = 1 end
				track = WoWPro.GetLootTrackingInfo(lootitem,lootqty)
			end
		end
        if action then
		    WoWPro:dbp("Setting track text for %s [%s] to '%s'",tostring(action),tostring(step),track)
		end
		row.track:SetText(track)
	end
	WoWPro:ResizeAndPad()
end


function WoWPro.EventHandler(frame, event, ...)
    -- Filter out non-player UNIT_AURA events
    if event == "UNIT_AURA" then
         -- Process silently!
        if not MaybeCombatLockdown() then
            WoWPro.AutoCompleteBuff(...)
        end
        return
    end

    WoWPro:LogEvent(event,...)

    -- Naughty People!
    if event == "ADDON_ACTION_FORBIDDEN" or event == "ADDON_ACTION_BLOCKED" then
        -- Its has been logged by LogEvent, so just return
        return
    end
    
	-- Unlocking event processong after things get settled --
	if event == "PLAYER_ENTERING_WORLD"  then
	    WoWPro:print("Setting Timer PEW")
	    WoWPro.InitLockdown = true
	    WoWPro.LockdownCounter = 5  -- times until release and give up to wait for other addons
	    WoWPro.LockdownTimer = 1.5
	end
		
	-- Locking event processong till after things get settled --
	if event == "PLAYER_LEAVING_WORLD"  then
	    WoWPro:print("Locking Down PLW")
	    WoWPro.InitLockdown = true
	end
	
	if event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "MINIMAP_ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD" then
	    -- Check to see if the current zone is mapped properly.
	    WoWPro.CheckHBDData()
	    WoWPro.SaveGarrisonBuildings()
	end

	-- if WoWPro.InitLockdown and event ~= "ZONE_CHANGED_NEW_AREA" then
	--     return
	-- end
	
    -- Scenario Tracking
    if event == "SCENARIO_UPDATE" then
        WoWPro.ProcessScenarioStage(...)
    end
    if event == "SCENARIO_CRITERIA_UPDATE" or event == "CRITERIA_COMPLETE" then
        WoWPro.ProcessScenarioCriteria(false)
    end

	-- Noticing if we are doing a pet battle!
	local guidetype = "WoWPro"
	local battleHide = false
	if WoWProDB.char.currentguide and WoWPro.Guides[WoWProDB.char.currentguide] and WoWPro.Guides[WoWProDB.char.currentguide].guidetype then
	    guidetype = WoWPro.Guides[WoWProDB.char.currentguide].guidetype
	    battleHide = not WoWPro.Guides[WoWProDB.char.currentguide].PetBattle
	end
	
	if event == "PET_BATTLE_OPENING_START" then
	    WoWPro.LastPetBattleWinner = nil
	    if (not WoWPro.Hidden) and battleHide then
        	WoWPro.MainFrame:Hide()
        	WoWPro.Titlebar:Hide()
        	WoWPro.Hidden = true
        end
		WoWPro.PetBattleActive = true
		return
	end
	if event == "PET_BATTLE_CLOSE" then
	    if WoWPro.Hidden then
    		WoWPro.MainFrame:Show()
    		WoWPro.Titlebar:Show()
    	end

		WoWPro.Hidden = nil
		if not C_PetBattles.IsInBattle() then
		    WoWPro.PetBattleActive = false
		    WoWPro:dbp("C_PetBattles.IsInBattle() = false")
		else
		    WoWPro:dbp("C_PetBattles.IsInBattle() = true")
		    return
		end
		if WoWPro.current_strategy == false then
		    WoWPro.current_strategy = nil
		    WoWPro:dbp("WoWPro.current_strategy = nil")
		end
	end
	
	-- Stop processing if no guide is active or something is odd!
	if not WoWProDB.char.currentguide then return end
	if not WoWPro.Guides[WoWProDB.char.currentguide] then return end
	if  not WoWPro.GuideLoaded then
	    WoWPro:dbp("Suppresssed event processing. Guide %s is not loaded yet!",tostring(WoWProDB.char.currentguide))
        return 
	end
	
	-- Common event Handling across addons
	
	-- Noticing if we have entered a Dungeon!
	if event == "ZONE_CHANGED_NEW_AREA" and WoWProCharDB.AutoHideInsideInstances == true then
	    local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
	    if WoWPro.zone[qidx] and (WoWPro:IsInstanceZone(WoWPro.zone[qidx]) or WoWPro.sobjective[qidx]) and IsInInstance() then
	        WoWPro:Print("|cff33ff33 Suppressing Instance Auto Hide, turn it on after you are done with this guide.|r")
	        WoWProCharDB.AutoHideWorldEventsInsideInstances = false
	        return
	    end
		if IsInInstance() then
			WoWPro:Print("|cff33ff33Instance Auto Hide|r: %s Module",guidetype)
			WoWPro.MainFrame:Hide()
			WoWPro.Titlebar:Hide()
			WoWPro.Hidden = true
			return
		elseif WoWPro.Hidden == true then
			WoWPro:Print("|cff33ff33Instance Exit Auto Show|r: %s Module",guidetype)
			WoWPro.MainFrame:Show()
			WoWPro.Titlebar:Show()
			WoWPro.Hidden = nil
		end
	end


	-- Unlocking guide frame when leaving combat --
	if event == "PLAYER_REGEN_ENABLED" or 
		event == "PLAYER_ENTERING_WORLD" or
		event == "CINEMATIC_STOP" then

		WoWPro.InitLockdown = nil
		WoWPro:PopulateQuestLog()
		WoWPro:AutoCompleteQuestUpdate(nil)
		WoWPro:UpdateQuestTracker()
		WoWPro:UpdateGuide(event)
	end
	
	-- Updating party-dependant options --
	if event == "PARTY_MEMBERS_CHANGED" and not MaybeCombatLockdown() then
		WoWPro:UpdateGuide() 
	end

	-- Updating WoWPro keybindings --
	if event == "UPDATE_BINDINGS" and not MaybeCombatLockdown() then
		WoWPro:UpdateGuide() 
	end

	-- -- Lets see what quests the NPC has:
 --    if event == "GOSSIP_SHOW" and WoWProCharDB.AutoSelect == true then
 --        local npcQuests = {GetGossipAvailableQuests()};
 --        local npcCount = GetNumGossipAvailableQuests();
 --        local index = 0
 --        local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
 --        local myNPC = WoWPro:TargetNpcId()
 --        for _,item in pairs(npcQuests) do
 --            if type(item) == "string" then
 --                index = index + 1
 --                WoWPro:dbp("ZZZT: GOSSIP_SHOW index %d/%d, considering [%s]",index,npcCount,item)
 --                if WoWPro.action[qidx] == "A" then
 --    		        if WoWPro.QID[qidx] == "*" and WoWPro.NPC[qidx] and tonumber(WoWPro.NPC[qidx]) == myNPC then
 --    	                if WoWPro.qcount[qidx] then
 --    	                    WoWPro:dbp("ZZZT %d: Inhale %s, prev qcount was %d, new is %d",qidx,item, WoWPro.qcount[qidx], npcCount)
 --    	                    WoWPro.qcount[qidx] = npcCount
 --    	                end
 --    	                WoWPro.qcount[qidx] = npcCount
 --    		            SelectGossipAvailableQuest(index)
 --    		            return
 --    		        end
 --    		        if WoWPro.action[qidx] == "A" and item == WoWPro.step[qidx] then
 --    		            WoWPro:dbp("ZZZT %d: Name matches [%s], selecting.",index,item)
 --    		            SelectGossipAvailableQuest(index)
 --    		        end
 --    		    end
 --            end
 --        end
 --        npcQuests =  {GetGossipActiveQuests()};
 --        index = 0 
 --        for _,item in pairs(npcQuests) do
 --            if type(item) == "string" then
 --                index = index + 1       
	-- 	        if WoWPro.action[qidx] == "T" and item == WoWPro.step[qidx] then
	-- 	            SelectGossipActiveQuest(index)
	-- 	            return
	-- 	        end
 --            end
 --        end
 --    end
    
 --    if event == "QUEST_GREETING" and WoWProCharDB.AutoSelect == true then
 --        local numAvailableQuests = GetNumAvailableQuests()
 --        local numActiveQuests = GetNumActiveQuests()
 --        local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
 --        if WoWPro.QID[qidx] == "*" and WoWPro.action[qidx] == "A" then
 --            WoWPro:Error("Got QUEST_GREETING event on wildcard accept.  Report this bug!")
 --        end
 --        for i=1, numActiveQuests do
 --            if WoWPro.action[qidx] == "T" and GetActiveTitle(i) == WoWPro.step[qidx] then
	-- 	        SelectActiveQuest(i)
	-- 	        return
	-- 	    end
	-- 	end
 --        for i=1, numAvailableQuests do
 --            if WoWPro.action[qidx] == "A" and GetAvailableTitle(i) == WoWPro.step[qidx] then
	-- 	        SelectAvailableQuest(i)
	-- 	        return
	-- 	    end
	-- 	end
 --    end
    
 --    if event == "QUEST_DETAIL" and WoWProCharDB.AutoAccept == true then
 --        local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
 --        local questtitle = GetTitleText();
 --        local npcCount = GetNumGossipAvailableQuests();
 --        local myNPC = WoWPro:TargetNpcId()
 --        WoWPro:dbp("ZZZT %d: Quest Detail [%s], %d avail, QID %s",qidx,questtitle,npcCount,tostring(WoWPro.QID[qidx]))
	-- 	if WoWPro.action[qidx] == "A" and (questtitle == WoWPro.step[qidx] or WoWPro.QID[qidx] == "*") then
	-- 	    if  WoWPro.QID[qidx] == "*" and WoWPro.NPC[qidx] and tonumber(WoWPro.NPC[qidx]) == myNPC then
	-- 	        WoWPro:dbp("ZZZT %d: Auto Accept wildcard [%s], %d avail",qidx,questtitle,npcCount)
	-- 	        WoWPro.qcount[qidx] = WoWPro.qcount[qidx] or npcCount
	-- 	    end
	-- 	    AcceptQuest()
	-- 	    if WoWPro.QID[qidx] == "*" and WoWProCharDB.AutoSelect then
 --    		    -- OK, now get the next quest.
 --    		    if WoWPro.qcount[qidx] then
 --    		        if  WoWPro.qcount[qidx] > 1 then
 --        		        WoWPro:dbp("ZZZT %d Faking GOSSIP_SHOW, qcount is %d",qidx, WoWPro.qcount[qidx])
 --        		        WoWPro.EventHandler(frame,"GOSSIP_SHOW")
 --        		    else
 --                        -- We accepted the last quest.
 --                        WoWPro:dbp("ZZZT: Suck done, finishing %d",qidx)
 --                   		WoWPro.CompleteStep(qidx, "QUEST_DETAIL: A*")
 --                    end
 --                end
 --    		end
	-- 	end
 --    end


 --    if event == "QUEST_PROGRESS" and WoWProCharDB.AutoTurnin == true then
 --        local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
 --        local questtitle = GetTitleText();
 --        WoWPro:dbp("Quest is [%s], matching [%s]",tostring(questtitle),tostring(WoWPro.step[qidx]))
	-- 	if WoWPro.action[qidx] == "T" and questtitle == WoWPro.step[qidx] then
	-- 	    CompleteQuest()
	-- 	end  
 --    end

    -- Noting that a quest is being completed for quest log update events --
	-- if event == "QUEST_COMPLETE" then
	-- --    local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
 --   --     local questtitle = GetTitleText();
	-- --	if WoWProCharDB.AutoTurnin == true and (WoWPro.action[qidx] == "T" or WoWPro.action[qidx] == "A") and questtitle == WoWPro.step[qidx] then
	-- --	    if (GetNumQuestChoices() <= 1) then
	-- --	        GetQuestReward(1)
	-- --	    end
 --   -- end
	-- 	WoWPro:AutoCompleteQuestUpdate(GetQuestID())
	-- end
	
	-- if event == "QUEST_TURNED_IN" or event == "QUEST_ACCEPTED" then
	--     local qlidx, qid = ...
	--     WoWPro:dbp("%s(%s,%s)",event,qlidx,qid)
	--     --if event == "QUEST_TURNED_IN" then
 --       -- 	WoWPro.CompletingQuest = true
 --       -- 	WoWProCharDB.completedQIDs[qlidx] = true
 --       -- 	WoWPro:AutoCompleteQuestUpdate(qlidx)	    
	--     --end
	-- end
	    
	if event == "NEW_RECIPE_LEARNED" then
	    WoWPro.LearnRecipe(...)
    end

	-- Auto-Completion --
	if event == "TAXIMAP_OPENED" then
		WoWPro:RecordTaxiLocations(...)
		WoWPro:UpdateQuestTracker()
		WoWPro:UpdateGuide(event)

		local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
		if WoWPro.action[qidx] == "F" and WoWProCharDB.AutoAccept == true then
		    if TaxiFrame_ShouldShowOldStyle() then
		        WoWPro.TakeTaxi_OldStyle(qidx,WoWPro.step[qidx])
		    else
		        WoWPro.TakeTaxi_NewStyle(qidx,WoWPro.step[qidx])
		    end
		end
	end
	if event == "CHAT_MSG_SYSTEM" then
		-- WoWPro:AutoCompleteSetHearth(...)
		WoWPro:ParseChatMsg(...)
	end	
	if event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "MINIMAP_ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" then
		WoWPro:AutoCompleteZone(...)
	end
	if event == "QUEST_LOG_UPDATE" or
		event == "QUEST_COMPLETE" or
		event == "QUEST_TURNED_IN" or 
		event == "QUEST_ACCEPTED" or
		event == "GARRISON_FOLLOWER_ADDED" then
		WoWPro:PopulateQuestLog()
		WoWPro:AutoCompleteQuestUpdate(nil)
		WoWPro:UpdateQuestTracker()
		WoWPro:UpdateGuide(event)
	end

	if event == "UI_INFO_MESSAGE" then
		WoWPro:AutoCompleteGetFP(...)
	end
	if event == "GOSSIP_SHOW" then
	    WoWPro.GossipText = strupper(GetGossipText())
	    WoWPro:dbp("GetGossipText: %s",WoWPro.GossipText)
	    WoWPro:UpdateGuide(event)
	end
	if event == "GOSSIP_CLOSED" then
	    WoWPro.GossipText = nil
	end
	
	if event == "PLAYER_TARGET_CHANGED" then
	    WoWPro.NpcCheck(...)
	end
	
	if event == "PET_BATTLE_PET_ROUND_RESULTS" then
	    WoWPro:UpdateGuide(event)
	end
	
	if event == "PET_BATTLE_FINAL_ROUND" then
	    local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
	    local winner = ...
	    WoWPro:DelFauxQuest(WoWPro.QID[qidx])
        WoWPro.ProcessFinalRound(winner, qidx)
	    WoWPro:UpdateGuide(event)
	end
	
	-- Module Event Handlers --
	for name, module in WoWPro:IterateModules() do
		if WoWPro[name].EventHandler 
		and WoWProDB.char.currentguide 
		and WoWPro.Guides[WoWProDB.char.currentguide]
		and guidetype == name 
		then WoWPro[name]:EventHandler(frame, event, ...) end
	end
end

function WoWPro.PuntedQLU()
    if WoWPro.InitLockdown then
        WoWPro:SendMessage("WoWPro_PuntedQLU")
        return
    end
    WoWPro.EventHandler(nil, "QUEST_LOG_UPDATE","-punted-")
end


-- Call this function to deal with any open quest dialog for autoaccept, autocomplete and autoturins
-- for any of the current displayed step
function WoWPro:QuestDialogAutomation()
	if not WoWPro.CurrentIndex or not WoWPro.ActiveStep or IsShiftKeyDown() then return end

	for step_index = WoWPro.ActiveStep, WoWPro.CurrentIndex do

		local callMeAgain = nil

		if GossipFrame:IsShown() then

			local action, step = WoWPro.action[step_index], WoWPro.step[step_index]
			if WoWProCharDB.AutoTurnin and action == "T" then

				local index = 1
				repeat
					local item = select((index-1) * 6 + 1, GetGossipActiveQuests())
					if item and item:trim() == step then
						SelectGossipActiveQuest(index)
						callMeAgain = true
						break
					end
					index = index + 1
				until not item

			elseif WoWProCharDB.AutoAccept and action == "A" then

				local index = 1
				repeat
					local item = select((index-1) * 7 + 1, GetGossipAvailableQuests())
					if item and item:trim() == step then
						SelectGossipAvailableQuest(index)
						callMeAgain = true
						break
					end
					index = index + 1
				until not item
			end
		end

		if QuestFrameGreetingPanel:IsShown() then
			local action, step = WoWPro.action[step_index], WoWPro.step[step_index]

			if WoWProCharDB.AutoSelect and action == "T" then
				local numActiveQuests = GetNumActiveQuests()
				local step_index = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
				for i=1, numActiveQuests do
					if GetActiveTitle(i):trim() == step then
						SelectActiveQuest(i)
						callMeAgain = true
						break
					end
				end
			elseif WoWProCharDB.AutoSelect and action == "A" then
				local numAvailableQuests = GetNumAvailableQuests()
				for i=1, numAvailableQuests do
					if GetAvailableTitle(i):trim() == step then
						SelectAvailableQuest(i)
						callMeAgain = true
						break
					end
				end
			end
		end

		if QuestFrameProgressPanel:IsShown() then

			-- Turnin the current quest automaticaly if applicable
			if WoWProCharDB.AutoTurnin and WoWPro.action[step_index] == "T" and GetTitleText():trim() == WoWPro.step[step_index] then
				CompleteQuest()
				callMeAgain = true
			end
		end

		if QuestFrameRewardPanel:IsShown() then

			-- Choose the reward automaticaly if there is only one choice
			if WoWProCharDB.AutoTurnin and 
				(WoWPro.action[step_index] == "T" or WoWPro.action[step_index] == "A") and
				GetTitleText():trim() == WoWPro.step[step_index] and
				GetNumQuestChoices() <= 1 then
					GetQuestReward(1)
					callMeAgain = true
			end
		end

		if QuestFrameDetailPanel:IsShown() then

			-- Accept the current quest automaticaly if applicable
			if WoWProCharDB.AutoAccept and 
				WoWPro.action[step_index] == "A" and 
				GetTitleText():trim() == WoWPro.step[step_index] and 
				not WoWPro.optional[step_index] and -- Don' t automatically accept optional quests
				not _G.QuestFrame.autoQuest -- No need to accept autoQuest since they are accepted automatically
			then 
	--err("AutoAcceptQuest")
					AcceptQuest()
					callMeAgain = true
			end

			-- Deal with AutoAccept dialog
			if WoWProCharDB.AutoAccept and _G.QuestFrame.autoQuest then
				HideUIPanel(_G.QuestFrame)
			end
		end

		if callMeAgain then 
			WoWPro:SendMessage("WoWPro_QuestDialogAutomation") 
			--return
		end

	end

end
