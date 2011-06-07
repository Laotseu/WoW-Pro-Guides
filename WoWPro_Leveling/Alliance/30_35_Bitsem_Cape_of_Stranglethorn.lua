-- URL: http://wow-pro.com/wiki/source_code_cape_stranglethorn_alliance
-- Date: 2011-06-05 12:07
-- Who: Crackerhead22

-- URL: http://wow-pro.com/node/3237/revisions/24501/view
-- Date: 2011-06-05 11:51
-- Who: Crackerhead22

-- URL: http://wow-pro.com/node/3237/revisions/24465/view
-- Date: 2011-05-31 20:59
-- Who: Ludovicus Maior
-- Log: "The Cape of Stranglethorn" is the zone name.  The "The" matters!

-- URL: http://wow-pro.com/node/3237/revisions/24298/view
-- Date: 2011-04-29 14:31
-- Who: Ludovicus Maior
-- Log: Line 131 for step T has unknown tag [Turns in at a barrel near the water.]

-- URL: http://wow-pro.com/node/3237/revisions/24218/view
-- Date: 2011-04-05 23:30
-- Who: Ludovicus Maior

-- URL: http://wow-pro.com/node/3237/revisions/24145/view
-- Date: 2011-03-06 19:21
-- Who: Ludovicus Maior
-- Log: Removed references to [The Curse of the Tides] which is obsolete.
--	Besides, they were all A steps and no C and T's.  Wierd.

-- URL: http://wow-pro.com/node/3237/revisions/24126/view
-- Date: 2011-02-23 01:26
-- Who: Ludovicus Maior
-- Log: Corrected Coordinates on [A Good-Fer-Nothin' Slither-Dogs], [Zanzil's Secret] and [Backdoor Dealings].
--	Removed PRE tag on [Dask "The Flask" Gobfizzle] as it did not seem to be required for me.

