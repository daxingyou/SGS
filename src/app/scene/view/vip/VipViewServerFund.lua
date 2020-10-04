
local RedPointHelper = require("app.data.RedPointHelper")
local ActivityOpenServerFundConst = require("app.const.ActivityOpenServerFundConst")
local OpenServerFundView = require("app.scene.view.activity.openserverfund.OpenServerFundView")
local VipViewServerFund = class("VipViewServerFund",OpenServerFundView)



function VipViewServerFund:ctor(mainView,activityId,showFundGroup)
    VipViewServerFund.super.ctor(self, mainView,activityId,showFundGroup,true)
end



function VipViewServerFund:_onClickAllServerButton(sender)
    G_SceneManager:showDialog("app.scene.view.vip.PopupVipViewAllServerFund")
end

function VipViewServerFund:_initListView(listView)
    local VipViewServerFundListCell = require("app.scene.view.vip.VipViewServerFundListCell")
	listView:setTemplate(VipViewServerFundListCell)
	listView:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	listView:setCustomCallback(handler(self, self._onItemTouch))
end


function VipViewServerFund:_initTabGroup()
	local param = {
		rootNode = nil,
		isVertical = 2,
		callback = handler(self, self._onTabSelect),
		textList = Lang.get("lang_activity_fund_tab_names"),
	}
	self._tabGroup:setCustomColor({
		{cc.c3b(0xcc, 0xde, 0xff)},
		{cc.c3b(0x3f, 0x47, 0xcf)}
	})
	self._tabGroup:recreateTabs(param)
end


function VipViewServerFund:onCreate()
	cc.bind(self._commonBuy,"CommonButtonHighLight")
	self._commonBuy:addClickEventListenerEx(handler(self,self._onBuyFund))

	cc.bind(self._tabGroup,"CommonTabGroupHorizon")

	self._imageBuy:updateLabel("Text", {text = Lang.getImgText("img_yigoumai02") })
	
	self:_initFundPeopleView()

	-- i18n ja change CSB
	self:_initTabGroup()
	self:_initListView(self._listItemSource)
end

function VipViewServerFund:_refreshBuyFundView()
	local hasBuy = G_UserData:getActivityOpenServerFund():isHasBuyCurrFund(self._paramShowFundGroup)
	local group = self._paramShowFundGroup or G_UserData:getActivityOpenServerFund():getCurrGroup()
	local groupInfo = G_UserData:getActivityOpenServerFund():getGroupInfo(group)

	local rmb = groupInfo.payCfg.rmb
	local totalGold = tonumber(groupInfo.config.txt)
	local isVipEnough = G_UserData:getActivityOpenServerFund():isVipEnoughForGrowFund()

	self._imageBuy:setVisible(hasBuy)
	self._commonBuy:setVisible(not hasBuy)

	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
        local _,currencyStr = UIHelper.convertCurrency(rmb)
		currencyStr = UIHelper.convertDollar(currencyStr)
		self._commonBuy:setString(isVipEnough and Lang.get("lang_activity_fund_buy_fund",{value = currencyStr}) or
			Lang.get("lang_activity_fund_recharge")
		)
	else
		self._commonBuy:setString(isVipEnough and Lang.get("lang_activity_fund_buy_fund",{value = rmb}) or
			Lang.get("lang_activity_fund_recharge")
		)
	end	


    self._textCurrStage:setString(Lang.get("lang_activity_fund_stage",{value = group}))
	self._textGold:setString(totalGold)
	self._textFanli:setString(groupInfo.config.txt2)
end

function VipViewServerFund:_initFundPeopleView()
	
end
function VipViewServerFund:_refreshFundPeopleView()
	local fundNum = G_UserData:getActivityOpenServerFund():getFundNum()
	self._textBuyPeopleNum:setString(fundNum)
end

function VipViewServerFund:_refreshVipView()
end


return VipViewServerFund