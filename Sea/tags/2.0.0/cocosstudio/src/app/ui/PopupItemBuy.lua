--弹出界面
--通用物品购买弹窗
local PopupItemUse = require("app.ui.PopupItemUse")
local Path = require("app.utils.Path")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local PopupItemBuy = class("PopupItemBuy", PopupItemUse)
local UserDataHelper = require("app.utils.UserDataHelper")
local ShopConst = require("app.const.ShopConst")

function PopupItemBuy:ctor(title, callback )
	self._title = title or Lang.get("common_title_buy_item") 
	self._callback = callback
	self._costResInfo1 = nil --消耗资源
	self._shopItemData = nil
	self._useNum  = 1 

	PopupItemBuy.super.ctor(self, title, callback)
end

function PopupItemBuy:onInitCsb()
	local CSHelper = require("yoka.utils.CSHelper")
	local resource = {
		file = Path.getCSB("PopupItemBuy", "common"),
		binding = {
			_btnOk = {
				events = {{event = "touch", method = "onBtnOk"}}
			},
			_btnCancel = {
				events = {{event = "touch", method = "onBtnCancel"}}
			},
		}
	}
   if resource then
        CSHelper.createResourceNode(self, resource)
    end
end


--
function PopupItemBuy:onCreate()
	-- button

	PopupItemBuy.super.onCreate(self)

	self:_dealByI18n()
	self._costResInfo2:setVisible(false)
    --self._costResInfo1:showResName(true,Lang.get("lang_common_buy_item_total_price_desc"))
end


function PopupItemBuy:onEnter()
    
end

function PopupItemBuy:onExit()
    
end

function PopupItemBuy:_onNumSelect(num, isClick)
    isClick = isClick or false
    logDebug("_onNumSelect :"..num)
    self._useNum = num
    
	local price1,type1,value1 = self:_getItemPrice(1)
	self:setCostInfo1(type1,value1, price1)

    local price2,type2,value2 = self:_getItemPrice(2)
	if value2 > 0 then
		self:setCostInfo2(type2,value2, price2)
    end
    if isClick and PopupItemBuy.super.checkSlectNum(self, false) then
        return
    end
end

function PopupItemBuy:_getItemPrice(index)
	index = index or 1
	local itemCfg = self._shopItemData:getConfig()
	local buyCount = self._shopItemData:getBuyCount()
	local itemPrice = itemCfg[string.format("price%d_size", index)]
	local itemPriceAdd = itemCfg[string.format("price%d_add", index)]
	local itemPriceValue = itemCfg[string.format("price%d_value", index)]
	local itemPriceType = itemCfg[string.format("price%d_type",index)]
	if itemPriceAdd > 0 then
		itemPrice = UserDataHelper.getTotalPriceByAdd(itemPriceAdd,buyCount,self._useNum )
	else
		itemPrice = itemPrice * self._useNum
	end

	return itemPrice, itemPriceType, itemPriceValue
end

function PopupItemBuy:updateUI( shopId,shopItemId )
	
	local shopMgr = G_UserData:getShops()
	local shopItemData = shopMgr:getShopGoodsById(shopId, shopItemId)

	if shopItemData and type(shopItemData) ~="table" then
		return
	end
	
	self._shopItemData = shopItemData

	local surplus = shopItemData:getSurplusTimes() -- 剩余购买次数
	local itemCfg = shopItemData:getConfig()
	local itemOwnerNum = UserDataHelper.getNumByTypeAndValue(itemCfg.type,itemCfg.value)
	PopupItemBuy.super.updateUI(self,itemCfg.type,itemCfg.value,itemCfg.size)

   if surplus > 0 then
		self:setMaxLimit(surplus)
		--self:setTextTips(Lang.get("shop_buy_limit_day", {num = surplus}))
	else
        --self:setTextTips(" ")
	end

	--[[if shopId == ShopConst.SEASOON_SHOP then
		self:setTextTips(Lang.get("shop_condition_season_buynum", {num = surplus}))
	end]]
	
	self:setOwnerCount(itemOwnerNum)
    self:_onNumSelect(self._useNum)

end

function PopupItemBuy:onBtnOk()
    if not PopupItemBuy.super.checkSlectNum(self, true) then
        return
    end
	local isBreak
	if self._callback then
		isBreak = self._callback(self._itemId, self._useNum)
	end
	if not isBreak then
		self:close()
	end
end


function PopupItemBuy:setCostInfo1(costType,costValue, costSize)
	self._costResInfo1:updateUI(costType,costValue,costSize)
end

function PopupItemBuy:setCostInfo2(costType,costValue, costSize)
	self._costResInfo2:updateUI(costType,costValue,costSize)
	self._costResInfo2:setVisible(true)
end

function PopupItemBuy:setShopConst(shopType)
    PopupItemBuy.super.setShopConst(self, shopType)
end
-- i18n pos lable
function PopupItemBuy:_dealByI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		local resName = UIHelper.seekNodeByTag(self,1595)
		resName:setAnchorPoint(cc.p(1,0.5))
		resName:setPositionX(self._costResInfo1:getPositionX() -3 )	
	end
end
return PopupItemBuy