-- URL: http://wow-pro.com/node/3237/revisions/23353/view
-- Date: 2010-12-03 11:08
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3237/revisions/23352/view
-- Date: 2010-12-03 11:07
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide('BitCap3035', 'The Cape of Stranglethorn', 'Bitsem', '30', '35', 'BitWes3540', 'Alliance', function()
return [[

T Hero's Call: Cape of Stranglethorn!|QID|28702|O|M|55.16,42.48|N|To Bronwyn Hewstrike.|
T To the Cape|QID|26805|O|M|55.16,42.48|N|To Bronwyn Hewstrike.|

A Dask "The Flask" Gobfizzle|QID|26825|M|55.12,42.44|N|From Bronwyn Hewstrike.|
T Dask "The Flask" Gobfizzle|QID|26825|M|55.33,42.01|N|To Dask "The Flask" Gobfizzle.|

A Too Big For His Britches|QID|26823|PRE|26825|M|55.33,42.01|N|From Dask "The Flask" Gobfizzle.|
A Good-Fer-Nothin' Slither-Dogs|QID|26822|RANK|2|M|54.76,41.86|N|From Goris.|

f Explorers' League Digsite|QID|26822|M|55.65,41.26|N|At Colin Swifthammer.|

C Good-Fer-Nothin' Slither-Dogs|QID|26822|S|M|44.50,19.02|N|Kill Stranglethorn Basilisks on your way to Ironjaw Behemoth.|
C Too Big For His Britches|QID|26823|M|66.13,27.50|N|Head inside the cave, kill and loot an Ironjaw Behemoth.|
C Good-Fer-Nothin' Slither-Dogs|QID|26822|US|M|60.83,28.24|N|Finish killing Basilisks.|

T Too Big For His Britches|QID|26823|M|55.21,41.99|N|To Dask "The Flask" Gobfizzle.|
A Perfectly Pure|QID|26817|PRE|26823|M|55.21,41.99|N|From Dask "The Flask" Gobfizzle.|
A Plush Pelts|QID|26818|PRE|26823|M|55.32,42.19|N|From Linzi Hewstrike.|
A Akiris by the Bundle|QID|26819|PRE|26823|M|55.32,42.19|N|From Linzi Hewstrike.|
A If They're Just Going to Leave Them Lying Around...|QID|26820|PRE|26823|M|55.32,42.19|N|From Linzi Hewstrike.|

T Good-Fer-Nothin' Slither-Dogs|QID|26822|M|55.05,42.41|N|To Goris.|

C Akiris by the Bundle|QID|26819|S|M|39.69,45.63|N|Kill Nagas for Akiris weed and gather Naga Icons while questing.|
C If They're Just Going to Leave Them Lying Around...|QID|26820|M|37.31,52.82|N|Pick up Naga Icons.|
C Perfectly Pure|QID|26817|M|43.88,49.00|N|Go to the top of the big hill, cross the bridge and loot Pure Water from the spring.|
C If They're Just Going to Leave Them Lying Around...|QID|26820|M|37.31,52.82|Pick up Naga Icons.|
C Akiris by the Bundle|QID|26819|US|M|39.69,45.63|N|Finish killing Naga.|
C Plush Pelts|QID|26818|M|40.04,30.65;50.88,9.12|N|Kill and loot Stranglethorn Tigresses and Elder Shadowmaw Panthers until you have all the fur needed.|

T Perfectly Pure|QID|26817|M|55.22,41.86|N|To Dask "The Flask" Gobfizzle.|
A Zanzil's Secret|QID|26815|PRE|26817|M|55.22,41.86|N|From Dask "The Flask" Gobfizzle.|

T Plush Pelts|QID|26818|M|55.44,42.07|N|To Linzi Hewstrike.|
T Akiris by the Bundle|QID|26819|M|55.44,42.07|N|To Linzi Hewstrike.|

A Maywiki|QID|26808|PRE|26819|M|55.44,42.07|N|From Linzi Hewstrike.|
T If They're Just Going to Leave Them Lying Around...|QID|26820|M|55.44,42.07|N|To Linzi Hewstrike.|
T Maywiki|QID|26808|M|55.68,42.14|N|To Maywiki.|

A Backdoor Dealings|QID|26809|PRE|26808|M|55.68,42.14|N|From Maywiki.|
C Zanzil's Secret|QID|26815|S|M|42.18,32.75|N|Kill Zanzil mobs while continuing.|
C Backdoor Dealings|QID|26809|M|54.18,31.45|N|Activate the Totem.|
C Zanzil's Secret|QID|26815|US|M|53.23,31.23|N|Finish killing Zanzil mobs for Zanzil's Mixtures.|

T Zanzil's Secret|QID|26815|M|55.24,41.90|N|To Dask "The Flask" Gobfizzle.|
A Results: Inconclusive|QID|26824|PRE|26815|M|55.24,41.90|N|From Dask "The Flask" Gobfizzle.|
A Recipe for Disaster|QID|26816|PRE|26815|M|55.24,41.90|N|From Dask "The Flask" Gobfizzle.|
T Results: Inconclusive|QID|26824|M|55.32,42.39|N|To Bronwyn Hewstrike.|
A Airwyn Bantamflax|QID|26821|PRE|26824|M|55.32,42.39|N|From Bronwyn Hewstrike.|
T Backdoor Dealings|QID|26809|M|55.72,42.20|N|To Maywiki.|
A Eliminate the Outcast|QID|26810|PRE|26809|M|55.72,42.20|N|From Maywiki.|

C Recipe for Disaster|QID|26816|S|M|62.27,41.98|N|Kill Zanzil Witchdoctors for the Formulation.|
A Message in a Bottle|QID|26603|M|62.41,46.70|N|From theHalf-Buried Bottle.|
C Recipe for Disaster|QID|26816|US|M|62.27,41.98|N|Kill Zanzil Witchdoctors for the Formulation.|
C Eliminate the Outcast|QID|26810|U|60374|M|61.15,44.61|N|Head to right next to the green portal.|

T Eliminate the Outcast|QID|26810|M|61.15,44.61|N|(UI Alert)|
A Through the Troll Hole|QID|26811|PRE|26810|M|61.15,44.61|N|(UI Alert)|
C Through the Troll Hole|QID|26811|U|60374|M|78.51,35.68|Z|Northern Stranglethorn|N|Go through the Rabbit Hole, I mean Troll Hole.|
T Through the Troll Hole|QID|26811|M|78.55,35.99|Z|Northern Stranglethorn|N|(UI Alert)|

A High Priestess Jeklik|QID|26812|PRE|26811|M|78.55,35.99|Z|Northern Stranglethorn|N|(UI Alert)|
C High Priestess Jeklik|QID|26812|U|60374|M|77.56,43.97|Z|Northern Stranglethorn|N|Destroy her body!|
T High Priestess Jeklik|QID|26812|M|77.42,44.07|Z|Northern Stranglethorn|N|(UI Alert)|

A Plunging Into Zul'Gurub|QID|26813|PRE|26812|M|77.42,44.07|Z|Northern Stranglethorn|N|(UI Alert)|
C Plunging Into Zul'Gurub|QID|26813|U|60374|M|82.11,35.37|Z|Northern Stranglethorn|N|Through another Troll Hole.|
T Plunging Into Zul'Gurub|QID|26813|M|82.11,35.37|Z|Northern Stranglethorn|N|(UI Alert)|

A High Priest Venoxis|QID|26814|PRE|26813|M|82.11,35.37|Z|Northern Stranglethorn|N|(UI Alert)|
C High Priest Venoxis|QID|26814|U|60374|M|83.70,35.96|Z|Northern Stranglethorn|N|Finish him off and grab the ladder. If you die, use the Fetish.|

T High Priest Venoxis|QID|26814|M|55.70,42.27|N|To Maywiki.|
T Recipe for Disaster|QID|26816|M|55.25,42.00|N|To Dask "The Flask" Gobfizzle.|
T Message in a Bottle|QID|26603|M|59.43,79.24|N|To Princess Poobah.|

A Protecting Her Royal Highness Poobah|QID|26604|PRE|26603|M|59.43,79.24|N|From Princess Poobah.|
C Protecting Her Royal Highness Poobah|QID|26604|M|58.07,84.56|N|Slay 5 Jaguero Stalkers.|
T Protecting Her Royal Highness Poobah|QID|26604|M|59.41,79.19|N|To Princess Poobah.|

A Grubby Little Paws|QID|26605|PRE|26604|M|59.41,79.19|N|From Princess Poobah.|
C Grubby Little Paws|QID|26605|M|64.81,82.81|N|Kill gorillas and monkeys for the Tiara, Scepter, Slippers and Diary.|
T Grubby Little Paws|QID|26605|M|59.51,79.17|N|To Princess Poobah.|

A Mukla's Demise|QID|26606|PRE|26605|M|59.51,79.17|N|From Princess Poobah.|
C Mukla's Demise|QID|26606|M|62.74,83.26|N|Kill Mukla. He will throw barrels at you DK style. Loot the Shackle Key.|
T Mukla's Demise|QID|26606|M|59.44,79.11|N|To Princess Poobah.|

A The Captain's Chest|QID|26599|M|40.33,67.87|N|From Captain Hecklebury Smotts.|
A The Bloodsail Buccaneers|QID|26609|M|42.66,71.96|N|From First Mate Crazz.|
A Stranglethorn Fever|QID|26597|M|41.88,72.81|N|From Fin Fizracket.|
A Scaring Shaky|QID|26593|M|42.05,73.46|N|From "Sea Wolf" MacKinley.|

T Airwyn Bantamflax|QID|26821|M|42.49,73.15|N|To Airwyn Bantamflax.|

h Booty Bay|QID|26593|M|40.93,73.79|N|At Innkeeper Skindle.|

f Booty Bay|QID|26593|NC|M|41.64,74.47|N|Get the Booty Bay flight path.|

T The Bloodsail Buccaneers|QID|26609|M|41.35,61.16|N|The turn-in is the Bloosail Correspondence ontop of a barrel near the water.|
A Bloodsail Treachery|QID|26610|PRE|26609|M|41.35,61.16|N|From the Bloosail Correspondence.|
l Weather-Beaten Coin|QID|26617|L|59143|M|41.35,61.23|N|Kill and loot "Good-Boy" Bruce.|
A An Old Sea Dog|QID|26617|U|59143|N|Accept this quest from the Weather-Beaten Coin.|

C Scaring Shaky|QID|26593|S|M|51,53|N|From now on kill Elder Mistvale Gorillas for Giblets.|
l Gorilla Fang|QID|26597|M|51,53|N|Kill and loot Gorillas until you get a Gorilla Fang.|L|2799|
R Spirit Den|QID|26597|M|52.28,52.12;53.28,49.01;54.00,46.69|N|Follow the waypoints to the cave.|
C Stranglethorn Fever|QID|26597|L|2797|Hand over the Gorilla Fang to Witch Doctor Unbagwam who will summon Mokk for you. Kill him and loot his heart.|
C Scaring Shaky|QID|26593|US|M|51,53|N|Finish killing Gorillas for Giblets.|
C The Captain's Chest|QID|26599|M|52.39,64.68;55.9,63.43|N|Kill Gorlash (He wanders between the waypoints.), and loot Smotts' Chest.|

H Booty Bay|QID|26599|N|Hearth to Booty Bay.|

T An Old Sea Dog|QID|26617|M|41.03,73.25|N|To Fleet Master Seahorn.|
T Stranglethorn Fever|QID|26597|M|41.86,72.81|N|To Fin Fizracket.|
T Bloodsail Treachery|QID|26610|M|42.53,72.05|N|To First Mate Crazz.|

A The Baron Must Be Told|QID|26611|PRE|26610|M|42.53,72.05|N|From First Mate Crazz.|
T The Baron Must Be Told|QID|26611|M|41.14,73.15|N|To Baron Revilgaz.|

A Details of the Attack|QID|26612|PRE|26611|M|41.14,73.15|N|From Baron Revilgaz.|
A Up to Snuff|QID|26613|M|40.74,73.72|N|From Deeg.|
T The Captain's Chest|QID|26599|M|40.37,67.76|N|To Captain Hecklebury Smotts.|

A A Giant's Feast|QID|26600|PRE|26599|M|40.37,67.76|N|From Captain Hecklebury Smotts.|
T Scaring Shaky|QID|26593|M|40.48,67.70|N|To "Shaky" Phillipe.|

A Return to MacKinley|QID|26594|PRE|26593|M|40.48,67.70|N|From "Shaky" Phillipe.|
A Keep An Eye Out|QID|26614|M|43.43,71.37|N|Up the ramp and around to Dizzy One-Eye.|
T Return to MacKinley|QID|26594|M|41.99,73.47|N|To "Sea Wolf" MacKinley.|
A Kill-Collect|QID|26595|PRE|26594|M|41.99,73.47|N|From "Sea Wolf" MacKinley.|
B Crate of Pupellyverbos Port|QID|26600|M|41.01,73.98|N|Buy Crate of Pupillyverbos Port from Whiskey Slim inside the Tavern.|L|59037|
C A Giant's Feast|QID|26600|NC|M|42.78,69.11|N|Then goto Kelsey Yance. Buy Crate of Grade E Meat from him.|
T A Giant's Feast|QID|26600|M|40.37,67.86|N|To Captain Hecklebury Smotts.|
A A Dish Best Served Huge|QID|26602|PRE|26600|M|40.37,67.86|N|From Captain Hecklebury Smotts.|

K Freewheelin' Juntz Fitztittle|QID|26595|L|59034|M|56.50,57.89;56.79,53.75|N|Kill Freewheelin' while he runs between these to towers. Loot his wrench.|
K Ephram "Midriff" Moonfall|QID|26595|L|59035|M|56.12,49.73|N|Talk to "Midriff", he'll attack you. Kill him and loot his Mirror.|
C Kill-Collect|QID|26595|L|3924|M|59.55,49.16|N|Kill Maury "Clubfoot" Wilkins. Loot his Clubbed Foot.|

C Keep An Eye Out|QID|26614|M|43.16,81.72|N|Kill and loot Bloodsail mobs until this drops.|S|
C Up to Snuff|QID|26613|M|41.17,82.64|N|Kill and loot Bloodsail mobs until you get 15 Snuff.|S|
C A Dish Best Served Huge|QID|26602|QO|Negolash slain: 1/1|M|49.68,81.16|N|Activate the Life Boat. Put in the food. Wait for Negolash to appear. Kill him!|
C Details of the Attack|QID|26612|M|45.09,79.59;42.08,83.04;41.12,82.55|N|The Orders and the Charts can be at any of the waypoints. Don't forget to kill the Bloodsail mobs needed.|
C Keep An Eye Out|QID|26614|M|43.16,81.72|N|Kill and loot Bloodsail mobs until this drops.|US|
C Up to Snuff|QID|26613|M|41.17,82.64|N|Kill and loot Bloodsail mobs until you get 15 Snuff.|US|

H Booty Bay|QID|26612|NC|M|41.19,73.06|N|Hearth or run to Booty Bay.|

T Up to Snuff|QID|26613|M|40.75,73.78|N|To Deeg.|
T Details of the Attack|QID|26612|M|41.12,73.13|N|To Baron Revilgaz.|

A Getting In With the Bloodsail|QID|26624|PRE|26612|M|41.12,73.13|N|From Baron Revilgaz.|
T Kill-Collect|QID|26595|M|42.04,73.47|N|To "Sea Wolf" MacKinley.
T Keep An Eye Out|QID|26614|M|43.33,71.41|N|Up the ramp to Dizzy One-Eye.|
T A Dish Best Served Huge|QID|26602|M|40.37,67.84|N|To Captain Hecklebury Smotts.|

A Mok'rash the Cleaver|QID|26601|PRE|26602|M|40.37,67.84|N|From Captain Hecklebury Smotts.|
C Mok'rash the Cleaver|QID|26601|M|35.15,65.70|N|Swim West to the Island. Kill Mok'rash.|
T Mok'rash the Cleaver|QID|26601|M|40.33,67.85|N|To Captain Hecklebury Smotts.|

T Getting In With the Bloodsail|QID|26624|M|45.45,56.16;43.84,56.46|N|Up the path to Yancey Grillsen.|
A Seeing Where Your Loyalties Lie|QID|26629|PRE|26624|M|43.84,56.46|N|From Yancey Grillsen.|
A Looks Like a Tauren Pirate to Me|QID|26630|M|41.14,73.25|N|From Fleet Master Seahorn.|

l Cow Head|QID|26630|L|59147|M|43.24,71.67|N|Go upstairs and talk to Bossy the Cow.|
l Oversized Pirate Hat|QID|26630|L|59148|M|42.72,69.13|N|Talk to Narkk and get the hat from him.|
C Looks Like a Tauren Pirate to Me|QID|26630|M|41.06,73.28|N|Take the Head and Hat to the Fleetmaster.|
T Looks Like a Tauren Pirate to Me|QID|26630|M|41.06,73.28|N|To Fleet Master Seahorn.|

T Seeing Where Your Loyalties Lie|QID|26629|M|43.85,56.34|N|To Yancey Grillsen.|
A Your First Day as a Pirate|QID|26631|PRE|26629|M|43.85,56.34|N|From Yancey Grillsen.|

T Your First Day as a Pirate|QID|26631|M|44.41,91.61|N|To Captain Keelhaul.|
A Swabbing Duty|QID|26633|PRE|26631|M|44.41,91.61|N|From Captain Keelhaul.|
A Cannonball Swim|QID|26635|M|44.53,92.92|N|From "Pretty Boy" Duncan.|
C Swabbing Duty|QID|26633|M|44.73,92.84|N|Grab a mop up on deck and activate the globs of goo as they appear. Or if you're lazy, pay Duncan a gold to do it for you.|

A The Bane of Many A Pirate|QID|26634|M|44.50,92.03|N|Up by the helm from Garr Salthoof.|
T Swabbing Duty|QID|26633|M|44.47,91.41|N|To Captain Keelhaul.|
C Cannonball Swim|QID|26635|M|43.59,97.78|N|Dive off the ship and search the bottom for cannonballs.|
T Cannonball Swim|QID|26635|M|44.62,93.47|N|To "Pretty Boy" Duncan.|
C The Bane of Many A Pirate|QID|26634|M|45.97,80.36|N|Look for crates near trees and rowboats. Kill the theives that appear.|
T The Bane of Many A Pirate|QID|26634|M|44.51,91.89|N|To Garr Salthoof.|

A Attracting Attention|QID|26644|PRE|26633|M|44.43,91.69|N|From Captain Keelhaul.|
T Attracting Attention|QID|26644|M|46.68,95.26|N|To Fleet Master Firallon.|

A Ol' Blasty|QID|26647|M|46.68,94.97|N|From Ironpatch.|
A Our Mortal Enemies|QID|26648|M|46.57,94.11|N|From "Dead-Eye" Drederick McGumm.|
C Ol' Blasty|QID|26647|M|46.90,93.91|N|Grab a cannon. Ability 1 is ready, 2 is Aim (locks target in place), aim ahead of the dummy. Ability 3 Fires the cannon.|
T Ol' Blasty|QID|26647|M|46.69,94.95|N|To Ironpatch.|

A Drive-By Piracy|QID|26649|PRE|26647|M|46.69,94.95|N|From Ironpatch.|
C Drive-By Piracy|QID|26649|M|45.93,89.66|N|Talk to the Bloodsail Oarsman to get on the boat. Use the cannon and kill Ventrue Co. Oil Workers.|
C Our Mortal Enemies|QID|26648|U|59226|M|63.34,83.65|N|When you get to the island, use the flare and go Pirates vs. Ninjas!|
T Our Mortal Enemies|QID|26648|M|63.18,83.31|N|(UI Alert)|
T Drive-By Piracy|QID|26649|M|46.68,94.99|N|To Ironpatch.|

A The Damsel's Luck|QID|26650|PRE|26649|M|46.70,95.24|N|From Fleet Master Firallon.|
T The Damsel's Luck|QID|26650|M|50.30,91.46|N|To Captain Still Water's Charts.|

A The Brashtide Crew|QID|26662|PRE|26650|M|50.30,91.46|N|From Captain Still Water's Charts.|
A Sinking From Within|QID|26663|PRE|26650|M|50.30,91.46|N|From Captain Still Water's Charts.|
A Making Mutiny|QID|26664|PRE|26650|M|50.30,91.46|N|From Captain Still Water's Charts.|

C Making Mutiny|QID|26664|M|44.71,92.59|S|N|Accuse Corsairs of mutiny. When they attack, kill them.|
C Speak with Long John Copper|QID|26662|M|51.27,91.38|QO|Speak with Long John Copper: 1/1|N|On The Damsel's Luck.|
C Sabotage the Grog|QID|26663|M|50.96,91.52|QO|Sabotage the Grog: 1/1|N|On the lowest level of The Damsel's Luck.|

C Speak with Enormous Shawn Stooker|QID|26662|M|46.77,94.17|QO|Speak with Enormous Shawn Stooker: 1/1|N|Now head to The Crimson Veil ship. Go to the lowest level and speak to Enormous Shawn.|
C Sabotage the Gunpowder|QID|26663|M|46.80,93.79|QO|Sabotage the Gunpowder: 1/1|N|Activate the Gunpowder Barrell on the lowest level of the ship.|

C Speak with Wailing Mary Smitts|QID|26662|M|44.52,93.15|QO|Speak with Wailing Mary Smitts: 1/1|N|Last, head to The Riptide ship. One level down, speak to Wailing Mary.|
C Sabotage the Cannonballs|QID|26663|M|44.71,92.78|QO|Sabotage the Cannonballs: 1/1|N|On the lowest level, between a wall and some normal crates.|
C Making Mutiny|QID|26664|M|44.71,92.59|US|N|Finish your accusations if necessary.|

T The Brashtide Crew|QID|26662|M|44.52,93.15|N|(UI Alert)|
T Making Mutiny|QID|26664|M|44.71,92.59|N|(UI Alert)|
T Sinking From Within|QID|26663|M|44.71,92.78|N|(UI Alert)|

A Call of Booty|QID|26665|PRE|26663;26664;26662|M|44.71,92.78|N|(UI Alert)|

H Booty Bay|QID|26665|NC|N|Hearth to Booty Bay.|

T Call of Booty|QID|26665|PRE|26662;26664;26663|M|41.13,73.17|N|To Baron Revilgaz.|
A Doublerum|QID|26678|PRE|26665|M|41.13,73.17|N|From Baron Revilgaz.|
T Doublerum|QID|26678|M|40.69,73.27|N|Go down three flights of stairs and into the room on the right.|

A Return to Revilgaz|QID|26679|PRE|26678|M|40.69,73.27|N|Loot the barrel and return to Baron Revilgaz.|
T Return to Revilgaz|QID|26679|M|41.19,73.16|N|To Baron Revilgaz.|

A Prepare for Takeoff|QID|26695|PRE|26679|M|41.19,73.16|N|From Baron Revilgaz.|
A Seeking Seahorn|QID|26698|PRE|26679|M|41.19,73.16|N|From Baron Revilgaz.|

T Seeking Seahorn|QID|26698|M|41.55,73.00|N|To Fleet Master Seahorn.|
A The Damsel's (Bad) Luck|QID|26700|PRE|26698|M|41.55,73.00|N|From Fleet Master Seahorn.|
A Turning the Brashtide|QID|26699|PRE|26698|M|41.55,73.00|N|From Fleet Master Seahorn.|

C Turning the Brashtide|QID|26699|S|M|42.59,72.46|N|From now on kill Brashtide Raiders on sight.|
C The Damsel's (Bad) Luck|QID|26700|M|41.49,73.00;41.29,71.25;41.12,70.93|N|Activate the rope beside him. Kill Corsairs. Activate the rope on the deck to get back.|
C Prepare for Takeoff|QID|26695|M|42.62,69.09|N|Inside the Old Port Authority. Loot the Crate behind Narkk.|
C Turning the Brashtide|QID|26699|US|M|42.59,72.46|N|Finish killing Raiders.|

T Prepare for Takeoff|QID|26695|M|41.10,73.07|N|To Baron Revilgaz.|
A The Final Voyage of the Brashtide|QID|26697|PRE|26695|M|41.12,73.09|N|From Baron Revilgaz.|
T The Damsel's (Bad) Luck|QID|26700|M|41.12,73.09|N|To Baron Revilgaz.|
T Turning the Brashtide|QID|26699|M|41.12,73.09|N|To Baron Revilgaz.|

C The Final Voyage of the Brashtide|QID|26697|M|40.47,73.38;34.06,53.27|N|Speak to Kebok for a ride. Use Action 1 to bomb the ships and rowboats. Don't forget you need to get 6 of them too. Use Action 3 to return when finished.|
T The Final Voyage of the Brashtide|QID|26697|M|41.12,73.12|N|To Baron Revilgaz.|

A Bloodsail's End|QID|26703|PRE|26679|M|41.12,73.12|N|From Baron Revilgaz.|
C Bloodsail's End|QID|26703|M|40.47,73.38;36.05,66.51|N|Speak to Kebok again. Once on the ship, go down to the Captain's room and kill him and his little parrot too.|
T Bloodsail's End|QID|26703|M|41.17,73.15|N|To Baron Revilgaz.|

A The Call of Kalimdor|QID|26596|M|40.56,68.20|N|If you're going to go to Dustwallow Marsh in Kalimdor next, skip this if you wish to do Western Plaguelands. From Corporal Jeyne.|
A The Battle for Andorhal|QID|28749|M|41.55,74.35|N|If you are going to go to the Western Plaguelands next. Ask him for teleport. From War-Mage Erallier.|

R Western Plaguelands|QID|28749|O|M|41.55,74.34|N|To continue to Western Plaguelands, get a teleport from War-Mage Erallier below the Alliance Flight Master.|
b Northern Barrens|QID|26596|O|M|39.10,67.05|N|To continue on to Dustwallow Marsh in Kalimdor, hop on the ship to Ratchet.|
N Close this step to go onto the next guide.|N|Those doing Dustwallow Marsh will have to load the guide manually.|
]]

end)
