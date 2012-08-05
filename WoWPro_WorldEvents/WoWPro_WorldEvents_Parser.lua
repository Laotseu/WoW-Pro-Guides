-------------------------------------------------------------------------------
-- Localized Lua globals
-------------------------------------------------------------------------------
local _G 								= getfenv(0)

local max								= _G.max
local tonumber							= _G.tonumber
local tostring							= _G.tostring
local type								= _G.type

local ipairs							= _G.ipairs
local pairs								= _G.pairs
local select							= _G.select
local tinsert							= _G.tinsert

local AcceptQuest						= _G.AcceptQuest
local ClearOverrideBindings		= _G.ClearOverrideBindings
local CompleteQuest					= _G.CompleteQuest
local GetAchievementCriteriaInfo	= _G.GetAchievementCriteriaInfo
local GetAchievementInfo			= _G.GetAchievementInfo
local GetAchievementNumCriteria	= _G.GetAchievementNumCriteria
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
local GetNumQuestLeaderBoards		= _G.GetNumQuestLeaderBoards
local GetProfessionInfo				= _G.GetProfessionInfo
local GetProfessions					= _G.GetProfessions
local GetQuestID						= _G.GetQuestID
local GetQuestLogLeaderBoard		= _G.GetQuestLogLeaderBoard
local GetQuestLogSpecialItemInfo	= _G.GetQuestLogSpecialItemInfo
local GetQuestReward					= _G.GetQuestReward
local GetSpellAvailableLevel		= _G.GetSpellAvailableLevel
local GetSpellBookItemInfo			= _G.GetSpellBookItemInfo
local GetSpellBookItemName			= _G.GetSpellBookItemName
local GetSubZoneText					= _G.GetSubZoneText
local GetTitleText					= _G.GetTitleText
local GetZoneText						= _G.GetZoneText
local InCombatLockdown				= _G.InCombatLockdown
local IsInInstance					= _G.IsInInstance
local PlaySoundFile					= _G.PlaySoundFile
local QuestLogPushQuest				= _G.QuestLogPushQuest
local QuestLog_OpenToQuest			= _G.QuestLog_OpenToQuest
local QuestMapUpdateAllQuests		= _G.QuestMapUpdateAllQuests
local QuestPOIGetIconInfo			= _G.QuestPOIGetIconInfo
local QuestPOIUpdateIcons			= _G.QuestPOIUpdateIcons
local SelectActiveQuest				= _G.SelectActiveQuest
local SelectAvailableQuest			= _G.SelectAvailableQuest
local SelectGossipActiveQuest		= _G.SelectGossipActiveQuest
local SelectGossipAvailableQuest	= _G.SelectGossipAvailableQuest
local SetOverrideBinding			= _G.SetOverrideBinding
local UnitClass						= _G.UnitClass
local UnitFactionGroup 				= _G.UnitFactionGroup
local UnitLevel						= _G.UnitLevel
local UnitRace							= _G.UnitRace
local UnitSex							= _G.UnitSex

local WoWPro_Locale 					= _G.WoWPro_Locale

local LibStub 							= _G.LibStub

local err_params = {}
local function err(msg, ...)
	if not _G.WoWPro.quest_log_debug then return end
	msg = tostring(msg)
	_G.wipe(err_params)
	for i=1,select('#',...) do err_params[i] = tostring(select(i,...)) end
	_G.geterrorhandler()(msg:format(_G.unpack(err_params)) .. " - " .. _G.time())
end

--------------------------------------
--      WoWPro_WorldEvents_Parser      --
--------------------------------------

local WoWPro = LibStub("AceAddon-3.0"):GetAddon("WoWPro")

