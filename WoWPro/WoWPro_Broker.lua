-------------------------------------------------------------------------------
-- Localized Lua globals
-------------------------------------------------------------------------------
local _G = getfenv(0)

local string 								= _G.string
local assert 								= _G.assert
local debugprofilestart 				= _G.debugprofilestart
local debugprofilestop 					= _G.debugprofilestop
local geterrorhandler 					= _G.geterrorhandler
local math 									= _G.math
local select 								= _G.select
local tonumber 							= _G.tonumber
local tostring 							= _G.tostring
local tostringall							= _G.tostringall
local time 									= _G.time
local type 									= _G.type

local table 								= _G.table
local ipairs 								= _G.ipairs
local next 									= _G.next
local pairs 								= _G.pairs
local tinsert 								= _G.tinsert
local tremove 								= _G.tremove
local wipe 									= _G.wipe

local UIParent 							= _G.UIParent

local CreateFrame 						= _G.CreateFrame
local EasyMenu 							= _G.EasyMenu
local GetFactionInfo 					= _G.GetFactionInfo
local GetFactionInfoByID 				= _G.GetFactionInfoByID
local GetItemCount 						= _G.GetItemCount
local GetItemInfo 						= _G.GetItemInfo
local GetNumFactions 					= _G.GetNumFactions
local GetNumQuestLeaderBoards 		= _G.GetNumQuestLeaderBoards
local GetNumQuestLogEntries 			= _G.GetNumQuestLogEntries
local GetProfessionInfo 				= _G.GetProfessionInfo
local GetProfessions 					= _G.GetProfessions
local GetQuestID 							= _G.GetQuestID
local GetQuestLogLeaderBoard 			= _G.GetQuestLogLeaderBoard
local GetQuestLogSpecialItemInfo 	= _G.GetQuestLogSpecialItemInfo
local GetQuestLogTitle 					= _G.GetQuestLogTitle
local GetSubZoneText 					= _G.GetSubZoneText
local GetZoneText 						= _G.GetZoneText
local InCinematic 						= _G.InCinematic
local InCombatLockdown 					= _G.InCombatLockdown
local NumTaxiNodes						= _G.NumTaxiNodes
local PlaySoundFile 						= _G.PlaySoundFile
local QuestMapUpdateAllQuests 		= _G.QuestMapUpdateAllQuests
local QuestPOIUpdateIcons 				= _G.QuestPOIUpdateIcons
local TaxiNodeName						= _G.TaxiNodeName
local UnitFactionGroup 					= _G.UnitFactionGroup
local UnitLevel 							= _G.UnitLevel
local WorldMapFrame_UpdateQuests 	= _G.WorldMapFrame_UpdateQuests

local function err(msg,...) geterrorhandler()(msg:format(tostringall(...)) .. " - " .. time()) end

-----------------------------
--      WoWPro_Broker      --
-----------------------------

local WoWPro = _G.LibStub("AceAddon-3.0"):GetAddon("WoWPro")

local L = _G.WoWPro_Locale
local OldQIDs, CurrentQIDs, NewQIDs, MissingQIDs
local GuideLoaded = false

-------------------------------
-- Table Recycling functions --
-------------------------------

-- Table reuse functions
local AcquireTable, ReleaseTable
do
	local table_cache = {}

	-- Returns a table
	function AcquireTable()
		local tbl = tremove(table_cache) or {}
		return tbl
	end

	-- Cleans the table and stores it in the cache
	function ReleaseTable(tbl)
		if not tbl then return end

		-- Nested tables ?
		for i=1,#tbl do
			if type(tbl[i]) == 'table' then ReleaseTable(tbl[i]) end
		end

		wipe(tbl)
		tinsert(table_cache, tbl)
	end
end	-- do block

-- Wipe a table but also call ReleaseTable() on each nested table
local function WipeTable(tbl)
	assert(type(tbl) == 'table',"Usage: WipeTable(table) The argument must be a table.")

	-- Nested tables ?
	for i=1,#tbl do
		if type(tbl[i]) == 'table' then ReleaseTable(tbl[i]) end
	end

	wipe(tbl)
end
WoWPro.AcquireTable = AcquireTable
WoWPro.ReleaseTable = ReleaseTable
WoWPro.WipeTable = WipeTable

-- Table copy function -- borrowed from AceDB-3.0.lua
local function CopyTable(src, dest)
	if type(dest) ~= "table" then dest = AcquireTable() end
	if type(src) == "table" then
		for k,v in pairs(src) do
			if type(v) == "table" then
				-- try to index the key first so that the metatable creates the defaults, if set, and use that table
				v = CopyTable(v, dest[k])
			end
			dest[k] = v
		end
	end
	return dest
