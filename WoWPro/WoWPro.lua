local _addonname, _addon = ...

-------------------------------------------------------------------------------
-- Localized Lua globals
-------------------------------------------------------------------------------
local _G = getfenv(0)

local print = _G.print
local collectgarbage = _G.collectgarbage
local tostring = _G.tostring
local wipe = _G.wipe
local select = _G.select

local ipairs = _G.ipairs
local pairs = _G.pairs
local tinsert = _G.tinsert

local UIParent = _G.UIParent

local CreateFrame = _G.CreateFrame
local GetAddOnMetadata = _G.GetAddOnMetadata
local GetBindingKey = _G.GetBindingKey
local GetQuestsCompleted = _G.GetQuestsCompleted
local InCombatLockdown = _G.InCombatLockdown
local LibStub = _G.LibStub
local SetBinding = _G.SetBinding

local TomTom = _G.TomTom
local Swatter = _G.Swatter

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

--local WoWProDB
--local WoWProCharDB

-- WoWPro keybindings name descriptions --
_G["BINDING_NAME_CLICK WoWPro_FauxItemButton:LeftButton"] = "Use quest item"
_G.BINDING_HEADER_BINDING_WOWPRO = "WoWPro Keybindings"
_G["BINDING_NAME_CLICK WoWPro_FauxTargetButton:LeftButton"] = "Target quest mob"

-- Debug print function --
function WoWPro:dbp(message)
	if WoWPro.DebugMode and message ~= nil then
		print("|cffffff00WoW-Pro Debug|r: "..message)
	end
end

-- WoWPro print function --
function WoWPro:Print(message)
	if message ~= nil then
		print("|cffffff00WoW-Pro|r: "..message)
	end
end

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
	local WoWProCharDB = _G.WoWProCharDB
	WoWProCharDB = WoWProCharDB or {}
	WoWPro.CharDB = WoWProCharDB
	WoWProCharDB.Guide = WoWProCharDB.Guide or {}
	WoWProCharDB.completedQIDs = WoWProCharDB.completedQIDs or {}
	WoWProCharDB.skippedQIDs = WoWProCharDB.skippedQIDs or {}
	if WoWProCharDB.Enabled == nil then
	    WoWProCharDB.Enabled = true
	end
	--if WoWProDB.global.Deltas == nil then
	--    WoWProDB.global.Deltas = {}
	--end
	WoWProDB.global.Deltas = WoWProDB.global.Deltas or {}
	if #WoWProDB.global.Deltas > 1000 then
		--err("The WoWProDB.global.Deltas table has %s items, you should think about emptying it.", #WoWProDB.global.Deltas)
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
	WoWPro:RegisterEvents( {															-- Setting up core events
		"PLAYER_REGEN_ENABLED", "PARTY_MEMBERS_CHANGED", "QUEST_QUERY_COMPLETE",
		"UPDATE_BINDINGS", "PLAYER_ENTERING_WORLD", "PLAYER_LEAVING_WORLD", "CINEMATIC_STOP"
	})
--	WoWPro.LockdownTimer = nil
	WoWPro.LockdownTimer = 2.0 -- Initial setting so that InitLockdown will get set to nil after login
	WoWPro.EventFrame:SetScript("OnUpdate", function(self, elapsed)
	    if WoWPro.LockdownTimer ~= nil then
	        WoWPro.LockdownTimer = WoWPro.LockdownTimer - elapsed
	        if WoWPro.LockdownTimer < 0 then
	            WoWPro.LockdownTimer = nil
	            WoWPro.InitLockdown = false
                WoWPro:LoadGuide()			-- Loads Current Guide (if nil, loads NilGuide)
	        end
	    end
	end)

	WoWPro.EventFrame:SetScript("OnEvent", function(self, event, ...)		-- Setting up event handler
		if WoWPro.InitLockdown then
		    WoWPro:dbp("LockEvent Fired: "..event)
		else
		    WoWPro:dbp("Event Fired: "..event)
		end


		-- Unlocking event processong till after things get settled --
		if event == "PLAYER_ENTERING_WORLD" then
		    WoWPro.LockdownTimer = 2.0

		-- Updating party-dependant options --
		elseif event == "PARTY_MEMBERS_CHANGED"
			or event == "UPDATE_BINDINGS"
			or event == "PARTY_MEMBERS_CHANGED" then
			WoWPro:UpdateGuide()
		--end

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
		end

		if WoWPro.InitLockdown then
		    return
		end

		-- Locking event processong till after things get settled --
		if event == "PLAYER_LEAVING_WORLD" then
		    WoWPro.InitLockdown = true
		end

		-- Unlocking guide frame when leaving combat --
		if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_ENTERING_WORLD" or event == "CINEMATIC_STOP" then
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

		-- Module Event Handlers --
		for name, module in WoWPro:IterateModules() do
			if WoWPro[name].EventHandler
			and WoWProDB.char.currentguide
			and WoWPro.Guides[WoWProDB.char.currentguide]
			and WoWPro.Guides[WoWProDB.char.currentguide].guidetype == name
			then WoWPro[name]:EventHandler(self, event, ...) end
		end
	end)

--	WoWPro:MapPoint()				-- Maps the active step
	-- If the base addon was disabled by the user, put it to sleep now.
	if not WoWProCharDB.Enabled then
	    WoWPro:Print("|cffff3333Disabled|r: Core Addon")
	    WoWPro:Disable()
	    return
	end
end

-- Called when the addon is disabled --
function WoWPro:OnDisable()
	WoWPro:AbleFrames()								-- Hides all frames
	WoWPro.EventFrame:UnregisterAllEvents()	-- Unregisters all events
	WoWPro:RemoveMapPoint()							-- Removes any active map points
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

-- Trace stuff
function WoWPro:Trace(text)
	if WoWPro.DB.global.Trace_on then
		local stack = _G.debugstack(2,3,0)
		stack = stack:gsub("Interface\\AddOns\\","")
		stack = stack:gsub("\n[.][.][.]","")
		stack = stack:gsub("\n"," - ")
		stack = stack:gsub(" function "," ")
		_G.tinsert(WoWPro.DB.global.Trace, text .. " - " .. stack .. _G.time())
	end
end