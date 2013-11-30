local _addonname, _addon = ...

-------------------------------------------------------------------------------
-- Localized Lua globals
-------------------------------------------------------------------------------
local _G 								= getfenv(0)

local collectgarbage					= _G.collectgarbage
local date								= _G.date
local geterrorhandler				= _G.geterrorhandler
local print 							= _G.print
local select							= _G.select
local time								= _G.time
local tostring							= _G.tostring
local tostringall						= _G.tostringall
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
local HideUIPanel						= _G.HideUIPanel
local InCombatLockdown				= _G.InCombatLockdown
local IsInInstance					= _G.IsInInstance
local IsShiftKeyDown 				= _G.IsShiftKeyDown
local SelectActiveQuest				= _G.SelectActiveQuest
local SelectAvailableQuest			= _G.SelectAvailableQuest
local SelectGossipActiveQuest		= _G.SelectGossipActiveQuest
local SelectGossipAvailableQuest	= _G.SelectGossipAvailableQuest
local SetBinding 						= _G.SetBinding
local GetBuildInfo					= _G.GetBuildInfo
local GetNumGroupMembers			= _G.GetNumGroupMembers
local GetNumPartyMembers			= _G.GetNumPartyMembers
local QueryQuestsCompleted			= _G.QueryQuestsCompleted


local DEFAULT_CHAT_FRAME			= _G.DEFAULT_CHAT_FRAME
local GossipFrame						= _G.GossipFrame
local QuestFrameDetailPanel		= _G.QuestFrameDetailPanel
local QuestFrameGreetingPanel		= _G.QuestFrameGreetingPanel
local QuestFrameProgressPanel		= _G.QuestFrameProgressPanel
local QuestFrameRewardPanel		= _G.QuestFrameRewardPanel

local LibStub 							= _G.LibStub

local TomTom 							= _G.TomTom
local Swatter 							= _G.Swatter

local function err(msg,...) geterrorhandler()(msg:format(tostringall(...)) .. " - " .. time()) end

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
    -- WoWPro:dbp("Creating WoWPro.%s:%s()",target.name,name)
    target[name] = WoWPro[name]
  end
end

function WoWPro:Export(target)
    tinsert(WoWPro.mixins,target)
end

--- MOP Function Compatability Section
do
	local _, _, _, interface = GetBuildInfo()
	WoWPro.MOP = (interface >= 50000)
end

if WoWPro.MOP then
	WoWPro.GetNumPartyMembers = GetNumGroupMembers
	WoWPro.QueryQuestsCompleted = function () end
	WoWPro.GetQuestsCompleted = function (x) return x; end
	WoWPro.IsQuestFlaggedCompleted = _G.IsQuestFlaggedCompleted
else
	WoWPro.GetNumPartyMembers = GetNumPartyMembers
	WoWPro.QueryQuestsCompleted = QueryQuestsCompleted -- After QUEST_QUERY_COMPLETE
	WoWPro.GetQuestsCompleted = GetQuestsCompleted
	WoWPro.IsQuestFlaggedCompleted = function(qid)  return WoWPro.CharDB.completedQIDs[qid] end
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
	WoWProCharDB.Taxi = WoWProCharDB.Taxi or {}
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

	-- Diable Aboutis if present since it conflict with WoWPro quest automation
	if _G.Aboutis then _G.Aboutis:Disable() end

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
	--if not Swatter then
	--	WoWPro:Print("It looks like you don't have |cff33ff33Swatter|r installed. "
	--		.."While we would love to claim our software is bug free, errors have occured. "
	--		.."Download it for free from http://auctioneeraddon.com/dl/AddOns/!Swatter-5.6.4424.zip or consider installing Auctioneer from www.curse.com .")
	--end

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
		"MINIMAP_ZONE_CHANGED",
		"PARTY_MEMBERS_CHANGED",
		"PLAYER_ENTERING_WORLD",
		"PLAYER_LEAVING_WORLD",
		"PLAYER_LEVEL_UP",
