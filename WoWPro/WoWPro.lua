local _addonname, _addon = ...

-------------------------------------------------------------------------------
-- Localized Lua globals
-------------------------------------------------------------------------------
local _G 								= getfenv(0)

local collectgarbage					= _G.collectgarbage
local date								= _G.date
local print 							= _G.print
local select							= _G.select
local tostring							= _G.tostring
local type								= _G.type
local wipe								= _G.wipe

local ipairs							= _G.ipairs
local pairs								= _G.pairs
local tinsert							= _G.tinsert
local tremove							= _G.tremove

local UIParent							= _G.UIParent

local AcceptQuest						= _G.AcceptQuest
local CompleteQuest					= _G.CompleteQuest
local CreateFrame						= _G.CreateFrame
local GetActiveTitle					= _G.GetActiveTitle
local GetAddOnMetadata				= _G.GetAddOnMetadata
local GetAvailableTitle				= _G.GetAvailableTitle
local GetBindingKey					= _G.GetBindingKey
local GetGossipActiveQuests		= _G.GetGossipActiveQuests
local GetGossipAvailableQuests	= _G.GetGossipAvailableQuests
local GetNumActiveQuests			= _G.GetNumActiveQuests
local GetNumAvailableQuests		= _G.GetNumAvailableQuests
local GetNumQuestChoices			= _G.GetNumQuestChoices
local GetQuestID						= _G.GetQuestID
local GetQuestReward					= _G.GetQuestReward
local GetQuestsCompleted			= _G.GetQuestsCompleted
local GetTitleText					= _G.GetTitleText
local InCombatLockdown				= _G.InCombatLockdown
local IsShiftKeyDown 				= _G.IsShiftKeyDown
local SelectActiveQuest				= _G.SelectActiveQuest
local SelectAvailableQuest			= _G.SelectAvailableQuest
local SelectGossipActiveQuest		= _G.SelectGossipActiveQuest
local SelectGossipAvailableQuest	= _G.SelectGossipAvailableQuest
local SetBinding 						= _G.SetBinding

local DEFAULT_CHAT_FRAME			= _G.DEFAULT_CHAT_FRAME

local LibStub 							= _G.LibStub

local TomTom 							= _G.TomTom
local Swatter 							= _G.Swatter

local err_params = {}
local function err(msg, ...)
	msg = tostring(msg)
	wipe(err_params)
	for i=1,select('#',...) do err_params[i] = tostring(select(i,...)) end
	_G.geterrorhandler()(msg:format(_G.unpack(err_params)) .. " - " .. _G.time())
end

--------------------------
--      WoWPro.lua      --
--------------------------

local WoWPro = LibStub("AceAddon-3.0"):NewAddon("WoWPro")
_G.WoWPro = WoWPro

WoWPro.Version = GetAddOnMetadata("WoWPro", "Version")
WoWPro.DebugMode = false
WoWPro.Guides = {}
WoWPro.InitLockdown = true  -- Set when the addon is loaded


-- Define list of objects to be exported to Guide Addons
WoWPro.mixins = {}
function WoWPro:Embed(target)
  for _,name in pairs(WoWPro.mixins) do
    WoWPro:dbp("Creating WoWPro.%s:%s()",target.name,name)
    target[name] = WoWPro[name]
  end
end

function WoWPro:Export(target)
    tinsert(WoWPro.mixins,target)
end

-- WoWPro keybindings name descriptions --
_G["BINDING_NAME_CLICK WoWPro_FauxItemButton:LeftButton"] = "Use quest item"
_G.BINDING_HEADER_BINDING_WOWPRO = "WoWPro Keybindings"
_G["BINDING_NAME_CLICK WoWPro_FauxTargetButton:LeftButton"] = "Target quest mob"

-- Debug print function --
WoWPro.Serial = 0
function WoWPro:dbp(message,...)
	local WoWProDB = WoWPro.DB

	if WoWPro.DebugMode and message ~= nil then
	    local msg = ("|cffff7f00%s|r: "..message):format(self.name or "Wow-Pro",...)
		DEFAULT_CHAT_FRAME:AddMessage( msg )
		WoWPro.Serial = WoWPro.Serial + 1
		if WoWPro.Serial > 999 then
		    WoWPro.Serial = 1
		end
		if WoWProDB and WoWProDB.global and WoWProDB.global.Log then
		    if WoWPro.Log then
		        WoWProDB.global.Log = WoWPro.Log
		        WoWPro.Log = nil
		    end
		    WoWProDB.global.Log[date("%Y%m%d/%H%M.") .. ("%03d"):format(WoWPro.Serial)] = msg
		else
		    WoWPro.Log[date("%Y%m%d/%H%M.") .. ("%02d"):format(WoWPro.Serial)] = msg
		end
	end
