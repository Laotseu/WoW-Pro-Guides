
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_westfall
-- Date: 2016-08-31 19:06
-- Who: Fluclo
-- Log: Added Rank 2 to the quests not needed for progression of the story. 
--	Removed Rank 2 tags from C and T entries. Added PRE tags to the quests that have pre-req quests. Added steps to get flight-paths. Corrected QO tags in Propaganda. Added Level step when quest levels increase. Removed Class Trainers (feature removed from the game) 
--	
--	To cater for the quest A Vision of the Past, added ACTIVE tag to Hearthstone set step to prevent it reappearing inappropriately. Removed Run steps to prevent it reappearing inappropriately. Added detail on how to get to Instance entrance as waypoint arrow stops working when your map changes to The Deadmines. Added a second set of entries for Evidence Collection to cater for those who loot one of the Defiance whilst head for A Vision of the Past. 
--	
--	Removed PRE for The Coast Isn't Clear as it isn't needed. Changed the quests in that area to Rank 2 as they are not needed for story progression. Added Active tags to the flights and use hearthstone steps so they only display if appropriate.

-- URL: http://wow-pro.com/node/3213/revisions/27639/view
-- Date: 2016-08-30 20:00
-- Who: Fluclo
-- Log: Added PRE tags to quests that need them, clarified that Murlocs and Gnolls needed to be looted for Hot on the Trail, added Active tag for run step

-- URL: http://wow-pro.com/node/3213/revisions/27614/view
-- Date: 2016-08-29 21:51
-- Who: Fluclo
-- Log: Level 9 needed, so changed WoWPro:GuideLevels from 8 to 9

-- URL: http://wow-pro.com/node/3213/revisions/26805/view
-- Date: 2014-11-06 12:56
-- Who: Fluclo
-- Log: Removed duplicate S tag from The Coast Isn't Clear

-- URL: http://wow-pro.com/node/3213/revisions/26399/view
-- Date: 2014-05-30 12:13
-- Who: Ludovicus
-- Log: Level setting

-- URL: http://wow-pro.com/node/3213/revisions/26214/view
-- Date: 2014-05-25 22:33
-- Who: Ludovicus
-- Log: Added guide type.

-- URL: http://wow-pro.com/node/3213/revisions/26133/view
-- Date: 2014-05-20 18:47
-- Who: Ludovicus
-- Log: Icon

-- URL: http://wow-pro.com/node/3213/revisions/25956/view
-- Date: 2014-05-14 22:06
-- Who: Ludovicus
-- Log: New registration guide.

-- URL: http://wow-pro.com/node/3213/revisions/25805/view
-- Date: 2013-11-18 21:46
-- Who: Fluclo
-- Log: Add LVL tag

-- URL: http://wow-pro.com/node/3213/revisions/25670/view
-- Date: 2013-05-17 19:20
-- Who: Ludovicus
-- Log: Bad coord for T CLUCK!.

-- URL: http://wow-pro.com/node/3213/revisions/25600/view
-- Date: 2013-03-23 20:45
-- Who: Ludovicus
-- Log: Quest name cleanups

-- URL: http://wow-pro.com/node/3213/revisions/25388/view
-- Date: 2013-01-12 21:19
-- Who: Emmaleah
-- Log: fixes for multi coordinates

-- URL: http://wow-pro.com/node/3213/revisions/25283/view
-- Date: 2013-01-09 00:24
-- Who: Ludovicus
-- Log: Multicoord corrections.

-- URL: http://wow-pro.com/node/3213/revisions/25043/view
-- Date: 2012-08-13 00:23
-- Who: Laotseu
-- Log: A few corrections I found while play testing a Monk on the Beta.

-- URL: http://wow-pro.com/node/3213/revisions/24820/view
-- Date: 2011-11-24 17:46
-- Who: Fluclo

-- URL: http://wow-pro.com/node/3213/revisions/24797/view
-- Date: 2011-11-05 23:12
-- Who: Fluclo
-- Log: Maybe the 2c generates slightly less hostile transients - more research needed :)

-- URL: http://wow-pro.com/node/3213/revisions/24778/view
-- Date: 2011-10-28 21:36
-- Who: Fluclo

