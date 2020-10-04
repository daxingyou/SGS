
local ShopConst = require("app.const.ShopConst")
local UIPopupHelper = require("app.utils.UIPopupHelper")
local VipViewExchangeItemRow = require("app.scene.view.vip.VipViewExchangeItemRow")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")
local UserDataHelper = require("app.utils.UserDataHelper")
local ActivitySubView = require("app.scene.view.activity.ActivitySubView")
local VipViewExchange = class("VipViewExchange", ActivitySubView)


function VipViewExchange:ctor(parent)
	self._shopId = ShopConst.VIP_EXCHANGE_SHOP
	self._goodIds = {}
	--csb bind var name
	self._listView = nil  --ListView
	self._isCreate = nil
	self._isDirt = nil
	local resource = {
		file = Path.getCSB("VipViewExchange", "vip"),
	}
	VipViewExchange.super.ctor(self, resource)
end

-- Describle：
function VipViewExchange:onCreate()
	self:_initListView()
	self._isCreate = true
end

function VipViewExchange:_pullData()
	G_UserData:getShops():c2sGetShopInfo(ShopConst.VIP_EXCHANGE_SHOP)
end

-- Describle：
function VipViewExchange:onEnter()
	print("VipViewExchange onEnter")
	self._signalUpdateShopGoods = G_SignalManager:add(SignalConst.EVENT_SHOP_INFO_NTF, 
		handler(self, self._onEventUpdateShopGoods))-- 刷新状态
	self._signalRecvCurrencysInfo = G_SignalManager:add(SignalConst.EVENT_RECV_CURRENCYS_INFO, 
		handler(self, self._onEventRecvCurrencysInfo))
	self:_updateData()
    self:_pullData()
end

function VipViewExchange:onEnterTransitionFinish()
	print("VipViewExchange onEnterTransitionFinish")
end

-- Describle：
function VipViewExchange:onExit()
	self._signalUpdateShopGoods:remove()
	self._signalUpdateShopGoods = nil
	self._signalRecvCurrencysInfo:remove()
	self._signalRecvCurrencysInfo = nil
end

-- Describle：
function VipViewExchange:enterModule()
	if not self._isCreate then
		--refresh data or do request
	end
	self._isCreate = false
	print("VipViewExchange enterModule")
	if self._isDirt then
		print("VipViewExchange dirt")
		self:_updateData()
	end
end


function VipViewExchange:_initListView()
	-- body
	local VipViewExchangeItemRow = require("app.scene.view.vip.VipViewExchangeItemRow")
    self._listItemSource:setTemplate(VipViewExchangeItemRow)
	self._listItemSource:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	self._listItemSource:setCustomCallback(handler(self, self._onItemTouch))
end

function VipViewExchange:_onItemUpdate(item, index)
	local startIndex = index * 4
	if self._itemList and #self._itemList > 0 then
		local itemLine = {}
		for i = 1,4,1 do
			local itemData1 = self._itemList[startIndex + i]
			if itemData1 then
				table.insert(itemLine, itemData1)
			end
		end	
		item:update(itemLine)
	end
end

function VipViewExchange:_onItemSelected(item, index)
	logWarn("VipViewExchange:_onItemSelected ")
end

function VipViewExchange:_onItemTouch(index, shopItemData)
	local lineIndex = index
	if shopItemData == nil then
		return
	end
	self:_popupFixShopBuyItem(shopItemData)
end

function VipViewExchange:_getItemDataByPos(pos)
	local itemList = self._itemList
	if pos > 0 and pos <= #itemList then
		return itemList[pos]
	end
	return nil
end


function VipViewExchange:_updateData()
	self._isDirt = false
    self._itemList = {}
	self._itemList = G_UserData:getShops():getShopGoodsList(self._shopId, 1)
    self:_updateView()
end


function VipViewExchange:_updateView()
	local lineCount = math.ceil(#self._itemList / 4)
	self._listItemSource:clearAll()
    self._listItemSource:resize(lineCount)
end

function VipViewExchange:_onEventUpdateShopGoods(id, message)
	if message.ret ~= MessageErrorConst.RET_OK then
		return
	end
	if rawget(message, "shop_id") ~= ShopConst.VIP_EXCHANGE_SHOP then
		return
	end
	self._isDirt = true
	if not self:isVisible() then
		return
	end
	print("ssssssssssssssss VipViewExchange")
	self:_updateData()
end

function VipViewExchange:_onEventRecvCurrencysInfo()
	self._isDirt = true
	if not self:isVisible() then
		return
	end
	self:_updateData()
end

--固定商店物品购买
function VipViewExchange:_popupFixShopBuyItem(shopItemData)
	local LogicCheckHelper = require("app.utils.LogicCheckHelper")
	local surplus = shopItemData:getSurplusTimes() -- 剩余购买次数
	logWarn("VipViewExchange surplus"..surplus)
	local itemCfg = shopItemData:getConfig()


	local function callBackFunction(buyCount)
		--是否能购买检测
		if LogicCheckHelper.shopFixBuyCheck(shopItemData, buyCount, true, nil, nil) == false then
			return
		end

		local isModuleShow = G_UserData:getPopModuleShow("VipViewExchange")
		if isModuleShow and isModuleShow == true then
			G_UserData:getShops():c2sBuyShopGoods(shopItemData:getGoodId(),shopItemData:getShopId(),buyCount)
			return
		end

		local cosumeItem,reward = self:_getItems(shopItemData)
		local itemParams = TypeConvertHelper.convert(cosumeItem.type, 
			cosumeItem.value)

		local itemParams2 = TypeConvertHelper.convert(reward.type, 
			reward.value)

		local buyTimesAlert = Lang.get("vip_exchange_gold_alert", {yubiCount = cosumeItem.size,itemName = itemParams2.name, itemCount = reward.size })
		local PopupSystemAlert =
			require("app.ui.PopupSystemAlert").new(nil, buyTimesAlert, function() 
				G_UserData:getShops():c2sBuyShopGoods(shopItemData:getGoodId(),shopItemData:getShopId(),buyCount)
			end)
		PopupSystemAlert:openWithAction()
		PopupSystemAlert:setCheckBoxVisible(true)
		PopupSystemAlert:setModuleName("VipViewExchange")

	end
		
	callBackFunction(1)
		


end


function VipViewExchange:_getItems(shopItem)
	local fixData = shopItem:getConfig()
	local buyCount = shopItem:getBuyCount()
	
	local VipPay = require("app.config.vip_pay")
	local vipPayCfg = VipPay.get(fixData.value)
	local isFirstRecharge = buyCount == 0
	local sendValue = vipPayCfg.gold_rebate_2
	if isFirstRecharge == true then
		sendValue = vipPayCfg.gold_rebate_1
	end

	local itemParams = TypeConvertHelper.convert(TypeConvertHelper.TYPE_RESOURCE, 
		DataConst.RES_DIAMOND)

	local getReward = {type = TypeConvertHelper.TYPE_RESOURCE,value = DataConst.RES_DIAMOND,size = vipPayCfg.gold }


	local i = 1
	local type = fixData["price" .. i .. "_type"]
	local value = fixData["price" .. i .. "_value"]
	local size = fixData["price" .. i .. "_size"]
	local priceAdd = fixData["price" .. i .. "_add"]
	
	local priceSize = UserDataHelper.getTotalPriceByAdd(priceAdd, buyCount, 1, size)
	local cosumeItem = {type = type,value = value,size = priceSize }
	return cosumeItem,getReward
end

return VipViewExchange
