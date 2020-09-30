local PopupBase = require("app.ui.PopupBase")
local PopupFriendState = class("PopupFriendState", PopupBase)

local PopupFriendStateNode = require("app.scene.view.activity.friendInvite.PopupFriendStateNode")
local Hero = require("app.config.hero")
local Color = require("app.utils.Color")

function PopupFriendState:ctor(userInviteInfo) 
    self._rankBase = nil            --通用排行底板
    self._listRank = nil            --排行榜list
    self._nodeEmpty = nil           --空数据UI


    self._userInviteInfo = userInviteInfo

	local resource = {
		file = Path.getCSB("PopupFriendState", "activity/friendInvite"), 
		binding = {
		}
	}
	PopupFriendState.super.ctor(self, resource)
end

function PopupFriendState:onCreate()
 
    self._rankBase:addCloseEventListener(handler(self, self._onCloseClick))
    self._rankBase:setTitle(Lang.get("activity_invite_box_title0"))   
    self._rankBase:setTitleFontSize(22)

    -- 初始化listview
    local nCount = 1
    for _, val in pairs(self._userInviteInfo) do   
        local PopupFriendStateNode = PopupFriendStateNode.new(val, nCount)
        self._listRank:pushBackCustomItem(PopupFriendStateNode)
        nCount = nCount + 1
    end
    self._nodeEmpty:setVisible(#self._userInviteInfo <= 0 )
    
    -- 初始化 title
    self._titleNick:setString(Lang.get("activity_invite_box_title1"))
    self._titleServer:setString(Lang.get("activity_invite_box_title2"))
    self._titleLevel:setString(Lang.get("activity_invite_box_title3"))
    self._titlePowwer:setString(Lang.get("activity_invite_box_title4"))
end

function PopupFriendState:onEnter()
 
end

function PopupFriendState:onExit()
end

function PopupFriendState:_onCloseClick()
    self:closeWithAction()
end

 
 

return PopupFriendState