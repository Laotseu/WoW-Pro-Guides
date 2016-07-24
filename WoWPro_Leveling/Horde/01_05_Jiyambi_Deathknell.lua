
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_tirisfal_glades
-- Date: 2015-06-28 23:54
-- Who: Ludovicus
-- Log: PLaythrough with QO and M adjustments

-- URL: http://wow-pro.com/node/3205/revisions/27272/view
-- Date: 2015-05-29 00:30
-- Who: Ludovicus
-- Log: New starter zone.

-- URL: http://wow-pro.com/node/3205/revisions/27230/view
-- Date: 2015-04-30 20:26
-- Who: Ludovicus
-- Log: remap

-- URL: http://wow-pro.com/node/3205/revisions/27213/view
-- Date: 2015-04-28 00:39
-- Who: Ludovicus
-- Log: Split

-- URL: http://wow-pro.com/node/3205/revisions/26956/view
-- Date: 2014-11-09 10:57
-- Who: Fluclo
-- Log: Removed "You should be" levels, since you can continue the guide even if you're not those levels;
--	Added "You need to be" levels where quests are not given if you haven't reached that level; 
--	Added PRE tags throughout where the quest relies on a previous step being completed; 
--	Fixed QID on Scarlet Letter mobs; 
--	Changed QO to new number system; 
--	Made repair steps auto-complete; 
--	Added ACTIVE tags where the step is suitable only if you have that quest; 

-- URL: http://wow-pro.com/node/3205/revisions/26481/view
-- Date: 2014-06-02 22:15
-- Who: Ludovicus
-- Log: Added Icons

-- URL: http://wow-pro.com/node/3205/revisions/26427/view
-- Date: 2014-06-02 13:23
-- Who: Ludovicus
-- Log: Set Levels

-- URL: http://wow-pro.com/node/3205/revisions/26210/view
-- Date: 2014-05-25 22:25
-- Who: Ludovicus
-- Log: Added guide type.

-- URL: http://wow-pro.com/node/3205/revisions/26136/view
-- Date: 2014-05-20 19:01
-- Who: Ludovicus
-- Log: Icon

-- URL: http://wow-pro.com/node/3205/revisions/26044/view
-- Date: 2014-05-17 17:44
-- Who: Ludovicus

-- URL: http://wow-pro.com/node/3205/revisions/25948/view
-- Date: 2014-05-09 19:15
-- Who: Hendo72
-- Log: - reapplied changes as I forgot to update the code with my changes... DOH!

-- URL: http://wow-pro.com/node/3205/revisions/25947/view
-- Date: 2014-05-09 19:09
-- Who: Hendo72
-- Log: - Updated 'Shadow Grave' quest. Improved coordinates and notes.
--	
--	- Broke 'The Awakening' quest down into steps and moved quest acceptance down for better flow.
--	
--	- reworded 'Recruitment' C step note.
--	
--	- Added an r step at the first vendor you come to.
--	
--	- Improved 'Ever So Lonely' C step note.
--	
--	- Changed Bulwark R step to an F step as you can fly there and removed f step as you already have the FP.
--	

-- URL: http://wow-pro.com/node/3205/revisions/25854/view
-- Date: 2013-12-26 21:16
-- Who: Ludovicus
-- Log: QID corrections and fixups for goblins in the zone.

-- URL: http://wow-pro.com/node/3205/revisions/25133/view
-- Date: 2012-10-09 00:07
-- Who: Ludovicus
-- Log: Added undead monk quests.

-- URL: http://wow-pro.com/node/3205/revisions/25128/view
-- Date: 2012-10-08 19:44
-- Who: Ludovicus

-- URL: http://wow-pro.com/node/3205/revisions/24730/view
-- Date: 2011-08-13 21:23
-- Who: Jiyambi
-- Log: Adding note to Marshal Redpath quest, warning of it's difficulty.

-- URL: http://wow-pro.com/node/3205/revisions/24598/view
-- Date: 2011-06-25 01:34
-- Who: Crackerhead22
-- Log: ! Missing A step for step T qid 309 - Fixed, QID for turn-in should be 3098

-- URL: http://wow-pro.com/node/3205/revisions/24511/view
-- Date: 2011-06-07 10:52
-- Who: Ludovicus
-- Log: Tweak Coords on C [Assault on the Rotbrain Encampment]