-- URL: http://wow-pro.com/node/3213/revisions/24777/view
-- Date: 2011-10-28 13:15
-- Who: Fluclo
-- Log: Clarified note on Secrets of the Tower

-- URL: http://wow-pro.com/node/3213/revisions/24776/view
-- Date: 2011-10-28 12:15
-- Who: Fluclo
-- Log: Added a training step for non-Sharman classes

-- URL: http://wow-pro.com/node/3213/revisions/24455/view
-- Date: 2011-05-30 17:49
-- Who: Ludovicus
-- Log: Line 189 for step A has unknown tag [From Marshal Gryan Stoutmantle.]: [A Rise of the Brotherhood|QID|26322|PRE|26320|RANK|1|M|56.27,47.45|From Marshal Gryan Stoutmantle.|]

-- URL: http://wow-pro.com/node/3213/revisions/24442/view
-- Date: 2011-05-28 19:18
-- Who: Crackerhead22
-- Log: Added notes.

-- URL: http://wow-pro.com/node/3213/revisions/24291/view
-- Date: 2011-04-29 14:20
-- Who: Ludovicus

-- URL: http://wow-pro.com/node/3213/revisions/23935/view
-- Date: 2011-01-06 15:32
-- Who: Crackerhead22
-- Log: Added turn in for "Furlbrow's Deed"

-- URL: http://wow-pro.com/node/3213/revisions/23814/view
-- Date: 2010-12-22 23:59
-- Who: Crackerhead22
-- Log: Added missing turn-ins.

-- URL: http://wow-pro.com/node/3213/revisions/23322/view
-- Date: 2010-12-03 08:42
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3213/revisions/23295/view
-- Date: 2010-12-03 07:22
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3213/revisions/23294/view
-- Date: 2010-12-03 07:21
-- Who: Jiyambi

