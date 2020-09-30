local ViewBase = require("app.ui.ViewBase")
local ServiceButtonNode = class("ServiceButtonNode", ViewBase)

function ServiceButtonNode:ctor(icon,text,callback)
    self._icon = icon
    self._text = text
    self._callback = callback
	local resource = {
		file = Path.getCSB("ServiceButtonNode", "playerDetail"),
		binding = {
			_button = {
				events = {{event = "touch", method = "_onClickButton"}}
			},
		}
	}
	self:setName("ServiceButtonNode")
	ServiceButtonNode.super.ctor(self, resource)
end

function ServiceButtonNode:onCreate()
    self._name:setString(self._text)
    if Lang.checkLang(Lang.JA) and self._icon == "img_private" then
        self._name:setFontSize(18)
        self._name:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
        self._name:setPositionX(32)
    end
    self._image:loadTexture(Path.getPlayerDetail(self._icon))
end

function ServiceButtonNode:_onClickButton()
    if self._callback then
        self._callback()
    end
end

function ServiceButtonNode:onEnter()
end

function ServiceButtonNode:onExit()
end


return ServiceButtonNode