end

-- Check for empty table
local function IsTableEmpty(table)
	return not next(table)
end



-- Guide Load --
function WoWPro:LoadGuide(guideID)
----WoWPro:Trace("Start WoWPro:LoadGuide Guide: "..tostring(guideID))
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	--Re-initiallizing tags and counts--
	for i,tag in pairs(WoWPro.Tags) do
		--WoWPro[tag] = {}
		WoWPro[tag] = WoWPro[tag] or AcquireTable()
		wipe(WoWPro[tag])
	end
	WoWPro.stepcount, WoWPro.stickycount, WoWPro.optionalcount = 0, 0 ,0

	GuideLoaded = true
	--Checking the GID and loading the guide --
	if guideID then WoWProDB.char.currentguide = guideID end
	local GID = WoWProDB.char.currentguide
	if not GID then
		WoWPro:LoadNilGuide()
		WoWPro:dbp("No guide specified, loading NilGuide.")
		return
	end
	-- If the current guide can not be found, see if it was renamed.
	if not WoWPro.Guides[GID] then
	    local myUFG = UnitFactionGroup("player"):sub(1,1)
	    local name,levels = GID:match("([A-Za-z]+)([0-9]+)")
	    levels = levels or ""
	    name = name or ""
	    local newGID =name..myUFG..levels
	    if WoWPro.Guides[newGID] then
	        -- Yeah, we renamed the guide on the poor chap.
	        -- Remap the state
	        WoWPro:Print("Guide "..GID.." was renamed to "..newGID..".  Remapping.")
	        WoWProCharDB.Guide[newGID] = WoWProCharDB.Guide[GID]
	        WoWProCharDB.Guide[GID] = nil
	        GID = newGID
	        WoWProDB.char.currentguide = GID
	    end
	end
	if not WoWPro.Guides[GID] then
		WoWPro:dbp("Guide "..GID.." not found, loading NilGuide.")
		WoWPro:LoadNilGuide()
		WoWProDB.char.currentguide = nil
		return
	end
	WoWPro:dbp("Loading Guide: "..GID)

	-- Creating a new entry if this guide does not have one
	if WoWProCharDB.Guide[GID] == nil then
	    WoWProCharDB.Guide[GID] = AcquireTable()
	    WoWProCharDB.Guide[GID].Version = WoWPro.Version
	end
	WoWProCharDB.Guide[GID].completion = WoWProCharDB.Guide[GID].completion or AcquireTable()
	WoWProCharDB.Guide[GID].skipped = WoWProCharDB.Guide[GID].skipped or AcquireTable()

	local module = WoWPro:GetModule(WoWPro.Guides[GID].guidetype)
	if module:IsEnabled() then
		WoWPro[WoWPro.Guides[GID].guidetype]:LoadGuide()
	else return end

	--WoWPro:UpdateGuide()
	WoWPro:MapPoint()
----WoWPro:Trace("End WoWPro:LoadGuide Guide: "..tostring(guideID))
end

function WoWPro:NextGuide(GID)
	if not WoWPro.Guides[GID].nextGID then return nil; end
	if WoWPro.Guides[GID].faction == "Neutral" then
	    -- nextGIDvalue is faction dependent.   Split it and pick the right one "AllianceGUID|HordeGID"
	    local  AllianceGUID, HordeGID = string.split("|",WoWPro.Guides[GID].nextGID)
	    if UnitFactionGroup("player") == _G.FACTION_ALLIANCE then
	        return AllianceGUID
	    else
	        return HordeGID
	    end
	else
	    return WoWPro.Guides[GID].nextGID
	end
end

WoWPro.eventcount = WoWPro.eventcount or {}
WoWPro.eventcount["UpdateGuide"] = 0

do -- closure

local menuFrame = CreateFrame("Frame", "WoWProDropMenu", UIParent, "UIDropDownMenuTemplate")
local function rowOnClick(self, button, down)
	if button == "LeftButton" then
		WoWPro[self.modulename]:RowLeftClick(self.i)
	elseif button == "RightButton" then
		WoWPro.rows[self.i]:SetChecked(nil)
		if WoWPro.Recorder then WoWPro[self.modulename]:RowLeftClick(self.i) end
		EasyMenu(WoWPro[self.modulename].RowDropdownMenu[self.i], menuFrame, "cursor", 0 , 0, "MENU")
	end
end

