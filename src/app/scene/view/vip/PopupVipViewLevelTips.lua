local PopupBase = require("app.ui.PopupBase")
local PopupVipViewLevelTips = class("PopupVipViewLevelTips", PopupBase)

function PopupVipViewLevelTips:ctor(fromNode)
	self._fromNode = fromNode
	local resource = {
		file = Path.getCSB("PopupVipViewLevelTips", "vip"),
		binding = {
			
		}
	}
	PopupVipViewLevelTips.super.ctor(self, resource, false, true)
end

function PopupVipViewLevelTips:onCreate()
	self._label = nil
	self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
	self._panelTouch:setSwallowTouches(false)
	self._panelTouch:addClickEventListener(handler(self, self._onClick)) --避免0.5秒间隔
end

function PopupVipViewLevelTips:onEnter()
	self:_updateView()
end

function PopupVipViewLevelTips:onExit()
	
end

--重写opne&close接口，避免黑底层多层时的混乱现象
function PopupVipViewLevelTips:open()
	local scene = G_SceneManager:getRunningScene()
	scene:addChildToPopup(self)
end

function PopupVipViewLevelTips:close()
	self:onClose()
	self.signal:dispatch("close")
	self:removeFromParent()
end

function PopupVipViewLevelTips:_updateView()
    local bgSize = self._panelBg:getContentSize()
    local textWidth = bgSize.width-25
    self._textName:getVirtualRenderer():setMaxLineWidth(textWidth)
    self._textName:setString(Lang.get("vip_level_tips"))

    local newBgHeight = self._textName:getContentSize().height + self._textName:getPositionY() * 2
    self._panelBg:setContentSize(cc.size(bgSize.width,newBgHeight))

	--确定位置
	local nodePos = self._fromNode:convertToWorldSpace(cc.p(0,0))
	local nodeSize = self._fromNode:getContentSize()
	local posX = nodePos.x + self._panelBg:getContentSize().width / 2 + 5
	local posY = nodePos.y  - 5 - self._panelBg:getContentSize().height / 2
	local dstPos = self:convertToNodeSpace(cc.p(posX, posY))
	self._panelBg:setPosition(dstPos)
end

function PopupVipViewLevelTips:_onClick()
	self:close()
end



return PopupVipViewLevelTips