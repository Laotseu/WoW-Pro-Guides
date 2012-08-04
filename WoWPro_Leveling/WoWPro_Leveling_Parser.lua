-------------------------------------------------------------------------------
-- Localized Lua globals
-------------------------------------------------------------------------------
local _G = getfenv(0)

local _
local assert							= _G.assert
local floor								= _G.floor
local format							= _G.format
local gsub								= _G.gsub
local max								= _G.max
local setmetatable					= _G.setmetatable
local strfind							= _G.strfind
local strreplace						= _G.strreplace
local strsplit							= _G.strsplit
local strtrim							= _G.strtrim
local strupper							= _G.strupper
local tonumber							= _G.tonumber
local tostring							= _G.tostring
local type								= _G.type

local table								= _G.table
local ipairs							= _G.ipairs
local pairs								= _G.pairs
local select							= _G.select
local tinsert							= _G.tinsert
local wipe								= _G.wipe

local ERR_NEWTAXIPATH				= _G.ERR_NEWTAXIPATH

local AcceptQuest						= _G.AcceptQuest
local ClearOverrideBindings		= _G.ClearOverrideBindings
local CompleteQuest					= _G.CompleteQuest
local CreateFrame						= _G.CreateFrame
local GetActiveTitle					= _G.GetActiveTitle
local GetAvailableTitle				= _G.GetAvailableTitle
local GetBindingKey					= _G.GetBindingKey
local GetItemCooldown				= _G.GetItemCooldown
local GetItemCount					= _G.GetItemCount
local GetItemIcon						= _G.GetItemIcon
local GetItemInfo						= _G.GetItemInfo
local GetNumActiveQuests			= _G.GetNumActiveQuests
local GetNumAvailableQuests		= _G.GetNumAvailableQuests
local GetNumPartyMembers			= _G.GetNumPartyMembers
local GetNumQuestChoices			= _G.GetNumQuestChoices
local GetNumQuestLeaderBoards 	= _G.GetNumQuestLeaderBoards
local GetNumQuestLogEntries 		= _G.GetNumQuestLogEntries
local GetQuestID 						= _G.GetQuestID
local GetQuestLink 					= _G.GetQuestLink
local GetQuestLogLeaderBoard 		= _G.GetQuestLogLeaderBoard
local GetQuestLogSpecialItemInfo	= _G.GetQuestLogSpecialItemInfo
local GetQuestReward					= _G.GetQuestReward
local GetSpellAvailableLevel 		= _G.GetSpellAvailableLevel
local GetSpellBookItemInfo 		= _G.GetSpellBookItemInfo
local GetSpellBookItemName 		= _G.GetSpellBookItemName
local GetSubZoneText 				= _G.GetSubZoneText
local GetTitleText 					= _G.GetTitleText
local GetZoneText 					= _G.GetZoneText
local InCombatLockdown 				= _G.InCombatLockdown
local IsInInstance 					= _G.IsInInstance
local PlaySoundFile 					= _G.PlaySoundFile
local QuestLogPushQuest 			= _G.QuestLogPushQuest
local QuestLog_OpenToQuest 		= _G.QuestLog_OpenToQuest
local QuestMapUpdateAllQuests 	= _G.QuestMapUpdateAllQuests
local QuestPOIGetIconInfo 			= _G.QuestPOIGetIconInfo
local QuestPOIUpdateIcons 			= _G.QuestPOIUpdateIcons
local SelectActiveQuest 			= _G.SelectActiveQuest
local SelectAvailableQuest 		= _G.SelectAvailableQuest
local SelectGossipActiveQuest 	= _G.SelectGossipActiveQuest
local SelectGossipAvailableQuest	= _G.SelectGossipAvailableQuest
local SetOverrideBinding 			= _G.SetOverrideBinding
local UnitClass 						= _G.UnitClass
local UnitFactionGroup 				= _G.UnitFactionGroup
local UnitLevel 						= _G.UnitLevel
local UnitRace 						= _G.UnitRace
local UnitSex 							= _G.UnitSex

local WoWPro_Locale 					= _G.WoWPro_Locale

local LibStub 							= _G.LibStub

local err_params = {}
local function err(msg, ...)
	msg = tostring(msg)
	wipe(err_params)
	for i=1,select('#',...) do err_params[i] = tostring(select(i,...)) end
	_G.geterrorhandler()(msg:format(_G.unpack(err_params)) .. " - " .. _G.time())
end

--_G.perr = true

--------------------------------------
--      WoWPro_Leveling_Parser      --
--------------------------------------

local WoWPro = LibStub("AceAddon-3.0"):GetAddon("WoWPro")

local L = WoWPro_Locale
WoWPro.Leveling.actiontypes = {
	A = "Interface\\GossipFrame\\AvailableQuestIcon",
	C = "Interface\\Icons\\Ability_DualWield",
	T = "Interface\\GossipFrame\\ActiveQuestIcon",
	K = "Interface\\Icons\\Ability_Creature_Cursed_02",
	R = "Interface\\Icons\\Ability_Tracking",
	H = "Interface\\Icons\\INV_Misc_Rune_01",
	h = "Interface\\AddOns\\WoWPro\\Textures\\resting.tga",
	F = "Interface\\Icons\\Ability_Druid_FlightForm",
	f = "Interface\\Icons\\Ability_Hunter_EagleEye",
	N = "Interface\\Icons\\INV_Misc_Note_01",
	B = "Interface\\Icons\\INV_Misc_Coin_01",
	b = "Interface\\Icons\\Spell_Frost_SummonWaterElemental",
	U = "Interface\\Icons\\INV_Misc_Bag_08",
	L = "Interface\\Icons\\Spell_ChargePositive",
	l = "Interface\\Icons\\INV_Misc_Bag_08",
	r = "Interface\\Icons\\Ability_Repair"
}
WoWPro.Leveling.actionlabels = {
	A = "Accept",
	C = "Complete",
	T = "Turn in",
	K = "Kill",
	R = "Run to",
	H = "Hearth to",
	h = "Set hearth to",
	F = "Fly to",
	f = "Get flight path for",
	N = "Note:",
	B = "Buy",
	b = "Boat or Zeppelin",
	U = "Use",
	L = "Level",
	l = "Loot",
	r = "Repair/Restock"
}

