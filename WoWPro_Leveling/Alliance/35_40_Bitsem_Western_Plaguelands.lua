-- URL: http://wow-pro.com/wiki/source_code_western_plaguelands_alliance
-- Date: 2010-12-21 01:29
-- Who: Bitsem

-- URL: http://wow-pro.com/node/3244/revisions/23807/view
-- Date: 2010-12-21 01:27
-- Who: Bitsem

-- URL: http://wow-pro.com/node/3244/revisions/23806/view
-- Date: 2010-12-21 00:14
-- Who: Crackerhead22

-- URL: http://wow-pro.com/node/3244/revisions/23805/view
-- Date: 2010-12-20 23:16
-- Who: Crackerhead22
-- Log: Added in QO steps for "The Good People of Hearthglen" to make it easier to find the NPCS.

-- URL: http://wow-pro.com/node/3244/revisions/23804/view
-- Date: 2010-12-20 22:56
-- Who: Crackerhead22
-- Log: Fixed |QO| error with "Drudges... ", it was 0/1 and not 1/1.

-- URL: http://wow-pro.com/node/3244/revisions/23803/view
-- Date: 2010-12-20 22:27
-- Who: Crackerhead22
-- Log: Removed "Threat to the Kingdom" quest.

-- URL: http://wow-pro.com/node/3244/revisions/23802/view
-- Date: 2010-12-20 22:23
-- Who: Crackerhead22
-- Log: Removed a |Z| tag that was causing "Zone not found" error.

-- URL: http://wow-pro.com/node/3244/revisions/23599/view
-- Date: 2010-12-05 07:50
-- Who: Bitsem
-- Log: Added Source Code. Untested.