local function rowContentUpdate(module, offset)
	-- Call the module
	local reload = WoWPro[module:GetName()]:RowUpdate(offset)
	if not reload then
		for i, row in pairs(WoWPro.rows) do
			local modulename
			-- Hyjack the click and menu functions for the Recorder if it's enabled --
			if WoWPro.Recorder then
				modulename = "Recorder"
				WoWPro.Recorder:RowUpdate(offset)
			else modulename = module:GetName() end
			if WoWPro[modulename].RowLeftClick and WoWPro[modulename].RowDropdownMenu then
				row.i = i
				row.modulename = modulename
				row:SetScript("OnClick", rowOnClick)
			end
		end
	end
	return reload
end

-- Bucket to wait until out of combat or until the cinematic is over
local THROTTLE_TIME = 0.1
local throt, b_offset
local f = CreateFrame("Frame")
f:Hide()
f:SetScript("OnShow", function(self)
	throt = THROTTLE_TIME
end)
f:SetScript("OnUpdate", function(self, elapsed)
	throt = throt - elapsed
	if throt < 0 and not InCombatLockdown() and not InCinematic() then
		WoWPro:UpdateGuide(b_offset)
		b_offset = nil
		f:Hide()
	end
end)

local function UpdateGuide_bucket(offset)
	b_offset = offset
	f:Show()
end

-- For profilling
local max_time, nb_error = 30, 0

-- Guide Update --
function WoWPro:UpdateGuide(offset)

	debugprofilestart()

----WoWPro:Trace("Call WoWPro:UpdateGuide offset:"..tostring(offset))
	if not WoWPro.GuideFrame:IsVisible() or not GuideLoaded then return end
	WoWPro:dbp("Running: UpdateGuide()")

	WoWPro.eventcount["UpdateGuide"] = WoWPro.eventcount["UpdateGuide"] + 1

	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB
	local GID = WoWProDB.char.currentguide

	if	not GID or not WoWPro.Guides[GID] then
		return
	end

	if InCombatLockdown() or InCinematic() then
		UpdateGuide_bucket(offset)
		return
	end

--WoWPro:Trace("Start WoWPro:UpdateGuide")
	-- If the module that handles this guide is not present and enabled, then end --
	local module = WoWPro:GetModule(WoWPro.Guides[GID].guidetype)
	if not module or not module:IsEnabled() then return end

	-- Finding the active step in the guide --
	WoWPro.ActiveStep = WoWPro:NextStep(1)

	if WoWPro.Recorder then WoWPro.ActiveStep = WoWPro.Recorder.SelectedStep or WoWPro.ActiveStep end
	if not offset then WoWPro.Scrollbar:SetValue(WoWPro.ActiveStep) end
	WoWPro.Scrollbar:SetMinMaxValues(1, math.max(1, WoWPro.stepcount))

	-- Calling on the guide's module to populate the guide window's rows --
	-- Reloading until all stickies that need to unsticky have done so --
	while true do
		if  not rowContentUpdate(module, offset) then break end
	end
	WoWPro:UpdateQuestTracker()

	-- Update content and formatting --
	WoWPro:RowSet(); WoWPro:RowSet()
	WoWPro:PaddingSet()

	-- Updating the guide list or current guide panels if they are shown --
	if WoWPro[module:GetName()].GuideList
	and WoWPro[module:GetName()].GuideList.Frame
	and WoWPro[module:GetName()].GuideList.Frame:IsVisible()
	and WoWPro[module:GetName()].UpdateGuideList then
		WoWPro[module:GetName()]:UpdateGuideList()
	end
	if WoWPro.CurrentGuideFrame:IsVisible() then WoWPro.UpdateCurrentGuidePanel() end

	-- Updating the progress count --
	local p = 0
	for j = 1,WoWPro.stepcount do
		if ( WoWProCharDB.Guide[GID].completion[j] or WoWProCharDB.Guide[GID].skipped[j] )
--		and not WoWPro.sticky[j]
		and not WoWPro.optional[j] then
			p = p + 1
		end
	end
	WoWProCharDB.Guide[GID].progress = p
--	WoWProCharDB.Guide[GID].total = WoWPro.stepcount - WoWPro.stickycount - WoWPro.optionalcount
	WoWProCharDB.Guide[GID].total = WoWPro.stepcount - WoWPro.optionalcount

	-- TODO: make next lines module specific
	WoWPro.TitleText:SetText(WoWPro.Guides[GID].zone.."   ("..WoWProCharDB.Guide[GID].progress.."/"..WoWProCharDB.Guide[GID].total..")")

	-- If the guide is complete, loading the next guide --
	if WoWProCharDB.Guide[GID].progress == WoWProCharDB.Guide[GID].total
	and not WoWPro.Recorder and WoWPro.Leveling and not WoWPro.Leveling.Resetting then
		if WoWProDB.profile.autoload then
			WoWProDB.char.currentguide = WoWPro:NextGuide(GID)
			WoWPro:LoadGuide()
		else
			WoWPro.NextGuideDialog:Show()
		end
	end

	--WoWPro.need_UpdateGuide = nil

	local time_taken = debugprofilestop()
	if time_taken > max_time then
		err("WoWPro:UpdateGuide(%s), time_taken = %s",offset,time_taken)
		nb_error = nb_error + 1
		if nb_error > 3 then
			nb_error = 1
			max_time = max_time + 10
		end
	end