-- Determine Next Active Step (Leveling Module Specific)--
-- This function is called by the main NextStep function in the core broker --
function WoWPro.Leveling:NextStep(k, skip)
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	local GID = WoWProDB.char.currentguide

	-- Optional Quests --
	if WoWPro.optional[k] and WoWPro.QID[k] then

		-- Checking Quest Log --
		if WoWPro.QuestLog[WoWPro.QID[k]] then
			skip = nil	 					-- If the optional quest is in the quest log, it's NOT skipped --
			WoWPro.prereq[k] = nil		-- If the quest is in the log, the prereqs must already be met no matter
												-- what the guide say
		--end

		-- Checking Prerequisites --
		elseif WoWPro.prereq[k] then
			skip = nil						-- defaulting to NOT skipped

			local numprereqs = select("#", (";"):split(WoWPro.prereq[k]))
			for j=1,numprereqs do
				local jprereq = select(numprereqs-j+1, strsplit(";", WoWPro.prereq[k]))
				if not WoWPro.IsQuestFlaggedCompleted(tonumber(jprereq)) then
					skip = true -- If one of the prereqs is NOT complete, step is skipped.
				end
			end

			-- If it is skipped, mark the quest as skipped
			if skip then
				if WoWPro.action[k] == "A"
				or WoWPro.action[k] == "C"
				or WoWPro.action[k] == "T" then
					WoWProCharDB.skippedQIDs[WoWPro.QID[k]] = true
					WoWProCharDB.Guide[GID].skipped[k] = true
				else
					WoWProCharDB.Guide[GID].skipped[k] = true
				end
			end
		end
	end

	-- Skipping quests with prerequisites if their prerequisite was skipped --
	if WoWPro.prereq[k]
	and not WoWPro.IsQuestFlaggedCompleted(k)
	and not WoWProCharDB.Guide[GID].skipped[k]
	and not WoWProCharDB.skippedQIDs[WoWPro.QID[k]] then
		local numprereqs = select("#", strsplit(";", WoWPro.prereq[k]))
		for j=1,numprereqs do
			local jprereq = select(numprereqs-j+1, strsplit(";", WoWPro.prereq[k]))
			if WoWProCharDB.skippedQIDs[tonumber(jprereq)] then
				skip = true
				-- If their prerequisite has been skipped, skipping any dependant quests --
				if WoWPro.action[k] == "A"
				or WoWPro.action[k] == "C"
				or WoWPro.action[k] == "T" then
					WoWProCharDB.skippedQIDs[WoWPro.QID[k]] = true
					WoWProCharDB.Guide[GID].skipped[k] = true
				else
					WoWProCharDB.Guide[GID].skipped[k] = true
				end
			end
		end
	end

	-- Skipping L steps if we are already past the level
	if WoWPro.action[k] == "L" and WoWPro.level[k] then
	    if tonumber(WoWPro.level[k]) <= UnitLevel("player") then
		    skip = true
	    end
	end

	return skip
end

-- Skip a step --
do -- closure

-- Creating a local function in another function is like creating a table,
-- it creates garbage. Best to create it only once.
-- Even better, replace with a while loop (todo)
local steplist = ""
local function skipPrereqSteps(WoWPro, WoWProCharDB, GID, QID)
	if not QID then return end

	WoWProCharDB.skippedQIDs[QID] = true

	for j = 1,WoWPro.stepcount do
		if WoWPro.QID[j] == QID then
			WoWProCharDB.Guide[GID].skipped[j] = true
		end

		if WoWPro.prereq[j] then
			local numprereqs = select("#", (";"):split(WoWPro.prereq[j]))
			for k=1,numprereqs do
				local kprereq = select(numprereqs-k+1, (";"):split(WoWPro.prereq[j]))
				if tonumber(kprereq) == QID then

					if WoWPro.action[j] == "A" or
						WoWPro.action[j] == "C" or
						WoWPro.action[j] == "T" then

						-- The QID was used in the |PRE| tag for another line,
						-- we have a new QID to skip
						skipPrereqSteps(WoWPro, WoWProCharDB, GID, WoWPro.QID[j])

					end

					steplist = steplist.."- "..WoWPro.step[j].."\n"
				end
			end
		end
	end
end

function WoWPro.Leveling:SkipStep(index)
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	local GID = WoWProDB.char.currentguide

	WoWProCharDB.Guide[GID].skipped[index] = true

	steplist = ""
	if WoWPro.action[index] == "A" or
		WoWPro.action[index] == "C" or
		WoWPro.action[index] == "T" then

		-- A step has been skiped, it's possible that it was a prereq for
		-- another step. We must loop the step list to find and skip all the
		-- others with that QID as a prereq. Each new step skiped can also be
		-- a prereq to another and so, the list must be looped again.
		skipPrereqSteps(WoWPro, WoWProCharDB, GID, WoWPro.QID[index])

	end


	WoWPro:MapPoint()
	return steplist
end

end -- closure

-- Unskip a step --
do -- closure

local function unskipPrereqSteps(WoWPro, WoWProCharDB, GID, QID)
	if not QID then return end

	WoWProCharDB.skippedQIDs[QID] = nil

	for j = 1,WoWPro.stepcount do

		if WoWPro.QID[j] and QID == WoWPro.QID[j] then
			WoWProCharDB.Guide[GID].skipped[j] = nil
		end

		if WoWPro.prereq[j] then
			local numprereqs = select("#", (";"):split(WoWPro.prereq[j]))
			for k=1,numprereqs do
				local kprereq = select(numprereqs-k+1, (";"):split(WoWPro.prereq[j]))
				if tonumber(kprereq) == QID then
					WoWProCharDB.Guide[GID].skipped[j] = nil
					if WoWPro.action[j] == "A" or
						WoWPro.action[j] == "C" or
						WoWPro.action[j] == "T" then

						-- We just unstickied a |PRE|, we must unstick the dep.
						unskipPrereqSteps(WoWPro, WoWProCharDB, GID, WoWPro.QID[j])
					end
				end
			end
		end
	end
end

function WoWPro.Leveling:UnSkipStep(index)
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	local GID = WoWProDB.char.currentguide
	WoWProCharDB.Guide[GID].completion[index] = nil
	WoWProCharDB.Guide[GID].skipped[index] = nil

	if WoWPro.QID[index] and
		( WoWPro.action[index] == "A" or
		  WoWPro.action[index] == "C" or
		  WoWPro.action[index] == "T" ) then

		WoWProCharDB.skippedQIDs[WoWPro.QID[index]] = nil
		unskipPrereqSteps(WoWPro, WoWProCharDB, GID, WoWPro.QID[index])

	end

	WoWPro:UpdateGuide()
	WoWPro:MapPoint()
end

end -- closure

