--
-- Author: Your Name
-- Date: 2017-02-28 15:29:44
--
local scene = {}

scene.view = import(".PetDetailView")

-- i18n ja
if Lang.checkUI("ui4") then
    scene.view = import(".PetDetailView2") 
end

return scene