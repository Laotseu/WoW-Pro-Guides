-----------------------------
--      WoWPro_Parser      --
-----------------------------

local _G = getfenv(0)
local WoWPro = _G.WoWPro
local _ = _G._
local function err(msg,...) _G.geterrorhandler()(msg:format(_G.tostringall(...)) .. " - " .. _G.time()) end
	
local L = WoWPro_Locale
WoWPro.actiontypesorder = { "A", "C", "T", "K", "R", "H", "h", "F", "f", "N", "B", "b", "U", "L", "l", "r", "noncombat", "chat", "acceptdaily", "turnindaily" }
WoWPro.actiontypesdesc = {
	A = "Accept Quest",
	C = "Complete Quest",
	T = "Turn In Quest",
	K = "Kill",
	R = "Run To",
	H = "Use Hearthstone",
	h = "Set Hearthstone",
	F = "Fly To",
	f = "Get Flight Path",
	N = "Note",
	B = "Buy",
	b = "Go by Boat or Zeppelin",
	U = "Use Item",
	L = "Level Up",
	l = "Loot or Pickup Item(s)",
	r = "Repair/Restock",
	--t = "Turn In Quest (conditional)",
	noncombat = "Interact With Item(s)",
	chat = "Chat",
	acceptdaily = "Accept Daily Quest",
	turnindaily = "Turn In Daily Quest",
}
WoWPro.actiontypes = {
	A = "Interface\\GossipFrame\\AvailableQuestIcon",
	C = [[Interface\MINIMAP\OBJECTICONS]],
	--C = "Interface\\CHARACTERFRAME\\UI-StateIcon",
	--C = [[Interface\QUESTFRAME\QuestTypeIcons]],
	T = "Interface\\GossipFrame\\ActiveQuestIcon",
	--K = "Interface\\Icons\\Ability_Creature_Cursed_02",
	K = "Interface\\MINIMAP\\OBJECTICONS",
	R = "Interface\\Icons\\Ability_Tracking",
	--H = "Interface\\Icons\\INV_Misc_Rune_01",
	H = "Interface\\MINIMAP\\TRACKING\\Innkeeper",
	--h = "Interface\\AddOns\\WoWPro\\Textures\\resting.tga",
	h = "Interface\\CHARACTERFRAME\\UI-StateIcon",
	--F = "Interface\\Icons\\Ability_Druid_FlightForm",
	F = "Interface\\MINIMAP\\OBJECTICONS",
--	f = "Interface\\Icons\\Ability_Hunter_EagleEye",
	f = "Interface\\MINIMAP\\OBJECTICONS",
	N = "Interface\\Icons\\INV_Misc_Note_01",
--	B = "Interface\\Icons\\INV_Misc_Coin_01",
	B = "Interface\\MINIMAP\\OBJECTICONS",
	b = "Interface\\Icons\\Spell_Frost_SummonWaterElemental",
	U = "Interface\\Icons\\INV_Misc_Bag_08",
	L = "Interface\\Icons\\Spell_ChargePositive",
--	l = "Interface\\Icons\\INV_Misc_Bag_08",
	l = "Interface\\CURSOR\\Pickup",
--	r = "Interface\\Icons\\Ability_Repair",
	r = "Interface\\MINIMAP\\OBJECTICONS",
	t = "Interface\\GossipFrame\\ActiveQuestIcon",
	--noncombat = "Interface\\AddOns\\WoWPro\\Textures\\Config.tga",
	-- noncombat = "Interface\\MINIMAP\\OBJECTICONS",
	noncombat = [[Interface\GossipFrame\BinderGossipIcon]],
	--noncombat = [[Interface\CURSOR\openhand]],
	chat = "Interface\\GossipFrame\\Gossipgossipicon",
	acceptdaily = "Interface\\GossipFrame\\DailyQuestIcon",
	turnindaily = "Interface\\GossipFrame\\DailyActiveQuestIcon",
}
WoWPro.actiontypecoords = {
	C = { 4/8, 5/8, 5/8, 6/8 },
	--C = { 1/2, 1, 0, 1/2 },
	--C = { 2/7, 3/7, 1/4, 2/4 },
	K = { 7/8, 8/8, 6/8, 7/8 },
	F = { 4/8, 5/8, 2/8, 3/8 },
	f = { 5/8, 6/8, 1/8, 2/8 },
	B = { 0/8, 1/8, 2/8, 3/8 },
	h = { 0, 1/2, 0, 1/2},
	r = { 3/8, 4/8, 3/8, 4/8 },
	-- noncombat = { 1/8, 2/8, 4/8, 5/8 },
}
function WoWPro:SetActiontypeTex(tex, actiontype, index)
	if not WoWPro.actiontypes[actiontype] then
		err("Invalid actiontype '%s' for index %s", actiontype, index)
	end
	tex:SetTexture(WoWPro.actiontypes[actiontype])
	if WoWPro.actiontypecoords[actiontype] then
		tex:SetTexCoord(
			WoWPro.actiontypecoords[actiontype][1],
			WoWPro.actiontypecoords[actiontype][2],
			WoWPro.actiontypecoords[actiontype][3],
			WoWPro.actiontypecoords[actiontype][4]
		)
	else
		tex:SetTexCoord(0, 1, 0, 1)
	end
end


WoWPro.actionlabels = {
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
	r = "Repair/Restock",
	t = "Conditional Turn In"
}


