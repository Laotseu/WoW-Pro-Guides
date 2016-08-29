local guide = WoWPro:RegisterGuide('LinksMardum098099', 'Leveling', 'Mardum, the Shattered Abyss', 'Linkslegend5', 'Neutral')
WoWPro:GuideLevels(guide,98, 99, 98.0)
WoWPro:GuideNextGuide(guide, 'LinksVault099100')
WoWPro:GuideClassSpecific(guide,"DemonHunter")
WoWPro:GuideIcon(guide,"ICON","Interface\\ICONS\\ClassIcon_DemonHunter")
WoWPro:GuideSteps(guide, function()
return [[
A The Invasion Begins|QID|40077|M|22.09,55.82|N|From Kayn Sunfury.|
C The Invasion Begins|QID|40077|QO|1|M|27.48,63.43|N|Slay Demons.|
C The Invasion Begins|QID|40077|QO|2|M|28.67,62.91|N|Change the Legion banner|
T The Invasion Begins|QID|40077|M|28.59,63.06|N|To Kayn Sunfury.|
A Assault on Mardum|QID|39279|M|28.59,63.06|N|From Kayn Sunfury.|
A Enter the Illidari: Ashtongue|QID|40378|M|28.55,62.95|N|From Kayn Sunfury.|
C Open the Gateway|QID|40378|NC|QO|1|M|31.5,62.0|N|Click on the Legion Gateway Activator.|
C Get your Felsaber|QID|40378|NC|QO|2|M|31.6,62.4|N|Click on the Felsaber to accept it.|
C Enter the Illidari: Ashtongue|QID|40378|QO|3|M|32.09,69.65|N|Find Allari to the southeast.|
T Enter the Illidari: Ashtongue|QID|40378|M|33.95,70.05|N|To Allari the Souleater.|
A Set Them Free|QID|38759|M|33.95,70.05|N|From Allari the Souleater.|
A Eye On the Prize|QID|39049|M|33.95,70.05|N|From Allari the Souleater.|
A Enter the Illidari: Coilskar|QID|40379|M|33.94,69.96|N|From Sevis Brightflame.|
C Set Them Free|QID|38759|QO|1|M|37.10,73.75|N|Get a Soulwrought Key from a Jailer|
C Set Them Free|QID|38759|QO|3|NC|M|39.35,71.72|N|Free Cyana Nightglaive|
C Set Them Free|QID|38759|QO|2|NC|M|41.72,73.21|N|Free Belath Dawnblade|
C Set Them Free|QID|38759|QO|4|NC|M|38.62,67.90|N|Free Izal Whitemoon|
C Set Them Free|QID|38759|QO|5|NC|M|41.59,66.67|N|Free Mannethrel Darkstar|
C Enter the Illidari: Coilskar|QID|40379|QO|1|CHAT|M|43.43,72.68|N|Click on thr Ashtoung Mystic to sacrifice his Soul.|
C Enter the Illidari: Coilskar|QID|40379|QO|2|NC|M|43.79,72.04|N|Click on the Legion Gateway Activator.|
K Inquisitor Baleful|QID|39049|T|Inquisitor Baleful|M|42.62,79.17|N|Kill Inquisitor Baleful and pick up the power taken|
T Set Them Free|QID|38759|M|38.80,60.63|N|To Jace Darkweaver.|
T Eye On the Prize|QID|39049|M|38.80,60.63|N|To Jace Darkweaver.|
T Enter the Illidari: Coilskar|QID|40379|M|38.80,60.63|N|To Jace Darkweaver.|
; T Assault on Mardum|QID|39279|M|39.43,70.47|N|To Foul Felstalker.| automatically turned in when done.
h Mardum, the Shattered Abyss|QID|40379|M|38.80,60.64|N|At Jace Darkweaver.|
A Meeting With the Queen|QID|39050|M|38.80,60.64|N|From Jace Darkweaver.|
C Meeting With the Queen|QID|39050|NC|M|38.80,60.64|N|Complete the ritual|
T Meeting With the Queen|QID|39050|M|38.80,60.64|N|To Jace Darkweaver.|
A Enter the Illidari: Shivarra|QID|38765|M|38.80,60.64|N|From Jace Darkweaver.|
A Before We're Overrun|QID|38766|M|38.80,60.64|N|From Jace Darkweaver.|
K Doom Commander Beliash|QID|38766|T|Doom Commander Beliash|M|34.71,39.21|N|Slay Beliashlain and pick up the power taken|
C Enter the Illidari: Shivarra|QID|38765|QO|1|CHAT|M|39.70,39.49|N|Talk to Sevis Brightflame and choose who you which to sacrifice.|
C Enter the Illidari: Shivarra|QID|38765|QO|2|NC|M|40.35,38.41|N|Activate the gateway.|
T Enter the Illidari: Shivarra|QID|38765|M|60.52,44.75|N|To Kayn Sunfury.|
T Before We're Overrun|QID|38766|M|60.52,44.75|N|To Kayn Sunfury.|
;h Illidari Foothold|QID|38766|M|60.52,44.75|N|At Kayn Sunfury.|
A Orders for Your Captains|QID|38813|M|60.52,44.75|N|From Kayn Sunfury.|
C Orders for Your Captains|QID|38813|CHAT|QO|2|M|59.24,46.15|N|Brief Lady S'theno|
C Orders for Your Captains|QID|38813|CHAT|QO|3|M|60.98,46.99|N|Brief Matron Mother Malevolence|
C Orders for Your Captains|QID|38813|CHAT|QO|1|M|62.18,46.29|N|Brief Battlelord Gaardoun|
T Orders for Your Captains|QID|38813|M|60.51,44.76|N|To Kayn Sunfury.|
A Give Me Sight Beyond Sight|QID|39262|M|60.51,44.76|N|From Kayn Sunfury.|
C Give Me Sight Beyond Sight|QID|39262|CHAT|QO|1|M|64.05,52.30|N|Speak with Jace Darkweaver|
C Give Me Sight Beyond Sight|QID|39262|NC|QO|2|M|64.0,52.8|N|Face the Cave and Use Spectral Sight|
T Give Me Sight Beyond Sight|QID|39262|M|64.05,52.30|N|To Jace Darkweaver.|
A Hidden No More|QID|39495|M|64.05,52.30|N|From Jace Darkweaver.|
K Fel Lord Caza|QID|39495|T|Fel Lord Caza|M|64.3,59.0|N|Sly Caza and pick up the power taken|
L Level 99|QID|39495|LVL|99|N|You should be around level 99 by this point.|
T Hidden No More|QID|39495|M|60.51,44.75|N|To Kayn Sunfury.|
A Stop the Bombardment|QID|38727|M|60.51,44.75|N|From Kayn Sunfury.|
A Their Numbers Are Legion|QID|38819|M|60.5,44.9|N|From Cyana Nightglaive.|
A Into the Foul Creche|QID|38725|M|60.53,44.66|N|From Allari the Souleater.|
C Their Numbers Are Legion|QID|38819|M|73.2,33.8|N|War progress|
C Stop the Bombardment|QID|38727|QO|3|NC|M|66.39,30.40|N|1/1 Soul Engine Devastator|
T Into the Foul Creche|QID|38725|M|73.16,33.82|N|To Kor'vas Bloodthorn.|
A The Imp Mother's Tome|QID|40222|M|73.15,33.83|N|From Kor'vas Bloodthorn.|
K Prolifica|QID|40222|T|Prolifica|M|76.97,27.52|N|Slay Prolifica and get the Tome of Fel Secrets|
C Stop the Bombardment|QID|38727|QO|2|M|75.01,41.07|N|1/1 Forge of Corruption Devastator|
C Stop the Bombardment|QID|38727|QO|1|M|69.28,48.77|N|1/1 Doom Fortress Devastator|
T The Imp Mother's Tome|QID|40222|M|60.52,44.82|N|To Kor'vas Bloodthorn.|
T Stop the Bombardment|QID|38727|M|60.51,44.75|N|To Kayn Sunfury.|
T Their Numbers Are Legion|QID|38819|M|60.51,44.75|N|To Kayn Sunfury.|
A Fel Secrets|QID|40051|M|60.51,44.82|N|From Kor'vas Bloodthorn.|
C Fel Secrets|QID|40051|NC|M|60.56,44.76|N|Click on the Tome of Secrets and Choose between Havoc & Vengeance|
T Fel Secrets|QID|40051|M|60.51,44.75|N|To Kayn Sunfury.|
A Cry Havoc and Let Slip the Illidari!|QID|39515;39516|M|60.51,44.75|N|From Kayn Sunfury.|
C Cry Havoc and Let Slip the Illidari!|QID|39516|CHAT|QO|2|M|60.55,44.86|N|Teach Cyana|
C Cry Havoc and Let Slip the Illidari!|QID|39516|CHAT|QO|4|M|60.52,44.82|N|Teach Kor'vas|
C Cry Havoc and Let Slip the Illidari!|QID|39516|CHAT|QO|3|M|60.51,44.75|N|Teach Kayn|
C Cry Havoc and Let Slip the Illidari!|QID|39516|CHAT|QO|1|M|60.53,44.66|N|Teach Allari|
C Cry Havoc and Let Slip the Illidari!|QID|39516|CHAT|QO|5|M|60.25,44.58|N|Teach Mannethrel|
T Cry Havoc and Let Slip the Illidari!|QID|39516|M|60.51,44.75|N|To Kayn Sunfury.|
A Vengeance Will Be Mine! |QID|39515;39516|M|60.51,44.75|N|From Kayn Sunfury.|
C Vengeance Will Be Mine! |QID|39515|CHAT|QO|2|M|60.55,44.86|N|Teach Cyana|
C Vengeance Will Be Mine! |QID|39515|CHAT|QO|4|M|60.52,44.82|N|Teach Kor'vas|
C Vengeance Will Be Mine! |QID|39515|CHAT|QO|3|M|60.51,44.75|N|Teach Kayn|
C Vengeance Will Be Mine! |QID|39515|CHAT|QO|1|M|60.53,44.66|N|Teach Allari|
C Vengeance Will Be Mine! |QID|39515|CHAT|QO|5|M|60.25,44.58|N|Teach Mannethrel|
C Vengeance Will Be Mine! |QID|39515|M|60.51,44.75|N|To Kayn Sunfury.|
T Vengeance Will Be Mine! |QID|39515|M|60.51,44.75|N|To Kayn Sunfury.|
A On Felbat Wings|QID|39663|M|60.51,44.75|N|From Kayn Sunfury.|
C On Felbat Wings|QID|39663|CHAT|M|62.53,44.90|N|Ride to the Fel Hammer|
T On Felbat Wings|QID|39663|M|69.93,44.23|N|To Cyana Nightglaive.|
;h The Fel Hammer|QID|39663|M|69.93,44.23|N|At Cyana Nightglaive.|
A The Keystone|QID|38728|M|69.93,44.23|N|From Cyana Nightglaive.|
K Brood Queen Tyranna|QID|38728|T|Brood Queen Tyranna|QO|1|M|69.77,40.35|N|Kill the Brood Queen Tyranna and get the Sargerite Keystone|
C The Keystone|QID|38728|NC|QO|2|M|70.70,39.04|N|Find the way downstairs.|
T The Keystone|QID|38728|M|69.85,37.90|N|To Kayn Sunfury.|
A Return to the Black Temple|QID|38729|M|69.85,37.90|N|From Kayn Sunfury.|
C Return to the Black Temple|QID|38729|NC|M|69.85,37.90|N|Activate the Sargerite Keystone|
T Return to the Black Temple|QID|38729|M|69.86,37.70|N|To Kayn Sunfury.|
;h Vault of Silence|QID|38729|M|69.86,37.70|N|At Kayn Sunfury.|
]]

end)

