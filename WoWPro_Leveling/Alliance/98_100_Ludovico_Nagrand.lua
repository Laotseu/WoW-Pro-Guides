
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/alliance_nagrand_source_code
-- Date: 2014-12-03 12:25
-- Who: Ludovicus
-- Log: Finished play-through.

-- URL: http://wow-pro.com/node/3618/revisions/27068/view
-- Date: 2014-12-02 01:46
-- Who: Ludovicus
-- Log: Played through [Spiritual Matters].

-- URL: http://wow-pro.com/node/3618/revisions/27064/view
-- Date: 2014-12-01 01:58
-- Who: Ludovicus
-- Log: Removed Stable quests.  Played through [The Call of Oshu'gun].

-- URL: http://wow-pro.com/node/3618/revisions/27063/view
-- Date: 2014-11-30 15:31
-- Who: Ludovicus
-- Log: Played through [THAELIN!] and removed duplicates at the end.

-- URL: http://wow-pro.com/node/3618/revisions/27062/view
-- Date: 2014-11-30 03:14
-- Who: Ludovicus
-- Log: Played through [Whacking Weeds]

-- URL: http://wow-pro.com/node/3618/revisions/27061/view
-- Date: 2014-11-29 12:55
-- Who: Ludovicus
-- Log: Played through [The Honor of a Blademaster] and now have too many followers!

-- URL: http://wow-pro.com/node/3618/revisions/27030/view
-- Date: 2014-11-22 12:04
-- Who: Ludovicus
-- Log: Corrected tags.

-- URL: http://wow-pro.com/node/3618/revisions/27026/view
-- Date: 2014-11-20 18:01
-- Who: Fluclo

-- URL: http://wow-pro.com/node/3618/revisions/27019/view
-- Date: 2014-11-17 20:29
-- Who: Ludovicus
-- Log: Updated zone to have @Draenor

-- URL: http://wow-pro.com/node/3618/revisions/27018/view
-- Date: 2014-11-17 20:21
-- Who: Ludovicus
-- Log: Warning.

-- URL: http://wow-pro.com/node/3618/revisions/26997/view
-- Date: 2014-11-14 20:31
-- Who: Ludovicus
-- Log: Use the right faction, stupid!

-- URL: http://wow-pro.com/node/3618/revisions/26993/view
-- Date: 2014-11-14 17:44
-- Who: Ludovicus
-- Log: corrected links

-- URL: http://wow-pro.com/node/3618/revisions/26992/view
-- Date: 2014-11-14 17:44
-- Who: Ludovicus
-- Log: Init

local guide = WoWPro:RegisterGuide('LudoNagrand', 'Leveling', 'Nagrand@Draenor', 'Ludovicus', 'Alliance')
WoWPro:GuideLevels(guide,98, 100, 98.7)
WoWPro:GuideNextGuide(guide, 'nil')
WoWPro:GuideSteps(guide, function()
return [[

N Warning!|QID|34675|N|This guide is partially written. It has been played through once and still needs TLC. Use at your own risk|

L Level 98 |QID|34674;37184|LVL|98|N|This guide requires a minimum level of 98 to do.|
N Welcome to Nagrand|QID|34674;37184|ACTIVE|34674;37184|S|N|If you want the rare elite and treasures included in this guide, please set your Rank to 3.|

T News from Nagrand|QID|36601;36606|M|38.36,36.75|Z|Lunarfall|N|To Baros Alexston at your garrison.|U|110560|
A Taking the Fight to Nagrand|QID|34674;37184|M|38.36,36.75|Z|Lunarfall|N|From Baros Alexston at your garrison.|U|110560|

F Nagrand|QID|34674;37184|M|47.90,49.72|Z|Lunarfall|CHAT|N|Speak with Dungar Longdrink and tell him you need a flight to the border of Nagrand.|
K Grizlemaw|QID|35784|M|89.46,72.93|N|*Rare Kill*\nOn the path to your left. Drops Grizzled Wolfskin Cloak worth 22g.|RANK|3|
T Taking the Fight to Nagrand|QID|34674;37184|M|86.40,66.20|N|To Lieutenant Balfor at the Wrecked Caravan.|

A The Might of the Warsong|QID|34675|M|88.40,66.20|N|From Lieutenant Balfor.|PRE|34674;37184|
K Malroc Stonesunder |QID|35932|M|81.09,59.77|N|*Rare Kill*\nDrops Malroc's Staff of Command worth 54g.|RANK|3|
K Redclaw the Feral |QID|35712|M|73.57,58.02|N|*Rare Kill*\nDrops Redclaw's Gutripper worth 43g.|RANK|3|
f Telaari Station|M|63.64,61.55|N|From Gryphon Master John Shelby|
T The Might of the Warsong|QID|34675|M|63.52,61.88|N|To Rangari D'kaan at Telaari Station.|

A Up and Running |QID|34678|M|63.52,61.88|N|From Rangari D'kaan.|
C Up and Running |QID|34678|NC|QO|3|N|Loot the Transmission Flywheel, inside the hut.|M|63.67,62.37|
C Up and Running |QID|34678|NC|QO|2|N|Loot the Prop Rotor, just behind Gryphon Master.|M|63.75,61.56|
C Up and Running |QID|34678|NC|QO|1|N|Loot Assorted Engineering Parts on the floor next to Captain Washburn.|M|62.09,62.12|
T Up and Running |QID|34678|M|63.07,61.96|N|To Thaelin Darkanvil.|

A Operation: Surprise Party |QID|34682|M|63.07,61.96|N|From Thaelin Darkanvil.|
C Operation: Surprise Party |QID|34682|NC|N|Mount Thaelin's Copter.|M|63.02,61.97|
T Operation: Surprise Party |QID|34682|N|To Rangari Ogir in Rangari Overlook.|M|65.88,68.62|

A Mo'mor Might Know |QID|34716|N|From Rangari Ogir.|M|65.88,68.62|
A Operation: Just Arrowhead |QID|34717|N|From Rangari Ogir.|M|65.88,68.62|
R Telaar|QID|34716;34717|NC|N|Click on the Rappelling Rope to get down to Telaar.|M|65.91,68.56|ACTIVE|34716;34717|
C Operation: Just Arrowhead |QID|34717|N|Kill Warsong forces at Telaar. |S|

T Mo'mor Might Know |QID|34716|N|To Vindicator Mo'mor, chained up inside the building.|M|66.74,68.64|
A The Others |QID|34718|N|From Vindicator Mo'mor|M|66.74,68.64|PRE|34716|
A ... and My Hammer |QID|34719|N|From Vindicator Mo'mor|M|66.74,68.64|PRE|34716|

C The Others |QID|34718|N|Speak to Caregiver Felaani.|QO|2|CHAT|M|68.50,67.07|
C The Others |QID|34718|N|Speak to Hansel Heavyhands.|QO|3|CHAT|M|67.63,64.49|
C ... and My Hammer |QID|34719|N|Loot Mo'mor's Holy Hammer.|NC|M|65.85,62.90|
C The Others |QID|34718|N|Speak to Arbiter Khan to check for a pulse. His corpse is on the first floor of the building.|QO|1|CHAT|

T The Others |QID|34718|N|To Vindicator Mo'mor|M|66.74,68.64|
T ... and My Hammer |QID|34719|N|To Vindicator Mo'mor|M|66.74,68.64|
A Shields Down! |QID|34746|N|From Vindicator Mo'mor|M|66.74,68.64|PRE|34718;34719|
C Shields Down! |QID|34746|N|Click on the Arkonite Crystal to destroy it|QO|1|NC|M|66.80,65.50|
C Shields Down! |QID|34746|N|Wait a moment for Packleader Karagora to spawn, then kill and loot him for the Garrison Blueprints|QO|2|

C Operation: Just Arrowhead |QID|34717|N|Finish killing Warsong forces at Telaar.|US|
T Operation: Just Arrowhead |QID|34717|M|63.52,61.88|N|To Rangari D'kaan at Telaari Station.|
T Shields Down! |QID|34746|M|63.07,61.96|N|To Thaelin Darkanvil.|

A A Choice to Make |QID|34769|M|63.07,61.96|N|From Thaelin Darkanvil.|
C A Choice to Make |QID|34769|M|63.07,61.96|N|Click on the Drafting Table and select your preferred outpost structure.\n\nRangari Coral: Provides a mount that you can fight and loot whilst mounted.\nTelaari Tank: Provides a siege engine to assist in battle.|NC|
T A Choice to Make |QID|34769|M|63.52,61.88|N|To Rangari D'kaan.|

A Trouble at the Overwatch |QID|35148|M|63.53,61.82|N|From Hansel Heavyhands|PRE|34769|
A The Friend o' My Enemy |QID|34952|M|63.53,61.82|N|From Hansel Heavyhands|PRE|34769|
A They Call Him Lantresor of the Blade |QID|34951|M|63.49,61.86|N|From Vindicator Mo'mor|
h Telaari Station |QID|35148|N|With Caregiver Felaani|M|63.57,62.46|

A That Pounding Sound |QID|35337|N|From Kia Herman|M|63.54,61.47|
A Shooting the Breeze |QID|35338|N|From Rangari Laara|M|63.49,61.41|

;Show the two animal quests until you get to Mar'gok's Overwatch.
C That Pounding Sound |QID|35337|N|Kill and loot the Leatherhide Calf, Clefthoof and Bull for their ears.|S|ACTIVE|35148|
C Shooting the Breeze |QID|35338|N|Kill and loot the Breezestrider Colt, Talbuk and Stallion for their Horns|S|ACTIVE|35148|

K Gnarlhoof the Rabid |QID|35717|M|66.67,56.37|N|*Rare Kill*\nDrops Rabid Talbuk Horn trinket worth 24g.|RANK|3|

A The Good Doctor |QID|35146|N|From Marybelle Walsh|M|77.46,47.38|
A Whacking Weeds |QID|36273|N|From Marybelle Walsh|M|77.46,47.38|

A The Missing Caravan |QID|34598|N|From Pyxni Pennypocket|M|78.60,48.54|
A Declawing The Competition|QID|34512|N|From Pyxni Pennypocket|M|78.60,48.54|

A Gazmolf Futzwangler and the Highmaul Crusade|QID|34810|N|From Gabby Goldsnap|M|79.83,48.83|
f The Ring of Trials |QID|34662|N|With Biggy Warprofits|M|79.78,49.76|

A Ring of Trials: Crushmaul |QID|34662|N|From Dexyl Deadblade|M|79.46,50.31|
C Ring of Trials: Crushmaul |QID|34662|QO|1|N|Speak to Guzrug the Tiny to start the fight.|CHAT|M|77.65,49.59|
C Ring of Trials: Crushmaul|QID|34662|M|78.26,50.72|QO|2|N|Kill Crushmaul. Don't stand in front of his boar when it is running around riderless or you will be stunned.|
T Ring of Trials: Crushmaul|QID|34662|M|79.46,50.28|N|To Dexyl Deadblade.|
A Ring of Trials: Raketalon|QID|34663|M|79.46,50.28|N|From Dexyl Deadblade.|PRE|34662|
C Ring of Trials: Raketalon|QID|34663|M|77.61,49.55|CHAT|QO|1|N|Speak to Guzrug the Tiny to start the fight.|
C Ring of Trials: Raketalon|QID|34663|M|78.26,50.72|QO|2|N|Kill Raketalon. Do not ignore the adds, kill them quickly and then back to Raketalon.|
T Ring of Trials: Raketalon|QID|34663|M|79.46,50.28|N|To Dexyl Deadblade.|
A Ring of Trials: Hol'yelaa|QID|34664|M|79.46,50.31|N|From Dexyl Deadblade.|PRE|34663|
C Ring of Trials: Hol'yelaa|QID|34664|M|77.61,49.55|QO|1|CHAT|N|Speak to Guzrug the Tiny to start the fight.|
C Ring of Trials: Hol'yelaa|QID|34664|M|78.26,50.72|QO|2|N|Kill Hol'yelaa. Move out of melee range when he casts his groundstop, but run back when he is done as he will not come to you.|
T Ring of Trials: Hol'yelaa|QID|34664|M|79.46,50.28|N|To Dexyl Deadblade.|
A Ring of Trials: Captain Boomspark|QID|34665|M|79.46,50.31|N|From Dexyl Deadblade.|PRE|34664|
C Ring of Trials: Captain Boomspark|QID|34665|M|77.61,49.55|QO|1|CHAT|N|Speak to Guzrug the Tiny to start the fight.|
C Ring of Trials: Captain Boomspark|QID|34665|M|78.26,50.72|QO|2|N|Kill The Burninator. Try to position him over the bombs when they are going to explode and NOT yourself.|
T Ring of Trials: Captain Boomspark|QID|34665|M|79.46,50.28|N|To Dexyl Deadblade.|
A Ring of Trials: Roakk the Zealot|QID|34666|M|79.46,50.31|N|From Dexyl Deadblade.|PRE|34665|
C Ring of Trials: Roakk the Zealot|QID|34666|M|77.61,49.55|QO|1|CHAT|N|Speak to Guzrug the Tiny to start the fight.|
C Ring of Trials: Roakk the Zealot|QID|34666|M|78.26,50.72|QO|2|N|Kill Roakk the Zealot. Turn away when he casts blinding light or else you will be stunned for several seconds.|
T Ring of Trials: Roakk the Zealot|QID|34666|M|79.46,50.28|N|To Dexyl Deadblade.|

A Tastes Like Chicken |QID|34869|N|From Digrem Orebar|M|79.20,52.62|

T The Missing Caravan |QID|34598|N|To Greezlex|M|79.01,58.92|
A Gobnapped |QID|34515|N|From Greezlex|M|79.01,58.92|
A They've Got The Goods! |QID|34514|N|From Greezlex|M|79.01,58.92|

A WANTED: Razorpaw! |QID|34513|N|From Bounty Board.|M|78.99,58.94|
R Sabermaw |QID|0|N|Run to Sabermaw|M|77.41,59.45|ACTIVE|34515;34514;34513|

A My Precious! |QID|34516|N|From Bazwix, he will run to your location when you enter Sabermaw.|

C Gobnapped |QID|34515|N|Click the Sabermaw Cages to save the Goblin Traders.|NC|S|
C Declawing The Competition|QID|34512|N|Kill and loot the Sabermaw for their claws.|S|
C Tastes Like Chicken |QID|34869|N|Kill and loot the Windroc for Raw Windroc.|S|
C They've Got The Goods! |QID|34514|N|Loot the Stolen Goods from the floor|S|NC|

C My Precious! |QID|34516|N|Loot Bazwix's Treasure from the floor up on the ridge. First coordinate is ramp up, second coordinate is Bazwix's Treasure location.|M|75.04,61.13;74.72,61.54|CN|NC|
T My Precious! |QID|34516|N|To Bazwix, he will come to your location.|M|74.72,61.54|

C WANTED: Razorpaw! |QID|34513|N|Kill Razorpaw, he's inside the cave.|M|75.13,62.49|

C Gobnapped |QID|34515|N|Finish clicking the Sabermaw Cages to save the Goblin Traders.|NC|US|
C They've Got The Goods! |QID|34514|N|Finish looting the Stolen Goods|US|NC|
C Declawing The Competition|QID|34512|N|Kill and loot the Sabermaw for their claws.|US|
C Tastes Like Chicken |QID|34869|N|Finish killing and looting the Windroc for Raw Windroc. A load of neutral ones can be found up on the glade.|US|M|77.37,66.53|

l Warsong Spear |QID|35682|N|Warsong Spear: Lootable object for Garrison Resources. At the first coordinate, there's a path, head up it (the path will have blue flags with gold bars on it). At the top (second coordinate) use the XXX, and fly to the third coordinate.|M|78.33,71.83;76.13,73.02;76.1,70.0|CN|RANK|3|
l Warsong Spoils |QID|35682|N|Warsong Spoils: Lootable object for Garrison Resources. Path at first coordinate, Glider at second coordinate, head to third coordinate. Run across ledge to fourth coordinate, run up the mountain to the fifth coordinate. Fly to the sixth coordinate (it's at the top of the tower)|M|78.25,71.90;76.10,73.00;76.00,70.60;75.95,65.85;75.70,64.50;80.60,60.60|CN|RANK|3|
K Berserk T-300 Series Mark II |QID|35735|N|*Rare Kill*\nPath at first coordinate, Glider at second coordinate, head to third coordinate. Run across ledge to fourth coordinate, run up the mountain to the fifth coordinate. Fly to cave entrance|M|78.25,71.90;76.10,73.00;76.00,70.60;75.95,65.85;75.70,64.50;76.93,64.37|CN|RANK|3|
l Saberon Stash |QID|36102|N|Saberon Stash: Lootable object for Garrison Resources. Path at first coordinate, Glider at second coordinate, head to third coordinate. Run across ledge to fourth coordinate, run half way up the mountain, then shimmy around the side (you'll see it before you need to walk down the mountain to it). Fly to cave entrance|M|78.25,71.90;76.10,73.00;76.00,70.60;75.95,65.85;75.19,64.93|CN|RANK|3|
K Soulfang |QID|36128|N|*Rare Kill*\nJump down the mountain to Sabermaw Den. This has a long time respawn, so if he's not there, skip quest and come back later.|M|74.70,64.05|RANK|3|

;Mar'gok's Overwatch
T Trouble at the Overwatch |QID|35148|M|78.79,69.26|N|To Rangari Eleena at Mar'gok's Overwatch.|
A Obtaining Ogre Offensive Orders |QID|34593|M|78.79,69.26|N|From Rangari Eleena|
A Obliterating Ogres |QID|34572|M|78.79,69.26|N|From Rangari Eleena|

C Obliterating Ogres|QID|34572|S|M|83.38,74.85|N|Kill the Ogres.|
A Removing the Paper Trail|QID|34597|M|81.34,70.38|N|From the Ogre Scrolls.|
C Removing the Paper Trail|QID|34597|NC|M|82.01,73.68|S|N|Click the Boxes of Ogre Research to destroy them.|
K Thulgork|QID|34593|QO|2|M|83.20,70.39|T|Thulgork|N|Kill and loot Thurgork for the orders.|
K Crulgorosh|QID|34593|QO|1|M|84.05,73.42|T|Crulgorosh|N|Kill and loot Crulgorosh for the orders. He can be found in the building up the stairs and to the left.|

K Warmaster Blugthol |QID|34645|M|82.79,76.03|N|*Rare Kill*\nDrops Blug'thol's Bloody Bracers worth 14g.|RANK|3|

C Removing the Paper Trail|QID|34597|NC|M|82.01,73.68|US|N|Finish clicking the Boxes of Ogre Research to destroy them.|
C Obliterating Ogres|QID|34572|US|M|83.38,74.85|N|Finish killing the Ogres.|

T Obtaining Ogre Offensive Orders|QID|34593|M|84.06,76.85|N|To Rangari Mirana, who has moved up to the fourth floor of the overwatch.|
A Reglakk's Research|QID|34596|M|84.06,76.85|N|From Rangari Mirana.|PRE|34593|
T Obliterating Ogres|QID|35155|M|84.06,76.85|N|To Rangari Mirana.|
T Removing the Paper Trail|QID|34597|M|84.06,76.85|N|To Rangari Mirana.|
A Removing the Reinforcements|QID|34877|M|84.06,76.85|N|From Rangari Mirana.|PRE|34593|

C Removing the Reinforcements|QID|34877|M|82.60,81.05|N|Click the Portal to Highmaul to destroy it.|NC|
C Reglakk's Research|QID|34596|T|Bulgorg the Wind Slayer|M|81.63,76.61|N|Bring Grand Magister Reglakk down to 50%, then kill Bulgore the Wind Slayer when spawned.|

;Show the two animal quests again until you get to Hallvalor.
C That Pounding Sound |QID|35337|N|Kill and loot the Leatherhide Calf, Clefthoof and Bull for their ears.|S|ACTIVE|34951|
C Shooting the Breeze |QID|35338|N|Kill and loot the Breezestrider Colt, Talbuk and Stallion for their Horns|S|ACTIVE|34951|

R Hallvalor |QID|34951|M|84.75,58.35|N|Head to Hallvalor.|
C The Friend o' My Enemy|QID|34952|M|85.42,55.30|N|Kill the Burning Blade forces at Hallvalor.|S|

T They Call Him Lantresor of the Blade|QID|34951|M|85.41,54.58|N|To Lantresor of the Blade.|
A The Blade Itself|QID|34954|M|85.42,54.59|N|From Lantresor of the Blade.|
A Not Without My Honor|QID|34955|M|85.42,54.59|N|From Lantresor of the Blade.|

C Not Without My Honor|QID|34955|S|NC|M|84.88,55.33|N|These treasure boxes are located inside many of the buildings. One of them will have his banner.|
C The Blade Itself|QID|34954|M|85.97,53.89|T|Instructor Luhk|N|Kill and loot Instructure Luhk for his blade.|
K Hyperious |QID|34862|M|86.60,56.34;86.73,55.44;87.08,54.22|N|*Rare Kill*\nUse the Mysterious Braziers to summon Hyperious. Drops the Smouldering Heart of Hyperious trinket worth 26g.|RANK|3|CN|
C Not Without My Honor|QID|34955|US|NC|M|84.88,55.33;84.88,55.32;85.83,57.14;87.34,58.19|CN|N|These treasure boxes are located inside many of the buildings. One of them will have his banner.|

T The Blade Itself|QID|34954|M|85.44,54.60|N|To Lantresor of the Blade.|
T Not Without My Honor|QID|34955|M|85.44,54.60|N|To Lantresor of the Blade.|

A Meet Me in the Cavern|QID|34956|M|85.44,54.60|N|From Lantresor of the Blade.|
C The Friend o' My Enemy|QID|34952|M|85.42,55.30|N|Finish this up before you go in the Cavern as the ones inside don't count and when you come out you will be neutral to them.|US|
T Meet Me in the Cavern|QID|34956|M|89.99,55.94|N|To Lantresor of the Blade.|

A Challenge of the Masters|QID|34957|M|89.99,55.94|N|From Lantresor of the Blade.|Z|The Master's Cavern|
C Challenge of the Masters|QID|34957|M|53.11,68.60|N|Kill the various challengers up to Warlord Dharl of the Thrice-Bloodied Blade.|Z|The Master's Cavern|

H Telaari Post |QID|34868|N|Use your hearthstone to return to Telaari Post.|ACTIVE|34596;34877;34957;34952|

T Reglakk's Research|QID|34596|M|63.52,61.88|N|From Rangari D'kaan.|
T Removing the Reinforcements|QID|34877|M|63.52,61.88|N|From Rangari D'kaan.|
T Challenge of the Masters|QID|34957|M|63.52,61.88|N|From Rangari D'kaan.|
A Along the Riverside |QID|35059|M|63.52,61.88|N|To Rangari D'kaan.|
A Nobundo Sends Word |QID|35332|M|63.52,61.88|N|To Rangari D'kaan.|

T The Friend o' My Enemy|QID|34952|US|M|63.54,61.84|N|To Hansel Heavyhands|
A The Honor of a Blademaster|QID|34747|N|From Lantresor of the Blade.|M|64.23,59.57|

;Show the two animal quests again until you get to the Ring of Trials.
C Shooting the Breeze |QID|35338|N|Kill and loot the Breezestrider Colt, Talbuk and Stallion for their Horns|S|ACTIVE|34869|
C That Pounding Sound |QID|35337|N|Kill and loot the and looting the Leatherhide Calf, Clefthoof and Bull for their ears.|S|ACTIVE|34869|

T Gazmolf Futzwangler and the Highmaul Crusade|QID|34810|N|To Gazmolf Futzwangler|M|71.13,52.35|
A A Lesson in Minerology |QID|34809|N|From Gazmolf Futzwangler|M|71.13,52.35|PRE|34810|
A Good Help is Hard to Find |QID|34811|N|From Trixi Leroux|M|71.11,52.42|PRE|34810|

C A Lesson in Minerology |QID|34809|N|Kill and loot the Raging Crusher for the Earthen Core.|S|
C Good Help is Hard to Find |QID|34811|N|Loot the Loose Soil for the Nagrand Antiquity.|NC|M|68.50,53.50|S|
K Greatfeather |QID|35714|M|66.75,51.25|N|*Rare Kill*\nDrops a cloth robe worth 30g.|RANK|3|
C Good Help is Hard to Find |QID|34811|N|Loot the Loose Soil for the Nagrand Antiquity.|NC|M|68.50,53.50|US|
C A Lesson in Minerology |QID|34809|N|Kill and loot the Raging Crusher for the Earthen Core.|US|M|68.50,53.50|

T A Lesson in Minerology |QID|34809|N|To Gazmolf Futzwangler|M|71.13,52.35|
T Good Help is Hard to Find |QID|34811|N|To Trixi Leroux|M|71.11,52.42|

A A Lesson in Teamwork |QID|35663|N|From Gazmolf Futzwangler|M|71.13,52.35|PRE|34809;34811|
A A Lesson in Archaeology |QID|35632|N|From Gazmolf Futzwangler|M|71.13,52.35|PRE|34809;34811|

R Vault of the Titan |QID|35663|N|Head to the Vault of the Titan.|M|67.20,49.55|
l Highmaul Sledge |QID|36039|M|67.39,49.09|N|Up on the side under the flag. Gives a 605 Str/Stam ring.|RANK|3|
C A Lesson in Teamwork |QID|35663|N|Loot the Ancient Reliquary from the ground or kill and loot the Highmaul.|NC|S|
C A Lesson in Archaeology |QID|35632|N|Deploy the Teleportation Beacon.|NC|QO|1|M|70.75,47.50|
C A Lesson in Archaeology |QID|35632|N|Wait for the dialog to finish.|NC|QO|2|M|70.75,47.50|
;C A Lesson in Archaeology |QID|35632|QO|1|M|70.0,40.3|Z|Nagrand|; Vault of the Titan |Z|950;11|
C A Lesson in Teamwork |QID|35663|N|Finish looting the Ancient Reliquary from the ground or kill and loot the Highmaul.|NC|US|M|68.85,48.65|

T A Lesson in Teamwork |QID|35663|N|To Gazmolf Futzwangler|M|71.13,52.35|
T A Lesson in Archaeology |QID|35632|N|To Gazmolf Futzwangler|M|71.13,52.35|

H Telaari Station |QID|35146;36273|N|Use your hearthstone to return to Telaari Station.|
F The Ring of Trials|QID|34869|M|63.64,61.55|N|To John Shelby|
C Fruitful Ventures |QID|34819|N|Loot the Nagrand Cherry just North of the ring of trials.|M|79.00,42.50|NC|
T Fruitful Ventures |QID|34819|M|79.23,52.65|N|To Digrem Orebar|
A New Babies |QID|34900|M|79.23,52.65|N|To Digrem Orebar|
C New Babies |QID|34900|M|44.00,49.40;48.20,60.60;50.20,46.20;50.60,61.20;58.20,55.40;60.00,50.40;60.80,47.20;63.00,49.80;64.00,38.00;65.60,45.60;67.20,36.40;67.80,61.20;69.80,65.80;70.00,16.60;71.00,52.40;73.00,36.00;75.60,46.20;77.80,60.80;78.20,33.40;82.80,48.80;84.60,60.00;85.40,50.80;61.50,45.00;79.20,52.50;65.50,39.90;71.00,58.30;60.60,66.75;75.33,57.45|CN|N|Find them near bodies of water. Only one per group. If you kill one, you can't keep it.|T|Tenderhoof Meadowstomper|
T New Babies |QID|34900|M|79.23,52.65|N|To Digrem Orebar|

R Spiteleaf Thicket |QID|35146;36273|N|To Spiteleaf Thicket.|M|85.11,29.47|ACTIVE|35146;36273|
C Whacking Weeds |QID|36273|N|Kill the Spiteleaf Podlings.|S|
R Spiteleaf Burrow |QID|35146|N|To Spiteleaf Burrow (head up the left path)|ACTIVE|35146|

C The Good Doctor |QID|35146|N|Speak to Dr. Hadley Ricard to save him.|CHAT|M|83.20,22.60|

T The Good Doctor |QID|35146|N|To Dr. Hadley Ricard|M|86.64,28.33|
A The Search For Research |QID|36275|N|From Dr. Hadley Ricard|M|86.64,28.33|PRE|35146|
A A Fascinating Fungus |QID|36284|N|From Dr. Hadley Ricard|M|86.64,28.33|PRE|35146|

C A Fascinating Fungus |QID|36284|N|Either loot from the ground, or kill and loot the Spore Giant for the Fungal Spores.|S|
C The Search For Research |QID|36275|N|Recover the Expedition Supplies|QO|2|NC|M|86.07,20.46|
C The Search For Research |QID|36275|N|Recover the Research Journal|QO|1|NC|M|88.9,19.8|
C The Search For Research |QID|36275|N|Recover the Anti-Fungal Boots|QO|3|NC|M|91.8,21.7|
C A Fascinating Fungus |QID|36284|N|Finish looting from the ground, or killing and looting the Spore Giant for the Fungal Spores.|US|

T The Search For Research |QID|36275|N|To Dr. Hadley Ricard|M|86.64,28.33|
T A Fascinating Fungus |QID|36284|N|To Dr. Hadley Ricard|M|86.64,28.33|
A Dirgemire |QID|36285|N|From Dr. Hadley Ricard|M|86.64,28.33|PRE|36275;36284|

R Decaying Grotto|QID|36285|M|86.41,16.19|ACTIVE|36285|N|Head to the Decaying Grotto, this is an underwater cavern.|
K Dirgemire |QID|36285|T|Dirgemire|N|Kill and loot Dirgemire for the Fungal Brain.|M|84.34,17.23|

T Dirgemire |QID|36285|N|To Dr. Hadley Ricard|M|86.64,28.33|
C Whacking Weeds |QID|36273|N|Finish killing the Spiteleaf Podlings.|US|

R Snarlpaw Ledge |QID|37318|N|Run to Snarlpaw Ledge.|M|79.13,33.15|
A The Dead Do Not Forget... |QID|37318|N|From Murgok|M|79.47,30.28|

C The Dead Do Not Forget... |QID|37318|N|Loot the Ancient Snarlpaw Skulls.|NC|S|
K Hunter Blacktooth |QID|35923|N|*Rare Kill*\nDrops a mace worth 55g.|RANK|3|M|80.58,30.56|
C The Dead Do Not Forget... |QID|37318|N|Loot the Ancient Snarlpaw Skulls.|NC|US|
T The Dead Do Not Forget... |QID|37318|N|To Boneseer's Cauldron|

C Shooting the Breeze |QID|35338|N|Kill and loot the Breezestrider Colt, Talbuk and Stallion for their Horns|S|
C That Pounding Sound |QID|35337|N|Kill and loot the and looting the Leatherhide Calf, Clefthoof and Bull for their ears.|S|
C Fruitful Ventures |QID|34819|N|Loot the Nagrand Cherry|M|79.00,42.50|NC|S|
K Flinthide |QID|35893|M|69.85,42.00|N|*Rare Kill*\nDrops a shield worth 27g.|RANK|3|
C Fruitful Ventures |QID|34819|N|Loot the Nagrand Cherry|M|79.00,42.50|NC|US|
C Shooting the Breeze |QID|35338|N|Finish Killing and Looting the Breezestrider Colt, Talbuk and Stallion for their Horns|US|M|79.00,42.50|
C That Pounding Sound |QID|35337|N|Finish Killing and Looting the and looting the Leatherhide Calf, Clefthoof and Bull for their ears.|US|M|79.00,42.50|

T Whacking Weeds|QID|36273|M|77.42,47.36|N|To Marybelle Walsh|

T Along the Riverside |QID|35059|N|To Yrel at Yrel's Watch.|M|61.98,40.54|
A Terms of Surrender |QID|35060|N|From Yrel|M|61.98,40.54|PRE|35059|
f Yrel's Watch|QID|35060|N|With Felicia Maline|M|62.67,40.64|
T Terms of Surrender |QID|35060|N|To Uruk Foecleaver in Lok-rath.|M|55.49,42.10|

A The Pride of Lok-rath |QID|35061|N|From Uruk Foecleaver|M|55.49,42.10|PRE|35060|
A Silence the War Machines |QID|35067|N|From Lieutenant K. K. Lee|M|55.46,42.10|PRE|35060|
A If They Won't Surrender... |QID|35068|N|From Lieutenant K. K. Lee|M|55.46,42.10|PRE|35060|

C Silence the War Machines |QID|35067|NC|N|Destroy the War Machines|S|
C If They Won't Surrender... |QID|35068|N|Kill the Lok-rath enemy forces.|S|
A Terror of Nagrand |QID|35069|N|From Fallen Alliance Soldier|M|56.08,43.77|
C Terror of Nagrand |QID|35069|N|Head into Terror's Cave, then kill and loot Shagor for his collar.|M|58.36,43.63|
K Uruk Foecleaver |QID|35061|T|Uruk Foecleaver|N|Kill Uruk Foecleaver|M|55.64,47.75|
C Silence the War Machines |QID|35067|NC|N|Destroy the War Machines|US|M|55.77,46.53;54.57,44.89;55.97,43.02|CN|
C If They Won't Surrender... |QID|35068|N|Finish killing the Lok-rath enemy forces.|US|

T Terror of Nagrand |QID|35069|N|To Captain "Victorious" Chong|M|62.13,40.43|
T Silence the War Machines |QID|35067|N|To Captain "Victorious" Chong|M|62.13,40.43|
T If They Won't Surrender... |QID|35068|N|To Captain "Victorious" Chong|M|62.13,40.43|

T The Pride of Lok-rath |QID|35061|N|To Yrel at Yrel's Watch.|M|61.98,40.54|
A Lok-rath is Secured |QID|35062|N|From Yrel.|M|61.98,40.54|PRE|35061|

A THAELIN! |QID|35140|N|From Yrel.|M|61.98,40.54|PRE|35061|
C THAELIN! |QID|35140|N|Click on the Baby Goren to capture them.  Or use the target button and your interact button (";" for me).|NC|M|62.00,40.50|T|Baby Goren|
T THAELIN! |QID|35140|N|To Yrel.|M|61.98,40.54|

A Carrier Has Arrived |QID|35141|N|From Yrel.|M|61.98,40.54|PRE|35140|
K Tura'aka |QID|35920|M|64.89,39.31|N|*Rare Kill*\nDrops a cloak worth 23g.|RANK|3|
f Joz's Rylaks |QID|35332|N|With Joz Navarix|M|62.23,32.89|

H Trading Post |QID|35062|N|Use your hearthstone to return to Telaari Station.|
T Carrier Has Arrived|QID|35141|M|63.06,61.95|N|To Thaelin Darkanvil|
T Lok-rath is Secured|QID|35062|M|63.52,61.89|N|To Rangari D'kaan|
A And Justice for Thrall|QID|35169|PRE|34596;34957;35062|M|63.52,61.89|N|From Rangari D'kaan|
F Yrel's Watch|QID|35332|M|63.64,61.55|N|To John Shelby|

f Throne of the Elements|ALTFP|Skysong Lake|QID|35332|N|With Gixmo Moneycash|M|73.70,26.65|
T Nobundo Sends Word |QID|35332|N|To Vindicator Nobundo at the Throne of the Elements|M|71.72,19.65|
A Called to the Throne |QID|35331|N|From Vindicator Nobundo|M|71.72,19.65|PRE|35332|
C Called to the Throne |QID|35331|QO|1|N|Speak to Vindicator Nobundo, and tell him you are ready to commune with the furies.|CHAT|
C Called to the Throne |QID|35331|QO|2|N|Commune with the furries|NC|M|71.7,19.7|
T Called to the Throne |QID|35331|N|To Vindicator Nobundo|M|71.72,19.65|
A Elemental Attunement |QID|35333|N|From Vindicator Nobundo|M|71.72,19.65|PRE|35331|
A An Old Friend |QID|34943|M|72.78,19.72|N|From Kalandrios|PRE|35331|
A Earth, Wind and Fire...and Water|QID|34881|M|71.34,17.86|N|From Inceneratus|
A Guardians of the Plateau|QID|34893|M|71.34,17.86|N|From Inceneratus|

R Skysong Lake |QID|34943|N|Head up the path through Skysong Lake and up the ledge.|M|73.85,16.50|
T An Old Friend |QID|34943|M|75.07,22.74|N|To Gar'rok, up on the ledge.|
A A Rare Bloom|QID|34894|M|75.07,22.74|PRE|34943|N|From Gar'rok|

R Elemental Plateau|QID|34881|M|75.86,21.50;77.71,18.87|CS|N|Take the path all the way up to the Plateau|
C Corrupted Wind Spirit|QID|34881|M|75.60,23.80;78.90,24.80;80.30,20.00;76.70,25.55;81.84,17.09;79.75,17.82;82.20,20.80;79.90,14.16;78.99,21.67|CN|QO|2|S|
K Corrupted Wind Guardian|QID|34893|T|Currupted Wind Guardian|M|79.69,25.31|QO|2|
C Pillar of Wind|QID|35333|NC|M|78.32,24.42|QO|2|

C Unstable Earth Spirit|QID|34881|M|76.45,14.30;74.38,9.75;82.30,17.65;78.30,15.80;82.10,19.80;81.10,15.76;76.10,11.70;79.59,18.29;80.70,21.55;79.50,13.18|CN|QO|1|S|
K Unstable Earth Guardian|QID|34893|T|Unstable Earth Guardian|M|81.43,14.34|QO|1|
C Pillar of Earth|QID|35333|NC|M|79.30,11.67|QO|1|

C Tumultous Water Spirit|QID|34881|M|78.00,15.50;80.35,18.55;72.31,9.12;74.12,11.01;75.99,12.54|CN|QO|4|S|
K Tainted Water Guardian|QID|34893|T|Tainted Water Guardian|M|75.28,14.05|QO|4|
C Pillar of Water|QID|35333|NC|M|73.80,10.50|QO|4|

K Magmire|QID|34894|M|68.8,10.4|T|Magmire|N|To get the bloom, you need to get past Magmire. Cave opening here.|
A A Wrong of Earth and Fire|QID|33928|N|Kill Magmire and get the quest from the Molten Core|U|113080|
C A Rare Bloom|QID|34894|M|70.7,9.9|NC|N|Ember Blossom, in the back of the cave.|
C Volatile Fire Spirit|QID|34881|M|73.60,10.45;71.14,8.29;68.53,9.85;67.75,11.95;65.47,10.59|CN|QO|3|S|
K Volatile Flame Guardian|QID|34893|T|Volatile Flame Guardian|M|66.54,8.39|QO|3|
C Pillar of Flame|QID|35333|M|67.42,9.17|QO|3|
C Volatile Fire Spirit|QID|34881|M|73.60,10.45;71.14,8.29;68.53,9.85;67.75,11.95;65.47,10.59|CN|QO|3|US|

R Throne of the Elements|QID|34894|M|67.57,11.28;68.83,14.10;70.62,17.15|CS|N|Take the back way back.|
T Earth, Wind and Fire...and Water|QID|34881|M|71.34,17.86|N|To Incineratus|
T Guardians of the Plateau|QID|34893|M|71.34,17.86|N|To Incineratus|
T A Wrong of Earth and Fire|QID|33928|M|71.34,17.86|N|To Incineratus|
T Elemental Attunement|QID|35333|M|71.72,19.65|N|To Vindicator Nobundo|
T A Rare Bloom|QID|34894|M|73.8,16.4;75.07,22.74|CS|N|To Gar'rok|
A Guise of the Deceiver|QID|34932|PRE|34894|M|75.07,22.74|N|From Gar'rok|
C Guise of the Deceiver|QID|34932|M|76.0,20.8;77.96,23.32|CS|CHAT|N|Speak with her. Challe is on the path to the Plateau, but take a path to the right.|
T Guise of the Deceiver|QID|34932|M|75.07,22.74|N|To Gar'rok|
A The Debt We Share|QID|34941|PRE|34932|M|75.07,22.74|N|From Gar'rok|
C Witness|QID|34941|M|75.07,22.74|CHAT|N|Witness his passing, and wait a few moments.|

T The Debt We Share|QID|34941|M|72.6,19.6|N|To Kalandrios|

A The Ritual of Binding|QID|35330|PRE|35333;34881;34893|M|71.72,19.65|N|From Vindicator Nobundo|
C The Ritual of Binding|QID|35330|M|72.6,19.6|CHAT|N|Chat with Kalandrios to start the ritual.|
T The Ritual of Binding|QID|35330|M|71.72,19.65|N|To Vindicator Nobundo|

A The Call of Oshu'gun|QID|35372|M|71.72,19.65|N|From Vindicator Nobundo|
C Spirit Woods|QID|35372|M|73.70,26.65|QO|1|CHAT|N|Ask Gixmo Moneycash for a ride.|
T The Call of Oshu'gun|QID|35372|M|55.52,55.92|N|To Vindicator Nobundo|

A Spiritual Matters|QID|35393|PRE|35372|M|55.52,55.92|N|From Vindicator Nobundo|
A The Pale Threat|QID|35397|M|55.52,55.92|N|From Vindicator Nobundo|
A Dark Binding|QID|35398|M|55.52,55.92|N|From Vindicator Nobundo|
A Silence the Call|QID|35084|M|55.46,55.92|N|From Shamanstone|
A Disrupt the Rituals|QID|35083|M|55.46,55.92|N|From Shamanstone|

C The Pale Threat|QID|35397|M|57.6,59.2|QO|2|N|Kill the Pale|S|
C Enslaved Earth Spirit|QID|35398|M|52.6,61.2|T|Enslaved Earth Spirit|QO|1|S|
K Greyseer|QID|35397|T|Greyseer|M|56.5,61.9;67.4,18.3|CS|QO|1|Z|The Underpale|N|Head to the cave at the back of Shadowfall Canyon. The arrow may be flaky until you get into the cave.|

T The Pale Threat|QID|35397|M|46.12,32.83|Z|The Underpale|N|To Vindicator Nobundo, in the cave.|
T Dark Binding |QID|35398|M|46.12,32.83|Z|The Underpale|N|To Vindicator Nobundo, in the cave.|
A The Fate of Gordawg|QID|35395|PRE|35397;35398|M|46.12,32.83|Z|The Underpale|N|To Vindicator Nobundo, in the cave.|
A The Dark Heart of Oshu'gun|QID|35396|PRE|35397;35398|M|46.12,32.83|Z|The Underpale|N|To Vindicator Nobundo, in the cave.|
;l Heart of the Fury|QID|35395|M|41.0,40.5|Z|The Underpale|QO|1|N|Kill Gordawg and loot the heart.|
K Gordawg|QID|35395|M|41.0,40.5|Z|The Underpale|QO|1|T|Gordawg|N|Kill Gordawg and loot the heart.|

C The Dark Heart of Oshu'gun|QID|35396|NC|M|17.50,64.50|Z|The Underpale|QO|1|N|Head into the opening behind Gordawg and keep on going till you see Cho'gall.|
K Decimatus|QID|35396|M|17.09,64.70|Z|The Underpale|QO|2|T|Decimatus|
R Oshu'gun|QID|35393|M|22.67,65.43;19.77,72.35;11.88,68.73;8.41,60.20|CS|Z|The Underpale|N|Follow Nobundo up the ramp and leave the Sanctum here. Climb up the crack.|

C Silence the Call|QID|35084|M|54.2,67.6|QO|2|N|Warsong shamans|S|
C Mok'gor totems|QID|35083|NC|M|48.16,58.49|QO|1|
A The Warsong Threat|QID|35386|M|51.87,62.09|N|From Warsong Plans|
C Gra'ah totems|QID|35083|NC|M|52.39,63.35|QO|2|
C Kag'ah totems|QID|35083|M|50.54,70.49|QO|3|

f Nivek's Overlook|ALTFP|Spirit Woods|QID|35084|M|49.38,75.91|N|From Nivek Lee, grab a flight point while we are out here.|RANK|2|
A Feline Friends Forever|QID|35596|M|40.4,76.2|N|From Goldmane the Skinner|RANK|3|
T Feline Friends Forever|QID|35596|M|40.4,76.2|N|To Goldmane the Skinner|RANK|3|

K Ritualist Kuhlrath|QID|35084|M|54.70,67.11|QO|1|N|In the hut.|
C Nagrand Scouting Report|QID|35386|NC|M|54.57,67.07|QO|4|; In Kuhlrath's hut
C Warsong Outrider Orders|QID|35386|NC|M|51.86,67.4|QO|3|N|On a table in the hut.|
C Warsong Command Brief|QID|35386|NC|M|52.50,55.80|QO|1|; Gar'Lua
C Mixed Unit Tactics|QID|35386|NC|M|47.08,56.01|QO|2|
T Silence the Call|QID|35084|M|46.73,57.52|N|To Shamanstone|
T Disrupt the Rituals|QID|35083|M|46.73,57.52|N|To Shamanstone|
A Through the Nether|QID|35085|PRE|35084;35083|M|46.73,57.52|N|To Shamanstone|

C Nether Beacon|QID|35085|M|48.07,59.05|QO|1|N|Near each set of totems you destroyed, there is a nether beacon.  Click on it.|

T Through the Nether|QID|35085|M|46.81,57.51|N|From Shamanstone|
A The Nether Approaches|QID|35087|PRE|35085|M|46.81,57.51|N|From Shamanstone|
A The Void March|QID|35086|PRE|35085|M|46.81,57.51|N|From Shamanstone|

K Void Terror|QID|35086|M|51.6,64.8|QO|1|S|
K Void Tendril|QID|35086|M|51.6,64.8|QO|2|S|
C Void Portals|QID|35087|NC|M|46.20,58.60;50.10,72.00;52.10,65.50;52.60,70.40;52.70,68.00;52.30,61.95;49.25,56.85;50.38,59.98|CN|QO|1|

T The Nether Approaches|QID|35087|M|46.81,57.51|N|From Shamanstone|
T The Void March|QID|35086|M|46.81,57.51|N|From Shamanstone|
A The Shadow of the Void|QID|35088|PRE|35087;35086|M|46.81,57.51|N|From Shamanstone, or the closest one.|
K Invalidus|QID|35088|T|Invalidus|M|48.09,58.56|QO|1|N|Click on the void crystal at the altar and kill Invalidus|
T The Shadow of the Void|QID|35088|M|55.5,55.9|N|To Shamanstone|

R Ancestral Grounds|QID|35393|M|41.33,56.54|N|Get ready to speak with spirits.|
T Spiritual Matters|QID|35393|M|40.43,56.79|N|To Gar'rok|
A Lighting The Darkness|QID|35022|PRE|34941|M|40.43,56.79|N|From Gar'rok|
A Echoes of the Past|QID|35023|PRE|34941|M|40.40,56.75|N|From Dahaka|

C Echoes of the Past|QID|35023|M|37.8,56.2|QO|1|N|Tormented Echos's and Void-Crazed Spirits.  Stay on the first two tiers.|S|
C Lighting The Darkness|QID|35022|NC|M|38.50,54.25|QO|1|N|Light the pyres.  Stay on the first two tiers.|U|112396|
C Echoes of the Past|QID|35023|M|37.8,56.2|QO|1|N|Tormented Echos's and Void-Crazed Spirits.  Stay on the first two tiers.|US|

T Lighting The Darkness|QID|35022|M|40.43,56.79|N|To Gar'rok|
T Echoes of the Past|QID|35023|M|40.4,56.6|N|To Dahaka|
A Golmash Hellscream|QID|35024|PRE|35022;35023||M|40.43,56.79|N|From Gar'rok|

K Golmash Hellscream|QID|35024|T|Golmash Hellscream|M|37.4,55.6|N|Golmash Hellscream, on the third tier.|

T Golmash Hellscream|QID|35024|M|40.4,56.8|N|To Gar'rok|

H Telaari Station |QID|35386|N|Use your hearthstone to return to Telaari Station.|
T The Warsong Threat|QID|35386|M|62.12,62.12|N|To Captain Washburn|
F Throne of the Elements|QID|35395|M|63.64,61.55|N|To John Shelby|
T The Fate of Gordawg|QID|35395|M|72.79,19.69|N|To Kalandrios|
T The Dark Heart of Oshu'gun|QID|35396|M|71.54,19.76|N|To Vindicator Nobundo|

R Gates of Grommashar|QID|35169|M|61.61,58.71; 69.50,58.62; 71.70, 66.00; 74.6,69.4|CN|N|Ride to the Gates. This is a scenario, so don't queue up for anything or you will bug it out.|
C And Justice for Thrall|QID|35169|M|74.56,69.56|CHAT|QO|1|N|Speak to Vindicator Yrel|
C And Justice for Thrall|QID|35169|M|71.4,84.4|QO|2|N|Garrosh Hellscream|
T And Justice for Thrall|QID|35169|M|66.96,33.77|N|A Cinematic and then, To Vindicator Yrel. Go up the hill past Thrall to see Garrosh youtself, before you turn in.|

D Thanks|QID|0|N|Ludovicus and Fluclo would like to thank you for using our guide. Watch for the upcoming Treasures of Nagrand Acheivment Guide!|

]]

end)