-- Skip a step --
function WoWPro:SkipStep(index)
	local GID = WoWProDB.char.currentguide
	
	if not WoWPro.QID[index] then return "" end
	if WoWPro.action[index] == "A" 
	or WoWPro.action[index] == "C" 
	or WoWPro.action[index] == "T" then
		WoWProCharDB.skippedQIDs[WoWPro.QID[index]] = true
		WoWProCharDB.Guide[GID].skipped[index] = true
	else 
		WoWProCharDB.Guide[GID].skipped[index] = true
	end
	local steplist = ""
	
	local function skipstep(currentstep)
		for j = 1,WoWPro.stepcount do 
			if WoWPro.prereq[j] then
				local numprereqs = select("#", string.split(";", WoWPro.prereq[j]))
				for k=1,numprereqs do
					local kprereq = select(numprereqs-k+1, string.split(";", WoWPro.prereq[j]))
					if tonumber(kprereq) == tonumber(WoWPro.QID[currentstep]) 
					and WoWProCharDB.skippedQIDs[WoWPro.QID[currentstep]] then
						if WoWPro.action[j] == "A" 
						or WoWPro.action[j] == "C" 
						or WoWPro.action[j] == "T" then
							WoWProCharDB.skippedQIDs[WoWPro.QID[j]] = true
						end
						steplist = steplist.."- "..WoWPro.step[j].."\n"
						skipstep(j)
					end
				end
			end 
		end
	end
	
	skipstep(index)
	
	WoWPro:UpdateQuestTracker()
	return steplist
end

-- Unskip a step --
function WoWPro:UnSkipStep(index)
	local GID = WoWProDB.char.currentguide
	WoWProCharDB.Guide[GID].completion[index] = nil
	if WoWPro.QID[index] 
	and ( WoWPro.action[index] == "A" 
		or WoWPro.action[index] == "C" 
		or WoWPro.action[index] == "T" ) then
			WoWProCharDB.skippedQIDs[WoWPro.QID[index]] = nil
			WoWProCharDB.Guide[GID].skipped[index] = nil
	else
		WoWProCharDB.Guide[GID].skipped[index] = nil
	end
	
	local function unskipstep(currentstep)
		for j = 1,WoWPro.stepcount do if WoWPro.prereq[j] then
			local numprereqs = select("#", string.split(";", WoWPro.prereq[j]))
			for k=1,numprereqs do
				local kprereq = select(numprereqs-k+1, string.split(";", WoWPro.prereq[j]))
				if tonumber(kprereq) == WoWPro.QID[currentstep] then
					if WoWPro.action[j] == "A" 
					or WoWPro.action[j] == "C" 
					or WoWPro.action[j] == "T" then
						WoWProCharDB.skippedQIDs[WoWPro.QID[j]] = nil
					end
					WoWProCharDB.Guide[GID].skipped = {}
					unskipstep(j)
				end
			end
		end end
	end
	
	unskipstep(index)
	WoWPro:UpdateGuide()
	WoWPro:UpdateQuestTracker()
end


function WoWPro.ParseQuestLine(faction,i,text,realline)
	local GID = WoWProDB.char.currentguide
	local zone = strtrim(string.match(WoWPro.Guides[GID].zone, "([^%(]+)") or "")
	
--		_, _, WoWPro.action[i], WoWPro.step[i] = text:find("^(%a) ([^|]*)(.*)")
		_, _, WoWPro.action[i], WoWPro.step[i] = text:find("^(%a) ([^|]*)")
	if (not WoWPro.action[i]) or (not WoWPro.step[i]) then
	    WoWPro:Error("Line %d in guide %s is badly formatted: \"%s\"\nParsing Halted.",realline,GID,text)
	    return
	end
	if not WoWPro.actionlabels[WoWPro.action[i]] then
		err("Invalid action label %s at line %d in guide %s: \"%s\"\nParsing Halted.",WoWPro.action[i],realline,GID,tostring(text))
		--WoWPro:Error("Invalid action label %s at line %d in guide %s: \"%s\"\nParsing Halted.",WoWPro.action[i],realline,GID,tostring(text))
		return
	end
	WoWPro.step[i] = WoWPro.step[i]:trim()
	WoWPro.stepcount = WoWPro.stepcount + 1
	WoWPro.QID[i] = text:match("|QID|([^|]*)|?")
	if WoWPro.action[i] == "t" then
	    WoWPro.action[i] = "T"
	    WoWPro.conditional[i] = true
	end
	if (WoWPro.action[i] == "A" or WoWPro.action[i] == "T") then
	    WoWPro:GrailCheckQuestName(GID,WoWPro.QID[i],WoWPro.step[i])
	end
	WoWPro.note[i] = text:match("|N|([^|]*)|?")
	-- Replace all the \ by | to allow UI Escape sequences in the notes
	WoWPro.note[i] = WoWPro.note[i] and WoWPro.note[i]:gsub('\\','|') or nil 
	--WoWPro.mat[i] = text:match("|N|([^|]*)|?")	-- I don't think that mat is ever used anywhere
	WoWPro.map[i] = text:match("|M|([^|]*)|?")
	if WoWPro.map[i] then
	    WoWPro:ValidateMapCoords(GID,WoWPro.action[i],WoWPro.step[i],WoWPro.map[i])
	end    
	if text:find("|S|") then 
		WoWPro.sticky[i] = true; 
		WoWPro.stickycount = WoWPro.stickycount + 1 
	end
	if text:find("|US|") then WoWPro.unsticky[i] = true end
	WoWPro.use[i] = text:match("|U|([^|]*)|?")
	WoWPro.zone[i] = text:match("|Z|([^|]*)|?") or (WoWPro.map[i] and zone ~= "" and zone)
	if WoWPro.zone[i] and WoWPro.map[i] and not WoWPro:ValidZone(WoWPro.zone[i]) then