--WoWPro:Trace("End WoWPro:UpdateGuide")
end

end -- closure

-- Next Step --
-- Determines the next active step --
function WoWPro:NextStep(k,i)
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	local GID = WoWProDB.char.currentguide
	if not k then k = 1 end --k is the position in the guide
	if not i then i = 1 end --i is the position on the rows
	local skip = true
	while skip do repeat

		skip = false -- The step deaults to NOT skipped

		-- Quickly skip completed steps --
		if WoWProCharDB.Guide[GID].completion[k] then
			skip = true
			break
		end

		-- Optional Quests --
		if WoWPro.optional[k] and WoWPro.QID[k] then
			skip = true --Optional steps default to skipped --

			if WoWPro.QuestLog[WoWPro.QID[k]] then
				skip = false -- If the optional quest is in the quest log, it's NOT skipped --
				WoWPro.prereq[k] = false -- If the quest is in the log, the prereqs are already met no matter
												 -- what the guide say
			end
		end
		-- if skip then break end

		-- Skipping profession quests if their requirements aren't met --
		if WoWPro.prof[k] and not skip then
			local prof, profnum, proflvl, profmaxlvl, profmaxskill = string.split(";",WoWPro.prof[k])
			proflvl = tonumber(proflvl) or 1
			profmaxlvl = tonumber(profmaxlvl) or 700
			profmaxskill = tonumber(profmaxskill) or 700

			if prof and type(prof) == "string" and type(proflvl) == "number" then
				local hasProf = false
				skip = true --Profession steps skipped by default
				local profs = AcquireTable()
				profs[1], profs[2], profs[3], profs[4], profs[5], profs[6] = GetProfessions()
				for p=1,6 do
					if profs[p] then
						local skillName, _, skillRank, maxskill, _, _, skillnum = GetProfessionInfo(profs[p])
						if skillName == prof then
							if (skillRank >= proflvl) and (skillRank < profmaxlvl) and (maxskill < profmaxskill) then
								skip = false -- The step is NOT skipped if the skill is present at the correct level or higher
							end
							hasProf = true
						end
					end
				end
				-- Zero or max proflvl special skip logic
				if not hasProf and ((profmaxlvl < 700) or (profmaxskill < 700)) then skip = false end
				if WoWPro.action[k] == "A" and not hasProf then
				    -- If they do not have the profession, mark the step and quest as skipped
				    WoWProCharDB.Guide[GID].skipped[k] = true
				    WoWProCharDB.skippedQIDs[WoWPro.QID[k]] = true
				end
				ReleaseTable(profs)
			else
			    WoWPro:Print("Warning: malformed profession tag [%s] at step %d",WoWPro.prof[k],k)
			end
		end

		-- Skipping reputation quests if their requirements are met --
		if WoWPro.rep[k] and not skip then
			local rep, factionIndex, temprep, replvl = string.split(";",WoWPro.rep[k])
			if temprep == nil then temprep = "neutral-exalted" end
			local repID,repmax = string.split("-",temprep)
			if repmax== nil then repmax = repID end
			-- Canonicalize the case
			rep = rep:lower()
			factionIndex = tonumber(factionIndex)
			repID = repID:lower()
			repmax = repmax:lower()
			replvl = tonumber(replvl) or 0

			if repID == 'hated' then repID = 1 end
			if repID == 'hostile' then repID = 2 end
			if repID == 'unfriendly' then repID = 3 end
			if repID == 'neutral' then repID = 4 end
			if repID == 'friendly' then repID = 5 end
			if repID == 'honored' then repID = 6 end
			if repID == 'revered' then repID = 7 end
			if repID == 'exalted' then repID = 8 end

			if repmax == 'hated' then repmax = 1
			elseif repmax == 'hostile' then repmax = 2
			elseif repmax == 'unfriendly' then repmax = 3
			elseif repmax == 'neutral' then repmax = 4
			elseif repmax == 'friendly' then repmax = 5
			elseif repmax == 'honored' then repmax = 6
			elseif repmax == 'revered' then repmax = 7
			elseif repmax == 'exalted' then repmax = 8
			else repmax = 8 end

			skip = true --reputation steps skipped by default

			local _, _, standingId, bottomValue, _, earnedValue = GetFactionInfoByID(factionIndex)
			if (repID <= standingId) and (repmax >= standingId) and (replvl == 0) then
				skip = false
			end
			if (replvl > 0) then
				replvl = bottomValue + replvl
				if (repID > standingId) then
					skip = false
				end
				if (repID == standingId) and (earnedValue <= replvl) then
                            		skip = false
				end
			end
			-- Mark quests as skipped that we will assume will NEVER be done.
			if WoWPro.action[k] == "A" and standingId < 3 and repID > 3 and skip then
			    WoWProCharDB.Guide[GID].skipped[k] = true
			    WoWProCharDB.skippedQIDs[WoWPro.QID[k]] = true
			end
      end

		-- Skipping any quests with a greater completionist rank than the setting allows --
		if not skip and WoWPro.rank[k] then
			if tonumber(WoWPro.rank[k]) > WoWProDB.profile.rank then
				skip = true
			end
		end

		-- We call the module NextStep no matter what in case it wants to reverse the decision
		skip = WoWPro[WoWPro.Guides[GID].guidetype]:NextStep(k, skip)

		-- Skipping any manually skipped quests --
		if WoWProCharDB.Guide[GID].skipped[k] then
			skip = true
		elseif WoWProCharDB.skippedQIDs[WoWPro.QID[k]] then
			WoWProCharDB.Guide[GID].skipped[k] = true
			skip = true
		end

		-- Skipping any unstickies until it's time for them to display --
		if WoWPro.unsticky[k] and WoWPro.ActiveStickyCount and i > WoWPro.ActiveStickyCount+1 then
			skip = true
		end


		-- Check for conditions that must be chekced only for the current step
		-- Checking for |L| condition that are already met
		if not skip and WoWPro.lootitem[k] and
			GetItemCount(WoWPro.lootitem[k]) >= WoWPro.lootqty[k] then
			WoWProCharDB.Guide[GID].completion[k] = true
			skip = true
		end

		until true
		if skip then k = k+1 end

	end

	return k
