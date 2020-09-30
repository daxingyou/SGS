local scene = {}

if Lang.checkUI("ui4") then
    scene.view = import(".VipViewNew")
else
    scene.view = import(".VipView")
end
return scene