local guide = WoWPro:RegisterGuide('LaotseuTalador', "Leveling", 'Talador', 'Laotseu', 'Alliance')
WoWPro:GuideLevels(guide,94,96,96.5)
WoWPro:GuideNextGuide(guide, 'EmmSoArak')
WoWPro:GuideSteps(guide, function()
return [[

N Not done yet|N|This guide has not be made yet. Sorry.|
L Level 94 |LVL|94|N|This guide requires a minimum level of 94 to do.|
]]
end)