end

-- Next Step Not Sticky --
-- Determines the next active step that isn't a sticky step (for mapping) --
function WoWPro:NextStepNotSticky(k)
	if not k then k = 1 end
	local sticky = true
	while sticky do
		sticky = false
		k = WoWPro:NextStep(k)
		if WoWPro.sticky[k] then
			sticky = true
			k = k + 1
		end
	end
	return k
end

-- Step Completion Tasks --
function WoWPro.CompleteStep(step, skipUIUpdate)
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	local GID = WoWProDB.char.currentguide
	if WoWProCharDB.Guide[GID].completion[step] then return end

	WoWProCharDB.Guide[GID].completion[step] = true

	--[==[
	local Delta = WoWPro:MapPointDelta()
	if Delta and ((WoWPro.action[step] == "C" and Delta[1] > 10) or Delta[1] > 1.9) then
	    local qid=-99
	    if WoWPro.QID[step] then
	        qid = WoWPro.QID[step]
	    end
	    local line = ("Action=%s|Step=%s|M0=%.2f,%.2f|M1=%.2f,%.2f|Error=%.2f|QID=%s|Vers=%s|Guide=%s"):format(WoWPro.action[step],WoWPro.step[step],Delta[2],Delta[3],Delta[4],Delta[5],Delta[1],qid,WoWPro.Version,GID)
	    table.insert(WoWProDB.global.Deltas, line)
	    WoWPro:dbp(line)
	else
	    WoWPro:dbp("Step Complete: "..WoWPro.step[step])
	end
	]==]

	if skipUIUpdate then
		-- No UI update is needed. We are probably in the process of loading a guide.
		return
	end

	if WoWProDB.profile.checksound then
		PlaySoundFile(WoWProDB.profile.checksoundfile)
	end
	for i,row in ipairs(WoWPro.rows) do
		if WoWProCharDB.Guide[GID].completion[row.index] then
			row.check:SetChecked(true)
		else
			row.check:SetChecked(false)
		end
	end

	WoWPro:MapPoint()
	WoWPro:UpdateGuide()
end

WoWPro.oldQuests = AcquireTable()
WoWPro.QuestLog = AcquireTable()

local abandoning
local orig = _G.AbandonQuest
_G.AbandonQuest = function(...)
	abandoning = true
	return orig(...)
end