-- URL: http://wow-pro.com/node/3205/revisions/24473/view
-- Date: 2011-06-01 00:36
-- Who: Crackerhead22
-- Log: Removed Z|Crusader's Outpost| as it was unneeded.

-- URL: http://wow-pro.com/node/3205/revisions/24437/view
-- Date: 2011-05-28 11:08
-- Who: Ludovicus
-- Log: Race tags needed updates.

-- URL: http://wow-pro.com/node/3205/revisions/24316/view
-- Date: 2011-04-29 15:20
-- Who: Ludovicus

-- URL: http://wow-pro.com/node/3205/revisions/24070/view
-- Date: 2011-01-29 17:11
-- Who: Ludovicus
-- Log: Added missing QID to Level 4 step.

-- URL: http://wow-pro.com/node/3205/revisions/24036/view
-- Date: 2011-01-22 14:39
-- Who: Ludovicus
-- Log: Added a bunch of |R|Undead,Troll| and |R|Undead| tags where appropriate.

-- URL: http://wow-pro.com/node/3205/revisions/23828/view
-- Date: 2010-12-25 08:31
-- Who: Crackerhead22
-- Log: Added missing |M| tags, fixed a couple |M| cords.

-- URL: http://wow-pro.com/node/3205/revisions/23671/view
-- Date: 2010-12-07 04:46
-- Who: Bitsem
-- Log: Added Class quests.

-- URL: http://wow-pro.com/node/3205/revisions/23660/view
-- Date: 2010-12-06 23:25
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3205/revisions/23276/view
-- Date: 2010-12-02 23:16
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3205/revisions/23275/view
-- Date: 2010-12-02 23:15
-- Who: Jiyambi

