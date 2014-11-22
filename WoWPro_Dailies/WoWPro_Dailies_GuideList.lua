
local function err(msg,...) _G.geterrorhandler()(msg:format(_G.tostringall(...)) .. " - " .. _G.time()) end

--------------------------------------------
--      WoWPro_Dailies_GuideList.lua      --
--------------------------------------------

WoWPro.Dailies.GuideList = {}

-- Creating a Table of Guides for the Guide List and sorting based on level --
local guides = {}

local function AddInfo(guide)
    if guide.name then
        return
    end
    if not guide.faction then
        WoWPro.Dailies:Error("Guide %s: missing faction",guide.GID)
        --guide.name = "Unknown"
        guide.category = guide.zone
        return
    end
    if tonumber(guide.faction) then
        name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfoByID(guide.faction)
        --guide.name = guide.faction
        guide.category = guide.zone
        return
    --local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfoByID(guide.faction)
    local isGood, name_or_err = pcall(GetFactionInfoByID, guide.faction)
    if not isGood or not name_or_err then
        if not isGood then
            WoWPro.Dailies:Error("Guide %s: GetFactionInfoByID error for [%s]",guide.GID,tostring(guide.faction))
        else
            WoWPro.Dailies:Error("Guide %s: bad faction [%s]",guide.GID,tostring(guide.faction))
        end
        --guide.name = "BadFaction"
        guide.category = guide.zone
    else
        --guide.name = name_or_err
        guide.category = guide.zone
    end
end

local function Init()
    if WoWPro.Dailies.GuideList.Guides then
        return
    end
    wipe(guides)
    for guidID,guide in pairs(WoWPro.Guides) do
    	if guide.guidetype == "Dailies" then
    	    local function progress ()
    	        if WoWProCharDB.Guide[guidID] and WoWProCharDB.Guide[guidID].progress and WoWProCharDB.Guide[guidID].total then
    	            return WoWProCharDB.Guide[guidID].progress.."/"..WoWProCharDB.Guide[guidID].total
    	        end
    	        return ""
    	    end
    	    AddInfo(guide)
    		table.insert(guides, {
    			GID = guidID,
    			guide = guide,
    			Zone = guide.zone,
    			Name = guide.name,
    		    Author = guide.author,
    			Category = guide.category or guide.zone,
    			Progress = progress
    		})
    	end
    end
    table.sort(guides, function(a,b) return a.Name < b.Name end)
    WoWPro.Dailies.GuideList.Guides = guides
end

-- Sorting Functions --
local sorttype = "Default"
local function authorSort()
	if sorttype == "AuthorAsc" then
		table.sort(guides, function(a,b) return a.Author > b.Author end)
		WoWPro.Dailies:UpdateGuideList()
		sorttype = "AuthorDesc"
	else
		table.sort(guides, function(a,b) return a.Author < b.Author end)
		WoWPro.Dailies:UpdateGuideList()
		sorttype = "AuthorAsc"
	end
end
local function nameSort()
    if sorttype == "ZoneAsc" then
        table.sort(guides, function(a,b) return a.Name > b.Name end)
        WoWPro.Dailies:UpdateGuideList()
        sorttype = "ZoneDesc"
    else
        table.sort(guides, function(a,b) return a.Name < b.Name end)
        WoWPro.Dailies:UpdateGuideList()
        sorttype = "ZoneAsc"
    end
end
local function zoneSort()
    if sorttype == "ZoneAsc" then
        table.sort(guides, function(a,b) return a.Zone > b.Zone end)
        WoWPro.Dailies:UpdateGuideList()
        sorttype = "ZoneDesc"
    else
        table.sort(guides, function(a,b) return a.Zone < b.Zone end)
        WoWPro.Dailies:UpdateGuideList()
        sorttype = "ZoneAsc"
    end
end
local function GIDSort()
    if sorttype == "GIDAsc" then
        table.sort(guides, function(a,b) return a.GID > b.GID end)
        WoWPro.Dailies:UpdateGuideList()
        sorttype = "GIDDesc"
    else
        table.sort(guides, function(a,b) return a.GID < b.GID end)
        WoWPro.Dailies:UpdateGuideList()
        sorttype = "GIDAsc"
    end
end
local function categorySort()
	if sorttype == "RangeAsc" then
		table.sort(guides, function(a,b) return a.Category > b.Category end)
		WoWPro.Dailies:UpdateGuideList()
		sorttype = "RangeDesc"
	else
		table.sort(guides, function(a,b) return a.Category < b.Category end)
		WoWPro.Dailies:UpdateGuideList()
		sorttype = "RangeAsc"
	end
end



-- Describe the table to the Core Module
--WoWPro.Dailies.GuideList.Format={{"Name",0.35,nameSort},{"Category",0.15,categorySort},{"Author",0.30,authorSort},{"Progress",0.20,nil}}
WoWPro.Dailies.GuideList.Format={{"Name",0.25,nameSort},{"Category",0.35,categorySort},{"Author",0.20,authorSort},{"Progress",0.20,nil}}
WoWPro.Dailies.GuideList.Init = Init
-- Fancy tooltip!
function WoWPro.Dailies.GuideTooltipInfo(row, tooltip, guide)
    GameTooltip:SetOwner(row, "ANCHOR_TOPLEFT")
    GameTooltip:AddLine(guide.side)
    GameTooltip:AddLine(guide.name)
    if guide.icon then
        GameTooltip:AddTexture(guide.icon,1,1,1,1)
        GameTooltip:AddLine(guide.icon)
    else
        GameTooltip:AddTexture("Interface\\PaperDollInfoFrame\\SpellSchoolIcon5")
    end
    GameTooltip:AddDoubleLine("Start Level:",tostring(guide.startlevel),1,1,1,guide.startlevel and unpack(WoWPro.LevelColor(guide.startlevel)) or 1)
    GameTooltip:AddDoubleLine("Mean Level:",string.format("%.2f",guide.level or 0),1,1,1,unpack(WoWPro.LevelColor(guide)))
    if guide.endlevel then
        GameTooltip:AddDoubleLine("End Level:",tostring(guide.endlevel),1,1,1,unpack(WoWPro.LevelColor(guide.endlevel)))
    end
end

WoWPro.Dailies:dbp("Guide Setup complete")