local guide = WoWPro:RegisterGuide('BitWes1020', "Leveling", 'Westfall', 'Bitsem', 'Alliance')
WoWPro:GuideLevels(guide,9,14,10.4861)
WoWPro:GuideNextGuide(guide, 'KurRed1520')
WoWPro:GuideIcon(guide,"ACH",4928)
WoWPro:GuideSteps(guide, function()
return [[
R Westfall |QID|26209|N|Westfall is located west of Elwynn Forest (just follow the road west from Goldshire).\n\nThere are two breadcrumb quests for this region:\n\nFurlbrow's Deed\nThis is a pickup from the floor behind Hogger\n\nHero's Call: Westfall\nThis quest is available from either of the Hero's Call boards in Stormwind City (Dwarven District and Trade District), or from any of these: Deputy Rainer at Westbrook Garrison, Marshall Dughan in Goldshire, Guard Thomas at the eastern Elwynn Bridge, Marshall McCree and Marshall Haggard at Eastvale Logging Camp.|
A Hero's Call: Westfall!|QID|184;28562;26378|LEAD|26209|N|Breadcrumb quest for Westfall that can be found on the Hero's Call Board in Inronforge or Stormwind, or from any of these: Deputy Rainer at Westbrook Garrison, Marshall Dughan in Goldshire, Guard Thomas at the eastern Elwynn Bridge, Marshall McCree and Marshall Haggard at Eastvale Logging Camp.\n\nThis quest is optional, skip it if you don't want it or if you plan on getting Furlbrow's Deed is Elwynn Forest.|O|
A Furlbrow's Deed|QID|184;28562;26378|LEAD|26209|M|24.8,95.2|Z|Elwynn Forest|N|Breadcrumb quest for Westfall. Choose this one if you are in Elwynn Forest already.\n\nThis quest is optional, skip it if you don't want it.|O|
T Hero's Call: Westfall!|QID|28562;26378|M|60.05,19.40|N|To Lieutenant Horatio Laine.|
T Furlbrow's Deed|QID|184|M|60.05,19.40|N|To Lieutenant Horatio Laine.|

A Murder Was The Case That They Gave Me|QID|26209|RANK|1|M|60.05,19.40|N|From Lieutenant Horatio Laine.|
C Murder Was The Case That They Gave Me|QID|26209|CHAT|RANK|1|M|58.26,18.50|N|Question the Drifters, Transient, and Homeless in the field. Some will fight you, some give information.|
T Murder Was The Case That They Gave Me|QID|26209|RANK|1|M|60.10,19.32|N|To Lieutenant Horatio Laine.|

A Hot On the Trail: The Riverpaw Clan|QID|26213|RANK|1|M|60.10,19.32|N|From Lieutenant Horatio Laine.|S|
A Hot On the Trail: Murlocs|QID|26214|RANK|1|M|60.10,19.32|N|From Lieutenant Horatio Laine.|
A Hot On the Trail: The Riverpaw Clan|QID|26213|RANK|1|M|60.10,19.32|N|From Lieutenant Horatio Laine.|US|

A Captain Sanders' Hidden Treasure|QID|26353|S|RANK|2|M|55.98,11.02|N|Kill Murlocs until they drop a Treasure Map to start this quest.|U|1357|

C Hot On the Trail: Murlocs|QID|26214|S|M|55.98,11.02|N|Kill Murlocs until you have their clue.|
C Hot On the Trail: The Riverpaw Clan|QID|26213|M|58.75,14.00|N|Kill Riverpaw Gnolls until you have their clue.|
C Hot On the Trail: Murlocs|QID|26214|US|M|55.98,11.02|N|Kill Murlocs until you have their clue.|

A Captain Sanders' Hidden Treasure|QID|26353|US|RANK|2|M|55.98,11.02|N|Kill Murlocs until they drop a Treasure Map to start this quest.|U|1357|

T Hot On the Trail: The Riverpaw Clan|QID|26213|RANK|1|M|60.10,19.32|N|To Lieutenant Horatio Laine.|S|
T Hot On the Trail: Murlocs|QID|26214|RANK|1|M|60.10,19.32|N|To Lieutenant Horatio Laine.|
T Hot On the Trail: The Riverpaw Clan|QID|26213|RANK|1|M|60.10,19.32|N|To Lieutenant Horatio Laine.|US|

A Meet Two-Shoed Lou|QID|26215|PRE|26214|RANK|1|M|60.13,19.37|N|From Lieutenant Horatio Laine.|
f Furlbrow's Pumpkin Farm|M|49.85,18.75|N|At Hoboair.|
T Meet Two-Shoed Lou|QID|26215|M|49.71,19.41|N|To Two-Shoed Lou.|

A Livin' the Life|QID|26228|PRE|26215|RANK|1|M|49.71,19.41|N|From Two-Shoed Lou.|
A "I TAKE Candle!"|QID|26229|RANK|1|M|49.59,19.60|N|From Jimb "Candles" McHannigan.
A Feast or Famine|QID|26230|RANK|1|M|49.52,19.08|N|From Mama Celeste inside the cabin.|

C Feast or Famine|QID|26230|M|52.83,22.45|N|Kill Coyotes for their tails, and collect fresh dirt from the mounds.|

C "I TAKE Candle!"|QID|26229|S|M|44.62,25.80|N|Kill Kobold Diggers you find outside and inside Jangalode Mine.|
R Jangolode Mine |QID|26228|M|44.54,25.17|N|Head to the Jangolode Mine.|

C Livin' the Life|QID|26228|NC|U|57761|M|44.54,24.96;46.44,19.31|CS|N|Use Two-Shoed Lou's Old House at the back of the cave.|
C "I TAKE Candle!"|QID|26229|US|M|44.62,25.80|N|Finish killing Kobold on your way out.|

T Feast or Famine|QID|26230|M|49.51,19.24|N|To Mama Celeste.|
T "I TAKE Candle!"|QID|26229|M|49.61,19.63|N|To Jimb "Candles" McHannigan.|
T Livin' the Life|QID|26228|M|49.64,19.51|N|To Two-Shoed Lou.|

A Lou's Parting Thoughts|QID|26232|PRE|26228|RANK|1|M|49.64,19.51|N|From Two-Shoed Lou.|
C Lou's Parting Thoughts|QID|26232|M|48.29,19.64|N|Head to the group of thugs at the back of the barn.  They'll attack you after they've finished their con. Kill 'em.|
T Lou's Parting Thoughts|QID|26232|M|49.68,19.56|N|To Lieutenant Horatio Laine (who is now at Furlbrow's  Pumpkin Farm).|

A Shakedown at the Saldean's|QID|26236|PRE|26232|RANK|1|M|49.68,19.56|N|From Lieutenant Horatio Laine.|
T Shakedown at the Saldean's|QID|26236|M|56.03,31.33|N|To Farmer Saldean, at Saldean's Farm (south-east of the Pumpkin Farm).|

A Times are Tough|QID|26237|PRE|26236|RANK|1|M|56.03,31.33|N|From Farmer Saldean.|
A Westfall Stew|QID|26241|RANK|1|M|56.35,30.55|N|From Salma Saldean.|

C Westfall Stew|QID|26241|S|M|56.50,28.46|N|Kill Goretusks, Fleshrippers, and collect Okra from the grounds of the farm.|
C Times are Tough|QID|26237|M|55.18,36.90|N|Kill Harvest Watchers.|S|
;K Harvest Watcher |QID|26252|N|Kill and loot the Harvest Watchers until they drop the Harvest Watecher Heart.|L|57935|RANK|2|
A Heart of the Watcher|QID|26252|RANK|2|M|55.23,34.87|N|Kill and loot the Harvest Watchers until they drop the Harvest Watecher Heart.|U|57935|

T Heart of the Watcher|QID|26252|RANK|2|M|56.15,31.40|N|To Farmer Saldean.|
A It's Alive!|QID|26257|PRE|26252|RANK|2|M|56.15,31.40|N|From Farmer Saldean.|
C It's Alive!|QID|26257|U|57954|RANK|2|M|48.87,33.51|N|Head to The Molsen Farm, then use the Harvest Watcher Heart on an Overloaded Harvest Golem. Use Action 2 to run over Energized Reapers, and Action 1 for one-on-one fighting.|

C Westfall Stew|QID|26241|US|M|48.75,28.00|N|Finish killing Goretusks, Fleshrippers, and collect Okra from the grounds of the farm.|
C Times are Tough|QID|26237|M|55.18,36.90|N|Finish killing the Harvest Watchers.|US|

T Westfall Stew|QID|26241|M|56.37,30.62|N|To Salma Saldean.|
T Times are Tough|QID|26237|M|56.07,31.31|N|To Farmer Saldean.|S|
T It's Alive!|QID|26257|RANK|2|M|55.96,31.34|N|To Farmer Saldean.|
T Times are Tough|QID|26237|M|56.07,31.31|N|To Farmer Saldean.|US|

A You Have Our Thanks|QID|26270|PRE|26241|RANK|1|M|56.02,31.28|N|From Farmer Saldean.|
T You Have Our Thanks|QID|26270|M|56.37,30.60|N|To Salma Saldean.|
A Hope for the People|QID|26266|RANK|1|M|56.37,30.60|N|From Salma Saldean.|

A CLUCK!|QID|3861|T|Chicken;chicken|U|11109|RANK|3|M|56.02,31.28|N|To get this quest, buy one unit of Special Chicken Feed from Farmer Saldean, find a chicken, and repeatedly type /chicken at it until eventually it turns friendly, and offer the quest.|
T CLUCK!|QID|3861|RANK|3|M|56.02,31.28|N|To Chicken - enjoy your new pet!|

T Hope for the People|QID|26266|M|56.88,47.13|N|To Hope Saldean at Sentinel Hill.|
A Feeding the Hungry and the Hopeless|QID|26271|RANK|1|M|56.88,47.13|N|From Hope Saldean.|
r Quartermaster Lewis |QID|26286|M|57.70,53.71|N|Take this opportunity to repair and sell your junk.\n\nClick this step to continue.|

A In Defense of Westfall|QID|26286|RANK|1|M|56.35,47.55|N|From Marshal Gryan Stoutmantle.|
A The Legend of Captain Grayson|QID|26371|RANK|1|M|56.44,47.45|N|From Scout Galiaan.|
A The Westfall Brigade|QID|26287|RANK|1|M|56.40,47.52|N|From Captain Danuvin.|
f Sentinel Hill|NC|M|56.6,49.4|N|Get the flight path.|
h Sentinel Hill|QID|26287|M|52.78,53.65|N|At Innkeeper Heather.|
N Update your skills|QID|26287|M|52.75,53.50|N|Update your skills with your trainer.\n\nClick this step to continue.|C|Paladin,Warrior,Priest,Mage,Hunter,Rogue,Warlock|

C The Westfall Brigade|QID|26287|M|51.30,53.34|N|Kill Riverpaw Brutes and Bandits.|S|
C In Defense of Westfall|QID|26286|M|53.42,49.31|N|Kill and loot the Riverpaw Brutes and Bandits until one drops the Gnoll Attack Orders.|
C The Westfall Brigade|QID|26287|M|51.30,53.34|N|Finish killing the Riverpaw Brutes and Bandits.|US|

C Feeding the Hungry and the Hopeless|QID|26271|NC|T|Homeless Stormwind Citizen;use item:57991|M|58.00,39.75|N|Run around outside the wall and use the Westfall Stew near the Homeless. They will come to you.|

T In Defense of Westfall|QID|26286|M|56.30,47.59|N|To Marshal Gryan Stoutmantle.|

T The Westfall Brigade|QID|26287|M|56.36,47.54|N|To Captain Danuvin.|
A Jango Spothide|QID|26288|PRE|26287|RANK|1|M|56.36,47.54|N|From Captain Danuvin.|

T Feeding the Hungry and the Hopeless|QID|26271|M|56.90,47.03|N|To Hope Saldean.|
A Find Agent Kearnen|QID|26289|RANK|1|M|56.44,47.46|N|From Marshal Gryan Stoutmantle.|

C Riverpaw gnolls|QID|26288|S|QO|Riverpaw Mystic slain: 5/5;Riverpaw Taskmaster slain: 5/5|M|62.28,76.43|N|Kill Riverpaw Mystics and Taskmasters.|
K Jango Spothide|QID|26288|M|62.28,76.43|T|Jango Spothide|QO|Jango Spothide slain: 1/1|N|Kill Jango Spothide as well as the Riverpaw Mystics and Taskmasters.|
C Riverpaw gnolls|QID|26288|US|QO|Riverpaw Mystic slain: 5/5;Riverpaw Taskmaster slain: 5/5|M|62.28,76.43|N|Kill Riverpaw Mystics and Taskmasters.|

T Find Agent Kearnen|QID|26289|M|68.23,70.43|N|To Agent Kearnen.|
A Secrets of the Tower|QID|26290|PRE|26289|RANK|1|M|68.23,70.43|N|From Agent Kearnen.|
C Secrets of the Tower|QID|26290|NC|U|58112|M|70.42,74.22|N|Run past the Level 13 elites (they will agro), and into Mortwake's Tower, there use the Potion of Shrouding (it'll stop the Elites from attacking you).  Run up the tower to the top, stand next to Helix Gearbreaker, and wait for Helix's Secret to be revealed.|
T Secrets of the Tower|QID|26290|M|68.39,70.45|N|Leave the tower, then head back to Agent Kearnen.  Don't worry about the elites, if they do start attacking you, they die very quickly.|
A Big Trouble in Moonbrook|QID|26291|PRE|26290|RANK|1|M|68.39,70.45|N|From Agent Kearnen.|

T Big Trouble in Moonbrook|QID|26291|M|56.41,47.41|N|To Marshal Gryan Stoutmantle, back at Sentinel Hill.|
A To Moonbrook!|QID|26292|PRE|26291|RANK|1|M|56.41,47.41|N|From Marshal Gryan Stoutmantle.|
T Jango Spothide|QID|26288|M|56.49,47.50|N|To Captain Danuvin.|

F Moonbrook|QID|26292|M|56.6,49.5;42.1,64.1|CN|N|Fly to Moonbrook from Thor at Sentinel Hill.  If he doesn't offer you the destination, run to Moonbrook which is south-west of Sentinel Hill.|
f Moonbrook|M|42.1,63.3|N|From Tina Skyden.|

T To Moonbrook!|QID|26292|M|42.11,63.99|N|To Captain Alpert.|
A Propaganda|QID|26295|PRE|26292|RANK|1|M|42.11,63.99|N|From Captain Alpert.|

;C Moonbrook Thug|QID|26296|RANK|2|M|41.50,67.37|N|Kill Moonbrook Thugs until they drop a Red Bandana - the first building on the right usually has a couple in there.|L|58117|
A Evidence Collection|QID|26296|RANK|2|M|43.69,67.90|N|Kill Moonbrook Thugs until they drop a Red Bandana. Accept the quest from the Red Bandana dropped by the Moonbrook Thugs.|U|58117|

C Evidence Collection|QID|26296|S|M|45.53,70.95|N|Kill thugs and loot their bandanas..|
C Mysterious Propaganda |QID|26295|M|41.26,66.50|N|The back of the first building on right on entering Moonbrook from the Flight Master.|QO|Mysterious Propaganda: 1/1|NC|

C Informational Pamphlet |QID|26295|M|41.59,66.41|N|Behind the Mysterious Propaganda on the broken barrel.|QO|Informational Pamphlet: 1/1|NC|
C Issue of the Moonbrook Times |QID|26295|M|43.27,69.90|N|In the main square next to the broken fountain.|QO|Issue of the Moonbrook Times: 1/1|NC|
C Secret Journal |QID|26295|M|43.46,66.57|N|Inside the Inn, top floor, far right hand room at the back.|QO|Secret Journal: 1/1|NC|
C Propaganda|QID|26295|M|41.56,66.42;42.27,69.68;42.57,69.67;43.48,66.72|CN|N|Finish collecting the propaganda.|
C Evidence Collection|QID|26296|RANK|2|US|M|45.53,70.95|N|Finish killing and looting the Thugs.|

T Evidence Collection|QID|26296|M|42.16,64.15|N|To Captain Alpert.|S|
T Propaganda|QID|26295|M|42.16,64.15|N|To Captain Alpert.|
A The Dawning of a New Day|QID|26297|PRE|26295|RANK|1|M|42.16,64.15|N|From Captain Alpert.|
T Evidence Collection|QID|26296|M|42.16,64.15|N|To Captain Alpert.|US|

C The Dawning of a New Day|QID|26297|M|43.45,69.19|N|Head to the rally point, and listen to the rally call.|NC|
T The Dawning of a New Day|QID|26297|M|42.18,64.19|N|To Captain Alpert.|

A Secrets Revealed|QID|26319|PRE|26297|RANK|1|M|42.18,64.19|N|From Captain Alpert.|
T Secrets Revealed|QID|26319|M|42.86,65.08|N|To Thoralius the Wise.|
A A Vision of the Past|QID|26320|PRE|26319|RANK|1|M|42.86,65.08|N|From Thoralius the Wise.|

R Defias Hideout|QID|26371|M|42.58,72.08|N|Enter the Defias Hideout.|
C A Vision of the Past|QID|26320|NC|U|58147|N|Follow the orphans and homeless to The Deadmines instance. Stick to the right. Once you enter the Deadmines Instance, use the incense. Then get ready to feel like a bad person if you've done the original Deadmines.|M|42.90,72.67;42.59,75.08;41.60,76.07;41.54,77.96;41.20,79.54;40.06,78.13;38.30,77.50|CS|

R Moonbrook|QID|26371|N|Exit the Instance|
R Moonbrook|QID|26371|N|Head back to Moonbrook.|M|38.30,77.50;39.43,77.99;38.83,79.04;40.06,78.13;41.20,79.54;41.54,77.96;41.60,76.07;42.59,75.08;42.90,72.67|CS|

;A The Coast Isn't Clear|QID|26348|PRE|26371|RANK|1|M|30.55,85.54|N|From Captain Grayson.|S|
;A Keeper of the Flame|QID|26347|RANK|1|M|30.55,85.54|N|From Captain Grayson.|S|
T The Legend of Captain Grayson|QID|26371|M|30.55,85.54|N|To Captain Grayson.|
;A The Coastal Menace|QID|26349|RANK|1|M|30.55,85.54|N|From Captain Grayson.|S|
A The Coast Isn't Clear|QID|26348|PRE|26371|RANK|1|M|30.55,85.54|N|From Captain Grayson.|
A The Coastal Menace|QID|26349|RANK|1|M|30.55,85.54|N|From Captain Grayson.|
A Keeper of the Flame|QID|26347|RANK|1|M|30.55,85.54|N|From Captain Grayson.|

C The Coast Isn't Clear|QID|26348|S|M|33.63,84.34|S|N|Kill Murloc Tidehunters and Oracles.|
K The Coastal Menace|QID|26349|M|34.27,84.81|N|Find, kill and loot Old Murk-Eye.|T|Old Murk-Eye|
C The Coast Isn't Clear|QID|26348|M|33.63,84.34|US|N|Head back to the lighthouse, and finish killing Murloc Tidehunters and Oracles.|

T Captain Sanders' Hidden Treasure|QID|26353|S|RANK|2|30.55,85.54|N|To Captain Grayson.|
A Captain Sanders' Hidden Treasure|QID|26354|RANK|2|PRE|26353|M|25.93,47.76|N|From the Captain's Footlocker.|

C Keeper of the Flame|QID|26347|M|37.79,40.04|N|Kill and loot Chasm Slimes until you get 5 Chasm Oozes.|

T Captain Sanders' Hidden Treasure|QID|26354|RANK|2|M|40.58,47.79|N|To the Broken Barrel.|
A Captain Sanders' Hidden Treasure|QID|26355|RANK|2|PRE|26354|M|40.58,47.79|N|From the Broken Barrel.|


T The Coast Isn't Clear|QID|26348|M|30.53,85.55|N|To Captain Grayson.|S|
T Keeper of the Flame|QID|26347|M|30.55,85.49|N|To Captain Grayson.|S|
T The Coastal Menace|QID|26349|M|30.53,85.55|N|To Captain Grayson.|
T Keeper of the Flame|QID|26347|M|30.55,85.49|N|To Captain Grayson.|US|
T The Coast Isn't Clear|QID|26348|M|30.53,85.55|N|To Captain Grayson.|US|

T Captain Sanders' Hidden Treasure|QID|26355|RANK|2|M|40.65,17.05|N|To the Old Jug.  You may want to run to Moonbrook then fly to Furlbrow's Pumpkin Farm.  The next two steps will take you way out into the sea at the north-west of Westfall, so you're best holding off using your Hearthstone at this point.|
A Captain Sanders' Hidden Treasure|QID|26356|RANK|2|PRE|26355|M|40.65,17.05|N|From the Old Jug.|

T Captain Sanders' Hidden Treasure|QID|26356|RANK|2|M|25.95,16.96|N|Swim across the water to the small isle, and turn the quest into the Locked Chest.|

H Sentinel Hill|QID|26320|NC|M|56.45,47.57|N|Hearth to, or otherwise head back to Sentinel Hill.|

T A Vision of the Past|QID|26320|M|56.27,47.45|N|To Marshal Gryan Stoutmantle.|
A Rise of the Brotherhood|QID|26322|PRE|26320|RANK|1|M|56.27,47.45|N|From Marshal Gryan Stoutmantle.|
C Rise of the Brotherhood|QID|26322|NC|M|56.36,47.55|N|Watch the scene.|

F Stormwind|QID|26322|N|Fly to Stormwind.|

T Rise of the Brotherhood|QID|26322|M|85.62,31.92|Z|Stormwind City|N|To King Varian Wrynn.|
A Return to Sentinel Hill|QID|26370|PRE|26322|RANK|1|M|85.62,31.92|Z|Stormwind City|N|From King Varian Wrynn.|

T Return to Sentinel Hill|QID|26370|M|56.37,49.57|N|To Marshal Gryan Stoutmantle.|

A Threat to the Kingdom|QID|26761|RANK|1|M|56.37,49.57|N|If you're continuing your quests in Redridge, this quest from Marshal Gryan Stoutmantle, otherwise this zone guide is now finished.|O|
A Hero's Call: Redridge Mountains!|QID|26365|RANK|1|M|56.44,49.52|N|If you're continuing your quests in Redridge, this quest from Captain Danuvin, otherwise this zone guide is now finished.|O|

]]

end)
