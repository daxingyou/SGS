local RedPointHelper = require("app.data.RedPointHelper")
local ActivityConst = require("app.const.ActivityConst")
local VipConst = require("app.const.VipConst")
local ShopConst = require("app.const.ShopConst")
local UIHelper  = require("yoka.utils.UIHelper")
local ActivitySubView = require("app.scene.view.activity.ActivitySubView")
local VipViewDiscountGiftPkg = class("VipViewDiscountGiftPkg", ActivitySubView)

local TAB_TYPE = VipConst.SUB_TAB_TYPE


function VipViewDiscountGiftPkg:ctor()
	self._imageTabBg = nil
    self._activityModuleUIList = {}
    self._selectTabIndex = 0
    self._tabListData = {}
	local resource = {
		file = Path.getCSB("VipViewDiscountGiftPkg", "vip"),
	}
	VipViewDiscountGiftPkg.super.ctor(self, resource)
end

-- Describle：
function VipViewDiscountGiftPkg:onCreate()
	cc.bind(self._tabGroup,"CommonTabGroupHorizon")
end

-- Describle：
function VipViewDiscountGiftPkg:onEnter()
	self._signalRedPointChange = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, 
		handler(self, self._onEventRedPointChange))
	self._signalUserLevelUp = G_SignalManager:add(SignalConst.EVENT_USER_LEVELUP, handler(self, self._onEventUserLevelUp ))
	self._signalVipGotoTab = G_SignalManager:add(SignalConst.EVENT_VIP_GO_TO_TAB, handler(self, self._onEventVipGotoTab))

    self:_refreshTabGroup()
    self:_refreshRedPoint()
end

-- Describle：
function VipViewDiscountGiftPkg:onExit()
	self._signalRedPointChange:remove()
	self._signalRedPointChange = nil

	self._signalUserLevelUp:remove()
	self._signalUserLevelUp = nil

	self._signalVipGotoTab:remove()
	self._signalVipGotoTab = nil
end


function VipViewDiscountGiftPkg:_onEventVipGotoTab(event,index,subTabType,threeTabType)
	local index = self:_getTabIndexByTabId(threeTabType)
	if index then
		self._tabGroup:setTabIndex(index)
	end
end


function VipViewDiscountGiftPkg:_onEventRedPointChange(event,funcId)
	if funcId == FunctionConst.FUNC_WELFARE or funcId ==  FunctionConst.FUNC_SHOP_SCENE then
		self:_refreshRedPoint()
	end
end

function VipViewDiscountGiftPkg:_onEventUserLevelUp(id, message)
	self:_refreshTagGroup()
end

function VipViewDiscountGiftPkg:gotoView(threeTabType)
	local paramIndex = self:_getTabIndexByTabId(threeTabType)
	if paramIndex then
		self._tabGroup:setTabIndex(paramIndex)
	end
end

function VipViewDiscountGiftPkg:_refreshTabGroup()
	if self._selectTabIndex == 0 then
		self._tabListData = self:_makeTabListData()
		self:_recreateTabs()
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

function VipViewDiscountGiftPkg:_recreateTabs()
	local param = {
		rootNode = nil,
		isVertical = 2,
		callback = handler(self, self._onTabSelect),
		textList = self:_makeTabTextListFromTabData(),
	}
	self._tabGroup:setCustomColor({
		{cc.c3b(0xcc, 0xde, 0xff)},
		{cc.c3b(0x3f, 0x47, 0xcf)}
	})
	self._tabGroup:recreateTabs(param)

	
	local tabNum = #(param.textList)

	if tabNum <= 1 then
		self._imageTabBg:setVisible(false)
		return
	end
	self._imageTabBg:setVisible(true)
	self._nodeLine:removeAllChildren()
	

	local tabWidth = 125 * #(param.textList) + 4
	local size = self._imageTabBg:getContentSize()
	self._imageTabBg:setContentSize(cc.size(tabWidth,size.height))

	for i = 1,tabNum-1,1 do
		local lineImage = UIHelper.createImage({texture = Path.getVip2("img_huadongxian") })
		lineImage:setPosition(125 * i +2,2)
		lineImage:setAnchorPoint(cc.p(0.5,0))
		lineImage:setContentSize(cc.size(5,50))
		self._nodeLine:addChild(lineImage)
	end
