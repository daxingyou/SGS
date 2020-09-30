--
-- Author: Your Name
-- Date: 2017-05-09 10:03:10
--
local scene = {}

scene.view = import(".TreasureDetailView")

-- i18n ja
if Lang.checkUI("ui4") then
    scene.view = import(".TreasureDetailView2") 
end


return scene