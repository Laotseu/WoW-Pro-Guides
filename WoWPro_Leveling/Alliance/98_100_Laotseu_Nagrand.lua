local guide = WoWPro:RegisterGuide('LaotseuNagrand', "Leveling", 'Nagrand@Draenor', 'Laotseu', 'Alliance')
WoWPro:GuideLevels(guide,98,100,98.5)
--WoWPro:GuideNextGuide(guide, '')
WoWPro:GuideSteps(guide, function()
return [[

N Not done yet|N|This guide has not be made yet. Sorry.|
L Level 98 |LVL|98|N|This guide requires a minimum level of 98 to do.|
]]
end)