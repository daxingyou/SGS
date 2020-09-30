local TextHelper = require("app.utils.TextHelper")
local DataConst = require("app.const.DataConst")
local ActivityConst =  require("app.const.ActivityConst")
local VipConst =  require("app.const.VipConst")
local RedPointHelper = require("app.data.RedPointHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local ViewBase = require("app.ui.ViewBase")
local VipViewRechargeView = class("VipViewRechargeView", ViewBase)

local TAB_TYPE = VipConst.TAB_TYPE
local SUB_ID_RATE= 1000

local ACTIVITY_ID_TO_TAB_MAP = {
	[ActivityConst.ACT_ID_MONTHLY_CARD] = {TAB_TYPE.MONTH_CARD},
	[ActivityConst.ACT_ID_OPEN_SERVER_FUND] = {TAB_TYPE.FOUNDATION},
	[ActivityConst.ACT_ID_LUXURY_GIFT_PKG] = {TAB_TYPE.LUXURY_GIFT,Lang.get("vip_new_tab_name_4")},
	[ActivityConst.ACT_ID_LEVEL_GIFT_PKG] = {TAB_TYPE.DISCOUNT_GIFT}
}

function VipViewRechargeView:ctor()
	--self._paramSubTabType = subTabType
    self._nodeVipExp = nil
	self._tabGroup = nil
	
    self._activityModuleUIList = {}
	self._selectTabIndex = 0
	self._tabListData = {}
    local resource = {
		file = Path.getCSB("VipViewRechargeView", "vip"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
          
		}
    }
    VipViewRechargeView.super.ctor(self,resource)
end

function VipViewRechargeView:onCreate()
	cc.bind(self._tabGroup ,"CommonTabGroupScrollHorizon")
end

function VipViewRechargeView:onEnter()
	self._signalRedPointChange = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self, self._onEventRedPointChange))
	self._signalUserLevelUp = G_SignalManager:add(SignalConst.EVENT_USER_LEVELUP, handler(self, self._onEventUserLevelUp ))
	self._signalVipGotoTab = G_SignalManager:add(SignalConst.EVENT_VIP_GO_TO_TAB, handler(self, self._onEventVipGotoTab))

    self:_refreshTabGroup()
    self:_refreshRedPoint()
end

function VipViewRechargeView:onExit()
	self._signalRedPointChange:remove()
	self._signalRedPointChange = nil

	self._signalUserLevelUp:remove()
	self._signalUserLevelUp = nil

	self._signalVipGotoTab:remove()
	self._signalVipGotoTab = nil
end



function VipViewRechargeView:_onEventRedPointChange(id, funcId)
	self:_refreshRedPoint()
end

function VipViewRechargeView:_onEventUserLevelUp(id, message)
	self:_refreshTabGroup()
end
--[[
function VipViewRechargeView:gotoView(subTabType,threeTabType)
	local paramIndex = self:_getTabIndexByTabId(subTabType)
	if paramIndex then
		self._tabGroup:setTabIndex(paramIndex)
	
	end
	if  subTabType == VipConst.TAB_TYPE.DISCOUNT_GIFT and self._activityModuleUIList[subTabType] then
		self._activityModuleUIList[subTabType]:gotoView(threeTabType)
	end
end
]]
function VipViewRechargeView:_onEventVipGotoTab(event,index,subTabType,threeTabType)
	local index = self:_getTabIndexByTabId(subTabType)
	if index then
		self._tabGroup:setTabIndex(index)
	end
	if subTabType == VipConst.TAB_TYPE.DISCOUNT_GIFT and self._activityModuleUIList[subTabType] then
		self._activityModuleUIList[subTabType]:gotoView(threeTabType)
	end
end

function VipViewRechargeView:_refreshTabGroup()
	if self._selectTabIndex == 0 then
		self._tabListData = self:_makeTabListData()
		--local paramIndex = self:_getTabIndexByTabId(self._paramSubTabType)
		self:_recreateTabs()
		--self._tabGroup:setTabIndex(paramIndex or 1)--找到一个能设置的Index，这里是1
		self._tabGroup:setTabIndex(1)--找到一个能设置的Index，这里是1
	else
		--找到以前selectTabIndex对应的id,在通过ID找到新Index
		local tabId = self._tabListData[self._selectTabIndex].tabId
		self._tabListData = self:_makeTabListData()
		self:_recreateTabs()
		local index = self:_getTabIndexByTabId(tabId)
		if index then
			local success  = self._tabGroup:setTabIndex(index)
			if not success then
				self._selectTabIndex = 0
				self._tabGroup:setTabIndex(1)--找到一个能设置的Index，这里是1
			end
		else
			self._selectTabIndex = 0
			self._tabGroup:setTabIndex(1)--找到一个能设置的Index，这里是1
		end
	end
end

