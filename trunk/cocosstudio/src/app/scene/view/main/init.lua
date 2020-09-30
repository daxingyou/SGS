local scene = {}

scene.view = import(".MainView")
if Lang.checkUI("ui4") then
    scene.view = import(".MainView2")
end

return scene