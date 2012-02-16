-------------------------------------------------------------------------------
-- Localized Lua globals
-------------------------------------------------------------------------------
local _G = getfenv(0)

local pairs = _G.pairs
local tinsert = _G.tinsert
local sort = _G.sort

local LibStub = _G.LibStub

---------------------------------------------
--      WoWPro_WorldEvents_GuideList.lua      --
---------------------------------------------

local WoWPro = LibStub("AceAddon-3.0"):GetAddon("WoWPro")

WoWPro.WorldEvents.GuideList = {}

-- Creating a Table of Guides for the Guide List and sorting based on name --
local guides = {}
for guidID,guide in pairs(WoWPro.Guides) do
  if guide.guidetype == "WorldEvents" then
    local function progress ()
	    if WoWPro.CharDB.Guide[guidID] and WoWPro.CharDB.Guide[guidID].progress and WoWPro.CharDB.Guide[guidID].total then
	        return WoWPro.CharDB.Guide[guidID].progress.."/"..WoWPro.CharDB.Guide[guidID].total
	    end
	    return ""
	end
  	tinsert(guides, {
  		GID = guidID,
		Zone = guide.zone,
		Name = guide.name,
		Author = guide.author,
		Category = guide.category,
		Progress = progress
  	})
  	end
  end
sort(guides, function(a,b) return a.Name < b.Name end)
WoWPro.WorldEvents.GuideList.Guides = guides

-- Sorting Functions --
local sorttype = "Default"
local function authorSort()
	if sorttype == "AuthorAsc" then
		sort(guides, function(a,b) return a.Author > b.Author end)
		WoWPro.WorldEvents:UpdateGuideList()
		sorttype = "AuthorDesc"
	else
		sort(guides, function(a,b) return a.Author < b.Author end)
		WoWPro.WorldEvents:UpdateGuideList()
		sorttype = "AuthorAsc"
  	end
end
local function nameSort()
	if sorttype == "NameAsc" then
		sort(guides, function(a,b) return a.Name > b.Name end)
		WoWPro.WorldEvents:UpdateGuideList()
		sorttype = "NameDesc"
	else
		sort(guides, function(a,b) return a.Name < b.Name end)
		WoWPro.WorldEvents:UpdateGuideList()
		sorttype = "NameAsc"
  	end
end
local function categorySort()
	if sorttype == "CategoryAsc" then
		sort(guides, function(a,b) return a.Category > b.Category end)
		WoWPro.WorldEvents:UpdateGuideList()
		sorttype = "CategoryDesc"
	else
		sort(guides, function(a,b) return a.Category < b.Category end)
		WoWPro.WorldEvents:UpdateGuideList()
		sorttype = "CategoryAsc"
	end
end



-- Describe the table to the Core Module
WoWPro.WorldEvents.GuideList.Format={{"Name",0.35,nameSort},{"Category",0.20,categorySort},{"Author",0.20,authorSort},{"Progress",0.15,nil}}

WoWPro.WorldEvents:Print("Guide Setup complete")