end
WoWPro:Export("dbp")

-- WoWPro print function --
function WoWPro:Print(message,...)
	local WoWProDB = WoWPro.DB

	if message ~= nil then
		local msg = ("|cffffff00%s|r: "..message):format(self.name or "Wow-Pro", ...)
		DEFAULT_CHAT_FRAME:AddMessage( msg )
		WoWPro.Serial = WoWPro.Serial + 1
		if WoWPro.Serial > 999 then
		    WoWPro.Serial = 1
		end
		WoWPro.Log = WoWPro.Log or {}
		if WoWProDB and WoWProDB.global and WoWProDB.global.Log then
		    if WoWPro.Log then
		        WoWProDB.global.Log = WoWPro.Log
		        WoWPro.Log = nil
		    end
		    WoWProDB.global.Log[date("%Y%m%d/%H%M.") .. ("%03d"):format(WoWPro.Serial)] = msg
		else
		    WoWPro.Log[date("%Y%m%d/%H%M.") .. ("%02d"):format(WoWPro.Serial)] = msg
		end
	end
end
WoWPro:Export("Print")

-- Default profile options --
local defaults = { profile = {
	drag = true,
	anchorpoint = "AUTO",
	pad = 5,
	space = 5,
	mousenotes = false,
	minimap = { hidden = false, },
	track = true,
	showcoords = false,
	autoload = true,
	guidescroll = false,
	checksound = true,
	checksoundfile = [[Sound\Interface\MapPing.wav]],
	rank = 2,
	resize = false,
	autoresize = true,
	numsteps = 1,
	hminresize = 200,
	vminresize = 100,
	titlebar = true,
	titlecolor = {0.5, 0.5, 0.5, 1},
	bgtexture = [[Interface\Tooltips\UI-Tooltip-Background]],
	bgcolor = {0.2, 0.2, 0.2, 0.7},
	bordertexture = [[Interface\Tooltips\UI-Tooltip-Border]],
	border = true,
	stickytexture = [[Interface\Tooltips\UI-Tooltip-Background]],
	stickycolor = {0.8, 0.8, 0.8, 0.7},
	stepfont = [[Fonts\FRIZQT__.TTF]],
	steptextsize = 13,
	steptextcolor = {1, 1, 1},
	notefont = [[Fonts\FRIZQT__.TTF]],
	notetextsize = 11,
	notetextcolor = {1, 1, 0},
	trackfont = [[Fonts\FRIZQT__.TTF]],
	tracktextsize = 10,
	tracktextcolor = {1, 1, 0},
	titlefont = [[Fonts\FRIZQT__.TTF]],
	titletextsize = 15,
	titletextcolor = {1, 1, 1},
	stickytitlefont = [[Fonts\FRIZQT__.TTF]],
	stickytitletextsize = 13,
	stickytitletextcolor = {1, 1, 1},
} }

-- Core Tag Setup --
WoWPro.Tags = { "action", "step", "note", "index", "map", "sticky",
	"unsticky", "use", "zone", "lootitem", "lootqty", "optional",
	"level", "target", "prof", "waypcomplete", "rank"
}