--		"PLAYER_REGEN_ENABLED",
		"QUEST_ACCEPTED",
		"QUEST_ACCEPT_CONFIRM",
		"QUEST_AUTOCOMPLETE",
		"QUEST_COMPLETE",
		"QUEST_DETAIL",
		"QUEST_GREETING",
--		"QUEST_LOG_UPDATE",
		"QUEST_PROGRESS",
--		"QUEST_QUERY_COMPLETE",
		"UPDATE_BINDINGS",
		"ZONE_CHANGED",
		"ZONE_CHANGED_INDOORS",
		"ZONE_CHANGED_NEW_AREA",
		"CRITERIA_UPDATE",
		"PET_BATTLE_OPENING_START",
		"PET_BATTLE_CLOSE",
		"UNIT_QUEST_LOG_CHANGED",
	})
	if not WoWPro.MOP then WoWPro:RegisterEvents( {"QUEST_QUERY_COMPLETE"} ) end
--	WoWPro.LockdownTimer = nil
	WoWPro.LockdownTimer = 1.0 -- Initial setting so that InitLockdown will get set to nil after login
	WoWPro.EventFrame:SetScript("OnUpdate", function(self, elapsed)
	    if WoWPro.LockdownTimer ~= nil then
	        WoWPro.LockdownTimer = WoWPro.LockdownTimer - elapsed
	        if WoWPro.LockdownTimer < 0 then
	            WoWPro:dbp("Lockdown Timer expired.  Return to normal")
	            WoWPro.LockdownTimer = nil
	            WoWPro.InitLockdown = false
               WoWPro:LoadGuide()			-- Loads Current Guide (if nil, loads NilGuide)
					WoWPro:UpdateGuide()			-- First update

               -- Disable the OnUpdate()
               WoWPro.EventFrame:SetScript("OnUpdate",nil)
	        end
	    end
	end)

	--WoWPro.eventcount = WoWPro.eventcount or {}

	local TIME_MAX = 1000

	WoWPro.EventFrame:SetScript("OnEvent", function(self, event, ...)		-- Setting up event handler

		if _G.perr_onevent then err("event = %s", event) end

		debugprofilestart()

		--WoWPro.eventcount[event] = WoWPro.eventcount[event] and WoWPro.eventcount[event] + 1 or 1

		if WoWPro.InitLockdown then
		    WoWPro:dbp("LockEvent Fired: "..event)
		else
		    WoWPro:dbp("Event Fired: "..event)
		end

		-- Locking event processong till after things get settled --
		if event == "PLAYER_LEAVING_WORLD" then
			WoWPro:dbp("Locking Down 1")

		-- Noticing if we have entered a Dungeon!
		elseif event == "ZONE_CHANGED_NEW_AREA" then
			if WoWProCharDB.AutoHideLevelingInsideInstances then
				if IsInInstance() then
					WoWPro:Print("|cff33ff33Instance Auto Hide|r: Leveling Module")
					WoWPro.MainFrame:Hide()
					WoWPro.Titlebar:Hide()
					WoWPro.Hidden = true
					local time_taken = debugprofilestop()
					if time_taken > TIME_MAX then
						err("event = %s, time_taken = %s",event,time_taken)
					end
					return
				elseif WoWPro.Hidden == true then
					WoWPro:Print("|cff33ff33Instance Exit Auto Show|r: Leveling Module")
					WoWPro.MainFrame:Show()
					WoWPro.Titlebar:Show()
					WoWPro.Hidden = nil
				end
			end

			WoWPro:AutoCompleteZone(...)

			-- Noticing if we are doing a pet battle!
		elseif event == "PET_BATTLE_OPENING_START" and (not WoWPro.Hidden) then
			--WoWPro:Print("|cff33ff33Pet Battle Auto Hide|r: Leveling Module")
			if InCombatLockdown() then return end
			WoWPro.MainFrame:Hide()
			WoWPro.Titlebar:Hide()
			WoWPro.Hidden = true
				--return

		elseif event == "PET_BATTLE_CLOSE" and WoWPro.Hidden then
			--WoWPro:Print("|cff33ff33Pet Battle Exit Auto Show|r: Leveling Module")
			WoWPro.MainFrame:Show()
			WoWPro.Titlebar:Show()
			WoWPro.Hidden = nil		

		elseif event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "MINIMAP_ZONE_CHANGED" then
			WoWPro:AutoCompleteZone(...)

		end

		if WoWPro.InitLockdown then
			local time_taken = debugprofilestop()
			if time_taken > TIME_MAX then
				err("event = %s, time_taken = %s",event,time_taken)
			end
			return
		end

		-- Updating party-dependant options --
		if event == "PARTY_MEMBERS_CHANGED"	or event == "UPDATE_BINDINGS" then
			WoWPro:UpdateGuide()


		-- Refresh the arrow after a change of continent or similar zoning
		elseif event == "PLAYER_ENTERING_WORLD" then
			WoWPro:DelayMapPoint()
			
		-- Update the guide in case there were quest or objectives completed during the cinematics
		-- and the UI was not updated.
		elseif event == "CINEMATIC_STOP" then
			--WoWPro:UpdateGuide()
			--WoWPro:MapPoint()
--err("CINEMATIC_STOP: InCinematic() = %s", InCinematic())
			WoWPro:DelayMapPoint(true)

		-- Update Achivement criteria based stuff
		elseif event == "CRITERIA_UPDATE" then
			--WoWPro:UpdateGuide()
			WoWPro:AutoCompleteQuestUpdate()

		end

		-- ====================================================================
		-- Event management shared between all the modules (used to be in each)
		-- ====================================================================
		if event == "CHAT_MSG_SYSTEM" then
			-- Set Hearth and deal with quest that are accepted and completed in one step
			WoWPro:CHAT_MSG_SYSTEM_parser(...)

		elseif event == "UNIT_QUEST_LOG_CHANGED" or event == "QUEST_ACCEPTED" or event == "QUEST_ACCEPT_CONFIRM" then
				WoWPro:QUEST_LOG_UPDATE_bucket(event, ...)

		-- All the auto-complete messages need to be processed after the QUEST_LOG_UPDATE
		-- hense the bucket. Also, all of them can be escaped with the shift key.
		elseif event == "GOSSIP_SHOW" then
	 		if WoWProCharDB.AutoSelect == true and not IsShiftKeyDown() then
				WoWPro:GOSSIP_SHOW_bucket()
			end

		elseif event == "QUEST_COMPLETE" then
			-- CompletingQuestQID is used by AutoCompleteSetHearth to detect quests that
			-- never show up in the quest log i.e. quests that are completed as soon as
			-- you accept them.
			WoWPro.CompletingQuestQID = GetQuestID()

			if WoWProCharDB.AutoTurnin == true  and not IsShiftKeyDown() then
				WoWPro:QUEST_COMPLETE_bucket()
			end

  		elseif event == "QUEST_DETAIL" then

			if WoWProCharDB.AutoAccept == true and not IsShiftKeyDown() then
				WoWPro:QUEST_DETAIL_bucket()
			end

		elseif event == "QUEST_GREETING" then

			if WoWProCharDB.AutoSelect == true and not IsShiftKeyDown() then
				WoWPro:QUEST_GREETING_bucket()
			end

		elseif event == "QUEST_PROGRESS" then

			if WoWProCharDB.AutoTurnin == true  and not IsShiftKeyDown() then
				WoWPro:QUEST_PROGRESS_bucket()
			end

		elseif event == "BAG_UPDATE" then
			WoWPro:BAG_UPDATE_bucket()

		elseif event == "PLAYER_LEVEL_UP" then
			WoWPro:AutoCompleteLevel(...)

		elseif event == "TAXIMAP_OPENED" then
			WoWPro:RecordTaxiLocations(...)

		elseif event == "UI_INFO_MESSAGE" then
			WoWPro:AutoCompleteGetFP(...)

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

		local time_taken = debugprofilestop()
		if time_taken > TIME_MAX then
			err("event = %s, time_taken = %s",event,time_taken)
		end

	end) -- OnEvent

