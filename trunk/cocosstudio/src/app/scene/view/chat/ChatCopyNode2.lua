
local ViewBase = require("app.ui.ViewBase")
local ChatCopyNode2 = class("ChatCopyNode2", ViewBase)

function ChatCopyNode2:ctor(point,chatMsg)
    self._point = point 
    self._chatMsg = chatMsg 

    self._resourceNode = nil
    self._imageBg = nil
    self._listItem = nil
	local resource = {
		file = Path.getCSB("ChatCopyNode2", "chat"),
		binding = {
		}
	}
	ChatCopyNode2.super.ctor(self, resource)
end

function ChatCopyNode2:onCreate()
    self._resourceNode:addTouchEventListener(handler(self, self._onScrollViewTouchCallBack))
    self._resourceNode:setSwallowTouches(false)

    self:_initListView()
end

function ChatCopyNode2:_initListView()
    -- body
    self._listItem:removeAllChildren()
    local ChatCopyTabItem = require("app.scene.view.chat.ChatCopyTabItem")
	self._listViewData = self:_makeListData()
    self._items = {}
    local width = 0
    logWarn("ChatCopyNode2 list "..#self._listViewData)
	for k, v in ipairs(self._listViewData) do
        local item = ChatCopyTabItem.new()
        item:setIdx(k)
        item:setCustomCallback(handler(self,self._onItemTouch))
        item:updateUI(v)
        item:showLine(visible)
		self._listItem:pushBackCustomItem(item)
		self._items[k] = item
	end

	self._listItem:adaptWithContainerSize()
	
    local size = self._imageBg:getContentSize()
    local listSize = self._listItem:getContentSize()
	self._imageBg:setContentSize(cc.size(listSize.width,size.height))
end

function ChatCopyNode2:_makeListData()
    local ChatConst = require("app.const.ChatConst")
    if self._chatMsg:getChannel() == ChatConst.CHANNEL_GUILD or 
        self._chatMsg:getChannel() == ChatConst.CHANNEL_TEAM or 
        self._chatMsg:getSender():isSelf() or 
        self._chatMsg:isEvent() then
        return {Lang.get("chat2_copy")}
    else
        return {Lang.get("chat2_copy"),Lang.get("chat2_tipoff")}
    end
end

function ChatCopyNode2:onEnter()
	local imageBgPos = self._resourceNode:convertToNodeSpace(self._point)
    self._imageBg:setPosition(imageBgPos.x,imageBgPos.y+50)
end

function ChatCopyNode2:onExit()
end

function ChatCopyNode2:_onTouchOther(sender)
end 

function ChatCopyNode2:_onItemTouch(tag,idx)
    logWarn("ChatCopyNode2 _onItemTouch "..idx)
    if idx == 1 then
        G_NativeAgent:clipboard(self._chatMsg:getContent())
        G_SignalManager:dispatch(SignalConst.EVENT_CHAT_COPY_MSG,self._chatMsg:getContent())
    elseif idx == 2 then
        local UserDataHelper = require("app.utils.UserDataHelper")
        if UserDataHelper.isHasTipOffChatMsg(self._chatMsg) then
            G_Prompt:showTip(Lang.get("chat2_already_tipoff"))
        else
            G_SceneManager:showDialog("app.scene.view.chat.PopupTipoff",nil,nil,self._chatMsg)
        end
        
    end
    self:_close()
end


function ChatCopyNode2:_onScrollViewTouchCallBack(sender,state)
    --if state == ccui.TouchEventType.moved then
    --end
   self:_close()
end

function ChatCopyNode2:_close()
     self:removeFromParent()
end

return ChatCopyNode2 