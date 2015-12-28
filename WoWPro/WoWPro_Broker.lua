-----------------------------
--      WoWPro_Broker      --
-----------------------------

local _G = getfenv(0)
local WoWPro = _G.WoWPro

local L = WoWPro_Locale
local OldQIDs, CurrentQIDs, NewQIDs, MissingQIDs

local function err(msg,...) _G.geterrorhandler()(msg:format(_G.tostringall(...)) .. " - " .. _G.time()) end

local function QidMapReduce(list,default,or_string,and_string,func)
    if not list then return default end
    local do_or = string.find(list,or_string)
    local split_string
    if do_or then
        split_string = or_string
    else
        split_string = and_string
    end
--    WoWPro:dbp("QidMapReduce: Splitting %s on '%s'",list,split_string)
    local numList = select("#", string.split(split_string, list))
    for i=1,numList do
        local QID = select(numList-i+1, string.split(split_string, list))
        QID = tonumber(QID)
		if not QID then
		    WoWPro:Error("Malformed QID [%s] in Guide %s",list,WoWProDB.char.currentguide)
		    QID=0
		end
	    local val = func(math.abs(QID))
--	    WoWPro:dbp("QidMapReduce: calling func on %d and got %s",QID,tostring(val))
	    if QID < 0 then
	        val = not val
	    end
	    if numList == 1 then
--	        WoWPro:dbp("QidMapReduce: singleton return %s",tostring(val))
	        return val
	    end
        if do_or and val then
--          WoWPro:dbp("QidMapReduce: do_or return true")
            return val
        end
        
        if do_and and not val then
--            WoWPro:dbp("QidMapReduce: do_and return false")
            return false
        end
    end
--    WoWPro:dbp("QidMapReduce: default return %s",tostring(default))
    return default
end
    
                    

-- -- See if any of the list of QIDs are in the indicated table.
-- function WoWPro:QIDsInTable(QIDs,tabla)
-- --    WoWPro:dbp("WoWPro:QIDsInTable(%s,%s)",QIDs,tostring(tabla))
--     return QidMapReduce(QIDs,false,";","&",function (qid) return tabla[qid] end)
-- end

-- See if any of the list of QIDs are in the indicated table and return the first
function WoWPro:QIDInTable(QIDs,tabla)
--    WoWPro:dbp("WoWPro:QIDsInTable(%s,%s)",QIDs,tostring(tabla))
    return QidMapReduce(QIDs,false,";","&",function (qid) return tabla[qid] and qid end)
end

-- See if any of the list of QIDs are in the indicated table, return a subkey
function WoWPro:QIDsInTableKey(QIDs,tabla,key)
--    WoWPro:dbp("WoWPro:QIDsInTable(%s,%s)",QIDs,tostring(tabla))
    return QidMapReduce(QIDs,false,";","&",function (qid) return tabla[qid] and tabla[qid][key] end)
end

-- See if all of the list of QIDs are in the indicated table.
function WoWPro:AllIDsInTable(IDs,tabla)
    return QidMapReduce(IDs,false,"&",";",function (qid) return tabla[qid] end)
end

-- Wipe out all the QIDs in the table.
function WoWPro:WipeQIDsInTable(IDs,tabla)
    return QidMapReduce(IDs,false,"&",";",function (qid) tabla[qid] = nil; return true; end)
end

-- Set all the QIDs in the table.
function WoWPro:SetQIDsInTable(IDs,tabla)
    return QidMapReduce(IDs,false,"&",";",function (qid) tabla[qid] = true; return true; end)
end
    
                    

-- See if any of the list of QUIDs are in the indicated table.
function WoWPro:QIDsInTable(QIDs,tabla)
    if not QIDs or QIDs == "" then return false end
    local numQIDs = select("#", string.split(";", QIDs))
    local default = false
	for j=1,numQIDs do
		local QID = select(numQIDs-j+1, string.split(";", QIDs))
		QID = tonumber(QID)
		if not QID then
		    WoWPro:Error("Malformed QID [%s] in Guide %s",QIDs,WoWProDB.char.currentguide)
		    QID=0
		end
		if QID >= 0 then
            if tabla[QID] then return true end
            default = false
        else
            if tabla[-QID] then return false end
            default = true
        end
    end
	return default
end

-- See if any of the list of QIDs are in the indicated table and return the first
function WoWPro:QIDInTable(QIDs,tabla)
--    WoWPro:dbp("WoWPro:QIDsInTable(%s,%s)",QIDs,tostring(tabla))
    return QidMapReduce(QIDs,false,";","&",function (qid) return tabla[qid] and qid end)
end

-- See if any of the list of QIDs are in the indicated table, return a subkey
function WoWPro:QIDsInTableKey(QIDs,tabla,key)
--    WoWPro:dbp("WoWPro:QIDsInTable(%s,%s)",QIDs,tostring(tabla))
    return QidMapReduce(QIDs,false,";","&",function (qid) return tabla[qid] and tabla[qid][key] end)
end
-- See if all of the list of QUIDs are in the indicated table.
function WoWPro:AllIDsInTable(IDs,tabla)
    if not IDs then return false end
    local numIDs = select("#", string.split(";", IDs))
	for j=1,numIDs do
		local ID = select(numIDs-j+1, string.split(";", IDs))
		ID = tonumber(ID)
		if not ID then
		    WoWPro:Error("Malformed ID [%s] in Guide %s",IDs,WoWProDB.char.currentguide)
		    ID=0
		end
		if ID >= 0 then
            if not tabla[ID] then
                WoWPro:dbp("AllIDsInTable: Did not find %d",ID)
                return false
            end
        end
    end
	return true
end

WoWPro.PetsOwned = nil

-- Lazy check for existence of pets
function WoWPro:PetOwned(npcID)
    if not WoWPro.PetsOwned then
        WoWPro.PetsOwned = {}
        WoWPro:dbp("WoWPro:PetOwned() Polling for %d pets.",C_PetJournal.GetNumPets())
        for i = 1,C_PetJournal.GetNumPets() do
            local petID, speciesID, isOwned, customName, level, favorite, isRevoked, name, icon, petType, creatureID, sourceText, description, isWildPet, canBattle = C_PetJournal.GetPetInfoByIndex(i);
                WoWPro:dbp("%s: %d@%d",name,creatureID,i)
                if WoWPro.PetsOwned[creatureID] then
                    WoWPro.PetsOwned[creatureID] = WoWPro.PetsOwned[creatureID] + 1
                else
                    WoWPro.PetsOwned[creatureID] = 1
                end
        end
    end
    WoWPro:dbp("Testing for pet %s, %s",tostring(npcID),tostring(WoWPro.PetsOwned[tonumber(npcID)]))
    return WoWPro.PetsOwned[tonumber(npcID)] or 0           
end 

-- Guide Load --
function WoWPro:LoadGuide(guideID)
    WoWPro:dbp("Signaled for LoadGuide %s",tostring(guideID))
    --err("Signaled for LoadGuide %s", guideID)
    if guideID then
        WoWProDB.char.currentguide = guideID
    end
    WoWPro.GuideLoaded = false
    WoWPro:SendMessage("WoWPro_LoadGuide")
end

