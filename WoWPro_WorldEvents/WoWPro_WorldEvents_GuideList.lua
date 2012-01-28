-------------------------------------------------------------------------------
-- Localized Lua globals
-------------------------------------------------------------------------------
local _G 							= getfenv(0)

local floor							= _G.floor
local max							= _G.max

local ipairs						= _G.ipairs
local pairs							= _G.pairs
local sort							= _G.sort
local tinsert						= _G.tinsert

local CreateFrame					= _G.CreateFrame
local IsShiftKeyDown				= _G.IsShiftKeyDown

local WoWPro_Locale 				= _G.WoWPro_Locale

local LibStub = _G.LibStub


---------------------------------------------
--      WoWPro_WorldEvents_GuideList.lua      --
---------------------------------------------

local WoWPro = LibStub("AceAddon-3.0"):GetAddon("WoWPro")
local L = WoWPro_Locale
local ROWHEIGHT, GAP, EDGEGAP = 17, 8, 16
local titlerow, rows, offset = {}, {}, 0
local NUMROWS = 15

-- Creating a Table of Guides for the Guide List and sorting based on name --
local guides = {}
for guidID,guide in pairs(WoWPro.Guides) do
	if guide.guidetype == "WorldEvents" then
		tinsert(guides, {
			GID = guidID,
			zone = guide.zone,
			name = guide.name,
			author = guide.author,
			category = guide.category,
			sequence = guide.sequence,
		})
	end
end
sort(guides, function(a,b) return a.name < b.name end)

-- Populating Guide List --
function WoWPro.WorldEvents.UpdateGuideList()
	local WoWProDB, WoWProCharDB = WoWPro.DB, WoWPro.CharDB

	if not WoWPro.WorldEvents.GuideList then return end
	if not WoWPro.WorldEvents.GuideList:IsVisible() then return end
	if not WoWPro.WorldEvents.GuideList:IsVisible() then return end
	for i,row in ipairs(WoWPro.WorldEvents.GuideList.rows) do
		row.i = i + offset
		local iGuide = guides[row.i]
		if iGuide then
			local GID = iGuide.GID
			row.name:SetText(iGuide.name)
			row.author:SetText(iGuide.author)
			row.category:SetText(iGuide.category)
			row.guide = GID
			if WoWProCharDB.Guide[GID] and WoWProCharDB.Guide[GID].total and WoWProCharDB.Guide[GID].progress then
				row.progress:SetText(WoWProCharDB.Guide[GID].progress.."/"..WoWProCharDB.Guide[GID].total)
			else
				row.progress:SetText("")
			end

			if WoWProDB.char.currentguide == GID then
				row:SetChecked(true)
			else
				row:SetChecked(false)
			end
		else
			row:Hide()
		end
		local function OnClick()
			if not WoWPro.WorldEvents:IsEnabled() then return end
			if IsShiftKeyDown() then
				WoWProCharDB.Guide[guides[row.i].GID] = nil
				WoWPro.WorldEvents.Resetting = true
				WoWPro:LoadGuide(guides[row.i].GID)
				for j = 1,WoWPro.stepcount do
					if WoWPro.QID[j] then WoWProCharDB.skippedQIDs[WoWPro.QID[j]] = nil end
				end
				WoWPro:LoadGuide(guides[row.i].GID)
				WoWPro.WorldEvents.Resetting = false
			else
				WoWPro:LoadGuide(guides[row.i].GID)
			end
				WoWPro.WorldEvents.UpdateGuideList()
		end

		row:SetScript("OnClick", OnClick)
	end
end

