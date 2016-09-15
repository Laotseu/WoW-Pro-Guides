
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/mardum_shattered_abyss_source_code
-- Date: 2016-09-14 02:36
-- Who: Ludovicus
-- Log: Deleted duplicate CH

-- URL: http://wow-pro.com/node/3656/revisions/27752/view
-- Date: 2016-09-13 18:26
-- Who: Ludovicus
-- Log: Add proper name to LinksDHArtCH100100

-- URL: http://wow-pro.com/node/3656/revisions/27547/view
-- Date: 2016-08-11 11:23
-- Who: Emmaleah

-- URL: http://wow-pro.com/node/3656/revisions/27546/view
-- Date: 2016-08-11 11:20
-- Who: Emmaleah
-- Log: fix typo "clikcking" corrected Izal's gender, added ClassSpecific Registration to the 3rd (Orgrimmar) guide

-- URL: http://wow-pro.com/node/3656/revisions/27545/view
-- Date: 2016-08-10 06:54
-- Who: Emmaleah
-- Log: Changes only made to the Mardum (1st) guide. Added Item Tags, added NC tags, deleted NC tags so the CHAT tags would show. 

-- URL: http://wow-pro.com/node/3656/revisions/27543/view
-- Date: 2016-08-10 04:34
-- Who: Ludovicus
-- Log: Added Blue items and tweaked for Live instead of Beta.
--	Added support for Vengance DH.

-- URL: http://wow-pro.com/node/3656/revisions/27480/view
-- Date: 2016-07-30 16:02
-- Who: Ludovicus
-- Log: Zone tweaks

-- URL: http://wow-pro.com/node/3656/revisions/27459/view
-- Date: 2016-07-01 02:22
-- Who: Ludovicus
-- Log: Just the usual tweaks.

-- URL: http://wow-pro.com/node/3656/revisions/27458/view
-- Date: 2016-06-30 23:25
-- Who: Ludovicus
-- Log: Add class restriction and icons.

-- URL: http://wow-pro.com/node/3656/revisions/27456/view
-- Date: 2016-06-28 05:32
-- Who: Linkslegend5
-- Log: Finished the DH rough draft, with the Artifact and Class Hall, it ends with picking a zone to start. Only has the DPS spec Artifact, but the recorder didn't get those steps (due to a scenario issue).

-- URL: http://wow-pro.com/node/3656/revisions/27455/view
-- Date: 2016-06-28 02:02
-- Who: Ludovicus
-- Log: Tweaks

-- URL: http://wow-pro.com/node/3656/revisions/27454/view
-- Date: 2016-06-28 00:37
-- Who: Linkslegend5
-- Log: Added Vault of the Warden, the next step after Mardum.

-- URL: http://wow-pro.com/node/3656/revisions/27453/view
-- Date: 2016-06-28 00:34
-- Who: Linkslegend5
-- Log: Wow-Pro Recording of Mardum, the Shattered Abyss.

-- URL: http://wow-pro.com/node/3656/revisions/27449/view
-- Date: 2016-06-28 00:05
-- Who: Ludovicus
-- Log: Initial blank

