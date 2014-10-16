
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/assault_dark_portal
-- Date: 2014-10-12 06:06
-- Who: Emmaleah
-- Log: run thru in build 19005 - Emmaleah - 10/11/14 (combining of horde/alliance steps)

-- URL: http://wow-pro.com/node/3600/revisions/26701/view
-- Date: 2014-09-29 21:07
-- Who: Fluclo

-- URL: http://wow-pro.com/node/3600/revisions/26693/view
-- Date: 2014-09-27 22:30
-- Who: Ludovicus
-- Log: Guide Name Change

-- URL: http://wow-pro.com/node/3600/revisions/26684/view
-- Date: 2014-09-26 02:33
-- Who: Fluclo
-- Log: NPCs have moved location at the entrance to Umbral Halls, and the quest Yrel needed both PRE and N tags.

-- URL: http://wow-pro.com/node/3600/revisions/26681/view
-- Date: 2014-09-21 20:35
-- Who: Fluclo
-- Log: The Home Stretch - Missing |N| tags (whoops!)

-- URL: http://wow-pro.com/node/3600/revisions/26680/view
-- Date: 2014-09-21 20:09
-- Who: Fluclo
-- Log: The Home Stretch - this quest is now no-mount, so updated note to reflect.

-- URL: http://wow-pro.com/node/3600/revisions/26679/view
-- Date: 2014-09-21 20:07
-- Who: Fluclo
-- Log: The Home Stretch is |NC|

-- URL: http://wow-pro.com/node/3600/revisions/26678/view
-- Date: 2014-09-21 20:06
-- Who: Fluclo
-- Log: Correct PRE tag on The Battle of the Forge

-- URL: http://wow-pro.com/node/3600/revisions/26676/view
-- Date: 2014-09-19 18:18
-- Who: Fluclo

-- URL: http://wow-pro.com/node/3600/revisions/26675/view
-- Date: 2014-09-19 18:17
-- Who: Fluclo


