local PopupBase = require("app.ui.PopupBase")
local PopupSceneTip = class("PopupSceneTip", PopupBase)

function PopupSceneTip:ctor(dstPosition,tipContent)
	self._dstPosition = dstPosition or cc.p(0, 0)
	self._tipContent = tipContent
	local resource = {
		file = Path.getCSB("PopupSceneTip", "main"),
		binding = {
		}
	}
	PopupSceneTip.super.ctor(self, resource, false, true)
end

function PopupSceneTip:onCreate()
	self._panelBg:setAnchorPoint(0.5,1)
	self._label = nil
	self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
	self._panelTouch:setSwallowTouches(false)
	self._panelTouch:addClickEventListener(handler(self, self._onClick)) --避免0.5秒间隔
end

function PopupSceneTip:onEnter()
	self:_updateView()
end

function PopupSceneTip:onExit()
	
end

--重写opne&close接口，避免黑底层多层时的混乱现象
function PopupSceneTip:open()
	local scene = G_SceneManager:getRunningScene()
	scene:addChildToPopup(self)
end

function PopupSceneTip:close()
	self:onClose()
	self.signal:dispatch("close")
	self:removeFromParent()
end

function PopupSceneTip:_updateView()
	if self._label == nil then
		self._label = cc.Label:createWithTTF("", Path.getCommonFont(), 22)
		self._label:setAnchorPoint(cc.p(0, 1))
		self._label:setColor(Colors.DARK_BG_ONE)
		self._label:setWidth(450)
		self._desNode:addChild(self._label)
	end

	self._label:setString(self._tipContent)

	local txtHeight = self._label:getContentSize().height
	local panelHeight = txtHeight + 70
	self._desNode:setPositionY(panelHeight - 35)
	local bgSize = self._panelBg:getContentSize()
	self._panelBg:setContentSize(cc.size(bgSize.width, panelHeight))
	self._panelBg:setPosition(self._dstPosition)
end

function PopupSceneTip:_onClick()
	self:close()
end

return PopupSceneTip