
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/stormheim_alliance
-- Date: 2016-08-31 22:46
-- Who: Ludovicus
-- Log: Make it load sans errors.

-- URL: http://wow-pro.com/node/3683/revisions/27667/view
-- Date: 2016-08-31 22:25
-- Who: Ludovicus
-- Log: So far

local guide = WoWPro:RegisterGuide('LudoStormheim', 'Leveling', 'Stormheim', 'Ludovicus', 'Alliance')
WoWPro:GuideLevels(guide,98, 105)
WoWPro:GuideNextGuide(guide, 'Azuna')
WoWPro:GuideSteps(guide, function()
return [[

N Starting in Dalaran|QID|38035|U|140192|N|This guide assumes you are starting in Dalaran. |
N Warning!|QID|38035|N|This guide is NOT complete and probably has errors.|
; N Treasure|QID|42484|N|All treasures necessary for the zone treasure hunting achievement are listed if you do the guide on rank 1. If you are using handy notes treasures, there treasure symbol will show over the tomtom green dot, obscuring it, the arrow will still work fine.|
; N Rares (Silver Elite)|QID|42484|N|All of the Silver mobs are also included. The item displayed has a high chance to drop but not guarenteed. Blizzard has marked these mobs on the minimap with a star.|
; N Ranks|QID|42484|N|Setting the guide to Rank 1 will get you all of the essential questlines for the zone questing achievement. Rank 2, adds the quests you may as well do while you are there. Rank 3 gets every quest & treasure and rare in the zone.|

A Stormheim |QID|39735|M|37.6,43.9|Z|The Hall of Shadows|; The Hall of Shadows |Z|1014;4|
A Stormheim |QID|39735|Z|Dalaran@Dalaran70|N|From your class hall Sign Board|
;f The Violet Citadel|QID|42484|M|29.10,46.93|Z|Dalaran@Dalaran70|N|At Sky Admiral Rogers.|
;T Stormheim|QID|39735|M|29.10,46.93|Z|Dalaran@Dalaran70|N|To Sky Admiral Rogers.|
T Stormheim|QID|39735|M|29.10,46.93|Z|1014;12|N|To Sky Admiral Rogers|; The Violet Citadel |Z|1014;12|
A A Royal Summons|QID|38035|M|29.10,46.93|Z|Dalaran@Dalaran70|N|From Sky Admiral Rogers.|
C A Royal Summons|QID|38035|M|28.86,46.63|Z|Dalaran@Dalaran70|QO|1|N|1/1 Royal Summons read|
C A Royal Summons|QID|38035|M|18.47,41.72|Z|Stormwind City|QO|2|N|1/1 The Skyfire boarded|
T A Royal Summons|QID|38035|M|18.93,42.75|Z|Stormwind City|N|To Sky Admiral Rogers.|
A Making the Rounds|QID|38206|M|18.93,42.75|Z|Stormwind City|N|From Sky Admiral Rogers.|
C Making the Rounds|QID|38206|M|18.56,46.36|Z|Stormwind City|QO|1|NC|N|Inspect Deck Guns|
C Making the Rounds|QID|38206|M|18.59,47.58|Z|Stormwind City|QO|2|NC|N|Salute 7th Legion Dragoons|
C Making the Rounds|QID|38206|M|18.62,50.90|Z|Stormwind City|QO|3|CHAT|N|Speak with Genn Greymane|
T Making the Rounds|QID|38206|M|18.67,51.12|Z|Stormwind City|N|To Genn Greymane.|
A Greymane's Gambit|QID|39800|M|18.67,51.12|Z|Stormwind City|N|From Genn Greymane.|
;C Prepare for Battle|Z|AraukNashalIntroScenario|SO|1|US|N|Man the Deck Guns|
;C Prepare for Battle|Z|AraukNashalIntroScenario|SO|2|S|N|Man the Deck Guns|
;A Greymane's Gambit|QID|39800|M|31.73,8.38|SO|2;1|
;C Prepare for Battle|Z|AraukNashalIntroScenario|SO|2|US|N|Man the Deck Guns|
;C Man the Deck Guns|M|31.94,8.43|SO|3|S|N|Man the Deck Guns|
;C Prepare for Battle|Z|AraukNashalIntroScenario|SO|3;1|N|Man the Deck Guns|
;C Fire at Will!|Z|AraukNashalIntroScenario|SO|3;2|N|Use the Deck Guns to shoot down Forsaken Dreadwings|
;C Shoot down Forsaken Dreadwings.|M|53.65,21.84|SO|3;3|N|Shoot down Forsaken Dreadwings.|
;C Fire at Will!|Z|AraukNashalIntroScenario|SO|3|US|N|Use the Deck Guns to shoot down Forsaken Dreadwings|
;C Justice from Above|Z|AraukNashalIntroScenario|SO|4|S|N|Head below decks and use a Skyfire Parachute to board the Forsaken ships and defeat their captains.|
;C Defeat the captain of The Banshee's Wail|M|53.22,41.20|SO|4;1|N|Defeat the captain of The Banshee's Wail|
;C Defeat the captain of The Black Rose|M|48.38,52.22|SO|4|US|N|Defeat the captain of The Black Rose|
;C Defeat the captain of The Windrunner|M|54.26,65.73|SO|5|S|N|Defeat the captain of The Windrunner|
;C Justice from Above|Z|AraukNashalIntroScenario|SO|5;1|N|Head below decks and use a Skyfire Parachute to board the Forsaken ships and defeat their captains.|
;C Bats in the Bomb Bay|Z|AraukNashalIntroScenario|SO|5|US|N|Remove Volatile Flares from Skyfire bomb bay.|
;C Volatile Flares removed|M|68.31,73.54|S|N|Volatile Flares removed|
;C Bats in the Bomb Bay|Z|AraukNashalIntroScenario|QO|1|N|Remove Volatile Flares from Skyfire bomb bay.|
;C Last Stand|Z|AraukNashalIntroScenario|N|Defeat Nathanos Blightcaller on the deck of the Skyfire.|
;C Defeat Nathanos Blightcaller|M|69.14,74.70|N|Defeat Nathanos Blightcaller|
;C Greymane's Gambit|QID|39800|M|69.14,74.70|QO|1|N|Greymane's mission complete|

; End of Scenario and now in Stormheim

T Greymane's Gambit|QID|39800|M|33.71,51.02|N|To Sky Admiral Rogers.|
A Boarded!|QID|38052|M|33.71,51.02|L|138783 1|N|From Sky Admiral Rogers.|
A Supplies From the Skies|QID|38036|M|33.76,50.76|N|From Mishka.|
A Assault and Battery|QID|38053|M|33.61,50.81|N|From Tinkmaster Overspark.|
A See Ya Later, Oscillator|QID|38558|M|33.61,50.81|N|From Tinkmaster Overspark.|
C Boarded!|QID|38052|S|M|34.35,57.21|N|Slay forsaken|
C Supplies From the Skies|QID|38036|M|33.82,50.65|QO|1|S|N|Skyfire First Aid Kit|
C See Ya Later, Oscillator|QID|38558|M|33.63,57.26|N|1/1 Crystal Oscillator|
K Assault and Battery|QID|38053|T|Dread-Rider Malwick|M|35.28,54.01|N|Kill Dread-Rider Malwick and loot the Battery.|
C Supplies From the Skies|QID|38036|M|33.81,56.98|QO|1|US|N|Skyfire First Aid Kit|
C Boarded!|QID|38052|US|M|34.35,57.21|N|Slay forsaken|
T Boarded!|QID|38052|M|33.67,51.06|N|To Sky Admiral Rogers.|
T Supplies From the Skies|QID|38036|M|33.74,50.81|N|To Mishka.|
T See Ya Later, Oscillator|QID|38558|M|33.63,50.84|N|To Tinkmaster Overspark.|
T Assault and Battery|QID|38053|M|33.60,50.83|N|To Tinkmaster Overspark.|
A Lightning Rod|QID|38058|M|33.60,50.83|QO|1|N|From Tinkmaster Overspark.|
A The Lost Legion|QID|38057|M|33.76,50.76|N|From Mishka.|

T The Lost Legion|QID|38057|M|31.19,57.96|N|To Knight-Captain Rhodes.|
A Pins and Needles|QID|38059|M|31.19,57.96|QO|1|N|From Knight-Captain Rhodes.|
C Lightning Rod|QID|38058|S|M|29.40,57.93|QO|1|N|Kill dragons and walk in lightnig until the Transponder is charged.|
C Pins and Needles|QID|38059|NC|M|30.22,52.95|N|Release 7th Legion Dragoons.|
T Pins and Needles|QID|38059|M|30.22,52.95|N|To 7th Legion Dragoon.|
C Lightning Rod|QID|38058|S|M|29.40,57.93|QO|1|N|Kill dragons and walk in lightnig until the Transponder is charged.|
T Lightning Rod|QID|38058|M|29.39,57.96|QO|2|N|To Storm Drake Whelp.|
A Signal Boost|QID|38060|M|29.39,57.96|N|From Storm Drake Whelp.|
C Signal Boost|QID|38060|M|31.33,50.32|N|1/1 Distress Signal started|
C Signal Boost|QID|38060|M|31.99,49.78|QO|2|N|1/1 Transponder defended|
T Signal Boost|QID|38060|M|33.81,46.03|QO|1|N|To Sky Admiral Rogers.|

A The Ancient Trials|QID|38210|M|33.74,45.80|QO|3|N|From Muninn.|
T The Ancient Trials|QID|38210|M|43.13,49.17|N|To Havi.|
A Havi's Test|QID|38331|M|43.13,49.17|N|From Havi.|
C Havi's Test |QID|38331|NC|QO|1|M|43.0,49.1|
C Havi's Test |QID|38331|NC|QO|2|M|42.9,49.2|
C Havi's Test |QID|38331|NC|QO|3|M|43.0,49.4|
T Havi's Test|QID|38331|M|43.15,49.22|QO|1|N|To Havi.|
A Ahead of the Game|QID|39590|M|43.15,49.22|QO|1|N|From Havi.|
A A Worthy Challenger|QID|38442|M|43.15,49.22|N|From Havi.|
A Blood and Gold|QID|39595|M|42.97,47.50|QO|3|N|From Bloodtotem Skirmisher.|
C Blood and Gold|QID|39595|M|42.03,46.04|S|N|7/7 Challenger's Tribute|
C Ahead of the Game|QID|39590|QO|2|M|42.03,46.04|N|1/1 Rumblehoof Champion's Head|
C Ahead of the Game|QID|39590|QO|1|M|44.89,40.56|N|1/1 Gutspill Champion's Head|
C Ahead of the Game|QID|39590|M|45.39,48.10|QO|3|N|1/1 Felskorn Champion's Head|
T Ahead of the Game|QID|39590|M|46.69,44.39|
C Blood and Gold|QID|39595|M|42.03,46.04|S|N|7/7 Challenger's Tribute|
T Blood and Gold|QID|39595|M|46.74,44.46|N|To Felskorn Runetwister.|
A A Trial of Valor|QID|39591|M|46.69,44.39|
A A Trial of Will|QID|39592|M|46.69,44.39|
A The Shattered Watcher|QID|39593|M|46.69,44.39|

A The Shattered Watcher |QID|39593|M|46.8,44.5|Z|Stormheim|N|From Felskorn Raider|; Aggramar's Vault |Z|1017;0|
C The Shattered Watcher |QID|39593|NC|QO|3|M|48.8,46.0|Z|Stormheim|; Terrace of the Watchers |Z|1017;0|
C The Shattered Watcher |QID|39593|NC|QO|2|M|49.3,45.6|Z|Stormheim|; Terrace of the Watchers |Z|1017;0|
C A Trial of Valor |QID|39591|M|50.6,44.8|Z|Stormheim|; Terrace of the Watchers |Z|1017;0|
C The Shattered Watcher |QID|39593|NC|QO|1|M|48.1,47.4|Z|Stormheim|; Terrace of the Watchers |Z|1017;0|
C A Trial of Will |QID|39592|M|48.7,47.7|Z|Stormheim|; Terrace of the Watchers |Z|1017;0|
;A A Worthy Challenger |QID|0|M|48.8,47.8|Z|Stormheim|N|Auto-accept|; Terrace of the Watchers |Z|1017;0|
;T A Worthy Challenger |QID|38442|M|48.8,47.8|Z|Stormheim|; Terrace of the Watchers |Z|1017;0|
C The Shattered Watcher |QID|39593|NC|QO|4|M|48.7,41.8|Z|Stormheim|; Terrace of the Watchers |Z|1017;0|
; |U|138783|M|50.4,41.1|Z|Stormheim|N|item:138783 [Glittering Memento]|; Terrace of the Watchers |Z|1017;0|
C The Shattered Watcher |QID|39593|NC|M|48.1,47.4|Z|Stormheim|; Terrace of the Watchers |Z|1017;0|
T A Trial of Valor|QID|39591|M|46.69,44.42|
T A Trial of Will|QID|39592|M|46.69,44.42|
T The Shattered Watcher|QID|39593|M|46.69,44.42|

A A Trial of Might|QID|39594|PRE|39592;39593|M|46.71,44.44|N|From Yotnar.|
C A Trial of Might|QID|39594|M|49.50,42.77|N|1/1 Learn about the Trial of Might|
C A Trial of Might|QID|39594|M|49.45,42.83|N|1/1 Yotnar Defeated|
T A Trial of Might|QID|39594|M|46.32,44.83|N|To Yotnar.|
A The Blessing of the Watchers|QID|39597|PRE|39594|M|46.32,44.83|N|From Yotnar.|
C The Blessing of the Watchers|QID|39597|M|46.32,44.83|N|1/1 Yotnar's Blessing Received|
;T A Worthy Challenger|QID|38442|M|42.71,42.20|
T The Blessing of the Watchers|QID|39597|M|43.14,49.15|N|To Havi.|
A Will of the Thorignir|QID|38473|PRE|39597|M|43.14,49.15|N|From Havi.|
T Will of the Thorignir|QID|38473|M|37.38,63.85|N|To Commander Lorna Crowley.|
A A Grapple a Day|QID|38312|PRE|38473|M|37.38,63.85|N|From Commander Lorna Crowley.|
f Lorna's Watch|QID|38312|M|37.41,63.99|N|At Donovan.|
C A Grapple a Day|QID|38312|M|37.37,63.79|QO|1|N|Stormforged Grapple Launcher|
A Built to Scale|QID|38337|S|M|43.46,64.40|N|Kill a Stormwing Drake.|
T A Grapple a Day|QID|38312|M|42.02,64.48|N|To Commander Lorna Crowley.|
A No Wings Required|QID|38318|M|42.02,64.48|N|From Commander Lorna Crowley.|
C No Wings Required|QID|38318|M|42.88,64.85|QO|3|N|1/1 Grapple over the wall|
;A Assault the Drekirjar|QID|38374|M|42.88,64.85|N|From Commander Lorna Crowley.|
C Built to Scale|QID|38337|S|M|46.15,72.82|N|50/50 Storm Drake Scale|
A To Weather the Storm|QID|38405|M|42.02,64.48|N|From Commander Lorna Crowley.|
C To Weather the Storm|QID|38405|QO|1|M|43.98,66.99|N|1/1 Enchanted Lodestone|
C To Weather the Storm|QID|38405|NC|QO|2|M|41.86,68.40|QO|1|N|1/1 Climbing Treads|
C To Weather the Storm|QID|38405|QO|3|M|45.68,66.64|LVL|101|N|1/1 Oiled Cloak|
;T Assault the Drekirjar|QID|38374|M|43.79,68.21|QO|1|N|To Commander Lorna Crowley.|
T To Weather the Storm|QID|38405|M|43.79,68.21|N|To Commander Lorna Crowley.|
A Impalement Insurance|QID|38410|PRE|38405|M|43.79,68.21|N|From Commander Lorna Crowley.|
T No Wings Required |QID|38318|M|43.8,68.2|N|To Commander Lorna Crowley|; Hrydshal |Z|1017;0|
C Impalement Insurance|QID|38410|M|43.52,68.14|QO|1|N|7/7 Harpoon Launchers Destroyed|
T Impalement Insurance|QID|38410|M|46.25,70.37|N|To Commander Lorna Crowley.|
C Built to Scale|QID|38337|US|M|46.15,72.82|N|50/50 Storm Drake Scale|
T Built to Scale|QID|38337|M|46.25,70.36|N|To Commander Lorna Crowley.|
A Another Way|QID|38342|PRE|38410|M|46.25,70.37|N|From Commander Lorna Crowley.|
K Another Way|QID|38342|T|Gunnlaug Scaleheart|M|46.24,72.39|QO|1|N|Gunnlaug Scaleheart slain|
C Another Way|QID|38342|M|45.70,73.12|QO|2|N|Climb the Tower|
T Another Way|QID|38342|M|45.62,73.09|N|To Commander Lorna Crowley.|
A Above the Winter Moonlight|QID|38412|PRE|38342|M|45.65,73.08|N|From Commander Lorna Crowley.|
C Above the Winter Moonlight|QID|38412|M|46.36,74.37|N|1/1 Grapple to the Mountain Path|
C Above the Winter Moonlight|QID|38412|M|44.26,77.56|QO|2|N|1/1 Reach the Top of the Path|
T Above the Winter Moonlight|QID|38412|M|44.82,77.41|QO|4|N|To Vethir.|
A Heart of a Dragon|QID|38414|PRE|38412|M|44.82,77.41|N|From Vethir.|
A Wings of Liberty|QID|38413|PRE|38412|M|44.82,77.41|N|From Vethir.|
A Fury of the Storm|QID|40568|PRE|38412|M|44.82,77.41|N|From Vethir.|
C Fury of the Storm|QID|40568|M|43.72,83.29|S|N|Drekirjar vrykul slain|
C Wings of Liberty|QID|38413|NC|M|45.89,78.76|QO|2|N|1/1 Hrafsir Freed|
C Wings of Liberty|QID|38413|NC|M|49.07,81.21|QO|1|N|1/1 Aleifir Freed|
C Wings of Liberty|QID|38413|NC|M|45.64,82.15|QO|4|N|1/1 Hridmogir Freed|
C Wings of Liberty|QID|38413|NC|M|44.10,80.63|QO|3|N|1/1 Erilar Freed|
C Heart of a Dragon|QID|38414|NC|QO|1|M|42.11,81.87|N|1/1 Find the Thorignir Mother|
K Heart of a Dragon|QID|38414|T|Azariah|QO|2|M|41.96,81.61|N|1/1 Azariah slain|
C Fury of the Storm|QID|40568|M|43.72,83.29|US|N|Drekirjar vrykul slain|
T Heart of a Dragon|QID|38414|M|42.78,82.70|QO|2|N|To Vethir.|
T Wings of Liberty|QID|38413|M|42.78,82.70|N|To Vethir.|
T Fury of the Storm|QID|40568|M|42.78,82.70|N|To Vethir.|
A Where Dragons Rule|QID|39652|PRE|38413;38414;40568|M|42.78,82.70|N|From Vethir.|
;C Where Dragons Rule|QID|39652|M|41.27,80.05|N|1/1 Fly to the top of Thorim's Peak|
C Where Dragons Rule|QID|39652|NC|M|40.84,80.96|N|1/1 Speak to Thrymjaris|
T Where Dragons Rule|QID|39652|M|40.84,80.96|N|To Thrymjaris.|
A Cry Thunder!|QID|38624|PRE|39652|M|40.84,80.96|N|From Thrymjaris.|
C Cry Thunder!|QID|38624|QO|1|N|Kill God-King's allies in Hrydshal.|
T Cry Thunder!|QID|38624|M|48.0,54.6|N|To Huginn.|

A The Trials Continue|QID|39803|M|47.91,54.63|N|From Huginn.
; Side Excursions
A Eating Into Our Business|QID|39789|M|51.45,56.95|N|From Ootasa Galehoof.|
C Eating Into Our Business|QID|39789|M|48.75,55.23|QO|1|N|10/10 Duskpelt worg slain|
T Eating Into Our Business|QID|39789|M|51.43,57.04|N|To Rax Sixtrigger.|
A Only the Finest|QID|39793|M|51.43,57.04|N|From Rax Sixtrigger.|
A Rigging the Wager|QID|39787|M|51.27,57.20|N|From Snaggle Sixtrigger.|
A The Brood of Nithogg|QID|42431|M|48.03,37.85|N|From Felskorn Warmonger.|
C Only the Finest|QID|39793|S|M|43.73,29.94|N|18/18 Patch of Fine Goat Hair|
K Rigging the Wager|QID|39787|M|48.7,33.7|N|Use the Grapple to get up the ledge, then click the rock to set up the bait that will attack Spitefeather.|
C Only the Finest|QID|39793|US|M|43.73,29.94|N|18/18 Patch of Fine Goat Hair|
C The Brood of Nithogg|QID|42431|M|49.13,33.54|N|Finish the bonus objective.|
T The Brood of Nithogg|QID|42431|M|49.13,33.54|
T Rigging the Wager|QID|39787|M|51.32,56.98|N|To Snaggle Sixtrigger.|
T Only the Finest|QID|39793|M|51.38,57.28|N|To Rax Sixtrigger.|
A A Stack of Racks|QID|39792|M|51.38,57.28|N|From Rax Sixtrigger.|
A A Stone Cold Gamble|QID|39786|M|51.32,56.99|N|From Snaggle Sixtrigger.|
C A Stack of Racks|QID|39792|S|M|56.97,78.87|QO|1|N|8/8 Meaty Rack of Musken Ribs|
C A Stone Cold Gamble|QID|39786|M|46.60,60.74|QO|1|N|1/1 Stonefang's Jaw|
C A Stack of Racks|QID|39792|US|M|56.97,78.87|QO|1|N|8/8 Meaty Rack of Musken Ribs|
T A Stack of Racks|QID|39792|M|51.36,57.13|N|To Rax Sixtrigger.|
T A Stone Cold Gamble|QID|39786|M|51.38,57.29|N|To Snaggle Sixtrigger.|
A Put It All on Red|QID|42483|M|51.38,57.29|N|From Snaggle Sixtrigger.|

; Back to business
f Valdisdall|QID|42483|M|60.73,50.86|N|At Garhal the Scalekeeper.|
h Valdisdall |M|60.5,50.3|N|Talk to Riala the Hearthwatcher|
T The Trials Continue|QID|39803|M|60.14,50.74|N|To Havi.|
A Speaking of Bones|QID|39804|M|60.14,50.74|N|From Havi.|
C Speaking of Bones|QID|39804|M|60.67,51.42|QO|1|N|1/1 Ironhorn Buck butchered|
T Speaking of Bones|QID|39804|M|60.14,50.74|N|To Havi.|
A To Haustvald|QID|39796|M|60.14,50.74|N|From Havi.|


T To Haustvald|QID|39796|M|68.50,54.35|N|To Vydhar.|
A Turn the Keys|QID|38778|M|68.50,54.35|N|From Vydhar.|
A The Runewood's Revenge|QID|39788|M|68.50,54.35|N|From Vydhar.|
C The Runewood's Revenge|QID|39788|S|M|68.42,50.78|N|8/8 Bonespeaker Carver slain|
C Turn the Keys|QID|38778|NC|M|68.61,51.60|QO|1|N|3/3 Runestones Activated|
C The Runewood's Revenge|QID|39788|US|M|68.42,50.78|N|8/8 Bonespeaker Carver slain|
;C The Runewood's Revenge|QID|39788|M|66.12,55.05|QO|1|N|8/8 Bonespeaker Runeaxe slain|

A Remnants of the Past |QID|39984|M|63.0,48.6|Z|Stormheim|; Tideskorn Harbor |Z|1017;0|
C Remnants of the Past |QID|39984|QO|1|M|60.8,46.1|Z|Stormheim|; Tideskorn Harbor |Z|1017;0|
; Usernote: Small Treasure Chest behind the little house|M|61.4,44.4|Z|Stormheim|; Tideskorn Harbor |Z|1017;0|
; |U|138885|M|61.4,44.4|Z|Stormheim|N|item:138885 [Treasure of the Ages]|; Tideskorn Harbor |Z|1017;0|
C Remnants of the Past |QID|39984|QO|4|M|60.4,42.9|Z|Stormheim|; Tideskorn Harbor |Z|1017;0|
; Usernote: Sall Treasure Chest You need the grappling hook.|M|60.8,42.7|Z|Stormheim|; Tideskorn Harbor |Z|1017;0|
; |U|140310|M|60.8,42.7|Z|Stormheim|N|item:140310 [Crude Statuette]|; Tideskorn Harbor |Z|1017;0|
C Remnants of the Past |QID|39984|QO|3|M|59.8,45.1|Z|Stormheim|; Tideskorn Harbor |Z|1017;0|
C Remnants of the Past |QID|39984|QO|2|M|58.3,47.0|Z|Stormheim|; Tideskorn Harbor |Z|1017;0|
C Remnants of the Past |QID|39984|QO|5|M|59.2,43.2|Z|Stormheim|; Tideskorn Harbor |Z|1017;0|
C Remnants of the Past |QID|39984|M|59.2,43.2|Z|Stormheim|; Tideskorn Harbor |Z|1017;0|
T Remnants of the Past |QID|39984|M|58.9,42.8|Z|Stormheim|N|To Havi|; Tideskorn Harbor |Z|1017;0|
A Scavenging the Shallows |QID|40046|M|58.9,42.8|Z|Stormheim|N|From Havi|; Tideskorn Harbor |Z|1017;0|
A To Honor the Fallen |QID|43595|M|58.9,42.8|Z|Stormheim|N|From Havi|; Tideskorn Harbor |Z|1017;0|
A Shadows in the Mists |QID|40044|M|58.9,42.8|Z|Stormheim|N|From Havi|; Tideskorn Harbor |Z|1017;0|
; Usernote: T||Captain Sten|T|Captain Sten|N|GUID = Creature-0-3020-1220-31825-98014-00004C1093|M|55.7,46.9|Z|Stormheim|; Helmouth Shallows |Z|1017;0|
; Usernote: Treasure Chest On the boat deck, under water|M|55.0,47.2|Z|Stormheim|; Helmouth Shallows |Z|1017;0|
; |U|138783|M|55.0,47.2|Z|Stormheim|N|item:138783 [Glittering Memento]|; Helmouth Shallows |Z|1017;0|
C Shadows in the Mists |QID|40044|QO|1|M|55.6,46.8|Z|Stormheim|; Helmouth Shallows |Z|1017;0|
C Scavenging the Shallows |QID|40046|M|55.9,43.2|Z|Stormheim|; Helmouth Shallows |Z|1017;0|
; Usernote: xxx|T|Halvir|N|GUID = Creature-0-3020-1220-31825-98018-00004C183D|M|53.8,42.1|Z|Stormheim|; Helmouth Shallows |Z|1017;0|
C Shadows in the Mists |QID|40044|QO|4|M|53.9,42.0|Z|Stormheim|; Helmouth Shallows |Z|1017;0|
; Usernote: z|T|Sigrid|N|GUID = Creature-0-3020-1220-31825-98015-00004C18D8|M|54.5,35.1|Z|Stormheim|; Helmouth Shallows |Z|1017;0|
C Shadows in the Mists |QID|40044|QO|2|M|54.8,34.9|Z|Stormheim|; Helmouth Shallows |Z|1017;0|
C To Honor the Fallen |QID|43595|M|54.8,34.9|Z|Stormheim|; Helmouth Shallows |Z|1017;0|
; Usernote: z|T|Kjell|N|GUID = Creature-0-3020-1220-31825-98016-00004C1929|M|56.9,34.9|Z|Stormheim|; Helmouth Shallows |Z|1017;0|
C Shadows in the Mists |QID|40044|QO|3|M|56.9,34.9|Z|Stormheim|; Helmouth Shallows |Z|1017;0|
C Shadows in the Mists |QID|40044|M|56.9,34.9|Z|Stormheim|; Helmouth Shallows |Z|1017;0|
T Scavenging the Shallows |QID|40046|M|58.9,42.8|Z|Stormheim|N|To Havi|; Tideskorn Harbor |Z|1017;0|
T To Honor the Fallen |QID|43595|M|58.9,42.8|Z|Stormheim|N|To Havi|; Tideskorn Harbor |Z|1017;0|
T Shadows in the Mists |QID|40044|M|58.9,42.8|Z|Stormheim|N|To Havi|; Tideskorn Harbor |Z|1017;0|

T Turn the Keys|QID|38778|M|68.50,54.34|N|To Vydhar.|
T The Runewood's Revenge|QID|39788|M|68.50,54.34|N|To Vydhar.|
A The Dreaming Fungus|QID|38810|M|68.50,54.34|N|From Vydhar.|
A Bjornharta|QID|38808|M|68.50,54.34|N|From Vydhar.|
C The Dreaming Fungus |QID|38810|S|NC|M|68.5,54.3|N|Pick the mushrooms.|
C Bjornharta |QID|38808|M|68.5,54.3|N|Kill the bears to get the bloated hearts.|
C The Dreaming Fungus |QID|38810|US|NC|M|68.5,54.3|N|Pick the mushrooms.|
T The Dreaming Fungus |QID|38810|M|68.5,54.3|N|To Vydhar|
T Bjornharta |QID|38808|M|68.5,54.3|N|To Vydhar|
A Judgment Day |QID|38811|M|68.5,54.3|N|From Vydhar|
A Lay Them to Rest |QID|39791|M|68.5,54.3|N|From Vydhar|
C Lay Them to Rest |QID|39791|S|U|128772|M|66.7,45.6|N|Bring them to 30% and then use the Branch of the Runewood on them.|
K Judgment Day |QID|38811|T|Rythas the Oracle|QO|2|M|64.7,46.5|N|Start the ceremony, then kill Rythas the Oracle.|
K Judgment Day |QID|38811|T|Heimir of the Black Fist|QO|1|M|67.5,42.9|N|Start the ceremony, then kill Heimir of the Black Fist.|
K Judgment Day |QID|38811|T|Oktel Dragonblood|QO|3|M|66.7,45.6|N|Start the ceremony, then kill Oktel Dragonblood.|
C Lay Them to Rest |QID|39791|US|U|128772|M|66.7,45.6|N|Bring them to 30% and then use the Branch of the Runewood on them.|
T Judgment Day |QID|38811|M|68.1,48.7|N|To Shieldmaiden Iounn|
A Regal Remains |QID|38817|M|68.1,48.7|N|From Shieldmaiden Iounn|
T Lay Them to Rest |QID|39791|M|68.1,48.7|N|To Shieldmaiden Iounn|
A Breaking the Bonespeakers |QID|38816|M|68.1,48.7|N|From Shieldmaiden Iounn|
C Breaking the Bonespeakers |QID|38816|US|M|69.7,41.7|
C Regal Remains |QID|38817|NC|S|M|69.4,41.7|N|Pick-up the bones.|
A The Runes that Bind |QID|38823|M|69.8,45.7|N|From Bonespeaker Cleaver|
; |U|138783|M|73.3,41.4|Z|Stormheim|N|item:138783 [Glittering Memento]|; Haustvald |Z|1017;0|
C The Runes that Bind |QID|38823|S|M|69.6,42.0|
C Regal Remains |QID|38817|NC|US|M|69.4,41.7|N|Pick-up the bones.|
C Breaking the Bonespeakers |QID|38816|US|M|69.7,41.7|
T Regal Remains |QID|38817|M|69.9,45.5|N|To Shieldmaiden Iounn|
T Breaking the Bonespeakers |QID|38816|M|69.9,45.5|N|To Shieldmaiden Iounn|
T The Runes that Bind |QID|38823|M|69.9,45.5|N|To Shieldmaiden Iounn|
A Waking the Shieldmaiden |QID|38815|M|69.9,45.5|N|From Shieldmaiden Iounn|
A The Mystery of Dreyrgrot |QID|42635|M|74.9,55.6|N|From Sir Finley Mrrgglton|
A A Stone of Blood |QID|42639|M|74.9,55.6|N|From Sir Finley Mrrgglton|

C Waking the Shieldmaiden |QID|38815|NC|M|71.5,42.5|Z|Stormheim|; Haustvald |Z|1017;0|
T Waking the Shieldmaiden |QID|38815|M|71.5,42.5|Z|Stormheim|N|To Ashildir|; Haustvald |Z|1017;0|
A The Final Judgment |QID|38818|M|71.5,42.5|Z|Stormheim|N|From Ashildir|; Haustvald |Z|1017;0|
; Usernote: z|T|Runeseer Faljar|N|GUID = Creature-0-3020-1220-31825-93093-00004C1183|M|73.1,40.1|Z|Stormheim|; Haustvald |Z|1017;0|
C The Final Judgment |QID|38818|M|73.2,39.9|Z|Stormheim|; Haustvald |Z|1017;0|
T The Final Judgment |QID|38818|M|65.5,47.2|Z|Helheim|N|To Ashildir|;  |Z|1022;0|
A Raze Hel |QID|38343|M|65.5,47.2|Z|Helheim|N|From Ashildir [Bonus Objective]|;  |Z|1022;0|
A An Unworthy Task |QID|39837|M|65.5,47.2|Z|Helheim|N|From Ashildir|;  |Z|1022;0|
C An Unworthy Task |QID|39837|M|60.8,43.8|Z|Helheim|;  |Z|1022;0|
T An Unworthy Task |QID|39837|M|64.6,43.3|Z|Helheim|N|To Colborn the Unworthy|;  |Z|1022;0|
A A Little Kelp From My Foes |QID|38339|M|64.6,43.3|Z|Helheim|N|From Colborn the Unworthy|;  |Z|1022;0|
A Accessories of the Cursed |QID|38324|M|64.6,43.3|Z|Helheim|N|From Colborn the Unworthy|;  |Z|1022;0|
C Accessories of the Cursed |QID|38324|M|69.0,29.0|Z|Helheim|;  |Z|1022;0|
C A Little Kelp From My Foes |QID|38339|M|67.7,27.6|Z|Helheim|;  |Z|1022;0|
T A Little Kelp From My Foes |QID|38339|M|64.6,43.4|Z|Helheim|N|To Colborn the Unworthy|;  |Z|1022;0|
T Accessories of the Cursed |QID|38324|M|64.6,43.4|Z|Helheim|N|To Colborn the Unworthy|;  |Z|1022;0|
A Stealth by Seaweed |QID|38347|M|64.6,43.4|Z|Helheim|N|From Colborn the Unworthy|;  |Z|1022;0|
C A Desperate Bargain |QID|39848|QO|1|M|34.0,27.6|Z|Helheim|; Helya's Throne |Z|1022;0|
C A Desperate Bargain |QID|39848|QO|2|M|34.0,27.6|Z|Helheim|; Helya's Throne |Z|1022;0|
C A Desperate Bargain |QID|39848|M|34.0,27.6|Z|Helheim|; Helya's Throne |Z|1022;0|
T A Desperate Bargain |QID|39848|M|34.0,27.6|Z|Helheim|; Helya's Throne |Z|1022;0|
A The Eternal Nemesis |QID|39857|M|34.0,27.6|Z|Helheim|; Helya's Throne |Z|1022;0|
; Usernote: z|T|Bloodbeard|N|GUID = Creature-0-3882-1463-13382-91657-00004C22A9|M|22.1,62.0|Z|Helheim|;  |Z|1022;0|
C To Light the Way |QID|39849|M|22.1,62.0|Z|Helheim|;  |Z|1022;0|
T To Light the Way |QID|39849|M|46.9,48.9|Z|Helheim|N|To Ashildir|; The Eternal Battlefield |Z|1022;0|
A Sundered |QID|39850|M|46.9,48.9|Z|Helheim|N|From Ashildir|; The Eternal Battlefield |Z|1022;0|
A Allies in Death |QID|39851|M|46.9,48.9|Z|Helheim|N|From Ashildir|; The Eternal Battlefield |Z|1022;0|
C Allies in Death |QID|S|NC|39851|M|59.1,66.5|Z|Helheim|; The Eternal Battlefield |Z|1022;0|
C Sundered |QID|39850|NC|QO|3|M|35.3,76.2|Z|Helheim|; The Eternal Battlefield |Z|1022;0|
C Sundered |QID|39850|NC|QO|2|M|57.4,77.1|Z|Helheim|; The Eternal Battlefield |Z|1022;0|
C Sundered |QID|39850|NC|QO|1|M|63.8,61.2|Z|Helheim|; The Eternal Battlefield |Z|1022;0|
C Allies in Death |QID|US|NC|39851|M|59.1,66.5|Z|Helheim|; The Eternal Battlefield |Z|1022;0|
T Sundered |QID|39850|M|46.9,48.9|Z|Helheim|N|To Ashildir|; The Eternal Battlefield |Z|1022;0|
T Allies in Death |QID|39851|M|46.9,48.9|Z|Helheim|N|To Ashildir|; The Eternal Battlefield |Z|1022;0|
A Victory is Eternal |QID|39853|M|46.9,48.9|Z|Helheim|N|From Ashildir|; The Eternal Battlefield |Z|1022;0|


; Standard Class Halls redirect
D On to Class Halls|N|This ends Stormheim and the Druid order hall guide will load.|C|Druid|GUIDE|EmmLegionDruid|
D On to Class Halls|N|This ends Stormheim and the Death Knight order hall guide will load.|C|DeathKnight|GUIDE|EmmLegionDK|
D On to Class Halls|N|This ends Stormheim and the Demon Hunter order hall guide will load.|C|DemonHunter|GUIDE|LinksDHArtCH100100|
D On to Class Halls|N|This ends Stormheim and the Hunter order hall guide will load.|C|Hunter|GUIDE|EmmLegionHunter|
D On to Class Halls|N|This ends Stormheim and the Mage order hall guide will load.|C|Mage|GUIDE|EmmLegionMage|
D On to Class Halls|N|This ends Stormheim and the Monk order hall guide will load.|C|Monk|GUIDE|EmmLegionMonk|
D On to Class Halls|N|This ends Stormheim and the Paladin order hall guide will load.|C|Paladin|GUIDE|EmmLegionPaladin|
D On to Class Halls|N|This ends Stormheim and the Priest order hall guide will load.|C|Priest|GUIDE|EmmLegionPriest|
D On to Class Halls|N|This ends Stormheim and the Rogue order hall guide will load.|C|Rogue|GUIDE|EmmLegionRogue|
D On to Class Halls|N|This ends Stormheim and the Shaman order hall guide will load.|C|Shaman|GUIDE|EmmLegionShaman|
D On to Class Halls|N|This ends Stormheim and the Warlock order hall guide will load.|C|Warlock|GUIDE|EmmLegionWarlock|
D On to Class Halls|N|This ends Stormheim and the Warrior order hall guide will load.|C|Warrior|GUIDE|EmmLegionWarrior|

]]

end)
--[==[
[12:31:55] WoWPro: 35:Step [A Pins and Needles] should not use the |QO|1| tags.
[12:31:55] WoWPro: 37:Step [T Lightning Rod] should not use the |QO|2| tags.
[12:31:55] WoWPro: 43:Step [T Signal Boost] should not use the |QO|1| tags.
[12:31:55] WoWPro: 44:Step [A The Ancient Trials] should not use the |QO|3| tags.
[12:31:55] WoWPro: 50:Step [T Havi's Test] should not use the |QO|1| tags.
[12:31:55] WoWPro: 51:Step [A Ahead of the Game] should not use the |QO|1| tags.
[12:31:55] WoWPro: 53:Step [A Blood and Gold] should not use the |QO|3| tags.
[12:31:55] WoWPro: 59:Step [T Ahead of the Game] should not use the |QO|2| tags.
[12:31:55] WoWPro: 60:Step [A A Trial of Valor] should not use the |QO|1| tags.
[12:31:55] WoWPro: 61:Step [A A Trial of Will] should not use the |QO|1| tags.
[12:31:55] WoWPro: 62:Step [A The Shattered Watcher] should not use the |QO|1| tags.
[12:31:55] WoWPro: 69:Step [T A Trial of Valor] should not use the |QO|2| tags.
[12:31:55] WoWPro: 72:Step [A A Trial of Might] should not use the |QO|1| tags.
[12:31:55] WoWPro: 79:Step [T The Blessing of the Watchers] should not use the |QO|1| tags.
[12:31:55] WoWPro: 87:Step [A No Wings Required] should not use the |QO|2| tags.
[12:31:55] WoWPro: 94:Step [T Assault the Drekirjar] should not use the |QO|1| tags.
[12:31:55] WoWPro: 100:Step [T Built to Scale] should not use the |QO|1| tags.
[12:31:55] WoWPro: 108:Step [T Above the Winter Moonlight] should not use the |QO|4| tags.
[12:31:55] WoWPro: 109:Step [A Heart of a Dragon] should not use the |QO|3| tags.
[12:31:55] WoWPro: 110:Step [A Wings of Liberty] should not use the |QO|1| tags.
[12:31:55] WoWPro: 111:Step [A Fury of the Storm] should not use the |QO|2| tags.
[12:31:55] WoWPro: 120:Step [T Heart of a Dragon] should not use the |QO|2| tags.]==]