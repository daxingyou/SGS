local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupFriendStateNode = class("PopupFriendStateNode", ListViewCellBase)
local Hero = require("app.config.hero")
local Color = require("app.utils.Color")

PopupFriendStateNode.RANK_BG_DARK = 4

function PopupFriendStateNode:ctor(data, count)
    self._cellData = data
    self._cellCount = count

	local resource = {
		file = Path.getCSB("PopupFriendStateNode", "activity/friendInvite"),
		binding = {
            _panelBase = {
				events = {{event = "touch", method = "_onPanelClick"}}
			},
		}
	}
	PopupFriendStateNode.super.ctor(self, resource)
end

function PopupFriendStateNode:onCreate()
    local size = self._panelBase:getContentSize()
    self:setContentSize(size)
    self._panelBase:setSwallowTouches(false)
    -- self._imageRank:setVisible(false)

  
    self:_setNodeBG()
    self:_setTextInfo()
end

function PopupFriendStateNode:_setTextInfo()  
    self._textNick:setString(self._cellData.name)
    self._textServer:setString(self._cellData.sname)
    self._textLevel:setString(self._cellData.level)
    self._textPower:setString(self._cellData.power)
    local color = Colors.getOfficialColor(tonumber(self._cellData.olevel))
    self._textNick:setColor(color) 
end

function PopupFriendStateNode:_setNodeBG( )
 
    if self._cellCount % 2 == 1 then
        local pic = Path.getComplexRankUI("img_com_ranking04")
        self._imageBG:loadTexture(pic)
        -- self._imageBG:setVisible(true)
    elseif self._cellCount % 2 == 0 then
        local pic = Path.getComplexRankUI("img_com_ranking05")
        self._imageBG:loadTexture(pic)
        -- self._imageBG:setVisible(false)
    end
end

function PopupFriendStateNode:_onPanelClick(sender)
    do return end
	local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
	local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
	if offsetX < 20 and offsetY < 20  then
        -- G_Prompt:showTip("我是 userid = "..self._rankData:getUser_id().." "..self._rankData:getName().." 的详细面板")
        local userId = self._rankData:getUser_id()
        if userId ~= G_UserData:getBase():getId() then
            G_UserData:getBase():c2sGetUserBaseInfo(userId)
        end
	end
end


return PopupFriendStateNode