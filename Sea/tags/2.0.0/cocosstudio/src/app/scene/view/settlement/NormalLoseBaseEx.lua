--普通副本胜利界面
local ViewBase = require("app.ui.ViewBase")
local NormalLoseBaseEx = class("NormalLoseBaseEx", ViewBase)

function NormalLoseBaseEx:ctor()
    self._layerColor = cc.LayerColor:create(cc.c4b(0, 0, 0, 0))     --触摸面板
	local resource = {
		file = Path.getCSB("NormalLoseBaseEx", "settlement"),
		size = {1136, 640},
		binding = {
		}
	}
	NormalLoseBaseEx.super.ctor(self, resource)
end

function NormalLoseBaseEx:onCreate()
	self._layerColor:setAnchorPoint(0.5,0.5)
	self._layerColor:setIgnoreAnchorPointForPosition(false)
	self:addChild(self._layerColor)
	self._layerColor:setTouchEnabled(true)
    self._layerColor:setTouchMode(cc.TOUCHES_ONE_BY_ONE)
    self._layerColor:registerScriptTouchHandler(handler(self, self._onTouchHandler))
end

function NormalLoseBaseEx:onEnter()
end

function NormalLoseBaseEx:onExit()
end

--点击触摸返回
function NormalLoseBaseEx:_onTouchHandler(event,x,y)
	if event == "began" then
        return true
    elseif event == "ended" then
        G_SceneManager:popScene()
    end
end


function NormalLoseBaseEx:pushPanel(panel)
    self._listContent:pushBackCustomItem(panel)
end


return NormalLoseBaseEx