function VipViewRechargeView:_recreateTabs()
	local param = {
		containerStyle = 2,
		offset = 0,
		isVertical = 2,
		callback = handler(self, self._onTabSelect),
		textList =  self:_makeTabTextListFromTabData()
	}
	self._tabGroup:setCustomColor({
		{cc.c3b(0xda, 0xe4, 0xff)},
		{cc.c3b(0x8c, 0x52, 0x2a)}
	})
	self._tabGroup:recreateTabs(param)
end



function VipViewRechargeView:_makeTabTextListFromTabData()
	local textList = {}
    for k,v in ipairs(self._tabListData ) do
		table.insert(textList, v.tabName)
	end
	return textList
end


function VipViewRechargeView:_makeTabListData()
	local tabList = {}
	local hasLevelGift = false 
	local LogicCheckHelper = require("app.utils.LogicCheckHelper")
	if LogicCheckHelper.funcIsOpened(FunctionConst.FUNC_VIP_GIFT) then
		table.insert(tabList,{tabId = TAB_TYPE.VIP_GIFT,tabName = Lang.get("vip_new_tab_name_1") })-- 亲密度礼包
	end
	if LogicCheckHelper.funcIsOpened(FunctionConst.FUNC_RECHARGE) then
		table.insert(tabList,{tabId = TAB_TYPE.JADE_BUY,tabName = Lang.get("vip_new_tab_name_2") })--玉石购买
	end
	local activityDataList = G_UserData:getActivity():getActivityListByShowPosition(ActivityConst.SHOW_POSITION_VIP)
	for k,v in ipairs(activityDataList) do
		if v.id > ActivityConst.ACT_ID_OPEN_SERVER_FUND then
			table.insert(tabList, {tabId = TAB_TYPE.FOUNDATION_APPSTORE  + SUB_ID_RATE * v.id ,data = v,
				tabName = v.name})
		elseif v.id == ActivityConst.ACT_ID_LEVEL_GIFT_PKG then
			hasLevelGift = true
			table.insert(tabList, {tabId = TAB_TYPE.DISCOUNT_GIFT,tabName = Lang.get("vip_new_tab_name_3")})
		elseif ACTIVITY_ID_TO_TAB_MAP[v.id] then
			local tabId = ACTIVITY_ID_TO_TAB_MAP[v.id][1]
			local tabName = ACTIVITY_ID_TO_TAB_MAP[v.id][2]
			if not tabName then tabName = v.name end
			table.insert(tabList, {tabId = tabId,data = v,tabName = tabName})
		end
	end

	if not hasLevelGift then
		local ShopConst = require("app.const.ShopConst")
		local Shop = require("app.config.shop")
		local exchangeShopConfig = Shop.get(ShopConst.VIP_EXCHANGE_SHOP )
		if LogicCheckHelper.funcIsOpened(exchangeShopConfig.function_id) then
			table.insert(tabList, {tabId = TAB_TYPE.DISCOUNT_GIFT,tabName = Lang.get("vip_new_tab_name_3")})
		end
	end

	table.sort(tabList, function(left, right)
		local leftTabId = left.tabId
		local rightTabId = right.tabId
		if leftTabId > TAB_TYPE.MAX then
			leftTabId = leftTabId % TAB_TYPE.MAX
		end
		if rightTabId > TAB_TYPE.MAX then
			rightTabId = rightTabId  % TAB_TYPE.MAX
		end
		if leftTabId == rightTabId then
			return left.tabId < right.tabId
		end
		return leftTabId < rightTabId
	end)
	return tabList
end

function VipViewRechargeView:_onTabSelect(index, sender)
	if self._selectTabIndex == index then
		return
	end
	self._selectTabIndex = index
	local tabData = self._tabListData[index]
	local tabId = self:_getTabId(tabData)
	--右边内容视图切换
	for id,view in pairs(self._activityModuleUIList) do
		if id ~= tabId and view:isVisible() then
			view:setVisible(false)
			if view.exitModule then
				view:exitModule()
			end
		end
	end
	local activityModuleUI,newCreate = self:_getActivityModuleUI(tabData)
	if not activityModuleUI:isVisible() or newCreate then
		activityModuleUI:setVisible(true)
		if activityModuleUI.enterModule then activityModuleUI:enterModule() end
	end
	if not newCreate then
	end

	self:_sendClickRedPointEvent()
end

function VipViewRechargeView:_getTabIndexByTabId(id)
	for k,v in ipairs(self._tabListData) do
		local tabId = self:_getTabId(v)
		if tabId == id then
			return k
		end
	end
	return nil
end

function VipViewRechargeView:_getTabId(tabData)
	return tabData.tabId
end

