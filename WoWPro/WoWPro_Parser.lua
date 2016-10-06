-----------------------------
--      WoWPro_Parser      --
-----------------------------

local _G = getfenv(0)
local WoWPro = _G.WoWPro
local _ = _G._
local function err(msg,...) _G.geterrorhandler()(msg:format(_G.tostringall(...)) .. " - " .. _G.time()) end
	
local L = WoWPro_Locale
local HBD = WoWPro.HBD
WoWPro.actiontypesorder = { "A", "C", "T", "K", "R", "H", "h", "F", "f", "N", "B", "b", "U", "L", "l", "r", "D", "noncombat", "chat", "acceptdaily", "turnindaily" }
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
	D = "Guide is done",
	noncombat = "Interact With Item(s)",
	chat = "Chat",
	acceptdaily = "Accept Daily Quest",
	turnindaily = "Turn In Daily Quest",
}
WoWPro.actiontypes = {
	A = "Interface\\GossipFrame\\AvailableQuestIcon",
	-- C = [[Interface\MINIMAP\OBJECTICONS]],
	-- C = "Interface\\CHARACTERFRAME\\UI-StateIcon",
	C = "Interface\\WorldStateFrame\\CombatSwords",
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
	D = "Interface\\TAXIFRAME\\UI-Taxi-Icon-Green",
	J = "Interface\\TAXIFRAME\\UI-Taxi-Icon-Red",
	["!"] = "Interface\\GossipFrame\\DailyQuestIcon",
	["$"] = "Interface\\Worldmap\\TreasureChest_64",
--	[";"] = "Interface\\Icons\\INV_Scroll_11",
	--noncombat = "Interface\\AddOns\\WoWPro\\Textures\\Config.tga",
	-- noncombat = "Interface\\MINIMAP\\OBJECTICONS",
	noncombat = [[Interface\GossipFrame\BinderGossipIcon]],
	--noncombat = [[Interface\CURSOR\openhand]],
	chat = "Interface\\GossipFrame\\Gossipgossipicon",
	acceptdaily = "Interface\\GossipFrame\\DailyQuestIcon",
	turnindaily = "Interface\\GossipFrame\\DailyActiveQuestIcon",
}
if UnitFactionGroup("player") == 'Alliance' then
    WoWPro.actiontypes['P'] = "Interface\\MINIMAP\\Vehicle-AllianceMagePortal"
else
    WoWPro.actiontypes['P'] = "Interface\\MINIMAP\\Vehicle-HordeMagePortal"
end
WoWPro.actiontypecoords = {
	-- C = { 7/8, 8/8, 5/8, 6/8 },
	-- C = { 1/2, 1, 0, 1/2 },
	C = { 0/2, 1/2, 0/2, 1/2 },
	K = { 7/8, 8/8, 6/8, 7/8 },
	F = { 4/8, 5/8, 2/8, 3/8 },
	f = { 5/8, 6/8, 1/8, 2/8 },
	B = { 0/8, 1/8, 2/8, 3/8 },
	h = { 0, 1/2, 0, 1/2},
	r = { 3/8, 4/8, 3/8, 4/8 },
	-- noncombat = { 1/8, 2/8, 4/8, 5/8 },
}
function WoWPro:SetActiontypeTex(tex, actiontype, index, offset)
	if not WoWPro.actiontypes[actiontype] and index then
		err("Invalid actiontype '%s' for index %s (offset = %s)", actiontype, index, offset)
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
	t = "Turn in when complete",
	K = "Kill",
	R = "Run to",
	H = "Hearth to",
	h = "Set hearth to",
	F = "Fly to",
	f = "Get flight path for",
	N = "Note",
	B = "Buy",
	b = "Take Boat or Zeppelin",
	U = "Use",
	L = "Level",
	l = "Loot",
	r = "Repair/Restock",
	D = "Done",
	J = "Jump",
	P = "Take portal",
	["!"] = "Declare",
	["$"] = "Treasure",
	--[";"] = "Comment"
}

function WoWPro.InsertActionDescriptions(tabla, order)
    for action, icon in pairs(WoWPro.actiontypes) do
        local label = WoWPro.actionlabels[action]
        local nickname = label:gsub("%s+", "")
        tabla[nickname] = {
            order = order,
            type = "description",
            fontSize = "medium",
            name = label .. " (" .. action .. ")",
            image = icon,
            imageWidth = 16,
            imageHeight = 16
        }
        order = order + 1
    end
    return tabla
end

