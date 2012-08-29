-------------------------------------------------------------------------------
-- Localized Lua globals
-------------------------------------------------------------------------------
local _G = getfenv(0)

local strupper = _G.strupper
local tostring = _G.tostring

local pairs = _G.pairs

local GetMapInfo = _G.GetMapInfo
local GetCurrentMapAreaID = _G.GetCurrentMapAreaID
local GetCurrentMapContinent = _G.GetCurrentMapContinent
local GetCurrentMapZone = _G.GetCurrentMapZone
local GetCurrentMapAreaID = _G.GetCurrentMapAreaID
local GetMapZones = _G.GetMapZones
local SetMapZoom = _G.SetMapZoom
local SetMapByID = _G.SetMapByID
local GetNumDungeonMapLevels = _G.GetNumDungeonMapLevels
local GetMapContinents = _G.GetMapContinents

----------------------------------
--      WoWPro_Zones.lua      --
----------------------------------

local WoWPro = _G.LibStub("AceAddon-3.0"):GetAddon("WoWPro")

-- Map information from 4.1.14007 as of May 6th, 2011

WoWPro.Zone2MapID = {
		["TwilightHighlands_terrain1"] = {
			["numFloors"] = 1,
			["mapID"] = 770,
			["cont"] = 2,
			["zone"] = 0,
			["mapName"] = "TwilightHighlands_terrain1",
			["floor"] = 1,
		},
		["Eye of Eternity"] = {
			["dungeon"] = "DragonSoul",
			["mapID"] = 824,
			["floor"] = 4,
			["mapName"] = "Eye of Eternity",
		},
		["DragonSoul"] = {
			["numFloors"] = 7,
			["mapID"] = 824,
			["mapName"] = "DragonSoul",
		},
		["Spine of Deathwing"] = {
			["dungeon"] = "DragonSoul",
			["mapID"] = 824,
			["floor"] = 6,
			["mapName"] = "Spine of Deathwing",
		},
		["Skyfire Airship"] = {
			["dungeon"] = "DragonSoul",
			["mapID"] = 824,
			["floor"] = 5,
			["mapName"] = "Skyfire Airship",
		},
		["Maw of Go'rath"] = {
			["dungeon"] = "DragonSoul",
			["mapID"] = 824,
			["floor"] = 2,
			["mapName"] = "Maw of Go'rath",
		},
		["Dragonblight in DragonSoul"] = {
			["dungeon"] = "DragonSoul",
			["mapID"] = 824,
			["floor"] = 1,
			["mapName"] = "Dragonblight",
		},
		["Maw of Shu'ma"] = {
			["dungeon"] = "DragonSoul",
			["mapID"] = 824,
			["floor"] = 3,
			["mapName"] = "Maw of Shu'ma",
		},
		["The Maelstrom in DragonSoul"] = {
			["dungeon"] = "DragonSoul",
			["mapID"] = 824,
			["floor"] = 7,
			["mapName"] = "The Maelstrom",
		},
		
		["The Hinterlands"] = {
			["numFloors"] = 0,
			["mapID"] = 26,
			["cont"] = 2,
			["zone"] = "The Hinterlands",
			["mapName"] = "The Hinterlands",
			["zonei"] = 30,
		},
		["The Plague Quarter"] = {
			["dungeon"] = "Naxxramas",
			["mapID"] = 535,
			["floor"] = 4,
			["mapName"] = "The Plague Quarter",
		},
		["The Antechamber of Ulduar"] = {
			["dungeon"] = "Ulduar",
			["mapID"] = 529,
			["floor"] = 2,
			["mapName"] = "The Antechamber of Ulduar",
		},
		["The Courtyard"] = {
			["dungeon"] = "ShadowfangKeep",
			["mapID"] = 764,
			["floor"] = 1,
			["mapName"] = "The Courtyard",
		},
		["Drak'Tharon Overlook"] = {
			["dungeon"] = "DrakTharonKeep",
			["mapID"] = 534,
			["floor"] = 2,
			["mapName"] = "Drak'Tharon Overlook",
		},
		["Westfall"] = {
			["numFloors"] = 0,
			["mapID"] = 39,
			["cont"] = 2,
			["zone"] = "Westfall",
			["mapName"] = "Westfall",
			["zonei"] = 38,
		},
		["Abyssal Depths"] = {
			["numFloors"] = 0,
			["mapID"] = 614,
			["cont"] = 2,
			["zone"] = "Abyssal Depths",
			["mapName"] = "Abyssal Depths",
			["zonei"] = 1,
		},
		["Band of Transmutation"] = {
			["dungeon"] = "Nexus80",
			["mapID"] = 528,
			["floor"] = 3,
			["mapName"] = "Band of Transmutation",
		},
		["Orgrimmar"] = {
			["dungeon"] = "Orgrimmar",
			["mapID"] = 321,
			["cont"] = 1,
			["zone"] = "Orgrimmar",
			["mapName"] = "Orgrimmar",
			["floor"] = 1,
		},
		["The Nexus"] = {
			["numFloors"] = 1,
			["mapID"] = 520,
			["mapName"] = "TheNexus",
			["floor"] = 1,
		},
		["The Upper Reaches"] = {
			["dungeon"] = "IcecrownCitadel",
			["mapID"] = 604,
			["floor"] = 5,
			["mapName"] = "The Upper Reaches",
		},
		["The Brood Pit"] = {
			["dungeon"] = "AzjolNerub",
			["mapID"] = 533,
			["floor"] = 1,
			["mapName"] = "The Brood Pit",
		},
		["Zul'Drak"] = {
			["numFloors"] = 0,
			["mapID"] = 496,
			["cont"] = 4,
			["zone"] = "Zul'Drak",
			["mapName"] = "Zul'Drak",
			["zonei"] = 12,
		},
		["Northern Stranglethorn"] = {
			["numFloors"] = 0,
			["mapID"] = 37,
			["cont"] = 2,
			["zone"] = "Northern Stranglethorn",
			["mapName"] = "Northern Stranglethorn",
			["zonei"] = 18,
		},
		["BlackwingLair"] = {
			["numFloors"] = 4,
			["mapID"] = 755,
			["mapName"] = "BlackwingLair",
		},
		["RazorfenKraul"] = {
			["numFloors"] = 1,
			["mapID"] = 761,
			["mapName"] = "RazorfenKraul",
			["floor"] = 1,
		},
		["Darnassus"] = {
			["numFloors"] = 0,
			["mapID"] = 381,
			["cont"] = 1,
			["zone"] = "Darnassus",
			["mapName"] = "Darnassus",
			["zonei"] = 7,
		},
		["Azuremyst Isle"] = {
			["numFloors"] = 0,
			["mapID"] = 464,
			["cont"] = 1,
			["zone"] = "Azuremyst Isle",
			["mapName"] = "Azuremyst Isle",
			["zonei"] = 4,
		},
		["Gilneas"] = {
			["numFloors"] = 0,
			["mapID"] = 545,
			["mapName"] = "Gilneas",
		},
		["Detention Block"] = {
			["dungeon"] = "BlackrockDepths",
			["mapID"] = 704,
			["floor"] = 1,
			["mapName"] = "Detention Block",
		},
		["Un'Goro Crater"] = {
			["numFloors"] = 0,
			["mapID"] = 201,
			["cont"] = 1,
			["zone"] = "Un'Goro Crater",
			["mapName"] = "Un'Goro Crater",
			["zonei"] = 27,
		},
		["Ironforge"] = {
			["numFloors"] = 0,
			["mapID"] = 341,
			["cont"] = 2,
			["zone"] = "Ironforge",
			["mapName"] = "Ironforge",
			["zonei"] = 14,
		},
		["Halls of Mourning"] = {
			["dungeon"] = "SethekkHalls",
			["mapID"] = 723,
			["floor"] = 2,
			["mapName"] = "Halls of Mourning",
		},
		["Western Plaguelands"] = {
			["numFloors"] = 0,
			["mapID"] = 22,
			["cont"] = 2,
			["zone"] = "Western Plaguelands",
			["mapName"] = "Western Plaguelands",
			["zonei"] = 37,
		},
		["The Wall Walk"] = {
			["dungeon"] = "ShadowfangKeep",
			["mapID"] = 764,
			["floor"] = 7,
			["mapName"] = "The Wall Walk",
		},
		["Shadowforge City"] = {
			["dungeon"] = "BlackrockDepths",
			["mapID"] = 704,
			["floor"] = 2,
			["mapName"] = "Shadowforge City",
		},
		["ZulGurub"] = {
			["numFloors"] = 0,
			["mapID"] = 697,
			["mapName"] = "ZulGurub",
		},
		["The Frost Queen's Lair"] = {
			["dungeon"] = "IcecrownCitadel",
			["mapID"] = 604,
			["floor"] = 4,
			["mapName"] = "The Frost Queen's Lair",
		},
		["The Upper Necropolis"] = {
			["dungeon"] = "Naxxramas",
			["mapID"] = 535,
			["floor"] = 6,
			["mapName"] = "The Upper Necropolis",
		},
		["Moonshrine Sanctum"] = {
			["dungeon"] = "BlackfathomDeeps",
			["mapID"] = 688,
			["floor"] = 2,
			["mapName"] = "Moonshrine Sanctum",
		},
		["TheSlavePens"] = {
			["numFloors"] = 1,
			["mapID"] = 728,
			["mapName"] = "TheSlavePens",
			["floor"] = 1,
		},
		["Vault of C'Thun"] = {
			["dungeon"] = "AhnQiraj",
			["mapID"] = 766,
			["floor"] = 3,
			["mapName"] = "Vault of C'Thun",
		},
		["Blackrock Stadium"] = {
			["dungeon"] = "BlackrockSpire",
			["mapID"] = 721,
			["floor"] = 7,
			["mapName"] = "Blackrock Stadium",
		},
		["Winterspring"] = {
			["numFloors"] = 0,
			["mapID"] = 281,
			["cont"] = 1,
			["zone"] = "Winterspring",
			["mapName"] = "Winterspring",
			["zonei"] = 28,
		},
		["Lower Broken Stair"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 7,
			["mapName"] = "Lower Broken Stair",
		},
		["Stasis Block: Trion"] = {
			["dungeon"] = "TheArcatraz",
			["mapID"] = 731,
			["floor"] = 1,
			["mapName"] = "Stasis Block: Trion",
		},
		["The Rookery"] = {
			["dungeon"] = "BlackrockSpire",
			["mapID"] = 721,
			["floor"] = 6,
			["mapName"] = "The Rookery",
		},
		["The Road to Stratholme"] = {
			["dungeon"] = "CoTStratholme",
			["mapID"] = 521,
			["floor"] = 1,
			["mapName"] = "The Road to Stratholme",
		},
		["Naxxramas"] = {
			["numFloors"] = 6,
			["mapID"] = 535,
			["mapName"] = "Naxxramas",
		},
		["Darkshore"] = {
			["numFloors"] = 0,
			["mapID"] = 42,
			["cont"] = 1,
			["zone"] = "Darkshore",
			["mapName"] = "Darkshore",
			["zonei"] = 6,
		},
		["Blade's Edge Mountains"] = {
			["numFloors"] = 0,
			["mapID"] = 475,
			["cont"] = 3,
			["zone"] = "Blade's Edge Mountains",
			["mapName"] = "Blade's Edge Mountains",
			["zonei"] = 1,
		},
		["ZulGurub793"] = {
			["numFloors"] = 0,
			["mapID"] = 793,
			["mapName"] = "ZulGurub793",
		},
		["Upper Broken Stair"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 8,
			["mapName"] = "Upper Broken Stair",
		},
		["ScarletMonastery"] = {
			["numFloors"] = 4,
			["mapID"] = 762,
			["mapName"] = "ScarletMonastery",
		},
		["BlackrockDepths"] = {
			["numFloors"] = 2,
			["mapID"] = 704,
			["mapName"] = "BlackrockDepths",
		},
		["Shattrath City"] = {
			["numFloors"] = 0,
			["mapID"] = 481,
			["cont"] = 3,
			["zone"] = "Shattrath City",
			["mapName"] = "Shattrath City",
			["zonei"] = 6,
		},
		["HallsofReflection"] = {
			["numFloors"] = 1,
			["mapID"] = 603,
			["mapName"] = "HallsofReflection",
			["floor"] = 1,
		},
		["Halls of Stone"] = {
			["numFloors"] = 1,
			["mapID"] = 526,
			["mapName"] = "Ulduar77",
			["floor"] = 1,
		},
		["Master's Terrace"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 6,
			["mapName"] = "Master's Terrace",
		},
		["VaultofArchavon"] = {
			["numFloors"] = 1,
			["mapID"] = 532,
			["mapName"] = "VaultofArchavon",
			["floor"] = 1,
		},
		["The Prison of Yogg-Saron"] = {
			["dungeon"] = "Ulduar",
			["mapID"] = 529,
			["floor"] = 4,
			["mapName"] = "The Prison of Yogg-Saron",
		},
		["VioletHold"] = {
			["numFloors"] = 1,
			["mapID"] = 536,
			["mapName"] = "VioletHold",
			["floor"] = 1,
		},
		["Netherspace"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 17,
			["mapName"] = "Netherspace",
		},
		["TheForgeofSouls"] = {
			["numFloors"] = 1,
			["mapID"] = 601,
			["mapName"] = "TheForgeofSouls",
			["floor"] = 1,
		},
		["WarsongGulch"] = {
			["numFloors"] = 0,
			["mapID"] = 443,
			["mapName"] = "WarsongGulch",
		},
		["MagtheridonsLair"] = {
			["numFloors"] = 1,
			["mapID"] = 779,
			["mapName"] = "MagtheridonsLair",
			["floor"] = 1,
		},
		["Nagrand"] = {
			["numFloors"] = 0,
			["mapID"] = 477,
			["cont"] = 3,
			["zone"] = "Nagrand",
			["mapName"] = "Nagrand",
			["zonei"] = 3,
		},
		["The Gilded Gate"] = {
			["dungeon"] = "AzjolNerub",
			["mapID"] = 533,
			["floor"] = 3,
			["mapName"] = "The Gilded Gate",
		},
		["The Grand Approach "] = {
			["dungeon"] = "Ulduar",
			["mapID"] = 529,
			["floor"] = 1,
			["mapName"] = "The Grand Approach ",
		},
		["Shimmering Expanse"] = {
			["numFloors"] = 0,
			["mapID"] = 615,
			["cont"] = 2,
			["zone"] = "Shimmering Expanse",
			["mapName"] = "Shimmering Expanse",
			["zonei"] = 23,
		},
		["Tazz'Alaor"] = {
			["dungeon"] = "BlackrockSpire",
			["mapID"] = 721,
			["floor"] = 1,
			["mapName"] = "Tazz'Alaor",
		},
		["Nefarian's Lair"] = {
			["dungeon"] = "BlackwingLair",
			["mapID"] = 755,
			["floor"] = 4,
			["mapName"] = "Nefarian's Lair",
		},
		["Caverns of Maraudon"] = {
			["dungeon"] = "Maraudon",
			["mapID"] = 750,
			["floor"] = 1,
			["mapName"] = "Caverns of Maraudon",
		},
		["The Maelstrom737"] = {
			["numFloors"] = 0,
			["mapID"] = 737,
			["cont"] = 5,
			["zone"] = "The Maelstrom",
			["mapName"] = "The Maelstrom737",
			["zonei"] = 4,
		},
		["Eversong Woods"] = {
			["numFloors"] = 0,
			["mapID"] = 462,
			["cont"] = 2,
			["zone"] = "Eversong Woods",
			["mapName"] = "Eversong Woods",
			["zonei"] = 11,
		},
		["CoTHillsbradFoothills"] = {
			["numFloors"] = 0,
			["mapID"] = 734,
			["mapName"] = "CoTHillsbradFoothills",
		},
		["Tanaris"] = {
			["numFloors"] = 0,
			["mapID"] = 161,
			["cont"] = 1,
			["zone"] = "Tanaris",
			["mapName"] = "Tanaris",
			["zonei"] = 21,
		},
		["Stratholme"] = {
			["numFloors"] = 2,
			["mapID"] = 765,
			["mapName"] = "Stratholme",
		},
		["Borean Tundra"] = {
			["numFloors"] = 0,
			["mapID"] = 486,
			["cont"] = 4,
			["zone"] = "Borean Tundra",
			["mapName"] = "Borean Tundra",
			["zonei"] = 1,
		},
		["The Icy Depths"] = {
			["dungeon"] = "TheArgentColiseum",
			["mapID"] = 543,
			["floor"] = 2,
			["mapName"] = "The Icy Depths",
		},
		["The Power Station"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 16,
			["mapName"] = "The Power Station",
		},
		["AlteracValley"] = {
			["numFloors"] = 0,
			["mapID"] = 401,
			["mapName"] = "AlteracValley",
		},
		["Tomb of the Earthrager"] = {
			["dungeon"] = "HallsofOrigination",
			["mapID"] = 759,
			["floor"] = 2,
			["mapName"] = "Tomb of the Earthrager",
		},
		["Shadowmoon Valley"] = {
			["numFloors"] = 0,
			["mapID"] = 473,
			["cont"] = 3,
			["zone"] = "Shadowmoon Valley",
			["mapName"] = "Shadowmoon Valley",
			["zonei"] = 5,
		},
		["MoltenCore"] = {
			["numFloors"] = 1,
			["mapID"] = 696,
			["mapName"] = "MoltenCore",
			["floor"] = 1,
		},
		["ShadowLabyrinth"] = {
			["numFloors"] = 1,
			["mapID"] = 724,
			["mapName"] = "ShadowLabyrinth",
			["floor"] = 1,
		},
		["Warpwood Quarter"] = {
			["dungeon"] = "DireMaul",
			["mapID"] = 699,
			["floor"] = 5,
			["mapName"] = "Warpwood Quarter",
		},
		["TheLostIsles_terrain1"] = {
			["numFloors"] = 0,
			["mapID"] = 681,
			["mapName"] = "TheLostIsles_terrain1",
		},
		["Hadronox's Lair"] = {
			["dungeon"] = "AzjolNerub",
			["mapID"] = 533,
			["floor"] = 2,
			["mapName"] = "Hadronox's Lair",
		},
		["GruulsLair"] = {
			["numFloors"] = 1,
			["mapID"] = 776,
			["mapName"] = "GruulsLair",
			["floor"] = 1,
		},
		["PitofSaron"] = {
			["numFloors"] = 0,
			["mapID"] = 602,
			["mapName"] = "PitofSaron",
		},
		["Dragonspire Hall"] = {
			["dungeon"] = "BlackrockSpire",
			["mapID"] = 721,
			["floor"] = 5,
			["mapName"] = "Dragonspire Hall",
		},
		["GilneasBattleground2"] = {
			["numFloors"] = 0,
			["mapID"] = 736,
			["mapName"] = "GilneasBattleground2",
		},
		["Thunder Bluff"] = {
			["numFloors"] = 0,
			["mapID"] = 362,
			["cont"] = 1,
			["zone"] = "Thunder Bluff",
			["mapName"] = "Thunder Bluff",
			["zonei"] = 25,
		},
		["The Vestibules of Drak'Tharon"] = {
			["dungeon"] = "DrakTharonKeep",
			["mapID"] = 534,
			["floor"] = 1,
			["mapName"] = "The Vestibules of Drak'Tharon",
		},
		["Dining Hall"] = {
			["dungeon"] = "ShadowfangKeep",
			["mapID"] = 764,
			["floor"] = 2,
			["mapName"] = "Dining Hall",
		},
		["RuinsofAhnQiraj"] = {
			["numFloors"] = 0,
			["mapID"] = 717,
			["mapName"] = "RuinsofAhnQiraj",
		},
		["TheSteamvault"] = {
			["numFloors"] = 2,
			["mapID"] = 727,
			["mapName"] = "TheSteamvault",
		},
		["Moonglade"] = {
			["numFloors"] = 0,
			["mapID"] = 241,
			["cont"] = 1,
			["zone"] = "Moonglade",
			["mapName"] = "Moonglade",
			["zonei"] = 13,
		},
		["Outland"] = {
			["numFloors"] = 0,
			["mapID"] = 466,
			["cont"] = "Continent",
			["zone"] = 3,
			["mapName"] = "Outland",
			["zonei"] = 0,
		},
		["Prison of Immol'Thar"] = {
			["dungeon"] = "DireMaul",
			["mapID"] = 699,
			["floor"] = 4,
			["mapName"] = "Prison of Immol'Thar",
		},
		["The Shrine of Eldretharr"] = {
			["dungeon"] = "DireMaul",
			["mapID"] = 699,
			["floor"] = 6,
			["mapName"] = "The Shrine of Eldretharr",
		},
		["The Mechanar"] = {
			["dungeon"] = "TheMechanar",
			["mapID"] = 730,
			["floor"] = 1,
			["mapName"] = "The Mechanar",
		},
		["Badlands"] = {
			["numFloors"] = 0,
			["mapID"] = 17,
			["cont"] = 2,
			["zone"] = "Badlands",
			["mapName"] = "Badlands",
			["zonei"] = 3,
		},
		["The Construct Quarter"] = {
			["dungeon"] = "Naxxramas",
			["mapID"] = 535,
			["floor"] = 1,
			["mapName"] = "The Construct Quarter",
		},
		["ShadowfangKeep"] = {
			["numFloors"] = 7,
			["mapID"] = 764,
			["mapName"] = "ShadowfangKeep",
		},
		["Crimson Laboratories"] = {
			["dungeon"] = "BlackwingLair",
			["mapID"] = 755,
			["floor"] = 3,
			["mapName"] = "Crimson Laboratories",
		},
		["Ruins of Gilneas"] = {
			["numFloors"] = 0,
			["mapID"] = 684,
			["cont"] = 2,
			["zone"] = "Ruins of Gilneas",
			["mapName"] = "Ruins of Gilneas",
			["zonei"] = 20,
		},
		["Frostmourne"] = {
			["dungeon"] = "IcecrownCitadel",
			["mapID"] = 604,
			["floor"] = 8,
			["mapName"] = "Frostmourne",
		},
		["Tirisfal Glades"] = {
			["numFloors"] = 0,
			["mapID"] = 20,
			["cont"] = 2,
			["zone"] = "Tirisfal Glades",
			["mapName"] = "Tirisfal Glades",
			["zonei"] = 31,
		},
		["BlackwingDescent"] = {
			["numFloors"] = 2,
			["mapID"] = 754,
			["mapName"] = "BlackwingDescent",
		},
		["Sunwell Plateau"] = {
			["dungeon"] = "SunwellPlateau",
			["mapID"] = 789,
			["floor"] = 1,
			["mapName"] = "Sunwell Plateau",
		},
		["Azshara"] = {
			["numFloors"] = 0,
			["mapID"] = 181,
			["cont"] = 1,
			["zone"] = "Azshara",
			["mapName"] = "Azshara",
			["zonei"] = 3,
		},
		["StrandoftheAncients"] = {
			["numFloors"] = 0,
			["mapID"] = 512,
			["mapName"] = "StrandoftheAncients",
		},
		["The Lost Isles"] = {
			["numFloors"] = 0,
			["mapID"] = 544,
			["cont"] = 5,
			["zone"] = "The Lost Isles",
			["mapName"] = "The Lost Isles",
			["zonei"] = 3,
		},
		["The Mind's Eye"] = {
			["dungeon"] = "Ulduar",
			["mapID"] = 529,
			["floor"] = 6,
			["mapName"] = "The Mind's Eye",
		},
		["Icecrown"] = {
			["numFloors"] = 0,
			["mapID"] = 492,
			["cont"] = 4,
			["zone"] = "Icecrown",
			["mapName"] = "Icecrown",
			["zonei"] = 8,
		},
		["Netherstorm"] = {
			["numFloors"] = 0,
			["mapID"] = 479,
			["cont"] = 3,
			["zone"] = "Netherstorm",
			["mapName"] = "Netherstorm",
			["zonei"] = 4,
		},
		["The Steamvault"] = {
			["dungeon"] = "TheSteamvault",
			["mapID"] = 727,
			["floor"] = 1,
			["mapName"] = "The Steamvault",
		},
		["Ahn'Qiraj: The Fallen Kingdom"] = {
			["numFloors"] = 0,
			["mapID"] = 772,
			["cont"] = 1,
			["zone"] = "Ahn'Qiraj: The Fallen Kingdom",
			["mapName"] = "Ahn'Qiraj: The Fallen Kingdom",
			["zonei"] = 1,
		},
		["ZulFarrak"] = {
			["numFloors"] = 0,
			["mapID"] = 686,
			["mapName"] = "ZulFarrak",
		},
		["Uldaman"] = {
			["numFloors"] = 2,
			["mapID"] = 692,
			["mapName"] = "Uldaman",
		},
		["ScarletEnclave"] = {
			["numFloors"] = 0,
			["mapID"] = 502,
			["mapName"] = "ScarletEnclave",
		},
		["Isle of Quel'Danas"] = {
			["numFloors"] = 0,
			["mapID"] = 499,
			["cont"] = 2,
			["zone"] = "Isle of Quel'Danas",
			["mapName"] = "Isle of Quel'Danas",
			["zonei"] = 15,
		},
		["Kezan"] = {
			["numFloors"] = 0,
			["mapID"] = 605,
			["cont"] = 5,
			["zone"] = "Kezan",
			["mapName"] = "Kezan",
			["zonei"] = 2,
		},
		["Gilneas_terrain2"] = {
			["numFloors"] = 0,
			["mapID"] = 679,
			["mapName"] = "Gilneas_terrain2",
		},
		["ArathiBasin"] = {
			["numFloors"] = 0,
			["mapID"] = 461,
			["mapName"] = "ArathiBasin",
		},
		["The Lower Necropolis"] = {
			["dungeon"] = "Naxxramas",
			["mapID"] = 535,
			["floor"] = 5,
			["mapName"] = "The Lower Necropolis",
		},
		["Crystalsong Forest"] = {
			["numFloors"] = 0,
			["mapID"] = 510,
			["cont"] = 4,
			["zone"] = "Crystalsong Forest",
			["mapName"] = "Crystalsong Forest",
			["zonei"] = 2,
		},
		["HallsofOrigination"] = {
			["numFloors"] = 3,
			["mapID"] = 759,
			["mapName"] = "HallsofOrigination",
		},
		["The Twilight Enclave"] = {
			["dungeon"] = "TheBastionofTwilight",
			["mapID"] = 758,
			["floor"] = 1,
			["mapName"] = "The Twilight Enclave",
		},
		["Halls of the Hereafter"] = {
			["dungeon"] = "AuchenaiCrypts",
			["mapID"] = 722,
			["floor"] = 1,
			["mapName"] = "Halls of the Hereafter",
		},
		["Feralas"] = {
			["numFloors"] = 0,
			["mapID"] = 121,
			["cont"] = 1,
			["zone"] = "Feralas",
			["mapName"] = "Feralas",
			["zonei"] = 12,
		},
		["Dun Morogh"] = {
			["numFloors"] = 0,
			["mapID"] = 27,
			["cont"] = 2,
			["zone"] = "Dun Morogh",
			["mapName"] = "Dun Morogh",
			["zonei"] = 7,
		},
		["Cleft of Shadow"] = {
			["dungeon"] = "Orgrimmar",
			["mapID"] = 321,
			["cont"] = 1,
			["zone"] = "Orgrimmar",
			["mapName"] = "Cleft of Shadow",
			["floor"] = 2,
		},
		["Guardian's Library"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 10,
			["mapName"] = "Guardian's Library",
		},
		["AuchenaiCrypts"] = {
			["numFloors"] = 2,
			["mapID"] = 722,
			["mapName"] = "AuchenaiCrypts",
		},
		["The Cape of Stranglethorn"] = {
			["numFloors"] = 0,
			["mapID"] = 673,
			["cont"] = 2,
			["zone"] = "The Cape of Stranglethorn",
			["mapName"] = "The Cape of Stranglethorn",
			["zonei"] = 29,
		},
		["Bloodmyst Isle"] = {
			["numFloors"] = 0,
			["mapID"] = 476,
			["cont"] = 1,
			["zone"] = "Bloodmyst Isle",
			["mapName"] = "Bloodmyst Isle",
			["zonei"] = 5,
		},
		["OnyxiasLair"] = {
			["numFloors"] = 1,
			["mapID"] = 718,
			["mapName"] = "OnyxiasLair",
			["floor"] = 1,
		},
		["Hrothgar's Landing"] = {
			["numFloors"] = 0,
			["mapID"] = 541,
			["cont"] = 4,
			["zone"] = "Hrothgar's Landing",
			["mapName"] = "Hrothgar's Landing",
		},
		["Arathi Highlands"] = {
			["numFloors"] = 0,
			["mapID"] = 16,
			["cont"] = 2,
			["zone"] = "Arathi Highlands",
			["mapName"] = "Arathi Highlands",
			["zonei"] = 2,
		},
		["The Vault of Lights"] = {
			["dungeon"] = "HallsofOrigination",
			["mapID"] = 759,
			["floor"] = 1,
			["mapName"] = "The Vault of Lights",
		},
		["Eastern Kingdoms"] = {
			["numFloors"] = 0,
			["mapID"] = 14,
			["cont"] = 2,
			["zone"] = "Eastern Kingdoms",
			["mapName"] = "Eastern Kingdoms",
			["zonei"] = 0,
		},
		["GilneasX"] = {
			["numFloors"] = 0,
			["mapID"] = 539,
			["mapName"] = "GilneasX",
		},
		["Desolace"] = {
			["numFloors"] = 0,
			["mapID"] = 101,
			["cont"] = 1,
			["zone"] = "Desolace",
			["mapName"] = "Desolace",
			["zonei"] = 8,
		},
		["Veil Sethekk"] = {
			["dungeon"] = "SethekkHalls",
			["mapID"] = 723,
			["floor"] = 1,
			["mapName"] = "Veil Sethekk",
		},
		["TwinPeaks"] = {
			["numFloors"] = 0,
			["mapID"] = 626,
			["mapName"] = "TwinPeaks",
		},
		["AhnQiraj"] = {
			["numFloors"] = 3,
			["mapID"] = 766,
			["mapName"] = "AhnQiraj",
		},
		["TwilightHighlands_terrain1"] = {
			["numFloors"] = 1,
			["mapID"] = 770,
			["cont"] = 2,
			["zone"] = 0,
			["mapName"] = "TwilightHighlands_terrain1",
			["floor"] = 1,
		},
		["Norndir Preperation"] = {
			["dungeon"] = "UtgardeKeep",
			["mapID"] = 523,
			["floor"] = 1,
			["mapName"] = "Norndir Preperation",
		},
		["BlackrockSpire"] = {
			["numFloors"] = 7,
			["mapID"] = 721,
			["mapName"] = "BlackrockSpire",
		},
		["The Military Quarter"] = {
			["dungeon"] = "Naxxramas",
			["mapID"] = 535,
			["floor"] = 3,
			["mapName"] = "The Military Quarter",
		},
		["Dalaran"] = {
			["numFloors"] = 2,
			["mapID"] = 504,
			["cont"] = 4,
			["zone"] = "Dalaran",
			["mapName"] = "Dalaran",
			["floor"] = 1,
			["zonei"] = 3,
		},
		["SunwellPlateau"] = {
			["numFloors"] = 2,
			["mapID"] = 789,
			["mapName"] = "SunwellPlateau",
		},
		["Burning Steppes"] = {
			["numFloors"] = 0,
			["mapID"] = 29,
			["cont"] = 2,
			["zone"] = "Burning Steppes",
			["mapName"] = "Burning Steppes",
			["zonei"] = 5,
		},
		["Halls of Strife"] = {
			["dungeon"] = "BlackwingLair",
			["mapID"] = 755,
			["floor"] = 2,
			["mapName"] = "Halls of Strife",
		},
		["Wetlands"] = {
			["numFloors"] = 0,
			["mapID"] = 40,
			["cont"] = 2,
			["zone"] = "Wetlands",
			["mapName"] = "Wetlands",
			["zonei"] = 39,
		},
		["Upper Library"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 12,
			["mapName"] = "Upper Library",
		},
		["RazorfenDowns"] = {
			["numFloors"] = 1,
			["mapID"] = 760,
			["mapName"] = "RazorfenDowns",
			["floor"] = 1,
		},
		["Ahnkahet"] = {
			["numFloors"] = 1,
			["mapID"] = 522,
			["mapName"] = "Ahnkahet",
			["floor"] = 1,
		},
		["The Dormitory"] = {
			["dungeon"] = "Gnomeregan",
			["mapID"] = 691,
			["floor"] = 2,
			["mapName"] = "The Dormitory",
		},
		["DireMaul"] = {
			["numFloors"] = 6,
			["mapID"] = 699,
			["mapName"] = "DireMaul",
		},
		["Capital Gardens"] = {
			["dungeon"] = "DireMaul",
			["mapID"] = 699,
			["floor"] = 2,
			["mapName"] = "Capital Gardens",
		},
		["Deathbringer's Rise"] = {
			["dungeon"] = "IcecrownCitadel",
			["mapID"] = 604,
			["floor"] = 3,
			["mapName"] = "Deathbringer's Rise",
		},
		["Karazhan"] = {
			["numFloors"] = 17,
			["mapID"] = 799,
			["mapName"] = "Karazhan",
		},
		["MagistersTerrace"] = {
			["numFloors"] = 2,
			["mapID"] = 798,
			["mapName"] = "MagistersTerrace",
		},
		["The Reliquary"] = {
			["dungeon"] = "Scholomance",
			["mapID"] = 763,
			["floor"] = 1,
			["mapName"] = "The Reliquary",
		},
		["Skitterweb Tunnels"] = {
			["dungeon"] = "BlackrockSpire",
			["mapID"] = 721,
			["floor"] = 2,
			["mapName"] = "Skitterweb Tunnels",
		},
		["The Celestial Watch"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 13,
			["mapName"] = "The Celestial Watch",
		},
		["Ruins of Gilneas City"] = {
			["numFloors"] = 0,
			["mapID"] = 685,
			["cont"] = 2,
			["zone"] = "Ruins of Gilneas City",
			["mapName"] = "Ruins of Gilneas City",
			["zonei"] = 21,
		},
		["Opera Hall Balcony"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 5,
			["mapName"] = "Opera Hall Balcony",
		},
		["The Banquet Hall"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 3,
			["mapName"] = "The Banquet Hall",
		},
		["IcecrownCitadel"] = {
			["numFloors"] = 8,
			["mapID"] = 604,
			["mapName"] = "IcecrownCitadel",
		},
		["IsleofConquest"] = {
			["numFloors"] = 0,
			["mapID"] = 540,
			["mapName"] = "IsleofConquest",
		},
		["UtgardeKeep"] = {
			["numFloors"] = 3,
			["mapID"] = 523,
			["mapName"] = "UtgardeKeep",
		},
		["Upper Livery Stables"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 2,
			["mapName"] = "Upper Livery Stables",
		},
		["Servant's Quarters"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 1,
			["mapName"] = "Servant's Quarters",
		},
		["Gilneas_terrain1"] = {
			["numFloors"] = 0,
			["mapID"] = 678,
			["mapName"] = "Gilneas_terrain1",
		},
		["TheRubySanctum"] = {
			["numFloors"] = 0,
			["mapID"] = 609,
			["mapName"] = "TheRubySanctum",
		},
		["The Menagerie"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 9,
			["mapName"] = "The Menagerie",
		},
		["Medivh's Chambers"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 15,
			["mapName"] = "Medivh's Chambers",
		},
		["BattleforGilneas"] = {
			["numFloors"] = 0,
			["mapID"] = 677,
			["mapName"] = "BattleforGilneas",
		},
		["Searing Gorge"] = {
			["numFloors"] = 0,
			["mapID"] = 28,
			["cont"] = 2,
			["zone"] = "Searing Gorge",
			["mapName"] = "Searing Gorge",
			["zonei"] = 22,
		},
		["Silithus"] = {
			["numFloors"] = 0,
			["mapID"] = 261,
			["cont"] = 1,
			["zone"] = "Silithus",
			["mapName"] = "Silithus",
			["zonei"] = 18,
		},
		["CoTMountHyjal"] = {
			["numFloors"] = 0,
			["mapID"] = 775,
			["mapName"] = "CoTMountHyjal",
		},
		["Bridge of Souls"] = {
			["dungeon"] = "AuchenaiCrypts",
			["mapID"] = 722,
			["floor"] = 2,
			["mapName"] = "Bridge of Souls",
		},
		["TheDeadmines"] = {
			["numFloors"] = 2,
			["mapID"] = 756,
			["mapName"] = "TheDeadmines",
		},
		["Grizzly Hills"] = {
			["numFloors"] = 0,
			["mapID"] = 490,
			["cont"] = 4,
			["zone"] = "Grizzly Hills",
			["mapName"] = "Grizzly Hills",
			["zonei"] = 5,
		},
		["The Guest Chambers"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 4,
			["mapName"] = "The Guest Chambers",
		},
		["DrakTharonKeep"] = {
			["numFloors"] = 2,
			["mapID"] = 534,
			["mapName"] = "DrakTharonKeep",
		},
		["Launch Bay"] = {
			["dungeon"] = "Gnomeregan",
			["mapID"] = 691,
			["floor"] = 3,
			["mapName"] = "Launch Bay",
		},
		["Skywall"] = {
			["numFloors"] = 1,
			["mapID"] = 769,
			["mapName"] = "Skywall",
			["floor"] = 1,
		},
		["Gnomeregan"] = {
			["numFloors"] = 4,
			["mapID"] = 691,
			["mapName"] = "Gnomeregan",
		},
		["The Vacant Den"] = {
			["dungeon"] = "ShadowfangKeep",
			["mapID"] = 764,
			["floor"] = 3,
			["mapName"] = "The Vacant Den",
		},
		["WailingCaverns"] = {
			["numFloors"] = 1,
			["mapID"] = 749,
			["mapName"] = "WailingCaverns",
			["floor"] = 1,
		},
		["Crusader's Square"] = {
			["dungeon"] = "Stratholme",
			["mapID"] = 765,
			["floor"] = 1,
			["mapName"] = "Crusader's Square",
		},
		["Throne of Neptulon"] = {
			["dungeon"] = "ThroneofTides",
			["mapID"] = 767,
			["floor"] = 2,
			["mapName"] = "Throne of Neptulon",
		},
		["Abyssal Halls"] = {
			["dungeon"] = "ThroneofTides",
			["mapID"] = 767,
			["floor"] = 1,
			["mapName"] = "Abyssal Halls",
		},
		["The Repository"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 11,
			["mapName"] = "The Repository",
		},
		["Library"] = {
			["dungeon"] = "ScarletMonastery",
			["mapID"] = 762,
			["floor"] = 2,
			["mapName"] = "Library",
		},
		["Scholomance"] = {
			["numFloors"] = 4,
			["mapID"] = 763,
			["mapName"] = "Scholomance",
		},
		["Kelp'thar Forest"] = {
			["numFloors"] = 0,
			["mapID"] = 610,
			["cont"] = 2,
			["zone"] = "Kelp'thar Forest",
			["mapName"] = "Kelp'thar Forest",
			["zonei"] = 16,
		},
		["Upper Observatory"] = {
			["dungeon"] = "ShadowfangKeep",
			["mapID"] = 764,
			["floor"] = 5,
			["mapName"] = "Upper Observatory",
		},
		["TheBastionofTwilight"] = {
			["numFloors"] = 3,
			["mapID"] = 758,
			["mapName"] = "TheBastionofTwilight",
		},
		["Ashenvale"] = {
			["numFloors"] = 0,
			["mapID"] = 43,
			["cont"] = 1,
			["zone"] = "Ashenvale",
			["mapName"] = "Ashenvale",
			["zonei"] = 2,
		},
		["Wintergrasp"] = {
			["numFloors"] = 0,
			["mapID"] = 501,
			["cont"] = 4,
			["zone"] = "Wintergrasp",
			["mapName"] = "Wintergrasp",
			["zonei"] = 11,
		},
		["Walk of the Makers"] = {
			["dungeon"] = "HallsofLightning",
			["mapID"] = 525,
			["floor"] = 2,
			["mapName"] = "Walk of the Makers",
		},
		["Cathedral"] = {
			["dungeon"] = "ScarletMonastery",
			["mapID"] = 762,
			["floor"] = 4,
			["mapName"] = "Cathedral",
		},
		["TheTempleOfAtalHakkar"] = {
			["numFloors"] = 1,
			["mapID"] = 687,
			["mapName"] = "TheTempleOfAtalHakkar",
			["floor"] = 1,
		},
		["Hall of Blackhand"] = {
			["dungeon"] = "BlackrockSpire",
			["mapID"] = 721,
			["floor"] = 4,
			["mapName"] = "Hall of Blackhand",
		},
		["TheUnderbog"] = {
			["numFloors"] = 1,
			["mapID"] = 726,
			["mapName"] = "TheUnderbog",
			["floor"] = 1,
		},
		["Dalaran City"] = {
			["dungeon"] = "Dalaran",
			["mapID"] = 504,
			["cont"] = 4,
			["zone"] = "Dalaran",
			["mapName"] = "Dalaran City",
			["floor"] = 1,
		},
		["Northern Barrens"] = {
			["numFloors"] = 0,
			["mapID"] = 11,
			["cont"] = 1,
			["zone"] = "Northern Barrens",
			["mapName"] = "Northern Barrens",
			["zonei"] = 16,
		},
		["Lower Pinnacle"] = {
			["dungeon"] = "UtgardePinnacle",
			["mapID"] = 524,
			["floor"] = 1,
			["mapName"] = "Lower Pinnacle",
		},
		["Unyielding Garrison"] = {
			["dungeon"] = "HallsofLightning",
			["mapID"] = 525,
			["floor"] = 1,
			["mapName"] = "Unyielding Garrison",
		},
		["Royal Quarters"] = {
			["dungeon"] = "IcecrownCitadel",
			["mapID"] = 604,
			["floor"] = 6,
			["mapName"] = "Royal Quarters",
		},
		["The Broken Hall"] = {
			["dungeon"] = "BlackwingDescent",
			["mapID"] = 754,
			["floor"] = 1,
			["mapName"] = "The Broken Hall",
		},
		["Hordemar City"] = {
			["dungeon"] = "BlackrockSpire",
			["mapID"] = 721,
			["floor"] = 3,
			["mapName"] = "Hordemar City",
		},
		["Durotar"] = {
			["numFloors"] = 0,
			["mapID"] = 4,
			["cont"] = 1,
			["zone"] = "Durotar",
			["mapName"] = "Durotar",
			["zonei"] = 9,
		},
		["Howling Fjord"] = {
			["numFloors"] = 0,
			["mapID"] = 491,
			["cont"] = 4,
			["zone"] = "Howling Fjord",
			["mapName"] = "Howling Fjord",
			["zonei"] = 6,
		},
		["Tyr's Terrace"] = {
			["dungeon"] = "UtgardeKeep",
			["mapID"] = 523,
			["floor"] = 3,
			["mapName"] = "Tyr's Terrace",
		},
		["ZulAman"] = {
			["numFloors"] = 0,
			["mapID"] = 781,
			["mapName"] = "ZulAman",
		},
		["Loch Modan"] = {
			["numFloors"] = 0,
			["mapID"] = 35,
			["cont"] = 2,
			["zone"] = "Loch Modan",
			["mapName"] = "Loch Modan",
			["zonei"] = 17,
		},
		["Dustwallow Marsh"] = {
			["numFloors"] = 0,
			["mapID"] = 141,
			["cont"] = 1,
			["zone"] = "Dustwallow Marsh",
			["mapName"] = "Dustwallow Marsh",
			["zonei"] = 10,
		},
		["The Headmaster's Study"] = {
			["dungeon"] = "Scholomance",
			["mapID"] = 763,
			["floor"] = 3,
			["mapName"] = "The Headmaster's Study",
		},
		["BlackrockCaverns"] = {
			["numFloors"] = 2,
			["mapID"] = 753,
			["mapName"] = "BlackrockCaverns",
		},
		-- This seems to have gone!
		["Dragonblight"] = {
			["numFloors"] = 0,
			["mapID"] = 488,
			["cont"] = 4,
			["zone"] = "Dragonblight",
			["mapName"] = "Dragonblight",
		},
		["LostCityofTolvir"] = {
			["numFloors"] = 0,
			["mapID"] = 747,
			["mapName"] = "LostCityofTolvir",
		},
		["Terokkar Forest"] = {
			["numFloors"] = 0,
			["mapID"] = 478,
			["cont"] = 3,
			["zone"] = "Terokkar Forest",
			["mapName"] = "Terokkar Forest",
			["zonei"] = 7,
		},
		["Twilight Forge"] = {
			["dungeon"] = "BlackrockCaverns",
			["mapID"] = 753,
			["floor"] = 2,
			["mapName"] = "Twilight Forge",
		},
		["TheBotanica"] = {
			["numFloors"] = 1,
			["mapID"] = 729,
			["mapName"] = "TheBotanica",
			["floor"] = 1,
		},
		["Silvermoon City"] = {
			["numFloors"] = 0,
			["mapID"] = 480,
			["cont"] = 2,
			["zone"] = "Silvermoon City",
			["mapName"] = "Silvermoon City",
			["zonei"] = 24,
		},
		["Graveyard"] = {
			["dungeon"] = "ScarletMonastery",
			["mapID"] = 762,
			["floor"] = 1,
			["mapName"] = "Graveyard",
		},
		["Zaetar's Grave"] = {
			["dungeon"] = "Maraudon",
			["mapID"] = 750,
			["floor"] = 2,
			["mapName"] = "Zaetar's Grave",
		},
		["Hellfire Peninsula"] = {
			["numFloors"] = 0,
			["mapID"] = 465,
			["cont"] = 3,
			["zone"] = "Hellfire Peninsula",
			["mapName"] = "Hellfire Peninsula",
			["zonei"] = 2,
		},
		["TempestKeep"] = {
			["numFloors"] = 1,
			["mapID"] = 782,
			["mapName"] = "TempestKeep",
			["floor"] = 1,
		},
		["The Inner Sanctum of Ulduar"] = {
			["dungeon"] = "Ulduar",
			["mapID"] = 529,
			["floor"] = 3,
			["mapName"] = "The Inner Sanctum of Ulduar",
		},
		["Hyjal_terrain1"] = {
			["numFloors"] = 1,
			["mapID"] = 683,
			["cont"] = 1,
			["zone"] = 0,
			["mapName"] = "Hyjal_terrain1",
			["floor"] = 1,
		},
		["Lower Observatory"] = {
			["dungeon"] = "ShadowfangKeep",
			["mapID"] = 764,
			["floor"] = 4,
			["mapName"] = "Lower Observatory",
		},
		["Maraudon"] = {
			["numFloors"] = 2,
			["mapID"] = 750,
			["mapName"] = "Maraudon",
		},
		["HellfireRamparts"] = {
			["numFloors"] = 1,
			["mapID"] = 797,
			["mapName"] = "HellfireRamparts",
			["floor"] = 1,
		},
		["The Four Seats"] = {
			["dungeon"] = "HallsofOrigination",
			["mapID"] = 759,
			["floor"] = 3,
			["mapName"] = "The Four Seats",
		},
		["Hall of the Keepers"] = {
			["dungeon"] = "Uldaman",
			["mapID"] = 692,
			["floor"] = 1,
			["mapName"] = "Hall of the Keepers",
		},
		["Stormwind City"] = {
			["numFloors"] = 0,
			["mapID"] = 301,
			["cont"] = 2,
			["zone"] = "Stormwind City",
			["mapName"] = "Stormwind City",
			["zonei"] = 26,
		},
		["NetherstormArena"] = {
			["numFloors"] = 0,
			["mapID"] = 482,
			["mapName"] = "NetherstormArena",
		},
		["Ragefire"] = {
			["numFloors"] = 1,
			["mapID"] = 680,
			["mapName"] = "Ragefire",
			["floor"] = 1,
		},
		["The Forgotten Pool"] = {
			["dungeon"] = "BlackfathomDeeps",
			["mapID"] = 688,
			["floor"] = 3,
			["mapName"] = "The Forgotten Pool",
		},
		["Deepholm"] = {
			["numFloors"] = 0,
			["mapID"] = 640,
			["cont"] = 5,
			["zone"] = "Deepholm",
			["mapName"] = "Deepholm",
			["zonei"] = 1,
		},
		["Nexus80"] = {
			["numFloors"] = 4,
			["mapID"] = 528,
			["mapName"] = "Nexus80",
		},
		["The Rampart of Skulls"] = {
			["dungeon"] = "IcecrownCitadel",
			["mapID"] = 604,
			["floor"] = 2,
			["mapName"] = "The Rampart of Skulls",
		},
		["Swamp of Sorrows"] = {
			["numFloors"] = 0,
			["mapID"] = 38,
			["cont"] = 2,
			["zone"] = "Swamp of Sorrows",
			["mapName"] = "Swamp of Sorrows",
			["zonei"] = 28,
		},
		["Grand Magister's Asylum"] = {
			["dungeon"] = "MagistersTerrace",
			["mapID"] = 798,
			["floor"] = 1,
			["mapName"] = "Grand Magister's Asylum",
		},
		["Tol Barad"] = {
			["numFloors"] = 0,
			["mapID"] = 708,
			["cont"] = 2,
			["zone"] = "Tol Barad",
			["mapName"] = "Tol Barad",
			["zonei"] = 32,
		},
		["Gordok Commons"] = {
			["dungeon"] = "DireMaul",
			["mapID"] = 699,
			["floor"] = 1,
			["mapName"] = "Gordok Commons",
		},
		["Eastern Plaguelands"] = {
			["numFloors"] = 0,
			["mapID"] = 23,
			["cont"] = 2,
			["zone"] = "Eastern Plaguelands",
			["mapName"] = "Eastern Plaguelands",
			["zonei"] = 9,
		},
		["Stranglethorn Vale"] = {
			["numFloors"] = 0,
			["mapID"] = 689,
			["cont"] = 2,
			["zone"] = "Stranglethorn Vale",
			["mapName"] = "Stranglethorn Vale",
			["zonei"] = 27,
		},
		["Band of Alignment"] = {
			["dungeon"] = "Nexus80",
			["mapID"] = 528,
			["floor"] = 4,
			["mapName"] = "Band of Alignment",
		},
		["The Pool of Ask'Ar"] = {
			["dungeon"] = "BlackfathomDeeps",
			["mapID"] = 688,
			["floor"] = 1,
			["mapName"] = "The Pool of Ask'Ar",
		},
		["Teldrassil"] = {
			["numFloors"] = 0,
			["mapID"] = 41,
			["cont"] = 1,
			["zone"] = "Teldrassil",
			["mapName"] = "Teldrassil",
			["zonei"] = 22,
		},
		["TheLostIsles_terrain2"] = {
			["numFloors"] = 0,
			["mapID"] = 682,
			["mapName"] = "TheLostIsles_terrain2",
		},
		["Twilight Highlands"] = {
			["numFloors"] = 0,
			["mapID"] = 700,
			["cont"] = 2,
			["zone"] = "Twilight Highlands",
			["mapName"] = "Twilight Highlands",
			["zonei"] = 34,
		},
		["Blasted Lands"] = {
			["numFloors"] = 0,
			["mapID"] = 19,
			["cont"] = 2,
			["zone"] = "Blasted Lands",
			["mapName"] = "Blasted Lands",
			["zonei"] = 4,
		},
		["Elwynn Forest"] = {
			["numFloors"] = 0,
			["mapID"] = 30,
			["cont"] = 2,
			["zone"] = "Elwynn Forest",
			["mapName"] = "Elwynn Forest",
			["zonei"] = 10,
		},
		["Throne of the Apocalypse"] = {
			["dungeon"] = "TheBastionofTwilight",
			["mapID"] = 758,
			["floor"] = 2,
			["mapName"] = "Throne of the Apocalypse",
		},
		["Court of the Highborne"] = {
			["dungeon"] = "DireMaul",
			["mapID"] = 699,
			["floor"] = 3,
			["mapName"] = "Court of the Highborne",
		},
		["Felwood"] = {
			["numFloors"] = 0,
			["mapID"] = 182,
			["cont"] = 1,
			["zone"] = "Felwood",
			["mapName"] = "Felwood",
			["zonei"] = 11,
		},
		["SethekkHalls"] = {
			["numFloors"] = 2,
			["mapID"] = 723,
			["mapName"] = "SethekkHalls",
		},
		["Northrend"] = {
			["numFloors"] = 0,
			["mapID"] = 485,
			["cont"] = 4,
			["zone"] = "Northrend",
			["mapName"] = "Northrend",
			["zonei"] = 0,
		},
		["CoilfangReservoir"] = {
			["numFloors"] = 1,
			["mapID"] = 780,
			["mapName"] = "CoilfangReservoir",
			["floor"] = 1,
		},
		["BlackfathomDeeps"] = {
			["numFloors"] = 3,
			["mapID"] = 688,
			["mapName"] = "BlackfathomDeeps",
		},
		["Gundrak"] = {
			["numFloors"] = 1,
			["mapID"] = 530,
			["mapName"] = "Gundrak",
			["floor"] = 1,
		},
		["ManaTombs"] = {
			["numFloors"] = 1,
			["mapID"] = 732,
			["mapName"] = "ManaTombs",
			["floor"] = 1,
		},
		["The Exodar"] = {
			["numFloors"] = 0,
			["mapID"] = 471,
			["cont"] = 1,
			["zone"] = "The Exodar",
			["mapName"] = "The Exodar",
			["zonei"] = 23,
		},
		["The Cooling Pools"] = {
			["dungeon"] = "TheSteamvault",
			["mapID"] = 727,
			["floor"] = 2,
			["mapName"] = "The Cooling Pools",
		},
		["Tol Barad Peninsula"] = {
			["numFloors"] = 0,
			["mapID"] = 709,
			["cont"] = 2,
			["zone"] = "Tol Barad Peninsula",
			["mapName"] = "Tol Barad Peninsula",
			["zonei"] = 33,
		},
		["Mount Hyjal"] = {
			["numFloors"] = 0,
			["mapID"] = 606,
			["cont"] = 1,
			["zone"] = "Mount Hyjal",
			["mapName"] = "Mount Hyjal",
			["zonei"] = 14,
		},
		["Silverpine Forest"] = {
			["numFloors"] = 0,
			["mapID"] = 21,
			["cont"] = 2,
			["zone"] = "Silverpine Forest",
			["mapName"] = "Silverpine Forest",
			["zonei"] = 25,
		},
		["GrimBatol"] = {
			["numFloors"] = 1,
			["mapID"] = 757,
			["mapName"] = "GrimBatol",
			["floor"] = 1,
		},
		["TheMechanar"] = {
			["numFloors"] = 2,
			["mapID"] = 730,
			["mapName"] = "TheMechanar",
		},
		["TheArcatraz"] = {
			["numFloors"] = 3,
			["mapID"] = 731,
			["mapName"] = "TheArcatraz",
		},
		["The Temple Gates"] = {
			["dungeon"] = "AhnQiraj",
			["mapID"] = 766,
			["floor"] = 2,
			["mapName"] = "The Temple Gates",
		},
		["Containment Core"] = {
			["dungeon"] = "TheArcatraz",
			["mapID"] = 731,
			["floor"] = 3,
			["mapName"] = "Containment Core",
		},
		["Stasis Block: Maximus"] = {
			["dungeon"] = "TheArcatraz",
			["mapID"] = 731,
			["floor"] = 2,
			["mapName"] = "Stasis Block: Maximus",
		},
		["Stonetalon Mountains"] = {
			["numFloors"] = 0,
			["mapID"] = 81,
			["cont"] = 1,
			["zone"] = "Stonetalon Mountains",
			["mapName"] = "Stonetalon Mountains",
			["zonei"] = 20,
		},
		["GilneasCity"] = {
			["numFloors"] = 0,
			["mapID"] = 611,
			["mapName"] = "GilneasCity",
		},
		["Upper Pinnacle"] = {
			["dungeon"] = "UtgardePinnacle",
			["mapID"] = 524,
			["floor"] = 2,
			["mapName"] = "Upper Pinnacle",
		},
		["TheStonecore"] = {
			["numFloors"] = 1,
			["mapID"] = 768,
			["mapName"] = "TheStonecore",
			["floor"] = 1,
		},
		["Ulduar"] = {
			["numFloors"] = 6,
			["mapID"] = 529,
			["mapName"] = "Ulduar",
		},
		["Uldum"] = {
			["numFloors"] = 0,
			["mapID"] = 720,
			["cont"] = 1,
			["zone"] = "Uldum",
			["mapName"] = "Uldum",
			["zonei"] = 26,
		},
		["Thousand Needles"] = {
			["numFloors"] = 0,
			["mapID"] = 61,
			["cont"] = 1,
			["zone"] = "Thousand Needles",
			["mapName"] = "Thousand Needles",
			["zonei"] = 24,
		},
		["Armory"] = {
			["dungeon"] = "ScarletMonastery",
			["mapID"] = 762,
			["floor"] = 3,
			["mapName"] = "Armory",
		},
		["Uldum_terrain1"] = {
			["numFloors"] = 1,
			["mapID"] = 748,
			["cont"] = 1,
			["zone"] = 0,
			["mapName"] = "Uldum_terrain1",
			["floor"] = 1,
		},
		["TheArgentColiseum543"] = {
			["numFloors"] = 2,
			["mapID"] = 543,
			["mapName"] = "TheArgentColiseum543",
		},
		["Mulgore"] = {
			["numFloors"] = 0,
			["mapID"] = 9,
			["cont"] = 1,
			["zone"] = "Mulgore",
			["mapName"] = "Mulgore",
			["zonei"] = 15,
		},
		["Calculation Chamber"] = {
			["dungeon"] = "TheMechanar",
			["mapID"] = 730,
			["floor"] = 2,
			["mapName"] = "Calculation Chamber",
		},
		["CoTStratholme"] = {
			["numFloors"] = 2,
			["mapID"] = 521,
			["mapName"] = "CoTStratholme",
		},
		["Stratholme City"] = {
			["dungeon"] = "CoTStratholme",
			["mapID"] = 521,
			["floor"] = 2,
			["mapName"] = "Stratholme City",
		},
		["CoTTheBlackMorass"] = {
			["numFloors"] = 0,
			["mapID"] = 733,
			["mapName"] = "CoTTheBlackMorass",
		},
		["Observation Grounds"] = {
			["dungeon"] = "MagistersTerrace",
			["mapID"] = 798,
			["floor"] = 2,
			["mapName"] = "Observation Grounds",
		},
		["UtgardePinnacle"] = {
			["numFloors"] = 2,
			["mapID"] = 524,
			["mapName"] = "UtgardePinnacle",
		},
		["Dragonflayer Ascent"] = {
			["dungeon"] = "UtgardeKeep",
			["mapID"] = 523,
			["floor"] = 2,
			["mapName"] = "Dragonflayer Ascent",
		},
		["The Frozen Throne"] = {
			["dungeon"] = "IcecrownCitadel",
			["mapID"] = 604,
			["floor"] = 7,
			["mapName"] = "The Frozen Throne",
		},
		["HallsofLightning"] = {
			["numFloors"] = 2,
			["mapID"] = 525,
			["mapName"] = "HallsofLightning",
		},
		["The Argent Coliseum"] = {
			["dungeon"] = "TheArgentColiseum",
			["mapID"] = 543,
			["floor"] = 1,
			["mapName"] = "The Argent Coliseum",
		},
		["The Spark of Imagination"] = {
			["dungeon"] = "Ulduar",
			["mapID"] = 529,
			["floor"] = 5,
			["mapName"] = "The Spark of Imagination",
		},
		["BaradinHold"] = {
			["numFloors"] = 1,
			["mapID"] = 752,
			["mapName"] = "BaradinHold",
			["floor"] = 1,
		},
		["Chamber of Summoning"] = {
			["dungeon"] = "Scholomance",
			["mapID"] = 763,
			["floor"] = 2,
			["mapName"] = "Chamber of Summoning",
		},
		["The Hall of Gears"] = {
			["dungeon"] = "Gnomeregan",
			["mapID"] = 691,
			["floor"] = 1,
			["mapName"] = "The Hall of Gears",
		},
		["Chamber of Incineration"] = {
			["dungeon"] = "BlackrockCaverns",
			["mapID"] = 753,
			["floor"] = 1,
			["mapName"] = "Chamber of Incineration",
		},
		["Kalimdor"] = {
			["numFloors"] = 0,
			["mapID"] = 13,
			["cont"] = 1,
			["zone"] = "Kalimdor",
			["mapName"] = "Kalimdor",
			["zonei"] = 0,
		},
		["TheBloodFurnace"] = {
			["numFloors"] = 1,
			["mapID"] = 725,
			["mapName"] = "TheBloodFurnace",
			["floor"] = 1,
		},
		["Undercity"] = {
			["numFloors"] = 0,
			["mapID"] = 382,
			["cont"] = 2,
			["zone"] = "Undercity",
			["mapName"] = "Undercity",
		},
		["Tinkers' Court"] = {
			["dungeon"] = "Gnomeregan",
			["mapID"] = 691,
			["floor"] = 4,
			["mapName"] = "Tinkers' Court",
		},
		["Vault of the Shadowflame"] = {
			["dungeon"] = "BlackwingDescent",
			["mapID"] = 754,
			["floor"] = 2,
			["mapName"] = "Vault of the Shadowflame",
		},
		["Deadwind Pass"] = {
			["numFloors"] = 0,
			["mapID"] = 32,
			["cont"] = 2,
			["zone"] = "Deadwind Pass",
			["mapName"] = "Deadwind Pass",
			["zonei"] = 6,
		},
		["The Storm Peaks"] = {
			["numFloors"] = 0,
			["mapID"] = 495,
			["cont"] = 4,
			["zone"] = "The Storm Peaks",
			["mapName"] = "The Storm Peaks",
			["zonei"] = 10,
		},
		["The Arachnid Quarter"] = {
			["dungeon"] = "Naxxramas",
			["mapID"] = 535,
			["floor"] = 2,
			["mapName"] = "The Arachnid Quarter",
		},
		["The Twilight Caverns"] = {
			["dungeon"] = "TheBastionofTwilight",
			["mapID"] = 758,
			["floor"] = 3,
			["mapName"] = "The Twilight Caverns",
		},
		["Vashj'ir"] = {
			["numFloors"] = 0,
			["mapID"] = 613,
			["cont"] = 2,
			["zone"] = "Vashj'ir",
			["mapName"] = "Vashj'ir",
			["zonei"] = 36,
		},
		["Dragonmaw Garrison"] = {
			["dungeon"] = "BlackwingLair",
			["mapID"] = 755,
			["floor"] = 1,
			["mapName"] = "Dragonmaw Garrison",
		},
		["The Maelstrom"] = {
			["numFloors"] = 0,
			["mapID"] = 737,
			["cont"] = 5,
			["zone"] = "The Maelstrom",
			["mapName"] = "The Maelstrom737",
			["zonei"] = 0,
		},
		["Duskwood"] = {
			["numFloors"] = 0,
			["mapID"] = 34,
			["cont"] = 2,
			["zone"] = "Duskwood",
			["mapName"] = "Duskwood",
			["zonei"] = 8,
		},
		["The Deadmines"] = {
			["dungeon"] = "TheDeadmines",
			["mapID"] = 756,
			["floor"] = 1,
			["mapName"] = "The Deadmines",
		},
		["Barov Family Vault"] = {
			["dungeon"] = "Scholomance",
			["mapID"] = 763,
			["floor"] = 4,
			["mapName"] = "Barov Family Vault",
		},
		["Lord Godfrey's Chamber"] = {
			["dungeon"] = "ShadowfangKeep",
			["mapID"] = 764,
			["floor"] = 6,
			["mapName"] = "Lord Godfrey's Chamber",
		},
		["Ghostlands"] = {
			["numFloors"] = 0,
			["mapID"] = 463,
			["cont"] = 2,
			["zone"] = "Ghostlands",
			["mapName"] = "Ghostlands",
			["zonei"] = 12,
		},
		["AzjolNerub"] = {
			["numFloors"] = 3,
			["mapID"] = 533,
			["mapName"] = "AzjolNerub",
		},
		["TheObsidianSanctum"] = {
			["numFloors"] = 0,
			["mapID"] = 531,
			["mapName"] = "TheObsidianSanctum",
		},
		["Southern Barrens"] = {
			["numFloors"] = 0,
			["mapID"] = 607,
			["cont"] = 1,
			["zone"] = "Southern Barrens",
			["mapName"] = "Southern Barrens",
			["zonei"] = 19,
		},
		["Gamesman's Hall"] = {
			["dungeon"] = "Karazhan",
			["mapID"] = 799,
			["floor"] = 14,
			["mapName"] = "Gamesman's Hall",
		},
		["The Hive Undergrounds"] = {
			["dungeon"] = "AhnQiraj",
			["mapID"] = 766,
			["floor"] = 1,
			["mapName"] = "The Hive Undergrounds",
		},
		["Band of Acceleration"] = {
			["dungeon"] = "Nexus80",
			["mapID"] = 528,
			["floor"] = 2,
			["mapName"] = "Band of Acceleration",
		},
		["Khaz'Goroth's Seat"] = {
			["dungeon"] = "Uldaman",
			["mapID"] = 692,
			["floor"] = 2,
			["mapName"] = "Khaz'Goroth's Seat",
		},
		["The Gauntlet"] = {
			["dungeon"] = "Stratholme",
			["mapID"] = 765,
			["floor"] = 2,
			["mapName"] = "The Gauntlet",
		},
		["TheStockade"] = {
			["numFloors"] = 1,
			["mapID"] = 690,
			["mapName"] = "TheStockade",
			["floor"] = 1,
		},
		["TheEyeofEternity"] = {
			["numFloors"] = 1,
			["mapID"] = 527,
			["mapName"] = "TheEyeofEternity",
			["floor"] = 1,
		},
		["TheShatteredHalls"] = {
			["numFloors"] = 1,
			["mapID"] = 710,
			["mapName"] = "TheShatteredHalls",
			["floor"] = 1,
		},
		["ThroneofTides"] = {
			["numFloors"] = 2,
			["mapID"] = 767,
			["mapName"] = "ThroneofTides",
		},
		["The Underbelly"] = {
			["dungeon"] = "Dalaran",
			["mapID"] = 504,
			["cont"] = 4,
			["zone"] = "Dalaran",
			["mapName"] = "The Underbelly",
			["floor"] = 2,
		},
		["Band of Variance"] = {
			["dungeon"] = "Nexus80",
			["mapID"] = 528,
			["floor"] = 1,
			["mapName"] = "Band of Variance",
		},
		["ThroneoftheFourWinds"] = {
			["numFloors"] = 1,
			["mapID"] = 773,
			["mapName"] = "ThroneoftheFourWinds",
			["floor"] = 1,
		},
		["The Lower Citadel"] = {
			["dungeon"] = "IcecrownCitadel",
			["mapID"] = 604,
			["floor"] = 1,
			["mapName"] = "The Lower Citadel",
		},
		["Shrine of the Eclipse"] = {
			["dungeon"] = "SunwellPlateau",
			["mapID"] = 789,
			["floor"] = 2,
			["mapName"] = "Shrine of the Eclipse",
		},
		["TheArgentColiseum"] = {
			["numFloors"] = 1,
			["mapID"] = 542,
			["mapName"] = "TheArgentColiseum",
			["floor"] = 1,
		},
		["Sholazar Basin"] = {
			["numFloors"] = 0,
			["mapID"] = 493,
			["cont"] = 4,
			["zone"] = "Sholazar Basin",
			["mapName"] = "Sholazar Basin",
			["zonei"] = 9,
		},
		["Redridge Mountains"] = {
			["numFloors"] = 0,
			["mapID"] = 36,
			["cont"] = 2,
			["zone"] = "Redridge Mountains",
			["mapName"] = "Redridge Mountains",
			["zonei"] = 19,
		},
		["Ironclad Cove"] = {
			["dungeon"] = "TheDeadmines",
			["mapID"] = 756,
			["floor"] = 2,
			["mapName"] = "Ironclad Cove",
		},
		["Hillsbrad Foothills"] = {
			["numFloors"] = 0,
			["mapID"] = 24,
			["cont"] = 2,
			["zone"] = "Hillsbrad Foothills",
			["mapName"] = "Hillsbrad Foothills",
			["zonei"] = 13,
		},
		["Zangarmarsh"] = {
			["numFloors"] = 0,
			["mapID"] = 467,
			["cont"] = 3,
			["zone"] = "Zangarmarsh",
			["mapName"] = "Zangarmarsh",
			["zonei"] = 8,
		},
		["Firelands"] = {
			["numFloors"] = 3,
			["mapID"] = 800,
			["mapName"] = "Firelands",
		},
		["Molten Front"] = {
			["numFloors"] = 0,
			["mapID"] = 795,
			["mapName"] = "MoltenFront",
		},
		["Darkmoon Island"] = {
			["numFloors"] = 0,
			["mapID"] = 823,
			["zone"] = "Darkmoon Faire Island",
			["mapName"] = "DarkmoonFaireIsland",
		},
		["The Wandering Isle"] = {
			["numFloors"] = 0,
			["mapID"] = 301,
			["zone"] = "The Wandering Isle",
			["mapName"] = "TheWanderingIsle",
		},	
		["The Jade Forest"] = {
			["numFloors"] = 0,
			["mapID"] = 806,
			["zone"] = "The Jade Forest",
			["mapName"] = "TheJadeForest",
		},
		["Valley of the Four Winds"] = {
			["numFloors"] = 0,
			["mapID"] = 807,
			["zone"] = "Valley of the Four Winds",
			["mapName"] = "ValleyoftheFourWinds",
		},
		["Krasarang Wilds"] = {
			["numFloors"] = 0,
			["mapID"] = 857,
			["zone"] = "Krasarang Wilds",
			["mapName"] = "KrasarangWilds",
		},

	}
	