local guide = WoWPro:RegisterGuide('JiyDk0105', "Leveling", 'Deathknell (Undead)', 'Jiyambi', 'Horde')
WoWPro:GuideLevels(guide,1,3, 1.69231)
WoWPro:GuideNextGuide(guide, 'JiyTir0512')
WoWPro:GuideIcon(guide,"Icon", WoWPro:GuidePickGender("Interface\\Icons\\Achievement_Character_Undead_Male","Interface\\Icons\\Achievement_Character_Undead_Female"))
WoWPro:GuideSteps(guide, function()
return [[

A Fresh out of the Grave|QID|24959|M|40.79,78.48|R|Undead|N|From Agatha.|
T Fresh out of the Grave|QID|24959|M|43.42,79.95|R|Undead|N|To Undertaker Mordo.|

A The Shadow Grave|QID|28608|M|43.42,79.95|R|Undead|N|From Undertaker Mordo.|
C The Shadow Grave|QID|28608|NC|M|29.66,71.95|Z|Tirisfal Glades|R|Undead|N|Head down the stairs into the crypt and over to the table in the corner. Click on the thread and the vial of green liquid.|
T The Shadow Grave|QID|28608|M|43.42,79.95|R|Undead|N|Leave the Crypt and return to Undertaker Mordo.|

A Those That Couldn't Be Saved|QID|26799|M|43.42,79.95|R|Undead|N|From Undertaker Mordo.
C Those That Couldn't Be Saved|QID|26799|S|M|46.47,74.85|R|Undead|N|Kill zombies.|

A The Wakening|QID|24960|M|45.93,80.44|R|Undead|N|From Caretaker Caice. Speak with the Forsaken at each waypoint and go through their conversation.|

C Lilian Voss|QID|24960|CHAT|M|44.22,70.64|QO|1|R|Undead|
C Marshal Redpath|QID|24960|CHAT|M|46.54,71.11|QO|2|R|Undead|
C Valdred Moray|QID|24960|CHAT|M|40.68,72.96|QO|3|R|Undead|

C Those That Couldn't Be Saved|QID|26799|US|M|46.47,74.85|R|Undead|N|Kill zombies.|
T The Wakening|QID|24960|M|45.93,80.44|R|Undead|N|To Caretaker Caice.|

A Beyond the Graves|QID|25089|M|45.93,80.44|R|Undead|N|From Caretaker Caice.|
T Those That Couldn't Be Saved|QID|26799|M|43.42,79.95|R|Undead|N|To Undertaker Mordo.|
T Beyond the Graves|QID|25089|M|50.37,56.57|R|Undead|N|To Deathguard Saltain.|

A Recruitment|QID|26800|M|49.93,56.22|R|Undead|N|From Deathguard Saltain.|
A Scourge on our Perimeter|QID|26801|M|46.61,58.83|N|From Shadow Priest Sarvis.|

C Scourge on our Perimeter|QID|26801|S|M|57.00,51.00|N|Kill zombies and skeletons.|
C Recruitment|QID|26800|NC|M|52.50,42.50|R|Undead|N|Click on the Scarlet Corpses with the yellow arrow pointing at them to pick them up.|
C Scourge on our Perimeter|QID|26801|US|M|57.00,51.00|N|Kill zombies and skeletons.|

T Recruitment|QID|26800|M|49.93,56.22|R|Undead|N|To Deathguard Saltain.|
T Scourge on our Perimeter|QID|26801|M|46.61,58.83|N|To Shadow Priest Sarvis.|

L Level 3|QID|24961|LVL|3|N|You need to be Level 3 to continue with this guide.|

A Hallowed Scroll|QID|3097|R|Undead|C|Priest|M|46.61,58.83|N|From Shadow Priest Sarvis.|
A Glyphic Scroll|QID|3098|R|Undead|C|Mage|M|46.61,58.83|N|From Shadow Priest Sarvis.|
A Trail-Worn Scroll|QID|24962|R|Undead|C|Hunter|M|46.61,58.83|N|From Shadow Priest Sarvis.|
A Simple Scroll|QID|3095|R|Undead|C|Warrior|M|46.61,58.83|N|From Shadow Priest Sarvis.|
A Tainted Scroll|QID|3099|R|Undead|C|Warlock|M|46.61,58.83|N|From Shadow Priest Sarvis.|
A Encrypted Scroll|QID|3096|R|Undead|C|Rogue|M|46.61,58.83|N|From Shadow Priest Sarvis.|
A Scribbled Scroll|QID|31146|R|Undead|C|Monk|M|46.61,58.83|N|From Shadow Priest Sarvis.|

A The Truth of the Grave|QID|24961|M|46.73,58.20|N|From Novice Elreth.|PRE|26801|

T Hallowed Scroll|QID|3097|R|Undead|C|Priest|M|47.80,58.31|N|To Dark Cleric Duesten.|
T Glyphic Scroll|QID|3098|R|Undead|C|Mage|M|46.93,58.52|N|To Isabella.|
T Trail-Worn Scroll|QID|24962|R|Undead|C|Hunter|M|49.25,56.28|N|To Xavier the Huntsman.|
T Simple Scroll|QID|3095|R|Undead|C|Warrior|M|54.18,56.36|N|To Dannal Stern.|
T Tainted Scroll|QID|3099|R|Undead|C|Warlock|M|46.97,59.23|N|To Maximillion.|
T Encrypted Scroll|QID|3096|R|Undead|C|Rogue|M|46.76,58.77|N|To David Trias.|
T Scribbled Scroll|QID|31146|R|Undead|C|Monk|M|53.23,56.91|N|To Ting, Strong of Stomach.|

A Of Light and Shadows|QID|24966|R|Undead|C|Priest|M|47.76,58.10|N|From Dark Cleric Duesten.|
A Magic Training|QID|24965|R|Undead|C|Mage|M|47.03,58.26|N|From Isabella.|
A The Thrill of the Hunt|QID|24964|R|Undead|C|Hunter|M|49.17,56.33|N|From Xavier the Huntsman.|
A Charging into Battle|QID|24969|R|Undead|C|Warrior|M|54.18,56.36|N|From Dannal Stern.|
A Dark Deeds|QID|24968|R|Undead|C|Warlock|M|46.91,59.42|N|From Maximillion.|
A Stab!|QID|24967|R|Undead|C|Rogue|M|53.65,56.55|N|From David Trias.|
A Tiger Palm|QID|31147|R|Undead|C|Monk|M|53.24,56.87|N|From Ting, Strong of Stomach.|

C Of Light and Shadows|QID|24966|R|Undead|C|Priest|NC|M|47.76,58.10|N|Train Flash Heal. Use it on the wounded forsaken next to you.|
C Magic Training|QID|24965|R|Undead|C|Mage|M|50.00,61.42|N|Train Arcane Missles from Isabella. Go to a Dummy, cast Fireball, then Arcane Missles when it becomes available.|
C The Thrill of the Hunt|QID|24964|R|Undead|C|Hunter|M|50.00,61.42|N|Learn Steady Shot from Xavier, practice it 5 times on a Dummy.|
C Charging into Battle|QID|24969|R|Undead|C|Warrior|M|50.00,61.42|N|Learn Chrage from Dannal and practice it on a Dummy.|
C Dark Deeds|QID|24968|R|Undead|C|Warlock|M|50.00,61.42|N|Learn Immolate from Maximillion and practice it 5 times on a Dummy.|
C Stab!|QID|24967|R|Undead|C|Rogue|M|50.00,61.42|N|Learn Eviscerate from David, practice it 3 times on a Dummy.|
C Tiger Palm|QID|31147|R|Undead|C|Monk|M|50.00,61.42|N|Use Tiger Palm on a Dummy.|

T Of Light and Shadows|QID|24966|R|Undead|C|Priest|M|47.59,58.27|N|To Dark Cleric Duesten.|
T Magic Training|QID|24965|R|Undead|C|Mage|M|47.03,58.26|N|To Isabella.|
T The Thrill of the Hunt|QID|24964|R|Undead|C|Hunter|M|49.17,56.33|N|To Xavier the Huntsman.|
T Charging into Battle|QID|24969|R|Undead|C|Warrior|M|54.18,56.36|N|To Dannal Stern.|
T Dark Deeds|QID|24968|R|Undead|C|Warlock|M|46.91,59.42|N|To Maximillion.|
T Stab!|QID|24967|R|Undead|C|Rogue|M|53.65,56.55|N|To David Trias.|
T Tiger Palm|QID|31147|R|Undead|C|Monk|M|53.24,56.87|N|From Ting, Strong of Stomach.|

C The Truth of the Grave|QID|24961|NC|M|54.31,57.11|N|She's in the inn, though the location inside is random. Right-click the cowering woman and choose the gossip option.|
T The Truth of the Grave|QID|24961|M|46.85,58.31|N|To Novice Elreth.|

A The Executor In the Field|QID|28672|M|46.85,58.31|N|From Novice Elreth.|PRE|24961|
T The Executor In the Field|QID|28672|M|55.49,37.79|N|To Executor Arren.|

A The Damned|QID|26802|M|55.49,37.790|N|From Executor Arren.|PRE|28672|
C The Damned|QID|26802|M|63.81,28.65|N|Kill and loot bats and wolves.|
T The Damned|QID|26802|M|55.49,37.79|N|To Executor Arren.|

A Night Web's Hollow|QID|24973|M|55.49,37.79|N|From Executor Arren.|PRE|24973|
C Night Web's Hollow|QID|24973|M|34.28,27.36|N|Kill spiders over at the mine.|
T Night Web's Hollow|QID|24973|M|55.49,37.79|N|To Executor Arren.|

A No Better Than the Zombies|QID|24970|M|55.49,37.79|N|From Executor Arren.|PRE|24973|
T No Better Than the Zombies|QID|24970|M|67.01,42.32|N|To Darnell.|

A Assault on the Rotbrain Encampment|QID|24971|M|67.01,42.32|N|From Darnell.|PRE|24970|
C Assault on the Rotbrain Encampment|QID|24971|M|70.03,69.71|QO|2|S|N|Kill the hostile undead.
K Marshal Redpath|QID|24971|T|Marshal Redpath|M|70.03,69.71|QO|1|N|Marshal Redpath was once tough to take on alone.|
C Assault on the Rotbrain Encampment|QID|24971|M|70.03,69.71|QO|2|N|Kill the hostile undead.|
T Assault on the Rotbrain Encampment|QID|24971|M|46.61,58.83|US|N|To Shadow Priest Sarvis.|

A Vital Intelligence|QID|24972|M|46.61,58.83|N|From Shadow Priest Sarvis.|PRE|24971|
R Tirisfal Glades|QID|24972|M|52.60,43.95;67.70,34.48;81.20,14.33|CC|N|Follow the road out of Deathknell.|ACTIVE|24972|
R Calston Estate|QID|24972|M|43.77,53.15|Z|Tirisfal Glades|
r Gordo empty bags|QID|24972|M|44.57,52.94|Z|Tirisfal Glades|T|Gordo|N|You won't have to repair yet. But, with only 1 bag right now, you'll need to empty it.|ACTIVE|24972|
T Vital Intelligence|QID|24972|M|44.70,53.67|Z|Tirisfal Glades|N|To Deathguard Simmer.|

]]

end)