function WoWPro.LoadGuideReal()
    local GID = WoWProDB.char.currentguide
    -- If currently in startup lockdown, punt
    if WoWPro.LockdownTimer ~= nil then
        WoWPro:dbp("Suppresssed guide load:  In lockdown.")
        WoWPro:SendMessage("WoWPro_LoadGuide")
        return
    end
    
    -- Need to register guides first
    if WoWPro.Guides2Register then
        -- Save the original guide to load
        WoWPro.PuntedGuide = WoWPro.PuntedGuide or GID
        -- pop off the next guide to load
        GID = table.remove(WoWPro.Guides2Register)
        while GID and not WoWPro.Guides[GID] do
            GID = table.remove(WoWPro.Guides2Register)
        end
        if not GID then
            WoWPro.Guides2Register = nil
            GID = WoWPro.PuntedGuide
            WoWPro.PuntedGuide = nil
            WoWPro:dbp("Finished processing Guides2Register, back to loading normally.")
        end
        WoWProDB.char.currentguide = GID
    end
    
    WoWPro:dbp("WoWPro_LoadGuide: starting guide cleanup:  %s",tostring(GID))
    
	--Re-initiallizing tags and counts--
	for i,tag in pairs(WoWPro.Tags) do 
		WoWPro[tag] = WoWPro[tag] or {}
		wipe(WoWPro[tag])
	end
	WoWPro.stepcount, WoWPro.stickycount, WoWPro.optionalcount = 0, 0 ,0
	
	--Checking the GID and loading the guide --
	if not GID then 
		WoWPro:LoadNilGuide() 
		WoWPro:dbp("No guide specified, loading NilGuide.")
		-- LFO: something else here
		return 
	end
	
	-- If the current guide can not be found, see if it was renamed.
	-- if not WoWPro.Guides[GID] then
	--     local myUFG = UnitFactionGroup("player"):sub(1,1)
	--     local name,levels = GID:match("([A-Za-z]+)([0-9]+)")
	--     levels = levels or ""
	--     name = name or ""
	--     local newGID =name..myUFG..levels
	--     if WoWPro.Guides[newGID] then
	--         -- Yeah, we renamed the guide on the poor chap.
	--         -- Remap the state
	--         WoWPro:Print("Guide "..GID.." was renamed to "..newGID..".  Remapping.")
	--         WoWProCharDB.Guide[newGID] = WoWProCharDB.Guide[GID]
	--         WoWProCharDB.Guide[GID] = nil
	--         GID = newGID
	--         WoWProDB.char.currentguide = GID  
	--     end
	-- end
	if not WoWPro.Guides[GID] then 
		WoWPro:dbp("Guide "..GID.." not found, loading NilGuide.")
		WoWPro:LoadNilGuide()
		WoWProDB.char.currentguide = nil 
		return 
	end 
	WoWPro:dbp("Loading Guide: "..GID)
	
	-- Creating a new entry if this guide does not have one
	if WoWProCharDB.Guide[GID] == nil then
	    WoWProCharDB.Guide[GID] = {}
	    WoWProCharDB.Guide[GID].Version = WoWPro.Version
	end

    -- If we have upgraded, wipe the old information and re-create
	-- if WoWProCharDB.Guide[GID] and WoWPro.Version ~= WoWProCharDB.Guide[GID].Version then
	--     WoWPro:Print("Resetting Guide "..GID.." due to upgrade.  Forgetting skipped steps.")
	--     WoWProCharDB.Guide[GID].completion =  {}
	--     WoWProCharDB.Guide[GID].skipped =  {}
	--     WoWProCharDB.Guide[GID].why =  {}
	--     WoWProCharDB.Guide[GID].Version = WoWPro.Version
 --    end
    
    -- If we resetting guide, wipe the old information and re-create
	if WoWPro.Resetting then
	    WoWPro:Print("Manual reset of Guide "..GID..".")
	    WoWProCharDB.Guide[GID].completion =  {}
	    WoWProCharDB.Guide[GID].skipped =  {}
	    WoWProCharDB.Guide[GID].why =  {}
	    WoWProCharDB.Guide[GID].done = false
	    WoWProCharDB.Guide[GID].Version = WoWPro.Version
	    -- err("GID = %s, done = %s", GID, WoWProCharDB.Guide[GID].done)
    end
	    
	if ((not WoWProCharDB.Guide[GID].completion) or (not WoWProCharDB.Guide[GID].skipped)) then
	    WoWProCharDB.Guide[GID].completion = WoWProCharDB.Guide[GID].completion or {}
	    WoWProCharDB.Guide[GID].skipped = WoWProCharDB.Guide[GID].skipped or {}
	    WoWProCharDB.Guide[GID].why = WoWProCharDB.Guide[GID].why or {}
	    local guide = WoWPro.Guides[GID]
	    WoWPro:Print(("Initializing Guide: %s - %s (%s)."):format(guide.name or guide.zone or "", guide.guidetype, GID))
	end

	WoWPro.ActiveStep = 1
	WoWPro.CurrentIndex = 0 
	
    WoWPro:LoadGuideSteps()
end

function WoWPro:NextGuide(GID)
	local myUFG = UnitFactionGroup("player")
    if not WoWPro.Guides[GID].nextGID then
        -- If there is no next guide defined, see if we can pop something off the stack
        local pop = WoWPro:PopCurrentGuide(GID, false)
        if pop then
            WoWPro:dbp("WoWPro:NextGuide(%s): popped guide", pop)
            return pop
        else
            WoWPro:dbp("WoWPro:NextGuide(%s): no next guide and no pop", GID)
            return nil
        end

    end
	if WoWPro.Guides[GID].faction == "Neutral" then
	    -- nextGIDvalue is faction dependent.   Split it and pick the right one "AllianceGUID|HordeGID"
	    local  AllianceGUID, HordeGID = string.split("|",WoWPro.Guides[GID].nextGID)
	    if myUFG == "Alliance" then
	        WoWPro:dbp("WoWPro:NextGuide(%s): Alliance %s", GID, AllianceGUID)
	        return AllianceGUID
	    else
	         WoWPro:dbp("WoWPro:NextGuide(%s): Horde %s", GID, HordeGID)
	        return HordeGID
	    end
	else
	     WoWPro:dbp("WoWPro:NextGuide(%s):  %s", GID, WoWPro.Guides[GID].nextGID)
	    return WoWPro.Guides[GID].nextGID
	end
end


function WoWPro:UpdateGuide(From)
    WoWPro:dbp("Signaled for UpdateGuide")
    WoWPro:SendMessage("WoWPro_UpdateGuide",From)
end

-- Guide Update --
local menuFrame = CreateFrame("Frame", "WoWProDropMenu", UIParent, "UIDropDownMenuTemplate")
WoWPro.GuideOffset = nil

-- Calling on the guide's module to populate the guide window's rows --
local function rowContentUpdate(offset)
	local reload = WoWPro:RowUpdate(offset)
	for i, row in pairs(WoWPro.rows) do
		if WoWPro.RowDropdownMenu[i] then
			row:SetScript("OnClick", function(self, button, down)			    
				if button == "LeftButton" then
					WoWPro:RowLeftClick(i)
				elseif button == "RightButton" then
					WoWPro.rows[i]:SetChecked(nil)
					if WoWPro.Recorder then WoWPro:RowLeftClick(i) end
					EasyMenu(WoWPro.RowDropdownMenu[i], menuFrame, "cursor", 0 , 0, "MENU")
				end
			end)
		end
	end
	return reload
end

function WoWPro.UpdateGuideReal(From)
    WoWPro:dbp("UpdateGuideReal(): Running")
	if not WoWPro.GuideFrame:IsVisible() then
	    -- Cinematic hides things ...
	    WoWPro:SendMessage("WoWPro_UpdateGuide","UpdateGuideReal()")
	    WoWPro:dbp("UpdateGuideReal(): Punting")
	end
	if not WoWPro.GuideLoaded then
	    WoWPro:dbp("UpdateGuideReal(): Hey! No guide, no update.")
	    return
	end
	
	-- If the user is in combat, or if a GID is not present, or if the guide cannot be found, end --
	if MaybeCombatLockdown() then
	    WoWPro:dbp("Suppresssed guide update.  In Combat.")
	    WoWPro:SendMessage("WoWPro_UpdateGuide","InCombat")
	    return
	end
	if InCinematic() then
		WoWPro:dbp("Suppresssed guide update.  In Cinematic.")
		WoWPro:SendMessage("WoWPro_UpdateGuide","InCinematic")
		return
	end
	WoWPro:dbp("Running: UpdateGuideReal()")
	local GID = WoWProDB.char.currentguide
	local offset = WoWPro.GuideOffset
	WoWPro.GuideOffset = nil
	if  not GID or not WoWPro.Guides[GID] then
	    WoWPro:dbp("Suppresssed guide update. Guide %s is invalid.",tostring(GID))
        return 
	end
	if  not WoWPro.GuideLoaded then
	    WoWPro:dbp("Suppresssed guide update. Guide %s is not loaded yet!",tostring(GID))
        return 
	end

	-- If the module that handles this guide is not present and enabled, then end --
	local module = WoWPro:GetModule(WoWPro.Guides[GID].guidetype)
	if not module or not module:IsEnabled() then return end
	
	-- Finding the active step in the guide --
-- err("ActiveStep = %s, CurrentIndex = %s", WoWPro.ActiveStep, WoWPro.CurrentIndex)	
	local oldCurrentIndex = WoWPro.CurrentIndex
	
	-- Ensure that the current step is not skiped
	WoWPro.ActiveStep = WoWPro:NextStep(1)
	local ActiveStep = WoWPro.ActiveStep
	local maxloop = 1000
	repeat
		maxloop = maxloop -1
		if maxloop < 1 then
			err("infinite loop ActiveStep = %s", ActiveStep)
			return
		end
		ActiveStep = WoWPro.ActiveStep
	 	WoWPro.ActiveStep = WoWPro:NextStep(ActiveStep-1)
	until ActiveStep == WoWPro.ActiveStep

	-- ActiveStep is the first step we find that is not completed or skiped
	-- CurrentIndex is the first non sticky step we find that is not completed or skiped
	-- Finding if the currently displayed step has changed
	-- err("ActiveStep = %s, CurrentIndex = %s", WoWPro.ActiveStep, WoWPro.CurrentIndex)	
	local oldCurrentIndex = WoWPro.CurrentIndex
	WoWPro.CurrentIndex = WoWPro:NextStep(ActiveStep-1)
	local CurrentIndex 
	local maxloop = 1000
	repeat
		maxloop = maxloop -1
		if maxloop < 1 then
			err("infinite loop CurrentIndex = %s", CurrentIndex)
			return
		end

		CurrentIndex = WoWPro.CurrentIndex
	 	WoWPro.CurrentIndex = WoWPro:NextStepNotSticky(CurrentIndex-1)
	until CurrentIndex == WoWPro.CurrentIndex

	if WoWPro.Recorder then
	    WoWPro.ActiveStep = WoWPro.Recorder.SelectedStep or WoWPro.ActiveStep
	end

	if WoWPro.CurrentIndex <= #WoWPro.step then
		if not offset then WoWPro.Scrollbar:SetValue(WoWPro.ActiveStep) end
		WoWPro.Scrollbar:SetMinMaxValues(1, math.max(1, WoWPro.stepcount))
		
		local reload = true
		-- Reloading until all stickies that need to unsticky have done so --
		while reload do reload = rowContentUpdate(offset) end
		
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
	end
	
	-- Updating the progress count --
	local p = 0
	for j = 1,WoWPro.stepcount do
		if ( WoWProCharDB.Guide[GID].completion[j] or WoWProCharDB.Guide[GID].skipped[j] )
		and not WoWPro.sticky[j] then
