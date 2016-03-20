local guide = WoWPro:RegisterGuide('WodShadowAll', "Leveling", 'Shadowmoon Valley', 'LaoTseu', 'Alliance')
WoWPro:GuideLevels(guide,90,92,90.7)
WoWPro:GuideNextGuide(guide, 'WodSpireAll')
WoWPro:GuideIcon(guide,"ACH",4901)
WoWPro:GuideSteps(guide, function()
return [[


]]

end)



--[[
; After intro


A Step Three: Prophet! |QID|34575|M|44.4,80.7|Z|TanaanJungleIntro|N|From Archmage Khadgar|; Iron Bastion |Z|970;0|
T Step Three: Prophet! |QID|34575|M|27.0,8.1|Z|Shadowmoon Valley|N|To Prophet Velen|; Eventide Landing |Z|947;0|
A Finding a Foothold |QID|34582|M|27.0,8.1|Z|Shadowmoon Valley|N|From Prophet Velen|; Eventide Landing |Z|947;0|
T Finding a Foothold |QID|34582|M|28.8,16.2|Z|Lunarfall|N|To Vindicator Maraad|;  |Z|947;0|
A For the Alliance! |QID|34583|M|28.8,16.2|Z|Lunarfall|N|From Vindicator Maraad|;  |Z|947;0|
T For the Alliance! |QID|34583|M|29.1,16.2|Z|Lunarfall|N|To Baros Alexston|;  |Z|947;0|
A Looking for Lumber |QID|34584|M|29.1,16.2|Z|Lunarfall|N|From Baros Alexston|;  |Z|947;0|
A Ravenous Ravens |QID|34616|M|29.1,16.2|Z|Lunarfall|N|From Baros Alexston|;  |Z|947;0|
T Looking for Lumber |QID|34584|M|29.1,16.2|Z|Lunarfall|N|To Baros Alexston|;  |Z|947;0|
T Ravenous Ravens |QID|34616|M|29.1,16.2|Z|Lunarfall|N|To Baros Alexston|;  |Z|947;0|
A Quakefist |QID|34585|M|28.9,16.4|Z|Lunarfall|N|From Yrel|;  |Z|947;0|
T Quakefist |QID|34585|M|28.9,16.4|Z|Lunarfall|N|To Yrel|;  |Z|947;0|
A Establish Your Garrison |QID|34586|M|29.0,16.2|Z|Lunarfall|N|From Baros Alexston|;  |Z|947;0|
f Chupala's Outpost |M|30.6,17.8|Z|Lunarfall|N|Talk to Dungar Longdrink|; Chupala's Outpost |Z|947;0|
T Establish Your Garrison |QID|34586|M|29.9,17.8|Z|Lunarfall|N|To Baros Alexston|; Chupala's Outpost |Z|947;0|
A Keeping it Together |QID|35176|M|29.9,17.8|Z|Lunarfall|N|From Baros Alexston|; Chupala's Outpost |Z|947;0|
A Ship Salvage |QID|35166|M|29.9,17.8|Z|Lunarfall|N|From Baros Alexston|; Chupala's Outpost |Z|947;0|
A Pale Moonlight |QID|35174|M|30.2,18.2|Z|Lunarfall|N|From Vindicator Maraad|; Chupala's Outpost |Z|947;0|
C Keeping it Together |QID|35176|QO|1/1 Speak with Assistant Brightstone about her work ethic|M|30.3,18.2|Z|Lunarfall|; Chupala's Outpost |Z|947;0|
C Keeping it Together |QID|35176|QO|1/1 Check the Garrison Cache|M|30.7,17.2|Z|Lunarfall|; Chupala's Outpost |Z|947;0|
C Keeping it Together |QID|35176|QO|1/1 Gather Shelly's Report|M|29.0,16.2|Z|Lunarfall|; Chupala's Outpost |Z|947;0|
T Keeping it Together |QID|35176|M|41.2,49.4|Z|Lunarfall|N|To Baros Alexston|; Chupala's Outpost |Z|971;0|
C Pale Moonlight |QID|35174|QO|1/1 Gnaw Bloodseeker slain|M|25.5,6.3|Z|Shadowmoon Valley|; Eventide Landing |Z|947;0|
C Pale Moonlight |QID|35174|QO|8/8 Pale Devourer slain|M|25.5,5.2|Z|Shadowmoon Valley|; Eventide Landing |Z|947;0|
T Pale Moonlight |QID|35174|M|44.1,53.3|Z|Lunarfall|N|To Vindicator Maraad|; Chupala's Outpost |Z|971;0|
T Ship Salvage |QID|35166|M|41.2,49.4|Z|Lunarfall|N|To Baros Alexston|; Chupala's Outpost |Z|971;0|
A Build Your Barracks |QID|34587|M|41.2,49.4|Z|Lunarfall|N|From Baros Alexston|; Chupala's Outpost |Z|971;0|
C Build Your Barracks |QID|34587|QO|1/1 Find Blueprints|M|45.2,41.1|Z|Lunarfall|; Chupala's Outpost |Z|971;0|
; |U|111956|M|45.2,41.1|Z|Lunarfall|N|item:111956 [Garrison Blueprint: Barracks, Level 1]|; Chupala's Outpost |Z|971;0|
C Build Your Barracks |QID|34587|QO|1/1 Learn Blueprints|M|45.2,41.1|Z|Lunarfall|; Chupala's Outpost |Z|971;0|
C Build Your Barracks |QID|34587|QO|1/1 Use the Architect Table|M|41.3,49.0|Z|Lunarfall|; Chupala's Outpost |Z|971;0|
C Build Your Barracks |QID|34587|QO|1/1 Finalize your Plot|M|39.9,69.9|Z|Lunarfall|; Chupala's Outpost |Z|971;0|
T Build Your Barracks |QID|34587|M|44.1,53.4|Z|Lunarfall|N|To Vindicator Maraad|; Chupala's Outpost |Z|971;0|
A Qiana Moonshadow |QID|34646|M|44.1,53.4|Z|Lunarfall|N|From Vindicator Maraad|; Chupala's Outpost |Z|971;0|
T Qiana Moonshadow |QID|34646|M|40.5,54.0|Z|Town Hall|N|To Qiana Moonshadow|;  |Z|971;0|
A Delegating on Draenor |QID|34692|M|40.2,53.6|Z|Town Hall|N|From Lieutenant Thorn|;  |Z|971;0|
T Delegating on Draenor |QID|34692|M|40.2,53.6|Z|Town Hall|N|To Lieutenant Thorn|;  |Z|971;0|
A Migrant Workers |QID|34778|M|44.1,53.3|Z|Lunarfall|N|From Vindicator Maraad|; Chupala's Outpost |Z|971;0|
A A Hero's Welcome |QID|33075|M|47.1,50.9|Z|Lunarfall|N|From Unknown|; Chupala's Outpost |Z|971;0|
A Wanted: Kuu'rat's Tusks |QID|33833|M|33.3,30.7|Z|Shadowmoon Valley|; Moonflower Valley |Z|947;0|
; |U|111349|M|34.9,35.5|Z|Shadowmoon Valley|N|item:111349 [A Treatise on Mining in Draenor]|; Anguish Fortress |Z|947;0|
; Level up! 91
T Wanted: Kuu'rat's Tusks |QID|33833|M|45.5,37.7|Z|Shadowmoon Valley|N|To Eremor|; Embaari Village |Z|947;0|
T A Hero's Welcome |QID|33075|M|46.0,38.9|Z|Shadowmoon Valley|N|To Samaara|; Embaari Village |Z|947;0|
A Dark Enemies |QID|33765|M|46.0,38.9|Z|Shadowmoon Valley|N|From Samaara|; Embaari Village |Z|947;0|
f Embaari Village |M|45.7,38.9|Z|Shadowmoon Valley|N|Talk to Eonor|; Embaari Village |Z|947;0|
A Think of the Children! |QID|33070|M|46.6,37.8|Z|Shadowmoon Valley|N|From Efee|; Embaari Village |Z|947;0|
A Closing the Door |QID|33905|M|46.7,37.3|Z|Shadowmoon Valley|N|From Vindicator Tenuum|; Embaari Village |Z|947;0|
; |U|111387|M|46.7,34.1|Z|Shadowmoon Valley|N|item:111387 [The Joy of Draenor Cooking]|; Arbor Glen |Z|947;0|
; |U|111364|M|46.6,33.5|Z|Shadowmoon Valley|N|item:111364 [First Aid in Draenor]|; Arbor Glen |Z|947;0|
C Think of the Children! |QID|33070|QO|1/1 Hakaam saved|M|49.0,30.9|Z|Shadowmoon Valley|; Arbor Glen |Z|947;0|
A In Need of a Hero |QID|33813|M|52.0,32.7|Z|Shadowmoon Valley|N|From Ariaana|; Arbor Glen |Z|947;0|
; |U|118676|M|51.9,32.9|Z|Shadowmoon Valley|N|item:118676 [Reins of the Emerald Drake]|; Arbor Glen |Z|947;0|
; |U|111908|M|51.9,32.7|Z|Shadowmoon Valley|N|item:111908 [Draenei Bucket]|; Arbor Glen |Z|947;0|
; |U|111908|M|52.0,32.8|Z|Shadowmoon Valley|N|item:111908 [Draenei Bucket]|; Arbor Glen |Z|947;0|
C In Need of a Hero |QID|33813|QO|1/1 Floor fire doused|M|52.0,32.8|Z|Shadowmoon Valley|; Arbor Glen |Z|947;0|
; |U|111908|M|52.0,32.8|Z|Shadowmoon Valley|N|item:111908 [Draenei Bucket]|; Arbor Glen |Z|947;0|
C In Need of a Hero |QID|33813|QO|1/1 Bookshelf fire doused|M|52.0,32.8|Z|Shadowmoon Valley|; Arbor Glen |Z|947;0|
C In Need of a Hero |QID|33813|QO|1/1 Table fire doused|M|52.1,32.8|Z|Shadowmoon Valley|; Arbor Glen |Z|947;0|
C Think of the Children! |QID|33070|QO|1/1 Ariaana saved|M|52.0,32.7|Z|Shadowmoon Valley|; Arbor Glen |Z|947;0|
T In Need of a Hero |QID|33813|M|52.0,32.7|Z|Shadowmoon Valley|N|To Ariaana|; Arbor Glen |Z|947;0|
C Think of the Children! |QID|33070|QO|1/1 Rastaak saved|M|51.9,36.0|Z|Shadowmoon Valley|; Arbor Glen |Z|947;0|
T Migrant Workers |QID|34778|M|56.0,32.6|Z|Shadowmoon Valley|N|To Foreman Zipfizzle|; Elodor Fields |Z|947;0|
A Circle the Wagon |QID|34779|M|56.0,32.6|Z|Shadowmoon Valley|N|From Foreman Zipfizzle|; Elodor Fields |Z|947;0|
A Bonus Objective: The Hills of Valuun |QID|34496|M|58.5,33.6|Z|Shadowmoon Valley|; Hills of Valuun |Z|947;0|
T Bonus Objective: The Hills of Valuun |QID|34496|M|60.7,32.5|Z|Shadowmoon Valley|N|To Rockhide Bull|; Elodor |Z|947;0|
A Bonus Objective: The Hills of Valuun |QID|34496|M|60.5,33.0|Z|Shadowmoon Valley|N|From Rockhide Bull|; Hills of Valuun |Z|947;0|
T Bonus Objective: The Hills of Valuun |QID|34496|M|61.6,30.3|Z|Shadowmoon Valley|; Elodor |Z|947;0|
A Bonus Objective: The Hills of Valuun |QID|34496|M|61.9,31.2|Z|Shadowmoon Valley|; Hills of Valuun |Z|947;0|
T Bonus Objective: The Hills of Valuun |QID|34496|M|65.7,30.0|Z|Shadowmoon Valley|; Moonlit Shore |Z|947;0|
A Bonus Objective: The Hills of Valuun |QID|34496|M|65.6,31.1|Z|Shadowmoon Valley|; Hills of Valuun |Z|947;0|
T Bonus Objective: The Hills of Valuun |QID|34496|M|66.2,33.0|Z|Shadowmoon Valley|N|To Shaded Plainsstalker|; Hills of Valuun |Z|947;0|
A Bonus Objective: The Hills of Valuun |QID|34496|M|66.1,33.1|Z|Shadowmoon Valley|N|From Shaded Plainsstalker|; Hills of Valuun |Z|947;0|
T Bonus Objective: The Hills of Valuun |QID|34496|M|66.2,37.0|Z|Shadowmoon Valley|; Hills of Valuun |Z|947;0|
A Bonus Objective: The Hills of Valuun |QID|34496|M|66.2,37.1|Z|Shadowmoon Valley|; Hills of Valuun |Z|947;0|
C Bonus Objective: The Hills of Valuun |QID|34496|QO|12/12 Seacliff Kaliri slain|M|66.5,37.2|Z|Shadowmoon Valley|; Hills of Valuun |Z|947;0|
C Bonus Objective: The Hills of Valuun |QID|34496|QO|12/12 Shaded Plainsstalker slain|M|64.5,36.5|Z|Shadowmoon Valley|; Hills of Valuun |Z|947;0|
T Bonus Objective: The Hills of Valuun |QID|34496|M|64.6,36.7|Z|Shadowmoon Valley|; Hills of Valuun |Z|947;0|
f Fey Landing |M|58.7,31.9|Z|Shadowmoon Valley|N|Talk to Vamuun|; Fey Landing |Z|947;0|
C Circle the Wagon |QID|34779|QO|1/1 Locate the Missing Wagon|M|51.2,28.6|Z|Shadowmoon Valley|; Saraah's Vale |Z|947;0|
C Circle the Wagon |QID|34779|QO|1/1 Defend the Camp|M|51.2,28.6|Z|Shadowmoon Valley|; Saraah's Vale |Z|947;0|
C Circle the Wagon |QID|34779|QO|1/1 Escort the Laborers|M|55.7,32.9|Z|Shadowmoon Valley|; Elodor Fields |Z|947;0|
T Circle the Wagon |QID|34779|M|56.0,32.8|Z|Shadowmoon Valley|N|To Unknown|; Elodor Fields |Z|947;0|
A Invisible Ramparts |QID|34780|M|56.2,32.6|Z|Shadowmoon Valley|N|From Unknown|; Elodor Fields |Z|947;0|
C Invisible Ramparts |QID|34780|QO|1/1 Carry crystal to tertiary pylon|M|56.2,33.4|Z|Shadowmoon Valley|; Elodor Fields |Z|947;0|
C Invisible Ramparts |QID|34780|QO|1/1 Carry crystal to secondary pylon|M|56.6,33.1|Z|Shadowmoon Valley|; Elodor Fields |Z|947;0|
C Invisible Ramparts |QID|34780|QO|1/1 Carry crystal to primary pylon|M|56.2,32.7|Z|Shadowmoon Valley|; Elodor Fields |Z|947;0|
T Invisible Ramparts |QID|34780|M|56.9,34.7|Z|Shadowmoon Valley|N|To Exarch Hataaru|; Elodor Fields |Z|947;0|
A Defenstrations |QID|34781|M|56.9,34.7|Z|Shadowmoon Valley|; Elodor Fields |Z|947;0|
T Defenstrations |QID|34781|M|57.0,34.7|Z|Shadowmoon Valley|N|To Shadowmoon Raider|; Elodor Fields |Z|947;0|
A The Exarch Council |QID|34782|M|56.2,32.4|Z|Shadowmoon Valley|N|From Unknown|; Elodor Fields |Z|947;0|
T The Exarch Council |QID|34782|M|59.4,26.6|Z|Shadowmoon Valley|N|To Exarch Othaar|; Elodor |Z|947;0|
A Naielle, The Rangari |QID|34783|M|59.4,26.6|Z|Shadowmoon Valley|N|From Exarch Othaar|; Elodor |Z|947;0|
A Hataaru, the Artificer |QID|34785|M|59.4,26.6|Z|Shadowmoon Valley|N|From Exarch Othaar|; Elodor |Z|947;0|
T Hataaru, the Artificer |QID|34785|M|61.9,29.7|Z|Shadowmoon Valley|N|To Exarch Hataaru|; Elodor |Z|947;0|
A Shut 'er Down |QID|35070|M|61.9,29.7|Z|Shadowmoon Valley|N|From Exarch Hataaru|; Elodor |Z|947;0|
A Engorged Goren |QID|34786|M|61.9,29.1|Z|Shadowmoon Valley|N|From Apprentice Artificer Andren|; Elodor |Z|947;0|
T Engorged Goren |QID|34786|M|61.9,29.2|Z|Shadowmoon Valley|N|To Apprentice Artificer Andren|; Elodor |Z|947;0|
T Shut 'er Down |QID|35070|M|61.9,29.7|Z|Shadowmoon Valley|N|To Exarch Hataaru|; Elodor |Z|947;0|
T Naielle, The Rangari |QID|34783|M|56.5,23.5|Z|Shadowmoon Valley|N|To Exarch Naielle|; Rangari Enclave |Z|947;0|
A Fun with Fungus |QID|34784|M|56.5,23.5|Z|Shadowmoon Valley|N|From Exarch Naielle|; Rangari Enclave |Z|947;0|
A The Sting |QID|34790|M|56.7,23.0|Z|Shadowmoon Valley|N|From Rangari Chel|; Rangari Enclave |Z|947;0|
T The Sting |QID|34790|M|56.7,23.0|Z|Shadowmoon Valley|N|To Rangari Chel|; Rangari Enclave |Z|947;0|
T Fun with Fungus |QID|34784|M|56.5,23.5|Z|Shadowmoon Valley|N|To Exarch Naielle|; Rangari Enclave |Z|947;0|
A Exarch Maladaar |QID|34787|M|56.5,23.6|Z|Shadowmoon Valley|N|From Exarch Akama|; Rangari Enclave |Z|947;0|
T Exarch Maladaar |QID|34787|M|59.5,30.4|Z|Shadowmoon Valley|N|To Exarch Maladaar|; Fey Landing |Z|947;0|
A Trust No One |QID|35552|M|59.5,30.4|Z|Shadowmoon Valley|N|From Exarch Maladaar|; Fey Landing |Z|947;0|
T Trust No One |QID|35552|M|60.9,24.4|Z|Shadowmoon Valley|; Altar of Sha'tar |Z|947;0|
A Warning the Exarchs |QID|34791|M|60.9,24.4|Z|Shadowmoon Valley|; Altar of Sha'tar |Z|947;0|
T Warning the Exarchs |QID|34791|M|62.4,26.3|Z|Shadowmoon Valley|N|To Exarch Maladaar|; Altar of Sha'tar |Z|947;0|
A Speaker for the Dead |QID|34789|M|62.4,26.3|Z|Shadowmoon Valley|N|From Exarch Maladaar|; Altar of Sha'tar |Z|947;0|
C Speaker for the Dead |QID|34789|QO|1/1 Begin the Ritual|M|66.5,26.2|Z|Shadowmoon Valley|; Altar of Sha'tar |Z|947;0|
C Speaker for the Dead |QID|34789|QO|1/1 Defend Hataaru's Spirit|M|66.5,26.2|Z|Shadowmoon Valley|; Altar of Sha'tar |Z|947;0|
T Speaker for the Dead |QID|34789|M|66.4,26.2|Z|Shadowmoon Valley|N|To Exarch Maladaar|; Altar of Sha'tar |Z|947;0|
A The Traitor's True Name |QID|34792|M|66.4,26.2|Z|Shadowmoon Valley|N|From Exarch Maladaar|; Altar of Sha'tar |Z|947;0|
C The Traitor's True Name |QID|34792|QO|1/1 Plant the Focusing Lens|M|60.5,20.4|Z|Shadowmoon Valley|; Exarch's Rise |Z|947;0|
C The Traitor's True Name |QID|34792|QO|1/1 Reveal the Traitor|M|60.5,20.4|Z|Shadowmoon Valley|; Exarch's Rise |Z|947;0|
C The Traitor's True Name |QID|34792|QO|1/1 Deal with the Traitor|M|60.4,20.7|Z|Shadowmoon Valley|; Exarch's Rise |Z|947;0|
T The Traitor's True Name |QID|34792|M|62.6,26.2|Z|Shadowmoon Valley|N|To Exarch Maladaar|; Altar of Sha'tar |Z|947;0|
A Friend of the Exarchs |QID|34788|M|62.5,26.2|Z|Shadowmoon Valley|N|From Exarch Naielle|; Altar of Sha'tar |Z|947;0|
T Friend of the Exarchs |QID|34788|M|62.5,26.2|Z|Shadowmoon Valley|N|To Exarch Naielle|; Altar of Sha'tar |Z|947;0|
A Supply Drop |QID|35905|M|62.5,26.2|Z|Shadowmoon Valley|N|From Exarch Naielle|; Altar of Sha'tar |Z|947;0|
T Supply Drop |QID|35905|M|41.2,49.3|Z|Lunarfall|N|To Baros Alexston|; Chupala's Outpost |Z|971;0|
A Ashran Appearance |QID|36624|M|40.6,53.5|Z|Town Hall|N|From Lieutenant Thorn|;  |Z|971;0|
N Took a taxi |M|48.1,49.7|Z|Lunarfall|N|Talk to Dungar Longdrink|; Chupala's Outpost |Z|971;0|
F Embaari Village |N|Fly to Embaari Village, Shadowmoon Valley|M|45.7,39.0|Z|Shadowmoon Valley|; Embaari Village |Z|947;0|
T Think of the Children! |QID|33070|M|49.1,38.5|Z|Shadowmoon Valley|N|To Prophet Velen|; Teluuna Observatory |Z|947;0|
T Dark Enemies |QID|33765|M|49.1,38.5|Z|Shadowmoon Valley|N|To Prophet Velen|; Teluuna Observatory |Z|947;0|
T Closing the Door |QID|33905|M|49.1,38.5|Z|Shadowmoon Valley|N|To Prophet Velen|; Teluuna Observatory |Z|947;0|
A Shadows Awaken |QID|34019|M|49.1,38.5|Z|Shadowmoon Valley|N|From Prophet Velen|; Teluuna Observatory |Z|947;0|
C Shadows Awaken |QID|34019|QO|1/1 Ner'zhul confronted|M|49.3,37.2|Z|Shadowmoon Valley|; Teluuna Observatory |Z|947;0|
C Shadows Awaken |QID|34019|QO|1/1 Karnoth slain|M|49.5,36.8|Z|Shadowmoon Valley|; Teluuna Observatory |Z|947;0|
; |U|115507|M|49.5,36.8|Z|Shadowmoon Valley|N|item:115507 [Drained Crystal Fragment]|; Teluuna Observatory |Z|947;0|
A A Power Lost |QID|36408|M|49.5,36.8|Z|Shadowmoon Valley|; Teluuna Observatory |Z|947;0|
T Shadows Awaken |QID|34019|M|49.3,37.4|Z|Shadowmoon Valley|N|To Prophet Velen|; Teluuna Observatory |Z|947;0|
A Into Twilight |QID|33072|M|49.3,37.4|Z|Shadowmoon Valley|N|From Prophet Velen|; Teluuna Observatory |Z|947;0|
A The Southern Wilds |QID|35444|M|49.0,38.6|Z|Shadowmoon Valley|N|From Farmer Gehaar|; Teluuna Observatory |Z|947;0|
T A Power Lost |QID|36408|M|47.0,38.6|Z|Shadowmoon Valley|N|To Artificer Baleera|; Embaari Village |Z|947;0|
A Restoration |QID|36409|M|47.0,38.6|Z|Shadowmoon Valley|N|From Artificer Baleera|; Embaari Village |Z|947;0|




]]