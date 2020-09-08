local UserDataHelper = require("app.utils.UserDataHelper")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")
local ListViewCellBase = require("app.ui.ListViewCellBase")
local UIHelper = require("yoka.utils.UIHelper")
local VipViewNormalShopItemRow = class("VipViewNormalShopItemRow",ListViewCellBase)


function VipViewNormalShopItemRow:ctor()
    local resource = {
        file = Path.getCSB("VipViewNormalShopItemRow", "vip")
    }
    VipViewNormalShopItemRow.super.ctor(self, resource)
end


function VipViewNormalShopItemRow:onCreate()
	local contentSize = self._panelRoot:getContentSize()
	self:setContentSize(contentSize)
end

function VipViewNormalShopItemRow:update(itemLine)
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
            local listViewItem = fileNode:getSubNodeByName("CommonListViewItem")
            cc.bind(listViewItem, "CommonListViewLineItem")
			local buttonExchange = fileNode:getSubNodeByName("ButtonExchange")
			buttonExchange:setTag(i)
    		buttonExchange:addTouchEventListener(handler(self,self._onTouchCallBack))
			self:_updateCell(fileNode, itemValue )
		end
	end
end


function VipViewNormalShopItemRow:_refreshListView(listViewItem,dropList)
	listViewItem:setItemSpacing(2)
	listViewItem:setListViewSize(200,70)
	listViewItem:updateUI(dropList, 0.8)
	listViewItem:setTextItemCountFontSize(26)
	listViewItem:alignCenter()
end

function VipViewNormalShopItemRow:_updateCell(itemNode,shopItem)
	local fixData = shopItem:getConfig()
	local buyCount = shopItem:getBuyCount()

	local newRemind = fixData.new_remind
    local itemParams = TypeConvertHelper.convert(TypeConvertHelper.TYPE_RESOURCE, 
		DataConst.RES_DIAMOND)
		
		
	local imageBgLight = itemNode:getSubNodeByName("Image_bg_light")
	imageBgLight:setVisible(newRemind == 2)
	
    local imageTip = itemNode:getSubNodeByName("Image_tip")
    imageTip:setVisible(newRemind == 1)

	
    local dropList = UserDataHelper.getFixRewardList(fixData)
	local listViewItem = itemNode:getSubNodeByName("CommonListViewItem")
	self:_refreshListView(listViewItem,dropList)


    local textTitle = itemNode:getSubNodeByName("Text_title")
    textTitle:setString(fixData.name)
    local textCondition = itemNode:getSubNodeByName("Text_condition")
    self:_updateLimitDes(textCondition,shopItem)

	local btnImg = nil
	if newRemind == 2 then
		listViewItem:setPositionY(125)
		textCondition:setPositionY(68)
		textCondition:setColor(cc.c3b(0xff, 0xff, 0xff) )
		textCondition:enableOutline( cc.c3b(0xff, 0x6c, 0x5d) , 2)
		btnImg =  Path.getVip2("img_btn_topups_anniu2")
	else
		listViewItem:setPositionY(131)
		textCondition:setPositionY(65)
		textCondition:setColor(cc.c3b(0xB4, 0x64, 0x14) )
		textCondition:disableEffect(cc.LabelEffect.OUTLINE)
		btnImg =  Path.getVip2("img_btn_topups_anniu")
	end
	
	local buttonExchange = itemNode:getSubNodeByName("ButtonExchange")
	buttonExchange:loadTextures(btnImg, btnImg, nil)

	local success, errorMsgs, funcNames = LogicCheckHelper.shopFixBtnCheckExt(shopItem)
	local isGray = false
	if success == false then
		isGray = true
		buttonExchange:setEnabled(false)
	else
		isGray = false
		buttonExchange:setEnabled(true)
	end

	local resourceNode = itemNode:getSubNodeByName("_resource")

	
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
		if isGray then
			costRes:setGray()
		elseif not canBuy then
			costRes:resetFromGray()
			costRes:setTextColorToRed()
		else
			costRes:resetFromGray()
			if newRemind == 2 then
				costRes:setCountColorToWhite()
			else
				costRes:setCountColorToBtnLevel1Bright()
			end
			
		end
		UIHelper.alignCenter(resourceNode,{costRes},nil,{costRes:getWidth()})
	end

	
	local checkType = {
		type = TypeConvertHelper.TYPE_RESOURCE,
		value = DataConst.RES_GOLD
	}

	--local redPoint = G_UserData:getShops():isFixShopItemDataCanBuy(shopItem, checkType)
	--buttonExchange:showRedPoint(redPoint)

	
end


function VipViewNormalShopItemRow:_onTouchCallBack(sender,state)
	if state == ccui.TouchEventType.ended then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
		if moveOffsetX < 20 and moveOffsetY < 20 then
			local curSelectedPos = sender:getTag()
			self:dispatchCustomCallback(self._itemLine[curSelectedPos])
		end
	end
end

function VipViewNormalShopItemRow:_updateLimitDes(textBtnDesc,shopItem)
	local success, errorMsgs, funcNames = LogicCheckHelper.shopFixBtnCheckExt(shopItem)
	local num = #errorMsgs
    if success == false then
        if num == 0 then
            textBtnDesc:setVisible(false)
            return
        elseif num == 1 then
            textBtnDesc:setVisible(true)
            if funcNames["shopNumBanType"] or funcNames["shopGoodsLack"] then
                textBtnDesc:setString(errorMsgs[1])
            else
                textBtnDesc:setString(errorMsgs[1] .. Lang.get("shop_condition_ext"))
			end
		else
			textBtnDesc:setVisible(false)
        end
	else
		textBtnDesc:setVisible(true)
        local strBuyTimes = UserDataHelper.getShopBuyTimesDesc(shopItem:getShopId(), shopItem:getGoodId())
        textBtnDesc:setString(strBuyTimes)
    end
    
end



return VipViewNormalShopItemRow