--		and not WoWPro.optional[j] then 
			p = p + 1 
		end
	end
	WoWProCharDB.Guide[GID].progress = p
	-- WoWProCharDB.Guide[GID].total = WoWPro.stepcount - WoWPro.stickycount - WoWPro.optionalcount
	WoWProCharDB.Guide[GID].total = WoWPro.stepcount - WoWPro.stickycount
	
	-- TODO: make next lines module specific
	WoWPro.TitleText:SetText((WoWPro.Guides[GID].name or WoWPro.Guides[GID].zone).."   ("..(WoWProCharDB.Guide[GID].progress+1).."/"..WoWProCharDB.Guide[GID].total..")")
	
	-- If the guide is complete, loading the next guide --
	if (WoWProCharDB.Guide[GID].progress >= WoWProCharDB.Guide[GID].total or WoWProCharDB.Guide[GID].done)
	and not WoWPro.Recorder and WoWPro.Leveling and not WoWPro.Leveling.Resetting then
--		err("progress = %s, total = %s, done = %s",WoWProCharDB.Guide[GID].progress, WoWProCharDB.Guide[GID].total, WoWProCharDB.Guide[GID].done)
		if WoWProDB.profile.autoload then
			WoWProDB.char.currentguide = WoWPro:NextGuide(GID)
			WoWPro:Print("Switching to next guide: %s",tostring(WoWProDB.char.currentguide))
			WoWPro:LoadGuide()
			return
		else
			WoWPro.NextGuideDialog:Show()
		end
		oldCurrentIndex = nil
	end
-- err("ActiveStep = %s, CurrentIndex = %s", WoWPro.ActiveStep, WoWPro.CurrentIndex)	
	if oldCurrentIndex ~= WoWPro.CurrentIndex then
		WoWPro:MapPoint()
		WoWPro:SendMessage("WoWPro_QuestDialogAutomation") -- Just in case a dialog is open for the step that was just added
	end
end	

local Rep2IdAndClass
Rep2IdAndClass = {  ["hated"] = {1,false},
                    ["hostile"] = {2,false},
                    ["unfriendly"] = {3,false},
                    ["neutral"] = {4,false},
                    ["friendly"] = {5,false},
                    ["honored"] = {6,false},
                    ["revered"] = {7,false},
                    ["exalted"] = {8,false},
                    ["hated"] = {1,false},
                    ["stranger"] = {0,true},
                    ["acquaintance"] = {1,true},
                    ["buddy"] = {2,true},
                    ["friend"] = {3,true},
                    ["good friend"] = {4,true},
                    ["best friend"] = {5,true},
}

			
-- Next Step --    			
-- Determines the next active step --
function WoWPro:NextStep(k,i)
	local GID = WoWProDB.char.currentguide
	if not GID then return 1 end
	if not k or k < 1 then k = 1 end --k is the position in the guide
	if not i then i = 1 end --i is the position on the rows
	WoWPro:dbp("Called WoWPro:NextStep(%d,%d)",k,i)
	local skip = true

	local CurrentIndex = max(WoWPro.CurrentIndex or 0, WoWPro.ActiveStep or 0)

	-- The "repeat ... break ... until true" hack is how you do a continue in LUA!  http://lua-users.org/lists/lua-l/2006-12/msg00444.html
	while skip do repeat
		local QID=WoWPro.QID[k]
		skip = false -- The step defaults to NOT skipped

		-- Quickly skip completed steps --
		if WoWProCharDB.Guide[GID].completion[k] then
		    -- WoWPro.why[k] = "NextStep(): Completed."
		    skip = true
		    break
		end

		-- Quickly skip any manually skipped quests --
		if WoWProCharDB.Guide[GID].skipped[k] then
			WoWPro:dbp("SkippedStep(%d,%s [%s])",k,WoWPro.action[k],WoWPro.step[k])
			WoWPro.why[k] = "NextStep(): SkippedStep."
			skip = true
			break
		elseif WoWPro:QIDsInTable(QID,WoWProCharDB.skippedQIDs) then
			WoWProCharDB.Guide[GID].skipped[k] = true
			WoWPro.why[k] = "NextStep(): SkippedQID."
			WoWPro:dbp("SkippedQID(%d, qid=%s, %s [%s])",k,QID,WoWPro.action[k],WoWPro.step[k]);
			skip = true
			break
		end
