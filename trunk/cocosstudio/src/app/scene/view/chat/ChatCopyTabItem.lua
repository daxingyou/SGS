
local ListViewCellBase = require("app.ui.ListViewCellBase")
local ChatCopyTabItem = class("ChatCopyTabItem", ListViewCellBase)


function ChatCopyTabItem:ctor()
    self._text = nil
    self._panelLine = nil
	local resource = {
		file = Path.getCSB("ChatCopyTabItem", "chat"),
		binding = {
		},
	}
	ChatCopyTabItem.super.ctor(self, resource)
end

function ChatCopyTabItem:onCreate()
	-- body
	local size = self._resourceNode:getContentSize()
    self:setContentSize(size.width, size.height)

    self._resourceNode:setSwallowTouches(false)
    self._resourceNode:addClickEventListenerEx(handler(self, self._onButtonClick))
end


function ChatCopyTabItem:updateUI(txt)
    self._text:setString(txt)
end

function ChatCopyTabItem:showLine(visible)
    if visible then
        self._panelLine:setVisible(visible)
    end
end

function ChatCopyTabItem:_onButtonClick()
    self:dispatchCustomCallback(self:getIdx())
end

return ChatCopyTabItem