--	WoWPro:MapPoint()				-- Maps the active step
	-- If the base addon was disabled by the user, put it to sleep now.
	if not WoWProCharDB.Enabled then
	    WoWPro:Disable()
	    return
	end

	-- Server query for completed quests --
	WoWPro.QueryQuestsCompleted()

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

	-- Re-enable Aboutis
	if _G.Aboutis then _G.Aboutis:Enable() end

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
	local nextG
	local zed
	for guidID,guide in pairs(WoWPro.Guides) do
        WoWPro:Print("Test Loading " .. guidID)
        WoWPro:LoadGuide(guidID)
        nextG = WoWPro:NextGuide(guidID)
        if WoWPro.Guides[guidID].zone then
            zed = WoWPro.Guides[guidID].zone:match("([^%(%-]+)" ):trim()
            if not WoWPro:ValidZone(zed) then
		        WoWPro:Print("Invalid guide zone:"..(WoWPro.Guides[guidID].zone))
		    end
		end
        if nextG and WoWPro.Guides[nextG] == nil then
            WoWPro:Print("Successor to " .. guidID .. " which is " .. tostring(nextG) .. " is invalid.")
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

	-- MOP compatibility
	local ACTIVE_QUEST_PARAMS = WoWPro.MOP and 5 or 4
	local AVAILABLE_QUEST_PARAMS = WoWPro.MOP and 6 or 5


	local THROTTLE_TIME = 0.2
	local throt, quest_log_update, gossip_show, quest_greeting, quest_detail, quest_complete, quest_progress
	local f = CreateFrame("Frame")
	f:Hide()
	f:SetScript("OnShow", function(self)
		throt = THROTTLE_TIME
	end)
	f:SetScript("OnUpdate", function(self, elapsed)
		throt = throt - elapsed
		if throt < 0 and WoWPro.action and WoWPro.lootqty then
			f:Hide()

			if quest_log_update then
--err("PopulateQuestLog")

				WoWPro:PopulateQuestLog()
				WoWPro:AutoCompleteQuestUpdate()
				WoWPro:UpdateQuestTracker()

				quest_log_update = nil
			end

			--if gossip_show then
			if GossipFrame:IsShown() then

				local qidx = WoWPro.CurrentIndex
				local action, step = WoWPro.action[qidx], WoWPro.step[qidx]
--err("gossip_show: qidx = %s, action = %s, step = %s",qidx,action,step)

				if WoWPro.CharDB.AutoTurnin and action == "T" then

					local index = 1
					repeat
						local item = select((index-1)*ACTIVE_QUEST_PARAMS + 1, GetGossipActiveQuests())
						if item == step then
							SelectGossipActiveQuest(index)
							break
						end
						index = index + 1
					until not item

				elseif WoWPro.CharDB.AutoAccept and action == "A" then

					local index = 1
					repeat
						local item = select((index-1)*AVAILABLE_QUEST_PARAMS + 1, GetGossipAvailableQuests())
						if item == step then
							SelectGossipAvailableQuest(index)
							break
						end
						index = index + 1
					until not item
				end

				WoWPro:QUEST_LOG_UPDATE_bucket()
				--gossip_show = nil
			end

			--if quest_greeting then
			if QuestFrameGreetingPanel:IsShown() then
				local qidx = WoWPro.CurrentIndex
				local action, step = WoWPro.action[qidx], WoWPro.step[qidx]

				if WoWPro.CharDB.AutoSelect and action == "T" then
					local numActiveQuests = GetNumActiveQuests()
					local qidx = WoWPro.rows[WoWPro.ActiveStickyCount+1].index
					for i=1, numActiveQuests do
						if GetActiveTitle(i) == step then
							SelectActiveQuest(i)
							break
						end
					end
				elseif WoWPro.CharDB.AutoSelect and action == "A" then
					local numAvailableQuests = GetNumAvailableQuests()
					for i=1, numAvailableQuests do
						if GetAvailableTitle(i) == step then
							SelectAvailableQuest(i)
							break
						end
					end
				end

				WoWPro:QUEST_LOG_UPDATE_bucket()
				--quest_greeting = nil
			end

			--if quest_progress then
			if QuestFrameProgressPanel:IsShown() then

				-- Turnin the current quest automaticaly if applicable
				local qidx = WoWPro.CurrentIndex
				if WoWPro.CharDB.AutoTurnin and WoWPro.action[qidx] == "T" and GetTitleText() == WoWPro.step[qidx] then
					CompleteQuest()
				end

				WoWPro:QUEST_LOG_UPDATE_bucket()
				--quest_progress = nil
			end

			--if quest_complete then
			if QuestFrameRewardPanel:IsShown() then

				-- Choose the reward automaticaly if there is only one choice
				local qidx = WoWPro.CurrentIndex
				if WoWPro.CharDB.AutoTurnin and 
					(WoWPro.action[qidx] == "T" or WoWPro.action[qidx] == "A") and
					GetTitleText() == WoWPro.step[qidx] and
					GetNumQuestChoices() <= 1 then
						GetQuestReward(1)
				end

				WoWPro:QUEST_LOG_UPDATE_bucket()
				--quest_complete = nil
			end

			--if quest_detail then
			if QuestFrameDetailPanel:IsShown() then
--err("AutoAcceptQuest")

				-- Accept the current quest automaticaly if applicable
				local qidx = WoWPro.CurrentIndex
				if WoWPro.CharDB.AutoAccept and WoWPro.action[qidx] == "A" and GetTitleText() == WoWPro.step[qidx] then
					-- Auto Quest are automaticaly accepted as soon as you see the quest text
					-- This code was lifted from QuestFrame.lua to prevent calling AcceptQuest()
					-- for an already accepted quest.
					if ( _G.QuestFrame.autoQuest ) then
						HideUIPanel(_G.QuestFrame)
					else
						AcceptQuest()
					end
				end

				WoWPro:QUEST_LOG_UPDATE_bucket()
				--quest_detail = nil
			end
		
		end
	end)
	function WoWPro:QUEST_LOG_UPDATE_bucket(arg1, arg2, arg3)