-- Populate the Quest Log table for other functions to call on --
function WoWPro:PopulateQuestLog()
	local WoWProCharDB = WoWPro.CharDB
	--WoWPro:dbp("Populating quest log...")

	WoWPro.oldQuests, WoWPro.QuestLog = WoWPro.QuestLog, WoWPro.oldQuests

	WipeTable(WoWPro.QuestLog)
	local i = 1
	local entries = GetNumQuestLogEntries()
	for i=1,tonumber(entries) do
		local isHeader, _, _, _, questID = select(5,GetQuestLogTitle(i))
		if not isHeader then
			WoWPro.QuestLog[questID] = i
		end
	end

	if IsTableEmpty(WoWPro.oldQuests) then return end

	-- Generating table WoWPro.missingQuest --
	for QID, questInfo in pairs(WoWPro.oldQuests) do
		if not WoWPro.QuestLog[QID] then
			if not abandoning then
				-- It's a quest that has been completed
				if not WoWPro.MOP then WoWProCharDB.completedQIDs[QID] = true end
				WoWPro.abandonedQID = nil
			else
				WoWPro.abandonedQID = QID
			end
			abandoning = nil
		end
	end
end

-- Experimental Interface to Grail
function WoWPro:SkipAll()
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB
    WoWPro:Print("Marking All Quests as skipped")
    local GID = WoWProDB.char.currentguide
	for index=1, WoWPro.stepcount do
	    if not WoWProCharDB.Guide[GID].completion[index] then
	        WoWProCharDB.Guide[GID].skipped[index] = true
        end
    end
end

function WoWPro:DoQuest(qid)
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB
    if type(qid) == "table" then
        for  i,p in ipairs(qid) do
            WoWPro:Print("Marking 1:n QID %d for execution.",p)
            WoWPro:QuestPrereq(p)
        end
        return
    end
    WoWPro:Print("Marking QID %d for execution.",qid)
    local GID = WoWProDB.char.currentguide
	for index=1, WoWPro.stepcount do
	    if tonumber(WoWPro.QID[index]) == tonumber(qid) and not WoWProCharDB.Guide[GID].completion[index] then
	        WoWProCharDB.Guide[GID].skipped[index] = nil
        end
    end
end

function WoWPro:QuestPrereq(qid)
    WoWPro:DoQuest(qid)
    local preReq = _G.Grail:QuestPrerequisites(qid)
    if not preReq then return end
    for i,p in ipairs(preReq) do
        WoWPro:QuestPrereq(p)
    end
end

function WoWPro:Questline(qid)
    if not _G.Grail then return end
    WoWPro:SkipAll()
    WoWPro:QuestPrereq(qid)
end

-- /run WoWPro:Questline("26625")

------------------------
-- Functions to parse quests and log that used to be in module but really need to be in core
------------------------

-- Auto-Complete: Quest Update --
function WoWPro:AutoCompleteQuestUpdate(skipUIUpdate)
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	local GID = WoWProDB.char.currentguide
	if not GID or not WoWPro.Guides[GID] then return end

	if WoWProCharDB.Guide then
		local something_completed

		for i=1,#WoWPro.action do

			local action = WoWPro.action[i]
			local QID = WoWPro.QID[i]
			local completion = WoWProCharDB.Guide[GID].completion[i]

			-- A quest was just abandoned, all the related steps that were marked
			-- as completed need to be unmarked
			if WoWPro.abandonedQID == QID and
				( action == "A" or action == "C" ) and
				completion then

				WoWProCharDB.Guide[GID].completion[i] = nil
				completion = nil
				if not skipUIUpdate then
					WoWPro:UpdateGuide()
					WoWPro:MapPoint()
				end
			end

			if not completion then

				local quest_log_index = WoWPro.QuestLog[QID]

				-- Quest is flaged as completed in the completeQIDs table
				if QID and WoWPro.IsQuestFlaggedCompleted(QID) then
					WoWPro.CompleteStep(i, true)
					something_completed = true

				-- Quests that are in the current log have been accepted
				elseif action == "A" and quest_log_index then
					WoWPro.CompleteStep(i, true)
					something_completed = true

				-- Quest Completion: Any step that is not a Turn in is considered completed if the quest is completed --
				elseif action ~= "T" and quest_log_index and select(7,GetQuestLogTitle(quest_log_index)) == 1 then
					WoWPro.CompleteStep(i, true)
					something_completed = true

				-- We already have the flightpoint
				elseif action == "f" and WoWProCharDB.Taxi[WoWPro.step[i]] then
					WoWPro.CompleteStep(i, true)
					something_completed = true

				-- Partial Completion --
				elseif WoWPro.QuestLog[QID] and WoWPro.questtext[i] and quest_log_index and GetNumQuestLeaderBoards(quest_log_index) > 0 then
					local numquesttext = select("#", (";"):split(WoWPro.questtext[i]))
					local complete = true
					for l=1,numquesttext do
						local lquesttext = select(numquesttext-l+1, (";"):split(WoWPro.questtext[i]))
						lquesttext = lquesttext:match("(.+):")
						local lcomplete = false
						for j=1,GetNumQuestLeaderBoards(quest_log_index) do
							local itemtext, _, isdone = GetQuestLogLeaderBoard(j, quest_log_index)
							if itemtext and itemtext:match("(.+):") == lquesttext and isdone then
								lcomplete = true
								break
							end
						end
						if not lcomplete then complete = false end --if one of the listed objectives isn't complete, then the step is not complete.
					end
					if complete then
						WoWPro.CompleteStep(i, true)
						something_completed = true
					end --if the step has not been found to be incomplete, run the completion function
				end

			end
		end
		WoWPro.abandonedQID = nil

		if not skipUIUpdate and something_completed then
			if WoWProDB.profile.checksound then
				PlaySoundFile(WoWProDB.profile.checksoundfile)
			end
			for i,row in ipairs(WoWPro.rows) do
				if WoWProCharDB.Guide[GID].completion[row.index] then
					row.check:SetChecked(true)
				else
					row.check:SetChecked(false)
				end
			end

			WoWPro:UpdateGuide()
			WoWPro:MapPoint()
			WoWPro.FirstMapCall = nil
		end
	end


	-- First Map Point --
	if not skipUIUpdate and WoWPro.FirstMapCall then
		WoWPro:MapPoint()
		WoWPro.FirstMapCall = false
	end