local MapsSeen = {}
local zonei, zonec, zonenames, contnames = {}, {}, {}, {}
local function ScrapeMapInfo(cont, zone, zone_idx, Zone2MapID)
    local record = {}
    record.mapName = zone or GetMapInfo();
    record.mapID = GetCurrentMapAreaID();
    if MapsSeen[record.mapID] then
        return
    end
    record.numFloors = GetNumDungeonMapLevels();
    if cont then
        record.cont = cont
    elseif GetCurrentMapContinent() > -1 then
        record.cont = GetCurrentMapContinent()
    end
    if zone then
        record.zone = zone
    elseif GetCurrentMapContinent() > -1 and GetCurrentMapZone() > -1 then
        record.zone = zonenames[GetCurrentMapContinent()][GetCurrentMapZone()] or GetCurrentMapZone()
    end
    if zone_idx then
        record.zonei = zone_idx
    end

    if record.numFloors > 1 then
        -- Multifloor map
        local offset
        if _G["DUNGEON_FLOOR_" .. strupper(record.mapName) .. "0"] then
            offset = -1
        else
            offset = 0
        end
        for floor=1,record.numFloors do
            local floorinfo = {}
            if record.cont then floorinfo.cont = record.cont end
            if record.zone then floorinfo.zone = record.zone end
            floorinfo.mapID = record.mapID
            floorinfo.floor = floor
            floorinfo.dungeon = record.mapName
            floorinfo.mapName = _G["DUNGEON_FLOOR_" .. strupper(record.mapName) .. (floor+offset)]
            if not floorinfo.mapName then
                WoWPro:Print("Unable to find name for "..record.mapName.." floor "..tostring(floor))
                floorinfo.mapName = tostring(floorinfo.mapID).."/"..tostring(floor)
            end
            Zone2MapID[floorinfo.mapName]=floorinfo;
        end
    end

    -- Single floor instance
    if record.numFloors == 1 then
        if _G["DUNGEON_FLOOR_" .. strupper(record.mapName) .. "0"] then
            record.mapName = _G["DUNGEON_FLOOR_" .. strupper(record.mapName) .. "0"]
        elseif _G["DUNGEON_FLOOR_" .. strupper(record.mapName) .. "1"] then
            record.mapName = _G["DUNGEON_FLOOR_" .. strupper(record.mapName) .. "1"]
        end
        record.floor = 1
    end
    if Zone2MapID[record.mapName] then
        if Zone2MapID[record.mapName].mapID == record.mapID then
            -- Already recorded that map.  Skip it.
            return
        end
        WoWPro:Print("Name "..record.mapName.." is duplicated for map "..tostring(record.mapID).." and "..tostring(Zone2MapID[record.mapName].mapID))
        record.mapName = record.mapName .. tostring(record.mapID)
    end
    MapsSeen[record.mapID] = true
    Zone2MapID[record.mapName]=record;
    if record.zone then
        Zone2MapID[record.zone]=record;
    end
end

function WoWPro:IsInstanceZone(zone)
    local mapID = WoWPro.Zone2MapID[zone]
    if not mapID then
        WoWPro:Print("Zone [%s] is not in Zone2MapID.  Please report!",zone)
        return false
    end
    if mapID.cont or mapID.zone then
        return false
    end
    return true
end

function WoWPro:GenerateMapCache()
    local here = GetCurrentMapAreaID()

    local Zone2MapID = {}
--    local MapsSeen = {}
	for ci,c in pairs{GetMapContinents()} do
	    contnames[ci] = c
	    zonenames[ci] = {GetMapZones(ci)}
		SetMapZoom(ci,0)
		ScrapeMapInfo(ci,contnames[ci],0,Zone2MapID)
	    for zi,z in pairs(zonenames[ci]) do
			SetMapZoom(ci,zi)
			ScrapeMapInfo(ci,z,zi,Zone2MapID)
		end
	end

    for z=1,10000 do
        if( SetMapByID(z) ) then
            ScrapeMapInfo(nil,nil,Zone2MapID)
        end
    end
    WoWPro.DB.Zone2MapID = Zone2MapID
    SetMapByID(here)
end
