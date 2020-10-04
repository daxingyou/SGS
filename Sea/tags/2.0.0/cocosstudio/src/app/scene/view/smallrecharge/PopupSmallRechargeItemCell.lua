local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")
local UIActionHelper = require("app.utils.UIActionHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local CommonConst = require("app.const.CommonConst")
local TextHelper = require("app.utils.TextHelper")
local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupSmallRechargeItemCell = class("PopupSmallRechargeItemCell", ListViewCellBase)

PopupSmallRechargeItemCell.RES_TYPE_REBATE = 1
PopupSmallRechargeItemCell.RES_TYPE_VIP_PAY = 2
PopupSmallRechargeItemCell.RES_TYPE_ROLE = 3

function PopupSmallRechargeItemCell:ctor()
	self._imageTitle = nil
	self._buttonBuy = nil  --CommonButtonSwitchLevel1
	self._textTime = nil --Text
	self._listItem = nil
	self._textCondition = nil  --SingleNode
	local resource = {
		file = Path.getCSB("PopupSmallRechargeItemCell", "smallrecharge"),
		binding = {
			_buttonBuy = {
				events = {{event = "touch", method = "_onBtnBuy"}}
			},
		},
	}
	PopupSmallRechargeItemCell.super.ctor(self, resource)
end

function PopupSmallRechargeItemCell:onCreate()
	-- body
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
	self._buttonBuy:setString(Lang.get("common_btn_name_confirm"))
	self._listItem:setItemSpacing(2)
	self._listItem:setListViewSize(218,70)

	self._textHint:setString(Lang.getImgText("small_recharge_get"))

	self._imageBg:loadTexture(Path.getSmallRechargeRes("little_recharge_bg"))
	self._imageStar:loadTexture(Path.getSmallRechargeRes("little_recharge_star"))
end

function PopupSmallRechargeItemCell:isTimeOut()

end

function PopupSmallRechargeItemCell:_refreshBtnToPayState()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local _,currencyStr1 = UIHelper.convertCurrency( self._vipPayConfig.rmb)
		currencyStr1 = UIHelper.convertDollar(currencyStr1)
		self._buttonBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = currencyStr1}))
	else
		self._buttonBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = self._vipPayConfig.rmb}))
	end
end

function PopupSmallRechargeItemCell:_refreshTime(limitTime)
	self._textTime:setVisible(true)
	local action = UIActionHelper.createUpdateAction(function()
		local currTime = G_ServerTime:getTime()
		local isTimeOut = currTime > limitTime
		if not isTimeOut then
			self._textTime:setString(
				Lang.getImgText("lang_new_level_pkg_time",{time = G_ServerTime:getLeftSecondsString(limitTime, "00:00:00")})
			)
		else
			self:updateUI(self._data)
		end
	end)
	self._textTime:runAction(action)
end


function PopupSmallRechargeItemCell:_previewState()
	self:_refreshTime(self._data.actUnitData:getStart_time())
	self._buttonBuy:setVisible(true)
	self._buttonBuy:setEnabled(false)
	self:_refreshBtnToPayState()
end

function PopupSmallRechargeItemCell:_rewardState()
	self:_refreshTime(self._data.actUnitData:getAward_time())
	self._buttonBuy:setVisible(true)
	self._buttonBuy:setEnabled(false)
	self:_refreshBtnToPayState()
end

function PopupSmallRechargeItemCell:_alreadyBuyState()
	self._textTime:setVisible(false)
	self._buttonBuy:setVisible(true)
	self._buttonBuy:setEnabled(false)
	self._buttonBuy:setString(Lang.get("lang_activity_level_gift_btn_alreadyBuy"))
end

function PopupSmallRechargeItemCell:_countDownState()
	self:_refreshTime(self._data.actUnitData:getEnd_time())
	self._buttonBuy:setVisible(true)
	self._buttonBuy:setEnabled(true)
	self:_refreshBtnToPayState()
end



function PopupSmallRechargeItemCell:updateUI(data)
	if not data then
		return
	end
	self._data = data



	local actTaskData = G_UserData:getCustomActivity():getActTaskDataById(data.actUnitData:getAct_id(),
		data.actTaskUnitData:getQuest_id())
	local progressTitle = Lang.get("customactivity_text_left")
	local awardTimes = actTaskData and actTaskData:getAward_times() or 0    --已领取次数
	local value01 =  data.actTaskUnitData:getAward_limit() - awardTimes
	local value02 = data.actTaskUnitData:getAward_limit()
	local richText = Lang.get("customactivity_task_progress_02",
		{title = progressTitle,curr = TextHelper.getAmountText2(value01),max = TextHelper.getAmountText2(value02)})
	self:_createProgressRichText(richText)
	

	
	self._textTime:stopAllActions()
	self._listItem:updateUI(data.actTaskUnitData:getRewardItems(), 0.75, true)
	self._listItem:alignCenter()


	
	local LittleChargeRes = require("app.config.little_charge_res")
	local config1 = LittleChargeRes.get(data.actTaskUnitData:getParam3(),PopupSmallRechargeItemCell.RES_TYPE_REBATE)
	self._imageTitle:loadTexture(Path.getSmallRechargeRes(config1.name))
	

	local vipPayId = data.actTaskUnitData:getParam2()
	local VipPay = require("app.config.vip_pay")
	local vipPayConfig = VipPay.get(vipPayId)
	self._vipPayConfig = vipPayConfig

	if data.actUnitData:isActInPreviewTime() then --预览
		self:_previewState()
	elseif data.actUnitData:isActInRunTime()  then--运行
		if awardTimes >= data.actTaskUnitData:getAward_limit()  then--已经购买完成
			self:_alreadyBuyState()
		else
			self:_countDownState()
			
		end
	elseif data.actUnitData:isActInRewardTime()  then--领奖
		self:_rewardState()
	end
end

--创建富文本
function PopupSmallRechargeItemCell:_createProgressRichText(richText)
	self._nodeProgress:removeAllChildren()
    local widget = ccui.RichText:createWithContent(richText)
    widget:setAnchorPoint(cc.p(0.5,0.5))
    self._nodeProgress:addChild(widget)
end

-- Describle：
function PopupSmallRechargeItemCell:_onBtnBuy()
	local actId = self._data.actUnitData:getAct_id()
	local questId = self._data.actTaskUnitData:getQuest_id()

	local actUnitData =  G_UserData:getCustomActivity():getActUnitDataById(actId)
	if not actUnitData  then
		G_Prompt:showTip(Lang.get("customactivity_tips_already_finish"))	
		return 
	end
	if not actUnitData:checkActIsVisible() then
		G_Prompt:showTip(Lang.get("customactivity_tips_already_finish"))	
		return 
	end
	if not actUnitData:isActInRunTime() then
		G_Prompt:showTip(Lang.get("customactivity_avatar_act_not_open"))	
		return 
	end
	local taskUnitData = G_UserData:getCustomActivity():getActTaskUnitDataById(actId,questId)
	local taskUserData = G_UserData:getCustomActivity():getActTaskDataById(actId,questId)
	local awardTimes = taskUserData and taskUserData:getAward_times() or 0 --已领取次数
	if awardTimes >= taskUnitData:getAward_limit() then--已经购买完成
		return
	end
	

	local payCfg = 	self._vipPayConfig
	print("ddd"..payCfg.id)
	G_GameAgent:pay(payCfg.id, 
		payCfg.rmb, 
		payCfg.product_id, 
		payCfg.name, 
		payCfg.name)	
end

return PopupSmallRechargeItemCell
