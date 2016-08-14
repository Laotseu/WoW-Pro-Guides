local guide = WoWPro:RegisterGuide('LinksVault099100', 'Leveling', 'Vault of the Wardens', 'Linkslegend5', 'Neutral')
WoWPro:GuideLevels(guide,99, 100)
WoWPro:GuideNextGuide(guide, '')
WoWPro:GuideClassSpecific(guide,"DemonHunter")
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
T Grand Theft Felbat|QID|39682|M|41.3,47.4|N|To Kor'vas Bloodthorn.|
A Frozen in Time|QID|39685|M|41.3,47.4|N|From Kor'vas Bloodthorn.|
A Beam Me Up|QID|39684|M|41.3,47.4|N|From Kor'vas Bloodthorn.|
A Forged in Fire|QID|39683|M|41.1,47.2|N|From Allari the Souleater.|
K Immolanth|QID|39683|T|Immolanth|M|47.0,17.1|N|Kill Immolanth slain and take his power.|
C Beam Me Up|QID|39684|NC|M|69.4,48.4|N|Rotate the Mirror. Watch out for the glowing ball of energy, they will kill you.|
C Activate the Western Countermeasure|QID|39685|NC|QO|3|M|43.58,78.04|
C Activate the Southern Countermeasure|QID|39685|NC|QO|2|M|46.58,84.16|
C Activate the Eastern Countermeasure|QID|39685|NC|QO|1|M|50.16,78.30|
T Frozen in Time|QID|39685|M|41.13,47.17|N|To Allari the Souleater.|
T Beam Me Up|QID|39684|M|41.13,47.17|N|To Allari the Souleater.|
T Forged in Fire|QID|39683|M|41.13,47.17|N|To Allari the Souleater.|
A All The Way Up|QID|39686|M|41.13,47.17|N|From Allari the Souleater.|
C All The Way Up|QID|39686|NC|M|46.8,47.9|N|Ascend to the Hall of Judgment|
;h The Warden's Court|QID|39686|M|24.42,55.86|N|At Kor'vas Bloodthorn.|
T All The Way Up|QID|39686|M|24.42,55.86|N|To Kor'vas Bloodthorn.|
A A New Direction|QID|40373|M|24.42,55.86|N|From Kor'vas Bloodthorn.|
C View the Pool of Judment|QID|40373|NC|QO|1|M|24.43,51.48|
C Choose between Kayn and Altruis|QID|40373|CHAT|QO|2|M|24.43,55.72|N|The choice is just for flovor. There is only customic game impact.|
T A New Direction|QID|40373|M|24.43,55.72|N|To Kor'vas Bloodthorn.|
A Between Us and Freedom|QID|39688;39694;40255;40256|M|24.43,55.72|N|From Kor'vas Bloodthorn.|
K Bastillax|QID|39688;39694;40255;40256|T|Bastillax|M|50.78,78.24|N|Kill Bastillax and take his power.|
T Between Us and Freedom|QID|39688;39694;40255;40256|M|84.04,82.82|N|To Altruis the Sufferer.|
A Illidari, We Are Leaving|QID|39689;39690|M|85.99,84.31|N|From Archmage Khadgar.|
T Illidari, We Are Leaving|QID|39689;39690|M|85.9,74.3|
A The Call of War |QID|39691|M|72.6,47.0|Z|Stormwind City|N|From Archmage Khadgar|
C The Call of War |QID|39691|NC|M|84.3,34.3|
T The Call of War |QID|39691|M|84.4,33.7|Z|Stormwind City|N|To Jace Darkweaver|
A Second Sight |QID|44471|M|84.4,33.7|Z|Stormwind City|N|From Jace Darkweaver|
T Second Sight |QID|44471|M|84.4,33.7|Z|Stormwind City|N|To Jace Darkweaver|
A Demons Among Them |QID|44463|M|84.4,33.7|Z|Stormwind City|N|From Jace Darkweaver|
C Demons Among Them |QID|44463|CHAT|QO|1|M|85.9,31.6|N|Warn King Anduin Wrynn|Z|Stormwind City|
C Demons Among Them |QID|44463|QO|2|M|81.3,25.7|N|Use your Spectral Sight to find demons and kill them.|Z|Stormwind City|
T Demons Among Them |QID|44463|M|85.7,31.8|Z|Stormwind City|N|To Anduin Wrynn|
A A Weapon of the Alliance |QID|44473|M|85.7,31.8|Z|Stormwind City|N|From Anduin Wrynn|
T A Weapon of the Alliance |QID|44473|M|40.3,77.7|Z|Stormwind City|N|To Elerion Bladedancer|
A Protect the Home Front |QID|40661|M|40.3,77.7|Z|Stormwind City|N|From Elerion Bladedancer|
]]
end)