end


function VipViewDiscountGiftPkg:_makeTabTextListFromTabData()
	local textList = {}
    for k,v in ipairs(self._tabListData ) do
		table.insert(textList, v.tabName)
	end
	return textList
end


function VipViewDiscountGiftPkg:_makeTabListData()
	local tabList = {}
	local LogicCheckHelper = require("app.utils.LogicCheckHelper")
	if LogicCheckHelper.funcIsOpened(FunctionConst.FUNC_RECHARGE) then
		table.insert(tabList,{tabId = TAB_TYPE.EXCHANGE,tabName = Lang.get("vip_discount_gift_tab_2") })
		
		--受等级控制,天数
		local itemList = G_UserData:getShops():getShopGoodsList(ShopConst.VIP_EXCHANGE_SHOP, ShopConst.EXCHANGE_SHOP_TAB.NORMAL)
		if #itemList > 0 then
			table.insert(tabList,{tabId = TAB_TYPE.NORMAL_SHOP,tabName = Lang.get("vip_discount_gift_tab_3") })
		end


		--受等级控制,天数
		local itemList = G_UserData:getShops():getShopGoodsList(ShopConst.VIP_EXCHANGE_SHOP, ShopConst.EXCHANGE_SHOP_TAB.LIMIT)
		if #itemList > 0 then
			table.insert(tabList,{tabId = TAB_TYPE.LIMIT_SHOP,tabName = Lang.get("vip_discount_gift_tab_4") })
		end

		--受等级控制
		local itemList = G_UserData:getShops():getShopGoodsList(ShopConst.VIP_EXCHANGE_SHOP, ShopConst.EXCHANGE_SHOP_TAB.WEEK_LIMIT)
		if #itemList > 0 then
			table.insert(tabList,{tabId = TAB_TYPE.LIMIT_WEEK_SHOP,tabName = Lang.get("vip_discount_gift_tab_5") })
		end
	end

	--[[
	local activityDataList = G_UserData:getActivity():getActivityListByShowPosition(ActivityConst.SHOW_POSITION_VIP)
	for k,v in ipairs(activityDataList) do
		if v.id == ActivityConst.ACT_ID_LEVEL_GIFT_PKG then
			table.insert(tabList, {tabId = TAB_TYPE.LEVEL_GIFT,tabName = v.name})
		end
	end
	
]]
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


function VipViewDiscountGiftPkg:_getTabIndexByTabId(id)
	for k,v in ipairs(self._tabListData) do
		local tabId = self:_getTabId(v)
		if tabId == id then
			return k
		end
	end
	return nil
end

function VipViewDiscountGiftPkg:_refreshRedPoint()
	for tabIndex,tabData in ipairs(self._tabListData) do
		local tabId = self:_getTabId(tabData)
		local redPointShow = false
		if tabId == TAB_TYPE.LEVEL_GIFT then 
			redPointShow = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_WELFARE,"subActivity",
				ActivityConst.ACT_ID_LEVEL_GIFT_PKG)
		elseif tabId == TAB_TYPE.EXCHANGE then
		
		elseif tabId == TAB_TYPE.LIMIT_SHOP then
			redPointShow = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_SHOP_SCENE,"exchangeShop",
				ShopConst.EXCHANGE_SHOP_TAB.LIMIT)
		elseif tabId == TAB_TYPE.LIMIT_WEEK_SHOP then
			redPointShow = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_SHOP_SCENE,"exchangeShop",
				ShopConst.EXCHANGE_SHOP_TAB.WEEK_LIMIT)
		elseif tabId == TAB_TYPE.NORMAL_SHOP then
			redPointShow = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_SHOP_SCENE,"exchangeShop",
				ShopConst.EXCHANGE_SHOP_TAB.NORMAL)
		end
		self._tabGroup:setRedPointByTabIndex(tabIndex,redPointShow)
	end