--[=[		
	    -- Availible quests: not complete and not in quest log --
	    if WoWPro.availible[k] then
	        local availible = WoWPro.availible[k]
	        if WoWPro:QIDsInTable(availible,WoWPro.QuestLog) then
	            WoWPro.CompleteStep(k,"NextStep(): Availible quest is currently in quest log")
	            break
	        end
	        if WoWPro:IsQuestFlaggedCompleted(availible) then
	            skip = true
	            WoWPro.CompleteStep(k,"NextStep(): Availible quest is currently complete")
	            break
	        end 
	    end 
	    
	    -- Handle Jump actions
	    if WoWPro.action[k] == "J" and  WoWPro.guide[k] and i == 1 then
            skip = false
            break
	    end
]=]
		-- Checking Prerequisites --
    	if WoWPro.prereq[k] and k <= CurrentIndex then
    	    if string.find(WoWPro.prereq[k],"+") then
    	        -- Any prereq met is OK, skip only if none are met	
        		local numprereqs = select("#", string.split("+", WoWPro.prereq[k]))
        		local totalFailure = true
        		for j=1,numprereqs do
        			local jprereq = select(numprereqs-j+1, string.split("+", WoWPro.prereq[k]))
        			if WoWPro:IsQuestFlaggedCompleted(tonumber(jprereq)) then 
        				totalFailure = false -- If one of the prereqs is complete, step is not skipped.
        			end
        		end
        		if totalFailure then
        		    skip = true
        		    WoWPro.why[k] = ("NextStep(): None of possible prereqs were met. ||PRE||%s||"):format(WoWPro.prereq[k])
        		    WoWProCharDB.Guide[GID].skipped[k] = true
        		    if WoWPro.action[k] == "A" then
        		    	WoWProCharDB.skippedQIDs[QID] = true
        		    end
        		    break
        		end
        	else
     	        -- All prereq met must be met	
        		local numprereqs = select("#", string.split(";", WoWPro.prereq[k]))
        		for j=1,numprereqs do
        			local jprereq = select(numprereqs-j+1, string.split(";", WoWPro.prereq[k]))
        			if not WoWPro:IsQuestFlaggedCompleted(tonumber(jprereq)) then 
        				skip = true -- If one of the prereqs is NOT complete, step is skipped.
        				WoWPro.why[k] = "NextStep(): Not all of the prereqs were met: " .. WoWPro.prereq[k]
        				WoWProCharDB.Guide[GID].skipped[k] = true
        				if WoWPro.action[k] == "A" then
        					WoWProCharDB.skippedQIDs[QID] = true
        				end
        				break
        			end
        		end
			end
    	end

    	-- Skipping quests with prerequisites if their prerequisite was skipped --
    	if WoWPro.prereq[k] and k <= CurrentIndex 
    	and not WoWProCharDB.Guide[GID].skipped[k] 
    	and not WoWPro:QIDsInTable(QID,WoWProCharDB.skippedQIDs) then 
    		local numprereqs = select("#", string.split(";", WoWPro.prereq[k]))
    		for j=1,numprereqs do
    			local jprereq = select(numprereqs-j+1, string.split(";", WoWPro.prereq[k]))
    			if WoWProCharDB.skippedQIDs[tonumber(jprereq)] then
    				skip = true
    				WoWPro.why[k] = "NextStep(): Skipping step with skipped prerequisite."
    				WoWPro:dbp("MissingPreReq2(%d)",k)
    				-- If their prerequisite has been skipped, skipping any dependant quests --
    				if WoWPro.action[k] == "A" 
    				or WoWPro.action[k] == "C" 
    				or WoWPro.action[k] == "T" then
    					WoWProCharDB.skippedQIDs[QID] = true
    					WoWProCharDB.Guide[GID].skipped[k] = true
    				else
    					WoWProCharDB.Guide[GID].skipped[k] = true
    				end
    			end
    		end
    	end
    	if skip then break end -- Exit the loop

    	-- Check leadin
    	if WoWPro.leadin[k] and k <= CurrentIndex and
    		WoWPro:IsQuestFlaggedCompleted(WoWPro.leadin[k]) then
 			skip = true 
 			WoWPro:dbp("Step %s [%s] skipped because it is a leadin to QID %s that is completed.",WoWPro.action[k],WoWPro.step[k],WoWPro.leadin[k])
 			WoWPro.why[k] = "NextStep(): Skipping step because it is a leadin to a completed quest."
			WoWProCharDB.Guide[GID].skipped[k] = true
 			break
    	end

		-- Select the right C step with the QG tag that matches the gossip
		if WoWPro.GossipText and WoWPro.gossip[k] and  not WoWProCharDB.Guide[GID].completion[k] and k <= CurrentIndex  then
		   -- is gossip in GossipText?
		   if string.find(WoWPro.GossipText, WoWPro.gossip[k], 1 , true) then
		       -- Found it
		       WoWPro:dbp("Step %s [%s] '%s' in GossipText",WoWPro.action[k],WoWPro.step[k],WoWPro.gossip[k])
		       WoWPro.why[k] = "Located gossip word in gossip text"
		       skip = false
		   else
		       WoWPro.why[k] = "Gossip word not in gossip text"
		       WoWProCharDB.Guide[GID].skipped[k] = true
		       skip = true
		   end
		end
 
	   -- Skip C or T steps, or step with |QO| if they are not active quests
	   -- ActiveStep is used here in order not to skip if the A step is a sticky (doesn't work, let's fix the guides instead)
	   if (WoWPro.action[k] == "C" or WoWPro.action[k] == "T" or WoWPro.questtext[k]) and
	      not WoWPro:QIDsInTable(QID,WoWPro.QuestLog) and 
	      k <= CurrentIndex then 
 			skip = true -- If the quest is not in the quest log, the step is skipped --
 			WoWPro:dbp("Step %s [%s] skipped as not in QuestLog",WoWPro.action[k],WoWPro.step[k])
 			WoWPro.why[k] = "NextStep(): Skipping C/T step because quest is not in Quest Log."
			WoWProCharDB.Guide[GID].skipped[k] = true
 			break
    	end

    	-- Skip T steps that have conditinal set to true and are not completed
    	if WoWPro.action[k] == "T" and WoWPro.conditional[k] and k <= CurrentIndex  then
			local isCompleted = false
			local numQIDs = select("#", string.split(";",QID))
			for j=1,numQIDs do
				local qID = select(numQIDs-j+1, string.split(";", QID))
				qID = tonumber(qID)
				local quest_log_index = WoWPro.QuestLog[qID]
				if quest_log_index and select(6,GetQuestLogTitle(quest_log_index)) == 1 then
					isCompleted = true
					break
				end
			end
			if not isCompleted then
	   		WoWPro.CompleteStep(k,"Criteria met")
	 			skip = true 
	 			WoWPro:dbp("Step %s [%s] skipped as not completed",WoWPro.action[k],WoWPro.step[k])
	 			WoWPro.why[k] = "NextStep(): Skipping Conditional T step because the quest is not completed."
				WoWProCharDB.Guide[GID].skipped[k] = true
	 			break
			end
    	end
    	
    	-- Complete "f" steps if we know the flight point already
    	if WoWPro.action[k] == "f"  and 
    			(WoWProCharDB.Taxi[WoWPro.step[k]] or (WoWPro.altfp[k] and WoWProCharDB.Taxi[WoWPro.altfp[k]])) then
	        WoWPro.CompleteStep(k, "Taxi already known")
	        skip = true
	        break
	   end	

	   -- Complete "h" steps if the Hearthstone is already bound to the correct desnisation
	   if WoWPro.action[k] == "h" and WoWPro.step[k] == GetBindLocation() and k <= CurrentIndex then
		   WoWPro.CompleteStep(k, "Hearthstone already set to "..WoWPro.step[k])
		   skip = true
		   break
	   end

	   -- Current zone check : steps that complete if were are in the correct zone.
	   if (WoWPro.action[k] == "F" or WoWPro.action[k] == "R" or WoWPro.action[k] == "b" or WoWPro.action[k] == "H") and
	   	not WoWPro.waypcomplete[k] and
	   	k <= CurrentIndex and
	   	(WoWPro.step[k] == GetZoneText():trim() or WoWPro.step[k] == GetSubZoneText():trim()) then

	        WoWPro.CompleteStep(k, "Destination zone detected")
	   	skip = true
	   	break
	   end

	    -- Check for must be active quests
		if WoWPro.active and WoWPro.active[k] and k <= CurrentIndex then
			if not WoWPro:QIDsInTable(WoWPro.active[k],WoWPro.QuestLog) then 
				WoWPro.why[k] = "NextStep(): Skipping step necessary ACTIVE quest is not in QuestLog."
				WoWPro.CompleteStep(k)
				skip = true -- If the quest is not in the quest log, the step is skipped --
				break
			end
			WoWPro:dbp("Step %s [%s] ACTIVE %s, skip=%s",WoWPro.action[k],WoWPro.step[k],WoWPro.active[k],tostring(skip))
		end

        -- WoWPro:dbp("Status(%d) skip=%s",k,tostring(skip))
        -- Checking level based completion --
        if WoWPro.level and WoWPro.level[k] then
            local level = tonumber(WoWPro.level[k])
            if WoWPro.action[k] == "L" and level <= UnitLevel("player") then
                WoWProCharDB.Guide[GID].completion[i] = true
                skip = true
                WoWPro.CompleteStep(k, "NextStep(): Completed L step because player level is high enough.")
                break
            end
            if WoWPro.level[k] and tonumber(WoWPro.level[k]) > UnitLevel("player") then
                skip = true
                WoWPro:dbp("Skip %s [%s] because its level %d is too high.",WoWPro.action[k],WoWPro.step[k],level)
                WoWPro.why[k] = "NextStep(): Skipping step because player level not high enough."
                break
            end
        end
            
		-- Skipping profession quests if their requirements aren't met --
		if WoWPro.prof[k] and not skip and k <= CurrentIndex then
			local prof, profnum, proflvl, profmaxlvl, profmaxskill = string.split(";",WoWPro.prof[k])
			if proflvl == '*' then proflvl = 700 end -- Set to the maximum level obtainable in the expansion plus 1
			proflvl = tonumber(proflvl) or 1
			profmaxlvl = tonumber(profmaxlvl) or 0
			profmaxskill = tonumber(profmaxskill) or 0
			if WoWProCharDB.ProfessionalfOffset and WoWPro.Guides[GID].BuyersGuide then
                proflvl = proflvl - WoWProCharDB.ProfessionalfOffset
                if 	proflvl < 1 then
                    proflvl = 1
                end	    
			end

			if type(prof) == "string" and type(proflvl) == "number" then
				local hasProf = false
				skip = true --Profession steps skipped by default
				local profs = {}
				profs[1], profs[2], profs[3], profs[4], profs[5], profs[6] = GetProfessions()
				for p=1,6 do
					if profs[p] then
						local skillName, _, skillRank, maxskill, _, _, skillnum = GetProfessionInfo(profs[p])
						-- if (tonumber(skillnum) == tonumber(profnum)) then
						if skillName == prof then
							hasProf = true
							if (profmaxlvl == 0) and (skillRank >= proflvl) then skip = false end
							if (profmaxlvl > 0) and (skillRank < profmaxlvl) then skip = false end
							if (profmaxskill > 0) and (profmaxskill > maxskill) then skip = false end
						end
					end
				end
				-- Zero proflvl special skip logic
				if (hasProf == false) and (proflvl == 0) then
				    WoWPro:dbp("Prof unskip qid %s for no %s for proflvl == 0",WoWPro.QID[k],prof)
				    skip = false
				    --hasProf = true
				end
				if WoWPro.action[k] == "A" and not hasProf then
				    -- If they do not have the profession, mark the step and quest as skipped
				    WoWPro.why[k] = "NextStep(): Permanently skipping step because player does not have a profession."
				    WoWProCharDB.Guide[GID].skipped[k] = true
				    WoWProCharDB.skippedQIDs[QID] = true
				    WoWPro.why[k] = ("NextStep(): skipping step because because the profession is not known ||P||%s||."):format(WoWPro.prof[k])
				    WoWPro:dbp("Prof permaskip qid %s for no %s",WoWPro.QID[k],prof)
				    skip = true
				elseif skip == true then
					-- Skipping the line because the profession requirements are not met
					WoWPro.why[k] = ("NextStep(): skipping step because profession requirements not met for ||P||%s||."):format(WoWPro.prof[k])
					WoWProCharDB.Guide[GID].skipped[k] = true
				end
			else
			    WoWPro:Error("Warning: malformed profession tag [%s] at step %d",WoWPro.prof[k],k)
			end
		end
        
		-- Skipping reputation quests if their requirements are met --
		if WoWPro.rep and WoWPro.rep[k] and not skip and k <= CurrentIndex then
			local rep, factionIndex, temprep, replvl = string.split(";",WoWPro.rep[k])
			WoWPro:dbp("ConsiderRep(%d, %s [%s] %s)",k,WoWPro.action[k],WoWPro.step[k],WoWPro.rep[k]);
			if temprep == nil then temprep = "neutral-exalted" end
			local repID,repmax = string.split("-",temprep)
			if repmax== nil then repmax = repID end
			local Friendship = false;
			-- Canonicalize the case
			rep = string.lower(rep)
			factionIndex = tonumber(factionIndex)
			repID = string.lower(repID)
			repmax = string.lower(repmax)
			if replvl and (not tonumber(replvl)) then
			    replvl =  string.lower(replvl)
			    if replvl == "bonus" then
			        replvl = true
			    elseif replvl == "nobonus" then
			        replvl = false
			    else
			        WoWPro:Error("Bad [%s] replvl [%s] found.  Defaulting to 0",rep,replvl)
			        replvl = 0
			    end
			    self:dbp("Special replvl converted to %s",tostring(replvl))
			else
			    replvl = tonumber(replvl) or 0
			end


         -- Extract lower bound rep
         if not Rep2IdAndClass[repID] then
                WoWPro:Error("Bad lower REP value of [%s] found in [%s].  Defaulting to 1.",temprep,WoWPro.rep[k])
             repID = 0
         end                
         Friendship = Rep2IdAndClass[repID][2]
         repID = Rep2IdAndClass[repID][1]
         if not repID then
                WoWPro:Error("Bad lower REP value of [%s] found in [%s].  Defaulting to 1.",temprep,WoWPro.rep[k])
             repID = 0
         end

         -- Extract upper bound rep
         repmax = Rep2IdAndClass[repmax][1]
         if not repmax then
                WoWPro:Error("Bad upper REP value of [%s] found.  Defaulting to 5.",temprep)
             repmax = 5
         end

            
			skip = true --reputation steps skipped by default
			WoWPro.why[k] = "NextStep(): Reputation steps skipped by default"
			local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, hasBonusRepGain
			local friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold
			if Friendship then
			    friendID, friendRep, friendMaxRep, name, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionIndex);
			    friendTextLevel = string.lower(friendTextLevel)
			    standingId = Rep2IdAndClass[friendTextLevel][1]
			    earnedValue = friendRep - friendThreshold
			    bottomValue = 0
			    WoWPro:dbp("NPC %s is a %s: standing %d, earned %d",name,friendTextLevel,standingId,earnedValue)
			else
			    name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild , _, hasBonusRepGain = GetFactionInfoByID(factionIndex)
                WoWPro:dbp("Faction %s: standing %d, earned %d, bottomValue %d, bonus %s",name,standingId,earnedValue,bottomValue,tostring(hasBonusRepGain))
             earnedValue = earnedValue - bottomValue
			end

         if type(replvl) == "boolean" then
             if not(replvl) == not(hasBonusRepGain) then
                 skip = false
                 WoWPro.why[k] = "NextStep(): RepStep no skip on bonus"
             end
                WoWPro:dbp("Special replvl %s vs hasBonusRepGain %s, skip is %s",tostring(replvl),tostring(hasBonusRepGain),tostring(skip))
         end 

			if type(replvl) == "number" and (repID <= standingId) and (repmax >= standingId) and (replvl == 0) then
				skip = false
				WoWPro.why[k] = "NextStep(): RepStep no skip on " .. WoWPro.rep[k]
			end
			if type(replvl) == "number" and (replvl > 0) then
				if (repID < standingId) then
				    WoWPro:dbp("** [%s] Spec %s repID %s > standingId %s: noskip", WoWPro.step[k],WoWPro.rep[k],tostring(repID), tostring(standingId))
				    WoWPro.why[k] = "NextStep(): RepStep no skip on " .. WoWPro.rep[k]
					skip = false 
				end
				if (repID == standingId) and (earnedValue >= replvl) then
				    WoWPro:dbp("** [%s] Spec %s earnedValue %d >= replvl %d: noskip", WoWPro.step[k],WoWPro.rep[k],earnedValue,replvl)
				    WoWPro.why[k] = "NextStep(): RepStep no skip on " .. WoWPro.rep[k]
                    skip = false
				end
			end
			-- Mark quests as skipped that we will assume will NEVER be done.
			if WoWPro.action[k] == "A" and standingId < 3 and repID > 3 and skip then
			    WoWProCharDB.Guide[GID].skipped[k] = true
			    -- LFO: Questionable, needs review.
			    --WoWPro:SetQIDsInTable(QID,WoWProCharDB.skippedQIDs)
				 WoWProCharDB.skippedQIDs[QID] = true
			end
			if skip then 
				WoWProCharDB.Guide[GID].skipped[k] = true
				break 
			end
      end
        
      -- Skipping Achievements if completed  --
    	if WoWPro.ach and WoWPro.ach[k] and k <= CurrentIndex then
    		local achnum, achitem, achflip = string.split(";",WoWPro.ach[k])
    		achflip = WoWPro.toboolean(achflip) 
    		local count = GetAchievementNumCriteria(achnum)
    		if achitem == "" then achitem = nil end
    		if count == 0 or not achitem then
    			local IDNumber, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText, isGuildAch, wasEarnedByMe, earnedBy = GetAchievementInfo(achnum)
    			WoWPro:dbp("ACH %s wasEarnedByMe=%s, Flip=%s", achnum, tostring(wasEarnedByMe), tostring(achflip))
    			if achflip then wasEarnedByMe = not wasEarnedByMe end
                if wasEarnedByMe then
                    if not achflip then
				        WoWPro.CompleteStep(k, "NextStep(): Achivement ["..Name.."] Complete.") 
				    end
				    skip = true
				else
				    WoWPro.why[k] = "NextStep(): Achivement ["..Name.."] not complete."
			    end 
    		elseif (count > 0) and achitem then
    			local description, type, completed, quantity, requiredQuantity, characterName, flags, assetID, quantityString, criteriaID = GetAchievementCriteriaInfo(achnum, achitem)
    			self:dbp("ACH %s/%s Completed=%s, Flip=%s", achnum, achitem, tostring(Completed), tostring(achflip))
    			if achflip then completed = not completed end
			    if completed then
			        if not achflip then
				        WoWPro.CompleteStep(k, "NextStep(): Criteria ["..description.."] Complete.")
				    end
				    skip = true
				else
				    WoWPro.why[k] = "NextStep(): Criteria ["..description.."] not complete."
			    end
			else
			    WoWPro:Error("Malformed Achievement tag on step %d: Ach [%s] AchCount %d",k,WoWPro.ach[k],count)
    		end
    	end
    	
    	-- Skipping spells if known.
    	-- Warning: not all spells are detectable by this method.  Blizzard is not consistent!
    	-- This tests for Spells you can put on a button, essentially.
    	if WoWPro.spell and WoWPro.spell[k] then
    	    local spellNick,spellID,spellFlip = string.split(";",WoWPro.spell[k])
    	    local spellName = GetSpellInfo(tonumber(spellID))
    	    -- local spellKnown = GetSpellInfo(spellName)
    	    -- spellKnown = spellKnown ~= nil
    	    local spellKnown = IsSpellKnown(spellID)
    	    spellFlip = WoWPro.toboolean(spellFlip)
    	    if spellFlip then spellKnown = not spellKnown end
    	    WoWPro:dbp("Checking spell step %s [%s] for %s: Nomen %s, Known %s",WoWPro.action[k],WoWPro.step[k],WoWPro.spell[k],tostring(spellName),tostring(spellKnown))
    	    if spellKnown then
    	        WoWPro.CompleteStep(k)
				skip = true
				WoWPro:dbp("Skipping because spell [%s] is known=%s",spellName, tostring(not not spellKnown))
			end
    	end
    	
    	if WoWPro.recipe and WoWPro.recipe[k] and k <= CurrentIndex then
    	    WoWPro:dbp("Step %d Recipe %s",k,WoWPro.recipe[k])
    	    if WoWProCharDB.Trades and WoWPro:AllIDsInTable(WoWPro.recipe[k],WoWProCharDB.Trades) then
        	    local why = string.format("recipe #%d %s/%d is known: %s",k,WoWPro.step[k],WoWPro.recipe[k],tostring(WoWProCharDB.Trades[WoWPro.recipe[k]]))
        	    WoWPro.CompleteStep(k, why)
        		skip = true
        		WoWPro:dbp(why)
        		break
        	end
      end
        
    	-- This tests for spells that are cast on you and show up as buffs
    	if WoWPro.buff and WoWPro.buff[k] and k <= CurrentIndex then
    	    local buffy = WoWPro:CheckPlayerForBuffs(WoWPro.buff[k])
    	    if buffy then
	            skip = true
                WoWPro.why[k] = "NextStep(): Skipping step because BUFF was present."
                WoWPro:dbp("Skipping because buff #%d",buffy);
                break
            end
     	end
        
        -- Test for pets
    	if WoWPro.pet and WoWPro.pet[k] then
    	    local petID,petCount,petFlip = string.split(";",WoWPro.pet[k])
    	    local found = WoWPro:PetOwned(petID)
    	    petCount = tonumber(petCount) or 3
    	    local want = found < petCount
    	    if petFlip then
    	        want = not want
    	    end
    	    if want then
                WoWPro.why[k] = "NextStep(): Pet wanted."
            else
                skip = true
                WoWPro.why[k] = "NextStep(): Pet NOT wanted."
                break
            end
     	end
        
        -- Test for buildings, default is to skip if we dont have any of the named ones if all other conditions satisfied.
        if WoWPro.building and WoWPro.building[k] and not skip then
            local Name,ids  = string.split(";",WoWPro.building[k],2)
            local numList = 0
            if ids then
                numList = select("#", string.split(";", ids))
            end
            Name = string.lower(Name)
            if Name == "townhall" then
                local level, mapTexture, townHallX, townHallY = C_Garrison.GetGarrisonInfo()
                if ( not level or not townHallX or not townHallY ) then
                    -- if no garrison yet, then stop.
                    skip = true
                end
                ids = tonumber(ids)
                if ids ~= level then
                    skip = true
                    WoWPro.why[k] = "NextStep(): TownHall not right level"
                end
            elseif  Name == "townhallonly" then
    		    local buildings = C_Garrison.GetBuildings();
                if #buildings > 0 then
        		    WoWPro.why[k] = "NextStep(): Buildings owned already."
                    skip = true
                end
            else
                local idHash = {}
                WoWPro:dbp("Checking to see if you own %s: %s",Name, ids)
                for i=1,numList do
                    local bid = select(numList-i+1, string.split(";", ids))
                    bid = tonumber(bid)
    		        if not bid then
    		            WoWPro:Error("Malformed BID [%s] in Guide %s",WoWPro.building[k],WoWProDB.char.currentguide)
    		            bid = 0
    		        end
    		        idHash[bid] = true
    		    end
    		    local buildings = C_Garrison.GetBuildings();
    		    WoWPro.why[k] = "NextStep(): Building not owned."
    		    local owned = false
                for i = 1, #buildings do
                    local building = buildings[i];
                    if idHash[building.buildingID] then
                        local id, name, texPrefix, icon, rank, isBuilding, timeStart, buildTime, canActivate, canUpgrade, isPrebuilt = C_Garrison.GetOwnedBuildingInfoAbbrev(building.plotID);
                        owned = true
                        WoWPro.why[k] = "NextStep(): " .. name .." owned."
                        WoWPro:dbp("Building %d is owned",building.buildingID)
                        if not WoWPro.map[k] then
                            if WoWProCharDB.BuildingLocations[name] then
                                WoWPro.map[k] = string.format("%2.2f,%2.2f",WoWProCharDB.BuildingLocations[name].x, WoWProCharDB.BuildingLocations[name].y)
                            end
                        end
                    end
                end
                -- skip if no buildings owned.
                skip = not owned
            end
		end
        
        -- WoWPro:dbp("Checkpoint Gimel for step %d",k)
        
		-- Skipping any quests with a greater completionist rank than the setting allows --
		if WoWPro.rank and WoWPro.rank[k] then
			if tonumber(WoWPro.rank[k]) > WoWProDB.profile.rank then 
			    WoWProCharDB.Guide[GID].skipped[k] = true
			    WoWPro.why[k] = "NextStep(): Step rank is too high."
			    skip = true
			end
		end
		
		-- WoWPro:dbp("Checkpoint Daleth for step %d",k)
      -- Do we have enough loot in bags?
		if (WoWPro.lootitem and WoWPro.lootitem[k] and k <= CurrentIndex) then
		    WoWPro:dbp("Checking step %d for loot %s",k, WoWPro.lootitem[k])
		    if GetItemCount(WoWPro.lootitem[k]) >= WoWPro.lootqty[k] then
		        if WoWPro.action[k] == "T" then
		            -- Special for T steps, do NOT skip.  Like Darkmoon [Test Your Strength]
		            WoWPro.why[k] = "NextStep(): enough loot to turn in quest."
		        else
		            if i == 1 then
		                -- Only complete the current step, the loot might go away!
		                WoWPro.CompleteStep(k, "NextStep(): completed cause you have enough loot in bags.")
		            else
			            WoWPro.why[k] = "NextStep(): skipped cause you have enough loot in bags."
			        end
			        skip = true
			    end
			else
		        if WoWPro.action[k] == "T" then
		            -- Special for T steps, do skip.  Like Darkmoon [Test Your Strength]
		            WoWPro.why[k] = "NextStep(): not enough loot to turn in quest."
			        skip = true
			    end
			end
		else		
    		-- Special for Buy steps where the step name is the item to buy and no |L| specified
    		if WoWPro.action[k] == "B" and k <= CurrentIndex then
    		    if GetItemCount(WoWPro.step[k]) > 0 then
    			    WoWPro.CompleteStep(k, "NextStep(): completed cause you bought enough named loot.")
    			    skip = true
    			end
    		end		    
      end
		
		-- Skipping any unstickies until it's time for them to display --
		if WoWPro.unsticky[k] and WoWPro.ActiveStickyCount and i > WoWPro.ActiveStickyCount+1 then 
			skip = true 
		end


		skip = WoWPro[WoWPro.Guides[GID].guidetype]:NextStep(k, skip)
				
	until true
	if skip then k = k+1 end

	-- Prevent infinite loop
	if k > #WoWPro.step then
		--err("Infinite loop")
		return #WoWPro.step + 1
	end
		
	end
	
	WoWPro.why[k] = "NextStep(): Step active."
	WoWPro:dbp("%s=WoWPro.NextStep()",tostring(k))
	return k
