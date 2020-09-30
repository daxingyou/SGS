local PopupBase = require("app.ui.PopupBase")
local PopupServiceTips = class("PopupServiceTips", PopupBase)

function PopupServiceTips:ctor(fromNode)
	self._fromNode = fromNode
	local resource = {
		file = Path.getCSB("PopupServiceTips", "playerDetail"),
		binding = {
			
		}
	}
	PopupServiceTips.super.ctor(self, resource, false, true)
end

function PopupServiceTips:onCreate()
	self._label = nil
	self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
	self._panelTouch:setSwallowTouches(false)
	self._panelTouch:addClickEventListener(handler(self, self._onClick)) --避免0.5秒间隔
end

function PopupServiceTips:onEnter()
	self:_updateView()
end

function PopupServiceTips:onExit()
	
end

--重写opne&close接口，避免黑底层多层时的混乱现象
function PopupServiceTips:open()
	local scene = G_SceneManager:getRunningScene()
	scene:addChildToPopup(self)
end

function PopupServiceTips:close()
	self:onClose()
	self.signal:dispatch("close")
	self:removeFromParent()
end

function PopupServiceTips:_updateView()
    local bgSize = self._panelBg:getContentSize()
    local textWidth = bgSize.width-25
    self._textName:getVirtualRenderer():setMaxLineWidth(textWidth)
    self._textName:setString(Lang.get("player_detail_service_tips"))

    local newBgHeight = self._textName:getContentSize().height + self._textName:getPositionY() * 2
    self._panelBg:setContentSize(cc.size(bgSize.width,newBgHeight))

	--确定位置
	local nodePos = self._fromNode:convertToWorldSpace(cc.p(0,0))
	local nodeSize = self._fromNode:getContentSize()
	local posX = nodePos.x - self._panelBg:getContentSize().width / 2 + 60
	local posY = nodePos.y + self._panelBg:getContentSize().height / 2 + 40
	local dstPos = self:convertToNodeSpace(cc.p(posX, posY))
	self._panelBg:setPosition(dstPos)
end

function PopupServiceTips:_onClick()
	self:close()
end



return PopupServiceTips