--		local line =string.format("Vers=%s|Guide=%s|Line=%s",WoWPro.Version,GID,text)
--        WoWProDB.global.ZoneErrors = WoWProDB.global.ZoneErrors or {}
--        table.insert(WoWProDB.global.ZoneErrors, line)
	    WoWPro:Error("Invalid Z tag at line %s in: %s",realline,text)
	    WoWPro.zone[i] = nil
	end
	--_, _, WoWPro.lootitem[i], WoWPro.lootqty[i] = text:find("|L|(%d+)%s?(%d*)|")
	WoWPro.lootitem[i], WoWPro.lootqty[i] = text:match("|L|(%d+)%s?(%d*)|")
	if WoWPro.lootitem[i] then
    	if tonumber(WoWPro.lootqty[i]) ~= nil then
    	    WoWPro.lootqty[i] = tonumber(WoWPro.lootqty[i])
    	else
    	    WoWPro.lootqty[i] = 1
    	end
    end
	WoWPro.questtext[i] = text:match("|QO|([^|]*)|?")
	-- Hack for the new quest objective format
	if WoWPro.questtext[i] then
		local numquesttext = select("#", (";"):split(WoWPro.questtext[i]))
		local questresult = ""
		for l=1,numquesttext do
			local lquesttext = select(l, (";"):split(WoWPro.questtext[i]))
			local questob1, questob2 = lquesttext:match("([^:]+)[:][ ](.*)")
			if questob1 then
				--err("questob1 = %s, questob2 = %s",questob1, questob2)
				questresult = ("%s%s%s %s"):format(questresult, l>1 and ";" or "", questob2, questob1)
			else
				questresult = ("%s%s%s"):format(questresult, l>1 and ";" or "", lquesttext)
			end
		end
		WoWPro.questtext[i] = questresult
	end

	if text:find("|O|") then 
		WoWPro.optional[i] = true
		WoWPro.optionalcount = WoWPro.optionalcount + 1 
	end
	WoWPro.prereq[i] = text:match("|PRE|([^|]*)|?") or (WoWPro.action[i] == "A" and WoWPro:GrailQuestPrereq(WoWPro.QID[i]))
	if not WoWPro.prereq[i] then WoWPro.prereq[i] = nil end

	if WoWPro.map[i] then
		if text:find("|CC|") then WoWPro.waypcomplete[i] = 1
		elseif text:find("|CS|") then WoWPro.waypcomplete[i] = 2
		elseif text:find("|CN|") then WoWPro.waypcomplete[i] = false
		else
		    WoWPro.waypcomplete[i] = false
		    if WoWPro.map[i]:find(";") then
		        WoWPro:Warning("Step %s [%s:%s] at line %s in %s is missing a CS|CC|CN tag.",WoWPro.action[i],WoWPro.step[i],tostring(WoWPro.QID[i]),realline,WoWProDB.char.currentguide)
		    end
		end
	end

	if faction then
		WoWPro.faction[i] = faction
	end
	if text:find("|NC|") then WoWPro.noncombat[i] = true end
	if text:find("|CHAT|") then WoWPro.chat[i] = true end
	local gql = WoWPro:GrailQuestLevel(WoWPro.QID[i])
	if WoWPro.DebugLevel > 0 and gql and tonumber(WoWPro.QID[i]) and tonumber(WoWPro.QID[i]) < 100000 then
	    if WoWPro.Guides[GID].startlevel and WoWPro.Guides[GID].startlevel > 1 and tonumber(gql) < (WoWPro.Guides[GID].startlevel / 2) then
	        WoWPro:Warning("Guide %s QID %s is level %s?",GID,WoWPro.QID[i],gql)
	        gql = "0"
	    end
	    if tonumber(gql) < 1 then
	        WoWPro:Warning("Guide %s QID %s is level %s!",GID,WoWPro.QID[i],gql)
	    else
	        gql = tonumber(gql)
	        if WoWPro.Guides[GID].startlevel and gql < tonumber(WoWPro.Guides[GID].startlevel) then
	              WoWPro:Warning("Guide %s QID %s is level %s!??",GID,WoWPro.QID[i],gql)
	        end
	        if WoWPro.Guides[GID].endlevel and gql > tonumber(WoWPro.Guides[GID].endlevel) then
	              WoWPro:Warning("Guide %s QID %s is level %s!??",GID,WoWPro.QID[i],gql)
	        end
	        WoWPro.Guides[GID].amax_level = max(WoWPro.Guides[GID].amax_level,gql)
	        WoWPro.Guides[GID].amin_level = min(WoWPro.Guides[GID].amin_level,gql)
	        WoWPro.Guides[GID].asum_level = WoWPro.Guides[GID].asum_level + gql
	        WoWPro.Guides[GID].acnt_level = WoWPro.Guides[GID].acnt_level + 1
	    end
	end
	WoWPro.level[i] = text:match("|LVL|([^|]*)|?") or gql
	WoWPro.leadin[i] = text:match("|LEAD|([^|]*)|?")
	WoWPro.active[i] = text:match("|ACTIVE|([^|]*)|?")
	WoWPro.target[i] = text:match("|T|([^|]*)|?")
	WoWPro.rep[i] = text:match("|REP|([^|]*)|?")
	WoWPro.prof[i] = text:match("|P|([^|]*)|?")
	WoWPro.rank[i] = text:match("|RANK|([^|]*)|?")
	WoWPro.spell[i] = text:match("|SPELL|([^|]*)|?")
	WoWPro.NPC[i] = text:match("|NPC|([^|]*)|?")
	WoWPro.ach[i] = text:match("|ACH|([^|]*)|?")
	WoWPro.buff[i] = text:match("|BUFF|([^|]*)|?")
	WoWPro.nobuff[i] = text:match("|NOBUFF|([^|]*)|?")
	WoWPro.recipe[i] = text:match("|RECIPE|([^|]*)|?")
	WoWPro.pet[i] = text:match("|PET|([^|]*)|?")
	WoWPro.building[i] = text:match("|BUILDING|([^|]*)|?")
	WoWPro.gossip[i] = text:match("|QG|([^|]*)|?")
	if WoWPro.gossip[i] then WoWPro.gossip[i] = strupper(WoWPro.gossip[i]) end
	if text:find("|DAILY|") then
		--err("Daily found: %s", text)
		WoWPro:SetSessionDailyQuests(WoWPro.QID[i])
	end
	WoWPro.altfp[i] = text:match("|ALTFP|([^|]*)|?")
	WoWPro.why[i] = nil

    -- If the step is "Achievement" use the name and description from the server ...
    if WoWPro.ach[i] and false then
        if not WoWPro.note[i] then
            WoWPro.note[i] = ""
        end
    	local achnum, achitem = string.split(";",WoWPro.ach[i])
    	local count = GetAchievementNumCriteria(achnum) 
    	local IDNumber, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText, isGuildAch = GetAchievementInfo(achnum) 
    	if WoWPro.step[i] == "Achievement" and count == 0 then 
    		WoWPro.step[i] = Name 
    		WoWPro.note[i] = Description.."\n\n"..WoWPro.note[i]
    	end 
    	if WoWPro.step[i] == "Achievement" and count > 0 then 
    		WoWPro.step[i] = Name 
    		local description, type, completed, quantity, requiredQuantity, characterName, flags, assetID, quantityString, criteriaID = GetAchievementCriteriaInfo(achnum, achitem) 
    		WoWPro.note[i] = description.. " ("..quantityString.." of "..requiredQuantity..")\n\n"..WoWPro.note[i]
    	end 
    end
		
	-- Module ParseQuestLine Handlers --
	if WoWProDB.char.currentguide and
	   WoWPro.Guides[WoWProDB.char.currentguide] and
	   WoWPro.Guides[WoWProDB.char.currentguide].guidetype and
	   WoWPro[WoWPro.Guides[WoWProDB.char.currentguide].guidetype].ParseQuestLine then
	    WoWPro[WoWPro.Guides[WoWProDB.char.currentguide].guidetype]:ParseQuestLine(text,i)
	end
