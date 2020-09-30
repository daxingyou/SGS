local UserDataHelper = require("app.utils.UserDataHelper")
local ActivityOpenServerFundConst = require("app.const.ActivityOpenServerFundConst")
local ActivityConst = require("app.const.ActivityConst")
local PopupBase = require("app.ui.PopupBase")
local PopupVipViewAllServerFund = class("PopupVipViewAllServerFund", PopupBase)


function PopupVipViewAllServerFund:ctor()
    self._activityId = ActivityConst.ACT_ID_OPEN_SERVER_FUND
	local resource = {
		file = Path.getCSB("PopupVipViewAllServerFund", "vip"),
		binding = {
			_buttonClose = {
				events = {{event = "touch", method = "_onBtnClose"}}
			}
		}
	}
	PopupVipViewAllServerFund.super.ctor(self, resource,true)
end

function PopupVipViewAllServerFund:onCreate()
    local PopupVipViewAllServerFundListCell = require("app.scene.view.activity.openserverfund.PopupVipViewAllServerFundListCell")
    self._listItemSource:setTemplate(PopupVipViewAllServerFundListCell)
	self._listItemSource:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	self._listItemSource:setCustomCallback(handler(self, self._onItemTouch))
end


function PopupVipViewAllServerFund:_pullData()
	local hasActivityServerData = G_UserData:getActivity():hasActivityData(self._activityId)
	if not hasActivityServerData  then
		G_UserData:getActivity():pullActivityData(self._activityId)
    end
    
    if hasActivityServerData and G_UserData:getActivityOpenServerFund():isExpired() then
        hasActivityServerData = false
        G_UserData:getActivity():pullActivityData(self._activityId)
    end

	return hasActivityServerData
end

function PopupVipViewAllServerFund:onEnter()
    self._signalWelfareFundOpenServerGetInfo = G_SignalManager:add(SignalConst.EVENT_WELFARE_FUND_OPEN_SERVER_GET_INFO,
        handler(self, self._onEventWelfareFundOpenServerGetInfo))
    self._signalWelfareFundOpenServerGetReward = G_SignalManager:add(SignalConst.EVENT_WELFARE_FUND_OPEN_SERVER_GET_REWARD,
        handler(self, self._onEventWelfareFundOpenServerGetReward ))
    self._signalServerRecordChange = G_SignalManager:add(SignalConst.EVENT_SERVER_RECORD_CHANGE, handler(self, self._onServerRecordChange))

   
    local hasServerData = self:_pullData()
    if hasServerData then
        self:_refreshListData()
    end

end

function PopupVipViewAllServerFund:onExit()
	self._signalWelfareFundOpenServerGetInfo:remove()
	self._signalWelfareFundOpenServerGetInfo = nil
	self._signalWelfareFundOpenServerGetReward:remove()
	self._signalWelfareFundOpenServerGetReward = nil
	self._signalServerRecordChange:remove()
    self._signalServerRecordChange = nil
end


function PopupVipViewAllServerFund:_onBtnClose()
	self:close()
end

function PopupVipViewAllServerFund:_onItemUpdate(item, index)
	local itemList = self:_getListDatas()
	local itemData = itemList[index+1]
	item:updateUI(itemData)
end

function PopupVipViewAllServerFund:_onItemSelected(item, index)
	logWarn("PopupVipViewAllServerFund:_onItemSelected ")
end

function PopupVipViewAllServerFund:_onItemTouch(index, itemPos)
	logWarn("PopupVipViewAllServerFund:_onItemTouch "..tostring(index).." "..tostring(itemPos))
	local data = self._listDatas[itemPos+1]
	local cfg = data:getConfig()
	local ActivityDataHelper = require("app.utils.data.ActivityDataHelper")
	if ActivityDataHelper.checkPackBeforeGetActReward2(data) then
	 	G_UserData:getActivityOpenServerFund():c2sActFund(cfg.id)
	end
end


function PopupVipViewAllServerFund:_refreshListData()
    local fundType = ActivityOpenServerFundConst.FUND_TYPE_SERVER_REWARD
    self._listDatas = G_UserData:getActivityOpenServerFund():getUnitDataListByFundType(fundType,self._paramShowFundGroup)
	self:_refreshListView(self._listItemSource ,self._listDatas)
end

function PopupVipViewAllServerFund:_refreshListView(listView,itemList)
	local lineCount = #itemList
	listView:clearAll()
	listView:resize(lineCount)
	listView:jumpToTop()
end

function PopupVipViewAllServerFund:_onEventWelfareFundOpenServerGetInfo(event,id,message)
	--刷新列表
	self:_refreshListData()

end

function PopupVipViewAllServerFund:_onEventWelfareFundOpenServerGetReward(event,id,message)
	local fundId = message.id--领取的id

	self:_refreshListData()

	--显示奖励弹窗
	local actOpenServerUnitData = G_UserData:getActivityOpenServerFund():getUnitDataById(fundId)
	if actOpenServerUnitData then
		local cfg = actOpenServerUnitData:getConfig()
		local awards  = {
			{type =  cfg.reward_type,value = cfg.reward_value,size = cfg.reward_size}
		}
		if awards then
			G_Prompt:showAwards(awards)
		end
	end
end

function PopupVipViewAllServerFund:_onServerRecordChange(event)
	--刷新全服奖励列表和购买人数
	self:_refreshListData()
end

return PopupVipViewAllServerFund