local guide = WoWPro:RegisterGuide('EmmFluc_DarkPortal', "Leveling", 'The Dark Portal', 'Emm+Fluc', 'Neutral')
WoWPro:GuideLevels(guide,90,90,90)
WoWPro:GuideNextGuide(guide, 'ShadowDraenor|EmmFrostfire')
WoWPro:GuideSteps(guide, function()
return [[

;Quest numbers differ on source pick-up. From Stormwind or Orgrimmar Auto-Accept, it is 34398. From Archmage Khadgar at The Dark Portal it is 36881.
C The Dark Portal |QID|34398;36881|Z|Blasted Lands|M|54.9,50.3|N|To Archmage Khadgar|CHAT|
T The Dark Portal |QID|34398;36881|N|To Archmage Khadgar|M|54.7,48.2|Z|TanaanJungleIntro|

A The Dark Portal |QID|34398|Z|Stormwind City|N|Auto-Accept on arrival in Stormwind City. If it doesn't appear/auto-accept, just head to the Hero's Call Board and select the quest from there.|FACTION|Alliance|Z|Stormwind City|LEAD|36881|
A The Dark Portal |QID|34398|Z|Orgrimmar|N|Auto-Accept on arrival in Orgrimmar. If it doesn't appear/auto-accept, just head to the Hero's Call Board and select the quest from there.|FACTION|Horde|Z|Orgrimmar|LEAD|36881|
C The Dark Portal |QID|34398|Z|Blasted Lands|M|54.9,50.3|N|Speak to Archmage Khadgar at the foot of The Dark Portal in Blasted Lands. A portal to the Blasted Lands can be found in the Mage Tower.\n\n[BETA: He is also located in Stormwind City's Trade District 65.2, 75.4]|CHAT|FACTION|Alliance|LEAD|36881|
C The Dark Portal |QID|34398|Z|Blasted Lands|M|54.9,50.3|N|Speak to Archmage Khadgar at the foot of The Dark Portal in Blasted Lands.|CHAT|FACTION|Horde|LEAD|36881|
T The Dark Portal |QID|34398|N|To Archmage Khadgar|M|54.7,48.2|Z|TanaanJungleIntro|LEAD|36881|

A Azeroth's Last Stand |QID|35933|N|From Archmage Khadgar|M|54.7,48.2|PRE|34398+36881|Z|TanaanJungleIntro|
C Azeroth's Last Stand |QID|35933|N|Kill an Iron Horde, and loot the Iron Horde Missive|M|53.0,48.3|Z|TanaanJungleIntro|
T Azeroth's Last Stand |QID|35933|N|Auto-Complete|Z|TanaanJungleIntro|

A Onslaught's End |QID|34392|N|Auto-Accept\n\nIf you've previously abandoned this quest, you can pick it up again from Archmage Khadgar.|PRE|35933|Z|TanaanJungleIntro|
C Disable the Northern Fel Spire |QID|34392|N|Disable the Northern Fel Spire|QO|1|NC|M|51.0, 42.0|Z|TanaanJungleIntro|;hand
C Disable the Northern Fel Spire |QID|34392|N|Disable the Southern Fel Spire|QO|2|NC|M|51.0, 54.6|Z|TanaanJungleIntro|;hand
T Onslaught's End |QID|34392|N|To Archmage Khadgar|M|54.7,48.2|Z|TanaanJungleIntro|

A The Portal's Power |QID|34393|N|From Archmage Khadgar|M|54.7,48.2|PRE|34392|Z|TanaanJungleIntro|
C The Portal's Power |QID|34393|N|Enter Gul'dan's prison, located directly underneath Archmage Khadgar. Entrances available due north and due south of Khadgar.|NC|QO|1|M|54.9,51.1|Z|TanaanJungleIntro|;hand
C The Portal's Power |QID|34393|N|Mark of the Burning Blade destroyed|NC|QO|2|M|56.0,46.3|Z|TanaanJungleIntro|;hand
C The Portal's Power |QID|34393|N|Mark of the Shattered Hand destroyed|NC|QO|3|M|57.3,48.2|Z|TanaanJungleIntro|;hand
C The Portal's Power |QID|34393|N|Mark of the Blackrock destroyed|NC|QO|4|M|56.1,50.1|Z|TanaanJungleIntro|;hand
C The Portal's Power |QID|34393|N|Destroy the Stasis Rune, located under Gul'dan|NC|QO|5|M|56.0,48.2|Z|TanaanJungleIntro|;hand
T The Portal's Power |QID|34393|N|To Archmage Khadgar|M|54.7,48.2|Z|TanaanJungleIntro|

A The Cost of War |QID|34420|N|From Archmage Khadgar|M|54.7,48.2|PRE|34393|Z|TanaanJungleIntro|
T The Cost of War |QID|34420|N|Follow Archmage Khadgar to Heartblood, then turn in quest.|M|60.2,56.4|Z|TanaanJungleIntro|

A Blaze of Glory |QID|34422|N|From Archmage Khadgar|M|60.3,56.3|PRE|34420|Z|TanaanJungleIntro|
A Vengeance for the Fallen |QID|35242;35241|N|From Rephuura|M|62.2,53.0|PRE|34420|Z|TanaanJungleIntro|
A Bled Dry |QID|35240|N|From Taag|M|62.2,53.0|PRE|34420|Z|TanaanJungleIntro|FACTION|Alliance|
A Bled Dry |QID|34421|N|From Taag|M|62.2,53.0|PRE|34420|Z|TanaanJungleIntro|FACTION|Horde|

C Vengeance for the Fallen |QID|35242|N|Kill the Bleeding Hollow orcs.|S|M|65.7,54.0|Z|TanaanJungleIntro|FACTION|Alliance|
C Vengeance for the Fallen |QID|35241|N|Kill the Bleeding Hollow orcs.|S|M|65.7,54.0|Z|TanaanJungleIntro|FACTION|Horde|
C Blaze of Glory |QID|34422|N|Approach the Bleeding Hollow huts, then use Lucifrium Bead's "Inferno" to burn them.|NC|S|M|66.5,55.9|Z|TanaanJungleIntro|
C Bled Dry |QID|35240|N|Open the Eastern cage.|NC|QO|2|M|65.7,54.0|Z|TanaanJungleIntro|FACTION|Alliance|
C Bled Dry |QID|34421|N|Open the Eastern cage.|NC|QO|2|M|61.0,62.7|Z|TanaanJungleIntro|FACTION|Horde|
C Bled Dry |QID|35240|N|Open the Southern cage.|NC|QO|1|M|65.7,54.0|Z|TanaanJungleIntro|FACTION|Alliance|
C Bled Dry |QID|34421|N|Open the Southern cage.|NC|QO|1|M|61.0,62.7|Z|TanaanJungleIntro|FACTION|Horde|
C Blaze of Glory |QID|34422|N|Finish burning the Bleeding Hollow huts.|NC|US|M|61.0,62.7|Z|TanaanJungleIntro|
C Vengeance for the Fallen |QID|35242|N|Finish killing the Bleeding Hollow orcs.|US|M|63.3,64.4|Z|TanaanJungleIntro|FACTION|Alliance|
C Vengeance for the Fallen |QID|35241|N|Finish killing the Bleeding Hollow orcs.|US|M|63.3,64.4|Z|TanaanJungleIntro|FACTION|Horde|

T Vengeance for the Fallen |QID|35242|N|To Vindicator Maraad|FACTION|Alliance|M|71.5,62.7|Z|TanaanJungleIntro|
T Vengeance for the Fallen |QID|35241|N|To Thrall|FACTION|Horde|M|72.0,62.1|Z|TanaanJungleIntro|
T Blaze of Glory |QID|34422|N|To Archmage Khadgar|M|71.6,62.3|Z|TanaanJungleIntro|
T Bled Dry |QID|35240|N|To Archmage Khadgar|M|61.0,62.8|Z|TanaanJungleIntro|FACTION|Alliance|
T Bled Dry |QID|34421|N|To Archmage Khadgar|M|61.0,62.8|Z|TanaanJungleIntro|FACTION|Horde|

A Altar Altercation |QID|34423|N|From Archmage Khadgar|PRE|35242;34422;35240|FACTION|Alliance|M|71.6,62.3|Z|TanaanJungleIntro|
A Altar Altercation |QID|34423|N|From Archmage Khadgar|PRE|35241;34422;34421|FACTION|Horde|M|71.6,62.3|Z|TanaanJungleIntro|
C Altar Altercation |QID|34423|N|Speak with Ariok and tell him "Khadgar has asked us to go distract the Eye of Kilrogg".|QO|1|CHAT|M|72.0,62.2|Z|TanaanJungleIntro|
C Altar Altercation |QID|34423|N|Head to the Bleeding Altar.|QO|2|NC|M|76.4,54.8|Z|TanaanJungleIntro|
C Altar Altercation |QID|34423|N|Destroy the three ritual orbs (the third is up the stairs on the side).|QO|3|NC|M|78.7,53.3|Z|TanaanJungleIntro|
C Altar Altercation |QID|34423|N|Head to Khadgar who is on the other side of Tar'thog Bridge.|QO|4|NC|M|71.9,40.4|Z|TanaanJungleIntro|
T Altar Altercation |QID|34423|N|To Archmage Khadgar|M|71.9,40.4|Z|TanaanJungleIntro|

A The Kargathar Proving Grounds |QID|34425|N|From Archmage Khadgar|M|71.9,40.4|PRE|34423|Z|TanaanJungleIntro|
C The Kargathar Proving Grounds |QID|34425|N|Wait for Archmage Khadgar to deal with the bridge, then follow him to the gaggle near Kargathar Proving Grounds|NC|M|73.0,38.0|Z|TanaanJungleIntro|
T The Kargathar Proving Grounds |QID|34425|N|To Archmage Khadgar|M|73.0,38.0|Z|TanaanJungleIntro|

A A Potential Ally |QID|34478|N|From Archmage Khadgar|M|73.0,38.0|PRE|34425|Z|TanaanJungleIntro|FACTION|Alliance|
A A Potential Ally |QID|34427|N|From Archmage Khadgar|M|73.0,38.0|PRE|34425|Z|TanaanJungleIntro|FACTION|Horde|
C A Potential Ally |QID|34478|N|Head to the Fire Ring, and use the Frostfury|NC|M|69.0,33.7|Z|TanaanJungleIntro|FACTION|Alliance|
C A Potential Ally |QID|34427|N|Head to the Fire Ring, and use the Frostfury|NC|M|69.0,33.7|Z|TanaanJungleIntro|FACTION|Horde|
T A Potential Ally |QID|34478|N|To Exarch Maladaar once he has run back to the gaggle.|FACTION|Alliance|M|73.2,38.9|Z|TanaanJungleIntro|
T A Potential Ally |QID|34427|N|To Farseer Drek'Thar once he has run back to the gaggle.|FACTION|Horde|M|73.2,38.9|Z|TanaanJungleIntro|

A Kill Your Hundred |QID|34429|N|From Archmage Khadgar|M|73.0,38.0|PRE|34427+34478|Z|TanaanJungleIntro|
C Kill Your Hundred |QID|34429|N|Enter Kargathar Proving Grounds|QO|1|NC|M|73.6,29.0|Z|TanaanJungleIntro|
C Kill Your Hundred |QID|34429|N|Wait until you have 100 Combatants killed (your friends will do all the killing for you if you want).|QO|2|M|73.6,27.3|Z|TanaanJungleIntro|
C Kill Your Hundred |QID|34429|N|Leave the arena and head to Umbral Halls.|NC|QO|3|M|80.9,50.1|Z|Tanaan Jungle|
T Kill Your Hundred |QID|34429|N|To Archmage Khadgar|M|80.9,50.1|Z|Tanaan Jungle|

A The Shadowmoon Clan |QID|34432|N|From Vindicator Maraad|FACTION|Alliance|M|80.7,45.3|PRE|34429|Z|Tanaan Jungle|
A The Shadowmoon Clan |QID|34739|N|From Thrall|FACTION|Horde|M|80.6,48.7|PRE|34429|Z|Tanaan Jungle|
A Masters of Shadow |QID|34431|N|From Luuka|M|82.8,44.2|PRE|34429|Z|Tanaan Jungle|FACTION|Alliance|
A Masters of Shadow |QID|34737|N|From Luuka|M|82.8,44.2|PRE|34429|Z|Tanaan Jungle|FACTION|Horde|

C The Shadowmoon Clan |QID|34432|N|Kill the Shadowmoon Voidaxe, Ritualist and Void Wolfs|S|M|60.6,51.8|Z|Tanaan Jungle|FACTION|Alliance|
C The Shadowmoon Clan |QID|34739|N|Kill the Shadowmoon Voidaxe, Ritualist and Void Wolfs|S|M|60.6,51.8|Z|Tanaan Jungle|FACTION|Horde|
K Slay Ungra |QID|34431|T|Ungra|N|Kill Ungra. Head up the first stairs, then take the next set of stairs to the left, then to the left.|QO|1|M|44.0,74.5|Z|Tanaan Jungle|FACTION|Alliance|
K Slay Taskmaster Gurran |QID|34431|T|Taskmaster Gurran|N|Straight along the corridor behind you. Watch for the hole in the floor.|QO|2|M|56.2,19.8|Z|Tanaan Jungle|FACTION|Alliance|
C Slay Ankova the Fallen |QID|34431|N|Jump down the hole, then follow the corridor north-west to the corpse of Ankova|QO|3|NC|M|45.2,16.1|Z|Tanaan Jungle|FACTION|Alliance|
K Slay Ungra |QID|34737|T|Ungra|N|Kill Ungra. Head up the first stairs, then take the next set of stairs to the left, then to the left.|QO|1|M|44.0,74.5|Z|Tanaan Jungle|FACTION|Horde|
K Slay Taskmaster Gurran |QID|34737|T|Taskmaster Gurran|N|Straight along the corridor behind you. Watch for the hole in the floor.|QO|2|M|56.2,19.8|Z|Tanaan Jungle|FACTION|Horde|
C Slay Ankova the Fallen |QID|34737|N|Jump down the hole, then follow the corridor north-west to the corpse of Ankova|QO|3|NC|M|45.2,16.1|Z|Tanaan Jungle|FACTION|Horde|

A Yrel |QID|34434|N|From Yrel|M|45.2,16.1|Z|Tanaan Jungle|FACTION|Alliance|PRE|34429|
A Yrel |QID|34740|N|From Yrel|M|45.2,16.1|Z|Tanaan Jungle|FACTION|Horde|PRE|34429|
C Yrel |QID|34434|N|Head down the corridor.|NC|M|57.7,40.6|Z|Tanaan Jungle|FACTION|Alliance|
C Yrel |QID|34740|N|Head down the corridor.|NC|M|57.7,40.6|Z|Tanaan Jungle|FACTION|Horde|
C The Shadowmoon Clan |QID|34432|N|Finish killing the Shadowmoon Voidaxe and Void Wolfs|US|M|57.7,40.6|Z|Tanaan Jungle|FACTION|Alliance|
C The Shadowmoon Clan |QID|34739|N|Finish killing the Shadowmoon Voidaxe and Void Wolfs|US|M|57.7,40.6|Z|Tanaan Jungle|FACTION|Horde|

T The Shadowmoon Clan |QID|34432|N|To Qiana Moonshadow|FACTION|Alliance|M|50.7,48.5|Z|Tanaan Jungle|
T The Shadowmoon Clan |QID|34739|N|To Olin Umberhide|FACTION|Horde|M|50.7,48.5|Z|Tanaan Jungle|
T Yrel |QID|34434|N|To Yrel|M|50.7,48.5|Z|Tanaan Jungle|FACTION|Alliance|
T Yrel |QID|34740|N|To Yrel|M|50.7,48.5|Z|Tanaan Jungle|FACTION|Horde|
T Masters of Shadow |QID|34431|N|To Exarch Maladaar|FACTION|Alliance|M|50.7,48.5|Z|Tanaan Jungle|
T Masters of Shadow |QID|34737|N|To Lady Liadrin|FACTION|Horde|M|50.7,48.5|Z|Tanaan Jungle|

A Keli'dan the Breaker |QID|34436|N|From Exarch Maladaar|FACTION|Alliance|M|50.7,48.5|PRE|34431;34434;34432|Z|Tanaan Jungle|
A Keli'dan the Breaker |QID|34741|N|From Lady Liadrin|FACTION|Horde|M|50.7,48.5|PRE|34739;34740;34737|Z|Tanaan Jungle|
K Keli'dan the Breaker |QID|34436|T|Keli'dan the Breaker|N|Kill Keli'dan the Breaker.|M|35.2,50.4|Z|TanaanJungleIntro|FACTION|Alliance|
K Keli'dan the Breaker |QID|34741|T|Keli'dan the Breaker|N|Kill Keli'dan the Breaker.|M|35.2,50.4|Z|TanaanJungleIntro|FACTION|Horde|
T Keli'dan the Breaker |QID|34436|N|To Archmage Khadgar|M|49.5,14.3|Z|TanaanJungleIntro|FACTION|Alliance|
T Keli'dan the Breaker |QID|34741|N|To Archmage Khadgar|M|49.5,14.3|Z|TanaanJungleIntro|FACTION|Horde|

A Prepare for Battle |QID|35019|N|From Vindicator Maraad|FACTION|Alliance|PRE|34436|M|48.5,14.1|Z|TanaanJungleIntro|
C Prepare for Battle |QID|35019|N|Kill and loot the Blackrock, or pick the Iron Horde Weapon from the floor.|M|44.9,19.5|Z|TanaanJungleIntro|FACTION|Alliance|
T Prepare for Battle |QID|35019|N|To Vindicator Maraad|FACTION|Alliance|M|48.6,14.2|Z|TanaanJungleIntro|
A Prepare for Battle |QID|35005|N|From Thrall|FACTION|Horde|PRE|34741|M|48.5,14.1|Z|TanaanJungleIntro|
C Prepare for Battle |QID|35005|N|Kill and loot the Blackrock, or pick the Iron Horde Weapon from the floor.|M|44.9,19.5|Z|TanaanJungleIntro|FACTION|Horde|
T Prepare for Battle |QID|35005|N|To Thrall|FACTION|Horde|M|50.1,13.3|Z|TanaanJungleIntro|

A The Battle of the Forge |QID|34439|N|From Cordana Felsong|PRE|35005;35019|M|49.5,14.2|Z|TanaanJungleIntro|
C The Battle of the Forge |QID|34439|N|Kill Blackrock Grunts|QO|2|S|M|44.3,21.3|Z|TanaanJungleIntro|
C The Battle of the Forge |QID|34439|N|Kill the Ogron Warcrusher|QO|1|M|42.9,21.4|Z|TanaanJungleIntro|
C The Battle of the Forge |QID|34439|N|Finish killing the Blackrock Grunts|QO|2|US|M|44.3,21.3|Z|TanaanJungleIntro|
T The Battle of the Forge |QID|34439|N|To Farseer Drek'Thar|M|43.0,26.4|Z|TanaanJungleIntro|

A Ga'nar of the Frostwolf |QID|34442|N|From Farseer Drek'Thar|PRE|34439|M|43.0,26.4|Z|TanaanJungleIntro|
A The Gunpowder Plot |QID|34987|N|From Hansel Heavyhands|PRE|34439|M|44.0,29.7|Z|TanaanJungleIntro|
A The Shadow of the Worldbreaker |QID|34958|N|From Thaelin Darkanvil|PRE|34439|M|44.0,29.7|Z|TanaanJungleIntro|

C The Shadow of the Worldbreaker |QID|34958|N|Kill the Blackrock until one drops the Worldbreaker Schematics|S|M|43.0,35.8|Z|TanaanJungleIntro|
T Ga'nar of the Frostwolf |QID|34442|N|To Ga'nar, who is at the other end of Blackrock Quarry|M|41.9,41.9|Z|TanaanJungleIntro|
A Polishing the Iron Throne |QID|34925|N|From Ga'nar|M|41.9,41.9|PRE|34442|Z|TanaanJungleIntro|
K Overseer Gotrigg |QID|34925|T|Overseer Gotrigg|N|Head into the hut, kill Overseer Gotrigg, and loot the Shackle Key|M|45.7,39.7|Z|TanaanJungleIntro|
T Polishing the Iron Throne |QID|34925|N|To Ga'nar|M|41.9,41.9|Z|TanaanJungleIntro|
A The Prodigal Frostwolf |QID|34437|N|From Ga'nar|M|41.9,41.9|PRE|34925|Z|TanaanJungleIntro|

C The Gunwpowder Plot |QID|34987|N|Head into the hut and loot the Blackrock Powder Keg|NC|QO|1|M|46.9,32.1|Z|TanaanJungleIntro|
C The Shadow of the Worldbreaker |QID|34958|N|Keep killing the Blackrock, one will eventually drop the Worldbreaker Schematics|US|M|43.0,35.8|Z|TanaanJungleIntro|
C The Gunpowder Plot |QID|34987|N|Press the Makeshift Plunger between Hansel Heavyhands and Thaelin Darkanvil|NC|QO|2|M|44.0,29.7|Z|TanaanJungleIntro|
T The Gunpowder Plot |QID|34987|N|To Hansel Heavyhands|M|44.0,29.7|Z|TanaanJungleIntro|

T The Shadow of the Worldbreaker |QID|34958|N|To Thaelin Darkanvil|M|44.0,29.7|Z|TanaanJungleIntro|
T The Prodigal Frostwolf |QID|34437|N|To Farseer Drek'Thar|M|43.0,26.4|Z|TanaanJungleIntro|

A Taking a Trip to the Top of the Tank |QID|35747|N|From Archmage Khadgar|PRE|34958;34437;34987|M|43.1,28.7|Z|TanaanJungleIntro|
C Taking a Trip to the Top of the Tank |QID|35747|N|Speak with Thaelin Darkanvil and say "Yes. I need you to help me operate that enormous tank".|QO|1|CHAT|M|44.0,29.7|Z|TanaanJungleIntro|
C Taking a Trip to the Top of the Tank |QID|35747|N|Head to The Path of Glory and kill Gogluk.|QO|2|M|37.5,48.5|Z|TanaanJungleIntro|
C Taking a Trip to the Top of the Tank |QID|35747|N|Run up one of the two chains to the top of the tank.|NC|QO|3|M|40.1,48.4|Z|TanaanJungleIntro|
T Taking a Trip to the Top of the Tank |QID|35747|N|To Thaelin Darkanvil|M|40.1,48.4|Z|TanaanJungleIntro|

A A Taste of Iron |QID|34445|N|From Thaelin Darkanvil|PRE|35747|M|40.1,48.4|Z|TanaanJungleIntro|
C A Taste of Iron |QID|34445|N|Mount the Worldbreaker Side Turret (to the top right)|NC|QO|1|M|40.1,49.1|Z|TanaanJungleIntro|
C A Taste of Iron |QID|34445|N|Use the Turret Blast (key 1) to kill the Iron Horde. You do not need to worry about the tanks or carts.|QO|2|Z|TanaanJungleIntro|
C A Taste of Iron |QID|34445|N|Press the Main Cannon Trigger next to Thaelin Darkanvil.|NC|QO|3|M|40.3,48.3|Z|TanaanJungleIntro|
T A Taste of Iron |QID|34445|N|To Thaelin Darkanvil|M|40.1,48.4|Z|TanaanJungleIntro|

A The Home Stretch |QID|35884|N|From Thaelin Darkanvil|PRE|34445|M|40.1,48.4|Z|TanaanJungleIntro|FACTION|Alliance|
A The Home Stretch |QID|34446|N|From Thaelin Darkanvil|PRE|34445|M|40.1,48.4|Z|TanaanJungleIntro|FACTION|Horde|
C The Home Stretch |QID|35884|N|Run through the Iron Bastion to the Docks.\n(Note: You cannot mount at this time)|M|44.4,80.7|Z|TanaanJungleIntro|FACTION|Alliance|NC|
C The Home Stretch |QID|34446|N|Run through the Iron Bastion to the Docks.\n(Note: You cannot mount at this time)|M|44.4,80.7|Z|TanaanJungleIntro|FACTION|Horde|NC|
T The Home Stretch |QID|35884|N|To Archmage Khadgar|M|44.4,80.7|Z|TanaanJungleIntro|FACTION|Alliance|
T The Home Stretch |QID|34446|N|To Archmage Khadgar|M|44.4,80.7|Z|TanaanJungleIntro|FACTION|Horde|

A Step Three: Prophet! |QID|34575|M|44.4,80.7|Z|TanaanJungleIntro|N|From Archmage Khadgar|; Iron Bastion |Z|970;0|
T Step Three: Prophet! |QID|34575|M|27.0,8.1|Z|Shadowmoon Valley|N|To Prophet Velen|; Eventide Landing |Z|947;0|

]]

end)
--[[
T Azeroth's Last Stand |QID|35933|M|54.1,48.8|Z|Tanaan Jungle|; The Dark Portal
; Field turnin
A Onslaught's End |QID|34392|M|54.1,48.8|Z|Tanaan Jungle|; The Dark Portal
C Onslaught's End |QID|34392|QO|1/1 Northern Fel Spire disabled|M|51.1,42.0|Z|Tanaan Jungle|; The Dark Portal
C Onslaught's End |QID|34392|QO|1/1 Southern Fel Spire disabled|M|51.2,54.7|Z|Tanaan Jungle|; The Dark Portal
T Onslaught's End |QID|34392|M|54.7,48.2|Z|Tanaan Jungle|N|To Archmage Khadgar|; The Dark Portal
A The Portal's Power |QID|34393|M|54.7,48.2|Z|Tanaan Jungle|N|From Archmage Khadgar|; The Dark Portal
C The Portal's Power |QID|34393|QO|1/1 Enter Gul'dan's prison|M|54.9,50.1|Z|Tanaan Jungle|; The Dark Portal
C The Portal's Power |QID|34393|QO|1/1 Mark of the Burning Blade destroyed|M|55.9,46.3|Z|Tanaan Jungle|; The Dark Portal
C The Portal's Power |QID|34393|QO|1/1 Mark of the Shattered Hand destroyed|M|57.2,48.1|Z|Tanaan Jungle|; The Dark Portal
C The Portal's Power |QID|34393|QO|1/1 Mark of the Blackrock destroyed|M|56.2,50.2|Z|Tanaan Jungle|; The Dark Portal
C The Portal's Power |QID|34393|QO|1/1 Stasis Rune destroyed|M|55.8,48.2|Z|Tanaan Jungle|; The Dark Portal
T The Portal's Power |QID|34393|M|54.8,48.3|Z|Tanaan Jungle|N|To Archmage Khadgar|; The Dark Portal
A The Cost of War |QID|34420|M|54.8,48.1|Z|Tanaan Jungle|N|From Archmage Khadgar|; The Dark Portal
T The Cost of War |QID|34420|M|60.2,56.3|Z|Tanaan Jungle|N|To Archmage Khadgar|; Heartblood
A Blaze of Glory |QID|34422|M|60.2,56.3|Z|Tanaan Jungle|N|From Archmage Khadgar|; Heartblood
A Vengeance for the Fallen |QID|35242|M|62.2,52.9|Z|Tanaan Jungle|N|From Rephuura|; Heartblood
A Bled Dry |QID|35240|M|62.3,53.0|Z|Tanaan Jungle|N|From Taag|; Heartblood
C Bled Dry |QID|35240|QO|1/1 Eastern cage opened|M|65.6,54.0|Z|Tanaan Jungle|; Heartblood
C Bled Dry |QID|35240|QO|1/1 Southern cage opened|M|61.0,62.8|Z|Tanaan Jungle|; Heartblood
T Vengeance for the Fallen |QID|35242|M|71.5,62.7|Z|Tanaan Jungle|N|To Vindicator Maraad|; Heartblood
T Blaze of Glory |QID|34422|M|71.5,62.4|Z|Tanaan Jungle|N|To Archmage Khadgar|; Heartblood
T Bled Dry |QID|35240|M|71.5,62.4|Z|Tanaan Jungle|N|To Archmage Khadgar|; Heartblood
A Altar Altercation |QID|34423|M|71.5,62.4|Z|Tanaan Jungle|N|From Archmage Khadgar|; Heartblood
C Altar Altercation |QID|34423|QO|1/1 Speak with Ariok|M|72.0,62.2|Z|Tanaan Jungle|; Heartblood
C Altar Altercation |QID|34423|QO|1/1 Escort Ariok to the Bleeding Altar|M|75.9,55.6|Z|Tanaan Jungle|; The Bleeding Altar
C Altar Altercation |QID|34423|QO|3/3 Blood Ritual Orb destroyed|M|78.7,53.4|Z|Tanaan Jungle|; The Bleeding Altar
C Altar Altercation |QID|34423|QO|1/1 Find Khadgar on Tar'thog Bridge|M|71.8,41.9|Z|Tanaan Jungle|; Tar'thog Bridge
T Altar Altercation |QID|34423|M|72.0,40.5|Z|Tanaan Jungle|N|To Archmage Khadgar|; Tar'thog Bridge
A The Kargathar Proving Grounds |QID|34425|M|72.0,40.5|Z|Tanaan Jungle|N|From Unknown|; Tar'thog Bridge
T The Kargathar Proving Grounds |QID|34425|M|73.0,38.1|Z|Tanaan Jungle|N|To Archmage Khadgar|; Kargathar Proving Grounds
A A Potential Ally |QID|34478|M|73.0,38.1|Z|Tanaan Jungle|N|From Archmage Khadgar|; Kargathar Proving Grounds
T A Potential Ally |QID|34478|M|73.2,38.9|Z|Tanaan Jungle|N|To Exarch Maladaar|; Kargathar Proving Grounds
A Kill Your Hundred |QID|34429|M|73.0,38.1|Z|Tanaan Jungle|N|From Archmage Khadgar|; Kargathar Proving Grounds
C Kill Your Hundred |QID|34429|QO|1/1 Enter the arena|M|73.7,27.2|Z|Tanaan Jungle|; Kargathar Proving Grounds
C Kill Your Hundred |QID|34429|QO|100/100 Combatants slain in the arena|M|73.6,24.5|Z|Tanaan Jungle|; Kargathar Proving Grounds
C Kill Your Hundred |QID|34429|QO|1/1 Escape Kargath's arena|M|82.5,49.6|Z|Tanaan Jungle|; Umbral Halls
; Usernote: test|M|82.5,56.3|Z|Umbral Halls|;  |Z|970;1|
T Kill Your Hundred |QID|34429|M|81.3,50.2|Z|Umbral Halls|N|To Archmage Khadgar|;  |Z|970;1|
A The Shadowmoon Clan |QID|34432|M|80.7,45.2|Z|Umbral Halls|N|From Vindicator Maraad|;  |Z|970;1|
A Masters of Shadow |QID|34431|M|82.8,44.3|Z|Umbral Halls|N|From Luuka|;  |Z|970;1|
C Masters of Shadow |QID|34431|QO|1/1 Ungra slain|M|43.8,76.7|Z|Tanaan Jungle|; Umbral Halls |Z|970;1|
C Masters of Shadow |QID|34431|QO|1/1 Taskmaster Gurran slain|M|56.0,19.9|Z|Tanaan Jungle|; Umbral Halls |Z|970;1|
C Masters of Shadow |QID|34431|QO|1/1 Ankova the Fallen slain|M|46.0,15.7|Z|Tanaan Jungle|; Umbral Halls |Z|970;1|
A Yrel |QID|34434|M|45.1,16.1|Z|Tanaan Jungle|N|From Unknown|; Umbral Halls |Z|970;1|
T Masters of Shadow |QID|34431|M|50.3,48.3|Z|Tanaan Jungle|N|To Exarch Maladaar|; Umbral Halls |Z|970;1|
T The Shadowmoon Clan |QID|34432|M|51.4,55.1|Z|Tanaan Jungle|N|To Qiana Moonshadow|; Umbral Halls |Z|970;1|
T Yrel |QID|34434|M|50.5,48.4|Z|Tanaan Jungle|N|To Yrel|; Umbral Halls |Z|970;1|
A Keli'dan the Breaker |QID|34436|M|50.2,48.2|Z|Tanaan Jungle|N|From Exarch Maladaar|; Umbral Halls |Z|970;1|
T Keli'dan the Breaker |QID|34436|M|49.5,14.4|Z|Tanaan Jungle|N|To Archmage Khadgar|; Blackrock Quarry |Z|970;0|
A Prepare for Battle |QID|35019|M|48.6,14.2|Z|Tanaan Jungle|N|From Vindicator Maraad|; Blackrock Quarry |Z|970;0|
T Prepare for Battle |QID|35019|M|48.5,14.2|Z|Tanaan Jungle|N|To Vindicator Maraad|; Blackrock Quarry |Z|970;0|
A The Battle of the Forge |QID|34439|M|49.5,14.2|Z|Tanaan Jungle|N|From Cordana Felsong|; Blackrock Quarry |Z|970;0|
C The Battle of the Forge |QID|34439|QO|3/3 Ogron Warcrusher slain|M|40.5,17.5|Z|Tanaan Jungle|; Blackrock Quarry |Z|970;0|
C The Battle of the Forge |QID|34439|QO|15/15 Blackrock Grunt slain|M|43.2,17.4|Z|Tanaan Jungle|; Blackrock Quarry |Z|970;0|
T The Battle of the Forge |QID|34439|M|43.1,26.4|Z|Tanaan Jungle|N|To Farseer Drek'Thar|; Blackrock Quarry |Z|970;0|
A Ga'nar of the Frostwolf |QID|34442|M|43.0,26.4|Z|Tanaan Jungle|N|From Farseer Drek'Thar|; Blackrock Quarry |Z|970;0|
A The Gunpowder Plot |QID|34987|M|44.1,29.6|Z|Tanaan Jungle|N|From Hansel Heavyhands|; Blackrock Quarry |Z|970;0|
A The Shadow of the Worldbreaker |QID|34958|M|44.1,29.7|Z|Tanaan Jungle|N|From Thaelin Darkanvil|; Blackrock Quarry |Z|970;0|
T Ga'nar of the Frostwolf |QID|34442|M|41.7,41.9|Z|Tanaan Jungle|N|To Ga'nar|; Blackrock Quarry |Z|970;0|
A Polishing the Iron Throne |QID|34925|M|41.7,41.9|Z|Tanaan Jungle|N|From Ga'nar|; Blackrock Quarry |Z|970;0|
T Polishing the Iron Throne |QID|34925|M|41.8,42.0|Z|Tanaan Jungle|N|To Ga'nar|; Blackrock Quarry |Z|970;0|
A The Prodigal Frostwolf |QID|34437|M|41.8,42.0|Z|Tanaan Jungle|N|From Ga'nar|; Blackrock Quarry |Z|970;0|
C The Gunpowder Plot |QID|34987|QO|1/1 Blackrock Powder Keg|M|46.9,32.0|Z|Tanaan Jungle|; Blackrock Quarry |Z|970;0|
C The Gunpowder Plot |QID|34987|QO|1/1 Depress the Makeshift Plunger|M|44.0,29.5|Z|Tanaan Jungle|; Blackrock Quarry |Z|970;0|
T The Gunpowder Plot |QID|34987|M|44.1,29.6|Z|Tanaan Jungle|N|To Hansel Heavyhands|; Blackrock Quarry |Z|970;0|
T The Shadow of the Worldbreaker |QID|34958|M|44.1,29.7|Z|Tanaan Jungle|N|To Thaelin Darkanvil|; Blackrock Quarry |Z|970;0|
T The Prodigal Frostwolf |QID|34437|M|43.0,26.4|Z|Tanaan Jungle|N|To Farseer Drek'Thar|; Blackrock Quarry |Z|970;0|
A Taking a Trip to the Top of the Tank |QID|35747|M|43.1,28.7|Z|Tanaan Jungle|N|From Archmage Khadgar|; Blackrock Quarry |Z|970;0|
C Taking a Trip to the Top of the Tank |QID|35747|QO|1/1 Speak with Thaelin|M|44.1,29.7|Z|Tanaan Jungle|; Blackrock Quarry |Z|970;0|
C Taking a Trip to the Top of the Tank |QID|35747|QO|1/1 Gogluk slain|M|37.2,48.0|Z|Tanaan Jungle|; The Path of Glory |Z|970;0|
C Taking a Trip to the Top of the Tank |QID|35747|QO|1/1 Climb the rear chains of the Iron Worldbreaker|M|39.8,48.3|Z|Tanaan Jungle|; The Path of Glory |Z|970;0|
T Taking a Trip to the Top of the Tank |QID|35747|M|40.1,48.4|Z|Tanaan Jungle|N|To Thaelin Darkanvil|; The Path of Glory |Z|970;0|
A A Taste of Iron |QID|34445|M|40.1,48.4|Z|Tanaan Jungle|N|From Thaelin Darkanvil|; The Path of Glory |Z|970;0|
C A Taste of Iron |QID|34445|QO|1/1 Enter the Worldbreaker Side Turret|M|40.1,49.0|Z|Tanaan Jungle|; The Path of Glory |Z|970;0|
C A Taste of Iron |QID|34445|QO|200/200 Iron Horde slain|M|40.2,48.7|Z|Tanaan Jungle|; The Path of Glory |Z|970;0|
C A Taste of Iron |QID|34445|QO|1/1 Press the Main Cannon Trigger|M|40.2,48.3|Z|Tanaan Jungle|; The Path of Glory |Z|970;0|
T A Taste of Iron |QID|34445|M|40.1,48.4|Z|Tanaan Jungle|N|To Thaelin Darkanvil|; The Path of Glory |Z|970;0|
A The Home Stretch |QID|35884|M|40.1,48.4|Z|Tanaan Jungle|N|From Thaelin Darkanvil|; The Path of Glory |Z|970;0|
T The Home Stretch |QID|35884|M|44.4,80.7|Z|Tanaan Jungle|N|To Archmage Khadgar|; Iron Bastion |Z|970;0|
A Step Three: Prophet! |QID|34575|M|44.4,80.7|Z|Tanaan Jungle|N|From Archmage Khadgar|; Iron Bastion |Z|970;0|]]
