local CommonMainMenu = require("app.ui.component.CommonMainMenu")
local CommonMainMenu2 = class("CommonMainMenu2",CommonMainMenu)
local UIHelper = require("yoka.utils.UIHelper")

function CommonMainMenu2:_init()
    self._useLabel = false
	CommonMainMenu2.super._init(self)
end

return CommonMainMenu2