end

-- Next Step Not Sticky --
-- Determines the next active step that isn't a sticky step (for mapping) --
function WoWPro:NextStepNotSticky(k)
    WoWPro:dbp("Called WoWPro.NextStepNotSticky(%d)",k)
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
	if k > WoWPro.stepcount then
	    WoWPro:print("WoWPro.NextStepNotSticky=%d: > EOG",k)
	else
	    if WoWPro.questtext[k] then
	        WoWPro:dbp("WoWPro.NextStepNotSticky=%d: %s [%s] QO=%s",k, tostring(WoWPro.action[k]), tostring(WoWPro.step[k]), tostring(WoWPro.questtext[k]) )
	    else
	        WoWPro:dbp("WoWPro.NextStepNotSticky=%d: %s [%s]",k, tostring(WoWPro.action[k]), tostring(WoWPro.step[k]))
	    end
    end
	return k
end

-- Step Completion Tasks --
function WoWPro.CompleteStep(step, why, manual)
	local GID = WoWProDB.char.currentguide
	if WoWProCharDB.Guide[GID].completion[step] then return end
	if WoWProDB.profile.checksound then	
		PlaySoundFile(WoWProDB.profile.checksoundfile)
	end
	WoWPro:dbp("WoWPro.CompleteStep(%d,%s[%s],'%s')",step,WoWPro.action[step], WoWPro.step[step], why)
	WoWPro.why[step] = why
	WoWProCharDB.Guide[GID].completion[step] = why
	for i,row in ipairs(WoWPro.rows) do
		if WoWProCharDB.Guide[GID].completion[row.index] then
			row.check:SetChecked(true)
		else
			row.check:SetChecked(false)
		end
	end
	
	local Delta = WoWPro:MapPointDelta()
	if not manual and Delta then
	    local qid=-99
	    if WoWPro.QID[step] then
	        qid = WoWPro.QID[step]
	    end
	    local line = string.format("Action=%s|Step=%s|M0=%.2f,%.2f|M1=%.2f,%.2f|Error=%.2f|QID=%s|Vers=%s|Guide=%s",WoWPro.action[step],WoWPro.step[step],Delta[2],Delta[3],Delta[4],Delta[5],Delta[1],qid,WoWPro.Version,GID)
        WoWProDB.global.Deltas = WoWProDB.global.Deltas or {}
	    table.insert(WoWProDB.global.Deltas, line)
	    WoWPro:dbp(line)
	end
	if WoWPro.action[step] == "D" then
