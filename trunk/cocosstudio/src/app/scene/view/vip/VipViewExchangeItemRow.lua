local UserDataHelper = require("app.utils.UserDataHelper")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")
local ListViewCellBase = require("app.ui.ListViewCellBase")
local VipViewExchangeItemRow = class("VipViewExchangeItemRow",ListViewCellBase)

local DIAMOND_REBATE_IMG = {
	[10] = 1,
	[60] = 2,
	[150] = 3,
	[240] = 4,
	[500] = 5,
	[800] = 6,
	[1300] = 7,
	[1800] = 8,
}


function VipViewExchangeItemRow:ctor()
    local resource = {
        file = Path.getCSB("VipViewExchangeItemRow", "vip")
    }
    VipViewExchangeItemRow.super.ctor(self, resource)
end


function VipViewExchangeItemRow:onCreate()
	local contentSize = self._panelRoot:getContentSize()
	self:setContentSize(contentSize)
end

function VipViewExchangeItemRow:update(itemLine)
	self._itemLine = itemLine

	for i=1, 4 do 
		local fileNode = self["_fileNode"..i]
		if fileNode then
			fileNode:setVisible(false)
		end
	end
	for i, itemValue in ipairs(itemLine) do
		local fileNode = self["_fileNode"..i]
		if fileNode then
			fileNode:setVisible(true)
			local resourceNode = fileNode:getSubNodeByName("_resource")
			resourceNode:setTag(i)
    		resourceNode:addTouchEventListener(handler(self,self._onTouchCallBack))
			self:_updateCell(fileNode, itemValue )
		end
	end
end

function VipViewExchangeItemRow:_updateCell(itemNode,shopItem)
	local fixData = shopItem:getConfig()
	local buyCount = shopItem:getBuyCount()
	
	--fixData.type, fixData.value, fixData.size 元宝

	if fixData.type == 800 then
		local VipPay = require("app.config.vip_pay")
		local vipPayCfg = VipPay.get(fixData.value)
		local isFirstRecharge = buyCount == 0
		local sendValue = vipPayCfg.gold_rebate_2
		if isFirstRecharge == true then
			sendValue = vipPayCfg.gold_rebate_1
		end
		local vipIconPath = Path.getCommonIcon("vip",vipPayCfg.icon_id) 
		dump(vipIconPath)
		itemNode:updateImageView( "Image_gold_icon", {texture = vipIconPath})
	

		local itemParams = TypeConvertHelper.convert(TypeConvertHelper.TYPE_RESOURCE, 
			DataConst.RES_DIAMOND)

		itemNode:updateLabel( "Text_gold_num", { text =  vipPayCfg.gold..itemParams.name})

		if isFirstRecharge then
			-- 首冲双倍
			itemNode:updateImageView("Image_tip", { visible = true} )
			itemNode:updateImageView("Image_tip_2", { visible = false} )
		elseif sendValue<=0 then
			itemNode:updateImageView("Image_tip", { visible = false} )
			itemNode:updateImageView("Image_tip_2", { visible = false} )
		else
			logWarn("sendValue" ..sendValue)
			-- 非首冲
			itemNode:updateImageView("Image_tip", { visible = false} )
			if DIAMOND_REBATE_IMG[sendValue] then
				itemNode:updateImageView("Image_tip_2", { visible = true, texture = Path.getVip2("text_vip_duo"..DIAMOND_REBATE_IMG[sendValue])} )
			else
				itemNode:updateImageView("Image_tip_2", { visible = false} )
			end
			
		end
	end
	for i = 1,1 do
		local costRes = itemNode:getSubNodeByName("Cost_Res"..i)
		local type = fixData["price" .. i .. "_type"]
		local value = fixData["price" .. i .. "_value"]
		local size = fixData["price" .. i .. "_size"]
		local priceAdd = fixData["price" .. i .. "_add"]
		cc.bind(costRes,"CommonResourceInfoList")
		local priceSize = UserDataHelper.getTotalPriceByAdd(priceAdd, buyCount, 1, size)

		if type and type > 0 then
			costRes:updateUI(type, value, priceSize)
			costRes:setVisible(true)
		else
			costRes:setVisible(false)
		end
		local canBuy = LogicCheckHelper.enoughValue(type, value, priceSize, false)
		if not canBuy then
			costRes:setTextColorToRed()
		else
			costRes:setTextColorToATypeColor()
		end
		
	end

	local buttonExchange = itemNode:getSubNodeByName("ButtonExchange")
	local checkType = {
		type = TypeConvertHelper.TYPE_RESOURCE,
		value = DataConst.RES_GOLD
	}
	--local redPoint = G_UserData:getShops():isFixShopItemDataCanBuy(shopItem, checkType)
	--buttonExchange:showRedPoint(redPoint)
end


function VipViewExchangeItemRow:_onTouchCallBack(sender,state)
	if state == ccui.TouchEventType.ended then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
		if moveOffsetX < 20 and moveOffsetY < 20 then
			local curSelectedPos = sender:getTag()
			self:dispatchCustomCallback(self._itemLine[curSelectedPos])
		end
	end
end


return VipViewExchangeItemRow