-- Quest parsing function --
local function ParseQuests(...)
--WoWPro:Trace("Start ParseQuests")
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	WoWPro:dbp("Parsing Guide...")
	local i = 1
	local myclassL, myclass = UnitClass("player")
	local myraceL, myrace = UnitRace("player")
	if myrace == "Scourge" then
		myrace = "Undead"
	end
	for j=1,select("#", ...) do
		local text = select(j, ...)
		text = text:trim()
		if text ~= "" and text:sub(1,1) ~= ";" then
			local class, race, gender, faction = text:match("|C|([^|]*)|?"), text:match("|R|([^|]*)|?"), text:match("|GEN|([^|]*)|?"), text:match("|FACTION|([^|]*)|?")
			if class then
				-- deleting whitespaces and capitalizing, to compare with Blizzard's class tokens
				class = (class:gsub(" ", "")):upper()
			end
			if race then
				-- deleting whitespaces to compare with Blizzard's race tokens
				race = race:gsub(" ", "")
			end
			if gender then
				-- deleting leading/trailing whitespace and then canonicalize the case
				gender = (gender:trim()):upper()
				-- map the text to the gender code
				if gender == "FEMALE" then
					gender = 3
				elseif gender == "MALE" then
					gender = 2
				else
					gender = 1
				end
			end
			if faction then
				-- deleting leading/trailing whitespace and then canonicalize the case
				faction = (faction:trim()):upper()
            end
			if class == nil or class:find(myclass) then if race == nil or race:find(myrace) then if gender == nil or gender == UnitSex("player") then if faction == nil or faction == (UnitFactionGroup("player")):upper() then
				WoWPro.action[i], WoWPro.step[i] = select(3, text:find("^(%a) ([^|]*)(.*)"))
				WoWPro.step[i] = WoWPro.step[i]:trim()
				WoWPro.stepcount = WoWPro.stepcount + 1
				WoWPro.QID[i] = tonumber(text:match("|QID|([^|]*)|?"))
				WoWPro.note[i] = text:match("|N|([^|]*)|?")
				WoWPro.map[i] = text:match("|M|([^|]*)|?")
				if text:find("|S|") then
					WoWPro.sticky[i] = true;
					WoWPro.stickycount = WoWPro.stickycount + 1
				end
				if text:find("|US|") then WoWPro.unsticky[i] = true end
				WoWPro.use[i] = text:match("|U|([^|]*)|?")
				WoWPro.zone[i] = text:match("|Z|([^|]*)|?")
				if tonumber(WoWPro.zone[i]) then WoWPro.zone[i] = tonumber(WoWPro.zone[i]) end
				if WoWPro.zone[i] and not WoWPro:ValidZone(WoWPro.zone[i]) then
					local line =("Vers=%s|Guide=%s|Line=%s"):format(WoWPro.Version,WoWProDB.char.currentguide,text)
					WoWProDB.global.ZoneErrors = WoWProDB.global.ZoneErrors or {}
					tinsert(WoWProDB.global.ZoneErrors, line)
					WoWPro:dbp("Invalid Z tag in:"..text)
					WoWPro.zone[i] = nil
				end
				WoWPro.lootitem[i], WoWPro.lootqty[i] = select(3, text:find("|L|(%d+)%s?(%d*)|"))
				WoWPro.lootitem[i] = tonumber(WoWPro.lootitem[i])
				WoWPro.lootqty[i] = WoWPro.lootitem[i] and (tonumber(WoWPro.lootqty[i]) or 1) or nil
				WoWPro.questtext[i] = text:match("|QO|([^|]*)|?")
				if text:find("|O|") then
					WoWPro.optional[i] = true
					WoWPro.optionalcount = WoWPro.optionalcount + 1
				end
				WoWPro.prereq[i] = text:match("|PRE|([^|]*)|?")

				if (WoWPro.action[i] == "R" or WoWPro.action[i] == "r" or WoWPro.action[i] == "N") and WoWPro.map[i] then
					if text:find("|CC|") then WoWPro.waypcomplete[i] = 1
					elseif text:find("|CS|") then WoWPro.waypcomplete[i] = 2
					else WoWPro.waypcomplete[i] = false end
				end

				if text:find("|NC|") then WoWPro.noncombat[i] = true end
				WoWPro.level[i] = text:match("|LVL|([^|]*)|?")
				WoWPro.leadin[i] = text:match("|LEAD|([^|]*)|?")
				WoWPro.target[i] = text:match("|T|([^|]*)|?")
                                    WoWPro.rep[i] = text:match("|REP|([^|]*)|?")
				WoWPro.prof[i] = text:match("|P|([^|]*)|?")
				WoWPro.rank[i] = text:match("|RANK|([^|]*)|?")

--				for _,tag in pairs(WoWPro.Tags) do
--					if not WoWPro[tag][i] then WoWPro[tag][i] = false end
--				end

				i = i + 1
			end end end end
		end
	end
--WoWPro:Trace("End ParseQuests")
end

-- Guide Load --
function WoWPro.Leveling:LoadGuide()
--WoWPro:Trace("Start WoWPro.Leveling:LoadGuide: "..tostring(WoWPro.DB.char.currentguide))
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	local GID = WoWProDB.char.currentguide

	-- Parsing quests --
	local sequence = WoWPro.Guides[GID].sequence
	ParseQuests(strsplit("\n", sequence()))

	WoWPro:dbp("Guide Parsed. "..WoWPro.stepcount.." steps registered.")

	WoWPro:PopulateQuestLog() --Calling this will populate our quest log table for use here

	-- Checking to see if any steps are already complete wihtout updating the GUI --
	WoWPro:AutoCompleteQuestUpdate(true)

--[[
	for i=1, WoWPro.stepcount do
		local QID = WoWPro.QID[i]
		local action = WoWPro.action[i]
		local completion = WoWProCharDB.Guide[GID].completion[i]
		local level = WoWPro.level[i]

		    -- Turned in quests --
		if WoWProCharDB.completedQIDs then
			if WoWProCharDB.completedQIDs[QID] then
				WoWProCharDB.Guide[GID].completion[i] = true
			end
		end

		    -- Quest Accepts and Completions --
		if not completion and WoWPro.QuestLog[QID] then
			if action == "A" then WoWProCharDB.Guide[GID].completion[i] = true end
			if action == "C" and WoWPro.QuestLog[QID].complete then
				WoWProCharDB.Guide[GID].completion[i] = true
			end
		end

		    -- Checking level based completion --
		if not completion and level and tonumber(level) <= UnitLevel("player") then
			WoWProCharDB.Guide[GID].completion[i] = true
		end

	end
]]
	WoWPro:UpdateGuide()

	-- Checking zone based completion --
	WoWPro:AutoCompleteZone()

	-- Update the display using the leaderboard
	WoWPro:UpdateQuestTracker()

	-- Scrollbar Settings --
	WoWPro.Scrollbar:SetMinMaxValues(1, max(1, WoWPro.stepcount - WoWPro.ShownRows))

	-- Set the arrow
	WoWPro:MapPoint()
	WoWPro.FirstMapCall = false

	-- Audio feedback to tell the user it's done
	if WoWProDB.profile.checksound then
		PlaySoundFile(WoWProDB.profile.checksoundfile)
	end

--WoWPro:Trace("End WoWPro.Leveling:LoadGuide: "..tostring(WoWPro.DB.char.currentguide))
end

-- Functions used by dropdown menus
local function _MapGuideCoordinate(self, row_num)
	--err("row_num=%s",row_num)
	WoWPro:MapPoint(row_num)
end

local function _MapBlizCoordinate(self, row_num)
	--err("row_num=%s",row_num)
	WoWPro:MapPoint(row_num, true)
end

local function _ShareQuest(self, quest_index)
	--err("quest_index=%s",quest_index)
	QuestLogPushQuest(quest_index)
end

local function _UnSticky(self, row_index)
	--err("row_index=%s",row_index)
	WoWPro.sticky[row_index] = false
--	WoWPro.UpdateGuide()
	WoWPro.UpdateGuide()
	WoWPro.MapPoint()
end

local function _Sticky(self, row_index)
	--err("row_index=%s",row_index)
	WoWPro.sticky[row_index] = true
	WoWPro.unsticky[row_index] = false
--	WoWPro.UpdateGuide()
	WoWPro.UpdateGuide()
	WoWPro.MapPoint()
end

-- Checkbox Function --
function WoWPro.Leveling:CheckFunction(row, button, down)
	row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	if button == "LeftButton" and row.check:GetChecked() then
		local steplist = WoWPro.Leveling:SkipStep(row.index)
		row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
		if steplist ~= "" then
			WoWPro:SkipStepDialogCall(row.index, steplist)
		end
	elseif button == "RightButton" and row.check:GetChecked() then
		WoWPro.CharDB.Guide[WoWPro.DB.char.currentguide].completion[row.index] = true
		WoWPro:MapPoint()
		if WoWPro.DB.profile.checksound then
			PlaySoundFile(WoWPro.DB.profile.checksoundfile)
		end
	elseif not row.check:GetChecked() then
		WoWPro.Leveling:UnSkipStep(row.index)
	end
	WoWPro:UpdateGuide()
