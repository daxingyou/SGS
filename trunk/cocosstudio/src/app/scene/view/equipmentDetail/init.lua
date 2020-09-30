--
-- Author: Liangxu
-- Date: 2017-04-12 17:44:08
--
local scene = {}

scene.view = import(".EquipmentDetailView")
-- i18n ja
if Lang.checkUI("ui4") then
    scene.view = import(".EquipmentDetailView2") 
end

return scene