function WoWPro.WorldEvents.CreateGuideList()
	local frame = CreateFrame("Frame", nil, WoWPro.GuideList.box)
	frame:SetAllPoints()

	local scrollbar = WoWPro:CreateScrollbar(frame, 6)

	do -- Title Row --
		-- Title Backdrop Settings --
		local titlerowBG = {
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			tile = true,
			tileSize = 16,
			insets = { left = 0, right = 0, top = 5, bottom = -5}
		}

		titlerow.buffer = CreateFrame("CheckButton", nil, frame)
		titlerow.buffer:SetBackdrop(titlerowBG)
		titlerow.buffer:SetBackdropColor(0.3, 0.2, 0.2, 1)
		titlerow.buffer:SetHeight(ROWHEIGHT)

		titlerow.name = CreateFrame("CheckButton", nil, frame)
		titlerow.name:SetBackdrop(titlerowBG)
		titlerow.name:SetBackdropColor(0.3, 0.2, 0.2, 1)
		titlerow.name:SetHeight(ROWHEIGHT)

		titlerow.category = CreateFrame("CheckButton", nil, frame)
		titlerow.category:SetBackdrop(titlerowBG)
		titlerow.category:SetBackdropColor(0.3, 0.2, 0.2, 1)
		titlerow.category:SetHeight(ROWHEIGHT)

		titlerow.author = CreateFrame("CheckButton", nil, frame)
		titlerow.author:SetBackdrop(titlerowBG)
		titlerow.author:SetBackdropColor(0.3, 0.2, 0.2, 1)
		titlerow.author:SetHeight(ROWHEIGHT)

		titlerow.progress = CreateFrame("CheckButton", nil, frame)
		titlerow.progress:SetBackdrop(titlerowBG)
		titlerow.progress:SetBackdropColor(0.3, 0.2, 0.2, 1)
		titlerow.progress:SetHeight(ROWHEIGHT)

		titlerow.buffer:SetPoint("TOPLEFT", 4, 0)
		titlerow.buffer:SetWidth(4)
		titlerow.name:SetPoint("LEFT", titlerow.buffer, "RIGHT", 0, 0)
		titlerow.name:SetWidth(155)
		titlerow.category:SetPoint("LEFT", titlerow.name, "RIGHT", 0, 0)
		titlerow.category:SetWidth(50)
		titlerow.author:SetPoint("LEFT", titlerow.category, "RIGHT", 0, 0)
		titlerow.author:SetWidth(85)
		titlerow.progress:SetPoint("LEFT", titlerow.author, "RIGHT", 0, 0)
		titlerow.progress:SetPoint("TOPRIGHT", scrollbar, "TOPLEFT", -5, 22)

		do -- Title Row Text Fields --
			local name = titlerow.name:CreateFontString(nil, nil, "GameFontWhite")
			local category = titlerow.category:CreateFontString(nil, nil, "GameFontWhite")
			local author = titlerow.author:CreateFontString(nil, nil, "GameFontWhite")
			local progress = titlerow.progress:CreateFontString(nil, nil, "GameFontWhite")

			name:SetPoint("LEFT", 0, -5)
			name:SetWidth(155)
			category:SetPoint("LEFT", name, "RIGHT", 0, 0)
			category:SetWidth(50)
			author:SetPoint("LEFT", category, "RIGHT", 0, 0)
			author:SetWidth(85)
			progress:SetPoint("LEFT", author, "RIGHT", 0, 0)
			progress:SetPoint("TOPRIGHT", scrollbar, "TOPLEFT", -5, 14)

			name:SetText(L["Name"])
			category:SetText(L["Type"])
			author:SetText(L["Author"])
			progress:SetText(L["Progress"])

			name:SetJustifyH("LEFT")
			category:SetJustifyH("LEFT")
			author:SetJustifyH("LEFT")
			progress:SetJustifyH("LEFT")

			titlerow.name.text = name
			titlerow.category.text = category
			titlerow.author.text = author
			titlerow.progress.text = progress
		end


		-- Sorting Functions --
		local sorttype = "Default"
		local function authorSort()
			if sorttype == "AuthorAsc" then
				sort(guides, function(a,b) return a.author > b.author end)
				WoWPro.Leveling.UpdateGuideList()
				sorttype = "AuthorDesc"
			else
				sort(guides, function(a,b) return a.author < b.author end)
				WoWPro.Leveling.UpdateGuideList()
				sorttype = "AuthorAsc"
			end
		end
		local function nameSort()
			if sorttype == "NameAsc" then
				sort(guides, function(a,b) return a.name > b.name end)
				WoWPro.Leveling.UpdateGuideList()
				sorttype = "NameDesc"
			else
				sort(guides, function(a,b) return a.name < b.name end)
				WoWPro.Leveling.UpdateGuideList()
				sorttype = "NameAsc"
			end
		end
		local function categorySort()
			if sorttype == "CategoryAsc" then
				sort(guides, function(a,b) return a.category > b.category end)
				WoWPro.Leveling.UpdateGuideList()
				sorttype = "CategoryDesc"
			else
				sort(guides, function(a,b) return a.category < b.category end)
				WoWPro.Leveling.UpdateGuideList()
				sorttype = "CategoryAsc"
			end
		end
		titlerow.author:SetScript("OnClick", authorSort)
		titlerow.name:SetScript("OnClick", nameSort)
		titlerow.category:SetScript("OnClick", categorySort)

	end

	frame.rows = {}
	-- Rows --
	for i=1,NUMROWS do
		local row = CreateFrame("CheckButton", nil, frame)

		local name = row:CreateFontString(nil, nil, "GameFontHighlightSmall")
		local category = row:CreateFontString(nil, nil, "GameFontHighlightSmall")
		local author = row:CreateFontString(nil, nil, "GameFontHighlightSmall")
		local progress = row:CreateFontString(nil, nil, "GameFontHighlightSmall")

		local prevrow

		-- Anchor Settings --
		do
			if i == 1 then
				row:SetPoint("TOPLEFT", titlerow.name, "BOTTOMLEFT", 0, -10)
				row:SetPoint("TOPRIGHT", titlerow.progress, "BOTTOMRIGHT", 0, -10)
				prevrow = titlerow
				GAP = -10

			else
				row:SetPoint("TOPLEFT", frame.rows[i-1], "BOTTOMLEFT", 0, 0)
				row:SetPoint("TOPRIGHT", frame.rows[i-1], "BOTTOMRIGHT", 0, 0)
				prevrow = frame.rows[i-1]
				GAP = 0
			end

			name:SetPoint("TOPLEFT", prevrow.name, "BOTTOMLEFT", 0, GAP)
			name:SetPoint("TOPRIGHT", prevrow.name, "BOTTOMRIGHT", 0, GAP)
			name:SetHeight(ROWHEIGHT)
			category:SetPoint("TOPLEFT", prevrow.category, "BOTTOMLEFT", 0, GAP)
			category:SetPoint("TOPRIGHT", prevrow.category, "BOTTOMRIGHT", 0, GAP)
			category:SetHeight(ROWHEIGHT)
			author:SetPoint("TOPLEFT", prevrow.author, "BOTTOMLEFT", 0, GAP)
			author:SetPoint("TOPRIGHT", prevrow.author, "BOTTOMRIGHT", 0, GAP)
			author:SetHeight(ROWHEIGHT)
			progress:SetPoint("TOPLEFT", prevrow.progress, "BOTTOMLEFT", 0, GAP)
			progress:SetPoint("TOPRIGHT", prevrow.progress, "BOTTOMRIGHT", 0, GAP)
			progress:SetHeight(ROWHEIGHT)

			row:SetPoint("LEFT", 4, 0)
			row:SetPoint("RIGHT", -4, 0)
			row:SetHeight(ROWHEIGHT)
		end


		local highlight = row:CreateTexture()
		highlight:SetTexture("Interface\\HelpFrame\\HelpFrameButton-Highlight")
		highlight:SetTexCoord(0, 1, 0, 0.578125)
		highlight:SetAllPoints()
		row:SetHighlightTexture(highlight)
		row:SetCheckedTexture(highlight)

		name:SetJustifyH("LEFT")
		category:SetJustifyH("LEFT")
		author:SetJustifyH("LEFT")
		progress:SetJustifyH("LEFT")

		-- On Click - Load Guide Clicked --

		row.name = name
		row.category = category
		row.author = author
		row.progress = progress
		frame.rows[i] = row
	end

	frame:EnableMouseWheel()
	frame:SetScript("OnMouseWheel", function(self, val) scrollbar:SetValue(scrollbar:GetValue() - val*NUMROWS/3) end)

	local function OnShow(self)
		scrollbar:SetValue(0);
		WoWPro.WorldEvents.UpdateGuideList()
		WoWPro.NextGuideDialog:Hide()
	end
	frame:SetScript("OnShow", OnShow)
	OnShow(frame)

	WoWPro.WorldEvents.GuideList = frame

	local f = scrollbar:GetScript("OnValueChanged")
	scrollbar:SetMinMaxValues(0, max(0, #guides - NUMROWS))
	scrollbar:SetScript("OnValueChanged", function(self, value, ...)
		offset = floor(value)
		WoWPro.WorldEvents.UpdateGuideList()
		return f(self, value, ...)
	end)
end