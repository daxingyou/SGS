local scene = {}

scene.view = import(".HorseDetailView")

-- i18n ja
if Lang.checkUI("ui4") then
    scene.view = import(".HorseDetailView2") 
end


return scene