local L = WoWPro_Locale
WoWPro.WorldEvents.actiontypes = {
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
WoWPro.WorldEvents.actionlabels = {
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

-- Determine Next Active Step (WorldEvents Module Specific)--
-- This function is called by the main NextStep function in the core broker --
function WoWPro.WorldEvents:NextStep(k, skip)
	local WoWProCharDB = WoWPro.CharDB

	local GID = WoWPro.DB.char.currentguide

	-- Optional Quests --
	if WoWPro.optional[k] and WoWPro.QID[k] then

		-- Checking Quest Log --
		if WoWPro.QuestLog[WoWPro.QID[k]] then
			skip = nil	 				-- If the optional quest is in the quest log, it's NOT skipped
			WoWPro.prereq[k] = nil	-- If the quest is in the log, the prereqs must already be met no matter
											-- what the guide say
		--end

		-- Checking Prerequisites --
		elseif WoWPro.prereq[k] then
			skip = nil					 -- defaulting to NOT skipped

			local numprereqs = select("#", (";"):split(WoWPro.prereq[k]))
			for j=1,numprereqs do
				local jprereq = select(numprereqs-j+1, (";"):split(WoWPro.prereq[k]))
				if not WoWPro.IsQuestFlaggedCompleted(tonumber(jprereq)) then
					skip = true -- If one of the prereqs is NOT complete, step is skipped.
				end
			end

			-- If the optinal quest is skipped, mark the quest as skipped
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
		local numprereqs = select("#", (";"):split(WoWPro.prereq[k]))
		for j=1,numprereqs do
			local jprereq = select(numprereqs-j+1, (";"):split(WoWPro.prereq[k]))
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

--[[
		local prof, profnum, proflvl, profmaxlvl, profmaxskill = string.split(";",WoWPro.prof[k])
		proflvl = tonumber(proflvl) or 1
		profmaxlvl = tonumber(profmaxlvl) or 700
		profmaxskill = tonumber(profmaxskill) or 700
		local profs, found = {}, false
		skip = false
		profs[1], profs[2], profs[3], profs[4], profs[5], profs[6] = GetProfessions()
		for p=1,6 do
			if profs[p] then
				local skillName, _, skillRank, maxskill, _, _, skillnum = GetProfessionInfo(profs[p])
					found = true
					if (skillRank >= proflvl) and (skillRank < profmaxlvl) and (maxskill < profmaxskill) then
						skip = false
--					if skip and proflvl > skillRank then skip = false end
					if skip then WoWProCharDB.Guide[GID].skipped[k] = true end
				end
			end
		end
		if found == false and proflvl == 0 then skip = false
		else if found == false and profmaxlvl == 700 then skip = true end end
	end
]]--
	-- Skipping profession quests (moved here from core)  --
	if WoWPro.prof[k] then
		local prof, profnum, proflvl, profmaxlvl, profmaxskill = (";"):split(WoWPro.prof[k])
		proflvl = tonumber(proflvl) or 1
		profmaxlvl = tonumber(profmaxlvl) or 700
		profmaxskill = tonumber(profmaxskill) or 700
		local profs, found = {}, false
		skip = false
		profs[1], profs[2], profs[3], profs[4], profs[5], profs[6] = GetProfessions()
		for p=1,6 do
			if profs[p] then
				local skillName, _, skillRank, maxskill, _, _, skillnum = GetProfessionInfo(profs[p])
				if (tonumber(skillnum) == tonumber(profnum)) then
					found = true
					if (skillRank >= proflvl) and (skillRank < profmaxlvl) and (maxskill < profmaxskill) then
						skip = false
					else skip = true end
--					if skip and proflvl > skillRank then skip = false end
					if skip then WoWProCharDB.Guide[GID].skipped[k] = true end
				end
			end
		end
		if found == false and proflvl == 0 then skip = false
		else if found == false and profmaxlvl == 700 then skip = true end end
	end

	-- Skipping Achievements if completed  --
	if WoWPro.ach[k] then
		local achnum, achitem = (";"):split(WoWPro.ach[k])
		local count = GetAchievementNumCriteria(achnum)
		if count == 0 then
			local IDNumber, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText, isGuildAch = GetAchievementInfo(achnum)
			if Completed then skip=true WoWProCharDB.Guide[GID].skipped[k] = true
			else skip=false end
		else
			local description, type, completed, quantity, requiredQuantity, characterName, flags, assetID, quantityString, criteriaID = GetAchievementCriteriaInfo(achnum, achitem)
			if completed then skip=true WoWProCharDB.Guide[GID].skipped[k] = true
			else skip=false end
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

function WoWPro.WorldEvents:SkipStep(index)
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

function WoWPro.WorldEvents:UnSkipStep(index)
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
	local WoWProDB = WoWPro.DB

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
--				WoWPro.leadin[i] = text:match("|LEAD|([^|]*)|?")
				WoWPro.target[i] = text:match("|T|([^|]*)|?")
				WoWPro.rep[i] = text:match("|REP|([^|]*)|?")
				WoWPro.prof[i] = text:match("|P|([^|]*)|?")
				WoWPro.rank[i] = text:match("|RANK|([^|]*)|?")
				WoWPro.ach[i] = text:match("|ACH|([^|]*)|?")

				if WoWPro.ach[i] then
					local achnum, achitem = (";"):split(WoWPro.ach[i])
					local count = GetAchievementNumCriteria(achnum)
					local IDNumber, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText, isGuildAch = GetAchievementInfo(achnum)
					if WoWPro.step[i] == "Achievement" and count == 0 then
						WoWPro.step[i] = Name
						WoWPro.note[i] = Description.."\n\n"..WoWPro.note[i] end
					if WoWPro.step[i] == "Achievement" and count > 0 then
						WoWPro.step[i] = Name
						local description, type, completed, quantity, requiredQuantity, characterName, flags, assetID, quantityString, criteriaID = GetAchievementCriteriaInfo(achnum, achitem)
						WoWPro.note[i] = description.. " ("..quantityString.." of "..requiredQuantity..")\n\n"..WoWPro.note[i] end
				end

--				for _,tag in pairs(WoWPro.Tags) do
--					if not WoWPro[tag][i] then WoWPro[tag][i] = false end
--				end

				i = i + 1
			end end end end
		end
	end
end

-- Guide Load --
function WoWPro.WorldEvents:LoadGuide()
	local WoWProCharDB = WoWPro.CharDB

	local GID = WoWPro.DB.char.currentguide

	-- Parsing quests --
	local sequence = WoWPro.Guides[GID].sequence
	ParseQuests(("\n"):split(sequence()))

	WoWPro:dbp("Guide Parsed. "..WoWPro.stepcount.." steps registered.")

	WoWPro:PopulateQuestLog() --Calling this will populate our quest log table for use here

	-- Checking to see if any steps are already complete wihtout updating the GUI --
	WoWPro:AutoCompleteQuestUpdate(true)

--[[
	-- Checking to see if any steps are already complete --
	--##### Need to validate but this should all be done in UpdateGuide()
	for i=1, WoWPro.stepcount do
		local action = WoWPro.action[i]
		local completion = WoWProCharDB.Guide[GID].completion[i]
		local level = WoWPro.level[i]
		local numQIDs

		if WoWPro.QID[i] then
			numQIDs = select("#", (";"):split(WoWPro.QID[i]))
		else
			numQIDs = 0
		end

		for j=1,numQIDs do
			local QID
			if WoWPro.QID[i] then
				QID = select(numQIDs-j+1, (";"):split(WoWPro.QID[i]))
				QID = tonumber(QID)
				WoWPro:dbp("Checking for completion: "..QID.." - "..WoWPro.step[i])
			else
				QID = nil
			end

		    -- Turned in quests --
		    if WoWProCharDB.completedQIDs or WoWPro.MOP then
			    if WoWPro.IsQuestFlaggedCompleted(QID) then
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

		end

		-- Checking level based completion --
		    if not completion and level and tonumber(level) <= UnitLevel("player") then
			WoWProCharDB.Guide[GID].completion[i] = true
		end
	end
]]
	-- Checking zone based completion --
	WoWPro:UpdateGuide()
	WoWPro:AutoCompleteZone()

	-- Update the display using the leadboard
	WoWPro:UpdateQuestTracker()

	-- Scrollbar Settings --
	WoWPro.Scrollbar:SetMinMaxValues(1, max(1, WoWPro.stepcount - WoWPro.ShownRows))

	-- Set the arrow
	WoWPro:MapPoint()
	WoWPro.FirstMapCall = false

	-- Audio feedback to tell the user it's done
	if WoWPro.DB.profile.checksound then
		PlaySoundFile(WoWPro.DB.profile.checksoundfile)
	end
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
	WoWPro.UpdateGuide()
	WoWPro.UpdateGuide()
	WoWPro.MapPoint()
end

local function _Sticky(self, row_index)
	--err("row_index=%s",row_index)
	WoWPro.sticky[row_index] = true
	WoWPro.unsticky[row_index] = false
	WoWPro.UpdateGuide()
	WoWPro.UpdateGuide()
	WoWPro.MapPoint()
end

-- Checkbox Function --
function WoWPro.WorldEvents:CheckFunction(row, button, down)
	row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	if button == "LeftButton" and row.check:GetChecked() then
		local steplist = WoWPro.WorldEvents:SkipStep(row.index)
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
		WoWPro.WorldEvents:UnSkipStep(row.index)
	end
	WoWPro:UpdateGuide()
end

-- Row Content Update --
function WoWPro.WorldEvents:RowUpdate(offset)
	local WoWProDB = WoWPro.DB
	local WoWProCharDB = WoWPro.CharDB

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
	--WoWPro.WorldEvents.RowDropdownMenu = {}
	WoWPro.ReleaseTable(WoWPro.WorldEvents.RowDropdownMenu)
	WoWPro.WorldEvents.RowDropdownMenu = WoWPro.AcquireTable()

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
--		local leadin = WoWPro.leadin[k]
		local leadin = nil
		local target = WoWPro.target[k]
		if WoWPro.prof[k] then
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
		if note then note = note:trim() note = note:gsub("\\n","\n") end
		if WoWProDB.profile.showcoords and coord and note then note = note.." ("..coord..")" end
		if WoWProDB.profile.showcoords and coord and not note then note = "("..coord..")" end
		if not ( WoWProDB.profile.showcoords and coord ) and not note then note = "" end
		row.note:SetText(note)
		row.action:SetTexture(WoWPro.WorldEvents.actiontypes[action])
		if WoWPro.noncombat[k] and WoWPro.action[k] == "C" then
			row.action:SetTexture("Interface\\AddOns\\WoWPro\\Textures\\Config.tga")
		end

		row.check:SetScript("OnClick", function(self, button, down)
			WoWPro.WorldEvents:CheckFunction(row, button, down)
		end)

		-- Right-Click Drop-Down --
		local dropdown = WoWPro.AcquireTable()
		if step then
			local tbl = WoWPro.AcquireTable()
			tbl.text 			= step.." Options"
			tbl.notCheckable 	= true
			tbl.isTitle 		= true
			tinsert(dropdown, tbl)

			local _, x, y, obj
			if coord or x then
				local tbl = WoWPro.AcquireTable()
				tbl.text 			= "Map Coordinates"
				tbl.notCheckable 	= true
				tbl.arg1				= row.num
				tbl.func 			= _MapGuideCoordinate
				tinsert(dropdown, tbl)
			end
			if QID then _, x, y, obj = QuestPOIGetIconInfo(QID) end
			if x and y then
				--)
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
		WoWPro.WorldEvents.RowDropdownMenu[i] = dropdown

		-- Item Button --
		if action == "H" then use = 6948 end
		if ( not use ) and action == "C" and WoWPro.QuestLog[QID] then
			local link, icon, charges = GetQuestLogSpecialItemInfo(WoWPro.QuestLog[QID])
			if link then
				local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = link:find("|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
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
			local macroText = "/cleartarget\n/targetexact [nodead] "..target
				.."\n/cleartarget [@target,dead]"
				.."\n/script if not GetRaidTargetIndex('target') then SetRaidTarget('target', 8) end"
			row.targetbutton:SetAttribute("macrotext", macroText)
			local target, spell, amt = (";"):split(target)
			spell = tonumber(spell) or 0
			amt = tonumber(amt) or 1

			row.targetbutton:Show()
			if spell == 2 then
				macroText = "/"..target.." "
			else
				macroText = "/cleartarget\n/targetexact [nodead] "..target
				.."\n/cleartarget [@target,dead]"
				.."\n/script if not GetRaidTargetIndex('target') then SetRaidTarget('target', 8) end"
			end
			row.targetbutton:SetAttribute("macrotext", macroText)
			if use then
				row.targetbutton:SetPoint("TOPRIGHT", row.itembutton, "TOPLEFT", -5, 0)
			else
				row.targetbutton:SetPoint("TOPRIGHT", row, "TOPLEFT", -10, -7)
			end
			--if not targetkb and row.targetbutton:IsVisible() then
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

		-- Setting the zone for the coordinates of the step --
		--zone = zone or ("-("):split(WoWPro.Guides[GID].zone)
		--row.zone = zone:trim(zone)

		-- Checking for loot items in bags --
		local lootqtyi
		if lootcheck and ( lootitem or action == "B" ) then
			if not WoWPro.sticky[row.index] then lootcheck = false end
			if not lootitem then
				if GetItemCount(step) > 0 and not completion[k] then WoWPro.CompleteStep(k) end
			end
			if tonumber(lootqty) ~= nil then lootqtyi = tonumber(lootqty) else lootqtyi = 1 end
			if GetItemCount(lootitem) >= lootqtyi and not completion[k] then WoWPro.CompleteStep(k) end
		end

		WoWPro.rows[i] = row

		k = k + 1
	end

	-- Remove macros if no button found
	if not itemkb then WoWPro:SetMacro("WPI") end
	if not targetkb then WoWPro:SetMacro("WPT") end

	WoWPro.ActiveStickyCount = WoWPro.ActiveStickyCount or 0
	WoWPro.CurrentIndex = WoWPro.rows[1+WoWPro.ActiveStickyCount].index
	WoWPro:UpdateQuestTracker()

	return reload
end

-- Left-Click Row Function --
function WoWPro.WorldEvents:RowLeftClick(i)
	if WoWPro.QID[WoWPro.rows[i].index] and WoWPro.QuestLog[WoWPro.QID[WoWPro.rows[i].index]] then
		QuestLog_OpenToQuest(WoWPro.QuestLog[WoWPro.QID[WoWPro.rows[i].index]])
	end
	WoWPro.rows[i]:SetChecked(nil)
end

-- Event Response Logic --
function WoWPro.WorldEvents:EventHandler(self, event, ...)
	local WoWProCharDB = WoWPro.CharDB

	WoWPro:dbp("Running: WorldEvents Event Handler "..event)

---	-- Noticing if we have entered a Dungeon!
---	if event == "ZONE_CHANGED_NEW_AREA" and WoWProCharDB.AutoHideWorldEventsInsideInstances == true then
---	    local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
---	    if WoWPro.zone[qidx] and not WoWPro:IsInstanceZone(WoWPro.zone[qidx]) and IsInInstance() then
---	        WoWPro:Print("|cff33ff33 Suppressing Instance Auto Hide, turn it on after you are done with this guide.|r")
---	        WoWProCharDB.AutoHideWorldEventsInsideInstances = false
---	        return
---	    end
---		if IsInInstance() then
---			WoWPro:Print("|cff33ff33Instance Auto Hide|r: WorldEvents Module")
---			WoWPro.MainFrame:Hide()
---			WoWPro.Titlebar:Hide()
---			WoWPro.Hidden = true
---			return
---		elseif WoWPro.Hidden == true then
---			WoWPro:Print("|cff33ff33Instance Exit Auto Show|r: WorldEvents Module")
---			WoWPro.MainFrame:Show()
---			WoWPro.Titlebar:Show()
---			WoWPro.Hidden = nil
---		end
---	end

--    -- Lets see what quests the NPC has:
--    if event == "GOSSIP_SHOW" and WoWProCharDB.AutoSelect == true then
--        local npcQuests = {GetGossipAvailableQuests()};
--        local index = 0
--        local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
--        for _,item in pairs(npcQuests) do
--            if type(item) == "string" then
--                index = index + 1
--		        if WoWPro.action[qidx] == "A" and item == WoWPro.step[qidx] then
--		            SelectGossipAvailableQuest(index)
--		            return
--		        end
--            end
--        end
--        npcQuests =  {GetGossipActiveQuests()};
--        index = 0
--        for _,item in pairs(npcQuests) do
--            if type(item) == "string" then
--                index = index + 1
--		        if WoWPro.action[qidx] == "T" and item == WoWPro.step[qidx] then
--		            SelectGossipActiveQuest(index)
--		            return
--		        end
--            end
--        end
--    end

--    if event == "QUEST_GREETING" and WoWProCharDB.AutoSelect == true then
--        local numAvailableQuests = GetNumAvailableQuests()
--        local numActiveQuests = GetNumActiveQuests()
--        local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
--        for i=1, numActiveQuests do
--            if WoWPro.action[qidx] == "T" and GetActiveTitle(i) == WoWPro.step[qidx] then
--		        SelectActiveQuest(i)
--		        return
--		    end
--		end
--        for i=1, numAvailableQuests do
--            if WoWPro.action[qidx] == "A" and GetAvailableTitle(i) == WoWPro.step[qidx] then
--		        SelectAvailableQuest(i)
--		        return
--		    end
--		end
--    end

--    if event == "QUEST_DETAIL" and WoWProCharDB.AutoAccept == true then
--        local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
--        local questtitle = GetTitleText();
--		if WoWPro.action[qidx] == "A" and questtitle == WoWPro.step[qidx] then
--		    AcceptQuest()
--		end
--    end

---    if event == "QUEST_PROGRESS" and WoWProCharDB.AutoTurnin == true then
---        local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
---        local questtitle = GetTitleText();
---		if WoWPro.action[qidx] == "T" and questtitle == WoWPro.step[qidx] then
---		    CompleteQuest()
---		end
---    end
---
---	-- Noting that a quest is being completed for quest log update events --
---	if event == "QUEST_COMPLETE" then
---	    WoWPro:Print("Completing Quest "..tostring(GetQuestID()))
---        local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
---        local questtitle = GetTitleText();
---        WoWPro:dbp("QC: "..WoWPro.action[qidx].."'"..questtitle.."', vs '"..WoWPro.step[qidx].."'")
---		if WoWProCharDB.AutoTurnin == true and (WoWPro.action[qidx] == "T" or WoWPro.action[qidx] == "A") and questtitle == WoWPro.step[qidx] then
---		    if (GetNumQuestChoices() <= 1) then
---		        GetQuestReward(0)
---		    end
---        end
---		WoWPro.WorldEvents.CompletingQuest = true
---		WoWPro.WorldEvents:AutoCompleteQuestUpdate(GetQuestID())
---	end

	-- Auto-Completion --
--	if event == "CHAT_MSG_SYSTEM" then
--		WoWPro.WorldEvents:AutoCompleteSetHearth(...)
--	end
--	if event == "CHAT_MSG_LOOT" then
--		WoWPro.WorldEvents:AutoCompleteLoot(...)
--	end
--	if event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "MINIMAP_ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" then
--		WoWPro.WorldEvents:AutoCompleteZone(...)
--	end
--	if event == "QUEST_LOG_UPDATE" then
--		WoWPro:PopulateQuestLog(...)
--		WoWPro.WorldEvents:AutoCompleteQuestUpdate(...)
--		WoWPro.WorldEvents:UpdateQuestTracker()
--	end
--	if event == "UI_INFO_MESSAGE" then
--		WoWPro.WorldEvents:AutoCompleteGetFP(...)
--	end
--	if event == "PLAYER_LEVEL_UP" then
--		WoWPro.WorldEvents:AutoCompleteLevel(...)
--		WoWPro.WorldEvents.CheckAvailableSpells(...)
--		WoWPro.WorldEvents.CheckAvailableTalents()
--	end
--	if event == "TRAINER_UPDATE" then
--		WoWPro.WorldEvents.CheckAvailableSpells()
--	end
--	if event == "CRITERIA_UPDATE" then
--		WoWPro:UpdateGuide()
--	end
end

--[==[
-- Auto-Complete: Get flight point --
function WoWPro.WorldEvents:AutoCompleteGetFP(...)
	for i = 1,15 do
		local index = WoWPro.rows[i].index
		if ... == _G.ERR_NEWTAXIPATH and WoWPro.action[index] == "f"
		and not WoWPro.CharDB.Guide[WoWPro.DB.char.currentguide].completion[index] then
			WoWPro.CompleteStep(index)
		end
	end
end
]==]
--[==[
-- Auto-Complete: Quest Update --
function WoWPro.WorldEvents:AutoCompleteQuestUpdate(questComplete)
	local WoWProCharDB = WoWPro.CharDB

	local GID = WoWPro.DB.char.currentguide
	if not GID or not WoWPro.Guides[GID] then return end

	if WoWProCharDB.Guide then
		for i=1,#WoWPro.action do

			local action = WoWPro.action[i]
			local completion = WoWProCharDB.Guide[GID].completion[i]

			if WoWPro.QID[i] then
				local numQIDs = select("#", (";"):split(WoWPro.QID[i]))
				for j=1,numQIDs do
					local QID = select(numQIDs-j+1, (";"):split(WoWPro.QID[i]))
					QID = tonumber(QID)

			        -- Quest Turn-Ins --
			        if WoWPro.WorldEvents.CompletingQuest and action == "T" and not completion and WoWPro.missingQuest == QID then
				        WoWPro.CompleteStep(i)
				        --WoWProCharDB.completedQIDs[QID] = true
				        WoWPro.WorldEvents.CompletingQuest = false
			        end

			        -- Abandoned Quests --
			        if not WoWPro.WorldEvents.CompletingQuest and ( action == "A" or action == "C" )
			        and completion and WoWPro.missingQuest == QID then
				        WoWProCharDB.Guide[GID].completion[i] = nil
				        WoWPro:UpdateGuide()
				        WoWPro:MapPoint()
			        end

                    -- Quest AutoComplete --
                    if questComplete and (action == "A" or action == "C" or action == "T" or action == "N") and QID == questComplete then
                        WoWPro.CompleteStep(i)
                    end
			        -- Quest Accepts --
			        if WoWPro.newQuest == QID and action == "A" and not completion then
				        WoWPro.CompleteStep(i)
			        end

			        -- Quest Completion --
			        if WoWPro.QuestLog[QID] and action == "C" and not completion and WoWPro.QuestLog[QID].complete then
				        WoWPro.CompleteStep(i)
			        end

			        -- Partial Completion --
			        if WoWPro.QuestLog[QID] and WoWPro.QuestLog[QID].leaderBoard and WoWPro.questtext[i]
			        and not WoWProCharDB.Guide[GID].completion[i] then
				        local numquesttext = select("#", (";"):split(WoWPro.questtext[i]))
				        local complete = true
				        for l=1,numquesttext do
					        local lquesttext = select(numquesttext-l+1, (";"):split(WoWPro.questtext[i]))
					        local lcomplete = false
					        for _, objective in pairs(WoWPro.QuestLog[QID].leaderBoard) do --Checks each of the quest log objectives
						        if lquesttext == objective then --if the objective matches the step's criteria, mark true
							        lcomplete = true
						        end
					        end
					        if not lcomplete then complete = false end --if one of the listed objectives isn't complete, then the step is not complete.
				        end
				        if complete then WoWPro.CompleteStep(i) end --if the step has not been found to be incomplete, run the completion function
			        end
			    end
			end
		end

	end

	-- First Map Point --
	if WoWPro.FirstMapCall then
		WoWPro:MapPoint()
		WoWPro.FirstMapCall = false
	end

end
]==]
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
	local track = "" 												--If the function did have a track string, adds a newline
	track = track.." - "..GetItemInfo(lootitem)..": " 	--Adds the item's name to the string
	local numinbag = GetItemCount(lootitem)+(count or 0)		--Finds the number in the bag, and adds a count if supplied
	track = track..numinbag										--Adds the number in bag to the string
	track = track.."/"..lootqty								--Adds the total number needed to the string
	if lootqty <= numinbag then
		track = track.." (C)"									--If the user has the requisite number of items, adds a complete marker
	end
	return track													--Returns the track string to the calling function
end
]==]
--[==[
-- Auto-Complete: Loot based --
function WoWPro.WorldEvents:AutoCompleteLoot(msg)
	local WoWProDB = WoWPro.DB
	local WoWProCharDB = WoWPro.CharDB

	local lootqtyi
	local _, _, itemid, name = msg:find(L["^You .*Hitem:(%d+).*(%[.+%])"])
	local _, _, _, _, count = msg:find(L["^You .*Hitem:(%d+).*(%[.+%]).*x(%d+)."])
	if count == nil then count = 1 end
	for i = 1,1+WoWPro.ActiveStickyCount do
		local index = WoWPro.rows[i].index
		if tonumber(WoWPro.lootqty[index]) ~= nil then lootqtyi = tonumber(WoWPro.lootqty[index]) else lootqtyi = 1 end
		if WoWProDB.profile.track and WoWPro.lootitem[index] then
			local track = GetLootTrackingInfo(WoWPro.lootitem[index],lootqtyi)
			WoWPro.rows[i].track:SetText(track:trim())
		end
		if WoWPro.lootitem[index] and WoWPro.lootitem[index] == itemid and GetItemCount(WoWPro.lootitem[index])  >= lootqtyi
		and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
			WoWPro.CompleteStep(index)
		end
	end
	for i = 1,15 do
	end
end
]==]
--[==[
-- Auto-Complete: Set hearth --
function WoWPro.WorldEvents:AutoCompleteSetHearth(...)
	local WoWProCharDB = WoWPro.CharDB

	local msg = ...
	local _, _, loc = msg:find(L["(.*) is now your home."])
	if loc then
		WoWProCharDB.Guide.hearth = loc
		for i = 1,15 do
			local index = WoWPro.rows[i].index
			if WoWPro.action[index] == "h" and WoWPro.step[index] == loc
			and not WoWProCharDB.Guide[WoWPro.DB.char.currentguide].completion[index] then
				WoWPro.CompleteStep(index)
			end
		end
	end
end
]==]
--[==[
-- Auto-Complete: Zone based --
function WoWPro.WorldEvents:AutoCompleteZone()
	WoWPro.ActiveStickyCount = WoWPro.ActiveStickyCount or 0
	local currentindex = WoWPro.rows[1+WoWPro.ActiveStickyCount].index
	local action = WoWPro.action[currentindex]
	local step = WoWPro.step[currentindex]
	local coord = WoWPro.map[currentindex]
	local waypcomplete = WoWPro.waypcomplete[currentindex]
	local zonetext, subzonetext = GetZoneText(), (GetSubZoneText()):trim()
	if action == "F" or action == "H" or action == "b" or (action == "R" and not waypcomplete) then
		if step == zonetext or step == subzonetext
		and not WoWPro.CharDB.Guide[WoWPro.DB.char.currentguide].completion[currentindex] then
			WoWPro.CompleteStep(currentindex)
		end
	end
end
]==]
--[==[
-- Auto-Complete: Level based --
function WoWPro.WorldEvents:AutoCompleteLevel(...)
	local WoWProCharDB = WoWPro.CharDB

	local newlevel = ... or UnitLevel("player")
	if WoWProCharDB.Guide then
		local GID = WoWPro.DB.char.currentguide
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
--[==[
-- Update Quest Tracker --
function WoWPro.WorldEvents:UpdateQuestTracker()
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
					if tonumber(lootqty) ~= nil then lootqty = tonumber(lootqty) else lootqty = 1 end
		local QID = WoWPro.QID[index]
		-- Setting up quest tracker --
		row.trackcheck = false
		local track = ""
		if WoWProDB.profile.track and ( action == "C" or questtext or lootitem) then
			if WoWPro.QuestLog[QID] and WoWPro.QuestLog[QID].leaderBoard then
				local j = WoWPro.QuestLog[QID].index
				row.trackcheck = true
				if not questtext and action == "C" then
					if WoWPro.QuestLog[QID].leaderBoard[1] then
						track = "- "..WoWPro.QuestLog[QID].leaderBoard[1]
						if select(3,GetQuestLogLeaderBoard(1, j)) then
							track =  track.." (C)"
						end
					end
					for l=1,#WoWPro.QuestLog[QID].leaderBoard do
						if l > 1 then
							if WoWPro.QuestLog[QID].leaderBoard[l] then
								track = track.."\n- "..WoWPro.QuestLog[QID].leaderBoard[l]
								if select(3,GetQuestLogLeaderBoard(l, j)) then
									track =  track.." (C)"
								end
							end
						end
					end
				elseif questtext then --Partial completion steps only track pertinent objective.
					local numquesttext = select("#", (";"):split(questtext))
					for l=1,numquesttext do
						local lquesttext = select(numquesttext-l+1, (";"):split(questtext))
						for m=1,GetNumQuestLeaderBoards(j) do
							if GetQuestLogLeaderBoard(m, j) then
								local _, _, itemName, _, _ = (GetQuestLogLeaderBoard(m, j)):find("(.*):%s*([%d]+)%s*/%s*([%d]+)");
								if itemName and lquesttext:find(itemName) then
									track = "- "..GetQuestLogLeaderBoard(m, j)
									if select(3,GetQuestLogLeaderBoard(m, j)) then
										track =  track.." (C)"
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
				track = GetLootTrackingInfo(lootitem,lootqty)
			end
		end
		row.track:SetText(track)
	end
	if not InCombatLockdown() then WoWPro:RowSizeSet(); WoWPro:PaddingSet() end
end
]==]
-- Get Currently Available Spells --
function WoWPro.WorldEvents.GetAvailableSpells(...)
	local newLevel = ... or UnitLevel("player")
	local i, j = 1, 0
	local availableSpells = {}
	while GetSpellBookItemName(i, "spell") do
		local info = GetSpellBookItemInfo(i, "spell")
		local name = GetSpellBookItemName(i, "spell")
		if info == "FUTURESPELL" and not "Master Riding" and not "Artisan Riding"
		and GetSpellAvailableLevel(i, "spell") <= newLevel then
			tinsert(availableSpells,name)
			j = j + 1
		end
		i = i + 1
	end
	return j, availableSpells
end