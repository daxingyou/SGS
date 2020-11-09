
local ViewBase = require("app.ui.ViewBase")
local ChatCopyNode = class("ChatCopyNode", ViewBase)

function ChatCopyNode:ctor(point,txt)
    self._point = point 
    self._txt = txt 
	local resource = {
		file = Path.getCSB("ChatCopyNode", "chat"),
		binding = {
			_imageBg = {
				events = {{event = "touch", method = "_onButton"}}
			},
		}
	}
	ChatCopyNode.super.ctor(self, resource)
end

function ChatCopyNode:onCreate()
	-- i18n pos lable
	self:_dealPosByI18n()
    self._resourceNode:addTouchEventListener(handler(self, self._onScrollViewTouchCallBack))
    self._resourceNode:setSwallowTouches(false)
end

function ChatCopyNode:onEnter()
	local imageBgPos = self._resourceNode:convertToNodeSpace(self._point)
	--dump(self._point)
 	--dump(imageBgPos)
    self._imageBg:setPosition(imageBgPos.x,imageBgPos.y+50)
end

function ChatCopyNode:onExit()
end

function ChatCopyNode:_onTouchOther(sender)
end 

function ChatCopyNode:_onButton(sender)
    local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
	local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
	if offsetX < 20 and offsetY < 20  then
		 self:_onClick()
         
	end
end

function ChatCopyNode:_onClick()
    G_SignalManager:dispatch(SignalConst.EVENT_CHAT_COPY_MSG,self._txt)
    self:_close()
end

function ChatCopyNode:_onScrollViewTouchCallBack(sender,state)
    --if state == ccui.TouchEventType.moved then
    --end
   self:_close()
end

function ChatCopyNode:_close()
     self:removeFromParent()
end

-- i18n pos lable
function ChatCopyNode:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		local text1 = UIHelper.seekNodeByName(self._imageBg,"Text_1")
		text1:setFontSize(text1:getFontSize()-4)
		local size = self._imageBg:getContentSize()
		self._imageBg:setContentSize(cc.size(size.width+30,size.height))
		text1:setPositionX(text1:getPositionX()+15)
	end
end

return ChatCopyNode 