local guide = WoWPro:RegisterGuide('LinksVault099100', 'Leveling', 'VaultOfTheWardensDH', 'Linkslegend5', 'Neutral')
WoWPro:GuideLevels(guide,99, 100)
WoWPro:GuideName(guide, "Demon Hunter - Vault of the Wardens")
WoWPro:GuideClassSpecific(guide,"DemonHunter")
WoWPro:GuideNextGuide(guide, 'LinksDHArtCH100100')
WoWPro:GuideIcon(guide,"ICON","Interface\\ICONS\\ClassIcon_DemonHunter")
WoWPro:GuideSteps(guide, function()
return [[
A Breaking Out|QID|38672|M|80.09,36.57|N|From Maiev Shadowsong.|
C Breaking Out|QID|38672|NC|QO|2|M|78.56,34.86|N|Free Kayn.|
C Breaking Out|QID|38672|NC|QO|1|M|78.58,38.30|N|Free Altruis.|
T Breaking Out|QID|38672|N|From the Lever.|
;A Vault of the Wardens|QID|39742|M|77.91,35.67|N||
A Rise of the Illidari|QID|38690|M|74.45,35.96|N|From Kayn Sunfury.|
A Fel Infusion|QID|38689|M|74.41,37.19|N|From Altruis the Sufferer.|
C Fel Infusion|QID|38689|S|M|68.84,27.15|N|Kill demons to gain Fel Energy. Look for the Golden dots on the minimap.|
C Rise of the Illidari|QID|38690|NC|M|72.08,31.82|N|Free Imprisoned Illidari.|
C Fel Infusion|QID|38689|US|M|68.84,27.15|N|100/100 Fel Energy regained|
;T Vault of the Wardens|QID|39742|M|71.23,35.63|N|To Savage Felstalker.|
;L Level 100|QID|38689|LVL|100|N|You should be around level 100 by this point.|
T Fel Infusion|QID|38689|M|49.67,49.29|N|To Altruis the Sufferer.|
T Rise of the Illidari|QID|38690|M|49.19,49.46|N|To Kayn Sunfury.|
A Stop Gul'dan!|QID|38723|M|49.47,49.78|N|From Maiev Shadowsong.|
C Stop Gul'dan!|QID|38723|QO|2|M|51.55,78.49|N|Kill Crusher & Sledge|
T Stop Gul'dan!|QID|38723|M|50.78,72.81|N|To Kayn Sunfury.|
A Grand Theft Felbat|QID|39682|M|50.78,72.81|N|From Kayn Sunfury.|
C Grand Theft Felbat|QID|39682|NC|M|0.00,0.00|N|Mount the Vampiric Felbat.|
;h The Demon Ward|QID|39682|M|0.00,0.00|N|At Kor'vas Bloodthorn.|
T Grand Theft Felbat|QID|39682|M|41.3,47.4|N|To Kor'vas Bloodthorn.|Z|Vault of the Wardens;2|
A Frozen in Time|QID|39685|M|41.3,47.4|N|From Kor'vas Bloodthorn.|
A Beam Me Up|QID|39684|M|41.3,47.4|N|From Kor'vas Bloodthorn.|
A Forged in Fire|QID|39683;40254|M|41.1,47.2|N|From Allari the Souleater.|
K Immolanth|QID|39683;40254|T|Immolanth|M|47.0,17.1|N|Kill Immolanth slain and take his power.|
C Beam Me Up|QID|39684|NC|M|69.4,48.4|N|Rotate the Mirror. Watch out for the glowing ball of energy, they will kill you.|
C Activate the Western Countermeasure|QID|39685|NC|QO|3|M|43.58,78.04|
C Activate the Southern Countermeasure|QID|39685|NC|QO|2|M|46.58,84.16|
C Activate the Eastern Countermeasure|QID|39685|NC|QO|1|M|50.16,78.30|
T Frozen in Time|QID|39685|M|41.13,47.17|N|To Allari the Souleater.|
T Beam Me Up|QID|39684|M|41.13,47.17|N|To Allari the Souleater.|
T Forged in Fire|QID|39683;40254|M|41.13,47.17|N|To Allari the Souleater.|
A All The Way Up|QID|39686|M|41.13,47.17|N|From Allari the Souleater.|
C All The Way Up|QID|39686|NC|M|46.8,47.9|N|Ascend to the Hall of Judgment|
;h The Warden's Court|QID|39686|M|24.42,55.86|N|At Kor'vas Bloodthorn.|
T All The Way Up|QID|39686|M|24.42,55.86|N|To Kor'vas Bloodthorn.|Z|Vault of the Wardens;3|
A A New Direction|QID|40373|M|24.42,55.86|N|From Kor'vas Bloodthorn.|
C View the Pool of Judment|QID|40373|NC|QO|1|M|24.43,51.48|
C Choose between Kayn and Altruis|QID|40373|CHAT|QO|2|M|24.43,55.72|N|The choice is just for flovor. There is only customic game impact.|
T A New Direction|QID|40373|M|24.43,55.72|N|To Kor'vas Bloodthorn.|
A Between Us and Freedom|QID|39688;39694;40255;40256|M|24.43,55.72|N|From Kor'vas Bloodthorn.|
K Bastillax|QID|39688;39694;40255;40256|T|Bastillax|M|50.78,78.24|N|Kill Bastillax and take his power.|Z|Vault of the Wardens;3|
T Between Us and Freedom|QID|39688;39694;40255;40256|M|84.04,82.82|N|To Altruis the Sufferer.|
A Illidari, We Are Leaving|QID|39689;39690|M|85.99,84.31|N|From Archmage Khadgar.|
T Illidari, We Are Leaving|QID|39689;39690|M|85.9,74.3|

A The Call of War |QID|39691|M|72.6,47.0|Z|Stormwind City|N|From Archmage Khadgar|FACTION|Alliance|
C The Call of War |QID|39691|NC|M|84.3,34.3|FACTION|Alliance|
T The Call of War |QID|39691|M|84.4,33.7|Z|Stormwind City|N|To Jace Darkweaver|FACTION|Alliance|
A Second Sight |QID|44471|M|84.4,33.7|Z|Stormwind City|N|From Jace Darkweaver|FACTION|Alliance|
T Second Sight |QID|44471|M|84.4,33.7|Z|Stormwind City|N|To Jace Darkweaver|FACTION|Alliance|
A Demons Among Them |QID|44463|M|84.4,33.7|Z|Stormwind City|N|From Jace Darkweaver|FACTION|Alliance|
C Demons Among Them |QID|44463|CHAT|QO|1|M|85.9,31.6|N|Warn King Anduin Wrynn|Z|Stormwind City|FACTION|Alliance|
C Demons Among Them |QID|44463|QO|2|M|81.3,25.7|N|Use your Spectral Sight to find demons and kill them.|Z|Stormwind City|FACTION|Alliance|
T Demons Among Them |QID|44463|M|85.7,31.8|Z|Stormwind City|N|To Anduin Wrynn|FACTION|Alliance|
A A Weapon of the Alliance |QID|44473|M|85.7,31.8|Z|Stormwind City|N|From Anduin Wrynn|FACTION|Alliance|
T A Weapon of the Alliance |QID|44473|M|40.3,77.7|Z|Stormwind City|N|To Elerion Bladedancer|FACTION|Alliance|
A Protect the Home Front |QID|40661|M|40.3,77.7|Z|Stormwind City|N|From Elerion Bladedancer|FACTION|Alliance|

A Audience with the Warchief |QID|40976|M|52.6,88.4|Z|Orgrimmar|N|From Archmage Khadgar|FACTION|Horde|; Gates of Orgrimmar |Z|321;1|
C Audience with the Warchief |QID|40976|QO|1|M|50.1,76.1|Z|Orgrimmar|FACTION|Horde|; Valley of Strength |Z|321;1|
C Audience with the Warchief |QID|40976|QO|2|M|50.1,76.1|Z|Orgrimmar|FACTION|Horde|; Valley of Strength |Z|321;1|
T Audience with the Warchief |QID|40976|M|45.8,15.1|Z|Durotar|N|To Allari the Souleater|FACTION|Horde|; The Dranosh'ar Blockade |Z|4;0|
A Second Sight |QID|40982|M|45.8,15.1|Z|Durotar|N|From Allari the Souleater|FACTION|Horde|; The Dranosh'ar Blockade |Z|4;0|
T Second Sight |QID|40982|M|45.8,15.1|Z|Durotar|N|To Allari the Souleater|FACTION|Horde|; The Dranosh'ar Blockade |Z|4;0|
A Demons Among Them |QID|40983|M|45.8,15.1|Z|Durotar|N|From Allari the Souleater|FACTION|Horde|; The Dranosh'ar Blockade |Z|4;0|
C Demons Among Them |QID|40983|QO|1|M|45.8,15.1|Z|Durotar|N|Kill 12 demons.|FACTION|Horde|
T Demons Among Them |QID|40983|M|45.6,15.9|Z|Durotar|N|To Lady Sylvanas Windrunner|FACTION|Horde|; The Dranosh'ar Blockade |Z|4;0|
A A Weapon of the Horde |QID|41002|M|45.6,15.9|Z|Durotar|N|From Lady Sylvanas Windrunner|FACTION|Horde|; The Dranosh'ar Blockade |Z|4;0|
T A Weapon of the Horde |QID|41002|M|52.9,56.7|Z|Orgrimmar|N|To Elthyn Da'rai|FACTION|Horde|; Valley of Strength |Z|321;1|
A Protect the Home Front |QID|44092|M|52.9,56.7|Z|Orgrimmar|N|From Elthyn Da'rai|FACTION|Horde|; Valley of Strength |Z|321;1|
]]
end)