--		err("GID = %s, step = %s, WoWPro.action[step] = %s", GID, step, WoWPro.action[step])
	    WoWProCharDB.Guide[GID].done = true
	    WoWPro:dbp("WoWPro.CompleteStep: %s guide is done.",GID)
	end
	if WoWPro.action[step] == "J" then
	    local nGID = WoWPro.guide[step]
	    WoWPro:dbp("WoWPro.CompleteStep: jumping from %s to %s.",GID, nGID)
	    WoWPro:LoadGuide(nGID)
	end
	if why then WoWPro.why[step] = why end
	WoWPro:UpdateGuide("WoWPro.CompleteStep")
	-- WoWPro:MapPoint()
end

WoWPro.oldQuests = {}
WoWPro.QuestLog = {}

local abandoning
local orig = _G.AbandonQuest
_G.AbandonQuest = function(...)
	abandoning = true
	return orig(...)
end


-- Populate the Quest Log table for other functions to call on --
--local colapsedHeaders = {}
function WoWPro:PopulateQuestLog()
	local WoWProCharDB = WoWPro.CharDB

	WoWPro.oldQuests, WoWPro.QuestLog = WoWPro.QuestLog, WoWPro.oldQuests
	wipe(WoWPro.QuestLog)
	
	-- Remember the colapsed headers
	--wipe(colapsedHeaders)
	local entries = GetNumQuestLogEntries()
	--for i=entries,1,-1 do
	--	if select(6,GetQuestLogTitle(i)) then
	--		tinsert(colapsedHeaders,i)
	--	end
	--end
	
	
	ExpandQuestHeader(0)	
	entries = GetNumQuestLogEntries()
	for i=1,entries do
		local isHeader, _ , _, frequency, questID = select(4,GetQuestLogTitle(i))
		if not isHeader then
			WoWPro.QuestLog[questID] = i
			if frequency == LE_QUEST_FREQUENCY_DAILY then
				WoWPro:SetPermanentDailyQuest(questID)
			end
		elseif isCollapsed then
		end
	end
	
	-- Restaure the colapsed headers
	--while(#colapsedHeaders) > 0 do
	--	CollapseQuestHeader(tremove(colapsedHeaders))
	--end

	-- Is the table empty?
	if not next(WoWPro.oldQuests) then return end

	-- Generating table WoWPro.missingQuest --
	for QID, questInfo in pairs(WoWPro.oldQuests) do
		if not WoWPro.QuestLog[QID] then
			if not abandoning then
				-- It's a quest that has been completed
				WoWPro.abandonedQID = nil
			else
				WoWPro.abandonedQID = QID
			end
			abandoning = nil
		end
	end
end
-- Populate the Quest Log table for other functions to call on --
-- function WoWPro:PopulateQuestLog()
-- 	WoWPro:dbp("WoWPro:PopulateQuestLog()")
	
-- 	-- If the UI is up, dont muck with things
-- 	if (QuestLogFrame:IsShown() or QuestLogDetailFrame:IsShown()) then
-- 	    WoWPro:SendMessage("WoWPro_PuntedQLU")
-- 	    return nil
-- 	end
	
-- 	WoWPro.oldQuests = WoWPro.QuestLog or {}
-- 	WoWPro.newQuest, WoWPro.missingQuest = false, false
	
-- 	-- Generating the Quest Log table --
-- 	WoWPro.QuestLog = {} -- Reinitiallizing the Quest Log table
-- 	local i, currentHeader = 1, "None"
-- 	local entries, numQuests = GetNumQuestLogEntries()
-- 	local lastCollapsed = nil
-- 	local num = 0
-- 	WoWPro:dbp("PopulateQuestLog: Entries %d, Quests %d.",entries,numQuests)

--     i=1
-- 	repeat
-- 		local questTitle, level, questTag, suggestedGroup, isHeader, 
-- 			isCollapsed, isComplete, isDaily, questID, startEvent, displayQuestID = GetQuestLogTitle(i)
-- 		local leaderBoard
--		local ocompleted
-- 		if not questTitle and (num < numQuests) then
-- 		     WoWPro:Error("PopulateQuestLog: return value from GetQuestLogTitle(%d) is nil.",i)
-- 		end
-- 		if isHeader then
-- --		    WoWPro:dbp("PopulateQuestLog: Header %s  @ %d",tostring(questTitle),i)
-- 			currentHeader = questTitle
-- 			if lastCollapsed then
-- 			    -- We just finished scanning a previously collapsed header and ran into the next
-- 			    -- We need to collapse it and then rewind to the next slot and restart, as the slot number for the header will have mutated on us.
-- 			    CollapseQuestHeader(lastCollapsed)
-- --			    WoWPro:dbp("PopulateQuestLog: Collapsing header at %d",lastCollapsed)
-- 			    i = lastCollapsed
-- 			    lastCollapsed = nil
-- 			elseif isCollapsed then
-- 			    lastCollapsed = i
-- --			    WoWPro:dbp("PopulateQuestLog: Expanding header at %d",lastCollapsed)
-- 			    ExpandQuestHeader(i)
-- 			end	    
-- 		elseif questTitle and not WoWPro.QuestLog[questID] then
-- 			if GetNumQuestLeaderBoards(i) and GetQuestLogLeaderBoard(1, i) then
-- 				leaderBoard = {} 
--				ocompleted = {}
-- 				for j=1,GetNumQuestLeaderBoards(i) do 
--					leaderBoard[j], _, ocompleted[j] = GetQuestLogLeaderBoard(j, i)
-- 				end 
--			else
--			    leaderBoard = nil
--			    ocompleted = nil
--			end
-- 			local link, icon, charges = GetQuestLogSpecialItemInfo(i)
-- 			local use
-- 			if link then
-- 				local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(link, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
-- 				use = Id
-- 			end
-- 			local coords
-- 			QuestMapUpdateAllQuests()
-- 			QuestPOIUpdateIcons()
-- 			local x, y = WoWPro:findBlizzCoords(questID)
-- 			if x and y then coords = string.format("%.2f",x)..","..string.format("%.2f",y) end
-- --			WoWPro:dbp("PopulateQuestLog: Quest %s [%s] @ %d",tostring(questID),questTitle,i)
-- 			WoWPro.QuestLog[questID] = {
-- 				title = questTitle,
-- 				level = level,
-- 				tag = questTag,
-- 				group = suggestedGroup,
-- 				complete = isComplete,
--				ocompleted = ocompleted,
-- 				daily = isDaily,
-- 				leaderBoard = leaderBoard,
-- 				header = currentHeader,
-- 				use = use,
-- 				coords = coords,
-- 				index = i
-- 			}
-- 			num = num + 1
-- 		end
-- 		i = i + 1
-- 		if ( i > 50 ) then
-- 		    break
-- 		end
-- 	until num == numQuests
	
-- 	if lastCollapsed then
-- 	    CollapseQuestHeader(lastCollapsed)
-- 	    lastCollapsed = nil
-- 	end

-- 	WoWPro:dbp("Quest Log populated. "..num.." quests found.")
-- 	if numQuests ~= num then
-- 	    WoWPro:Error("Expected to find %d quests in QuestLog, but found %d.",numQuests, num)
-- 	end

-- 	if WoWPro.oldQuests == {} then return end

-- 	-- Generating table WoWPro.newQuest --
-- 	for QID, questInfo in pairs(WoWPro.QuestLog) do
-- 		if not WoWPro.oldQuests[QID] then 
-- 			WoWPro.newQuest = QID 
-- 			WoWPro:dbp("New Quest %d: [%s]",QID,WoWPro.QuestLog[QID].title)
-- 		end
--		-- Is this an auto-switch quest?
--		if WoWProDB.global.QID2Guide[QID] and WoWProDB.char.currentguide ~= WoWProDB.global.QID2Guide[QID] then
--		    WoWPro:SelectGuide(WoWProDB.global.QID2Guide[QID], WoWPro.QuestLog[QID].title)
--		    WoWPro:print("AutoSwitch: [%s] => %s",WoWPro.QuestLog[QID].title, WoWProDB.global.QID2Guide[QID])
-- 	end
	
-- 	-- Generating table WoWPro.missingQuest --
-- 	for QID, questInfo in pairs(WoWPro.oldQuests) do
-- 		if not WoWPro.QuestLog[QID] then 
-- 			WoWPro.missingQuest = QID 
-- 			WoWPro:dbp("Missing Quest: "..WoWPro.oldQuests[QID].title)
-- 		end
-- 	end

	-- Print updated objectives --
--	WoWProDB.char.Emmaleah = WoWProDB.char.Emmaleah or {}
--	if WoWPro.DebugLevel > 0 then
--	    table.insert(WoWProDB.char.Emmaleah,WoWPro.QuestLog)
--	else
--	    WoWProDB.char.Emmaleah = {}
--	end
	
-- 	return num
-- end

   		


-- Cached version of function
function WoWPro:IsQuestFlaggedCompleted(qid,force)
	if qid == "*" then return nil; end
	local QID = tonumber(qid)
	if not QID then
		-- is it a QID list?
		local quids = select("#", string.split(";", qid))
		if (not quids) or quids == 1 then 
            WoWPro:Warning("Guide %s has a bad QID! [%s]",WoWProDB.char.currentguide,tostring(qid))
		   return false;
		else
		   -- Yup, return true if any are complete
			for j=1,quids do
				local jquid = select(quids-j+1, string.split(";", qid))
		       jquid = tonumber(jquid)
		       if not jquid then
                    WoWPro:Warning("Guide %s has a bad QID! [%s]",WoWProDB.char.currentguide,tostring(qid))
		           return false;
		       end
		       if WoWPro:IsQuestFlaggedCompleted(jquid,force) then
		           return true
		       end
			end
		   return false
		end
	end
	-- if not WoWProCharDB.completedQIDs then
	--     WoWProCharDB.completedQIDs = {}
	-- end
	-- if not force and type(WoWProCharDB.completedQIDs[QID]) ~= "nil" then
	--     return WoWProCharDB.completedQIDs[QID]
	-- end
	-- WoWProCharDB.completedQIDs[QID] = IsQuestFlaggedCompleted(QID) or false
	-- return WoWProCharDB.completedQIDs[QID]
 	return IsQuestFlaggedCompleted(QID)
end

-- Quest Ordering by distance to travel

function WoWPro.SwapSteps(i,j)
    local GID = WoWProDB.char.currentguide
    for idx,tag in pairs(WoWPro.Tags) do
        WoWPro[tag][j] ,  WoWPro[tag][i] =  WoWPro[tag][i] ,  WoWPro[tag][j]
    end
    WoWProCharDB.Guide[GID].completion[i] , WoWProCharDB.Guide[GID].completion[j] = WoWProCharDB.Guide[GID].completion[j] , WoWProCharDB.Guide[GID].completion[i]
    WoWProCharDB.Guide[GID].skipped[i] , WoWProCharDB.Guide[GID].skipped[j] = WoWProCharDB.Guide[GID].skipped[j] , WoWProCharDB.Guide[GID].skipped[i]
end


function WoWPro:FindClosestStep(limit)
    local distance, closest
    for index=1, limit do
        local d = WoWPro:DistanceToStep(index)
        if (not distance) or (d < distance) then
            distance = d
            closest = index
        end
    end
    return closest, distance
end


-- Put completed and skipped steps at end of guide
function WoWPro:CompleteAtEnd()
    local GID = WoWProDB.char.currentguide
    local last = WoWPro.stepcount
    for i=1, WoWPro.stepcount do
        if WoWProCharDB.Guide[GID].completion[i] then
            -- find the last uncompleted step
            while WoWProCharDB.Guide[GID].completion[last] and (last > i) do
                last = last - 1
            end
            if last <= i then
                -- no more room, done
                break
            end
            WoWPro.SwapSteps(i,last)
            WoWPro.why[last] = "Already Done"
            last = last - 1
        end
    end
    for i=1, WoWPro.stepcount do
        if WoWProCharDB.Guide[GID].skipped[i] then
            -- find the last skipped step
            while WoWProCharDB.Guide[GID].skipped[last] and (last > i) do
                last = last - 1
            end
            if last <= i then
                -- no more room, done
                break
            end
            WoWPro.SwapSteps(i,last)
            WoWPro.why[last] = "Skipped for now"
            last = last - 1
        end
    end
    return last
end


function WoWPro.OrderSteps(update)
    -- Put the stuff we did or dont want at the end
    local limit = WoWPro:CompleteAtEnd()
    WoWPro:Print("Limit at %d instead of %d",limit,WoWPro.stepcount)
    -- Put the first step closest to us
    local sidx,d = WoWPro:FindClosestStep(limit)
    WoWPro.SwapSteps(1,sidx)
    WoWPro.why[1] = string.format("selected step as the closest at a distance of %g",d)
    WoWPro:Print("First setp %d at distance of %g",sidx,d)
    -- Now achor at each step and find the following step that is closer
    for anchor = 1, limit do
       local distance, closest 
       for index=anchor+1 , limit do
            local d = WoWPro:DistanceBetweenSteps(anchor,index)
            if (not distance) or (d < distance) then
                distance = d
                closest = index
            end
        end
        if closest then
            WoWPro.SwapSteps(anchor+1,closest)
            WoWPro.why[anchor+1] = string.format("selected step as the next closest at a distance of %g",d)
        end
    end
    if update then
        WoWPro:UpdateGuide("WoWPro.OrderSteps")
    end
end


-- Experimental Interface to Grail
function WoWPro:SkipAll()
    WoWPro:Print("Marking All Quests as skipped")
    local GID = WoWProDB.char.currentguide
	for index=1, WoWPro.stepcount do
	    if not WoWProCharDB.Guide[GID].completion[index] then
	        WoWProCharDB.Guide[GID].skipped[index] = true
        end
    end
end

function WoWPro:DoQuest(qid)
    WoWPro:Print("Marking QID %s for execution.",qid)
    local GID = WoWProDB.char.currentguide
    qid = tonumber(qid)
	for index=1, WoWPro.stepcount do
	    if tonumber(WoWPro.QID[index]) == qid and not WoWProCharDB.Guide[GID].completion[index] then
	        WoWProCharDB.Guide[GID].skipped[index] = nil
        end
    end
end

function WoWPro:QuestPrereq(qid)
    WoWPro:DoQuest(qid)

    local controlTable = { ["result"] = {}, ["preq"] = {}, ["lastIndexUsed"] = 0, ["doMath"] = true }
    local lastIndexUsed = Grail._PreparePrerequisiteInfo(Grail:QuestPrerequisites(qid, true), controlTable)
    local firstQuestsInPrerequisiteChain = controlTable.result
    local allQuestsInPrerequisiteChain = controlTable.preq

    for i,q in ipairs(allQuestsInPrerequisiteChain) do
        WoWPro:DoQuest(q)
    end
end

function WoWPro:Questline(qid)
    if not Grail or not WoWPro.EnableGrail then return end
    WoWPro:SkipAll()
    WoWPro:QuestPrereq(qid)
    WoWPro:LoadGuide(nil)
end

StaticPopupDialogs["WOWPRO_PICKQUEST"] = {
    text = "Please enter the quest ID to select and then click GO!",
    button1 = "Go!",
    button2 = "Never Mind",
    OnAccept = function(self,data,data2) local qid = self.editBox:GetText() ; WoWPro:Questline(tonumber(qid)) end,
    hideOnEscape = true,
    preferredIndex = 3,
    hasEditBox = true,
    OnShow = function (self, data) self.editBox:SetText("quest id #") end
}


function WoWPro.PickQuestline()
    StaticPopup_Show("WOWPRO_PICKQUEST")
end

function WoWPro:GrailQuestPrereq(qid)
    if not Grail or not WoWPro.EnableGrail then return nil end
    local preReq = Grail:QuestPrerequisites(qid)
    local PREstr = nil
    if not preReq then return nil end
    if type(preReq) ~= "table" then
        preReq = Grail:_FromPattern(preReq)
    end
    for i,p in ipairs(preReq) do
        if( string.sub(tostring(p),1,1) == "B" ) then
            p = string.sub(p,2);
        end
        if tonumber(p) then
            if PREstr then
                PREstr =  PREstr .. ";" .. tostring(p)
            else
                PREstr = tostring(p)
            end
        end
    end
    return PREstr
end

function WoWPro:GrailCheckQuestName(guide,QID,myname)
    if not Grail or not WoWPro.EnableGrail then return nil end
    if QID == "*" then return QID end
    if not QID then
        WoWPro:Warning("In guide %s, quest [%s]  does not have a QID",guide,tostring(myname))
        return false
    end
    local numQIDs = select("#", string.split(";", QID))
    myname = myname:trim()
    if numQIDs > 1 then return QID end
    for j=1,numQIDs do
        local qid = select(numQIDs-j+1, string.split(";", QID))
        local gName = Grail:QuestName(qid)

        if gName then
            gName = gName:trim()
            if gName:find("FLAG %- ") then
                -- just punt
                gName = gName
            end
            if   gName ~=  gName then      
                WoWPro:Warning("In guide %s, quest %s's name [%s] does not match Grail's database [%s].",guide,tostring(qid),myname,gName)
            end
        end
    end
end

function WoWPro:GrailQuestLevel(qid)
    if not Grail or not WoWPro.EnableGrail then return nil end
    local _,_,level = Grail:MeetsRequirementLevel(qid,nil)
    if level then
        return tostring(level)
    else
        return nil
    end
end


-- /run WoWPro:Questline("14282")
-- /run WoWPro:Questline("10006")


function WoWPro.LockdownHandler(self, elapsed)
	if WoWPro.LockdownTimer ~= nil then
		WoWPro.LockdownTimer = WoWPro.LockdownTimer - elapsed
		if WoWPro.LockdownTimer < 0 then
			if TomTom and TomTom.AddMFWaypoint then
				WoWPro:CarboniteProfileHack()
			else 
				WoWPro:Warning("Waiting for TomTom or Carbonite to init...%s", tostring(WoWPro.LockdownCounter))
				if WoWPro.LockdownCounter > 0 then
					WoWPro.LockdownCounter = WoWPro.LockdownCounter - 1
					WoWPro.LockdownTimer = 0.33
				else
					-- Warning if the user is missing TomTom --
					WoWPro:Warning("It looks like you don't have |cff33ff33TomTom|r or |cff33ff33Carbonite|r installed. "
						.."WoW-Pro's guides won't have their full functionality without it! "
						.."Download it for free from www.wowinterface.com or www.curse.com .")

					if TomTom then -- Fix when Carbonite`s TomTom emulation is OFF
						TomTom = nil
						WoWPro:Warning("If you have |cff33ff33Carbonite|r installed, "
							.."do not forget to enable Carbonite\'s TomTom emulation! (Tracking HUD section)")
					end
				end
			end

			if WoWPro.LockdownTimer < 0 then
				WoWPro:dbp("Lockdown Timer expired.  Return to normal")
				WoWPro.LockdownCounter = nil
				WoWPro.LockdownTimer = nil
				WoWPro.InitLockdown = false
				WoWPro:LoadGuide()			-- Loads Current Guide (if nil, loads NilGuide)
			end
		end
	end
end

-- Carbonite - TomTom profile hack Section
function WoWPro:CarboniteProfileHack()
	if TomTom and Nx then
		local tom = TomTom
		
		if not tom["db"] then
			tom["db"] = {
				profile = {
					arrow = {
						arrival = 10,
						setclosest = false,
					},
					persistence = {
						cleardistance = 0,
					},
				},
			}

			WoWPro:Print('Patched Carbonite\'s fake TomTom profile')
		end
	end
end