--err("QUEST_LOG_UPDATE_bucket: arg1 = %s, arg2 = %s, arg3 = %s",arg1, arg2, arg3)	
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
		if throt < 0 and WoWPro.lootitem then
			f:Hide()
			WoWPro:UpdateLootLines() -- Update the loot tracking in the WoWPro quest tracking
		end
	end)

	function WoWPro:BAG_UPDATE_bucket()
		-- We will wait THROTTLE_TIME after the last BAG_UPDATE event
		throt = THROTTLE_TIME
		f:Show()
	end

end -- End Bucket Closure

do -- DelayMapUpdate Bucket Closure

	local THROTTLE_TIME = 1
	local throt, need_update_guide
	local f = CreateFrame("Frame")
	f:Hide()
	f:SetScript("OnUpdate", function(self, elapsed)
		throt = throt - elapsed
		if throt < 0 and not WoWPro.InitLockdown then
			f:Hide()
			if need_update_guide then
				WoWPro:UpdateGuide()
				need_update_guide = nil
			end
--err("need_update_guide = %s",need_update_guide)
			WoWPro:MapPoint() -- Update the TomTom arrow
		end
	end)

	function WoWPro:DelayMapPoint(needUpdateGuide)
		-- We will wait THROTTLE_TIME before doing a MapUpdate()
		throt = THROTTLE_TIME
		need_update_guide = needUpdateGuide or need_update_guide
		f:Show()
	end

end -- End Bucket Closure

