
local ShopConst = require("app.const.ShopConst")
local UserDataHelper = require("app.utils.UserDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UIPopupHelper = require("app.utils.UIPopupHelper")
local VipViewLimitShopItemRow = require("app.scene.view.vip.VipViewLimitShopItemRow")
local ActivitySubView = require("app.scene.view.activity.ActivitySubView")
local VipViewLimitShopView = class("VipViewLimitShopView", ActivitySubView)


function VipViewLimitShopView:ctor(parent,tabId)
	self._shopId = ShopConst.VIP_EXCHANGE_SHOP
	self._tabId = tabId
	self._goodIds = {}
	--csb bind var name
	self._listView = nil  --ListView
	self._isCreate = nil
	self._isDirt = nil
	local resource = {
		file = Path.getCSB("VipViewLimitShopView", "vip"),
	}
	VipViewLimitShopView.super.ctor(self, resource)
end

-- Describle：
function VipViewLimitShopView:onCreate()
	self:_initListView()
	self._isCreate = true
end


function VipViewLimitShopView:_pullData()
	G_UserData:getShops():c2sGetShopInfo(ShopConst.VIP_EXCHANGE_SHOP)
end

-- Describle：
function VipViewLimitShopView:onEnter()
	self._signalUpdateShopGoods = G_SignalManager:add(SignalConst.EVENT_SHOP_INFO_NTF, 
		handler(self, self._onEventUpdateShopGoods))-- 刷新状态

	self._signalRecvCurrencysInfo = G_SignalManager:add(SignalConst.EVENT_RECV_CURRENCYS_INFO, 
		handler(self, self._onEventRecvCurrencysInfo))

	self:_updateData()
    self:_pullData()
end

-- Describle：
function VipViewLimitShopView:onExit()
	self._signalUpdateShopGoods:remove()
	self._signalUpdateShopGoods = nil
	self._signalRecvCurrencysInfo:remove()
	self._signalRecvCurrencysInfo = nil
end

-- Describle：
function VipViewLimitShopView:enterModule()
	if not self._isCreate then
		--refresh data or do request
	end
	self._isCreate = false
	print("VipViewLimitShopView enterModule")
	if self._isDirt then
		print("VipViewLimitShopView dirt")
		self:_updateData()
	end
end


function VipViewLimitShopView:_initListView()
	-- body
	local VipViewLimitShopItemRow = require("app.scene.view.vip.VipViewLimitShopItemRow")
    self._listItemSource:setTemplate(VipViewLimitShopItemRow)
	self._listItemSource:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	self._listItemSource:setCustomCallback(handler(self, self._onItemTouch))
end

function VipViewLimitShopView:_onItemUpdate(item, index)
	local startIndex = index * 3
	if self._itemList and #self._itemList > 0 then
		local itemLine = {}
		for i = 1,3,1 do
			local itemData1 = self._itemList[startIndex + i]
			if itemData1 then
				table.insert(itemLine, itemData1)
			end
		end	
		item:update(itemLine)
	end
end

function VipViewLimitShopView:_onItemSelected(item, index)
	logWarn("VipViewLimitShopView:_onItemSelected ")
end

function VipViewLimitShopView:_onItemTouch(index, shopItemData)
	local lineIndex = index
	if shopItemData == nil then
		return
	end
	self:_popupFixShopBuyItem(shopItemData)
end

function VipViewLimitShopView:_getItemDataByPos(pos)
	local itemList = self._itemList
	if pos > 0 and pos <= #itemList then
		return itemList[pos]
	end
	return nil
end


function VipViewLimitShopView:_updateData()
	self._isDirt = false
    self._itemList = {}
	self._itemList = G_UserData:getShops():getShopGoodsList(self._shopId,self._tabId)
    self:_updateView()
end


function VipViewLimitShopView:_updateView()
	local lineCount = math.ceil(#self._itemList / 3)
	self._listItemSource:clearAll()
    self._listItemSource:resize(lineCount)
end

function VipViewLimitShopView:_onEventUpdateShopGoods(id, message)
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
	print("ssssssssssssssss VipViewLimitShopView")
	self:_updateData()
end

function VipViewLimitShopView:_onEventRecvCurrencysInfo()
	self._isDirt = true
	if not self:isVisible() then
		return
	end
	self:_updateData()
end

--固定商店物品购买
function VipViewLimitShopView:_popupFixShopBuyItem(shopItemData)
	local LogicCheckHelper = require("app.utils.LogicCheckHelper")
	local surplus = shopItemData:getSurplusTimes() -- 剩余购买次数
	logWarn("VipViewExchange surplus"..surplus)
	local itemCfg = shopItemData:getConfig()

	local success, errorMsgs, funcNames = LogicCheckHelper.shopFixBtnCheckExt(shopItemData)
	if not success then
		return
	end

	local function callBackFunction(buyCount)
		--是否能购买检测
		if LogicCheckHelper.shopFixBuyCheck(shopItemData, buyCount, true, nil, nil) == false then
			return
		end

		local isModuleShow = G_UserData:getPopModuleShow("VipViewLimitShopView")
		if isModuleShow and isModuleShow == true then
			G_UserData:getShops():c2sBuyShopGoods(shopItemData:getGoodId(),shopItemData:getShopId(),buyCount)
			return
		end

		local cosumeItem = self:_getItems(shopItemData)
		local itemParams = TypeConvertHelper.convert(cosumeItem.type, 
			cosumeItem.value)

		local buyTimesAlert = Lang.get("vip_exchange_gold_alert2", {yubiCount = cosumeItem.size })
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

function VipViewLimitShopView:_getItems(shopItem)
	local fixData = shopItem:getConfig()
	local buyCount = shopItem:getBuyCount()
	local i = 1
	local type = fixData["price" .. i .. "_type"]
	local value = fixData["price" .. i .. "_value"]
	local size = fixData["price" .. i .. "_size"]
	local priceAdd = fixData["price" .. i .. "_add"]
	local priceSize = UserDataHelper.getTotalPriceByAdd(priceAdd, buyCount, 1, size)
	local cosumeItem = {type = type,value = value,size = priceSize }
	return cosumeItem
end


return VipViewLimitShopView