-- URL: http://wow-pro.com/node/3244/revisions/23369/view
-- Date: 2010-12-03 11:23
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3244/revisions/23368/view
-- Date: 2010-12-03 11:22
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide('BitWes3540', 'Western Plaguelands', 'Bitsem', '35', '40', 'CraEas4045', 'Alliance', function()
return [[

T The Battle for Andorhal|QID|28749|M|40.97,70.38|N|To Thassarian.|
A Scourge First... Horde Later|QID|27159|M|40.97,70.38|N|From Thassarian.|
A War Machines|QID|27160|M|40.97,70.38|N|From Lurid.|
A The Endless Flow|QID|27161|M|41.21,70.13|N|From Lang Loosegrip.|

f Andorhal|QID|27161|M|39.52,69.54|N|At Ginny Goodwin.|

C Scourge First... Horde Later|QID|27159|M|41.89,69.69|S|N|From now on, kill scourge and Opengut Behemoths on sight.|
C The Endless Flow|QID|27161|U|60849|M|42.44,65.55|N|Use Lang's Hand Grenades to kill skeletons and the Scourge Bone Animus in the tower.|
C War Machines|QID|27160|M|42.50,72.01|N|Continue killing Opengut Behemoths.|
C Scourge First... Horde Later|QID|27159|M|41.89,69.69|US|N|Finish killing the needed mobs.|

T The Endless Flow|QID|27161|M|41.28,70.19|N|To Lang Loosegrip.|
A Araj the Summoner|QID|27164|PRE|27161|M|41.28,70.19|N|From Lang Loosegrip.|

T Scourge First... Horde Later|QID|27159|M|41.13,70.39|N|To Thassarian.|
T War Machines|QID|27160|M|41.10,70.46|N|To Lurid.|

A Scholomancer|QID|27162|PRE|27160|M|41.10,70.46|N|From Thassarian.|
A Brute Strength|QID|27163|PRE|27160|M|41.10,70.46|N|From Thassarian.|

C Brute Strength|QID|27163|M|43.57,69.61|T|Rattlegore|N|Level 35 Elite, inside the building.|
C Araj the Summoner|QID|27164|U|60849|M|45.20,69.32|T|Araj the summoner|N|Use Lang's Hand Grenades if he summons skeletons. Level 35 Elite, by the fountain. Loot Araj's Phylactery Shard.|
C Scholomancer|QID|27162|M|45.39,72.34|T|Darkmaster Gandling|N|Thassarian and Koltira Deathweaver will appear to help you during the battle.|

T Scholomancer|QID|27162|M|41.13,70.48|N|To Thassarian.|
T Brute Strength|QID|27163|M|41.13,70.48|N|To Thassarian.|
T Araj the Summoner|QID|27164|M|41.13,70.48|N|To Thassarian.|

A Victory, For Now|QID|27165|PRE|27162;27163;27164|M|41.13,70.48|N|From Thassarian.|

r Repair and Restock|QID|27165|NC|M|39.53,69.55|N|Speak to Ginny Goodwin for a free flight when you're ready to go.|

f Chillwind Camp|QID|27165|NC|M|42.95,84.95|N|If you don't have it, from Bibilfaz Featherwhistle.|

T Victory, For Now|QID|27165|M|42.78,84.12|N|To Commander Ashlam Valorfist.|

A Go Fletch!|QID|27166|M|42.78,84.12|N|From Commander Ashlam Valorfist.|
A A Mighty Hunger|QID|27167|M|42.78,84.12|N|From Thurman Grant.|
A Into the Woods|QID|27683|M|42.96,83.63|N|From Argent Officer Pureheart.|N|If you will be entering the Eastern Plaguelands next.|

h Chillwind Camp|QID|27683|M|43.38,84.51|N|At Mother Matterly.|

C A Mighty Hunger|QID|27167|S|M|41.93,79.46|N|From now on, kill and loot Shaggy Black Bears and collect Feathers from the ground. (They sparkle.)|
C Go Fletch!|QID|27166|M|41.31,79.63|N|Collect the feathers sparkling on the ground.|
C A Mighty Hunger|QID|27167|US|M|41.93,79.46|N|Finish killing bears for Sides of Bear Meat.|
T Go Fletch!|QID|27166|M|42.73,83.98|N|To Commander Ashlam Valorfist.|
T A Mighty Hunger|QID|27167|M|42.73,83.98|N|To Thurman Grant.|
A Uther's Blessing|QID|27169|PRE|27167|M|42.73,83.98|N|From Commander Ashlam Valorfist.|
A Those That Couldn't Let Go|QID|27168|PRE|27167|M|43.32,83.81|N|From High Priestess MacDonnell.|

C Those That Couldn't Let Go|QID|27168|S|U|60861|M|49.84,80.79|
C Uther's Blessing|QID|27169|NC|U|61920|M|51.94,82.64|N|Use the Chillwind Tribute at Uther's Tomb.|

T Uther's Blessing|QID|27169|M|51.95,82.71|N|To High Priest Thel'danis.|
A The Abandoned Crypt|QID|27170|M|51.95,82.71|N|From High Priest Thel'danis.|
T The Abandoned Crypt|QID|27170|M|53.77,80.47|
A Ambushed!|QID|27171|PRE|27170|M|53.77,80.47|

C Ambushed!|QID|27171|M|54.82,79.75|N|Kill Skeletons on your way out. Loot the pieces you need.|
C Those That Couldn't Let Go|QID|27168|US|U|60861|M|49.84,80.79|N|From now on use the Holy Thurible on Withdrawn Souls.|

T Those That Couldn't Let Go|QID|27168|M|43.44,83.76|N|To High Priestess MacDonnell.|
A The Menders' Stead|QID|27175|M|43.02,83.61|N|From Argent Officer Pureheart.|
T Ambushed!|QID|27171|M|42.74,83.97|N|To Commander Ashlam Valorfist.|
A The Writhing Haunt|QID|27172|PRE|27171|M|42.74,83.97|N|From Commander Ashlam Valorfist.|

T The Writhing Haunt|QID|27172|M|53.78,64.67|N|To Thurman Grant.|
A This Is Our Army|QID|27173|PRE|27173|M|53.78,64.67|N|From Thurman Grant.|
C This Is Our Army|QID|27173|M|52.53,65.78|
T This Is Our Army|QID|27173|M|53.78,64.67|N|To Thurman Grant.|

A Combat Training|QID|27174|M|53.78,64.67|N|From Thurman Grant.|
C Combat Training|QID|27174|M|53.91,65.70|N|Help the villagers defeat Gory.|
T Combat Training|QID|27174|M|53.84,64.66|N|To Thurman Grant.|
T The Menders' Stead|QID|27175|M|49.31,54.87|N|To Field Agent Kaartish.|

A A New Era for the Plaguelands|QID|26999|PRE|27175|M|49.31,54.87|N|From Field Agent Kaartish.|
A Zen'Kiki, the Druid|QID|26953|M|48.98,54.75|N|From Adrine Towhide.|
A I Ain't Sayin' You a Gourd-Digger...|QID|26956|M|48.60,54.88|N|From Selyria Groenveld.|
A The Battle Resumes!|QID|27197|M|50.39,52.70|N|From Durnt Brightfalcon.|

f The Menders' Stead|QID|27197|M|50.49,52.34|N|At Marge Heffman.|
r Repair and Restock|QID|26953|NC|M|55.29,56.19|N|Repair and Restock.|

C I Ain't Sayin' You a Gourd-Digger...|QID|26956|M|46.23,52.27|
C A New Era for the Plaguelands|QID|26999|M|51.28,57.54|N|The Bears and Wolves are to the North. The spiders to the South.|
C Zen'Kiki, the Druid|QID|26953|M|52.11,58.67|
T A New Era for the Plaguelands|QID|26999|M|49.33,54.92|N|To Field Agent Kaartish.|

A Northridge Lumber Mill|QID|26935|PRE|26999|M|49.33,54.92|N|From Field Agent Kaartish.|
T Zen'Kiki, the Druid|QID|26953|M|48.93,54.74|N|To Adrine Towhide.|

A A Different Approach|QID|26954|PRE|26953|M|48.93,54.74|N|From Adrine Towhide.|
T I Ain't Sayin' You a Gourd-Digger...|QID|26956|M|48.58,54.89|N|To Selyria Groenveld.|

C A Different Approach|QID|26954|M|53.72,53.59|N|Poke (right click) him to get him to pull a bird. Help him kill it. Repeat.|
T A Different Approach|QID|26954|M|49.00,54.72|N|To Adrine Towhide.|
T Northridge Lumber Mill|QID|26935|M|48.12,32.45|N|To Nathaniel Dumah.|

A Learning the Ropes|QID|27000|PRE|26935|M|48.12,32.45|N|From Nathaniel Dumah.|
A Too Close for Comfort|QID|27013|M|48.35,31.84|N|From Kelly Dumah.|

C Too Close for Comfort|QID|27013|M|52.55,27.06|N|Hunt down those Rabid Foxes.|
T Too Close for Comfort|QID|27013|M|48.49,32.00|N|To Kelly Dumah.

A Redpine Thievery|QID|27011|PRE|27013|M|48.49,32.00|N|From Kelly Dumah.|
A A Gnoll's Resolve|QID|27012|PRE|27013|M|48.49,32.00|N|From Kelly Dumah.|

C A Gnoll's Resolve|QID|27012|S|M|49.71,42.20|N|From now on, collect Logs and kill Gnolls.|
C Redpine Thievery|QID|27011|M|49.76,42.09|N|They look like stacks of three sparkling logs.|
C A Gnoll's Resolve|QID|27012|US|M|49.71,42.20|N|Finish killing Gnolls for the needed loot.|

T Redpine Thievery|QID|27011|M|48.41,32.11|N|To Kelly Dumah.|
T A Gnoll's Resolve|QID|27012|M|48.41,32.11|N|To Kelly Dumah.|

C Learning the Ropes|QID|27000|M|47.67,31.80;45.33,35.73|N|Hop on a charger, run into a group of spiders and use Ability 1 to scare them away.|
T Learning the Ropes|QID|27000|M|48.13,32.44|N|To Nathaniel Dumah.|

A This Means WAR (Wild Arachnid Roundup)|QID|27001|M|48.13,32.44|N|From Nathaniel Dumah.|
C This Means WAR (Wild Arachnid Roundup)|QID|27001|M|47.95,33.53|N|Use the whinny to herd spiders back to the mill.|
T This Means WAR (Wild Arachnid Roundup)|QID|27001|M|48.11,32.47|N|To Nathaniel Dumah.|

A An Audience with the Highlord|QID|27002|PRE|27001|M|48.11,32.47|N|From Nathaniel Dumah.|

f Hearthglen|QID|26761|M|47.67,31.80;44.67,18.58|N|Hop on a charger and follow the road to Hearthglen. At William Henderson.|

A It's About Time!|QID|27156|M|43.24,16.02|N|From Lieutenant Myner.|
T An Audience with the Highlord|QID|27002|M|42.04,14.64|N|To Highlord Tirion Fordring.|

A The Long Trip Home|QID|26957|M|42.11,14.85|N|From Del Gahrron.|
A Taelan Fordring's Legacy|QID|27151|M|42.19,14.98|N|From Daria L'Rayne.|

C It's About Time!|QID|27156|M|43.09,16.33|N|Talk to Trainees. Challenge and beat them.|
T It's About Time!|QID|27156|M|43.28,15.96|N|To Lieutenant Myner.|

A Drudges...|QID|27157|PRE|27157|M|43.28,15.96|N|From Lieutenant Myner.|
C Drudges...|QID|27157|QO|Shadril slain: 1/1|M|45.86,12.31;45.37,9.73|T|Shadril|N|Enter the mine. Kill the *ew* huge spider.|
T Drudges...|QID|27157|M|43.27,15.91|N|To Lieutenant Myner.|

C Taelan Fordring's Legacy|QID|27151|M|54.78,24.69|N|Kill Gnoll looters.|
T Taelan Fordring's Legacy|QID|27151|M|54.99,24.73|

A Unusual Behavior... Even For Gnolls|QID|27152|PRE|27151|M|54.99,24.73|
C Unusual Behavior... Even For Gnolls|QID|27152|NC|M|54.78,34.10;56.16,34.70;57.07,35.56|N|Follow the arrows up the path. Kill Moldfang.|
T Unusual Behavior... Even For Gnolls|QID|27152|M|57.28,35.71|

A The Good People of Hearthglen|QID|27153|PRE|27152|M|57.28,35.71|
N Bree Ironstock|QID|27153|M|43.68,17.22|QO|Speak with Bree Ironstock: 1/1|N|Back to Hearthglen. Talk to Bree Ironstock.|
N High Cleric Alphus|QID|27153|M|42.15,18.24|QO|Speak with High Cleric Alphus: 1/1|N|Talk to High Cleric Alphus.|
N Morris Vant|QID|27153|M|44.38,13.55|QO|Speak with Morris Vant: 1/1|N|Talk to Morris Vant.|
C The Good People of Hearthglen|QID|27153|M|44.82,12.47|N|Talk to Outfitter Mendelev.|
T The Good People of Hearthglen|QID|27153|M|44.82,12.47|N|(With a UI Alert)|

A Bagging Bisp|QID|27154|PRE|27153|M|42.16,18.33|N|(From a UI Alert)|
C Bagging Bisp|QID|27154|M|45.90,18.46|N|Head up to the top of the tower and confront Bisp.|
T Bagging Bisp|QID|27154|M|45.90,18.46|

A Turning Yourself In|QID|27155|PRE|27154|M|45.90,18.46|
T Turning Yourself In|QID|27155|M|42.06,14.61|N|Head to the Highlord and face the music.|

F The Mender's Stead|QID|26957|NC|M|44.62,18.37|N|Fly to Mender's Stead.|

T The Long Trip Home|QID|26957|M|50.59,52.52|N|To Del Gahrron.|
A Memories from a Lost Past|QID|27017|PRE|26957|M|50.59,52.52|N|From Del Gahrron.|
A Gahrron's Withering Cauldron|QID|27053|M|49.30,54.84|N|From Field Agent Kaartish.|

C Gahrron's Withering Cauldron|QID|27053|M|62.71,59.17|N|Kill the Cauldron Lord and loot his key.|
T Gahrron's Withering Cauldron|QID|27053|M|62.58,58.62|N|At the Cauldron.|

A Return to the Stead|QID|27057|PRE|27053|M|62.58,58.62|
C Memories from a Lost Past|QID|27017|NC|M|64.93,59.43;64.88,59.32|N|The Prayer Book is upstairs. The Painting is hanging over the fireplace.|

T Return to the Stead|QID|27057|M|49.32,54.76|N|To Field Agent Kaartish.|
A Desperate Acts|QID|27054|PRE|27057|M|49.32,54.76|N|From Field Agent Kaartish.|
A Zen'Kiki and the Cultists|QID|26955|M|48.93,54.76|N|From Adrine Towhide.|
T Memories from a Lost Past|QID|27017|M|50.60,52.60|N|To Del Gahrron.|

C Desperate Acts|QID|27054|M|66.04,47.75|N|Kill Instructor Malicia and loot the orders.|
T Desperate Acts|QID|27054|M|66.04,47.75|N|(With a UI Alert)|
A Students of Krastinov|QID|27055|PRE|27054|M|66.04,47.75|N|(From a UI Alert)|
C Zen'Kiki and the Cultists|QID|26955|NC|M|66.78,47.12|N|Take Zen'Kiki to the cages. Open them, let him heal.|
C Students of Krastinov|QID|27055|M|65.22,38.83;64.64,35.20|N|Enter the cave and kill, kill, kill.|
T Students of Krastinov|QID|27055|M|49.31,54.81|N|To Field Agent Kaartish.|
T Zen'Kiki and the Cultists|QID|26955|M|48.93,54.77|N|To Adrine Towhide.|

F Andorhal|QID|27197|M|50.52,52.36|N|Fly to Andorhal.|

T The Battle Resumes!|QID|27197|M|39.84,69.47|N|To Thassarian.|
A Ashes to Ashes|QID|27199|PRE|27197|M|39.84,69.47|N|From Thassarian.|
A Supporting the Troops|QID|27198|PRE|27199|M|40.11,69.17|N|From Lang Loosegrip.|

C Supporting the Troops|QID|27198|S|M|44.45,65.66|N|From now on, kill Andorhal Deathguards and Deathguard War-Captains.|
C Ashes to Ashes|QID|27199|M|44.70,65.11|N|Kill three Deathguard War-Captains on their horses.|
C Supporting the Troops|QID|27198|US|M|44.45,65.66|N|Finish killing Deathguards.|

T Supporting the Troops|QID|27198|M|39.94,69.42|N|To Lang Loosegrip.|
T Ashes to Ashes|QID|27199|M|39.94,69.42|N|To Thassarian.|
A The Depravity of the Forsaken|QID|27205|PRE|27199|M|39.74,69.52|N|From Thassarian.|

T The Depravity of the Forsaken|QID|27205|M|39.84,69.51|N|To Thassarian.|
A Val'kyr Incursion|QID|27201|PRE|27205|M|39.84,69.51|N|From Thassarian.|
A Brother Against Brother|QID|27202|PRE|27205|M|39.82,69.69|N|From Thurman Grant.|

C Val'kyr Incursion|QID|27201|S|M|41.80,70.42|N|War! From now on kill Lesser Val'kyr and Frosaken Troopers.|
C Brother Against Brother|QID|27202|M|41.44,73.62|N|Kill Lesser Val'kyr.|
C Val'kyr Incursion|QID|27201|US|M|41.80,70.42|N|Finish killing those Lesser Val'kyr!|

T Brother Against Brother|QID|27202|M|39.90,69.65|N|To Thurman Grant.|
T Val'kyr Incursion|QID|27201|M|39.89,69.55|N|To Thassarian.|

A Aradne|QID|27204|PRE|27201|M|39.89,69.55|N|From Thassarian.|
C Aradne|QID|27204|M|40.37,72.24|
T Aradne|QID|27204|M|39.97,69.58|N|To Thassarian.|

A Alas, Andorhal|QID|27206|PRE|27204|M|39.97,69.58|N|From Thassarian.|

F Chillwind Camp|QID|27206|NC|N|Fly to Chillwind Camp.|

T Alas, Andorhal|QID|27206|M|42.73,84.12|N|To Commander Ashlam Valorfist.|
]]
end)