-- Skip a step --
function WoWPro:SkipStep(index)
	local GID = WoWProDB.char.currentguide
	WoWPro:dbp("SkipStep(%s) Action is %s QID is %s ",tostring(index),  tostring(WoWPro.action[index]), tostring(WoWPro.QID[index]))
	
	if not WoWPro.QID[index] then return "" end
	if WoWPro.action[index] == "D" then return "" end -- No skipping this type
	if WoWPro.action[index] == "A" 
	or WoWPro.action[index] == "C" 
	or WoWPro.action[index] == "T" then
	    -- local numqids = select("#", string.split(";", WoWPro.QID[j]))
	    -- for k=1,numqids do
	    --     local kqid = select(numqids-k+1, string.split(";", WoWPro.QID[j]))
	    --     if tonumber(kqid) then
	    --         WoWProCharDB.skippedQIDs[tonumber(kqid)] = true
	    --     end
	    -- end
	   WoWPro:SetQIDsInTable(WoWPro.QID[j],WoWProCharDB.skippedQIDs)
		WoWProCharDB.Guide[GID].skipped[index] = true
		WoWPro:dbp("Skipping step %d", index)
	else 
		WoWProCharDB.Guide[GID].skipped[index] = true
		WoWPro:dbp("Just skipping step %d", index)
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
							-- WoWProCharDB.skippedQIDs[WoWPro.QID[j]] = true
							WoWPro:SetQIDsInTable(WoWPro.QID[j],WoWProCharDB.skippedQIDs)	
						end
						steplist = steplist.."- "..WoWPro.step[j].."\n"
						skipstep(j)
					end
				end
			end 
		end
	end
	
	skipstep(index)

	WoWPro:UpdateGuide("SkipStep")
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
   --  		local numqids = select("#", string.split(";", WoWPro.QID[index]))
   --  	    for k=1,numqids do
   --  	        local kqid = select(numqids-k+1, string.split(";", WoWPro.QID[index]))
   --  	        if tonumber(kqid) then
   --  	            WoWProCharDB.skippedQIDs[tonumber(kqid)] = nil
   --  	        end
   --  	    end
			-- WoWProCharDB.Guide[GID].skipped[index] = nil
			WoWPro:WipeQIDsInTable(WoWPro.QID[index],WoWProCharDB.skippedQIDs)
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
						-- WoWProCharDB.skippedQIDs[WoWPro.QID[j]] = nil
						WoWPro:WipeQIDsInTable(WoWPro.prereq[j],WoWProCharDB.skippedQIDs)
					end
					WoWProCharDB.Guide[GID].skipped = {}
					unskipstep(j)
				end
			end
		end end
	end
	
	unskipstep(index)
	WoWPro:UpdateGuide("UnSkipStep")
	WoWPro:UpdateQuestTracker()
end


