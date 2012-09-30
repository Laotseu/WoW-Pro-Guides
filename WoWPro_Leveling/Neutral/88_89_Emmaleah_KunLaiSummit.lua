
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_kunlai_summit_neutral
-- Date: 2012-09-25 00:51
-- Who: Ludovicus Maior

-- URL: http://wow-pro.com/node/3490/revisions/25067/view
-- Date: 2012-09-15 19:39
-- Who: Ludovicus Maior
-- Log: Applied https://github.com/Emmaleah/WoW-Pro-Guides/blob/master/WoWPro_Leveling/Neutral/88_89_Emmaleah_KunLaiSummit.lua

-- URL: http://wow-pro.com/node/3490/revisions/25065/view
-- Date: 2012-09-08 06:24
-- Who: Laotseu

-- URL: http://wow-pro.com/node/3490/revisions/25064/view
-- Date: 2012-09-08 05:49
-- Who: Laotseu
-- Log: Play tested using an Alliance toon. Didn't touch the Horde only quests.

-- URL: http://wow-pro.com/node/3490/revisions/25057/view
-- Date: 2012-08-28 19:31
-- Who: Ludovicus Maior
-- Log: Submitted by Emmaleah on Sat, 2012-08-18 15:07. 

WoWPro.Leveling:RegisterGuide('EmmKun8889', 'Kun-Lai Summit', 'Emmaleah', '88', '89', 'EmmTow8990|EmmTow8990', 'Neutral', function()
return [[

N Welcome to Kun-Lai Summit.|N|This guide assumes you are starting at Grassy Cline in Valley of the Four Winds. If you don't have the quest 'Road to Kun-Lai' it is available in Halfhill.|

A The Road to Kun-Lai|QID|31254|FACTION|Alliance|M|55.3,50.2|Z|Valley of the Four Winds|N|From Highlord Grummle.|
F Grassy Cline|QID|31254|FACTION|Alliance|
A The Road to Kun-Lai|QID|31255|FACTION|Horde|M|55.3,50.2|Z|Valley of the Four Winds|N|From Highlord Grummle.|
F Grassy Cline|QID|31255|FACTION|Horde|

C Speak with Highroad Grummle|QID|31254|FACTION|Alliance|QO|Speak with the Highroad Grummle: 1/1|NC|M|70.08,23.47|Z|Valley of the Four Winds|
C Speak with Highroad Grummle|QID|31255|FACTION|Horde|QO|Speak with the Highroad Grummle: 1/1|NC|M|70.08,23.47|Z|Valley of the Four Winds|

f Tavern in the Mists|QID|99999|M|56.75,75.82|Z|The Veiled Stair|N|At Shin the Weightless.|
A Robbing Robbers of Robbers|QID|31286|M|53.52,65.78|Z|The Veiled Stair|N|From Len the Whisperer.|
A Educating Saurok|QID|31287|M|53.52,65.78|Z|The Veiled Stair|N|From Len the Whisperer.|
C Robbing Robbers of Robbers|QID|31286|S|NC|Z|The Veiled Stair|M|45.62,45.63|
K Kill Leechfingers|QID|31287|T|Leechfingers|M|55.7,55.9;50.18,42.00|CC|Z|The Veiled Stair|N|In the back of the cave.|
C Robbing Robbers of Robbers|QID|31286|US|NC|Z|The Veiled Stair|M|45.62,45.63|
T Robbing Robbers of Robbers|QID|31286|M|53.49,65.77|Z|The Veiled Stair|N|To Len the Whisperer.|
T Educating Saurok|QID|31287|M|53.49,65.77|Z|The Veiled Stair|N|To Len the Whisperer.|

C The Road to Kun-Lai|QID|31254|FACTION|Alliance|QO|Speak with Brewmaster Boof: 1/1|NC|M|51.98,43.69|Z|The Veiled Stair|
C The Road to Kun-Lai|QID|31255|FACTION|Horde|QO|Speak with Brewmaster Boof: 1/1|NC|M|51.98,43.69|Z|The Veiled Stair|
A The Spring Drifter|QID|31285|M|51.98,43.69|Z|The Veiled Stair|N|From Brewmaster Boof.|
C The Spring Drifter|QID|31285|M|51.98,43.69|Z|The Veiled Stair|N|Get on the boat and enjoy the ride.|

T The Spring Drifter |QID|31285|M|72.7,93.0|N|To Brewmaster Boof|
f Binan Village|QID|99999|CC|M|72.52,94.18|N|At Jo the Wind Watcher.|
A Temple of the White Tiger|QID|31392|FACTION|Alliance|M|72.04,94.17|N|From Wang Chung.|
A Temple of the White Tiger|QID|31393|FACTION|Horde|M|72.04,94.17|N|From Wang Chung.|
A Hit Medicine|QID|30460|M|71.62,92.82|N|From Apothecary Cheng.|
r Repair/Restock|QID|30457|M|71.42,92.22|N|At The Metal Paw.|
T The Road to Kun-Lai|QID|31254|FACTION|Alliance|M|72.25,91.86|N|To Mayor Bramblestaff.|
T The Road to Kun-Lai|QID|31255|FACTION|Horde|M|72.25,91.86|N|To Mayor Bramblestaff.|
A Call Out Their Leader|QID|30457|M|72.25,91.86|N|From Mayor Bramblestaff.|
A All of the Arrows|QID|30459|M|70.47,90.05|N|From Commander Hsieh.|
C All of the Arrows|QID|30459|S|NC|M|68.79,86.46|
C Hit Medicine|QID|30460|S|NC|U|79819|M|68.03,87.57|N|Normal healing spells will also work.|
C Kill Bataari Tribe members|QID|30457|QO|Bataari Tribe Members slain: 10/10|M|68.89,88.51|N|Kill 10 Bataari Tribe members and the Fire-Warrior will appear.|
K Kill Bataari Fire-Warrior|QID|30457|T|Bataari Fire-Warrior|M|68.6,88.5|QO|Bataari Fire-Warrior slain: 1/1|
C Hit Medicine|QID|30460|US|NC|U|79819|M|68.03,87.57|N|Normal healing spells will also work.|
C All of the Arrows|QID|30459|US|NC|M|68.79,86.46|
T All of the Arrows|QID|30459|M|71.01,90.45|N|To Commander Hsieh.|
T Call Out Their Leader|QID|30457|M|72.27,91.85|N|To Mayor Bramblestaff.|
T The Spring Drifter|QID|31285|M|72.64,93.00|N|To Brewmaster Boof.|
T Hit Medicine|QID|30460|M|71.59,92.83|N|To Apothecary Cheng.|

A Admiral Taylor has Awakened|QID|30508|FACTION|Alliance|M|71.59,92.83|N|From Apothecary Cheng.|
T Admiral Taylor has Awakened|QID|30508|FACTION|Alliance|M|71.53,93.06|N|To Admiral Taylor, upstairs.|
A Westwind Rest|QID|30512|M|71.53,93.06|FACTION|Alliance|N|From Admiral Taylor.|

A General Nazgrim has Awakened|QID|30511|FACTION|Horde|M|71.58,92.78|N|From Apothecary Cheng.|
T General Nazgrim has Awakened|QID|30511|FACTION|Horde|M|71.62,93.12|N|To General Nazgrim.|
A Eastwind Rest|QID|30513|FACTION|Horde|M|71.62,93.12|N|From General Nazgrim.|

A Repossession|QID|30469|M|74.94,88.85|N|From Merchant Shi.|
A My Son...|QID|30467|M|74.94,88.85|N|From Merchant Shi.|
A Enraged Vengeance|QID|30468|M|74.77,88.74|N|From Swordmistress Mei.|
A The Waterspeaker's Staff|QID|30496|M|75.1,87.9|N|From Waterspeaker Gorai.|
A Free the Dissenters|QID|30967|M|75.1,87.9|N|From Waterspeaker Gorai.|
C Enraged Vengeance|QID|30468|S|M|73.26,77.51|
C Free the Dissenters|QID|30967|S|NC|M|74.40,78.82|N|Talk to the Prisoners, pick up the sparklies and kill what attacks you as you travel towards the next spot.|
C Repossession|QID|30469|S|M|73.99,77.54|
C The Waterspeaker's Staff|QID|30496|T|Orachi|M|74.39,77.69|N|Kill Orachi and get the staff.|
T My Son...|QID|30467|M|74.68,76.88|N|To Wu-Peng.|
A Father and Child Reunion|QID|30834|M|74.68,76.88|N|From Wu-Peng.|
C Repossession|QID|30469|US|M|73.99,77.54|
C Enraged Vengeance|QID|30468|US|M|73.26,77.51|
C Free the Dissenters|QID|30967|US|NC|M|74.40,78.82|
T The Waterspeaker's Staff|QID|30496|M|75.17,88.21|N|To Waterspeaker Gorai.|
T Free the Dissenters|QID|30967|M|75.17,88.21|N|To Waterspeaker Gorai.|
C Father and Child Reunion|QID|30834|M|74.95,88.86|
T Repossession|QID|30469|M|74.95,88.86|N|To Merchant Shi.|
T Father and Child Reunion|QID|30834|M|74.95,88.86|N|To Merchant Shi.|
T Enraged Vengeance|QID|30468|M|74.79,88.70|N|To Swordmistress Mei.|
A The Ritual|QID|30480|M|75.17,88.26|N|From Waterspeaker Gorai.|
C The Ritual|QID|30480|M|74.92,88.52|
T The Ritual|QID|30480|M|74.92,88.52|N|To Waterspeaker Gorai.|
A Cleansing the Mere|QID|30828|M|74.92,88.52|N|From Waterspeaker Gorai.|
C Cleansing the Mere|QID|30828|M|71.74,87.39|
T Cleansing the Mere|QID|30828|M|71.74,87.39|N|To Waterspeaker Gorai.|
A The Fall of Shai Hu|QID|30855|M|71.74,87.39|N|From Waterspeaker Gorai.|
K Kill Shai Hu|QID|30855|T|Shai Hu|M|71.16,82.96|N|Kill the small Sha on the island to get the shield down.|
T The Fall of Shai Hu|QID|30855|M|74.93,88.53|N|To Waterspeaker Gorai.|

C Eastwind Rest|QID|30513|FACTION|Horde|NC|QO|Spoke with Farmhand Ko: 1/1|M|63.65,86.68|N|Talk to Farmhand Ko.|
C Eastwind Rest|QID|30513|FACTION|Horde|NC|QO|Spoke with Elder Shiao: 1/1|M|61.25,82.25|N|Talk to Elder Shiao.|
T Eastwind Rest|QID|30513|FACTION|Horde|M|61.25,82.25|N|To Elder Shiao.|
A Challenge Accepted|QID|30515|FACTION|Horde|M|61.25,82.25|N|From Elder Shiao.|
C Challenge Accepted|QID|30515|M|58.28,84.30|FACTION|Horde|N|Click on the flag to summon Ur-Bataar.|
T Challenge Accepted|QID|30515|M|61.55,80.22|FACTION|Horde|N|To Elder Shiao.|
A Round 'Em Up|QID|31256|M|62.99,80.22|FACTION|Horde|N|From General Nazgrim.|
A Best Meals Anywhere!|QID|31251|M|62.73,79.83|FACTION|Horde|N|From Rivett Clutchpop.|
A Trouble on the Farmstead|QID|30570|FACTION|Horde|M|62.52,79.55|N|From Farmhand Ko.|
A Mogu?! Oh No-gu!|QID|30620|FACTION|Horde|M|62.33,79.69|N|From Elder Shiao.|
f Eastwind Rest|QID|99999|FACTION|Horde|M|62.46,80.69|N|At Soaring Paw.|
A Deanimate the Reanimated|QID|30594|FACTION|Horde|M|62.69,80.67|N|From Shademaster Kiryn.|
T Trouble on the Farmstead|QID|30570|FACTION|Horde|M|60.29,85.72|N|To Farmer Chow.|

C Westwind Rest|QID|30512|FACTION|Alliance|NC|QO|Speak with Farmhand Bo: 1/1|M|58.89,80.47|
C Westwind Rest|QID|30512|FACTION|Alliance|NC|QO|Speak with Elder Tsulan: 1/1|M|56.38,84.44|
T Westwind Rest|QID|30512|FACTION|Alliance|M|56.38,84.44|N|To Elder Tsulan.|
A Challenge Accepted|QID|30514|FACTION|Alliance|M|56.38,87.44|N|From Elder Tsulan.|
K Kill Ur-Bataar|QID|30514|T|Ur-Bataar|FACTION|Alliance|M|58.30,84.20|N|Click the banner to start the combat.|
T Challenge Accepted|QID|30514|FACTION|Alliance|M|54.69,84.27|N|To Elder Tsulan.|
A Round 'Em Up|QID|30575|FACTION|Alliance|M|53.77,82.70|N|From Admiral Taylor.|
A Blue Dwarf Needs Food Badly|QID|30583|FACTION|Alliance|M|54.14,83.28|N|From Sully "The Pickle" McLeary.|
A Mogu?! Oh No-gu!|QID|30619|M|54.19,83.44|FACTION|Alliance|N|From Elder Tsulan.|
f Westwind Rest|QID|99999|M|53.97,84.27|FACTION|Alliance|N|At Tabo the Flyer.|
A Trouble on the Farmstead|QID|30569|FACTION|Alliance|M|53.80,84.10|N|From Farmhand Bo.|
A Deanimate the Reanimated|QID|30593|FACTION|Alliance|M|53.44,83.09|N|From Mishka.|
C Blue Dwarf Needs Food Badly|QID|30583|S|FACTION|Alliance|M|50.70,83.11|N|While killing birds (or Mushan) for meat. also capture 3 yaks (by clicking on them)|
C Round 'Em Up|QID|30575|FACTION|Alliance|S|NC|M|53.92,83.67|
T Trouble on the Farmstead|QID|30569|FACTION|Alliance|M|60.25,85.73|N|To Farmer Chow.|

A Farmhand Freedom|QID|30571|M|60.25,85.73|N|From Farmer Chow.|
A ... and the Pot, Too!|QID|30581|M|60.19,85.81|N|From Uyen Chow.|
C ... and the Pot, Too!|QID|30581|S|NC|M|60.03,88.43|N|The pot is in the house.|
C Farmhand Freedom|QID|30571|M|61.88,87.04|N|Kill the guards to free the slaves.|
C ... and the Pot, Too!|QID|30581|US|NC|M|60.03,88.43|N|The pot is in the house.|
T ... and the Pot, Too!|QID|30581|M|60.18,85.86|N|To Uyen Chow.|
T Farmhand Freedom|QID|30571|M|60.23,85.82|N|To Farmer Chow.|
A Back to Westwind Rest|QID|31252|FACTION|Alliance|M|60.23,85.82|N|From Farmer Chow.|
A Back to Eastwind Rest|QID|31253|FACTION|Horde|M|60.22,85.77|N|From Farmer Chow.|

;R Mojuija|QID|30595|CC|M|59.55,78.27|; Need to plot a path
A Profiting off of the Past|QID|30595|M|59.59,78.26|N|From Bao Jian.|
C Profiting off of the Past|QID|30595|S|NC|M|58.40,74.86|
C Deanimate the Reanimated|QID|30593|S|FACTION|Alliance|M|59.20,72.21|
K Kill Mogujia Soul-Caller|QID|30619|T|Mogujia Soul-Caller|FACTION|Alliance|M|58.23,71.21|
C Deanimate the Reanimated|QID|30593|US|FACTION|Alliance|M|59.20,72.21|
C Profiting off of the Past|QID|30595|US|NC|M|58.40,74.86|
T Profiting off of the Past|QID|30595|M|59.58,78.27|N|To Bao Jian.|

C Blue Dwarf Needs Food Badly|QID|30583|US|FACTION|Alliance|M|50.70,83.11|N|While killing birds (or Mushan) for meat. also capture 3 yaks (by clicking on them)|
C Round 'Em Up|QID|30575|FACTION|Alliance|US|NC|M|53.92,83.67|
T Blue Dwarf Needs Food Badly|QID|30583|FACTION|Alliance|M|54.12,83.37|N|To Sully "The Pickle" McLeary.|
T Round 'Em Up|QID|30575|M|FACTION|Alliance|53.81,82.77|N|To Admiral Taylor.|
T Back to Westwind Rest|QID|31252|FACTION|Alliance|M|53.80,83.99|N|To Farmhand Bo.|
T Mogu?! Oh No-gu!|QID|30619|FACTION|Alliance|M|54.13,83.37|N|To Elder Tsulan.|
T Deanimate the Reanimated|QID|30593|FACTION|Alliance|M|53.49,83.38|N|To Mishka.|
A In Tents Channeling|QID|30652|FACTION|Alliance|M|53.80,82.74|N|From Admiral Taylor.|
A Pandaren Prisoners|QID|30650|M|54.2,83.4|FACTION|Alliance|54.13,83.40|N|From Elder Tsulan.|
A Barrels of Fun|QID|30651|FACTION|Alliance|M|54.13,83.32|N|From Sully "The Pickle" McLeary.|
; Tying something new here. These are a series of steps for two quests that are normally done in spacific order. 
; I'll use sticky on the next step so we see one step in advance.
C Pandaren Prisoners|QID|30650|S|NC|FACTION|Alliance|M|49.67,80.36|
K Kill Musaan the Blazecaster|QID|30652|S|T|Musaan the Blazecaster|QO|Musaan the Blazecaster slain: 1/1|FACTION|Alliance|M|50.4,78.6|
C Destroy the Eastern Oil Rig|QID|30651|NC|U|80528|QO|Eastern Oil Rig destroyed: 1/1|M|50.9,79.4|N|Pick an Explosives Barrel and set it near the rig.|
K Kill Harala the Firespeaker|QID|30652|S|T|Harala the Firespeaker|QO|Harala the Firespeaker slain: 1/1|FACTION|Alliance|M|49.4,78.5|
K Kill Musaan the Blazecaster|QID|30652|US|T|Musaan the Blazecaster|QO|Musaan the Blazecaster slain: 1/1|FACTION|Alliance|M|50.4,78.6|
C Destroy the Southern Oil Rig|QID|30651|S|NC|U|80528|QO|Southern Oil Rig destroyed: 1/1|FACTION|Alliance|M|49.7,81.1|N|Pick an Explosives Barrel and set it near the rig.|
K Kill Harala the Firespeaker|QID|30652|US|T|Harala the Firespeaker|QO|Harala the Firespeaker slain: 1/1|FACTION|Alliance|M|49.4,78.5|
K Kill Pao-kun the Pyromancer|QID|30652|S|T|Pao-kun the Pyromancer|QO|Pao-kun the Pyromancer slain: 1/1|FACTION|Alliance|M|49.1,80.3|
C Destroy the Southern Oil Rig|QID|30651|US|NC|U|80528|QO|Southern Oil Rig destroyed: 1/1|FACTION|Alliance|M|49.7,81.1|N|Pick an Explosives Barrel and set it near the rig.|
K Kill Akonu the Embercaller|QID|30652|S|T|Akonu the Embercaller|QO|Akonu the Embercaller slain: 1/1|FACTION|Alliance|M|47.7,80.0|
K Kill Pao-kun the Pyromancer|QID|30652|US|T|Pao-kun the Pyromancer|QO|Pao-kun the Pyromancer slain: 1/1|FACTION|Alliance|M|49.1,80.3|
C Destroy the Western|QID|30651|S|NC|U|80528|QO|Western Oil Rig destroyed: 1/1|FACTION|Alliance|M|48.0,81.5|N|Pick an Explosives Barrel and set it near the rig.|
K Kill Akonu the Embercaller|QID|30652|US|T|Akonu the Embercaller|QO|Akonu the Embercaller slain: 1/1|FACTION|Alliance|M|47.7,80.0|
T In Tents Channeling|QID|30652|FACTION|Alliance|N|To UI Alert.|
A The Ordo Warbringer|QID|30660|FACTION|Alliance|N|From UI Alert.|
C Destroy the Western|QID|30651|US|NC|U|80528|QO|Western Oil Rig destroyed: 1/1|FACTION|Alliance|M|48.0,81.5|N|Pick an Explosives Barrel and set it near the rig.|
K Kill Ordo Warbringer|QID|30660|FACTION|Alliance|M|49.1,76.7;48.4,76.7|N|Ordo Warbringer is in the cave to the back of the camp.|
C Pandaren Prisoners|QID|30650|US|NC|FACTION|Alliance|M|49.67,80.36|
T Barrels of Fun|QID|30651|FACTION|Alliance|M|54.13,83.32|N|To Sully "The Pickle" McLeary.|
T Pandaren Prisoners|QID|30650|FACTION|Alliance|M|53.80,82.74|N|To Admiral Taylor.|
T The Ordo Warbringer|QID|30660|FACTION|Alliance|M|53.80,82.74|N|To Admiral Taylor.|
A The Shado-Pan|QID|31455|FACTION|Alliance|M|53.80,82.74|N|From Admiral Taylor.|
A Cho's Missive|QID|31460|FACTION|Alliance|M|53.49,83.38|N|From Mishka.|
A Muskpaw Ranch|QID|31456|FACTION|Alliance|M|53.80,83.99|N|From Farmhand Bo.|

C Best Meals Anywhere!|QID|31251|FACTION|Horde|M|59.99,80.46|N|While killing birds (or Mushan) for meat. also capture 3 yaks (by clicking on them)|
C Round 'Em Up|QID|31256|FACTION|Horde|M|59.99,80.46|
T Mogu?! Oh No-gu!|QID|30620|FACTION|Horde|M|62.32,79.69|N|To Elder Shiao.|
T Back to Eastwind Rest|QID|31253|FACTION|Horde|M|62.54,79.50|N|To Farmhand Ko.|
T Best Meals Anywhere!|QID|31251|FACTION|Horde|M|62.76,79.85|N|To Rivett Clutchpop.|
A Barrels of Fun|QID|30656|FACTION|Horde|M|62.76,79.85|N|From Rivett Clutchpop.|
T Deanimate the Reanimated|QID|30594|FACTION|Horde|M|62.69,80.63|N|To Shademaster Kiryn.|
T Round 'Em Up|QID|31256|FACTION|Horde|M|62.92,80.22|N|To General Nazgrim.|
A In Tents Channeling|QID|30657|FACTION|Horde|M|62.92,80.22|N|From General Nazgrim.|
A Pandaren Prisoners|QID|30655|FACTION|Horde|M|62.36,79.64|N|From Elder Shiao.|
C Pandaren Prisoners|QID|30655|FACTION|Horde|M|49.58,78.89|N|Blizzard has kindly marked the locations of the mobs to kill|
C Barrels of Fun|QID|30656|FACTION|Horde|M|47.99,81.27|
C In Tents Channeling|QID|30657|FACTION|Horde|M|47.76,80.17|
T In Tents Channeling|QID|30657|FACTION|Horde|N|To UI Alert,|
A The Ordo Warbringer|QID|30661|FACTION|Horde|N|From UI Alert.|
C The Ordo Warbringer|QID|30661|FACTION|Horde|M|48.35,76.69|
T Barrels of Fun|QID|30656|FACTION|Horde|M|62.76,79.81|N|To Rivett Clutchpop.|
T The Ordo Warbringer|QID|30661|FACTION|Horde|M|62.28,80.29|N|To General Nazgrim.|
T Pandaren Prisoners|QID|30655|FACTION|Horde|M|62.28,80.29|N|To General Nazgrim.|
A The Shado-Pan|QID|31453|FACTION|Horde|M|62.28,80.29|N|From General Nazgrim.|
A Beyond the Wall|QID|31695|M|54.1,83.4|N|From Elder Tsulan|
A Cho's Missive|QID|31459|FACTION|Horde|M|62.67,80.65|N|From Shademaster Kiryn.|
A Muskpaw Ranch|QID|31457|FACTION|Horde|M|62.55,79.53|N|From Farmhand Ko.|

;R Lao & Son's Yakwash|QID|31457|CC|M|71.5,70.04|; Need to plot a proper path
T Muskpaw Ranch|QID|31457|FACTION|Horde|M|71.50,70.04|N|To Lao Muskpaw.|
T Muskpaw Ranch|QID|31456|FACTION|Alliance|M|71.50,70.04|N|To Lao Muskpaw.|
A The Missing Muskpaw|QID|30488|M|71.50,70.04|N|From Lao Muskpaw.|
A Fresh Needle Scent|QID|30489|M|71.50,70.04|N|From Lao Muskpaw.|
C Fresh Needle Scent|QID|30489|S|M|71.67,73.59|
T The Missing Muskpaw|QID|30488|M|74.96,74.52|N|To Muskpaw Jr. He is in the back of the cave.|
A At the Yak Wash|QID|30491|M|74.96,74.52|N|From Muskpaw Jr..|N|You can ride Jr's Yak out of the cave and leave vehicle when you are out.|
C Fresh Needle Scent|QID|30489|US|M|71.67,73.59|N|Get the remaining needles before mounting the Yak.|
A Yakity Yak|QID|30587|M|70.9,70.4|S|N|From UI Alert. (from killing Burilgi Despoiler)|
C At the Yak Wash|QID|30491|S|NC|M|71.39,69.05|N|Jump on the Yak and it will go back to the farm by itself.|
A The Late Mrs. Muskpaw|QID|30582|S|U|80241|N|You should have the Muskpaw's Keepsake by now. Otherwise, kill more Burilgi.|
C Yakity Yak|QID|30587|S|M|69.94,72.81|
C At the Yak Wash|QID|30491|US|NC|M|71.39,69.05|N|Mount the Yaks and ride them back to the farm.|
A The Late Mrs. Muskpaw|QID|30582|US|U|80241|N|You should have the Muskpaw's Keepsake by now. Otherwise, kill more Burilgi.|
C Yakity Yak|QID|30587|US|M|69.94,72.81|
T At the Yak Wash|QID|30491|M|71.34,69.31|N|To Muskpaw Jr..|
T The Late Mrs. Muskpaw|QID|30582|M|71.30,69.68|N|To Lao Muskpaw.|
A The Fearmaster|QID|30804|M|71.30,69.68|N|From Lao Muskpaw.|
T Fresh Needle Scent|QID|30489|M|71.42,69.75|N|To Lao Muskpaw.|
T Yakity Yak|QID|30587|M|71.42,69.75|N|To Lao Muskpaw.|
K Kill The Fearmaster|QID|30804|T|The Fearmaster|M|68.20,74.70|
T The Fearmaster|QID|30804|M|71.37,69.64|N|To Lao Muskpaw.|
A Back in Yak|QID|30492|M|71.33,69.28|N|From Muskpaw Jr..|

;R The Grummie Bazaar|QID|30492|CC|M|65.51,61.26|; Need a proper path
C Back in Yak|QID|30492|M|65.51,61.26|
T Back in Yak|QID|30492|M|64.72,61.68|N|To Lucky Eightcoins.|
A A Grummle's Luck|QID|30808|M|64.72,61.68|N|From Lucky Eightcoins.|
A Oil Stop|QID|30614|M|65.48,60.78|N|From Slimy Inkstain.|
A Traffic Issues|QID|30616|M|64.89,60.47|N|From Smokey Sootassle.|
C Traffic Issues|QID|30616|S|M|62.8,67.4|
C A Grummle's Luck|QID|30808|S|NC|M|63.5,66.8|N|Most of them are inside the huts.|
C Oil Stop|QID|30614|U|80312|M|63.44,68.53|
C A Grummle's Luck|QID|30808|US|NC|M|63.5,66.8||N|Most of them are inside the huts.|
C Traffic Issues|QID|30616|US|M|62.8,67.4|
T A Grummle's Luck|QID|30808|M|64.67,61.70|N|To Lucky Eightcoins.|
T Oil Stop|QID|30614|M|65.44,60.78|N|To Slimy Inkstain.|
T Traffic Issues|QID|30616|M|64.88,60.40|N|To Smokey Sootassle.|
A Roadside Assistance|QID|30617|M|64.88,60.40|N|From Smokey Sootassle.|

R Temple of the White Tiger|QID|31392|M|66.8,59.29;68.4,56.08;69.05,52.48;66.33,50.71|CS|; no good QID to use for this...since it comes just before faction based steps.
f Temple of the White Tiger|QID|99999|M|66.33,50.71|N|At Big Greenfeather.|

T Temple of the White Tiger|QID|31392|FACTION|Alliance|M|68.74,43.07|N|To Anduin Wrynn.|
A A Celestial Experience|QID|31394|FACTION|Alliance|M|68.74,43.07|N|From Anduin Wrynn.|
C A Celestial Experience|QID|31394|FACTION|Alliance|M|68.98,44.09|N|If you can, talk to Xuen between each step for heals.|
T A Celestial Experience|QID|31394|FACTION|Alliance|M|68.76,43.14|N|To Anduin Wrynn.|
A A Witness to History|QID|31512|FACTION|Alliance|M|68.76,43.14|N|From Anduin Wrynn.|

T Temple of the White Tiger|QID|31393|FACTION|Horde|M|68.74,43.07|N|To Dezco.|
A A Celestial Experience|QID|31395|FACTION|Horde|M|68.74,43.07|N|From Dezco.|
C A Celestial Experience|QID|31395|FACTION|Horde|M|68.98,44.09|N|Talk to Xuen between each step.
T A Celestial Experience|QID|31395|FACTION|Horde|M|68.76,43.14|N|To Dezco.|
A A Witness to History|QID|31511|FACTION|Horde|M|68.76,43.14|N|From Dezco.|

R The Grummle Bazaar|QID|30617|CC|M|64.24,59.45|
C Roadside Assistance|QID|30617|NC|QO|Lucky Burlap Incense lit: 4/8|N|Don't worry about finishing this we will be back later.|

T Cho's Missive|QID|31460|FACTION|Alliance|M|57.28,61.66|N|To Lorewalker Cho.|
T Cho's Missive|QID|31459|FACTION|Horde|M|57.28,61.66|N|To Lorewalker Cho.|
A Path Less Traveled|QID|30999|M|57.28,61.66|N|From Lorewalker Cho.|
T Path Less Traveled|QID|30999|M|57.27,61.18|N|To Uncle Cloverleaf.|
A Instant Courage|QID|30601|M|57.27,61.18|N|From Uncle Cloverleaf.|
h The Lucky Traveller|QID|30592|M|57.43,60.05|Z|One Keg|N|At Chiyo Mistpaw.|
A They Stole My Luck!|QID|30621|M|57.35,60.22|N|From Ji-Lu the Lucky.|
f One Keg|QID|99999|M|57.77,59.78|N|At Little Cleankite.|
A Resupplying One Keg|QID|30618|M|57.71,61.79|N|From Big Sal.|
C Resupplying One Keg|QID|30618|S|NC|M|56.33,50.88|
C Instant Courage|QID|30601|S|NC|U|80308|M|57.54,47.44|It's ok to leave the Guides to die if you want to zerg out.|
C They Stole My Luck!|QID|30621|NC|M|57.77,49.30|N|The next 3 quests are done inside Howlingwind Cavern.|
C Instant Courage|QID|30601|US|NC|U|80308|M|57.54,47.44|It's ok to leave the Guides to die if you want to zerg out.|
C Resupplying One Keg|QID|30618|US|NC|M|56.33,50.88|
T They Stole My Luck!|QID|30621|M|57.30,60.19|N|To Ji-Lu the Lucky.|
T Resupplying One Keg|QID|30618|M|57.71,61.76|N|To Big Sal.|
T Instant Courage|QID|30601|M|57.23,61.15|N|To Uncle Cloverleaf.|
A Comin' Round the Mountain|QID|30487|M|57.26,61.17|N|From Uncle Cloverleaf.|

C Comin' Round the Mountain|QID|30487|M|48.11,48.93|
T Comin' Round the Mountain|QID|30487|M|48.12,49.00|N|To Lucky Bluestring.|
A One Traveler's Misfortune|QID|30683|M|48.12,49.00|N|From Lucky Bluestring.|
C One Traveler's Misfortune|QID|30683|M|50.22,49.39|
T One Traveler's Misfortune|QID|30683|M|48.09,49.04|N|To Lucky Bluestring.|
A Seeker's Folly|QID|30684|M|48.09,49.04|N|From Lucky Bluestring.|
C Seeker's Folly|QID|30684|M|43.22,51.99|N|Follow the path with the red flags. Avoid the falling snow and the twisters. Click on every shrines you see.|
T Seeker's Folly|QID|30684|M|43.79,51.01|N|To Lorewalker Cho.|
A The Tongue of Ba-Shon|QID|30829|M|43.79,51.01|N|From Lorewalker Cho.|
C The Tongue of Ba-Shon|QID|30829|M|43.51,51.38|
T The Tongue of Ba-Shon|QID|30829|M|43.73,51.09|N|To Lorewalker Cho.|
A Staying Connected|QID|30795|M|43.73,51.09|N|From Lorewalker Cho.|
C Staying Connected|QID|30795|U|81712|M|51.94,47.44|N|Talk to Mishi for a flight to Valley of the Emporers.|
T Staying Connected|QID|30795|M|51.94,47.44|N|To Image of Lorewalker Cho.|
A An End to Everything|QID|30796|M|51.94,47.44|N|From Image of Lorewalker Cho.|
C An End to Everything|QID|30796|S|M|57.34,47.17|
A It Was Almost Alive|QID|30797|M|57.07,47.75|
C It Was Almost Alive|QID|30797|NC|M|57.08,47.83|N|Use the item to call Cho and turn in these 2 qeusts.|
C An End to Everything|QID|30796|US|M|57.34,47.17|
T An End to Everything|QID|30796|U|81712|M|58.03,49.02|N|Use The Togue of Ba-Shon to call the Image of Lorewalker Cho and turn in the quest.|
T It Was Almost Alive|QID|30797|U|81712|M|58.03,49.02|N|Use The Togue of Ba-Shon to call the Image of Lorewalker Cho and turn in the quest.|
A The Tomb of Shadows|QID|30799|U|81712|M|58.03,49.02|N|From Image of Lorewalker Cho.|
C Get the Wai Dynasty Rubbing|QID|30799|NC|QO|Wai Dynasty Rubbing: 1/1|M|56.0,48.0;56.4,43.5|CC|
C Get the Shen Dynasty Rubbing|QID|30799|NC|QO|Shen Dynasty Rubbing: 1/1|M|57.1,43.5|
C Get the Qiang Dynasty Rubbing|QID|30799|NC|QO|Qiang Dynasty Rubbing: 1/1|M|57.0,45.0|
T The Tomb of Shadows|QID|30799|U|81712|M|55.14,46.47|N|To Image of Lorewalker Cho.|
A Breaking the Emperor's Shield|QID|30798|U|81712|M|55.14,46.47|N|From Image of Lorewalker Cho.|
C Breaking the Emperor's Shield|QID|30798|M|53.02,51.35|N|Go up the stairs from Tomb of Shadows to Tomb of Secrets.|
T Breaking the Emperor's Shield|QID|30798|U|81712|M|52.94,50.85|N|To Image of Lorewalker Cho.|
A Stealing Their Thunder King|QID|30800|U|81712|M|52.94,50.85|N|From Image of Lorewalker Cho.|
C Stealing Their Thunder King|QID|30800|M|53.55,4.48;53.35,48.65;54.74,46.84;48.79,47.36|CS|N|Watch your step, the colored tiles are trapped.|
T Stealing Their Thunder King|QID|30800|U|81712|M|49.13,47.46|N|To Image of Lorewalker Cho.|
A Lessons from History|QID|30801|U|81712|M|49.13,47.46|N|From Image of Lorewalker Cho.|
C Lessons from History|QID|30801|M|48.84,47.33|
T Lessons from History|QID|30801|U|81712|M|49.20,47.43|N|To Image of Lorewalker Cho.|
A Chasing the Storm|QID|30802|U|81712|M|49.20,47.43|N|From Image of Lorewalker Cho.|
C Chasing the Storm|QID|30802|M|51.31,48.26|N|Kill Zandalari Warriors until you get the Blood-Revealed Map.|
T Chasing the Storm|QID|30802|U|81712|M|51.31,48.26|N|To Image of Lorewalker Cho.|

A Fisherman's Tale|QID|30935|U|81712|M|51.31,48.26|N|From Image of Lorewalker Cho.|
C Fisherman's Tale|QID|30935|NC|QO|Speak to Mishi outside of Lei Shen's Tomb: 1/1|M|53.0,46.4|
C Fisherman's Tale|QID|30935|NC|QO|Speak to Shin Whispercloud to access Zouchin Province: 1/1|M|63.3,40.2|N|Go down the Path deeper into the mountain.|
f Zouchin Village|QID|99999|M|62.44,30.16|N|At Bo the Wind Claimer.|
T Fisherman's Tale|QID|30935|M|62.33,29.03|N|To Lorewalker Cho.|
A It Takes A Village|QID|30944|M|62.33,29.03|N|From Lorewalker Cho.|
A Checking In|QID|30816|M|63.14,29.40|N|From Li Ha,i.|
A Handle With Care|QID|30943|M|63.48,28.65|N|From Elder Shu.|
A Make A Fighter Out of Me|QID|30942|M|63.69,30.66|N|From Shomi.|
A What's Yours Is Mine|QID|30945|M|63.38,30.69|N|From Steelbender Doshu.|
C It Takes A Village|QID|30944|S|NC|M|62.43,28.30|
C Handle With Care|QID|30943|S|NC|M|70.04,27.70|
C Make A Fighter Out of Me|S|QID|30942|M|71.17,28.65|
C What's Yours Is Mine|QID|30945|M|71.17,28.66|
C Make A Fighter Out of Me|QID|30942|US|M|71.17,28.65|
C Handle With Care|QID|30943|US|NC|M|70.04,27.70|
C It Takes A Village|QID|30944|US|NC|M|62.43,28.30|
T Make A Fighter Out of Me|QID|30942|M|71.17,28.66|N|To Shomi.|
T What's Yours Is Mine|QID|30945|M|63.35,30.68|N|To Steelbender Doshu.|
T Handle With Care|QID|30943|M|63.23,28.68|N|To Elder Shu. He is upstairs on the balcony.|
T It Takes A Village|QID|30944|M|62.33,29.04|N|To Lorewalker Cho.|
A Enemies At Our Door|QID|31011|M|62.33,29.04|N|From Lorewalker Cho.|
C Enemies At Our Door|QID|31011|S||QO|Amani Berserker slain: 10/10;Gurubashi Bloodrider slain: 3/3|M|64.49,28.84|
C Rool barrels on the Behemoth|QID|31011|NC|QO|Amani Behemoth slain: 5/5|M|61.24,29.27|N|Roll the barrels down the hill.|
C Enemies At Our Door|QID|31011|US|QO|Amani Berserker slain: 10/10;Gurubashi Bloodrider slain: 3/3|M|64.49,28.84|
T Enemies At Our Door|QID|31011|M|62.32,29.06|N|To Lorewalker Cho.|
A Revelations|QID|30946|M|62.32,29.06|N|From Lorewalker Cho.|
C Revelations|QID|30946|M|62.46,28.88|N|Prisoner is upstairs.|
T Revelations|QID|30946|M|62.32,29.02|N|To Lorewalker Cho.|
A Prophet Khar'zul|QID|31228|M|62.32,29.02|N|From Lorewalker Cho.|
T Checking In|QID|30816|M|60.59,21.25|N|To Sage Liao.|
A Emergency Care|QID|30794|M|60.59,21.22|N|From Sage Liao.|
C Emergency Care|QID|30794|U|81177|M|60.60,21.38|N|Bandage or heal Sage Liao.|
T Emergency Care|QID|30794|M|60.55,21.32|N|To Sage Liao.|
A Justice|QID|30805|M|60.55,21.32|N|From Sage Liao.|
A The Scent of Life|QID|30806|M|60.55,21.32|N|From Sage Liao.|
A By the Falls, For the Fallen|QID|30807|M|60.55,21.32|N|From Sage Liao.|
C By the Falls, For the Fallen|QID|30807|S|NC|M|60.17,31.11|
C Opalescent Blue Crab Shell|QID|30806|S|QO|Opalescent Blue Crab Shell: 1/1|M|59.61,22.26||N|Kill crabs until you get one.|
C Blackmane Mercenaries|QID|30805|S|QO|Blackmane Mercenaries slain: 6/6|M|62.4,23.0|
C Stolen Pandaren Spices|QID|30806|S|QO|Stolen Pandaren Spices: 8/8|M|59.61,22.26|N|Kill Balckmane mercenaries or loot barrels.|
K Kill Captain Ripflesh|QID|30805|T|Captain Ripflesh|QO|Captain Ripflesh slain: 1/1|M|62.14,23.99|
C Stolen Pandaren Spices|QID|30806|US|QO|Stolen Pandaren Spices: 8/8|M|59.61,22.26|N|Kill Balckmane mercenaries or loot barrels.|
C Blackmane Mercenaries|QID|30805|US|QO|Blackmane Mercenaries slain: 6/6|M|62.4,23.0|
C Opalescent Blue Crab Shell|QID|30806|US|QO|Opalescent Blue Crab Shell: 1/1|M|59.61,22.26||N|Kill crabs until you get one.|
C By the Falls, For the Fallen|QID|30807|US|NC|M|60.17,31.11|
T Justice|QID|30805|M|60.59,21.38|N|To Sage Liao.|
T The Scent of Life|QID|30806|M|60.59,21.38|N|To Sage Liao.|
T By the Falls, For the Fallen|QID|30807|M|60.59,21.38|N|To Sage Liao.|
A Preparing the Remains|QID|30819|M|60.59,21.38|N|From Sage Liao.|
T Preparing the Remains|QID|30819|M|63.12,29.33|N|To Li Hai.|
A A Funeral|QID|30820|M|63.12,29.33|N|From Li Hai.|
C A Funeral|QID|30820|NC|M|62.3,31.5;64.3,32.1;66.96,33.44|CC|N|Light the Incense of Life.|
T A Funeral|QID|30820|M|67.05,33.44|N|To Sage Liao.|
C Prophet Khar'zul|QID|31228|NC|QO|Speak with Mishi in Zouchin Village: 1/1|M|62.3,29.3|
C Slay Zandalari|QID|31228|S|QO|Zandalari forces slain: 12/12|M|74.20,10.61|
K Kill Prophet Khar'zul|QID|31228|T|Prophet Khar'zul|QO|Prophet Khar'zul slain: 1/1|M|76.2,8.9|
C Slay Zandalari|QID|31228|US|QO|Zandalari forces slain: 12/12|M|74.20,10.61|
F Zouchin Village|QID|31228|M|76.17,11.38|CC|N|Talk to Mishi for a ride back to the village.|
T Prophet Khar'zul|QID|31228|M|62.30,29.01|N|To Lorewalker Cho.|
r Repair/Restock|M|63.38,30.69|;currently the blacksmith is bugged and doesnt repair.

H One Keg|QID|30592|N|Fly if you did not reset your hearthstone earlier.|
A The Burlap Trail: To Burlap Waystation|QID|30592|M|58.04,61.49|N|From Brother Lintpocket.|
C Roadside Assistance|QID|30617|NC|M|58.76,62.49|
C The Burlap Trail: To Burlap Waystation|QID|30592|M|53.14,66.57|
T The Burlap Trail: To Burlap Waystation|QID|30592|M|51.69,67.80|N|To Brother Trailscenter.|
A The Rabbitsfoot|QID|30602|M|58.04,61.49|N|From Brother Trailscenter.|
C The Rabbitsfoot|QID|30602|M|49.07,70.42|N|He is hanging from a tree.|
A The Broketooth Ravage|QID|30603|M|49.07,70.42|N|From Brother Rabbitsfoot.|
C The Broketooth Ravage|QID|30603|NC|M|48.01,73.34|N|In Mo-Mo Treasure Chest inside the little cave.|

T The Rabbitsfoot|QID|30602|M|51.99,67.28|N|To Brother Rabbitsfoot.|
T The Broketooth Ravage|QID|30603|M|51.99,67.28|N|To Brother Rabbitsfoot.|
A A Monkey Idol|QID|30599|M|52.0,67.3|N|From Brother Rabbitsfoot|
A No Pack Left Behind|QID|30600|M|52.0,67.3|N|From Brother Rabbitsfoot|
A Breaking Broketooth|QID|30604|M|52.0,67.3|N|From Brother Rabbitsfoot|
C Breaking Broketooth|QID|30604|S|M|54.8,69.2|
C No Pack Left Behind|QID|30600|S|NC|M|54.9,73.6|
K Kill Ko Ko|QID|30599|T|Hateful Ko Ko|L|80429|N|Loot his corpse (literally).|M|52.3,71.4|
C Destroy Ko Ko's Altar|QID|30599|NC|QO|Destroy Ko Ko's Altar: 1/1|M|52.3,71.4|
K Kill Dak Dak|QID|30599|T|Dak Dak|L|80428|M|52.6,72.8|N|Loot his corpse (literally).|
C Destroy Dak Dak's Altar|QID|30599|NC|QO|Destroy Dak Dak's Altar: 1/1|M|56.9,71.0|
K Kill Tak Tak|QID|30599|T|Tak Tak|L|80430|N|Loot his corpse (literally).|
C Destroy Tak Tak's Altar|QID|30599|NC|QO|Destroy Tak Tak's Altar: 1/1|
C No Pack Left Behind|QID|30600|US|NC|M|54.9,73.6|
C Breaking Broketooth|QID|30604|US|M|54.8,69.2|
T A Monkey Idol|QID|30599|M|52.0,67.3|N|To Brother Rabbitsfoot|
T No Pack Left Behind|QID|30600|M|52.0,67.3|N|To Brother Rabbitsfoot|
A Bros Before Hozen|QID|30605|M|51.94,67.24|N|From Brother Rabbitsfoot.|
T Breaking Broketooth|QID|30604|M|52.0,67.3|N|To Brother Rabbitsfoot|
C Bros Before Hozen|QID|30605|M|50.5,64.2|
T Bros Before Hozen|QID|30605|M|50.60,64.08|N|To Brother Yakshoe.|
A Hozen Love Their Keys|QID|30607|M|50.60,64.08|N|From Brother Yakshoe.|
A The Snackrifice|QID|30608|M|50.60,64.08|N|From Brother Yakshoe.|
A Thumping Knucklethump|QID|30606|M|50.60,64.08|N|From Brother Yakshoe.|
C Thumping Knucklethump|QID|30606|S|M|50.2,64.3|
C The Snackrifice|QID|30608|S|NC|M|52.0,61.2|
K Kill Cho Cho the Wicked|QID|30607|T|Cho Cho the Wicked|QO|Yeti Shackle Key: 1/1|M|49.19,59.42|N|In the back of the cave. Kill him and get the key.|
C Hozen Love Their Keys|QID|30607|M|49.19,59.42|N|Click the boulder beside the big Yeti.|
C The Snackrifice|QID|30608|US|NC|M|52.0,61.2|
C Thumping Knucklethump|QID|30606|US|M|50.2,64.3|
T Hozen Love Their Keys|QID|30607|M|52.00,67.22|N|To Brother Yakshoe.|
T The Snackrifice|QID|30608|M|52.00,67.22|N|To Brother Yakshoe.|
A Grummle! Grummle! Grummle!|QID|30610|M|52.00,67.22|N|From Brother Yakshoe.|
T Thumping Knucklethump|QID|30606|M|51.98,67.21|N|To Brother Rabbitsfoot.|
A Unleash The Yeti!|QID|30611|M|51.98,67.21|N|From Brother Rabbitsfoot.|
C Grummle! Grummle! Grummle!|QID|30610|S|M|44.84,63.64|
C Unleash The Yeti!|QID|30611|M|46.56,62.95|
C Grummle! Grummle! Grummle!|QID|30610|US|M|44.84,63.64|
T Unleash The Yeti!|QID|30611|M|45.98,64.08|N|To Brother Rabbitsfoot.|
T Grummle! Grummle! Grummle!|QID|30610|M|45.98,64.08|N|To Brother Yakshoe.|
A The Leader Hozen|QID|30612|M|45.98,64.08|
C The Leader Hozen|QID|30612|M|46.15,63.24|

A The Burlap Trail: To Kota Basecamp|QID|30692|M|51.69,67.80|N|From Brother Trailscenter.|
C The Burlap Trail: To Kota Basecamp|QID|30692|M|43.77,69.04|

T The Leader Hozen|QID|30612|M|42.79,69.35|N|To Brother Rabbitsfoot.|
T The Burlap Trail: To Kota Basecamp|QID|30692|M|42.45,68.96|N|To Brother Oilyak.|
f Kota Basecamp|QID|99999|M|42.78,69.58|N|At Uncle Eastwind.|
h Kota Basecamp|QID|30747|M|42.66,69.72|N|At Clover Keeper.|
A Kota Blend|QID|30744|M|42.47,69.60|N|From Uncle Keenbean.|
A Trouble Brewing|QID|30745|M|42.47,69.60|N|From Uncle Keenbean.|
A Shut it Down|QID|30742|M|42.34,69.73|N|From Cousin Gootfur.|
A Gourmet Kafa|QID|30743|M|42.34,69.73|N|From Cousin Gootfur.|
C Gourmet Kafa|QID|30743|S|NC|M|39.99,71.67|N|Flag droppings (yes, it's another poop quest).|
C Trouble Brewing|QID|30745|S|M|37.83,77.90|N|Kill yetis.|
C Shut it Down|QID|30742|S|M|40.67,73.42|N|Kill the goats.|
C Kota Blend|QID|30744|NC|M|36.38,76.94|N|Pick up the berries from the ground.|
T Kota Blend|QID|30744|36.38,76.94|To UI Alert.|
A A Fair Trade|QID|30746|M|36.38,76.94|From UI Alert.|
C Shut it Down|QID|30742|US|M|40.67,73.42|N|Kill yetis.|
C Trouble Brewing|QID|30745|US|M|37.83,77.90|N|Kill yetis.|
C Gourmet Kafa|QID|30743|US|N|Flag droppings (yes, it's another poop quest).|
T A Fair Trade|QID|30746|M|36.95,76.16|N|To Nephew Burrberry.|
T Shut it Down|QID|30742|M|42.48,69.45|N|To Cousin Gootfur.|
T Gourmet Kafa|QID|30743|M|42.48,69.39|N|To Cousin Gootfur.|
T Trouble Brewing|QID|30745|M|42.48,69.45|N|To Cousin Gootfur.|
A The Burlap Grind|QID|30747|M|42.49,69.36|N|From Nephew Burrberry.|
C The Burlap Grind|QID|30747|M|49.53,66.89|N|Talk to Kota Kon. vehicle UI comes up. After finishing the objectives, exit vehicle close to the Burlap Trail Waystation.|

R One Keg|QID|30617|M|57.77,59.78|CC|
T Roadside Assistance|QID|30617|M|58.13,61.46|N|To Brother Lintpocket.|

F Eastwind Rest|QID|31511|FACTION|Horde|M|57.77,59.2|CC|N|At Little Cleankite.|
A Beyond the Wall|QID|31695|FACTION|Horde|M|62.36,79.65|N|From Elder Shiao.|;seems odd. is it really same QID even tho 2 seperate quest givers. ... its also the only QID listed on WOWHEAD?
C A Witness to History|QID|31511|FACTION|Horde|M|55.58,91.24|
R Shado-Pan Fallback|QID|31453|FACTION|Horde|CC|M|44.51,89.96|
T The Shado-Pan|QID|31453|FACTION|Horde|M|44.51,89.96|N|To Shado-Master Chong.|

F Westwind Rest|QID|31512|FACTION|Alliance|M|57.77,59.2|CC|N|At Little Cleankite.|
A Beyond the Wall|QID|31695|FACTION|Alliance|M|54.13,83.37|N|From Elder Tsulan.|;seems odd. is it really same QID even tho 2 seperate quest givers. ... its also the only QID listed on WOWHEAD?
C A Witness to History|QID|31512|FACTION|Alliance|M|55.58,91.24|
R Shado-Pan Fallback|QID|31455|FACTION|Alliance|CC|M|44.51,89.96|
T The Shado-Pan|QID|31455|FACTION|Alliance|M|44.51,89.96|N|To Shado-Master Chong.|

A Turnabout|QID|30670|M|44.49,89.88|N|From Shado-Master Chong.|
A The Defense of Shado-Pan Fallback|QID|30665|M|44.49,89.88|N|From Shado-Master Chong.|
C The Defense of Shado-Pan Fallback|S|QID|30665|M|44.45,88.63|
C Turnabout|QID|30670|S|M|41.29,86.60|
A Holed Up|QID|30682|NC|M|42.99,88.33|N|From Sya Zhong.|
C Holed Up|QID|30682|NC|QO|Ya Firebough rescued: 1/1|M|41.08, 87.03|
C Holed Up|QID|30682|NC|QO|Old Lady Fung rescued: 1/1|M|42.74, 85.76|
C Holed Up|QID|30682|NC|QO|Jin Warmkeg rescued: 1/1|M|43.86,86.22|
C Turnabout|QID|30670|US|M|41.29,86.60|
C The Defense of Shado-Pan Fallback|US|QID|30665|M|44.45,88.63|
T Turnabout|QID|30670|M|44.47,89.91|N|To Shado-Master Chong.|
A Unmasking the Yaungol|QID|30690|M|44.47,89.91|N|From Shado-Master Chong.|
T The Defense of Shado-Pan Fallback|QID|30665|M|44.47,89.91|N|To Shado-Master Chong.|
T Holed Up|QID|30682|M|44.47,89.91|N|To Shado-Master Chong.|
C Unmasking the Yaungol|QID|30690|T|Kobai|U|81741|M|45.28,86.63|N|Find Kobai, put the trap down in front of you, pull him and when it is cought, press the Extra button to start the fight with the Malevolent Fury.|
T Unmasking the Yaungol|QID|30690|M|44.48,89.91|N|To Shado-Master Chong.|
A To Winter's Blossom|QID|30699|M|44.48,89.91|N|From Shado-Master Chong.|
r Repair/Restock|QID|99999|M|44.23,90.25|N|At Fixxit Redhammer.|

f Shado-Pan Fallback|QID|99999|M|43.92,89.56|N|Up the stairs, at Kite Master Ni.|
H Kota Basecamp|QID|30747|N|Fly if your hearth isn't set to Kota Basecamp.|
T The Burlap Grind|QID|30747|M|42.49,69.28|N|To Nephew Burrberry.|

R Winter's Blossom|QID|30699|M|34.97,59.36|
T To Winter's Blossom|QID|30699|M|34.97,59.36|N|To Lin Silentstrike.|
A Honor, Even in Death|QID|30723|M|34.93,59.20|N|From Lin Silentstrike.|
A A Line Unbroken|QID|30715|M|35.14,59.59|N|From Ban Bearheart.|
f Winter's Blossom|QID|99999|M|34.55,59.00|N|At Kite Master Len.|
A Better Dead than Dread|QID|31847|M|34.55,59.00|N|From Kite Master Len. Requires level 89.|
C Honor, Even in Death|QID|30723|S|M|30.22,62.06|
C Released Shado-Master Zhiyao|QID|30715|NC|QO|Shado-Master Zhiyao Released From his Oath: 1/1|M|30.4,60.0|
C Released Liu of the Thousand Blows|QID|30715|NC|QO|Liu of the Thousand Blows Released From his Oath: 1/1|M|30.2,62.5|
C Released Shiya Boldblade|QID|30715|QO|NC|Shiya Boldblade Released From her Oath: 1/1|M|30.0,64.4|
C Honor, Even in Death|QID|30723|US|M|30.22,62.06|
T A Line Unbroken|QID|30715|M|35.16,59.61|N|To Ban Bearheart.|
T Honor, Even in Death|QID|30723|M|34.98,59.23|N|To Lin Silentstrike.|
A To the Wall!|QID|30724|M|35.01,59.22|N|From Lin Silentstrike.|

C To the Wall!|QID|30724|M|34.55,59.05|
T To the Wall!|QID|30724|M|29.31,62.31|N|To Suna Silentstrike.|
A Off the Wall!|QID|30750|M|29.30,62.32|N|From Suna Silentstrike.|
A A Terrible Sacrifice|QID|30751|M|29.25,62.33|N|From Lao-Chin the Iron Belly.|
C A Terrible Sacrifice|QID|30751|S|NC|M|26.27,59.10|
C Off the Wall!|QID|30750|M|26.98,59.95|N|Right Click to boot them off the wall (at low health).|
C A Terrible Sacrifice|QID|30751|US|NC|M|26.27,59.10|
T Off the Wall!|QID|30750|M|29.28,62.22|N|To Suna Silentstrike.|
T A Terrible Sacrifice|QID|30751|M|29.28,62.22|N|To Lao-Chin the Iron Belly.|
A Lao-Chin's Gambit|QID|30994|M|29.28,62.22|N|From Suna Silentstrike.|
C Lao-Chin's Gambit|QID|30994|M|29.31,62.25|
T Lao-Chin's Gambit|QID|30994|M|31.85,60.18|N|To Lao-Chin the Iron Belly.|
A Do a Barrel Roll!|QID|30991|M|31.85,60.18|N|From Lao-Chin the Iron Belly.|
C Do a Barrel Roll!|QID|30991|M|30.15,63.94|N|You can steer towards the target, then press 1 to blow up the barrel.|
T Do a Barrel Roll!|QID|30991|M|31.82,60.16|N|To Lao-Chin the Iron Belly.|
A Finish This!|QID|30992|M|31.82,60.16|N|From Lao-Chin the Iron Belly.|
C Finish This!|QID|30992|M|31.30,61.61|
T Finish This!|QID|30992|M|31.30,61.61|N|To Ban Bearheart.|
A Where are My Reinforcements?|QID|30993|M|31.30,61.61|N|From Ban Bearheart.|
;A My Husband...|QID|30768|M|31.30,61.61|N|From Suna Silentstrike.|;This quest was not offered to me in Kun-Lai Summit, it might have been moved in some other zone.
C Where are My Reinforcements?|QID|30993|M|34.08,58.62|Talk to Ban while down in the valley and then again beside the balloon.)
T Where are My Reinforcements?|QID|30993|M|35.29,49.45|N|To Ban Bearheart. Follow Ban, hop in his balloon.|
A Unbelievable!|QID|30752|M|35.29,49.45|N|From Ban Bearheart.|
C Unbelievable!|QID|30752|M|36.75,47.67|
T Unbelievable!|QID|30752|M|36.75,47.67|N|To Ban Bearheart.|
A Into the Monastery|QID|31030|M|36.75,47.67|N|From Ban Bearheart. This is a dungeon quest.|

N Congratulations|N|You have finished Kun-Lai Summit. You may have also achieved level 90 and want to explore Vale of Eternal Blossoms. If you want to continue with the guide Townlong Steppes will load when you check off this step.|

]]
end)
