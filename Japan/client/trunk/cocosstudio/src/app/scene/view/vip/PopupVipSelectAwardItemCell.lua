-- Author: conley
local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupVipSelectAwardItemCell = class("PopupVipSelectAwardItemCell", ListViewCellBase)

PopupVipSelectAwardItemCell.REWARD_RMB_SCALE = 10 --奖励缩放

PopupVipSelectAwardItemCell.STATE_HAS_RECEIVED = 1 
PopupVipSelectAwardItemCell.STATE_CAN_RECEIVE = 2 
PopupVipSelectAwardItemCell.STATE_NOT_RECEIVE = 3 

function PopupVipSelectAwardItemCell:ctor()
	self._resourceNode = nil --根节点
	local resource = {
		file = Path.getCSB("PopupVipSelectAwardItemCell", "vip"),
		binding = {
			_button = {
				events = {{event = "touch", method = "_onClickBuyBtn"}}
			}
		}
	}
	PopupVipSelectAwardItemCell.super.ctor(self, resource)
end

function PopupVipSelectAwardItemCell:onCreate()
	local size = self._resourceNode:getContentSize()
    self:setContentSize(size.width, size.height)
    self:setAnchorPoint(cc.p(0.5,0.5))
    self._imageReceive:setVisible(false)
    self._button:setVisible(true)
    self._button:getChildByName("Text"):setString(Lang.get("vip_select_award_click_get"))
    
end

function PopupVipSelectAwardItemCell:_onClickBuyBtn()
	local curSelectedPos = self:getTag()
	logWarn("PopupVipSelectAwardItemCell:_onIconClicked  " .. curSelectedPos)
	self:dispatchCustomCallback(curSelectedPos)
end

function PopupVipSelectAwardItemCell:updateUI(reward)
    self._icon:unInitUI()
    self._icon:initUI(reward.type, reward.value, reward.size)
end


function PopupVipSelectAwardItemCell:setIconState(state)
    if state == PopupVipSelectAwardItemCell.STATE_HAS_RECEIVED then--已经领取
        self._imageReceive:setVisible(true)
        self._button:setVisible(false)
    elseif state == PopupVipSelectAwardItemCell.STATE_CAN_RECEIVE then --可领取
        self._imageReceive:setVisible(false)
        self._button:setVisible(true)
        self._button:setEnabled(true)
    elseif state == PopupVipSelectAwardItemCell.STATE_NOT_RECEIVE then--不可领取
        self._imageReceive:setVisible(false)
        self._button:setVisible(true)
        self._button:setEnabled(true)
    end
   
end


return PopupVipSelectAwardItemCell