end


function VipViewDiscountGiftPkg:_onTabSelect(index, sender)
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

function VipViewDiscountGiftPkg:_getActivityModuleUI(tabData)
	local tabId = self:_getTabId(tabData)
	local activityModuleUI = self._activityModuleUIList[tabId]
	if activityModuleUI == nil then
		if tabId == TAB_TYPE.LEVEL_GIFT then
			local LevelGiftView = import("app.scene.view.activity.levelGift.LevelGiftView")
			activityModuleUI = LevelGiftView.new(self, ActivityConst.ACT_ID_LEVEL_GIFT_PKG)
        elseif tabId == TAB_TYPE.EXCHANGE then
            local VipViewExchange = require("app.scene.view.vip.VipViewExchange")
			activityModuleUI = VipViewExchange.new(self)
		elseif tabId == TAB_TYPE.LIMIT_SHOP then
			local VipViewLimitShopView = require("app.scene.view.vip.VipViewLimitShopView")
			activityModuleUI = VipViewLimitShopView.new(self,ShopConst.EXCHANGE_SHOP_TAB.LIMIT)
		elseif tabId == TAB_TYPE.LIMIT_WEEK_SHOP then
			local VipViewLimitShopView = require("app.scene.view.vip.VipViewLimitShopView")
			activityModuleUI = VipViewLimitShopView.new(self,ShopConst.EXCHANGE_SHOP_TAB.WEEK_LIMIT)
		elseif tabId == TAB_TYPE.NORMAL_SHOP then
			local VipViewNormalShopView = require("app.scene.view.vip.VipViewNormalShopView")
			activityModuleUI = VipViewNormalShopView.new(self)
		end
		self._nodeTabContent:addChild(activityModuleUI)
		self._activityModuleUIList[tabId] = activityModuleUI
		return activityModuleUI,true
	end
	return activityModuleUI,false
end

function VipViewDiscountGiftPkg:_sendClickRedPointEvent()
	local tabData = self._tabListData[self._selectTabIndex]
	local tabId = self:_getTabId(tabData)
	
	if tabId == TAB_TYPE.LEVEL_GIFT then 
		G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_CLICK,
			FunctionConst.FUNC_WELFARE,{actId = ActivityConst.ACT_ID_LEVEL_GIFT_PKG})
	elseif tabId == TAB_TYPE.EXCHANGE then 
	elseif tabId == TAB_TYPE.LIMIT_WEEK_SHOP then
		G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_CLICK,
			FunctionConst.FUNC_SHOP_SCENE,{shopId = ShopConst.VIP_EXCHANGE_SHOP,tabIndex = ShopConst.EXCHANGE_SHOP_TAB.WEEK_LIMIT,"vip"} )
	elseif tabId == TAB_TYPE.LIMIT_SHOP then
		G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_CLICK,
			FunctionConst.FUNC_SHOP_SCENE,{shopId = ShopConst.VIP_EXCHANGE_SHOP,tabIndex = ShopConst.EXCHANGE_SHOP_TAB.LIMIT,"vip"} )
	elseif tabId == TAB_TYPE.NORMAL_SHOP then
		logWarn("VipViewDiscountGiftPkg ddd"..tabId)
		G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_CLICK,
			FunctionConst.FUNC_SHOP_SCENE,{shopId = ShopConst.VIP_EXCHANGE_SHOP,tabIndex = ShopConst.EXCHANGE_SHOP_TAB.NORMAL,"vip"} )
	end

	--ShopConst.EXCHANGE_SHOP_TAB.LIMIT
end

function VipViewDiscountGiftPkg:_getTabId(tabData)
	return tabData.tabId
end


return VipViewDiscountGiftPkg
