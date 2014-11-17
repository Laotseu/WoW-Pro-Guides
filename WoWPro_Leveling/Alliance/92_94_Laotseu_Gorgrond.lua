local guide = WoWPro:RegisterGuide('LaotseuGorgrond', "Leveling", 'Gorgrond', 'Laotseu', 'Alliance')
WoWPro:GuideLevels(guide,92,94,92.5)
WoWPro:GuideNextGuide(guide, 'LaotseuTalador')
WoWPro:GuideSteps(guide, function()
return [[

N Not done yet|N|This guide has not be made yet. Sorry.|
L Level 92 |LVL|92|N|This guide requires a minimum level of 92 to do.|
]]
end)