-- Called before all addons have loaded, but after saved variables have loaded. --
function WoWPro:OnInitialize()
	local WoWProDB = LibStub("AceDB-3.0"):New("WoWProData", defaults, true) -- Creates DB object to use with Ace
	WoWPro.DB = WoWProDB
	_G.WoWProDB = WoWProDB
	-- Trace
	WoWProDB.global.Trace_on = nil
	WoWProDB.global.Trace = {}
	-- Setting up callbacks for use with profiels --
	WoWProDB.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	WoWProDB.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	WoWProDB.RegisterCallback(self, "OnProfileReset", "SetDefaults")

	-- Creating empty user settings if none exist --
	_G.WoWProCharDB = _G.WoWProCharDB or {}
	local WoWProCharDB = _G.WoWProCharDB
	WoWPro.CharDB = WoWProCharDB
	WoWProCharDB.Guide = WoWProCharDB.Guide or {}
	WoWProCharDB.completedQIDs = WoWProCharDB.completedQIDs or {}
	WoWProCharDB.skippedQIDs = WoWProCharDB.skippedQIDs or {}
	if WoWProCharDB.Enabled == nil then
	    WoWProCharDB.Enabled = true
	end
	--if WoWProDB.global.Deltas == nil then
	--if WoWProDB.global.Deltas == nil then
	--end
	WoWProDB.global.Deltas = WoWProDB.global.Deltas or {}
	if #WoWProDB.global.Deltas > 1000 then
		err("The WoWProDB.global.Deltas table has %s items, you should think about emptying it.", #WoWProDB.global.Deltas)
		WoWPro:Print(("The WoWProDB.global.Deltas table has %s items, you should think about emptying it."):format(#WoWProDB.global.Deltas))
	end
end

-- Called when the addon is enabled, and on log-in and /reload, after all addons have loaded. --
function WoWPro:OnEnable()
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	WoWPro:dbp("|cff33ff33Enabled|r: Core Addon")

	-- Warning if the user is missing TomTom --
	if not TomTom then
		WoWPro:Print("It looks like you don't have |cff33ff33TomTom|r installed. "
			.."WoW-Pro's guides won't have their full functionality without it! "
			.."Download it for free from www.wowinterface.com or www.curse.com .")
	end

	if not TomTom.AddMFWaypoint then
		WoWPro:Print("It looks like you don't have a recent |cff33ff33TomTom|r installed. "
			.."WoW-Pro's guides won't have their full functionality without it! "
			.."Download it for free from www.wowinterface.com or www.curse.com .")
    end

	-- Warning if the user is missing Swatter --
	if not Swatter then
		WoWPro:Print("It looks like you don't have |cff33ff33Swatter|r installed. "
			.."While we would love to claim our software is bug free, errors have occured. "
			.."Download it for free from http://auctioneeraddon.com/dl/AddOns/!Swatter-5.6.4424.zip or consider installing Auctioneer from www.curse.com .")
	end

	-- Warning if the user is missing Swatter --
	if not Swatter then
		WoWPro:Print("It looks like you don't have |cff33ff33Swatter|r installed. "
			.."While we would love to claim our software is bug free, errors have occured. "
			.."Download it for free from http://auctioneeraddon.com/dl/AddOns/!Swatter-5.6.4424.zip or consider installing Auctioneer from www.curse.com .")
	end

	-- Loading Frames --
	if not WoWPro.FramesLoaded then --First time the addon has been enabled since UI Load
		WoWPro:CreateFrames()
		WoWPro:CreateConfig()
		WoWPro.EventFrame=CreateFrame("Button", "WoWPro.EventFrame", UIParent)
		WoWPro.FramesLoaded = true
	else -- Addon was previously disabled, so no need to create frames, just turn them back on
		WoWPro:AbleFrames()
	end

	-- Module Enabling --
	for name, module in WoWPro:IterateModules() do
		WoWPro:dbp("Enabling "..name.." module...")
		module:Enable()
	end

	WoWPro:CustomizeFrames()	-- Applies profile display settings

	-- Keybindings Initial Setup --
	local keys = GetBindingKey("CLICK WoWPro_FauxItemButton:LeftButton")
	if not keys then
		SetBinding("CTRL-SHIFT-I", "CLICK WoWPro_FauxItemButton:LeftButton")
	end
	local keys = GetBindingKey("CLICK WoWPro_FauxTargetButton:LeftButton")
	if not keys then
		SetBinding("CTRL-SHIFT-T", "CLICK WoWPro_FauxTargetButton:LeftButton")
	end

	-- Event Setup --
	WoWPro:dbp("Registering Events: Core Addon")
	WoWPro:RegisterEvents( {	-- Setting up core events
		"BAG_UPDATE",
		"CHAT_MSG_SYSTEM",
		"CINEMATIC_STOP",
		"GOSSIP_SHOW",
		"PARTY_MEMBERS_CHANGED",
		"PLAYER_ENTERING_WORLD",
		"PLAYER_LEAVING_WORLD",
		"PLAYER_REGEN_ENABLED",
		"QUEST_AUTOCOMPLETE",
		"QUEST_COMPLETE",
		"QUEST_DETAIL",
		"QUEST_GREETING",
		"QUEST_LOG_UPDATE",
		"QUEST_PROGRESS",
		"QUEST_QUERY_COMPLETE",
		"UPDATE_BINDINGS",
	})
--	WoWPro.LockdownTimer = nil
	WoWPro.LockdownTimer = 2.0 -- Initial setting so that InitLockdown will get set to nil after login
	WoWPro.EventFrame:SetScript("OnUpdate", function(self, elapsed)
	    if WoWPro.LockdownTimer ~= nil then
	        WoWPro.LockdownTimer = WoWPro.LockdownTimer - elapsed
	        if WoWPro.LockdownTimer < 0 then
	            WoWPro:dbp("Lockdown Timer expired.  Return to normal")
	            WoWPro.LockdownTimer = nil
	            WoWPro.InitLockdown = false
                WoWPro:LoadGuide()			-- Loads Current Guide (if nil, loads NilGuide)
	        end
	    end
	end)

	WoWPro.EventFrame:SetScript("OnEvent", function(self, event, ...)		-- Setting up event handler

if _G.perr_onevent then err("event = %s", event) end

		if WoWPro.InitLockdown then
		    WoWPro:dbp("LockEvent Fired: "..event)
		else
		    WoWPro:dbp("Event Fired: "..event)
		end


		-- Unlocking event processong till after things get settled --
		if event == "PLAYER_ENTERING_WORLD" then
		    WoWPro.InitLockdown = true
		    WoWPro.LockdownTimer = 2.0

		-- Updating WoWPro keybindings --
		--elseif event == "UPDATE_BINDINGS" and not InCombatLockdown() then
		--	WoWPro:UpdateGuide()
		--end

		-- Receiving the result of the completed quest query --
		elseif event == "QUEST_QUERY_COMPLETE" then
			local num = 0
			for i, QID in pairs(WoWProCharDB.completedQIDs) do
				num = num+1
			end
			WoWPro:dbp("Old Completed QIDs: "..num)
			WoWProCharDB.completedQIDs = WoWProCharDB.completedQIDs or {}
			wipe(WoWProCharDB.completedQIDs)
			GetQuestsCompleted(WoWProCharDB.completedQIDs)
			num = 0
			for i, QID in pairs(WoWProCharDB.completedQIDs) do
				num = num+1
			end
			WoWPro:dbp("New Completed QIDs: "..num)
			collectgarbage("collect")
			if not WoWPro.InitLockdown then
			    WoWPro.UpdateGuide()
			end
		--end

		-- Locking event processong till after things get settled --
		elseif event == "PLAYER_LEAVING_WORLD" then
		    WoWPro:dbp("Locking Down 1")
		    WoWPro.InitLockdown = true
		end

		if WoWPro.InitLockdown then
		    return
		end

		-- Updating party-dependant options --
		if event == "PARTY_MEMBERS_CHANGED"
			or event == "UPDATE_BINDINGS"
			or event == "PARTY_MEMBERS_CHANGED" then
			WoWPro:UpdateGuide()
		--end
		-- Unlocking guide frame when leaving combat --
		elseif event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_ENTERING_WORLD" or event == "CINEMATIC_STOP" then
			WoWPro:UpdateGuide()
		end

		-- Updating party-dependant options --
		--if event == "PARTY_MEMBERS_CHANGED" and not InCombatLockdown() then
		--	WoWPro:UpdateGuide()
		--end

		-- Updating WoWPro keybindings --
		--if event == "UPDATE_BINDINGS" and not InCombatLockdown() then
		--	WoWPro:UpdateGuide()
		--end

		-- ====================================================================
		-- Event management shared between all the modules (used to be in each)
		-- ====================================================================
		if event == "CHAT_MSG_SYSTEM" then
			-- Set Hearth and deal with quest that are accepted and completed in one step
			WoWPro:CHAT_MSG_SYSTEM_parser(...)

		elseif event == "QUEST_LOG_UPDATE" then
				WoWPro:QUEST_LOG_UPDATE_bucket()

		-- All the auto-complete messages need to be processed after the QUEST_LOG_UPDATE
		-- hense the bucket. Also, all of them can be escaped with the shift key.
		elseif event == "GOSSIP_SHOW" then
--err("GOSSIP_SHOW")
	 		if WoWProCharDB.AutoSelect == true and not IsShiftKeyDown() then
				WoWPro:GOSSIP_SHOW_bucket()
			end

		elseif event == "QUEST_COMPLETE" then
--err("QUEST_COMPLETE")
			-- CompletingQuestQID is used by AutoCompleteSetHearth to detect quests that
			-- never show up in the quest log i.e. quests that are completed as soon as
			-- you accept them.
			WoWPro.CompletingQuestQID = GetQuestID()

			if WoWProCharDB.AutoTurnin == true  and not IsShiftKeyDown() then
				WoWPro:QUEST_COMPLETE_bucket()
			end

  		elseif event == "QUEST_DETAIL" then
--err("QUEST_DETAIL")

			if WoWProCharDB.AutoAccept == true and not IsShiftKeyDown() then
				WoWPro:QUEST_DETAIL_bucket()
			end

		elseif event == "QUEST_GREETING" then
--err("QUEST_GREETING")

			if WoWProCharDB.AutoSelect == true and not IsShiftKeyDown() then
				WoWPro:QUEST_GREETING_bucket()
			end

		elseif event == "QUEST_PROGRESS" then
--err("QUEST_PROGRESS")

			if WoWProCharDB.AutoTurnin == true  and not IsShiftKeyDown() then
				WoWPro:QUEST_PROGRESS_bucket()
			end

		elseif event == "BAG_UPDATE" then
			WoWPro:BAG_UPDATE_bucket()

		end

		-- Module Event Handlers --
		for name, module in WoWPro:IterateModules() do
			if WoWPro[name].EventHandler
			and WoWProDB.char.currentguide
			and WoWPro.Guides[WoWProDB.char.currentguide]
			and WoWPro.Guides[WoWProDB.char.currentguide].guidetype == name then
				--if _G.perr_onevent then err("event = %s, module = %s", event, name) end
				WoWPro[name]:EventHandler(self, event, ...)
			end
		end
	end)

--	WoWPro:MapPoint()				-- Maps the active step
	-- If the base addon was disabled by the user, put it to sleep now.
	if not WoWProCharDB.Enabled then
	    WoWPro:Disable()
	    return
	end

	-- Server query for completed quests --
	_G.QueryQuestsCompleted()

	-- Clear the error logs
	if WoWPro.DB.global.ZoneErrors then wipe(WoWPro.DB.global.ZoneErrors) end

end

-- Called when the addon is disabled --
function WoWPro:OnDisable()
	-- Module Disabling --
	for name, module in WoWPro:IterateModules() do
		WoWPro:dbp("Disabling "..name.." module...")
		module:Disable()
	end

	WoWPro:AbleFrames()								-- Hides all frames
	WoWPro.EventFrame:UnregisterAllEvents()	-- Unregisters all events
	WoWPro:RemoveMapPoint()							-- Removes any active map points
	WoWPro:Print("|cffff3333Disabled|r: Core Addon")
end

-- Tag Registration Function --
function WoWPro:RegisterTags(tagtable)
--[[ Purpose: Can be called by modules to add tags to the WoWPro.Tags table.
This table is iterated on in several key functions within the addon.
]]--
	if not WoWPro.Tags then return end			-- If the table doesn't exist for some reason (function called too early), end.
	for i=1,#tagtable do
		tinsert(WoWPro.Tags,tagtable[i])	-- Insert each tag from the table supplied into the WoWPro.Tags table.
	end
end

-- Event Registration Function --
function WoWPro:RegisterEvents(eventtable)
--[[Purpose: Iterates through the supplied table of events, and registers each
event to the guide frame.
]]--
	for _, event in ipairs(eventtable) do
		WoWPro.EventFrame:RegisterEvent(event)
	end
end

-- Event Un-Registration Function --
function WoWPro:UnregisterEvents(eventtable)
--[[Purpose: Iterates through the supplied table of events, and removes each
event from the guide frame.
]]--
	for _, event in ipairs(eventtable) do
		WoWPro.EventFrame:UnregisterEvent(event)
	end
end

function WoWPro:LoadAllGuides()
    WoWPro:Print("Test Load of All Guides")
    local aCount=0
    local hCount=0
    local nCount=0
    local Count=0
    local nextGID
    local zed
	for guidID,guide in pairs(WoWPro.Guides) do
        WoWPro:Print("Test Loading " .. guidID)
        WoWPro:LoadGuide(guidID)
        nextGID = WoWPro.Guides[guidID].nextGID
        if WoWPro.Guides[guidID].zone then
            zed = WoWPro.Guides[guidID].zone:match("([^%(%-]+)" ):trim()
            if not WoWPro:ValidZone(zed) then
		        WoWPro:Print("Invalid guide zone:"..(WoWPro.Guides[guidID].zone))
		    end
		end
        if nextGID and WoWPro.Guides[nextGID] == nil then
            WoWPro:Print("Successor to " .. guidID .. " which is " .. tostring(nextGID) .. " is invalid.")
        end
        if WoWPro.Guides[guidID].faction then
            if WoWPro.Guides[guidID].faction == "Alliance" then aCount = aCount + 1 end
            if WoWPro.Guides[guidID].faction == "Neutral"  then nCount = nCount + 1 end
            if WoWPro.Guides[guidID].faction == "Horde"    then hCount = hCount + 1 end
        end
        Count = Count + 1
		WoWPro:Print("%d Done! %d A, %d N, %d H guides present", Count, aCount, nCount, hCount)
	end
end

---------
-- Event processing and buckets that are used by multiple modules
---------

do -- QUEST_LOG_UPDATE_bucket Bucket Closure

--[[
	Purpose:
	--------

	This bucket throttle the LOG_UPDATE messages and also make sure that
	the quest auto-complete dialogs are processed after the guide has been
	updated.
]]

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
				WoWPro:AutoCompleteQuestUpdate()
				WoWPro:UpdateQuestTracker()

				quest_log_update = nil
			end

			if gossip_show then

				local qidx = WoWPro.CurrentIndex
				local action, step = WoWPro.action[qidx], WoWPro.step[qidx]
--err("gossip_show: qidx = %s, action = %s, step = %s",qidx,action,step)

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

				end

				gossip_show = nil
			end

			if quest_greeting then
				local qidx = WoWPro.CurrentIndex
				local action, step = WoWPro.action[qidx], WoWPro.step[qidx]
--err("quest_greeting: qidx = %s, action = %s, step = %s",qidx,action,step)

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

				-- Turnin the current quest automaticaly if applicable
				local qidx = WoWPro.CurrentIndex
				if WoWPro.action[qidx] == "T" and GetTitleText() == WoWPro.step[qidx] then
					CompleteQuest()
				end

				quest_progress = nil
			end

			if quest_complete then

				-- Choose the reward automaticaly if there is only one choice
				local qidx = WoWPro.CurrentIndex
				if (WoWPro.action[qidx] == "T" or WoWPro.action[qidx] == "A") and
					GetTitleText() == WoWPro.step[qidx] and
					GetNumQuestChoices() <= 1 then
						GetQuestReward(0)
				end

				quest_complete = nil
			end

			if quest_detail then

				-- Accept the current quest automaticaly if applicable
				local qidx = WoWPro.CurrentIndex
				if WoWPro.action[qidx] == "A" and GetTitleText() == WoWPro.step[qidx] then
					AcceptQuest()
				end

				quest_detail = nil
			end

			f:Hide()
		end
	end)

	function WoWPro:QUEST_LOG_UPDATE_bucket()
		quest_log_update = true
		f:Show()
	end

	function WoWPro:GOSSIP_SHOW_bucket()
		gossip_show = true
		f:Show()
	end

	function WoWPro:QUEST_GREETING_bucket()
		quest_greeting = true
		f:Show()
	end

	function WoWPro:QUEST_PROGRESS_bucket()
		quest_progress = true
		f:Show()
	end

	function WoWPro:QUEST_COMPLETE_bucket()
		quest_complete = true
		f:Show()
	end

	function WoWPro:QUEST_DETAIL_bucket()
		quest_detail = true
		f:Show()
	end

end -- End Bucket Closure

do -- BAG_UPDATE_bucket Waiting Bucket Closure

	local THROTTLE_TIME = 0.2
	local throt
	local f = CreateFrame("Frame")
	f:Hide()
	f:SetScript("OnUpdate", function(self, elapsed)
		throt = throt - elapsed
		if throt < 0 then
			WoWPro:UpdateLootLines() -- Update the loot tracking in the WoWPro quest tracking
			f:Hide()
		end
	end)

	function WoWPro:BAG_UPDATE_bucket()
		-- We will wait THROTTLE_TIME after the last BAG_UPDATE event
		throt = THROTTLE_TIME
		f:Show()
	end

end -- End Bucket Closure
