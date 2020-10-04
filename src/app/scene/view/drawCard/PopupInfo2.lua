local PopupBase = require("app.ui.PopupBase")
local PopupInfo2 = class("PopupInfo2", PopupBase)

function PopupInfo2:ctor(fromNode)
	self._fromNode = fromNode
	local resource = {
		file = Path.getCSB("PopupDrawCardScoreIntro", "drawCard"),
		binding = {
			
		}
	}
	PopupInfo2.super.ctor(self, resource, false, true)
end

function PopupInfo2:onCreate()
	self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
	self._panelTouch:setSwallowTouches(false)
	self._panelTouch:addClickEventListener(handler(self, self._onClick)) --避免0.5秒间隔
end

function PopupInfo2:onEnter()
	self:_updateView()
end

function PopupInfo2:onExit()
	
end

--重写opne&close接口，避免黑底层多层时的混乱现象
function PopupInfo2:open()
	local scene = G_SceneManager:getRunningScene()
	scene:addChildToPopup(self)
end

function PopupInfo2:close()
	self:onClose()
	self.signal:dispatch("close")
	self:removeFromParent()
end

function PopupInfo2:_updateView()
	--确定位置
	local nodePos = self._fromNode:convertToWorldSpace(cc.p(0,0))
	local nodeSize = self._fromNode:getContentSize()
	local posX = nodePos.x - self._imageBG:getContentSize().width + 30 
	local posY = nodePos.y+26
	local dstPos = self:convertToNodeSpace(cc.p(posX, posY))
	self._imageBG:setPosition(dstPos)
end

function PopupInfo2:_onClick()
	self:close()
end



return PopupInfo2