
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/alliance_shadowmoon_valley_draenor_source_code
-- Date: 2014-10-09 15:04
-- Who: Fluclo
-- Log: Moved Hexcloth quest to an earlier opportunity to finish it.

-- URL: http://wow-pro.com/node/3604/revisions/26709/view
-- Date: 2014-10-09 14:04
-- Who: Fluclo
-- Log: Friendly Competition now lootable without the skinning profession

-- URL: http://wow-pro.com/node/3604/revisions/26703/view
-- Date: 2014-10-01 01:29
-- Who: Fluclo

-- URL: http://wow-pro.com/node/3604/revisions/26700/view
-- Date: 2014-09-29 21:06
-- Who: Fluclo

-- URL: http://wow-pro.com/node/3604/revisions/26699/view
-- Date: 2014-09-29 21:06
-- Who: Fluclo

local guide = WoWPro:RegisterGuide('ShadowDraenor', "Leveling", 'Shadowmoon Valley@Draenor', 'Fluclo', 'Alliance')
WoWPro:GuideLevels(guide,90,92,90)
WoWPro:GuideNextGuide(guide, 'XXXX')
WoWPro:GuideSteps(guide, function()
return [[

L Level 90 |QID|34575|LVL|90|N|This guide requires a minimum level of 90 to do.|
N Getting to Shadowmoon Valley (Draenor) |QID|34575|N|To get to Shadowmoon Valley (Draenor), you will first need to complete the Assault on the Dark Portal in Tanaan Jungle. Please work through that guide instead.|LEAD|35884|

A Step Three: Prophet! |QID|34575|N|Auto-Accepted|
T Step Three: Prophet! |QID|34575|N|To Prophet Velen|M|27.0,8.1|

A Finding a Foothold |QID|34582|N|From Prophet Velen|PRE|34575|M|27.0,8.1|
C Finding a Foothold |QID|34582|N|Head to Lunarfall, the location of your new garrison.|NC|M|28.8,16.2|
T Finding a Foothold |QID|34582|N|To Vindicator Maraad|M|28.8,16.2|

A For the Alliance! |QID|34583|N|From Vindicator Maraad|PRE|34582|M|28.8,16.2|
C For the Alliance! |QID|34583|N|Click on the outline of the Alliance Banner, then wait for the portal to open and your friends to come through.|NC|M|29.0,16.1|
T For the Alliance! |QID|34583|N|To Baros Alexston|M|29.0,16.2|

A Looking for Lumber |QID|34584|N|From Baros Alexston|M|29.0,16.2|PRE|34583|
A Ravenous Ravens |QID|34616|N|From Baros Alexston|M|29.0,16.2|PRE|34583|
C Ravenous Ravens |QID|34616|N|Kill the Lunarfall Ravens|S|M|29.1,17.8|
C Looking for Lumber |QID|34584|N|Click on the flag shadows to mark the trees.|NC|M|29.1,17.8|
C Ravenous Ravens |QID|34616|N|Finish killing the Lunarfall Ravens|US|M|29.1,17.8|
T Looking for Lumber |QID|34584|N|From Baros Alexston|M|29.0,16.2|
T Ravenous Ravens |QID|34616|N|From Baros Alexston|M|29.0,16.2|

A Quakefist |QID|34585|N|From Yrel|M|28.9,16.4|PRE|34584+34616|
C Quakefist |QID|34585|N|Kill Quakefist, who can be found inside the cave.|M|30.1,21.8|
T Quakefist |QID|34585|N|To Yrel|M|28.9,16.4|

A Establish Your Garrison|QID|34586|N|From Baros Alexston|M|29.0,16.2|PRE|34585|
C Establish Your Garrison|QID|34586|N|Speak to Baros Alexston and tell him you have everything, and build the garrison.|CHAT|M|29.0,16.2|
f Lunarfall |QID|34586|N|With Dungar Longdrink.|PRE|34585|M|47.8,49.8|Z|Lunarfall|
T Establish Your Garrison|QID|34586|N|To Baros Alexston|M|41.4,49.2|Z|Lunarfall|

A Keeping it Together |QID|35176|N|From Baros Alexston|PRE|34586|M|41.4,49.2|Z|Lunarfall|
A Ship Salvage|QID|35166|N|From Baros Alexston|PRE|34586|M|41.4,49.2|Z|Lunarfall|
A Pale Moonlight |QID|35174|N|From Vindicator Maraad|PRE|34586|M|44.0,53.5|Z|Lunarfall|

C Keeping it Together |QID|35176|N|Speak to Assistant Brightstone and tell her it's time to get back to work.|QO|1|CHAT|M|45.0,53.6|Z|Lunarfall|
C Keeping it Together |QID|35176|N|Open the Garrison Cache.|QO|3|NC|M|49.3,43.4|Z|Lunarfall|
C Keeping it Together |QID|35176|N|Head to Shelly Harnby (outside the garrison) and gather her report.|QO|2|CHAT|M|32.6,34.4|Z|Lunarfall|

C Pale Moonlight |QID|35174|N|Kill and loot the Pale Devourers|S|QO|2|
C Ship Salvage|QID|35166|N|Loot the Drudgeboat Salvage from the floor or from the Pale Devourers|S|NC|
C Pale Moonlight |QID|35174|N|Head down to Eventide Landing and kill Gnaw Bloodseeker|QO|1|M|25.5,5.5|
C Ship Salvage|QID|35166|N|Finish looting the Drudgeboat Salvage from the floor or from the Pale Devourers|US|NC|M|26.5,6.5|
C Pale Moonlight |QID|35174|N|Finish killing the Pale Devourers|US|QO|2|M|26.5,6.5|

T Pale Moonlight |QID|35174|N|To Vindicator Maraad\n\nUse your Garrison Hearthstone to get back to the garrison.|U|110560|M|44.0,53.5|Z|Lunarfall|
T Keeping it Together |QID|35176|N|To Baros Alexston|M|41.4,49.2|Z|Lunarfall|
T Ship Salvage|QID|35166|N|To Baros Alexston|M|41.4,49.2|Z|Lunarfall|

A Build Your Barracks |QID|34587|N|From Baros Alexston|PRE|35174;35176;35166|M|41.4,49.2|Z|Lunarfall|
C Build Your Barracks |QID|34587|N|Loot the Barracks Blueprints from the floor of the construction site.|QO|1|NC|M|45.4,40.2|Z|Lunarfall|
C Build Your Barracks |QID|34587|N|Click on the Barracks Blueprints to learn it.|QO|2|U|111956|NC|
C Build Your Barracks |QID|34587|N|Click on the Architect Table, then drag the Barracks icon to the Large Empty Plot.|QO|3|NC|M|41.2,48.9|Z|Lunarfall|
C Build Your Barracks |QID|34587|N|Go back to the Barracks construction site, and click on the scroll to Finalize Garrison Plot|QO|4|NC|M|44.6,43.5|Z|Lunarfall|
T Build Your Barracks |QID|34587|N|To Vindicator Maraad|M|44.0,53.5|Z|Lunarfall|

A Qiana Moonshadow |QID|34646|N|From Vindicator Maraad|PRE|34587|M|44.0,53.5|Z|Lunarfall|
C Qiana Moonshadow |QID|34646|N|Head to Qiana Moonshadow in Moonflower Valley (south of your garrison) and click on her.|NC|
T Qiana Moonshadow |QID|34646|N|To Qiana Moonshadow (she's now at to your garrison)|M|40.5,53.9|Z|Lunarfall|

A Delegating on Draenor |QID|34692|N|From Lieutenant Thorn|PRE|34646|M|40.3,53.6|Z|Lunarfall|
C Delegating on Draenor |QID|34692|N|Click on the Command Table, then send Qiana Moonshadow on the mission.|NC|M|40.4,53.6|Z|Lunarfall|
T Delegating on Draenor |QID|34692|N|To Lieutenant Thorn|M|40.3,53.6|Z|Lunarfall|

A Migrant Workers |QID|34778|N|From Vindicator Maraad|PRE|34692|M|44.0,53.5|Z|Lunarfall|
C Migrant Workers |QID|34778|N|Speak with Zipfizzle and tell him to Move Out.|CHAT|M|44.2,51.0|Z|Lunarfall|

A Hero's Welcome |QID|33075|N|From Yrel|PRE|34692|M|47.2,50.9|Z|Lunarfall|

A Wanted: Kuu'rat's Tusks |QID|33833|N|From the notice board in Moonflower Valley. This is a 3-party group quest.|M|33.2,30.7|RANK|3|
C Wanted: Kuu'rat's Tusks |QID|33833|N|Kill Kuu'rat, and loot the tusks. This is flagged as a 3-party group quest. Don't forget to use your newly acquired Call to Arms to aid you in the battle.|M|34.6,26.9|RANK|3|
T Wanted: Kuu'rat's Tusks |QID|33833|N|To Eremor in Embaari Village|RANK|3|M|45.5,37.7|

f Embaari Village |QID|33075|N|With Eonor|M|45.7,38.8|
C Hero's Welcome |QID|33075|N|Find Samaara at Embaari Village|M|46.1,38.9|NC|
T Hero's Welcome |QID|33075|N|To Samaara|M|46.1,38.9|

A Dark Enemies |QID|33765|N|From Samaara|M|46.1,38.9|PRE|33075|
A Think of the Children! |QID|33070|N|From Efee|M|46.6,37.7|PRE|33075|
A Closing the Door |QID|33905|N|From Vindicator Tenuum|M|46.6,37.3|PRE|33075|

C Dark Enemies |QID|33765|N|Kill the Shadowmoon Voidmancers|S|
C Closing the Door |QID|33905|N|Kill the Shadowmoon Portalmasters around the void portals to disable them.|M|46.6,37.3|S|
C Think of the Children! |QID|33070|N|Save Hakaam from inside the burning hut in Arbor Glen|QO|1|M|49.0,30.9|CHAT|

A In Need of a Hero |QID|33813|N|From Ariaana|M|52.0,32.7|ACTIVE|33070|
C In Need of a Hero |QID|33813|N|Grab a Draenei Bucket from outside the hut, then go back in and use it on the Floor Fire|QO|2|NC|
C In Need of a Hero |QID|33813|N|Grab a Draenei Bucket from outside the hut, then go back in and use it on the Bookshelf Fire|QO|1|NC|
C In Need of a Hero |QID|33813|N|Grab a Draenei Bucket from outside the hut, then go back in and use it on the Table Fire|QO|3|NC|
T In Need of a Hero |QID|33813|N|To Ariaana|M|52.0,32.7|

C Think of the Children! |QID|33070|N|Complete the quest In Need of a Hero to save Ariaana|QO|3|NC|
C Think of the Children! |QID|33070|N|Save Rastaak from inside the burning hut in Arbor Glen|QO|2|CHAT|M|52.0,36.0|
C Closing the Door |QID|33905|N|Finish closing the void portals by killing the Shadowmoon Portalmasters around a void portals.|M|52.5,36.5|US|
C Dark Enemies |QID|33765|N|Finish killing the Shadowmoon Voidmancers as you head back to Teluuna Observatory|US|M|51.3,38.9|

T Think of the Children! |QID|33070|N|To Prophet Velen at Teluuna Observatory.|M|49.1,38.5|
T Dark Enemies |QID|33765|N|To Prophet Velen.|M|49.1,38.5|
T Closing the Door |QID|33905|N|To Prophet Velen|M|49.1,38.5|

A Shadows Awaken |QID|34019|N|From Prophet Velen|M|49.1,38.5|PRE|33765;33070;33905|
C Shadows Awaken |QID|34019|N|Head into the centre of the observatory and wait for Ner'zhul to spawn Karnoth|M|49.3,37.4|NC|QO|1|
C Shadows Awaken |QID|34019|N|Kill and loot Karnoth.|M|49.4,37.0|

A The Mysterious Flask|QID|35342|N|Loot the Mysterious Flask from Karnoth, and use it to begin the quest.|U|113103|P|Alchemy;171;*;1;700|
A The Strength of Iron|QID|36309|N|Loot Haephest's Satchel from Karnoth, and use it to begin the quest.|U|115343|P|Blacksmithing;164;*;1;700|
A Enchanted Highmaul Bracer|QID|36308|N|Loot the Enchanted Highmaul Bracer from Karnoth, and use it to begin the quest.|U|115281|P|Enchanting;333;*;1;700|
A Gnomish Location Transponder|QID|36286|N|Loot the Gnomish Location Transponder from Karnoth, and use it to begin the quest.|U|115278|P|Engineering;202;*;1;700|
A A Mysterious Satchel|QID|36239|N|Loot the Mysterious Satchel from Karnoth, and use it to begin the quest.|U|114984|P|Inscription;773;*;1;700|
A A Power Lost|QID|36408|N|Loot the Drained Crystal Fragment from Karnoth, and use it to begin the quest.|U|115507|P|Jewelcrafting;755;*;1;700|
A A Call for Huntsman|QID|36176|N|Loot the Dirty Note from Karnoth, and use it to begin the quest.|U|114877|P|Leatherworking;164;*;1;700|
A The Cryptic Tome of Tailoring|QID|36236|N|Loot the Cryptic Tome of Tailoring Note from Karnoth, and use it to begin the quest.|U|114972|P|Tailoring;197;*;1;700|

T Shadows Awaken |QID|34019|N|To Prophet Velen|M|49.3,37.4|
A Into Twilight |QID|33072|N|From Prophet Velen|M|49.3,37.4|PRE|34019|
A The Southern Wilds |QID|35444|N|From Farmer Gehaar|M|49.1,38.6|PRE|34019|

H Lunarfall |QID|33814|N|Use your Garrison Hearthstone, or fly back to your garrison.|U|110560|ACTIVE|35342|
T The Mysterious Flask|QID|35342|M|47.69,45.39|Z|Lunarfall|N|To Aenir.|ACTIVE|35342|
A The Young Alchemist|QID|35343|M|47.69,45.39|Z|Lunarfall|N|From Aenir.|PRE|35342|
F Embaari Village |QID|35343|N|Fly back to Embaari Village|ACTIVE|35343|

T The Young Alchemist|QID|35343|M|55.85,41.15|N|To Abatha.|
A The Missing Father|QID|35344|M|55.85,41.15|N|From Abatha.|PRE|35343|
T The Missing Father|QID|35344|M|54.02,45.75|N|To Telos.|

A Shocking Assistance|QID|35345|M|54.02,45.75|N|From Telos.|PRE|35344|
C Shocking Assistance|QID|35345|M|54.0,45.5|N|Kill and loot the Shockscale Eel for the Shockscales.|
T Shocking Assistance|QID|35345|M|55.85,41.18|N|To Abatha.|

T A Call for Huntsman |QID|36176|N|To Fanara in Embaari Village.|M|44.2,40.9|ACTIVE|36176|
A Friendly Competition |QID|36177|N|From Fanara in Embaari Village.|M|44.2,40.9|PRE|36176|
C Friendly Competition |QID|36177|N|Kill and loot the Shadowmoon Stalkers.|M|44.0,42.0|S|QO|1|
C Friendly Competition |QID|36177|N|Kill and loot the Silverwing Kaliri|M|45.0,30.0|QO|2|
C Friendly Competition |QID|36177|N|Kill and loot the Shadowmoon Stalkers.|M|44.0,42.0|US|QO|1|
T Friendly Competition |QID|36177|N|To Fanara in Embaari Village.|M|44.2,40.9|

A Fair Trade |QID|36185|N|From Fanara in Embaari Village.|M|44.2,40.9|PRE|36177|
T Fair Trade |QID|36185|N|To Garaal|M|45.0,39.2|

T A Power Lost|QID|36408|N|To Artificer Baleera in Embaari Village|M|47.0,38.7|ACTIVE|36408|
A Restoration |QID|36409|N|From Artificer Baleera|M|47.0,38.6|PRE|36408|
C Restoration |QID|36409|N|Kill Morakh Chillwhisper, and loot the Empowered Crystal|M|50.5,20.1|
T Restoration |QID|36409|N|To Artificer Baleera|M|47.0,38.6|

T The Strength of Iron|QID|36309|N|To Haephest in Embaari Village|M|45.2,38.9|ACTIVE|36309|
A Father and Son|QID|36311|N|From Haephest|M|45.2,38.9|PRE|36309|
C Father and Son|QID|36311|N|Speak to Duna at Arbor Glen|M|51.1,37.0|CHAT|
T Father and Son|QID|36311|N|To Haephest|M|45.2,38.9|

H Lunarfall |QID|33814|N|Use your Garrison Hearthstone, or fly back to your garrison.|U|110560|ACTIVE|36236|
T The Cryptic Tome of Tailoring|QID|36236|M|43.0,54.9|Z|Lunarfall|N|To Aerun.|ACTIVE|36236|
A Ameeka, Master Tailor|QID|36262|M|43.0,54.9|Z|Lunarfall|N|From Aerun.|PRE|36236|
F Embaari Village |QID|36262|N|Fly to Embaari Village|ACTIVE|36262|

T Migrant Workers |QID|34778|N|To Foreman Zipfizzle|M|56.0,32.6|
A Circle the Wagon |QID|34779|N|From Foreman Zipfizzle|M|56.0,32.6|PRE|34778|

C Circle the Wagon |QID|34779|N|Locate the missing wagon in Saraah's Vale.|NC|M|51.2,28.4|QO|1|
C Circle the Wagon |QID|34779|N|Defend the wagon from the Shadowmoon Raiders|M|51.2,28.4|QO|2|
C Circle the Wagon |QID|34779|N|Follow Maraad through Saraah's Vale and Elodor Fields. There will be two ambushes during the escort.|QO|3|
T Circle the Wagon |QID|34779|N|To Exarch Akama|M|56.0,32.8|

A Invisible Ramparts |QID|34780|N|From Exarch Hataaru|M|56.2,32.6|PRE|34779|
N Charged Resonance Crystal |QID|34780|N|Pick up a Charged Resonance Crystal|BUFF|161644|M|56.8,34.2|NC|ACTIVE|34780|
C Primary Pilon |QID|34780|N|Carry the crystal to primary pylon|QO|1|M|56.2,32.8|NC|
C Secondary Pylon |QID|34780|N|Pick up a second Charged Resonance Crystal, and carry the crystal to secondary pylon|QO|2|M|56.6,33.1|NC|
C Tertiary Pylon |QID|34780|N|Pick up a third Charged Resonance Crystal, and carry the crystal to tertiary pylon|QO|3|M|56.2,33.4|NC|
T Invisible Ramparts |QID|34780|N|To Defense Pylon Central Control Console, inside the building.|M|56.9,34.7|

A Defenstrations |QID|34781|N|From Defense Pylon Central Control Console|PRE|34780|M|56.9,34.7|
C Defenstrations |QID|34781|N|Head outside and kill the Shadowmoon invaders.|
T Defenstrations |QID|34781|N|To Defense Pylon Central Control Console.|M|56.94,34.71|

A The Exarch Council |QID|34782|N|From Vindicator Maraad\n(Don't worry about the Fungal Giant Elite, he won't attack you)|M|56.2,32.4|PRE|34781|

T Gnomish Location Transponder|QID|36286|N|To Goggles|M|60.9,32.6|ACTIVE|36286|
A Snatch 'n' Grab|QID|36287|N|From Goggles|M|60.9,32.6|PRE|36286|
C Snatch 'n' Grab|QID|36287|N|Obtain the Pilfered Parts from Moonlit Shore|NC|M|66.9,27.5|
T Snatch 'n' Grab|QID|36287|N|To Goggles|M|60.9,32.6|PRE|36286|

T Ameeka, Master Tailor|QID|36262|N|To Ameeka in Elodor.|M|58.2,26.5|
A The Clothes on Their Backs|QID|36266|N|From Ameeka.|PRE|36262|M|58.2,26.5|
T The Exarch Council |QID|34782|N|To Exarch Othaar, follow road up to Elodor.|M|59.4,26.6|

A Naielle, The Rangari |QID|34783|N|From Exarch Othaar|M|59.4,26.6|PRE|34782|
A Hataaru, the Artificer |QID|34785|N|From Exarch Othaar|M|59.4,26.6|PRE|34782|

T Naielle, The Rangari |QID|34783|N|To Exarch Naielle in Rangari Enclave|M|56.5,23.5|

A Fun with Fungus |QID|34784|N|From Exarch Naielle|M|56.5,23.5|PRE|34783|
A The Sting |QID|34790|N|From Rangari Chel|M|56.7,23.0|PRE|34782|

T A Mysterious Satchel|QID|36239|N|To Sha'la|M|57.8,21.4|
A Slow and Steady|QID|36240|N|From Sha'la|M|57.8,21.4|PRE|36239|
C Slow and Steady|QID|36240|N|Loot Toxic Umbrafen Herbs from the Moonglow Sporebats and Umbraspore Giants|M|55.2,21.0|S|

C The Sting |QID|34790|N|Kill and loot the Moonglow Sporebats to find a Pristine Sporebat Stinger|S|
N Shimmershroom|QID|34790|N|Pick up a Shimmershroom from the floor around Umbrafen|BUFF|165892|ACTIVE|34790|
C Fun with Fungus |QID|34784|N|Collect the Volatile Spore whilst they are green (with the Shimmershroom buff). If they turn red, find another Shimmershroom.|NC|
C The Sting |QID|34790|N|Finish killing and looting the Moonglow Sporebats until you find a Pristine Sporebat Stinger|US|

C Slow and Steady|QID|36240|N|Finish looting the Toxic Umbrafen Herbs from the Moonglow Sporebats and Umbraspore Giants.|M|55.2,21.0|US|
T Slow and Steady|QID|36240|N|To Sha'la|M|57.8,21.4|
A The Power of Preservation|QID|36241|N|From Sha'la|M|57.8,21.4|PRE|36240|
T The Power of Preservation|QID|36241|N|To Ardule D'na|M|58.2,20.8|

T The Sting |QID|34790|N|To Rangari Chel|M|56.7,23.0|
T Fun with Fungus |QID|34784|N|To Exarch Naielle|M|56.5,23.5|

T Hataaru, the Artificer |QID|34785|N|To Exarch Hataaru outside the Elodor Dig|M|61.9,29.7|
A Shut'er Down |QID|35070|N|From Exarch Hataaru|PRE|34785|M|61.9,29.7|PRE|34785|
A Engorged Goren |QID|34786|N|From Apprentice Artificer Andren|M|61.9,29.1|PRE|34782|

C Engorged Goren |QID|34786|N|Kill and loot the Crystalmaw Goren and Spitters until you have 20 Crystallized Goren Scales|S|M|63.5,26.3|
C Shut'er Down |QID|35070|N|Disable the Crystal with the Override Level|NC|M|64.4,26.2|
C Engorged Goren |QID|34786|N|Finish killing and looting the Crystalmaw Goren and Spitters until you have 20 Crystallized Goren Scales|US|M|63.5,26.3|

T Engorged Goren |QID|34786|N|To Apprentice Artificer Andren|M|61.9,29.1|
T Shut'er Down |QID|35070|N|To Exarch Hataaru|M|61.9,29.7|
A Exarch Maladaar |QID|34787|N|From Exarch Akama|M|61.9,29.6|PRE|35070|

T Exarch Maladaar |QID|34787|N|To Exarch Maladaar on Fey Landing.|M|59.5,30.4|
A Trust No One |QID|35552|N|From Exarch Maladaar.|M|59.5,30.4|PRE|34787|
C Trust No One |QID|35552|N|Follow the trail to the Infiltrator's Hideout.|M|61.3,24.8|NC|
T Trust No One |QID|35552|N|To Shadow Council Tome of Curses.|M|60.9,24.4|

A Warning the Exarchs |QID|34791|N|From Shadow Council Tome of Curses.|M|60.9,24.4|PRE|35552|
T Warning the Exarchs |QID|34791|N|To Exarch Maladaar at Altar of Sha'tar.|M|62.5,26.3|

A Speaker for the Dead |QID|34789|N|From Exarch Maladaar|M|62.5,26.3|PRE|34791|
C Speaker for the Dead |QID|34789|N|Head to the back of the Altar of Sha'tar, and tell Exarch Maladaar that you are ready to begin.|QO|1|M|66.4,26.2|CHAT|
C Speaker for the Dead |QID|34789|N|Defend Hataaru's Spirit by killing Shrakun then a few Tormentor Imps that spawn.|QO|2|M|66.4,26.2|
T Speaker for the Dead |QID|34789|N|To Exarch Maladaar|M|66.4,26.2|

;If you've just finished the above quest, the next quest can be picked up at your current location, but if you've abandoned and returned, the quest giver is at 62.6,26.2 hence the M coords.
A The Traitor's True Name |QID|34792|N|From Exarch Maladaar|M|62.6,26.2|PRE|34789|
C The Traitor's True Name |QID|34792|N|Follow the path to the top of Exarch's Rise, and Plant the Focusing Lens|QO|1|NC|M|60.8,20.5|
C The Traitor's True Name |QID|34792|N|Wait for Exarch Othaar to turn red, then kill him|QO|2|M|60.6,20.6|
C The Traitor's True Name |QID|34792|N|Kill Socrethar|QO|3|M|60.6,20.6|
T The Traitor's True Name |QID|34792|N|To Exarch Maladaar at the Altar of Sha'tar|M|62.6,26.2|

A Friend of the Exarchs |QID|34788|N|From Exarch Naielle|PRE|34792|M|62.5,26.2|PRE|34792|
C Friend of the Exarchs |QID|34788|N|Choose a follower.\n\n- Andren is good for Danger Zones and Engineering. \n- Chel is good for Minion Swarms and Leatherworking. \n- Onaala is good for Wild Aggression and Blacksmithing.|NC|
T Friend of the Exarchs |QID|34788|N|To Exarch Naielle|M|62.5,26.2|

A Supply Drop |QID|35905|N|From Exarch Naielle|PRE|34788|M|62.5,26.2|PRE|34788|

f Fey Landing |QID|35552|N|With Vamuun.|M|58.7,31.9|
F Embaari Village|QID|33072|N|Fly to Embaari Village|ACTIVE|33072|M|40.5,54.9|
R Twilight Glade|QID|33072|N|Run south through The Nightmarsh to Twilight Glade.|ACTIVE|33072|M|40.5,54.9|
f Twilight Glade |QID|33072|N|With Gotuun|M|40.7,55.3|

T Into Twilight |QID|33072|N|To Prophet Velen at Twilight Glade|M|40.5,54.9|
A The Clarity Elixir |QID|33076|N|From Prophet Velen|PRE|33072|M|40.5,54.9|

A Loola's Lost Love |QID|34876|N|From Old Loola|M|41.3,55.1|
A A Grandmother's Remedy |QID|33077|N|From Old Loola|M|41.3,55.1|

C Swamplighter Dust |QID|33076|N|Kill and loot the Frenzied Swamplighters for the Swamplighter Dust|QO|1|S|M|45.0,51.0|
C Engorged Heart |QID|33076|N|Kill and loot the Echidnian Hydra for their Engorged Heart|QO|2|S|M|45.0,51.0|
C Loola's Lost Love |QID|34876|N|Click on the loose mud to seach it|NC|S|M|45.0,51.0|
C A Grandmother's Remedy |QID|33077|N|Click on the Belly Toad to squeeze a Vial of Toad Juice|S|NC|M|45.0,51.0|

A Rangari Roundup |QID|34897|N|From Rangari Navra.\nNote: You will have to click Rangari Navra for the quest to be made available.|M|43.7,51.7|
C Rangari Roundup |QID|34897|N|Find Hidden Rangari|S|NC|
C The Clarity Elixir |QID|33076|N|Collect the Pristine Star Lily, this can be found inside the tree in Nightmarsh.|QO|3|NC|M|47.3,52.1|

C A Grandmother's Remedy |QID|33077|N|Finish squeezing the Vial of Toad Juice out of the Belly Toads.|US|NC|M|45.0,51.0|
C Loola's Lost Love |QID|34876|N|Finish searching the loose mud|NC|US|M|45.0,51.0|
C Rangari Roundup |QID|34897|N|Finish finding the Hidden Rangari|US|NC|CN|M|47.1,53.1;46.4,51.6;45.0,50.4;44.8,51.2;43.9,52.7|
C Engorged Heart |QID|33076|N|Finish killing and looting the Echidnian Hydra for their Engorged Heart|QO|2|US|M|45.0,51.0|
C Swamplighter Dust |QID|33076|N|Finish killing and looting the Frenzied Swamplighters for the Swamplighter Dust, there are loads of them up Moonwillow Peak (which will also be the quest turn-in area)|QO|1|US|M|36.8,51.7|
T The Clarity Elixir |QID|33076|N|To Prophet Velen in Moonwillow Peak|M|35.3,49.1|

A The Fate of Karabor |QID|33059|N|From Prophet Velen|M|35.3,49.1|PRE|33076|
C The Fate of Karabor |QID|33059|N|Click on the Clarity Elixir to drink it|M|35.3,49.1|QO|1|NC|
C The Fate of Karabor |QID|33059|N|Follow through the Scenario steps to witness the fate of Karabor.\n\n1. Move forward with Prophet Velen to Yrel's position\n2. Kill Krull\n3. Run up the stairs, wait for Prophet Velen to run up the stairs, then tell him we're being overrun.\n(Undismissed pets will die at this point)|M|35.3,49.1|QO|2|

T The Fate of Karabor |QID|33059|N|To Prophet Velen, in Twilight Glade. \n(Recall/revive your pet if appropriate)|M|40.5,54.9|
T Rangari Roundup |QID|34897|N|To Rangari Veka|M|40.6,54.8|
A Going Undercover |QID|33080|N|From Rangari Veka|PRE|33072|M|40.6,54.8|
T A Grandmother's Remedy |QID|33077|N|To Old Loola|M|41.3,55.1|
T Loola's Lost Love |QID|34876|N|To Old Loola|M|41.3,55.1|

C Going Undercover |QID|33080|N|Speak to Sylene and ask for a Shadowmoon orc illusion.|QO|1|M|40.7,54.6|CHAT|

A The Dark that Blinds Us |QID|33078|N|From Loreseeker Heidii|M|42.1,57.4|
C The Dark that Blinds Us |QID|33078|N|Click the Western stone to get a rubbing|QO|3|NC|M|43.7,60.5|
C The Dark that Blinds Us |QID|33078|N|Click the Northern stone to get a rubbing|QO|2|NC|M|44.5,59.1|
C The Dark that Blinds Us |QID|33078|N|Click the Eastern stone to get a rubbing|QO|1|NC|M|45.2,60.5|
C The Dark that Blinds Us |QID|33078|N|Click the Southern stone to get a rubbing|QO|4|NC|M|44.5,63.9|
T The Dark that Blinds Us |QID|33078|N|To Loreseeker Heidii|M|42.1,57.4|

C Going Undercover |QID|33080|N|Head up into Shaz'gul, and click on the explosives inside the supply hut. Whilst in Shaz'gul, you will have a disguise that only the Void Occulus and Void Wolf can see through, so avoid any mob with void in their name. \n\nIf you need to get past a Void Wolf, you can pick up a Tasty Meat and throw it near them. To get past the Void Occulus, use a Void Touched Pumpkin.|QO|2|M|37.2,59.3|NC|
C Going Undercover |QID|33080|N|Click the explosives inside the main lodge (and to the right)|QO|3|NC|M|36.4,61.4|NC|
C Going Undercover |QID|33080|N|Head up into Shaz'gul, and click on the explosives at chieftain's seat.|QO|4|M|39.1,62.9|NC|
C Going Undercover |QID|33080|N|Click the explosives at the training pit|QO|5|M|36.6,65.5|NC|

T Going Undercover |QID|33080|N|To Yrel|M|34.2,63.2|
A Escape From Shaz'gul |QID|33081|N|From Yrel|M|34.2,63.2|PRE|33080|

C Escape From Shaz'gul |QID|33081|N|Speak to Yrel and select any two chat lines to inspire her.|QO|1|CHAT|M|34.2,63.2|
C Escape From Shaz'gul |QID|33081|N|Escort Yrel out of Shaz'gul, a number of mobs will spawn at various points.|QO|2|M|39.2,57.5|

T Escape From Shaz'gul |QID|33081|N|To Yrel, now in Twilight Glade.|M|40.6,54.9|
A Chasing Shadows |QID|33586|N|From Prophet Velen|M|40.5,54.9|PRE|33081|
A Fast Expansion|QID|33814|M|40.65,54.87|N|From Scout Valdez.|PRE|33081|

F Embaari Village |QID|33586|M|40.7,55.3|N|Fly to Embaari Village|
f Exile's Rise|QID|33586|M|45.58,25.37|N|At Wargra.|
T Chasing Shadows |QID|33586|M|45.70,26.35|N|To Rulkan up Exile's Rise|

A Ancestor's Memory|QID|33082|M|45.70,26.35|N|From Rulkan.|PRE|33586|
A Forbidden Love|QID|34847|M|46.13,25.48|N|From Dulgab.|
A Lunarblossom|QID|34836|M|46.40,25.21|N|From Zukaza.|

C Ancestor's Memory|QID|33082|M|45.7,25.4|N|Click on Ancestor's Totem in the cave underneath Exile's Rise. Entrance is south of the Rise (jump down)|NC|
T Ancestor's Memory|QID|33082|M|45.8,25.6|N|Wait for the dialog to finish, then To Rulkan|

A Darkest Night|QID|34043|M|45.84,25.58|N|From Rulkan.|PRE|33082|
A Rulkan |QID|35631|M|45.84,25.58|N|Ask Rulkan to become your follower.|PRE|33082|

C Lunarblossom|QID|34836|N|Loot the Lunarblossom from the floor of Deadwalker Pass, the entrance to the Pass is to the east of Exile's Rise.|NC|S|M|51.1,19.2|
C Forbidden Love|QID|34847|N|Head up to Dol'mak's Hideout to find Kral'za. The cave entrance is at the back of Deadwalker Pass - head east to the path, then take the northern fork to Deadwalker Pass.|QO|1|NC|M|48.1,15.1|
C Forbidden Love|QID|34847|N|Kill Dol'mak|QO|2|M|48.1,15.1|
C Forbidden Love|QID|34847|N|Kill Dark Apparition|QO|3|M|48.1,15.1|
C Lunarblossom|QID|34836|N|Finish looting the Lunarblossom from the floor of Deadwalker Pass.|NC|US|M|51.1,19.2|

T Lunarblossom|QID|34836|M|46.41,25.22|N|To Zukaza back in Exile's Rise.|
T Forbidden Love|QID|34847|M|46.12,25.49|N|To Dulga.|

T Darkest Night |QID|34043|N|To Prophet Velen at Anguish Fortress.|M|35.71,36.93|
A Into Anguish|QID|35032|M|35.71,36.93|N|From Prophet Velen.|PRE|34043|
A On the Offensive|QID|33083|M|35.83,36.97|N|From Rangari Saa'to.|PRE|34043|
A Harbingers of the Void|QID|33793|M|35.83,36.97|N|From Rangari Saa'to.|PRE|34043|
A The Great Salvation|QID|33794|M|35.83,36.97|N|From Rangari Saa'to.|PRE|34043|
A Across the Stars|QID|33795|M|35.37,36.95|N|From Illuminate Praavi.|PRE|34043|

C Into Anguish|QID|35032|N|Head up the stairs, then use the Fragment of Anguish to remove the forcefield.|QO|1|M|35.0,37.9|NC|

C The Clothes on Their Backs|QID|36266|N|Kill and loot the Shadowmoon Forces for their Ceremonial Shadowmoon Robes.|S|
C On the Offensive|QID|33083|N|Kill the Shadowmoon Forces|S|
C Across the Stars|QID|33795|N|Pick up the Star Readings from the floor.|NC|S|
C The Great Salvation|QID|33794|N|Rescue the Draenei prisoners by opening the cages.|NC|S|

C Into Anguish|QID|35032|N|Deactivate the Mark of Shadows|QO|3|M|34.5,41.4|NC|
C Harbingers of the Void |QID|33793|N|Kill the Shadowmoon Prophet surrounding the Essence of Shadow to release it, then kill it.|QO|1|M|34.0,43.3|
C Harbingers of the Void|QID|33793|N|Kill Essence of Anguish, who is inside Ancestor's Grotto cave.|QO|3|M|35.2,44.5|
C Into Anguish|QID|35032|N|Deactivate the Mark of Anguish|QO|4|M|32.6,38.8|NC|
C Harbingers of the Void |QID|33793|N|Kill the Shadowmoon Prophet surrounding the Essence of Darkness to release it, then kill it.|QO|2|M|31.2,39.4|
C Into Anguish|QID|35032|N|Deactivate the Mark of Darkness|QO|2|M|29.5,39.7|NC|

T Into Anguish|QID|35032|N|Auto-Complete|
A The Dark Side of the Moon|QID|34054|PRE|35032|N|Auto-Accept|
C The Dark Side of the Moon|QID|34054|N|Head up the Terrace of the Stars to Yrel then Velen.|M|30.3,43.2|NC|QO|1|
C The Dark Side of the Moon|QID|34054|N|Wait for the dialog to finish, then kill Arkeddon.|M|30.9,43.9|QO|2|

C The Great Salvation|QID|33794|N|Finish rescuing the Draenei prisoners by opening the cages.|NC|US|
C Across the Stars|QID|33795|N|Finish picking up the Star Readings from the floor.|NC|US|
C The Clothes on Their Backs|QID|36266|N|Finish killing and loot the Shadowmoon Forces for their Ceremonial Shadowmoon Robes.|US|
C On the Offensive|QID|33083|N|Finish killing the Shadowmoon Forces|US|

T The Great Salvation|QID|33794|N|To Yrel in Embaari Village|M|46.4,38.6|
T The Dark Side of the Moon|QID|34054|N|To Yrel|M|46.4,38.6|

;This only covers those who do not auto-accept above...
A The Dark Side of the Moon|QID|35093|M|35.7,36.9|N|From Prophet Velen.|LEAD|34054|PRE|35032|
C The Dark Side of the Moon|QID|35093|N|Head up the Terrace of the Stars to Yrel|M|30.3,43.2|NC|QO|1|
C The Dark Side of the Moon|QID|35093|N|Kill Arkeddon.|M|30.9,43.9|QO|2|

T The Dark Side of the Moon|QID|35093|N|To Yrel|M|46.4,38.6|
T On the Offensive|QID|33083|N|To Prophet Velen|M|46.4,38.7|
T Harbingers of the Void|QID|33793|M|35.7,36.9|N|To Prophet Velen|M|46.4,38.7|
T Across the Stars|QID|33795|M|35.7,36.9|N|To Prophet Velen|M|46.4,38.7|

A Darkness Falls|QID|33837|N|From Prophet Velen.|M|46.4,38.7|PRE|33794;33083;33793;33795|

F Fey Landing |QID|36266|N|Fly to Fey Landing in Elodor.|ACTIVE|36266|
T The Clothes on Their Backs|QID|36266|N|To Ameeka.|M|58.2,26.5|
A Hexcloth|QID|36269|N|From Ameeka.|PRE|36266|M|58.2,26.5|
C Hexcloth|QID|36269|N|Create a Hexweave Swatch.|NC|
T Hexcloth|QID|36269|N|To Ameeka.|M|58.2,26.5|
F Embaari Village |QID|33837|N|Fly to Embaari Village.|PRE|36269|

C Darkness Falls|QID|33837|N|Enter the Waning Crescent|QO|1|M|46.5,45.3|NC|
C Darkness Falls|QID|33837|N|Find Ner'zhul, just head straight on through the cavern.|QO|2|M|52.0,46.1|NC|
C Darkness Falls|QID|33837|N|Kill Ner'zhul and the add-ons spawned.|QO|3|M|52.0,46.1|
T Darkness Falls|QID|33837|M|52.22,46.15|N|To Yrel.|

A The Righteous March|QID|33255|M|52.23,46.04|N|From Vindicator Maraad, wait until he flies into Light's Fall.|PRE|33837|
C The Righteous March|QID|33255|M|52.23,46.04|N|Speak to Vindicator Maraad and tell him you are ready to join the attack. Then at the Temple of Karabor, use Key 1 (Naaru's Retribution) to kill the Iron Horde fighting around the Karabor.|
T The Righteous March|QID|33255|M|77.46,37.63|N|To Exarch Akama.|

A The Defense of Karabor|QID|33256|M|77.46,37.63|N|From Exarch Akama.|PRE|33255|
C The Defense of Karabor|QID|33256|N|Complete the scenario (Kill Arnokk the Burner, head to the harbor, kill Commander Vorka. Watch out for the reinforcements which can overwhelm you)|
T The Defense of Karabor|QID|33256|N|Jump onto Raindash to take you back to Embaari Village, then To Yrel|M|46.4,38.6|

A The Secrets of Gorgrond |QID|33533|N|Moving onto Gorgrond next? Accept this quest from Yrel.|LEAD|36632;35556|

l The Prophet's Arcanum |QID|37322|N|Go to your mailbox, there will be a message there from Yrel, with The Prophet's Arcanum. Take it.|L|119208|PRE|33256|M|45.9,39.6|
A The Prophet's Final Message|QID|37322|M|42.37,52.04|Z|Lunarfall|N|From The Prophet's Arcanum. (Quest can also be obtained from Arsenio Zerep.)|U|119208|PRE|33256|
F Path of the Light |QID|37322|M|45.7,38.9|N|Take a flight to Path of Light from Eonor.|ACTIVE|37322|
f Tranquil Court|QID|37322|M|70.4,50.4|N|With Itara|ACTIVE|37322|
T The Prophet's Final Message|QID|37322|N|To Prophet Velen's Memorial|M|73.7,55.8|

H Lunarfall |QID|33814|N|Use your Garrison Hearthstone, or fly back to your garrison.|U|110560|

A Lost Lumberjacks|QID|34820|M|48.92,42.24|Z|Lunarfall|N|From Ken Loggin. \n(if you've already leveled up your garrison, you'll find Ken outside the fort to the west.|
A Gloomshade Game Hunter |QID|33461|N|From the list of ingredients attached to the side of the cart.|M|44.2,53.9|Z|Lunarfall|

T Fast Expansion|QID|33814|M|41.53,49.27|Z|Lunarfall|N|To Baros Alexston.|
A Bigger is Better |QID|36592|M|41.53,49.27|Z|Lunarfall|N|From Baros Alexston.|
C Bigger is Better |QID|36592|M|41.4,49.0|Z|Lunarfall|N|Select the Architect Table, and select "Upgrade" for the Town Hall.|NC|
T Bigger is Better |QID|36592|M|31.8,31.2|Z|Lunarfall|N|To Baros Alexston.|
T Supply Drop|QID|35905|M|31.8,31.2|Z|Lunarfall|N|To Baros Alexston.|

A Building for Professions |QID|36100|M|31.8,31.2|Z|Lunarfall|N|From Baros Alexston.|
C Building for Professions |QID|36100|N|Click on the Architect's table, bring up the small plots, and build on one of the plots.|NC|M|31.7,31.8|Z|Lunarfall|
T Building for Professions |QID|36100|M|31.8,31.2|Z|Lunarfall|N|To Baros Alexston.|

T Lost Lumberjacks|QID|34820|M|39.9,29.5|N|To Lost Packmule.|
A Gloomshade Grove|QID|33263|M|39.53,29.93|N|From Lost Packmule.|PRE|34820|

C Gloomshade Game Hunter |QID|33461|N|Kill and loot Gulper Leg for the Gulper Leg.|QO|3|S|
C Gloomshade Game Hunter |QID|33461|N|Kill and loot Gloomshade Howler for the Shadowstalker Ribs.|QO|1|S|
C Gloomshade Grove|QID|33263|N|Head to Phlox in Gloomshade Grove|QO|1|M|39.3,25.7|NC|
C Gloomshade Grove|QID|33263|N|Speak to Phlox|QO|2|CHAT|M|39.3,25.7|
C Gloomshade Grove|QID|33263|N|Click the Alliance Sword near the pond.|QO|3|NC|M|39.6,22.7|
C Gloomshade Grove|QID|33263|N|Speak with Phlox|QO|4|CHAT|M|39.6,22.8|
C Gloomshade Game Hunter |QID|33461|N|Finish killing and looting Gulper Leg for the Gulper Leg.|QO|3|M|39.1,22.6|US|
C Gloomshade Grove|QID|33263|N|Click the Alliance Shield near the Field|QO|5|NC|M|39.8,19.9|
C Gloomshade Grove|QID|33263|N|Speak with Phlox|QO|6|CHAT|M|39.9,20.0|
C Gloomshade Game Hunter |QID|33461|N|Finish killing and looting Gloomshade Howler for the Shadowstalker Ribs.|QO|1|US|M|39.9,20.0|

C Gloomshade Game Hunter |QID|33461|N|Kill and loot Gloomshade Fungi for the Gloomshade Spore.|QO|2|S|
C Gloomshade Grove|QID|33263|N|Click the Dead Packmule near the Beach|QO|7|NC|M|41.8,18.0|
C Gloomshade Grove|QID|33263|N|Speak with Phlox|QO|8|CHAT|M|41.9,18.0|

C Gloomshade Grove|QID|33263|N|Head into Gloomshade Grotto Gloomshade Grotto|QO|9|NC|M|47.0,15.0|
C Gloomshade Grove|QID|33263|N|Kill Phlox|QO|10|M|47.1,14.7|
T Gloomshade Grove|QID|33263|N|To Jarrod Hamby|M|47.1,14.4|

A Game of Thorns|QID|33271|M|47.05,14.83|N|From Jarrod Hamby (or the Skull from the floor)|M|47.1,14.4|PRE|33263|
A Prune the Podlings|QID|34806|M|47.05,14.39|N|From Ryan Metcalf.|PRE|33263|
A Captured Critters|QID|33331|M|46.26,15.91|N|From a Captured Critter just ouside the cave.|PRE|33263|

C Prune the Podlings|QID|34806|M|47.05,14.39|N|Kill Podlings|S|
C Gloomshade Game Hunter |QID|33461|N|Finish killing and looting Gloomshade Fungi for the Gloomshade Spore.|QO|2|US|M|43.0,18.5|
C Captured Critters|QID|33331|N|Release Captured Critters|NC|M|43.0,18.5|
T Captured Critters|QID|33331|N|Auto-Complete|
C Prune the Podlings|QID|34806|M|47.05,14.39|N|Finish killing Podlings|US|M|43.0,18.5|
T Prune the Podlings|QID|34806|M|47.05,14.39|N|Auto-Complete|

C Game of Thorns|QID|33271|N|Follow the path up to King Deathbloom, and kill him.|M|35.7,19.7|
T Game of Thorns|QID|33271|N|To Shelly Hamby|M|36.4,19.3|
A Shelly Hamby |QID|35625|N|From Shelly Hamby|M|36.4,19.3|PRE|33271|
T Shelly Hamby |QID|35625|N|From Shelly Hamby|M|36.4,19.3|

T Gloomshade Game Hunter|QID|33461|M|37.4,61.1|Z|Lunarfall|N|To Arsenio Zerep just outside your Garrison. Use your Garrison Hearthstone to get you back to your garrison.|U|110560|

T Enchanted Highmaul Bracer|QID|36308|N|To Eileese Shadowsong|Z|Lunarfall|M|45.6,53.2|
A The Arakkoan Enchanter|QID|36310|N|From Eileese Shadowsong|Z|Lunarfall|M|45.6,53.2|PRE|36308|
T The Arakkoan Enchanter|QID|36310|N|To Arcanist Delath|M|37.4,72.6|
A Failed Apprentice |QID|36313|N|From Arcanist Delath|M|37.4,72.6|PRE|36310|
C Failed Apprentice |QID|36313|N|Free Deema|M|37.4,72.6|NC|
T Failed Apprentice |QID|36313|N|To Deema|M|37.4,72.6|
A Oru'kai's Staff |QID|36315|N|From Deema|M|37.4,72.6|PRE|36313|
C Oru'kai's Staff |QID|36315|N|Obtain Oru'kai's Staff from the water.|
T Oru'kai's Staff |QID|36315|N|To Arcanist Delath|M|37.4,72.6|

F Embaari Village|QID|35444|N|Fly to Embaari Village|ACTIVE|35444|
f Path of the Light|QID|35444|N|Run east along the road. To Paaya.|M|57.0,56.6|ACTIVE|35444|
R The Draakorium |QID|35444|N|Run south along the road.|M|57.0,56.6|ACTIVE|35444|
f The Draakorium |QID|35444|N|With Morfax|M|57.0,56.6|ACTIVE|35444|
T The Southern Wilds |QID|35444|N|To Prelate Reenu.|M|57.0,57.5|ACTIVE|35444| ;From Farmer Gehaar

A The Southern Wilds|QID|35459|M|42.71,44.76|Z|Lunarfall|LEAD|35444|
f The Draakorium |QID|35459|N|With Morfax|M|57.0,56.6|ACTIVE|35459|
T The Southern Wilds |QID|35459|N|To Prelate Reenu, south along the road in Draakorium|M|57.0,57.5|ACTIVE|35459|

T The Southern Wilds |QID|35450|N|To Prelate Reenu, south along the road in Draakorium|M|57.0,57.5|ACTIVE|35450|

A Crippled Caravan|QID|33786|M|57.0,57.5|N|From Prelate Reenu.|
A Wanted: Maa'run's Hoof |QID|33836|N|From the Wanted Poster at The Draakorium. This is a 3-party group quest.|RANK|3|
C Crippled Caravan|QID|33786|N|Head to Fiona's Caravan|M|53.6,57.3|NC|
T Crippled Caravan|QID|33786|N|To Fiona|M|53.6,57.3|

A Fiona's Solution|QID|33787|M|53.60,57.27|N|From Fiona.|
A Swamplighter Queen|QID|33808|M|53.60,57.27|N|From Fiona.|

C Wanted: Maa'run's Hoof |QID|33836|N|Kill and loot Maa'run for her hoof. This is a 3-party group quest.|RANK|3|M|51.8,54.4|
C Swamplighter Queen|QID|33808|N|Head into Swamplight Cave, then kill and loot Swamplighter Queen for her tail.|M|51.5,55.6|

C Fiona's Solution|QID|33787|N|Pick up the Moonlit Herb from the ground of Swamplight Trail.|QO|4|M|51.8,58.5|NC|S|
C Fiona's Solution|QID|33787|N|Kill and loot the Riot Blossom|QO|3|S|M|51.8,58.5|
C Fiona's Solution|QID|33787|N|Kill and loot the Swamplighter Drones for the Swamplighter Venom (note, venom does NOT drop from the Workers)|QO|2|S|M|51.8,58.5|
C Fiona's Solution|QID|33787|N|Kill and loot Twilight Riverbeast for the Heart.|QO|1|M|51.8,58.5|
C Fiona's Solution|QID|33787|N|Pick up the Moonlit Herb from the ground of Swamplight Trail.|QO|4|M|51.8,58.5|NC|US|
C Fiona's Solution|QID|33787|N|Finish killing and looting Twilight Riverbeast for the Heart.|QO|1|M|51.8,58.5|
C Fiona's Solution|QID|33787|N|Finish killing and looting the Swamplighter Drones for the Swamplighter Venom (note, venom does NOT drop from the Workers)|QO|2|US|M|51.8,58.5|
C Fiona's Solution|QID|33787|N|Finish killing and looting the Riot Blossom|QO|3|US|M|51.8,58.5|

T Fiona's Solution|QID|33787|M|53.59,57.30|N|To Fiona.|
T Swamplighter Queen|QID|33808|M|53.59,57.30|N|To Fiona.|
A Cooking With Unstable Herbs|QID|33788|M|53.59,57.30|N|From Fiona.|PRE|33787;33808|
C Cooking With Unstable Herbs|QID|33788|QO|1|N|Speak with Fiona|CHAT|M|53.59,57.30|
C Cooking With Unstable Herbs|QID|33788|QO|2|N|Follow Fiona's steps to complete the elixir.\n\nNice Glow = Moonlit Herb\nSomething Meaty = Riverbeast Heart\nWriggle Around = Riotvine\nDangerous and Toxic = Swamplighter Venom|NC|M|53.59,57.30|
C Cooking With Unstable Herbs|QID|33788|QO|3|N|Click to use the elixir on Gidwin Goldbraids.|NC|
T Cooking With Unstable Herbs|QID|33788|M|53.59,57.30|N|To Fiona.|

A Poison Paralysis|QID|35006|M|53.58,57.32|N|From Fiona.|PRE|33788|
A Botani Beatdown|QID|34995|M|53.67,57.26|N|From Tarenar Sunstrike.|PRE|33788|
A Blademoon Bloom|QID|35014|M|53.70,57.28|N|From Rangari Arepheon.|PRE|33788|
A Forever Young|QID|34994|M|53.47,57.29|N|From Beezil Linkspanner.|PRE|33788|
A Rotting Riverbeasts|QID|34996|M|52.61,59.69|N|From Rangari Duula.|

C Botani Beatdown|QID|34995|M|53.67,57.26|N|Kill the Blademoon Botani|S|
C Rotting Riverbeasts|QID|34996|M|51.6,63.2|N|Kill the Blooming Mandragora. By the river-edge, there are Shadow Lily's that will allow you to walk on water.|

A Slumberbloom|QID|34997|M|53.14,65.38|N|From Sleepy Rangari.|
C Slumberbloom|QID|34997|M|53.3,65.7|N|Destroy the Slumberblooms by using the Gathered Pebbles on them.|S|NC|

C Forever Young|QID|34994|N|Collect the Youthvine from the ground.|NC|M|53.8,69.3|S|

C Poison Paralysis|QID|35006|NC|N|Find and cure Talren Highbeacon|QO|3|M|54.1,70.8|
C Blademoon Bloom|QID|35014|N|Speak with Rangari Arepheon|M|55.7,72.0|CHAT|
T Blademoon Bloom|QID|35014|N|To Rangari Arepheon|M|55.7,72.0|

A Gestating Genesaur|QID|35015|M|55.67,71.98|N|From Rangari Arepheon.|PRE|35014|
C Gestating Genesaur|QID|35015|M|56.1,73.1|N|Kill Blooming Genesaur|
T Gestating Genesaur|QID|35015|M|55.67,71.98|N|To Rangari Arepheon.|

C Poison Paralysis|QID|35006|NC|N|Find and cure Argus Highbeacon|QO|2|M|56.8,70.4|
C Poison Paralysis|QID|35006|NC|N|Find and cure Rimblat Earthshatter|QO|1|M|55.1,68.1|

C Slumberbloom|QID|34997|M|53.3,65.7|N|Finish destroying the Slumberblooms by using the Gathered Pebbles on them.|NC|US|
T Slumberbloom|QID|34997|N|Auto-Complete|

C Forever Young|QID|34994|N|Finish collecting the Youthvine from the ground.|NC|M|54.7,70.0|US|
C Botani Beatdown|QID|34995|N|Finish killing the Blademoon Botani|US|M|55.1,68.1|

T Rotting Riverbeasts|QID|34996|M|52.61,59.67|N|To Rangari Duula.|
T Forever Young|QID|34994|M|53.45,57.29|N|To Beezil Linkspanner.|
T Botani Beatdown|QID|34995|M|53.68,57.24|N|To Tarenar Sunstrike.|
T Poison Paralysis|QID|35006|M|53.60,57.29|N|To Fiona.|

A Fiona |QID|35617|M|53.60,57.29|N|From Fiona.|PRE|35006|
T Fiona |QID|35617|M|53.60,57.29|N|To Fiona.|

T Wanted: Maa'run's Hoof|QID|33836|M|58.03,57.63|N|To Orrin.|RANK|3|

L Level 94 |QID|33113|LVL|94|N|Move onto Gorgrond, you can come back to this guide after you've levelled up a bit (the next steps require Level 94)|
A Shadowmoonwell |QID|33113|N|From Delas Moonfang|M|29.5,24.5|PRE|37451|
C Shadowmoonwell |QID|33113|N|Collect a Chunk of Lunar Rock from the Secluded Glade|NC|M|23.2,20.8|
T Shadowmoonwell |QID|33113|N|To Delas Moonfang|M|29.5,24.5|

A A Curse Upon the Woods |QID|33120|N|From Delas Moonfang|M|29.5,24.5|PRE|33113|
C A Curse Upon the Woods |QID|33120|N|Head back to The Cursed Woods and kill the Fel-cursed creatures|M|26.3,20.7|
T A Curse Upon the Woods |QID|33120|N|To Delas Moonfang|M|29.5,24.5|

]]

end)