end

-- Quest parsing function --
function WoWPro:ParseSteps(steps)
	WoWPro:dbp("Parsing Guide, %d steps",#steps)
	local GID = WoWProDB.char.currentguide
	local i = 1
	local myclassL, myclass = UnitClass("player")
	local myraceL, myrace = UnitRace("player")
	local myFaction = strupper(UnitFactionGroup("player"))
	if myrace == "Scourge" then
		myrace = "Undead"
	end
	WoWPro.stepcount, WoWPro.stickycount, WoWPro.optionalcount = 0, 0 ,0
	if WoWPro.DebugLevel > 0 then
	    WoWPro.Guides[GID].amax_level = -1
	    WoWPro.Guides[GID].amin_level = 100
	    WoWPro.Guides[GID].acnt_level = 0
	    WoWPro.Guides[GID].asum_level = 0 
	end
--err("ParsingSteps for %s, steps = %s",GID,#steps)
	for j=1,#steps do
		local text = steps[j]
		text = text:trim()
		if text ~= "" and text:sub(1,1) ~= ";" then
			local class, race, gender, faction = text:match("|C|([^|]*)|?"), text:match("|R|([^|]*)|?"), text:match("|GEN|([^|]*)|?"), text:match("|FACTION|([^|]*)|?")
			if class then
				-- deleting whitespaces and capitalizing, to compare with Blizzard's class tokens
				class = strupper(string.gsub(class, " ", ""))
			end
			if race then
				-- deleting whitespaces to compare with Blizzard's race tokens
				race = string.gsub(race, " ", "")
			end
			if gender then
				-- deleting leading/trailing whitespace and then canonicalize the case
				gender=strupper(strtrim(gender))
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
				faction=strupper(strtrim(faction))
            end			    
			if (class == nil or class:find(myclass)) and
			   (race == nil or race:find(myrace)) and
			   (gender == nil or gender == UnitSex("player")) and
			   (faction == nil or myFaction == "NEUTRAL" or faction == "NEUTRAL" or faction == myFaction) then
                WoWPro.ParsingQuestLine = text
            if i > 1000 then err("Infinite parsing for guide %s, j = %s",GID,j); return end
				WoWPro.ParseQuestLine(faction,i,text,j)
				WoWPro.ParsingQuestLine = nil
				i = i + 1
			end
		end
	end
--err("after for j=1,#steps")
--if true then return end
	if WoWPro.DebugLevel > 0 then
	    if WoWPro.Guides[GID].acnt_level > 0 then
            if WoWPro.Guides[GID].startlevel and WoWPro.Guides[GID].startlevel ~= WoWPro.Guides[GID].amin_level then
                WoWPro:Warning("Guide %s startlevel=%s, but min_level=%s",GID, WoWPro.Guides[GID].startlevel, WoWPro.Guides[GID].amin_level)
        	end
            if WoWPro.Guides[GID].endlevel and WoWPro.Guides[GID].endlevel ~= WoWPro.Guides[GID].amax_level then
                WoWPro:Warning("Guide %s endlevel=%s, but max_level=%s",GID, WoWPro.Guides[GID].endlevel, WoWPro.Guides[GID].amax_level)
        	end
        	local amean_level = WoWPro.Guides[GID].asum_level / WoWPro.Guides[GID].acnt_level
        	if not WoWPro.Guides[GID].level and WoWPro.Guides[GID].acnt_level > 1 then
        	    WoWPro:Warning("Guide %s %d/%d meanlevel=%g",GID, WoWPro.Guides[GID].asum_level , WoWPro.Guides[GID].acnt_level, amean_level)
        	end
        	if WoWPro.Guides[GID].level and WoWPro.Guides[GID].acnt_level > 1 and math.abs(WoWPro.Guides[GID].level-amean_level) > 0.001 then
        	    WoWPro:Warning("Guide %s level= %g but meanlevel=%g",GID, WoWPro.Guides[GID].level, amean_level)
        	end        	
        end
    end
end
	
-- Guide Load --
function WoWPro:LoadGuideSteps()
    WoWPro:dbp("Signaled for LoadGuideSteps for %s",tostring(WoWProDB.char.currentguide))
    WoWPro:SendMessage("WoWPro_LoadGuideSteps")
end

function WoWPro.LoadGuideStepsReal()
	local GID = WoWProDB.char.currentguide
    WoWPro:dbp("LoadGuideSteps(%s)",GID);
--err("LoadGuideStepsReal for guide %s", GID)    
	-- Parsing quests --
	local sequencef = WoWPro.Guides[GID].sequence
	local sequence = sequencef()
	if not sequence then
	    WoWPro:Error("Guide %s sequence function returned nothing!",GID,sequence)
	    return
	end
	local steps = { string.split("\n", sequence ) }
	WoWPro.stepcount = 0
--err("Before ParseSteps")
	WoWPro:ParseSteps(steps)
--if true then return end	
	WoWPro:dbp("Guide Parsed. "..WoWPro.stepcount.." steps stored.")
	WoWPro:PushCurrentGuide(GID)
	WoWPro:GuideSetup()
end

-- Push the guide on to the list of active guides, one per module
function WoWPro:PushCurrentGuide(GID)
    local guideType = WoWPro.Guides[WoWProDB.char.currentguide].guidetype
    if not  WoWProDB.char[guideType] then
        WoWProDB.char[guideType] = {}
    end
    if not WoWProDB.char[guideType].GuideStack then
        WoWProDB.char[guideType].GuideStack = {}
    end
    WoWProDB.char[guideType].GuideStack[GID] = time()
    WoWPro[guideType]:dbp("Recorded load for guide %s at %d",GID,WoWProDB.char[guideType].GuideStack[GID])
end

-- Guide Setup --
function WoWPro:GuideSetup()
    WoWPro:dbp("Signaled for GuideSetup for %s",tostring(WoWProDB.char.currentguide))
    WoWPro:SendMessage("WoWPro_GuideSetup")
end

function WoWPro.SetupGuideReal()
    local GID = WoWProDB.char.currentguide
    local guideType = WoWPro.Guides[GID].guidetype
    local guideClass = WoWPro[guideType]
    local recordQIDs = guideClass.RecordQIDs
    
    WoWPro:dbp("SetupGuideReal(%s): Type: %s, recordQIDs:",GID,guideType,tostring(recordQIDs))
    
	-- -- Checking to see if any steps are already complete --
	-- for i=1, WoWPro.stepcount do
	-- 	local action = WoWPro.action[i]
	-- 	local numQIDs

	-- 	if WoWPro.QID[i] then
	-- 		numQIDs = select("#", string.split(";", WoWPro.QID[i]))
	-- 	else
	-- 		numQIDs = 0
	-- 	end

        
 --        if (not WoWProCharDB.Guide[GID].skipped[i]) and numQIDs > 0 then
 --            WoWProCharDB.Guide[GID].completion[i] = false
 --            WoWPro.why[i] = "UnCompleted by WoWPro:LoadGuideSteps() because quest was not skipped."
 --        end
	-- 	for j=1,numQIDs do
	-- 		local QID = nil
	-- 		local qid
	-- 		if WoWPro.QID[i] then
	-- 			qid = select(numQIDs-j+1, string.split(";", WoWPro.QID[i]))
	-- 			QID = tonumber(qid)
	-- 		end

 --            if QID then
 --                if recordQIDs then
 --                    WoWProDB.global.QID2Guide[QID] = GID
 --                end
 --    		    -- Turned in quests --
 --    			if WoWPro:IsQuestFlaggedCompleted(qid,true) then
 --    			    WoWProCharDB.Guide[GID].completion[i] = true
 --    			    WoWPro.why[i] = "Completed by WoWPro:LoadGuideSteps() because quest was flagged as complete."
 --    			end
    	
 --    		    -- Quest Accepts and Completions --
 --    		    if not WoWProCharDB.Guide[GID].completion[i] and WoWPro.QuestLog[QID] then 
 --    			    if action == "A" then WoWProCharDB.Guide[GID].completion[i] = true end
 --    			    if action == "C" and select(7,GetQuestLogTitle(WoWPro.QuestLog[QID])) == 1 then
 --    				    WoWProCharDB.Guide[GID].completion[i] = true
 --    				    WoWPro.why[i] = "Completed by WoWPro:LoadGuideSteps() because in QuestLog was complete."
 --    			    end
 --    		    end
 --    		end
	-- 	end
	-- end
	
	-- Scrollbar Settings --
	WoWPro.Scrollbar:SetMinMaxValues(1, math.max(1, WoWPro.stepcount - WoWPro.ShownRows))
	
	WoWPro.GuideLoaded = true
	
	WoWPro:PopulateQuestLog()
	WoWPro:AutoCompleteQuestUpdate()
	WoWPro:UpdateQuestTracker()
	WoWPro:UpdateGuide("WoWPro:LoadGuideSteps()")
	WoWPro:SendMessage("WoWPro_PostLoadGuide")
end


-- Checkbox Function --
function WoWPro:CheckFunction(row, button, down)
    local GID = WoWProDB.char.currentguide
	if button == "LeftButton" and row.check:GetChecked() then
		local steplist = WoWPro:SkipStep(row.index)
		row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
		if steplist ~= "" then 
			WoWPro:SkipStepDialogCall(row.index, steplist)
		end
	elseif button == "RightButton" and row.check:GetChecked() then
	    row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		WoWProCharDB.Guide[GID].completion[row.index] = true
		WoWPro:UpdateQuestTracker()
		if WoWProDB.profile.checksound then	
			PlaySoundFile(WoWProDB.profile.checksoundfile)
		end
	elseif not row.check:GetChecked() then
		WoWPro:UnSkipStep(row.index)
	end
	WoWPro:UpdateGuide()
end

-- Functions used by dropdown menus
local function _MapBlizCoordinate(self, row_num)
	--err("row_num=%s",row_num)
	WoWPro:MapPoint(row_num,true)
end

-- Row Content Update --
function WoWPro:RowUpdate(offset)
	local GID = WoWProDB.char.currentguide
	if MaybeCombatLockdown() 
		or not GID 
		or not WoWPro.Guides[GID]
		then return 
	end
	WoWPro:dbp("Running: WoWPro:RowUpdate()")
	WoWPro.ActiveStickyCount = 0
	local reload = false
	local k = offset or WoWPro.ActiveStep
	local itemkb = false
	local targetkb = false
	local module = WoWPro:GetModule(WoWPro.Guides[GID].guidetype)
	ClearOverrideBindings(WoWPro.MainFrame)
	WoWPro.RowDropdownMenu = {}

	local CurrentIndex = WoWPro.CurrentIndex
	
	local last_visible_i = 15 -- Last row visible
	for i=1,15 do
		
		-- Skipping any skipped steps, unsticky steps, and optional steps unless it's time for them to display --
		if not WoWProDB.profile.guidescroll then
			k = WoWPro:NextStep(k, i)
		end

				
		--Setup row--
		local row = WoWPro.rows[i]
		row.index = k
		row.num = i

		-- Run Module specific PreRowUpdate()
		if WoWPro[module:GetName()].PreRowUpdate then
		    WoWPro[module:GetName()]:PreRowUpdate(row)
		end
		
		--Loading Variables --
		local step = WoWPro.step[k]
		local action = WoWPro.action[k] 
		local note = WoWPro.note[k]
		local QID = WoWPro.QID[k] 
		local coord = WoWPro.map[k] 
		local sticky = WoWPro.sticky[k] 
		local unsticky = WoWPro.unsticky[k] 
		local use = WoWPro.use[k] 
		local zone = WoWPro.zone[k] 

		local questtext = WoWPro.questtext[k] 
		local optional = WoWPro.optional[k] 
		local conditional = WoWPro.conditional[k]
		local prereq = WoWPro.prereq[k] 
		local leadin = WoWPro.leadin[k] 
		local target = WoWPro.target[k] 
		if WoWPro.prof[k] then
			local prof, proflvl = string.split(" ", WoWPro.prof[k]) 
		end
		local completion = WoWProCharDB.Guide[GID].completion
		
		-- Checking off leadin steps --
		-- Perhaps this logic belongs in NextStep?  --Ludo
		-- if leadin then
		--     local numQIDs = select("#", string.split(";", leadin))
		--     for j=1,numQIDs do
		-- 	    local lQID = select(numQIDs-j+1, string.split(";", leadin))
		-- 		if WoWProCharDB.completedQIDs[tonumber(lQID)] and not completion[k] then
		-- 	        completion[k] = true
		-- 	        return true --reloading
		--         end
		-- 	end
		-- end		
		
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
		
		-- Is this the last visible row?
		if not sticky and last_visible_i > i then
			last_visible_i = i
		end

		-- Getting the image and text for the step --
		row.step:SetText(step)
		if step then row.check:Show() else row.check:Hide() end
		if completion[k] or WoWProCharDB.Guide[GID].skipped[k] or WoWProCharDB.skippedQIDs[WoWPro.QID[k]] then
			row.check:SetChecked(true)
			if WoWProCharDB.Guide[GID].skipped[k] or WoWProCharDB.skippedQIDs[QID] then
				row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
			else
				row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
			end
		else
			row.check:SetChecked(false)
			row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		end

		-- Add a line for optional steps
		if optional then
			note = "|cFF69CCF0Optional Step|r|n"..note
		end

		-- Add a line for conditional step (so that ppl may chose to skip it)
		if conditional then
			note = "|cFF9482C9Conditional Step|r|n"..note
		end

		if note then note = strtrim(note) note = string.gsub(note,"\\n","\n") end
		
		
		if WoWProDB.profile.showcoords and coord then
		    note = note or ""
		    if WoWPro.waypcomplete[k] == 1 then
		        note = note.." ("..string.gsub(coord,";"," > ")..")"
		    elseif WoWPro.waypcomplete[k] == 2 then
		        note = note.." ("..string.gsub(coord,";"," >> ")..")"
		    elseif WoWPro.waypcomplete[k] == false then
		        note = note.." ("..string.gsub(coord,";","; ")..")"
		    else
		        note = note.." ("..coord..")"
		    end
		end
		
		if not ( WoWProDB.profile.showcoords and coord ) and not note then note = "" end
		row.note:SetText(note)
		--row.action:SetTexture(WoWPro.actiontypes[action])
		
		-- Ajust the action icon based on |NC|, |CHAT|, |DAILY|, etc.
		local texaction = WoWPro.action[k]
		if WoWPro.noncombat[k] and texaction == "C" then
			texaction = "noncombat"
		elseif WoWPro.chat[k] then
		   texaction = "chat" 
		elseif texaction == "A" and WoWPro:IsQuestDaily(QID) then
			texaction = "acceptdaily"
		elseif texaction == "T" and WoWPro:IsQuestDaily(QID) then
			texaction = "turnindaily"
		end
		WoWPro:SetActiontypeTex(row.action, texaction)

		row.check:SetScript("OnClick", function(self, button, down)
			WoWPro:CheckFunction(row, button, down)
		end)
		
		-- Right-Click Drop-Down --
		local dropdown = {
		}
		if step then
			table.insert(dropdown, 
				{text = step.." Options", isTitle = true}
			)
			QuestMapUpdateAllQuests()
			QuestPOIUpdateIcons()
			local _, x, y, obj
			if QID and tonumber(QID) then _, x, y, obj = QuestPOIGetIconInfo(tonumber(QID)) end
			if coord or x then
				table.insert(dropdown, 
					{text = "Map Coordinates", func = function()
						WoWPro:MapPoint(row.num)
					end} 
				)
			end
			if x and y then
				local tbl = {}
				tbl.text 			= "Map Blizzard Coordinates"
				tbl.arg1				= row.num
				tbl.func 			= _MapBlizCoordinate
				tinsert(dropdown, tbl)
			end
			-- if tonumber(QID) and WoWPro.QuestLog[tonumber(QID)] and WoWPro.QuestLog[tonumber(QID)].index and WoWPro.GetNumPartyMembers() > 0 then
			if tonumber(QID) and WoWPro.QuestLog[tonumber(QID)] and WoWPro.GetNumPartyMembers() > 0 then
				table.insert(dropdown, 
					{text = "Share Quest", func = function()
						-- QuestLogPushQuest(WoWPro.QuestLog[QID].index)
						QuestLogPushQuest(WoWPro.QuestLog[QID])
					end} 
				)
			end
			if sticky then
				table.insert(dropdown, 
					{text = "Un-Sticky", func = function() 
						WoWPro.sticky[row.index] = false
						WoWPro.UpdateGuide()
						WoWPro.UpdateGuide()
						WoWPro.MapPoint()
					end} 
				)
			else
				table.insert(dropdown, 
					{text = "Make Sticky", func = function() 
						WoWPro.sticky[row.index] = true
						WoWPro.unsticky[row.index] = false
						WoWPro.UpdateGuide()
						WoWPro.UpdateGuide()
						WoWPro.MapPoint()
					end} 
				)
			end
		end

		-- Remove the empty radio button for all
		for i,v in ipairs(dropdown) do
			v.notCheckable 	= true
		end
		WoWPro.RowDropdownMenu[i] = dropdown
		
		-- Item Button --
		local noUseItem = nil
		if action == "H" and not use then use = 6948 end
		if ( not use ) and (questtext or action == "C" or action == "K") and WoWPro.QuestLog[tonumber(QID)] then
			-- local link, icon, charges = GetQuestLogSpecialItemInfo(WoWPro.QuestLog[tonumber(QID)].index)
			local link, icon, charges = GetQuestLogSpecialItemInfo(WoWPro.QuestLog[tonumber(QID)])
			if link then
				local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name 
					= string.find(link, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
				use = Id
				WoWPro.use[k] = use
				-- Verify if the item is used in the target macro
				if target  and (target:find("use item[:]%d+") or (name and target:find("use "..name,1,1))) then
					noUseItem = true
				end
			end
		end
		
		-- if use and GetItemInfo(use) then
		local target_item = select(3,(target or ""):lower():find("use item:(%d+)")) -- Check if the |T| has a "use item:""
		if use and tonumber(use) ~= tonumber(target_item or "") then
			row.itembutton.item_id = use -- To display the item Tooltip
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
			if i <= last_visible_i and row.itembutton:IsVisible() then
				local key1, key2 = GetBindingKey("CLICK WoWPro_FauxItemButton:LeftButton")
				if key1 then
					SetOverrideBinding(WoWPro.MainFrame, false, key1, "CLICK WoWPro_itembutton"..i..":LeftButton")
				end
				if key2 then
					SetOverrideBinding(WoWPro.MainFrame, false, key2, "CLICK WoWPro_itembutton"..i..":LeftButton")
				end
				--itemkb = true
			end

			-- Set the item macro
			if i <= last_visible_i then
				if not noUseItem then
					local itemEquipLoc = select(9, GetItemInfo(use))
					if not itemEquipLoc or itemEquipLoc == "" then
						WoWPro:SetMacro("WPI", "#showtooltip\n/use item:"..use)
					else
						WoWPro:SetMacro("WPI", ("#showtooltip\n/equip item:%s\n/use item:%s"):format(use, use))
					end
					itemkb = true
				end
			end
		else 
			use = nil
			row.itembutton.item_id = nil
			row.itembutton:Hide() 
		end
		
		-- Target Button --
		if target then
			row.targetbutton.tooltip_text = target
		    local mtext
		    --local target, emote = string.split(";",target)
		    local target, emote = target:match("([^;]*)[;](.*)")
		    if not target then target = row.targetbutton.tooltip_text end
			row.targetbutton:Show()
			if emote then
			   mtext = target:gsub("\\n","\n")
			   mtext = mtext:gsub("[|]n","\n")

				row.targetbutton.tooltip_text = "/targetexact "..target.."\n/"..emote
				mtext = "\n/cleartarget"
						.."\n/targetexact [nodead] "..target
						.."\n/cleartarget [@target,dead]"
						.."\n/script if not GetRaidTargetIndex('target') then SetRaidTarget('target', 1) end"
						.."\n/"..emote
				if mtext:find("/use ") then
					mtext = "#showtooltip\n"..mtext
				end
			else			
				mtext = "/cleartarget"
						.."\n/targetexact [nodead] "..target
						.."\n/cleartarget [@target,dead]"
						.."\n/script if not GetRaidTargetIndex('target') then SetRaidTarget('target', 8) end"

			   -- mtext = "/cleartarget\n/target "..target.."\n"
			   -- mtext = mtext .. "/run if not GetRaidTargetIndex('target') == 8 and not UnitIsDead('target') then SetRaidTarget('target', 8) end"
			end
			row.targetbutton:SetAttribute("macrotext", mtext)
			-- Run Module specific RowUpdateTarget() to override macrotext
    		if WoWPro[module:GetName()].RowUpdateTarget then
    		    WoWPro[module:GetName()]:RowUpdateTarget(row)
    		end
    		
    		-- WoWPro:dbp("Target text set to: %s",row.targetbutton:GetAttribute("macrotext"))
    		
			if use then
				row.targetbutton:SetPoint("TOPRIGHT", row.itembutton, "TOPLEFT", -5, 0)
			else
				row.targetbutton:SetPoint("TOPRIGHT", row, "TOPLEFT", -10, -7)
			end 
			if i <= last_visible_i and row.targetbutton:IsVisible() then
				local key1, key2 = GetBindingKey("CLICK WoWPro_FauxTargetButton:LeftButton")
				if key1 then
					SetOverrideBinding(WoWPro.MainFrame, false, key1, "CLICK WoWPro_targetbutton"..i..":LeftButton")
				end
				if key2 then
					SetOverrideBinding(WoWPro.MainFrame, false, key2, "CLICK WoWPro_targetbutton"..i..":LeftButton")
				end
				--targetkb = true
			end

			-- Set the Taget macro
			if i <= last_visible_i then
				WoWPro:SetMacro("WPT", mtext)
				targetkb = true
			end
		else
			row.targetbutton.tooltip_text = nil
			row.targetbutton:Hide() 
		end

		-- Remove macros if no button found
		if not itemkb then WoWPro:SetMacro("WPI") end
		if not targetkb then WoWPro:SetMacro("WPT") end
		
		-- Setting the zone for the coordinates of the step --
		zone = zone or strsplit("-(",WoWPro.Guides[GID].zone)
		row.zone = strtrim(zone)

		WoWPro.rows[i] = row
		
		k = k + 1
	end
	
	WoWPro.ActiveStickyCount = WoWPro.ActiveStickyCount or 0
	WoWPro.CurrentIndex = WoWPro.rows[1+WoWPro.ActiveStickyCount].index
	if CurrentIndex ~= WoWPro.CurrentIndex then
		WoWPro:MapPoint()
		WoWPro:SendMessage("WoWPro_QuestDialogAutomation") -- Just in case a dialog is open for the step that was just added
	end


	WoWPro:UpdateQuestTracker()

	return reload
end

-- Left-Click Row Function --
function WoWPro:RowLeftClick(i)
	local QID

	-- If more then one QIDs, find if a QID is active
	if WoWPro.QID[WoWPro.rows[i].index] then
		for qid in (WoWPro.QID[WoWPro.rows[i].index]):gmatch("[^;]+") do
			if WoWPro.QuestLog[tonumber(qid)] then 
				QID = tonumber(qid)
				break
			end
		end
	end

	if QID then
	   ShowUIPanel(QuestLogFrame)
	   -- QuestLog_OpenToQuest(WoWPro.QuestLog[QID].index)
		QuestLogPopupDetailFrame_Show(WoWPro.QuestLog[QID])
	end
	WoWPro.rows[i]:SetChecked(nil)
end


-- Functions to deal with remembering the daily quests

-- Remember the quest as daily
function WoWPro:SetPermanentDailyQuest( qid )
	if not qid then return end

	if type(qid) ~= "number" then
		err("Invalid type for qid %s",qid)
		return
	end

	WoWProDB.global.DailyQuests[qid] = true
end

-- Set all the quests in qids as daily but don't remember it between sessions
function WoWPro:SetSessionDailyQuests( qids )
	if not qids then return end

	for i = 1, select("#",(";"):split(qids)) do
		local qid = select(i,(";"):split(qids))
		WoWPro.DailyQuests[tonumber(qid)] = true
	end
end

-- If any of the quest in qids is a daily, return true
function WoWPro:IsQuestDaily( qids )
	if not qids then return nil end

	if type(qids) == "number" then
		return WoWProDB.global.DailyQuests[qids] or WoWPro.DailyQuests[qids]
	end

	for i = 1, select("#",(";"):split(qids)) do
		local qid = select(i,(";"):split(qids))
		if  WoWProDB.global.DailyQuests[tonumber(qid)] or WoWPro.DailyQuests[tonumber(qid)] then
			return true
		end
	end

	return nil
end