-- Take a zone token and return the zone name or ID and the floor.
-- Valid formats: |Z|Zone Name|, |Z|Zone Name/level|, |Z|Zone Name/level|, |Z|mapID|, |Z|mapID/level|
-- Zone Name is a string
-- mapID and level are numbers
-- Returns: zone, mapID, level
local zone_cache = {} -- "toke" => validated_OK, message, zone, mapID, level
function WoWPro.ParseZoneToken(token, validating)
	-- assert(type(token) == "string", ("Invalid first parameter, expected a string, got \"%s\""):format(type(token)))
	if (not token or token == "") and validating then return true, nil end
	if (not token or token == "") and not validating then return nil, nil, nil end

	if zone_cache[token] then
		if validating then
			return zone_cache[token][1], zone_cache[token][2]
		else
			return zone_cache[token][3], zone_cache[token][4], zone_cache[token][5]
		end
	end
	
	-- Is there a level? (Let's make sure we only catch only the text after the last / or ;)
	local zone, level = select(3,token:find("(.*)[/;]([^/;]+)"))
	if level then
		level = tonumber(level)
		if validating and level == nil then
			zone_cache[token] = { false, ("level must be a number: |Z|%s|. If the zone name use a \"/\", use |Z|Zone name;0|."):format(token),
										 zone, mapID, level }
			return false, zone_cache[token][2]
		end
	else
		-- No level found
		zone = token
		level = 0
	end

	local mapID
	-- Is the zone a mapID?
	if tonumber(zone) ~= nil then
		mapID = tonumber(zone)
		zone = HBD:GetLocalizedMap(mapID)
		if validating and zone == nil then
			zone_cache[token] = { false, ("HereBeDragons doesn't recongnize mapID \"%s\" in |Z|%S|"):format(mapID, token),
										 zone, mapID, level }
			return false, zone_cache[token][2]
		end
	else
		mapID = WoWPro.Zone2MapID[zone]
		if validating and mapID == nil then
			zone_cache[token] = { false, ("Cannot find a valid mapID for |Z|%s|"):format(token),
										 zone, mapID, level }
			return false, zone_cache[token][2]
		end
	end

	zone_cache[token] = { true, nil, zone, mapID, level }
	if validating then
		return true
	else
		return zone, mapID, level
	end
end


function WoWPro.ValidateZoneToken(action,step,tag_value)
	WoWPro.ParseZoneToken(tag_value, true)
end


WoWPro.TagTable = {} -- Indexed by tag
WoWPro.TagList = {}  -- In order of definition
local function DefineTag(action, key, vtype, validator, setter)
    WoWPro.TagTable[action] = {key=key, vtype=vtype, validator=validator, setter=setter}
    if key then
        WoWPro.Tags[key]=true
        WoWPro[key] = {}
        table.insert(WoWPro.TagList, action)
    end
end

local function validate_list_of_qids(action, step, tag, value)
    --- Either X;Y;Z or X&Y&Z, or *, no empties
    if value == "*" then return true; end
    return WoWPro.QidVerify(value, false,";","+")
end

local function validate_list_of_ints(action, step, tag, value)
    ---  X;Y, no empties
    --- WoWPro.QidVerify(list,empty_ok,or_string,and_string)
    return WoWPro.QidVerify(value, false,";","|")
end

-- QID Tags first
DefineTag("QID","QID","string",validate_list_of_qids,nil)
DefineTag("PRE","prereq","string",validate_list_of_qids,nil)
DefineTag("AVAILABLE","available","string",validate_list_of_qids,nil)
DefineTag("O","optional","boolean",nil,function (text,i)
    WoWPro.optional[i] = true;
    WoWPro.optionalcount = WoWPro.optionalcount + 1;
end)
DefineTag("LEAD","leadin","string",validate_list_of_qids,nil)
DefineTag("ACTIVE","active","string",validate_list_of_qids,nil)
DefineTag("NPC","NPC","string",validate_list_of_ints,nil)

-- Mapping Tags
DefineTag("M","map","string",nil,nil)
DefineTag("Z","zone","string",nil,nil)
-- DefineTag("Z","zone","string",WoWPro.ValidateZoneToken,function(value,i)
-- 	WoWPro.zone[i] = value
-- 	WoWPro.zoneName[i], WoWPro.mapID[i], WoWPro.map_level[i] = WoWPro.ParseZoneToken(value)
-- end)
DefineTag("CC","waypcomplete","boolean",nil,function (value,i) WoWPro.waypcomplete[i] = 1; end)
DefineTag("CS","waypcomplete","boolean",nil,function (value,i) WoWPro.waypcomplete[i] = 2; end)
DefineTag("CN","waypcomplete","boolean",nil,function (value,i) WoWPro.waypcomplete[i] = false; end)

-- Item or Quest Objective Tags
DefineTag("L","lootitem","string",nil,
	-- Setter
	function (text,i)
	   WoWPro.lootitem[i], WoWPro.lootqty[i] = select(3,text:find("(%d+)%s?(%d*)"))
		if WoWPro.lootitem[i] then
	    	if tonumber(WoWPro.lootqty[i]) ~= nil then
	    	    WoWPro.lootqty[i] = tonumber(WoWPro.lootqty[i])
	    	else
	    	    WoWPro.lootqty[i] = 1
	    	end
	    end
	end)    
DefineTag("QO","questtext","string",
	-- Validator
	function(action,step,tag,value,i)
		if WoWPro.action[i] == 'A' or WoWPro.action[i] == 'T' then
			local msg = ("%d:Step [%s %s] should not use the ||%s||%s|| tags."):format(i,action,step,tag,value)
			return false, msg
		end
		local qtext,qindicator = value:match("(.+):%s*([0-9]+[/][0-9]+)")
		if qtext and qindicator then
			WoWPro:Warning("%d:Step %s [%s] is using old ||%s||%s|| format.",i,action,step,tag,value)
			-- Return valid since the message has already been printed and we fix it in the setter.
		end
		return true 
	end,
	-- Setter
	function(value,i,action,step,tag)
		local qtext,qindicator = value:match("(.+):%s*([0-9]+[/][0-9]+)")
		if qtext and qindicator then
			WoWPro.questtext[i] = ("%s %s"):format(qindicator, qtext)
		else
			WoWPro.questtext[i] = value
		end
	end)
-- DefineTag("QO","questtext","string",nil,nil)
DefineTag("SO","sobjective","string",validate_list_of_ints,nil)
DefineTag("U","use","number",nil,nil)
DefineTag("ITEM","item","string",nil,nil)
DefineTag("NC","noncombat","boolean",nil,nil)
DefineTag("NA","noauto","boolean",nil,nil)
DefineTag("CHAT","chat","boolean",nil,nil)
DefineTag("LVL","level","number",nil,nil)
DefineTag("T","target","string",nil,nil)
DefineTag("QG","gossip","string",nil, function (value,i) WoWPro.gossip[i] = strupper(value) end)

-- Conditionals
DefineTag("REP","rep","string",nil,nil)
DefineTag("P","prof","string",nil,nil)
DefineTag("SPELL","spell","string",nil,nil)
DefineTag("ACH","ach","string",nil,nil)
DefineTag("BUFF","buff","string",nil,nil)
DefineTag("RECIPE","recipe","number",nil,nil)
DefineTag("PET","pet","string",nil,nil)
DefineTag("BUILDING","building","string",nil,nil)
DefineTag("GUIDE","guide","string",nil,nil)

-- Pet Stuff
DefineTag("PET1","pet1","string",nil,nil)
DefineTag("PET2","pet2","string",nil,nil)
DefineTag("PET3","pet3","string",nil,nil)
DefineTag("STRATEGY","strategy","string",nil,nil)
DefineTag("SELECT","select","number",nil,nil)
DefineTag("SWITCH","switch","number",nil,nil)
DefineTag("DEAD","dead","string",nil,nil)

-- Stuff at the end
DefineTag("US","unsticky","boolean",nil,nil)
DefineTag("S","sticky","boolean",nil, function (text,i)
    WoWPro.sticky[i] = true;
    WoWPro.stickycount = WoWPro.stickycount + 1;
end)
DefineTag("N","note","string",nil,nil)
DefineTag("FACTION","faction","string",nil,nil)
DefineTag("R",nil,"string",nil,function (value,i) end)  -- Swallow R tags
DefineTag("C","class","string",nil,nil)
DefineTag("GEN",nil,"string",nil,function (value,i) end)  -- Swallow Gen tags
DefineTag("RANK","rank","number",nil,nil)

-- Added by LaoTseu
DefineTag("DAILY","daily","boolean",nil,function(value,i) WoWPro:SetSessionDailyQuests(WoWPro.QID[i]) end)   
DefineTag("ALTFP","altfp","string",nil,function(value,i)
	WoWPro.altfp[i] = (value):format(_G.UnitName("player")) -- Hack for the Draenor garisson
	-- err("i=%s, value=%s, result=%s", i, value, WoWPro.altfp[i])
end)
DefineTag("NOBUFF","nobuff","string",nil,nil)


function WoWPro.ParseQuestLine(faction, zone, i, text, realline)
	local GID = WoWProDB.char.currentguide

	-- Validate guide zone
	local valid, msg = WoWPro.ParseZoneToken(zone, true)		
	if not valid then 
		--err("Invalid zone = %s, msg = %s",zone,msg)
		local currentZone = HBD:GetLocalizedMap(HBD:GetPlayerZone())
		WoWPro:Warning(("Invalid zone %s for guide %s, will use current zone %s"):format(zone or "nil", GID, currentZone))
		zone = currentZone
	end
	
	if text:match("(.*);;") then
		text = text:match("(.*);;") or "" -- Remove the ;; and everything after it, these are comments
	end
	text = string.trim(text) 
	if text == "" or string.sub(text,1,1) == ";" then
	    -- empty lines or comments are ignored
	    return
	end

   -- Split the line up on the pipes
   local tags = { strsplit("|", text) }
	if #tags < 3 then
	    -- Two pipes are needed for a valid line
	    WoWPro:Error("Line %d in guide %s has only %d sections.", i, GID, #tags)
	    return
	end
	
	-- The first tag is is the Action followed by the Step name
	local primo = tags[1]
	if string.len(primo) < 3 then
	    -- Too short to be valid
	    WoWPro:Error("Line %d in guide %s has too short a preamble.  Only %d characters. '%s'",i,GID, string.len(primo), primo)
	    return
	end
	if string.sub(primo,2,2) ~= " " then
	    -- Second needs to be a blank
	    WoWPro:Error("Line %d in guide %s must have a blank as the 2nd character: '%s' is not right.",i,GID, primo)
	    return
	end
    
    -- Now extract the action and step
	WoWPro.action[i] = string.sub(primo,1,1)
	WoWPro.step[i] = string.sub(primo,3)
	WoWPro.step[i] = WoWPro.step[i]:trim()

    -- Now make sure it is a valid action!
    if not WoWPro.actionlabels[WoWPro.action[i]] then
		err("Invalid action label %s at line %d in guide %s: \"%s\"\nParsing Halted.",WoWPro.action[i],realline,GID,tostring(text))
		--WoWPro:Error("Invalid action label %s at line %d in guide %s: \"%s\"\nParsing Halted.",WoWPro.action[i],realline,GID,tostring(text))
	    return    
    end

	local idx = 2
	
	-- Parse the tags
	repeat
	    local tag = tags[idx]
	    tag = tag and tag:trim() -- clean it up
	    -- If there is a ; where a tag should be, it's comment.
	    local comment = tag:match("(.*[;].*)")
	    if comment then
	    	for i=idx+1,#tags do
	    		comment = ("%s||%s"):format(comment, tags[i])
	    	end
	    	WoWPro:Warning("EOL Comment: %s", comment)
	    	idx = #tags+1
	    else
		    local tag_spec = WoWPro.TagTable[tag]
		    local value = nil
		    if tag_spec then
		        if tag_spec.key and not WoWPro[tag_spec.key] then
		            WoWPro:Error("Tag %s has a bad key value of '%s'. Report this!", tag, tostring(tag_spec.key))
		            tag = nil
		        end

		        if tag_spec.key == nil or WoWPro[tag_spec.key] == nil then
		        		err("Line = %s", text)
		        		err("tag = %s, tag_spec.key = %s, WoWPro[tag_spec.key] = %s, idx = %s, action = %s, step = %s", tag, tag_spec.key, WoWPro[tag_spec.key], idx, WoWPro.action[i], WoWPro.step[i])
		        end
		        if tag_spec.key and WoWPro[tag_spec.key][i] then
		            WoWPro:Warning("%d:Step %s [%s] has duplicate tag ||%s||.",i,WoWPro.action[i],WoWPro.step[i],tag)
		        end
		        if tag_spec.vtype == "boolean" then
		            -- We only care that it exists
		            value = true
		        elseif tag_spec.vtype == "number" then
		            -- pop the next value off the stack
		            idx = idx + 1
		            value = tonumber(tags[idx])
		            if not value then
		                WoWPro:Warning("%d:Step %s [%s] has an bad value for tag ||%s||%s||.",i,WoWPro.action[i],WoWPro.step[i],tag, value)
		            end
		        elseif tag_spec.vtype == "string" then
		            -- pop the next value off the stack
		            idx = idx + 1
		            value = tags[idx]
		            if not value then
		                WoWPro:Warning("%d:Step %s [%s] has an missing value for tag ||%s||.",i,WoWPro.action[i],WoWPro.step[i],tag)
		            elseif string.len(value) == 0 then
		                WoWPro:Warning("%d:Step %s [%s] has an empty value for tag ||%s||.",i,WoWPro.action[i],WoWPro.step[i],tag)
		            end
		        elseif tag_spec.vtype == "guide" then
		            -- pop the next value off the stack
		            idx = idx + 1
		            value = tags[idx]
		            if not value then
		                WoWPro:Warning("%d:Step %s [%s] has a missing value for tag ||%s||.",i,WoWPro.action[i],WoWPro.step[i],tag)
		            elseif not WoWPro.Guides[value] then
		                WoWPro:Warning("%d:Step %s [%s] has an invalid value for tag ||%s||.",i,WoWPro.action[i],WoWPro.step[i],tag)
		            end
		        else
		            WoWPro:Error("Tag %s has a bad key vtype of '%s'. Report this!", tag, tag_spec.vtype)
		        end
		        if tag and tag_spec.validator then
		        		local valid, msg = tag_spec.validator(WoWPro.action[i],WoWPro.step[i],tag,value,i)
		            if not valid then
		                if msg then
		                	WoWPro:Warning(msg)
		                else
		                	WoWPro:Warning("%s: Step [%s %s] has an invalid tag ||%s||%s||.",i,WoWPro.action[i],WoWPro.step[i],tag, value)
		                end
		                tag = nil
		                value = nil
		            end
		        end
		        if tag then
		            if tag_spec.setter then
		                tag_spec.setter(value,i,WoWPro.action[i],WoWPro.step[i],tag)
		            else
		                WoWPro[tag_spec.key][i] = value
		            end
		        end
		    else
		        if not tag and idx <  #tags then
		            WoWPro:Warning("%d:Step %s [%s] has an empty tag.",i,WoWPro.action[i],WoWPro.step[i])
		        elseif tag and tag ~= "" and tag:sub(1,1) ~= ";" then
		            -- empty tags and tags that are comments are permissible
		            WoWPro:Error("%s:Step %s [%s] has an unknown tag ||%s||.",i,WoWPro.action[i],WoWPro.step[i],tag)
		        end
		    end
		    idx = idx + 1
		 end
	until idx > #tags
	
	if WoWPro.action[i] == "t" then
	    WoWPro.action[i] = "T"
	    WoWPro.conditional[i] = true
	end
	if (WoWPro.action[i] == "A" or WoWPro.action[i] == "T") then
	    WoWPro:GrailCheckQuestName(GID,WoWPro.QID[i],WoWPro.step[i])
	end
	if WoWPro.map[i] then
	    WoWPro:ValidateMapCoords(GID,WoWPro.action[i],WoWPro.step[i],WoWPro.map[i])
	end    
	WoWPro.zone[i] = WoWPro.zone[i] or (WoWPro.map[i] and zone)
	local valid, msg = WoWPro.ParseZoneToken(WoWPro.zone[i])
	if WoWPro.zone[i] and WoWPro.map[i] and not valid then
		WoWPro:Error("Step %s [%s] has a bad Z||%s|| tag.",WoWPro.action[i],WoWPro.step[i],WoWPro.zone[i])
		WoWPro:Error("   " .. msg)
	   WoWPro.zone[i] = nil
	elseif valid then
		WoWPro.zoneName[i], WoWPro.mapID[i], WoWPro.map_level[i] = WoWPro.ParseZoneToken(value)
	end
	WoWPro.prereq[i] = WoWPro.prereq[i] or (WoWPro.action[i] == "A" and WoWPro:GrailQuestPrereq(WoWPro.QID[i]))

	if WoWPro.map[i] then
		if WoWPro.waypcomplete[i] == nil then 
		    WoWPro.waypcomplete[i] = false
		    if WoWPro.map[i]:find(";") then
		        WoWPro:Warning("Step %s [%s:%s] in %s is missing a CS|CC|CN tag.",WoWPro.action[i],WoWPro.step[i],tostring(WoWPro.QID[i]),WoWProDB.char.currentguide)
		    end
		end
	end

	if faction then
	    -- The parser may have set this already, but we allow the caller to override
		WoWPro.faction[i] = faction
	end

	local GQL = tonumber(WoWPro:GrailQuestLevel(WoWPro.QID[i]))
   WoWPro.level[i] = WoWPro.level[i] or (WoWPro.action[i] == "A" and GQL) or nil
	
	if GQL and GQL < 1 and tonumber(WoWPro.QID[i]) < 100000  then
	    WoWPro:dbp("Guide %s QID %s: Grail reports %s!",GID,WoWPro.QID[i],GQL)
	    GQL = nil
    end

	if WoWPro.DebugLevel > 0 and GQL and tonumber(WoWPro.QID[i]) and tonumber(WoWPro.QID[i]) < 100000 then
	    if WoWPro.Guides[GID].startlevel then
	        if  WoWPro.Guides[GID].startlevel > 1 then
	            if GQL < 2 then
                    -- Treat a 1 from grail as meaning no level requirement.
        	        GQL = WoWPro.Guides[GID].startlevel
        	    end
        	end
	    end
        if WoWPro.Guides[GID].startlevel and (GQL+2) < WoWPro.Guides[GID].startlevel then
              WoWPro:Warning("Guide %s QID %s is level %d, but startlevel=%d!",GID,WoWPro.QID[i],GQL, WoWPro.Guides[GID].startlevel)
        end
        if WoWPro.Guides[GID].endlevel and GQL > WoWPro.Guides[GID].endlevel then
              WoWPro:Warning("Guide %s QID %s is level %d, but endlevel=%d",GID,WoWPro.QID[i],GQL, WoWPro.Guides[GID].endlevel)
        end
        WoWPro.Guides[GID].amax_level = max(WoWPro.Guides[GID].amax_level,GQL)
        WoWPro.Guides[GID].amin_level = min(WoWPro.Guides[GID].amin_level,GQL)
        WoWPro.Guides[GID].asum_level = WoWPro.Guides[GID].asum_level + GQL
        WoWPro.Guides[GID].acnt_level = WoWPro.Guides[GID].acnt_level + 1
	end

	WoWPro.why[i] = nil
	
    -- If there is a note, expand any markup.
    if WoWPro.note[i] then
        WoWPro.note[i] = WoWPro.ExpandMarkup(WoWPro.note[i])
    end

    -- If the step is "Achievement" there is no note use the name and description from the server ...
    if WoWPro.ach[i] and not WoWPro.note[i] then
        WoWPro.note[i] = ""
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

function WoWPro.RecordStuff(i)
    local QIDs = WoWPro.QID[i]
    local NPCs = WoWPro.NPC[i]
    if not QIDs then return end

    local GID = WoWProDB.char.currentguide
    local guideType = WoWPro.Guides[GID].guidetype
    local guideClass = WoWPro[guideType]
    local recordQIDs = guideClass.RecordQIDs or WoWPro.Guides[GID].AutoSwitch

    if not recordQIDs then return end
    
	if WoWPro.noauto[i] then
	    return
	end

    if WoWPro.action[i] == "!" and NPCs then
        -- NPC triggered QID
        -- ! Brutus/Ruckus|NPC|85561;85655|QID|85561.1|
        local numNPCs = select("#", string.split(";", NPCs))
    	for j=1,numNPCs do
    		local npc = select(numNPCs-j+1, string.split(";", NPCs))
    		local NPC = tonumber(npc)
    		if NPC then
    			WoWProDB.global.NpcFauxQuests[NPC] = {qid = tonumber(QIDs), title = WoWPro.step[i]}
--    			WoWPro:Print("Recorded NPC %d => QID %s",NPC, QIDs)
    		end
    	end        
    else
        -- Regular step declaration
        local numQIDs = select("#", string.split(";", QIDs))
    	for j=1,numQIDs do
    		local qid = select(numQIDs-j+1, string.split(";", QIDs))
    		local QID = tonumber(qid)
    		if QID then
--    		    WoWPro:Print("Recorded QID %s to GID %s",qid,GID)
    			WoWProDB.global.QID2Guide[QID] = GID
    			WoWProDB.global.QID2Guide[qid] = GID
    		end
        end
    end

end

function WoWPro.SemiMatch(big,little)
	local possible = select("#", string.split(";", big))
	for j=1,possible do
		local jpossible = select(possible-j+1, string.split(";", big))
		if jpossible == little then
			return true
		end
	end
    return false
end

-- Quest parsing function --
function WoWPro:ParseSteps(steps)
	WoWPro:dbp("Parsing Guide, %d steps",#steps)
	local GID = WoWProDB.char.currentguide
	local i = WoWPro.Recorder and 1 or 2  -- Leave room the the L step, no extra step for recorder guides
	local myclassL, myclass = UnitClass("player")
	local myraceL, myrace = UnitRace("player")
	local myFaction = strupper(UnitFactionGroup("player"))
	local zone = strtrim(string.match(WoWPro.Guides[GID].zone or "", "([^%(]+)"))

    -- if WoWPro.Recorder then
    --     i = 1 -- No extra steps for recorder guides
    -- end
	if myrace == "Scourge" then
		myrace = "Undead"
	end
	WoWPro.stepcount, WoWPro.stickycount, WoWPro.optionalcount = 0, 0 ,0
	if WoWPro.DebugLevel > 0 then
	    WoWPro.Guides[GID].amax_level = -1
	    WoWPro.Guides[GID].amin_level = _G.MAX_PLAYER_LEVEL_TABLE[min(_G.GetExpansionLevel(),_G.GetAccountExpansionLevel())]
	    WoWPro.Guides[GID].acnt_level = 0
	    WoWPro.Guides[GID].asum_level = 0 
	end
	WoWPro:Warning("ParsingSteps for %s, steps = %s",GID,#steps)


	for j=1,#steps do
		local text = steps[j]
		text = text:trim()
		if text ~= "" and text:sub(1,1) ~= ";" and not (j == 1 and text:sub(1,1) == "L") then
			local class, race  = text:match("|C|([^|]*)|?"), text:match("|R|([^|]*)|?")
			local gender, faction = text:match("|GEN|([^|]*)|?"), text:match("|FACTION|([^|]*)|?")
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
			if (class == nil or WoWPro.SemiMatch(class, myclass)) and
			   (race == nil or WoWPro.SemiMatch(race, myrace))  and
			   (gender == nil or gender == UnitSex("player")) and
			   (faction == nil or myFaction == "NEUTRAL" or faction == "NEUTRAL" or faction == myFaction) then
				WoWPro.ParseQuestLine(faction, zone, i, text)
				WoWPro.RecordStuff(i)
				i = i + 1
			end
		end
	end
	local last_i = i -1

	-- OK, now add a standard L step at the start of every guide
	local init,min_level
	if not WoWPro.Recorder then
    	min_level = WoWPro.Guides[GID].startlevel or 1
    	init = string.format("L Level %d|LVL|%d|N|You need to be level %d to start this guide.|",min_level,min_level,min_level)
    	WoWPro.ParseQuestLine(faction, zone, 1, init)
	end

	-- OK, now add a standard L step just before the end of the guide, if we have an end-level
	-- if not WoWPro.Recorder and WoWPro.Guides[GID].endlevel then
	--     local halt
	--     local endlevel = WoWPro.Guides[GID].endlevel
	--     halt =  string.format("L Level %d|LVL|%d|N|You need to be level %d to finish this guide.|",endlevel,endlevel,endlevel)
	--     WoWPro.ParseQuestLine(faction, zone, i, halt)
	--     i = i + 1
	-- end

	-- OK, now add a standard D step at the end of every guide, if there is none there
	local fini, nguide
    if not  WoWPro.Recorder and WoWPro.action[last_i] ~= "D" then
    	nguide = WoWPro:NextGuide(GID)
    	if nguide and nguide ~= "" then
    	    fini = string.format("D Onwards|N|This ends %s. %s is next.|",WoWPro:GetGuideName(GID), WoWPro:GetGuideName(nguide))
    	else
    	    fini = string.format("D Fini|N|This ends %s. There is no next guide, so you can pick the next from the control panel.|",WoWPro:GetGuideName(GID))
    	end
    	WoWPro.ParseQuestLine(faction, zone, i, fini)
        WoWPro.stepcount = i
    else
        WoWPro.stepcount = i - 1
   end


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
    local AutoSwitch = WoWPro.Guides[GID].AutoSwitch

    WoWPro:dbp("LoadGuideSteps(%s) AutoSwitch=%s",GID,tostring(AutoSwitch));
    
	--Re-initiallizing tags and counts--
	for tag,val in pairs(WoWPro.Tags) do 
		WoWPro[tag] = {}
	end
	WoWPro.stepcount, WoWPro.stickycount, WoWPro.optionalcount = 0, 0 ,0
	
	-- Parsing quests --
	local sequencef = WoWPro.Guides[GID].sequence
	local sequence = sequencef()
	if not sequence then
	    WoWPro:Error("Guide %s sequence function returned nothing!",GID,sequence)
	    return
	end
	local steps = { string.split("\n", sequence ) }
	WoWPro.stepcount = 0
   WoWProCharDB.Guide[GID].done = false
	WoWPro:ParseSteps(steps)
	
	
	if WoWPro.LoadAllGuidesActive then
	    WoWPro:dbp("Guide Parsed for LoadAllGuidesActive. "..WoWPro.stepcount.." steps stored.")
	    return
	else
	    WoWPro:dbp("Guide Parsed. "..WoWPro.stepcount.." steps stored.")
	end
	
	-- May need to go the the next guide to register	
	if WoWPro.Guides2Register then
	    WoWProDB.global.Guide2QIDs[GID] = WoWPro.Version
	    WoWPro:dbp("Recorded %s, time to load next Guides2Register.", GID)
       WoWPro:SendMessage("WoWPro_LoadGuide")
       return
    end
    
	WoWPro:PushCurrentGuide(GID)
	WoWPro:GuideSetup()
end

-- Push the guide on to the list of active guides
function WoWPro:PushCurrentGuide(GID)
    local guideType = WoWPro.Guides[WoWProDB.char.currentguide].guidetype
    table.insert(WoWProCharDB.GuideStack,GID)
    WoWPro[guideType]:dbp("Recorded load for guide %s",GID, when)
end

function WoWPro:PopCurrentGuide(current, pop)
    -- Get rid of the current guide
    for idx = 1, #WoWProCharDB.GuideStack do
        while WoWProCharDB.GuideStack[idx] == current do
            table.remove(WoWProCharDB.GuideStack,idx)
        end
    end
    if pop then
        return table.remove(WoWProCharDB.GuideStack)
    else
        return WoWProCharDB.GuideStack[#WoWProCharDB.GuideStack]
    end
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
    
    WoWPro:dbp("SetupGuideReal(%s): Type: %s",GID,guideType)
    
	-- Do we need to do AutoProximitySort'
	if WoWPro.Guides[GID].AutoProximitySort then
	    WoWPro.OrderSteps(false)    
	end
	
-- WoWPro:PopulateQuestLog() --Calling this will populate our quest log table for use here
	-- 
	-- -- Checking to see if any steps are already complete --
	-- for i=1, WoWPro.stepcount do
	-- 	local action = WoWPro.action[i]
	-- 	local numQIDs
	-- 
	-- 	if WoWPro.QID[i] then
	-- 		numQIDs = select("#", string.split(";", WoWPro.QID[i]))
	-- 	else
	-- 		numQIDs = 0
	-- 	end
	-- 
	--     WoWProCharDB.Guide[GID].completion[i] = false
	--     WoWPro.why[i] = "uncompleted by WoWPro:LoadGuideSteps() because quest was defaulted to incomplete."  
	-- 	for j=1,numQIDs do
	-- 		local QID = nil
	-- 		local qid
	-- 		if WoWPro.QID[i] then
	-- 			qid = select(numQIDs-j+1, string.split(";", WoWPro.QID[i]))
	-- 			QID = tonumber(qid)
	-- 		end
 	-- 
   --          if QID then
   --              if recordQIDs then
   --                  WoWProDB.global.QID2Guide[QID] = GID
   --              end
   --  		    -- Turned in quests --
   --  			if WoWPro:IsQuestFlaggedCompleted(qid,true) then
   --  			    WoWProCharDB.Guide[GID].completion[i] = true
   --  			    WoWPro.why[i] = "Completed by WoWPro:LoadGuideSteps() because quest was flagged as completed."
   --  			end
   --  	
   --  		    -- Quest Accepts and Completions --
   --  		    if not WoWProCharDB.Guide[GID].completion[i] then
   --  		        if WoWPro.QuestLog[QID] then 
   --      			    if action == "A" then
   --      			        WoWProCharDB.Guide[GID].completion[i] = true
   --      			        WoWPro.why[i] = "Completed by WoWPro:LoadGuideSteps() because quest was in QuestLog."
   --      			    end
   --      			    if action == "C" and WoWPro.QuestLog[QID].complete then
   --      				    WoWProCharDB.Guide[GID].completion[i] = true
   --      				    WoWPro.why[i] = "Completed by WoWPro:LoadGuideSteps() because quest in QuestLog was complete."
   --      			    end
   --      			end
   --  		    end
   --  		end
	-- 	end
	-- end
	
	-- Scrollbar Settings --
	WoWPro.Scrollbar:SetMinMaxValues(1, math.max(1, WoWPro.stepcount - WoWPro.ShownRows))
	
	WoWPro.GuideLoaded = true
	
	WoWPro.FirstMapCall = true 	-- Force an arrow reset
	WoWPro:PopulateQuestLog()
	WoWPro:AutoCompleteQuestUpdate()
	WoWPro:AutoCompleteZone()
	WoWPro:UpdateQuestTracker()
	WoWPro:UpdateGuide("WoWPro:LoadGuideSteps()")
	WoWPro:SendMessage("WoWPro_PostLoadGuide")
end


-- Checkbox Function --
function WoWPro:CheckFunction(row, button, down)
    local GID = WoWProDB.char.currentguide
    WoWPro:dbp("WoWPro:CheckFunction: row %d button %s UD %s rowChecked %s",row.index, button, tostring(down), tostring(row.check:GetChecked()))
	if button == "LeftButton" and row.check:GetChecked() then
	    WoWPro:dbp("WoWPro:CheckFunction: User marked step %d as skipped.", row.index)
		local steplist = WoWPro:SkipStep(row.index)
		row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
		if steplist ~= "" then 
			WoWPro:SkipStepDialogCall(row.index, steplist)
		end
	elseif button == "RightButton" and row.check:GetChecked() then
	   row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	   WoWPro.CompleteStep(row.index, "Mannualy checked (right-click)", true)
		-- WoWProCharDB.Guide[GID].completion[row.index] = true
		--WoWPro:UpdateQuestTracker()
		--if WoWProDB.profile.checksound then	
		--	PlaySoundFile(WoWProDB.profile.checksoundfile)
		-- end
		-- if WoWPro.action[row.index] == "D" then
	 --        WoWProCharDB.Guide[GID].done = true
	 --        WoWPro:dbp("WoWPro:CheckFunction: %s guide is done.",GID)
	 --    end
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
		local floor = 0

		-- Extract the floor if present
		if zone and (zone:match("/") or zone:match(";")) then
			zone, floor = string.split("/;",zone)
		end
		if tonumber(zone) then
			zone = GetMapNameByID(zone)
		end

		local questtext = WoWPro.questtext[k] 
		local optional = WoWPro.optional[k] 
		local conditional = WoWPro.conditional[k]
		local prereq = WoWPro.prereq[k] 
		local leadin = WoWPro.leadin[k] 
		local target = WoWPro.target[k]
		local item = WoWPro.item[k] 
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
		row.track:SetText("")
		if step then row.check:Show() else row.check:Hide() end
		if completion[k] or WoWProCharDB.Guide[GID].skipped[k] or WoWPro:QIDsInTable(WoWPro.QID[k],WoWProCharDB.skippedQIDs) then
			row.check:SetChecked(true)
			if WoWProCharDB.Guide[GID].skipped[k] or WoWPro:QIDsInTable(WoWPro.QID[k],WoWProCharDB.skippedQIDs) then
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
		
		
		if WoWProDB.profile.showcoords and coord and coord ~= "0,0" then
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
		    if zone and zone ~= WoWPro.Guides[GID].zone then
		    	local display_zone = WoWPro.Zone2MapID[zone] and WoWPro.Zone2MapID[zone].mapName or zone
		    	if zone:find("@") then
		    		-- Let's remove the ugly @xxxxx
		    		display_zone = zone:gsub("[@].*","")
		    	end
		      note = note .. " in " ..display_zone
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
			if QID and tonumber(QID) then
			    _, x, y, obj = QuestPOIGetIconInfo(tonumber(QID))
			end
			if coord or x then
				table.insert(dropdown, 
					{text = "Map Coordinates", func = function()
					    WoWPro:RemoveMapPoint()
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
						WoWPro.UpdateGuide("ClickedUnSticky")
						WoWPro.UpdateGuide("ClickedUnSticky")
						WoWPro.MapPoint()
					end} 
				)
			else
				table.insert(dropdown, 
					{text = "Make Sticky", func = function() 
						WoWPro.sticky[row.index] = true
						WoWPro.unsticky[row.index] = false
						WoWPro.UpdateGuide("ClickedMakeSticky")
						WoWPro.UpdateGuide("ClickedMakeSticky")
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
		
		-- Loots Button --
		
		if item then
		    local nomen = row.lootsbutton:SetItemByID(item)
		    if note ~= "" then
		        note = nomen .. ": " .. note
		    else
		        note = nomen
		    end
		    row.lootsbutton:Show()
		    row.note:SetText(note)
		else row.lootsbutton:Hide() end
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