end

-- Update Item Tracking --
local function GetLootTrackingInfo(lootitem, lootqty)
--[[Purpose: Creates a string containing:
	- tracked item's name
	- how many the user has
	- how many the user needs
	- a complete symbol if the ammount the user has the ammount they need
]]
	local track, numinbag = "" 								--If the function did have a track string, adds a newline
	track = GetItemInfo(lootitem)
	if not track then return "" end
	track = " - "..track..": " 								--Adds the item's name to the string
	numinbag = GetItemCount(lootitem)						--Finds the number in the bag, and adds a count if supplied
	track = track..numinbag										--Adds the number in bag to the string
	track = track.."/"..lootqty								--Adds the total number needed to the string
	if (tonumber(lootqty) or 1) <= numinbag then
		track = track.." (C)"									--If the user has the requisite number of items, adds a complete marker
	end
	return track, numinbag										--Returns the track string and the inventory count to the calling function
end

-- Update WoWPro Quest Tracker --
function WoWPro:UpdateQuestTracker()
	local WoWProDB = WoWPro.DB

	if not WoWPro.GuideFrame:IsVisible() then return end
	local GID = WoWProDB.char.currentguide
	if not GID or not WoWPro.Guides[GID] then return end

	for i,row in ipairs(WoWPro.rows) do
		local index = row.index
		local questtext = WoWPro.questtext[index]
		local action = WoWPro.action[index]
		local lootitem = WoWPro.lootitem[index]
		local lootqty = WoWPro.lootqty[index]

		local QID = WoWPro.QID[index]
		-- Setting up quest tracker --
		row.trackcheck = false
		local track = ""
		if WoWProDB.profile.track and ( action == "C" or questtext or lootitem) then
			if WoWPro.QuestLog[QID] and GetNumQuestLeaderBoards(WoWPro.QuestLog[QID]) > 0 then
				local j = WoWPro.QuestLog[QID]
				row.trackcheck = true
				if not questtext and action == "C" then
					for l=1,GetNumQuestLeaderBoards(j) do
						local itemtext, _, isdone = GetQuestLogLeaderBoard(l, j)
						track = ("%s%s- %s%s"):format(track, l>1 and "\n" or "", itemtext, isdone and " (C)" or "")
					end
				elseif questtext then --Partial completion steps only track pertinent objective.
					local numquesttext = select("#", (";"):split(questtext))
					for l=1,numquesttext do
						local lquesttext = select(numquesttext-l+1, (";"):split(questtext))
						local litemname = lquesttext:match("(.+):") -- Everything before the : is the item name
						for m=1,GetNumQuestLeaderBoards(j) do
							if GetQuestLogLeaderBoard(m, j) then
								local itemtext, _, isdone = GetQuestLogLeaderBoard(m, j)
								local itemName = itemtext:match("(.+):") -- Everything before the : is the item name
								if itemName and itemName == litemname then
									track = ("%s%s- %s%s"):format(track, l>1 and "\n" or "", itemtext, isdone and " (C)" or "")
								end
							end
						end
					end
				end
			end
			if lootitem then
				row.trackcheck = true
				lootqty = tonumber(lootqty) or 1
				track = GetLootTrackingInfo(lootitem, lootqty)
			end
		end
		row.track:SetText(track)
	end
	if not InCombatLockdown() then WoWPro:RowSizeSet(); WoWPro:PaddingSet() end
end

