-- Author: conley
local ListViewCellBase = require("app.ui.ListViewCellBase")
local ActivityOpenServerFundConst = require("app.const.ActivityOpenServerFundConst")
local FriendInviteItemCell = class("FriendInviteItemCell", ListViewCellBase)
local friend_invite = require("app.config.friend_invite")

function FriendInviteItemCell:ctor()
	self._resourceNode = nil --根节点
	self._commonIconTemplate = nil --道具Item
	self._commonButtonMediumNormal = nil--领取按钮
	self._imageReceive = nil--已领取图片
 
 
	local resource = {
		file = Path.getCSB("FriendInviteItemCell", "activity/friendInvite"), 
		binding = {
			_commonButtonMediumNormal = {
				events = {{event = "touch", method = "_onItemClick"}}
			}
		},
	}
	FriendInviteItemCell.super.ctor(self, resource)
end

function FriendInviteItemCell:onCreate()  
    self:_swapImageByI18n()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

    --self._commonButtonMediumNormal:setString(Lang.get("lang_activity_fund_receive"))
    self._commonButtonMediumNormal:setSwallowTouches(false)
end

function FriendInviteItemCell:_onItemClick(sender,state)

    if state == ccui.TouchEventType.ended or not state then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
		if moveOffsetX < 20 and moveOffsetY < 20 then
        	local curSelectedPos = self:getTag()
            logWarn("FriendInviteItemCell:_onIconClicked  "..curSelectedPos)
            self:dispatchCustomCallback(curSelectedPos)
		end
	end


end

function FriendInviteItemCell:updateUI(data) 
    local state = data.state
    local cfg = friend_invite.get(data.id)
    -- 隐藏所有Icon
    for i=1, self._resourceNode:getChildrenCount() do
        local name = self._resourceNode:getChildren()[i]:getName()
        if string.find(name, "_commonIcon") ~= nil then   
            self._resourceNode:getChildren()[i]:setVisible(false) 
        end
    end

    -- 获取奖励数据
    local items = {}
    local len = self:_getLen(cfg)
    for n = 1, len do
        if cfg["reward_type"..n] ~= 0 and cfg["reward_size"..n] ~= 0 then 
            table.insert(items, {reward_type=cfg["reward_type"..n], reward_value=cfg["reward_value"..n], reward_size=cfg["reward_size"..n] })
        end
    end

    for i = 1, #items do
        self["_commonIconTemplate" .. i]:setVisible(true)  
        self["_commonIconTemplate" .. i]:unInitUI()
        self["_commonIconTemplate" .. i]:initUI( items[i].reward_type, items[i].reward_value, items[i].reward_size)
        self["_commonIconTemplate" .. i]:setTouchEnabled(true)
        self["_commonIconTemplate" .. i]:showCount(true)  
    end

    self:_refreshButtonName(state)
    self._textTitle:setString(cfg.name)
    -- do  return end
	-- local cfg = actOpenServerFundUnitData:getConfig()
    -- local vipLevel = G_UserData:getActivityOpenServerFund():getGrowFundNeedVipLevel()
	-- self._commonIconTemplate:unInitUI()
	-- self._commonIconTemplate:initUI( cfg.reward_type, cfg.reward_value, cfg.reward_size)
	-- self._commonIconTemplate:setTouchEnabled(true)
    -- -- self._commonIconTemplate:showCount(true)  self._commonIconTemplate:setCount()
 
    -- local itemParams = self._commonIconTemplate:getItemParams()
	-- --self._textItemName:setString(tostring(cfg.reward_size)..itemParams.name)
end

function FriendInviteItemCell:_refreshButtonName(state)
    local ActivityConst = require("app.const.ActivityConst")

    if state == ActivityConst.CHECKIN_STATE_WRONG_TIME then      --未完成
        self._imageReceive:setVisible(false)
        self._commonButtonMediumNormal:setVisible(true)
        self._commonButtonMediumNormal:setEnabled(false)
        self._commonButtonMediumNormal:setString(Lang.get("activity_invite_btn_state2"))
    elseif  state == ActivityConst.CHECKIN_STATE_RIGHT_TIME then --可领取
        self._imageReceive:setVisible(false)
        self._commonButtonMediumNormal:setVisible(true)
        self._commonButtonMediumNormal:setEnabled(true)
        self._commonButtonMediumNormal:setString(Lang.get("activity_invite_btn_state1"))
    elseif  state == ActivityConst.CHECKIN_STATE_PASS_TIME then   --已领取
        self._imageReceive:setVisible(true)
        self._commonButtonMediumNormal:setVisible(false)
    end
end

function FriendInviteItemCell:_getLen(cfg)
    local nIndex = 0
    for key, value in pairs(cfg._raw_key_map) do
        nIndex = nIndex + 1
    end

    nIndex = (nIndex-8)/3
    return nIndex
end
 
function FriendInviteItemCell:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")	
        self._imageReceive = UIHelper.swapSignImage(self._imageReceive,
		{ 
			 style = "signet_8", 
			 text = Lang.getImgText("img_seal_yilingqu01") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))

	end
end
return FriendInviteItemCell

 --