end

-- Row Content Update --
function WoWPro.Leveling:RowUpdate(offset)
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	local GID = WoWProDB.char.currentguide
	if InCombatLockdown()
		or not GID
		or not WoWPro.Guides[GID]
		then return
	end
	WoWPro.ActiveStickyCount = 0
	local reload = false
	local lootcheck = true
	local k = offset or WoWPro.ActiveStep
	local itemkb = false
	local targetkb = false
	ClearOverrideBindings(WoWPro.MainFrame)
	--WoWPro.Leveling.RowDropdownMenu = {}
	WoWPro.ReleaseTable(WoWPro.Leveling.RowDropdownMenu)
	WoWPro.Leveling.RowDropdownMenu = WoWPro.AcquireTable()

	QuestMapUpdateAllQuests()
	QuestPOIUpdateIcons()
	for i=1,15 do

		-- Skipping any skipped steps, unsticky steps, and optional steps unless it's time for them to display --
		if not WoWProDB.profile.guidescroll then
			k = WoWPro:NextStep(k, i)
		end

		--Loading Variables --
		local row = WoWPro.rows[i]
		row.index = k
		row.num = i
		local step = WoWPro.step[k]
		local action = WoWPro.action[k]
		local note = WoWPro.note[k]
		local QID = WoWPro.QID[k]
		local coord = WoWPro.map[k]
		local sticky = WoWPro.sticky[k]
		local unsticky = WoWPro.unsticky[k]
		local use = WoWPro.use[k]
		local zone = WoWPro.zone[k]
		local lootitem = WoWPro.lootitem[k]
		local lootqty = WoWPro.lootqty[k]
		local questtext = WoWPro.questtext[k]
		local optional = WoWPro.optional[k]
		local prereq = WoWPro.prereq[k]
		local leadin = WoWPro.leadin[k]
		local target = WoWPro.target[k]
		if WoWPro.prof[k] then
			local prof, proflvl = strsplit(" ", WoWPro.prof[k])
		end
		local completion = WoWProCharDB.Guide[GID].completion

		-- Checking off lead in steps --
		if leadin and WoWPro.IsQuestFlaggedCompleted(tonumber(leadin)) and not completion[k] then
			completion[k] = true
			return true --reloading
		end

		-- Unstickying stickies --
		if unsticky and i == WoWPro.ActiveStickyCount+1 then
			for n,row in ipairs(WoWPro.rows) do
				if step == row.step:GetText() and WoWPro.sticky[row.index] and not completion[row.index] then
					completion[row.index] = true
					return true --reloading
				end
			end
		end

		-- Counting stickies that are currently active (at the top) --
		if sticky and i == WoWPro.ActiveStickyCount+1 and not completion[k] then
			WoWPro.ActiveStickyCount = WoWPro.ActiveStickyCount+1
		end

		-- Getting the image and text for the step --
		row.step:SetText(step)
		if step then row.check:Show() else row.check:Hide() end
		if completion[k] or WoWProCharDB.Guide[GID].skipped[k] or WoWProCharDB.skippedQIDs[WoWPro.QID[k]] then
			row.check:SetChecked(true)
			if WoWProCharDB.Guide[GID].skipped[k] or WoWProCharDB.skippedQIDs[WoWPro.QID[k]] then
				row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
			else
				row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
			end
		else
			row.check:SetChecked(false)
			row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		end
		if note then note = strtrim(note) note = gsub(note,"\\n","\n") end
		if WoWProDB.profile.showcoords and coord and note then note = note.." ("..coord..")" end
		if WoWProDB.profile.showcoords and coord and not note then note = "("..coord..")" end
		if not ( WoWProDB.profile.showcoords and coord ) and not note then note = "" end
		row.note:SetText(note)
		row.action:SetTexture(WoWPro.Leveling.actiontypes[action])
		if WoWPro.noncombat[k] and WoWPro.action[k] == "C" then
			row.action:SetTexture("Interface\\AddOns\\WoWPro\\Textures\\Config.tga")
		end

		row.check:SetScript("OnClick", function(self, button, down)
			WoWPro.Leveling:CheckFunction(row, button, down)
		end)

		-- Right-Click Drop-Down --
		--local dropdown = {
		--}
		local dropdown = WoWPro.AcquireTable()
		if step then
			--table.insert(dropdown,
			--	{text = step.." Options", notCheckable = true, isTitle = true}
			--)
			local tbl = WoWPro.AcquireTable()
			tbl.text 			= step.." Options"
			tbl.notCheckable 	= true
			tbl.isTitle 		= true
			tinsert(dropdown, tbl)

			local _, x, y, obj
			if coord or x then
				--table.insert(dropdown,
				--	{text = "Map Coordinates", notCheckable = true, func = function()
				--		WoWPro:MapPoint(row.num)
				--	end}
				--)
				local tbl = WoWPro.AcquireTable()
				tbl.text 			= "Map Coordinates"
				tbl.notCheckable 	= true
				tbl.arg1				= row.num
				tbl.func 			= _MapGuideCoordinate
				tinsert(dropdown, tbl)
			end
			if QID then _, x, y, obj = QuestPOIGetIconInfo(QID) end
			if x and y then
				local tbl = WoWPro.AcquireTable()
				tbl.text 			= "Map Blizard Coordinates"
				tbl.notCheckable 	= true
				tbl.arg1				= row.num
				tbl.func 			= _MapBlizCoordinate
				tinsert(dropdown, tbl)
			end
			if WoWPro.QuestLog[QID] and GetNumPartyMembers() > 0 then
				local tbl = WoWPro.AcquireTable()
				tbl.text 			= "Share Quest"
				tbl.notCheckable 	= true
				tbl.arg1				= WoWPro.QuestLog[QID]
				tbl.func 			= _ShareQuest
				tinsert(dropdown, tbl)
			end
			if sticky then
				local tbl = WoWPro.AcquireTable()
				tbl.text 			= "Un-Sticky"
				tbl.notCheckable 	= true
				tbl.arg1				= row.index
				tbl.func				= _UnSticky
				tinsert(dropdown, tbl)
			else
				local tbl = WoWPro.AcquireTable()
				tbl.text 			= "Make Sticky"
				tbl.notCheckable 	= true
				tbl.arg1				= row.index
				tbl.func				= _Sticky
				tinsert(dropdown, tbl)
			end
		end
		WoWPro.Leveling.RowDropdownMenu[i] = dropdown

		-- Item Button --
		if action == "H" then use = 6948 end
		if ( not use ) and action == "C" and WoWPro.QuestLog[QID] then
			local link, icon, charges = GetQuestLogSpecialItemInfo(WoWPro.QuestLog[QID])
			if link then
				local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = strfind(link, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
				use = Id
				WoWPro.use[k] = use
			end
		end

		if use and GetItemInfo(use) then
			row.itembutton.item_id = use
			row.itembutton:Show()
			row.itemicon:SetTexture(GetItemIcon(use))
			row.itembutton:SetAttribute("type1", "item")
			row.itembutton:SetAttribute("item1", "item:"..use)
			row.cooldown:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
			row.cooldown:SetScript("OnEvent", function()
					local start, duration, enabled = GetItemCooldown(use)
					if enabled then
						row.cooldown:Show()
						row.cooldown:SetCooldown(start, duration)
					else row.cooldown:Hide() end
				end)
			local start, duration, enabled = GetItemCooldown(use)
			if enabled then
				row.cooldown:Show()
				row.cooldown:SetCooldown(start, duration)
			else row.cooldown:Hide() end
--			if not itemkb and row.itembutton:IsVisible() then
			if row.itembutton:IsVisible() then
				local key1, key2 = GetBindingKey("CLICK WoWPro_FauxItemButton:LeftButton")
				if key1 then
					SetOverrideBinding(WoWPro.MainFrame, false, key1, "CLICK WoWPro_itembutton"..i..":LeftButton")
				end
				if key2 then
					SetOverrideBinding(WoWPro.MainFrame, false, key2, "CLICK WoWPro_itembutton"..i..":LeftButton")
				end
				WoWPro:SetMacro("WPI", "#showtooltip\n/use item:"..use)
				itemkb = true
			end
		else
			row.itembutton.item_id = nil
			row.itembutton:Hide()
		end

		-- Target Button --
		if target then
			row.targetbutton.tooltip_text = target
			row.targetbutton:Show()
			local macroText = "/cleartarget\n/targetexact [nodead] "..target
				.."\n/cleartarget [@target,dead]"
				.."\n/script if not GetRaidTargetIndex('target') then SetRaidTarget('target', 8) end"
			row.targetbutton:SetAttribute("macrotext", macroText)
			if use then
				row.targetbutton:SetPoint("TOPRIGHT", row.itembutton, "TOPLEFT", -5, 0)
			else
				row.targetbutton:SetPoint("TOPRIGHT", row, "TOPLEFT", -10, -7)
			end
--			if not targetkb and row.targetbutton:IsVisible() then
			if row.targetbutton:IsVisible() then
				local key1, key2 = GetBindingKey("CLICK WoWPro_FauxTargetButton:LeftButton")
				if key1 then
					SetOverrideBinding(WoWPro.MainFrame, false, key1, "CLICK WoWPro_targetbutton"..i..":LeftButton")
				end
				if key2 then
					SetOverrideBinding(WoWPro.MainFrame, false, key2, "CLICK WoWPro_targetbutton"..i..":LeftButton")
				end
				WoWPro:SetMacro("WPT", macroText)
				targetkb = true
			end
		else
			row.targetbutton.tooltip_text = nil
			row.targetbutton:Hide()
		end

		WoWPro.rows[i] = row

		k = k + 1
	end

	-- Remove macros if no button found
	if not itemkb then WoWPro:SetMacro("WPI") end
	if not targetkb then WoWPro:SetMacro("WPT") end

	WoWPro.ActiveStickyCount = WoWPro.ActiveStickyCount or 0
	WoWPro.CurrentIndex = WoWPro.rows[1+WoWPro.ActiveStickyCount].index
	--WoWPro:UpdateQuestTracker()

	return reload
end

-- Left-Click Row Function --
function WoWPro.Leveling:RowLeftClick(i)
	if WoWPro.QID[WoWPro.rows[i].index] and WoWPro.QuestLog[WoWPro.QID[WoWPro.rows[i].index]] then
		QuestLog_OpenToQuest(WoWPro.QuestLog[WoWPro.QID[WoWPro.rows[i].index]])
	end
	WoWPro.rows[i]:SetChecked(nil)
end

-- Event Response Logic --
function WoWPro.Leveling:EventHandler(self, event, ...)

--if _G.perr_onevent then err("event = %s", event) end

	local WoWProCharDB = WoWPro.CharDB

	WoWPro:dbp("Running: Leveling Event Handler "..event)

	-- Auto-Completion --
	--if event == "CHAT_MSG_SYSTEM" then
	--	WoWPro.Leveling:AutoCompleteSetHearth(...)
	--end
	--elseif event == "CHAT_MSG_LOOT" then
		--WoWPro.Leveling:AutoCompleteLoot(...)
	--end
	--elseif event == "BAG_UPDATE" then
	--	WoWPro.Leveling:BAG_UPDATE_bucket()

--	if event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "MINIMAP_ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" then
--		WoWPro.Leveling:AutoCompleteZone(...)
	--end

	--if event == "UI_INFO_MESSAGE" then
	--	WoWPro.Leveling:AutoCompleteGetFP(...)
	--end

	--elseif event == "TAXIMAP_OPENED" then
	--	WoWPro.Leveling:RecordTaxiLocations(...)
	----- Noticing if we have entered a Dungeon!
	---elseif event == "ZONE_CHANGED_NEW_AREA" and WoWProCharDB.AutoHideLevelingInsideInstances == true then
	---	if IsInInstance() then
	---		WoWPro:Print("|cff33ff33Instance Auto Hide|r: Leveling Module")
	---		WoWPro.MainFrame:Hide()
	---		WoWPro.Titlebar:Hide()
	---		WoWPro.Hidden = true
	---		return
	---	elseif WoWPro.Hidden == true then
	---		WoWPro:Print("|cff33ff33Instance Exit Auto Show|r: Leveling Module")
	---		WoWPro.MainFrame:Show()
	---		WoWPro.Titlebar:Show()
	---		WoWPro.Hidden = nil
	---	end
	--end

	-- Lets see what quests the NPC has:
	--elseif event == "GOSSIP_SHOW" then
--if _G.perr then err("GOSSIP_SHOW") end

	-- 	if WoWProCharDB.AutoSelect == true and not IsShiftKeyDown() then
	--		WoWPro.Leveling:GOSSIP_SHOW_bucket()
			--local npcQuests = {GetGossipAvailableQuests()};
			--local index = 0
        --local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
			--for _,item in pairs(npcQuests) do
			--	if type(item) == "string" then
			--		index = index + 1
			--		if WoWPro.action[qidx] == "A" and item == WoWPro.step[qidx] then
			--			SelectGossipAvailableQuest(index)
			--			return
			--		end
			--	end
			--end
			--npcQuests =  {GetGossipActiveQuests()};
			--index = 0
			--for _,item in pairs(npcQuests) do
			--	if type(item) == "string" then
			--		index = index + 1
			--		if WoWPro.action[qidx] == "T" and item == WoWPro.step[qidx] then
			--			SelectGossipActiveQuest(index)
			--			return
			--		end
			--	end
			--end
	--	end

	--elseif event == "QUEST_GREETING" then
--if _G.perr then err("QUEST_GREETING") end
	--	if WoWProCharDB.AutoSelect == true and not IsShiftKeyDown() then
	--		WoWPro.Leveling:QUEST_GREETING_bucket()
		--	local numAvailableQuests = GetNumAvailableQuests()
		--	local numActiveQuests = GetNumActiveQuests()
       -- local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
		--	for i=1, numActiveQuests do
		--		if WoWPro.action[qidx] == "T" and GetActiveTitle(i) == WoWPro.step[qidx] then
		--			SelectActiveQuest(i)
		--			return
		--	   end
		--	end
		--	for i=1, numAvailableQuests do
		--		if WoWPro.action[qidx] == "A" and GetAvailableTitle(i) == WoWPro.step[qidx] then
		--			SelectAvailableQuest(i)
		--			return
		--		end
		--	end
	--	end

  -- elseif event == "QUEST_DETAIL" then
--if _G.perr then err("QUEST_DETAIL") end
	--	if WoWProCharDB.AutoAccept == true and not IsShiftKeyDown() then
	--		WoWPro.Leveling:QUEST_DETAIL_bucket()
        --local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
	   	--local questtitle = GetTitleText();
			--if WoWPro.action[qidx] == "A" and questtitle == WoWPro.step[qidx] then
			--	AcceptQuest()
			--end
	--	end

	--elseif event == "QUEST_PROGRESS" then
--if _G.perr then err("QUEST_PROGRESS") end
		--if WoWProCharDB.AutoTurnin == true  and not IsShiftKeyDown() then
		--	WoWPro.Leveling:QUEST_PROGRESS_bucket()
        --local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
			--local questtitle = GetTitleText();
			--if WoWPro.action[qidx] == "T" and questtitle == WoWPro.step[qidx] then
			--	CompleteQuest()
			--end
		--end

	--elseif event == "QUEST_COMPLETE" then
--if _G.perr then err("QUEST_COMPLETE") end
		-- Keep track of the quest being completed
		-- This is need to get information from quest that never get displayed
		-- in the quest log i.e. quests that complete as soon as they are
		-- accepted.
		--WoWPro.Leveling.CompletingQuest = GetQuestID()

		-- Autocomplete stuff
		--if WoWProCharDB.AutoTurnin == true  and not IsShiftKeyDown() then
		--	WoWPro.Leveling:QUEST_COMPLETE_bucket()
  -- 	local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
  -- 	local questtitle = GetTitleText();
	--	if WoWProCharDB.AutoTurnin == true and (WoWPro.action[qidx] == "T" or WoWPro.action[qidx] == "A") and questtitle == WoWPro.step[qidx] then
	--		if (GetNumQuestChoices() <= 1) then
	--			GetQuestReward(0)
	--		end
  --   	end
		--end
		--WoWPro.Leveling.CompletingQuestName = true
		--WoWPro.Leveling:AutoCompleteQuestUpdate(GetQuestID())
		--WoWPro.Leveling:QUEST_LOG_UPDATE_bucket()
	--end

	--elseif event == "QUEST_LOG_UPDATE" then
	--	WoWPro.Leveling:QUEST_LOG_UPDATE_bucket()
		-- Keep track of the completed quests
		--WoWPro.Leveling:GetTurnins(...)

		--WoWPro:PopulateQuestLog(...)
		--WoWPro.Leveling:AutoCompleteQuestUpdate(...)
		--WoWPro.Leveling:UpdateQuestTracker()
	--end
--	elseif event == "PLAYER_LEVEL_UP" then
--		WoWPro.Leveling:AutoCompleteLevel(...)
--		WoWPro.Leveling.CheckAvailableSpells(...)
--		WoWPro.Leveling.CheckAvailableTalents()
	--end
--	elseif event == "TRAINER_UPDATE" then
--		WoWPro.Leveling.CheckAvailableSpells()
--	end

end

--[==[
-- Remeber Taxi Locations
function WoWPro.Leveling:RecordTaxiLocations(...)
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
]==]

--[==[
-- Auto-Complete: Get flight point --
function WoWPro.Leveling:AutoCompleteGetFP(...)
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	for i = 1,15 do
		local index = WoWPro.rows[i].index
		if ... == ERR_NEWTAXIPATH and WoWPro.action[index] == "f"
		and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
			WoWPro.CompleteStep(index)
		end
	end
end
]==]
-- Auto-Complete: Quest Update --
--[[
function WoWPro.Leveling:AutoCompleteQuestUpdate(skipUIUpdate)
--WoWPro:Trace("Start WoWPro.Leveling:AutoCompleteQuestUpdate")
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	local GID = WoWProDB.char.currentguide
	if not GID or not WoWPro.Guides[GID] then return end

	if WoWProCharDB.Guide then
		for i=1,#WoWPro.action do

			local completion = WoWProCharDB.Guide[GID].completion[i]
			if not completion then

				local action = WoWPro.action[i]
				local QID = WoWPro.QID[i]
				-- Quest Turn-Ins --
				--if WoWPro.Leveling.CompletingQuest == QID and action == "T" and not completion and WoWPro.missingQuest == QID then
				--	WoWPro.CompleteStep(i)
				--	WoWProCharDB.completedQIDs[QID] = true
				--	WoWPro.Leveling.CompletingQuest = nil
				--end

				-- Abandoned Quests --
	--			if not WoWPro.Leveling.CompletingQuest and ( action == "A" or action == "C" )
	--				and completion and WoWPro.missingQuest == QID
	--			then
				if WoWPro.abandonedQID == QID and WoWPro.Leveling.CompletingQuest and
						( action == "A" or action == "C" ) and completion then
					WoWProCharDB.Guide[GID].completion[i] = nil
					completion = nil
					if not skipUIUpdate then
						WoWPro:UpdateGuide()
						WoWPro:MapPoint()
					end
				end

				-- Quest AutoComplete --
				if WoWProCharDB.completedQIDs[QID] then
					WoWPro.CompleteStep(i, skipUIUpdate)
					completion = true
--				end

					-- Quest AutoComplete --
	--			if (WoWPro.newQuest == QID or currentquests[QID]) and (action == "A") and not completion
	--			then
	--                WoWPro.CompleteStep(i)
	--            end
	--
						  -- Quest Accepts --
	--			if WoWPro.newQuest == QID and action == "A" and not completion then
	--				WoWPro.CompleteStep(i)
	--			end

				-- Quests that are in the current log have been accepted
				elseif action == "A" and not completion and WoWPro.QuestLog[QID] then
					WoWPro.CompleteStep(i, skipUIUpdate)
					completion = true
--				end

				-- Quest Completion: Any step that is not a Turn in is considered completed if the quest is completed --
				elseif action ~= "T" and not completion and WoWPro.QuestLog[QID] and WoWPro.QuestLog[QID].complete then
					WoWPro.CompleteStep(i, skipUIUpdate)
					completion = true
--				end

				-- Verify with FlightPoint addons
				--elseif action == "f" and not completion then
				--	-- Futur code to interact with FlightMap type of addons
				--end

						  -- Quest Completion --
--				elseif WoWPro.lootitem[i] and not completion
--					and GetItemCount( WoWPro.lootitem[i] ) >=  WoWPro.lootqty[i] then
--					WoWPro.CompleteStep(i, skipUIUpdate)
--					completion = true
--				end

				-- Partial Completion --
				elseif WoWPro.QuestLog[QID] and not completion and WoWPro.QuestLog[QID].leaderBoard and WoWPro.questtext[i] then
					local numquesttext = select("#", strsplit(";", WoWPro.questtext[i]))
					local complete = true
					for l=1,numquesttext do
						local lquesttext = select(numquesttext-l+1, strsplit(";", WoWPro.questtext[i]))
						local lcomplete = false
						for _, objective in pairs(WoWPro.QuestLog[QID].leaderBoard) do --Checks each of the quest log objectives
							if lquesttext == objective then --if the objective matches the step's criteria, mark true
								lcomplete = true
							end
						end
						if not lcomplete then complete = false end --if one of the listed objectives isn't complete, then the step is not complete.
					end
					if complete then WoWPro.CompleteStep(i, skipUIUpdate) end --if the step has not been found to be incomplete, run the completion function
				end

			end
		end
	end

	-- First Map Point --
	if not skipUIUpdate and WoWPro.FirstMapCall then
		WoWPro:MapPoint()
		WoWPro.FirstMapCall = false
	end

--WoWPro:Trace("End WoWPro.Leveling:AutoCompleteQuestUpdate")
end
]]

--[[
do -- QUEST_LOG_UPDATE_bucket Bucket Closure

	local THROTTLE_TIME = 0.2
	local throt, quest_log_update, gossip_show, quest_greeting, quest_detail, quest_complete, quest_progress
	local f = CreateFrame("Frame")
	f:Hide()
	f:SetScript("OnShow", function(self)
		throt = THROTTLE_TIME
	end)
	f:SetScript("OnUpdate", function(self, elapsed)
		throt = throt - elapsed
		if throt < 0 then
			if quest_log_update then

				WoWPro:PopulateQuestLog()
				WoWPro.Leveling:AutoCompleteQuestUpdate()
				WoWPro.Leveling:UpdateQuestTracker()

				quest_log_update = nil
			end

			if gossip_show then

--if _G.perr then err("gossip_show") end

				local qidx = WoWPro.ActiveStep
				local action, step = WoWPro.action[qidx], WoWPro.step[qidx]

				if action == "T" then

					local index = 1
					repeat
						local item = select((index-1)*4 + 1, GetGossipActiveQuests())
						if item == step then
							SelectGossipActiveQuest(index)
							break
						end
						index = index + 1
					until not item

					--for _,item in ipairs(npcQuests) do
					--	if type(item) == "string" then
					--		index = index + 1
					--		if item == step then
					--			-- action == "T"
					--			SelectGossipActiveQuest(index)
					--			break
					--		end
					--	end
					--end
				elseif action == "A" then

					local index = 1
					repeat
						local item = select((index-1)*4 + 1, GetGossipAvailableQuests())
						if item == step then
							SelectGossipAvailableQuest(index)
							break
						end
						index = index + 1
					until not item

					--local npcQuests = GetGossipAvailableQuests()
					--local index = 0
					--for _,item in ipairs(npcQuests) do
					--	if type(item) == "string" then
					--		index = index + 1
					--		if item == step then
					--			SelectGossipAvailableQuest(index)
					--			break
					--		end
					--	end
					--end
				end

				gossip_show = nil
			end

			if quest_greeting then

--if _G.perr then err("quest_greeting") end

				local qidx = WoWPro.ActiveStep
				local action, step = WoWPro.action[qidx], WoWPro.step[qidx]

				if action == "T" then
					local numActiveQuests = GetNumActiveQuests()
					local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
					for i=1, numActiveQuests do
						if GetActiveTitle(i) == step then
							SelectActiveQuest(i)
							break
						end
					end
				elseif action == "A" then
					local numAvailableQuests = GetNumAvailableQuests()
					for i=1, numAvailableQuests do
						if GetAvailableTitle(i) == step then
							SelectAvailableQuest(i)
							break
						end
					end
				end

				quest_greeting = nil
			end

			if quest_progress then

--if _G.perr then err("quest_progress") end

				-- Turnin the current quest automaticaly if applicable
				local qidx = WoWPro.ActiveStep
				if WoWPro.action[qidx] == "T" and GetTitleText() == WoWPro.step[qidx] then
					CompleteQuest()
				end

				quest_progress = nil
			end

			if quest_complete then

--if _G.perr then err("quest_complete") end

				-- Choose the reward automaticaly if there is only one choice
				local qidx = WoWPro.ActiveStep
				if (WoWPro.action[qidx] == "T" or WoWPro.action[qidx] == "A") and
					GetTitleText() == WoWPro.step[qidx] and
					GetNumQuestChoices() <= 1 then
						GetQuestReward(0)
				end

				quest_complete = nil
			end

			if quest_detail then

--if _G.perr then err("quest_detail") end

				-- Accept the current quest automaticaly if applicable
				local qidx = WoWPro.ActiveStep
				if WoWPro.action[qidx] == "A" and GetTitleText() == WoWPro.step[qidx] then
					AcceptQuest()
				end

				quest_detail = nil
			end

			f:Hide()
		end
	end)

	function WoWPro.Leveling:QUEST_LOG_UPDATE_bucket()
		quest_log_update = true
		f:Show()
	end

	function WoWPro.Leveling:GOSSIP_SHOW_bucket()
		gossip_show = true
		f:Show()
	end

	function WoWPro.Leveling:QUEST_GREETING_bucket()
		quest_greeting = true
		f:Show()
	end

	function WoWPro.Leveling:QUEST_PROGRESS_bucket()
		quest_progress = true
		f:Show()
	end

	function WoWPro.Leveling:QUEST_COMPLETE_bucket()
		quest_complete = true
		f:Show()
	end

	function WoWPro.Leveling:QUEST_DETAIL_bucket()
		quest_detail = true
		f:Show()
	end

end -- End Bucket Closure
]]

--[[
do -- BAG_UPDATE_bucket Waiting Bucket Closure

	local THROTTLE_TIME = 0.2
	local throt
	local f = CreateFrame("Frame")
	f:Hide()
	f:SetScript("OnUpdate", function(self, elapsed)
		throt = throt - elapsed
		if throt < 0 then
			WoWPro.Leveling:UpdateLootLines()			-- Updete the loot line displayed
			f:Hide()
		end
	end)

	function WoWPro.Leveling:BAG_UPDATE_bucket()
		-- We will wait THROTTLE_TIME after the last BAG_UPDATE event
		throt = THROTTLE_TIME
		f:Show()
	end

end -- End Bucket Closure
]]

--[==[
-- Update Item Tracking --
local function GetLootTrackingInfo(lootitem,lootqty,count)
--[[Purpose: Creates a string containing:
	- tracked item's name
	- how many the user has
	- how many the user needs
	- a complete symbol if the ammount the user has is equal to the ammount they need
]]
	if not GetItemInfo(lootitem) then return "" end
	local track, numinbag = "" 								--If the function did have a track string, adds a newline
	track = track.." - "..GetItemInfo(lootitem)..": " 	--Adds the item's name to the string
--	numinbag = GetItemCount(lootitem)+(count or 0)		--Finds the number in the bag, and adds a count if supplied
	numinbag = GetItemCount(lootitem)						--Finds the number in the bag, and adds a count if supplied
	track = track..numinbag										--Adds the number in bag to the string
	track = track.."/"..lootqty								--Adds the total number needed to the string
	if lootqty <= numinbag then
		track = track.." (C)"									--If the user has the requisite number of items, adds a complete marker
	end
	return track, numinbag										--Returns the track string and the inventory count to the calling function
end
]==]

--[[
-- Update the Loot line that are displayed based on actual count found in the inventory
-- and mark the step as complete if we have the minimum number required
function WoWPro.Leveling:UpdateLootLines()
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
]]

-- Auto-Complete: Loot based --
--function WoWPro.Leveling:AutoCompleteLoot(msg)
--	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB
--
--	local lootqtyi
--	local _, _, itemid, name = msg:find(L["^You .*Hitem:(%d+).*(%[.+%])"])
--	itemid = tonumber(itemid)
--	local _, _, _, _, count = msg:find(L["^You .*Hitem:(%d+).*(%[.+%]).*x(%d+)."])
--	if count == nil then count = 1 end
--	for i = 1,1+WoWPro.ActiveStickyCount do
--		local index = WoWPro.rows[i].index
----		if tonumber(WoWPro.lootqty[index]) ~= nil then lootqtyi = tonumber(WoWPro.lootqty[index]) else lootqtyi = 1 end
--		lootqtyi = WoWPro.lootqty[index] or 1
--		if WoWProDB.profile.track and WoWPro.lootitem[index] then
--			local track = GetLootTrackingInfo(WoWPro.lootitem[index],lootqtyi,count)
--			WoWPro.rows[i].track:SetText(strtrim(track))
--		end
--		if WoWPro.lootitem[index] and WoWPro.lootitem[index] == itemid and GetItemCount(WoWPro.lootitem[index]) + count >= lootqtyi
--		and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
--			WoWPro.CompleteStep(index)
--		end
--	end
--	for i = 1,15 do
--	end
--end

--[[
-- Auto-Complete: Set hearth --
function WoWPro.Leveling:AutoCompleteSetHearth(...)
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	local msg = ...
	local _, _, loc = msg:find(L["(.*) is now your home."])
	if loc then
		WoWProCharDB.Guide.hearth = loc
		for i = 1,15 do
			local index = WoWPro.rows[i].index
			if WoWPro.action[index] == "h" and WoWPro.step[index] == loc
			and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
				WoWPro.CompleteStep(index)
			end
		end
	else
		local quest = select(3, msg:find("^(.+) completed.$"))
		if quest then
			local qid = GetQuestID()
			if qid and WoWPro.CompletingQuestQID and qid == WoWPro.CompletingQuestQID then
				WoWPro.CompletingQuestQID = nil
				WoWProCharDB.completedQIDs[qid] = true
				WoWPro:QUEST_LOG_UPDATE_bucket()
			end
		end
	end
end
]]

--[==[
-- Auto-Complete: Zone based --
function WoWPro.Leveling:AutoCompleteZone()
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	WoWPro.ActiveStickyCount = WoWPro.ActiveStickyCount or 0
	local currentindex = WoWPro.rows[1+WoWPro.ActiveStickyCount].index
	local action = WoWPro.action[currentindex]
	local step = WoWPro.step[currentindex]
	local coord = WoWPro.map[currentindex]
	local waypcomplete = WoWPro.waypcomplete[currentindex]
	local zonetext, subzonetext = GetZoneText(), strtrim(GetSubZoneText())
	if action == "F" or action == "H" or action == "b" or (action == "R" and not waypcomplete) then
		if step == zonetext or step == subzonetext
		and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[currentindex] then
			WoWPro.CompleteStep(currentindex)
		end
	end
end
]==]

--[==[
-- Auto-Complete: Level based --
function WoWPro.Leveling:AutoCompleteLevel(...)
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
]==]

--[[
-- Update Quest Tracker --
function WoWPro.Leveling:UpdateQuestTracker()
--WoWPro:Trace("Start WoWPro.Leveling:UpdateQuestTracker")
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
--		if tonumber(lootqty) ~= nil then lootqty = tonumber(lootqty) else lootqty = 1 end
		local QID = WoWPro.QID[index]
		-- Setting up quest tracker --
		row.trackcheck = false
		local track = ""
		if WoWProDB.profile.track and ( action == "C" or questtext or lootitem) then
			if WoWPro.QuestLog[QID] and WoWPro.QuestLog[QID].leaderBoard then
				local j = WoWPro.QuestLog[QID].index
				row.trackcheck = true
				if not questtext and action == "C" then
					--if WoWPro.QuestLog[QID].leaderBoard[1] then
					--	track = "- "..WoWPro.QuestLog[QID].leaderBoard[1]
					--	if select(3,GetQuestLogLeaderBoard(1, j)) then
					--		track =  track.." (C)"
					--	end
					--end
--					for l=1,#WoWPro.QuestLog[QID].leaderBoard do
					for l=1,GetNumQuestLeaderBoards(j) do
						--if l > 1 then
							--if WoWPro.QuestLog[QID].leaderBoard[l] then
								local itemtext, _, isdone = GetQuestLogLeaderBoard(l, j)
								track = ("%s%s- %s%s"):format(track, l>1 and "\n" or "", itemtext, isdone and " (C)" or "")
								--track = track.."\n- "..WoWPro.QuestLog[QID].leaderBoard[l]
								--if select(3,GetQuestLogLeaderBoard(l, j)) then
								--	track =  track.." (C)"
								--end
							--end
						--end
					end
				elseif questtext then --Partial completion steps only track pertinent objective.
					local numquesttext = select("#", strsplit(";", questtext))
					for l=1,numquesttext do
						local lquesttext = select(numquesttext-l+1, strsplit(";", questtext))
						local _, _, litemname = strfind(lquesttext, "(.+):") -- Everything before the : is the item name
						for m=1,GetNumQuestLeaderBoards(j) do
							if GetQuestLogLeaderBoard(m, j) then
								local itemtext, _, isdone = GetQuestLogLeaderBoard(m, j)
--								local _, _, itemName, _, _ = string.find(GetQuestLogLeaderBoard(m, j), "(.*):%s*([%d]+)%s*/%s*([%d]+)");
								local _, _, itemName = strfind(itemtext, "(.+):") -- Everything before the : is the item name
								--if itemName and string.find(lquesttext,itemName) then
								if itemName and itemName == litemname then
									--track = "- "..GetQuestLogLeaderBoard(m, j)
									--if select(3,GetQuestLogLeaderBoard(m, j)) then
									--	track =  track.." (C)"
									--end
									track = ("%s%s- %s%s"):format(track, l>1 and "\n" or "", itemtext, isdone and " (C)" or "")
								end
							end
						end
					end
				end
			end
			if lootitem then
				row.trackcheck = true
				--if tonumber(lootqty) ~= nil then lootqty = tonumber(lootqty) else lootqty = 1 end
				lootqty = tonumber(lootqty or 1)
				track = GetLootTrackingInfo(lootitem,lootqty)
			end
		end
		row.track:SetText(track)
	end
	if not InCombatLockdown() then WoWPro:RowSizeSet(); WoWPro:PaddingSet() end
--WoWPro:Trace("End WoWPro.Leveling:UpdateQuestTracker")
end
]]

-- Get Currently Available Spells --
function WoWPro.Leveling.GetAvailableSpells(...)
	local newLevel = ... or UnitLevel("player")
	local i, j = 1, 0
	local availableSpells = {}
	while GetSpellBookItemName(i, "spell") do
		local info = GetSpellBookItemInfo(i, "spell")
		local name = GetSpellBookItemName(i, "spell")
		if info == "FUTURESPELL" and not "Master Riding" and not "Artisan Riding"
		and GetSpellAvailableLevel(i, "spell") <= newLevel then
			table.insert(availableSpells,name)
			j = j + 1
		end
		i = i + 1
	end
	return j, availableSpells
end
