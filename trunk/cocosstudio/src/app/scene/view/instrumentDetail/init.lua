--
-- Author: Liangxu
-- Date: 2017-9-15 17:46:28
--
local scene = {}

scene.view = import(".InstrumentDetailView")

-- i18n ja
if Lang.checkUI("ui4") then
    scene.view = import(".InstrumentDetailView2") 
end

return scene