function VipViewRechargeView:_getActivityModuleUI(tabData)
	local tabId = self:_getTabId(tabData)
	local activityModuleUI = self._activityModuleUIList[tabId]
	if activityModuleUI == nil then
		if tabId == TAB_TYPE.JADE_BUY then --yubi
			local VipRechargeView = require("app.scene.view.vip.VipRechargeView")
			activityModuleUI = VipRechargeView.new(self, DataConst.RES_JADE2)
		elseif tabId == TAB_TYPE.VIP_GIFT then --qin mi du 
			local VipViewGiftPkg = require("app.scene.view.vip.VipViewGiftPkg")
			activityModuleUI = VipViewGiftPkg.new(self)
		elseif tabId == TAB_TYPE.LUXURY_GIFT then
            local LuxuryGiftPkgView = require("app.scene.view.activity.luxurygiftpkg.LuxuryGiftPkgView")
			activityModuleUI = LuxuryGiftPkgView.new(self,ActivityConst.ACT_ID_LUXURY_GIFT_PKG,true)
		elseif tabId == TAB_TYPE.FOUNDATION then
			local OpenServerFundView = require("app.scene.view.vip.VipViewServerFund")
			activityModuleUI = OpenServerFundView.new(self,ActivityConst.ACT_ID_OPEN_SERVER_FUND)
		elseif	tabId == TAB_TYPE.DISCOUNT_GIFT then
			local VipViewDiscountGiftPkg = require("app.scene.view.vip.VipViewDiscountGiftPkg")
			activityModuleUI = VipViewDiscountGiftPkg.new(self)
        elseif tabId == TAB_TYPE.MONTH_CARD  then
            local MonthlyCardView = require("app.scene.view.activity.monthlycard.MonthlyCardView")
			activityModuleUI = MonthlyCardView.new(self,ActivityConst.ACT_ID_MONTHLY_CARD,true)
		elseif tabId > TAB_TYPE.MAX  then
			local realTabId = tabId % TAB_TYPE.MAX
			local realId = (tabId - realTabId) / SUB_ID_RATE
			if realTabId == TAB_TYPE.FOUNDATION_APPSTORE then
				local OpenServerFundView = require("app.scene.view.vip.VipViewServerFund")
				activityModuleUI = OpenServerFundView.new(self, tabData.data.id,
					UserDataHelper.getFundGroupByFundActivityId(tabData.data.id))
			end
		end
		
		self._nodeTabContent:addChild(activityModuleUI)
		self._activityModuleUIList[tabId] = activityModuleUI

		return activityModuleUI,true
	end
	return activityModuleUI,false
end

function VipViewRechargeView:_sendClickRedPointEvent()
    local tabData = self._tabListData[self._selectTabIndex]
	local tabId = self:_getTabId(tabData)
	if tabId == TAB_TYPE.JADE_BUY then --yubi
	elseif tabId == TAB_TYPE.VIP_GIFT then --qin mi du 
	elseif tabId == TAB_TYPE.LUXURY_GIFT then
		G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_CLICK,
			FunctionConst.FUNC_WELFARE,{actId = tabData.data.id})
	elseif tabId == TAB_TYPE.FOUNDATION then
		G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_CLICK,
			FunctionConst.FUNC_WELFARE,{actId = tabData.data.id,"vipHint"})
	elseif	tabId == TAB_TYPE.DISCOUNT_GIFT then		
	elseif tabId == TAB_TYPE.MONTH_CARD  then
		G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_CLICK,
			FunctionConst.FUNC_WELFARE,{actId = tabData.data.id,"buyMonthCardHint"})
	elseif tabId > TAB_TYPE.MAX  then
		local realTabId = tabId % TAB_TYPE.MAX
		local realId = (tabId - realTabId) / SUB_ID_RATE
		if realTabId == TAB_TYPE.FOUNDATION_APPSTORE then
			G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_CLICK,
				FunctionConst.FUNC_WELFARE,{actId = ActivityConst.ACT_ID_OPEN_SERVER_FUND,"vipHint"})
		end
	end
		
end

function VipViewRechargeView:_refreshRedPoint()
	for tabIndex,tabData in ipairs(self._tabListData) do
		local tabId = self:_getTabId(tabData)
		local redPointShow = false
		if tabId == TAB_TYPE.JADE_BUY then --yubi
		elseif tabId == TAB_TYPE.VIP_GIFT then --qin mi du 
			redPointShow = RedPointHelper.isModuleReach(FunctionConst.FUNC_VIP_GIFT)
		elseif tabId == TAB_TYPE.DISCOUNT_GIFT then
			redPointShow = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_SHOP_SCENE,"exchangeShopMain")
		elseif tabId == TAB_TYPE.LUXURY_GIFT then
			redPointShow = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_WELFARE,"subActivity",tabData.data.id)
		elseif tabId == TAB_TYPE.FOUNDATION then
			redPointShow = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_WELFARE,"subActivity",tabData.data.id)	
		elseif tabId == TAB_TYPE.MONTH_CARD  then
			redPointShow = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_WELFARE,"subActivity",tabData.data.id)
		elseif tabId>TAB_TYPE.MAX  then
			local realTabId = tabId % TAB_TYPE.MAX
			local realId = (tabId - realTabId) / SUB_ID_RATE
			if realTabId == TAB_TYPE.FOUNDATION_APPSTORE then
				redPointShow = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_WELFARE,"subActivity",tabData.data.id)
			end
		end
		self._tabGroup:setRedPointByTabIndex(tabIndex,redPointShow)
	end
	
	
end


return VipViewRechargeView