-- Update the Loot line that are displayed based on actual count found in the inventory
-- and mark the step as complete if we have the minimum number required
function WoWPro:UpdateLootLines()
	for i = 1,1+WoWPro.ActiveStickyCount do
		local guide_index = WoWPro.rows[i].index
		if WoWPro.DB.profile.track and WoWPro.lootitem[guide_index] then
			-- Update the displayed text
			local lootqty = WoWPro.lootqty[guide_index]
			local track, numinbag = GetLootTrackingInfo(WoWPro.lootitem[guide_index], lootqty)
			WoWPro.rows[i].track:SetText(track)

			-- Was it completed?
			if numinbag >= lootqty then
				WoWPro.CompleteStep(guide_index)
			end
		end
	end
	if not InCombatLockdown() then WoWPro:RowSizeSet(); WoWPro:PaddingSet() end
end

-- Auto-Complete: Set hearth and quests that complete without any effect on the quest log --
local HOME_MSG = '^' .. _G.ERR_DEATHBIND_SUCCESS_S:format('(.*)') .. '$' -- Build localized: "^(.*) is now your home.$"
local QUEST_MSG = '^' .. _G.ERR_QUEST_COMPLETE_S:format('(.+)') .. '$'   -- Build localized: "^(.+) completed.$"
function WoWPro:CHAT_MSG_SYSTEM_parser(msg, ...)
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	local quest = msg:match(QUEST_MSG)
	if quest then
		local qid = GetQuestID()
		if qid and WoWPro.CompletingQuestQID and qid == WoWPro.CompletingQuestQID then
			-- A quest has been completed, we mark it in the completedQID table and
			-- provoque a log update in case the quest was in the log
			-- CompletingQuestQID was set when we got the QUEST_COMPLETE message
			-- GetQuestID() is to verify that no other quest were completed since then
			-- It's probably a bit overkill.
			WoWPro.CompletingQuestQID = nil
			if not WoWPro.MOP then WoWProCharDB.completedQIDs[qid] = true end
			WoWPro:QUEST_LOG_UPDATE_bucket()
		end
	else
		local loc = msg:match(HOME_MSG)
		if loc then
			-- The user has set his Hearth to a new location, we save it
			-- and check if we have a step that is completed
			WoWProCharDB.Guide.hearth = loc
			for i = 1,15 do -- This need work but it's not used very often
				local index = WoWPro.rows[i].index
				if WoWPro.action[index] == "h" and WoWPro.step[index] == loc
				and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
					WoWPro.CompleteStep(index)
				end
			end
		end
	end
end

-- Auto-Complete: Level based --
function WoWPro:AutoCompleteLevel(...)
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	local newlevel = ... or UnitLevel("player")
	if WoWProCharDB.Guide then
		local GID = WoWProDB.char.currentguide
		if not WoWProCharDB.Guide[GID] then return end
		for i=1,WoWPro.stepcount do
			if not WoWProCharDB.Guide[GID].completion[i]
				and WoWPro.level[i]
				and tonumber(WoWPro.level[i]) <= newlevel then
					WoWPro.CompleteStep(i)
			end
		end
	end
end

-- Auto-Complete: Zone based --
function WoWPro:AutoCompleteZone()
	if not WoWPro.action then return end
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	WoWPro.ActiveStickyCount = WoWPro.ActiveStickyCount or 0
	local currentindex = WoWPro.rows[1+WoWPro.ActiveStickyCount].index
	local action = WoWPro.action[currentindex]
	local step = WoWPro.step[currentindex]
	local coord = WoWPro.map[currentindex]
	local waypcomplete = WoWPro.waypcomplete[currentindex]
	local zonetext, subzonetext = GetZoneText(), GetSubZoneText():trim()
	if action == "F" or action == "H" or action == "b" or (action == "R" and not waypcomplete) then
		if step == zonetext or step == subzonetext
		and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[currentindex] then
			WoWPro.CompleteStep(currentindex)
		end
	end
end

-- Learn the FP from the opened taxi window
function WoWPro:RecordTaxiLocations(...)
	local WoWProCharDB = WoWPro.CharDB

	for i = 1, NumTaxiNodes() do
		local nomen = TaxiNodeName(i)
		local location,zone = (","):split(nomen)
		if not WoWProCharDB.Taxi[location] then
			WoWProCharDB.Taxi[location] = true
			WoWPro:Print("Discovered Flight Point: [%s]",location)
		end
	end
end

-- Auto-Complete: Get flight point --
function WoWPro:AutoCompleteGetFP(...)
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	for i = 1,15 do
		local index = WoWPro.rows[i].index
		if ... == _G.ERR_NEWTAXIPATH and WoWPro.action[index] == "f"
		and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
			WoWPro.CompleteStep(index)
		end
	end
end

