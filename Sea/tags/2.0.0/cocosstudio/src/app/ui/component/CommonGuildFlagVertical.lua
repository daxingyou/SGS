
local CommonGuildFlag = require("app.ui.component.CommonGuildFlag")
local CommonGuildFlagVertical = class("CommonGuildFlagVertical",CommonGuildFlag)

function CommonGuildFlagVertical:ctor()
	CommonGuildFlagVertical.super.ctor(self)
end



function CommonGuildFlagVertical:getImagePath(index)
    return Path.getGuildVerticalFlagImage(index)
end


return CommonGuildFlagVertical