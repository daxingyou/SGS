
local ShopConst = require("app.const.ShopConst")
local UserDataHelper = require("app.utils.UserDataHelper")
local UIPopupHelper = require("app.utils.UIPopupHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local VipViewNormalShopItemRow = require("app.scene.view.vip.VipViewNormalShopItemRow")
local ActivitySubView = require("app.scene.view.activity.ActivitySubView")
local VipViewNormalShopView = class("VipViewNormalShopView", ActivitySubView)


function VipViewNormalShopView:ctor(parent)
	self._shopId = ShopConst.VIP_EXCHANGE_SHOP
	self._goodIds = {}
	--csb bind var name
	self._listView = nil  --ListView
	self._isCreate  = nil
	local resource = {
		file = Path.getCSB("VipViewNormalShopView", "vip"),
	}
	VipViewNormalShopView.super.ctor(self, resource)
end

-- Describle：
function VipViewNormalShopView:onCreate()
	self:_initListView()
	self._isCreate = true
end


function VipViewNormalShopView:_pullData()
	G_UserData:getShops():c2sGetShopInfo(ShopConst.VIP_EXCHANGE_SHOP)
end

-- Describle：
function VipViewNormalShopView:onEnter()
	self._signalUpdateShopGoods = G_SignalManager:add(SignalConst.EVENT_SHOP_INFO_NTF, 
		handler(self, self._onEventUpdateShopGoods))-- 刷新状态
	self._signalRecvCurrencysInfo = G_SignalManager:add(SignalConst.EVENT_RECV_CURRENCYS_INFO, 
		handler(self, self._onEventRecvCurrencysInfo))
	self:_updateData()
    self:_pullData()
end

-- Describle：
function VipViewNormalShopView:onExit()
	self._signalUpdateShopGoods:remove()
	self._signalUpdateShopGoods = nil
	self._signalRecvCurrencysInfo:remove()
	self._signalRecvCurrencysInfo = nil
end

-- Describle：
function VipViewNormalShopView:enterModule()
	if not self._isCreate then
		--refresh data or do request
	end
	self._isCreate = false
	print("VipViewNormalShopView enterModule")
	if self._isDirt then
		print("VipViewNormalShopView Dirt")
		self:_updateData()
	end
end


function VipViewNormalShopView:_initListView()
	-- body
	local VipViewNormalShopItemRow = require("app.scene.view.vip.VipViewNormalShopItemRow")
    self._listItemSource:setTemplate(VipViewNormalShopItemRow)
	self._listItemSource:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	self._listItemSource:setCustomCallback(handler(self, self._onItemTouch))
end

function VipViewNormalShopView:_onItemUpdate(item, index)
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

function VipViewNormalShopView:_onItemSelected(item, index)
	logWarn("VipViewNormalShopView:_onItemSelected ")
end

function VipViewNormalShopView:_onItemTouch(index, shopItemData)
	local lineIndex = index
	if shopItemData == nil then
		return
	end
	self:_popupFixShopBuyItem(shopItemData)
end

function VipViewNormalShopView:_getItemDataByPos(pos)
	local itemList = self._itemList
	if pos > 0 and pos <= #itemList then
		return itemList[pos]
	end
	return nil
end


function VipViewNormalShopView:_updateData()
    self._itemList = {}
	self._itemList = G_UserData:getShops():getShopGoodsList(self._shopId, ShopConst.EXCHANGE_SHOP_TAB.NORMAL)
	--[[
	table.insert(self._itemList,self._itemList[1])
	table.insert(self._itemList,self._itemList[1])
	table.insert(self._itemList,self._itemList[1])
	table.insert(self._itemList,self._itemList[1])
	table.insert(self._itemList,self._itemList[1])
	table.insert(self._itemList,self._itemList[1])
	table.insert(self._itemList,self._itemList[1])
	table.insert(self._itemList,self._itemList[1])
	table.insert(self._itemList,self._itemList[1])
	table.insert(self._itemList,self._itemList[1])
	table.insert(self._itemList,self._itemList[1])
	table.insert(self._itemList,self._itemList[1])
	table.insert(self._itemList,self._itemList[1])
	]]
    self:_updateView()
end


function VipViewNormalShopView:_updateView()
	local lineCount = math.ceil(#self._itemList / 3)
	self._listItemSource:clearAll()
    self._listItemSource:resize(lineCount)
end

function VipViewNormalShopView:_onEventUpdateShopGoods(id, message)
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
	print("ssssssssssssssss VipViewNormalShopView")
	self:_updateData()
end

function VipViewNormalShopView:_onEventRecvCurrencysInfo()
	self._isDirt = true
	if not self:isVisible() then
		return
	end
	self:_updateData()
end

--固定商店物品购买
function VipViewNormalShopView:_popupFixShopBuyItem(shopItemData)
	local LogicCheckHelper = require("app.utils.LogicCheckHelper")
	local surplus = shopItemData:getSurplusTimes() -- 剩余购买次数
	logWarn("VipViewNormalShopView surplus"..surplus)
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

		local isModuleShow = G_UserData:getPopModuleShow("VipViewNormalShopView")
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

function VipViewNormalShopView:_getItems(shopItem)
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



return VipViewNormalShopView
