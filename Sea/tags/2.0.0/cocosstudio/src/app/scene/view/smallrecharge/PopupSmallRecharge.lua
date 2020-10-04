local PopupBase = require("app.ui.PopupBase")
local PopupSmallRecharge = class("PopupSmallRecharge", PopupBase)

PopupSmallRecharge.RES_TYPE_REBATE = 1
PopupSmallRecharge.RES_TYPE_VIP_PAY = 2
PopupSmallRecharge.RES_TYPE_ROLE = 3

function PopupSmallRecharge:ctor(actId,callback)
	self._actId = actId
	self._callback = callback
	--csb bind var name
	self._listItem = nil  --ListView
	self._nodeContinue = nil
	self._nodeBubble = nil
	self._imageRole = nil
	self._time = 0
	local resource = {
		file = Path.getCSB("PopupSmallRecharge", "smallrecharge"),
	}

	PopupSmallRecharge.super.ctor(self, resource)
end

-- Describle：
function PopupSmallRecharge:onCreate()
	self:_initListView()

	
	local actUnitData =  G_UserData:getCustomActivity():getActUnitDataById(self._actId)
	local LittleChargeRes = require("app.config.little_charge_res")
	local config1 = LittleChargeRes.get(actUnitData:getIcon_value(),PopupSmallRecharge.RES_TYPE_ROLE)
	self._nodeBubble:getSubNodeByName("Text"):setString(actUnitData:getDesc())
	self._nodeBubble:getSubNodeByName("_imagePopo"):loadTexture(Path.getSmallRechargeRes("little_recharge_bubble"))
	self._imageRole:loadTexture(Path.getSmallRechargeRes(config1.name))


	self._imageRole:loadTexture(Path.getSmallRechargeRes(config1.name))
	self._imageGuang:loadTexture(Path.getSmallRechargeRes("little_recharge_light"))
	self._imageShade:loadTexture(Path.getSmallRechargeRes("little_recharge_bg_0"))
end

function PopupSmallRecharge:onShowFinish()
	self._time = G_ServerTime:getMSTime()
end

function PopupSmallRecharge:closeWithAction()
	local time = G_ServerTime:getMSTime()
	if time - self._time >= 500 then
		PopupSmallRecharge.super.closeWithAction(self)
	end 
end

-- Describle：
function PopupSmallRecharge:onEnter()
	self._signalCustomActInfo = G_SignalManager:add(SignalConst.EVENT_CUSTOM_ACTIVITY_INFO, handler(self, self._onEventCustomActInfo))
	self._signalCustomActUpdate = G_SignalManager:add(SignalConst.EVENT_CUSTOM_ACTIVITY_UPDATE, handler(self, self._onEventCustomActUpdate))
	self._signalCustomActUpdateQuest= G_SignalManager:add(SignalConst.EVENT_CUSTOM_ACTIVITY_UPDATE_QUEST, handler(self, self._onEventCustomActUpdateQuest))
	self._signalCustomActExpired = G_SignalManager:add(SignalConst.EVENT_CUSTOM_ACTIVITY_EXPIRED, handler(self,self._onEventCustomActExpired))
	self._signalCustomActGetAward = G_SignalManager:add(SignalConst.EVENT_CUSTOM_ACTIVITY_GET_AWARD, handler(self, self._onEventCustomActGetAward))
	self:_refreshView()
end

-- Describle：
function PopupSmallRecharge:onExit()
	self._signalCustomActInfo:remove()
	self._signalCustomActInfo = nil
	self._signalCustomActUpdate:remove()
	self._signalCustomActUpdate = nil
	self._signalCustomActUpdateQuest:remove()
	self._signalCustomActUpdateQuest = nil
	self._signalCustomActGetAward:remove()
	self._signalCustomActGetAward = nil


	self._signalCustomActExpired:remove()
	self._signalCustomActExpired = nil
end

function PopupSmallRecharge:_initListView()
	local UserDataHelper = require("app.utils.UserDataHelper")
	local ItemCell = require("app.scene.view.smallrecharge.PopupSmallRechargeItemCell")
    self._listViewData = UserDataHelper.getSmallAmountRechargeShowListById(
		self._actId
    )	
    self._listItem:removeAllChildren()
	self._items = {}
	local width = 0
	local height = 0
	--test
	--table.insert(self._listViewData,self._listViewData[1])
	--table.insert(self._listViewData,self._listViewData[1])
	--table.insert(self._listViewData,self._listViewData[1])
	for k, v in pairs(self._listViewData) do
		local item = ItemCell.new()
		self._listItem:pushBackCustomItem(item)
		self._items[k] = item
	end

	if #self._listViewData > 3 then
		self._listItem:setClippingEnabled(true) 
		self._listItem:setContentSize(cc.size(900,368))
		self._listItem:setTouchEnabled(true)
		self._listItem:doLayout()
	else
		self._listItem:setClippingEnabled(false) 
		self._listItem:adaptWithContainerSize()
		self._listItem:setTouchEnabled(false)
	end
end

function PopupSmallRecharge:_refreshView()
	for k, v in pairs(self._listViewData) do
		local item = self._items[k]
		item:updateUI(v)
	end
end

function PopupSmallRecharge:onClose()
	if self._callback then
		self._callback()
	end
end


function PopupSmallRecharge:_onEventCustomActInfo(event,data)
	self:_refreshView()
end

function PopupSmallRecharge:_onEventCustomActUpdate(event,data)
	
end

function PopupSmallRecharge:_onEventCustomActExpired(event,data)

end

function PopupSmallRecharge:_onEventCustomActUpdateQuest(event,data)
	self:_refreshView()
end

function PopupSmallRecharge:_onEventCustomActGetAward(event,message)
	local taskUnitData = G_UserData:getCustomActivity():getActTaskUnitDataById(
				message.act_id,message.quest_id)
	local rewards = {}
	local fixRewards = taskUnitData:getRewardItems()
	local selectRewards = taskUnitData:getSelectRewardItems()
	for k,v in ipairs(fixRewards) do
		table.insert(rewards,v)
	end
	logWarn("award_id"..message.award_id)
	local selectReward = selectRewards[message.award_id]--服务器从1开始
	if selectReward then
		table.insert(rewards,selectReward)
	end
	local newRewards = rewards
	if message.award_num > 1 then
		newRewards = {}
		local rate = message.award_num
		for k,v in ipairs(rewards) do
			table.insert(newRewards,{type = v.type,value = v.value,size = v.size * rate})
		end
	end
	self:_showRewards(newRewards)
end

function PopupSmallRecharge:_showRewards(awards)
	if awards then
        G_Prompt:showAwards(awards)
		-- local PopupGetRewards = require("app.ui.PopupGetRewards").new()
		-- PopupGetRewards:showRewards(awards)
	end
end


return PopupSmallRecharge
