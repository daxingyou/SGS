local MonthCardNode = class("MonthCardNode")

MonthCardNode.CARD_PNGS = {
	{title = "img_yueka_haohuayueka",type = "img_yueka_zi1",goldBg = "img_yueka_zi"},
	{title = "img_yueka_zhizunyueka",type = "img_yueka_cheng1",goldBg = "img_yueka_cheng"}
}

function MonthCardNode:ctor(node,index,callBack)
    self._node = node
    self._index = index
    self._callBack = callBack
    self._data = nil

	self._imageTitle = ccui.Helper:seekNodeByName(node, "Image_title")
    --self._imageType = ccui.Helper:seekNodeByName(node, "Image_type")
    self._dropListView = ccui.Helper:seekNodeByName(node, "DropAwardsListview")
	self._imageYuanbaoBg = ccui.Helper:seekNodeByName(node, "Image_yuanbao_bg")
	self._atlasLabel01 = ccui.Helper:seekNodeByName(node, "AtlasLabel_1")
	self._atlasLabel02 = ccui.Helper:seekNodeByName(node, "AtlasLabel_2")
	self._atlasLabel03 = ccui.Helper:seekNodeByName(node, "AtlasLabel_3")
	self._imageHintBg = ccui.Helper:seekNodeByName(node, "Image_hint_bg")
    self._imageSend = ccui.Helper:seekNodeByName(node, "Image_send")

    self._imageBack = ccui.Helper:seekNodeByName(node, "Image_bg")
    self._imageContentBack = ccui.Helper:seekNodeByName(node, "Image_82")
    self._imageCell1 = ccui.Helper:seekNodeByName(node, "Image_81")
    self._imageCell2 = ccui.Helper:seekNodeByName(node, "Image_hint_bg")

    
	self._textTitle = ccui.Helper:seekNodeByName(node, "textTitle")
	self._text03 = ccui.Helper:seekNodeByName(node, "Text_03")
	self._imageReceive = ccui.Helper:seekNodeByName(node, "Image_receive")
	self._commonButton1 = ccui.Helper:seekNodeByName(node, "CommonButton1")
	self._textDes = ccui.Helper:seekNodeByName(node, "Text_Des")
	if not Lang.checkLang(Lang.CN) then
		self._labelTotalGold = nil-- i18n change lable
	end

	cc.bind(self._commonButton1, "CommonButtonSwitchLevel1")
	self._commonButton1:addClickEventListenerEx(handler(self,self._onBtnClick))
    self._commonButton1:setButtonTag(index)
    self._commonButton1:switchToHightLight()

	local pngData = MonthCardNode.CARD_PNGS[self._index]
	self._imageTitle:loadTexture(Path.getMonthlyCardRes(pngData.title))
	--self._imageType:loadTexture(Path.getMonthlyCardRes(pngData.type))
	self._imageYuanbaoBg:loadTexture(Path.getMonthlyCardRes(pngData.goldBg))

	if index == 1 then
		self._atlasLabel02:setColor(Colors.COLOR_QUALITY[4])
		self._atlasLabel03:setColor(Colors.COLOR_QUALITY[4])
		self._textDes:setColor(Colors.COLOR_QUALITY[4])
        self._textDes:setString(Lang.get("lang_activity_monthly_card_des1"))
        
        self._imageBack:loadTexture(Path.getMonthlyCardRes("week_back"))
        self._imageContentBack:loadTexture(Path.getMonthlyCardRes("week_cell"))
        self._imageCell1:loadTexture(Path.getMonthlyCardRes("week_cell"))
        self._imageCell2:loadTexture(Path.getMonthlyCardRes("week_cell"))
        --self._imageContentBack:ignoreContentAdaptWithSize(false)
	else
		self._atlasLabel02:setColor(Colors.COLOR_QUALITY[5])
		self._atlasLabel03:setColor(Colors.COLOR_QUALITY[5])
		self._textDes:setColor(Colors.COLOR_QUALITY[5])
        self._textDes:setString(Lang.get("lang_activity_monthly_card_des2"))
        self._imageBack:loadTexture(Path.getMonthlyCardRes("month_back"))
        self._imageContentBack:loadTexture(Path.getMonthlyCardRes("month_cell"))
        self._imageCell1:loadTexture(Path.getMonthlyCardRes("month_cell"))
        self._imageCell2:loadTexture(Path.getMonthlyCardRes("month_cell"))
	end
	
	-- i18n change lable
	self:_swapImageByI18n()
	self:_dealI18n()

    cc.bind(self._dropListView, "CommonListViewLineItem")
    self:_updateDropAwards()
end

function MonthCardNode:_updateDropAwards()
    -- body
    local MonthCardHelper = require("app.scene.view.activity.monthlycard.MonthCardHelper")
    local dropList = MonthCardHelper.getCurCanDropAwrads()

    if table.nums(dropList) <= 0 then
        return
    end

    self._dropListView:setMaxItemSize(3)
    self._dropListView:setListViewSize(320,120)
    self._dropListView:setItemsMargin(1)
    self._dropListView:updateUI(dropList, 1)

    local num = table.nums(dropList)
    if num < 3 then
        self._dropListView:setPositionX((300 - self._dropListView:getItemContentSize().width * num)/2)
    elseif num == 3 then
        self._dropListView:setPositionX((328 - self._dropListView:getItemContentSize().width * num)/2)
    end    
end

function MonthCardNode:_onBtnClick(sender)
    if self._callBack then
        self._callBack(sender,self._data)
    end
end

function MonthCardNode:_refreshBthStateToReceive(cardData)
	--self._commonButton1:switchToHightLight()

	local remainDay = cardData:getRemainDay()
	self._commonButton1:setString(Lang.get("lang_activity_monthly_card_btn_2"))
	self._commonButton1:setEnabled(true)

	self._imageHintBg:setVisible(true)
	self:_createConditionRichText(Lang.get("lang_activity_monthly_card_remain_day",{day = remainDay}))
end

function MonthCardNode:_refreshBthStateToAlreadyReceive(cardData)
	self._commonButton1:setVisible(false)
	self._imageReceive:setVisible(true)
	local remainDay = cardData:getRemainDay()

	self._imageHintBg:setVisible(true)
	--self._textTitle:setString(Lang.get("lang_activity_monthly_card_remain_day",{day = remainDay}))
	self:_createConditionRichText(Lang.get("lang_activity_monthly_card_remain_day",{day = remainDay}))
end

function MonthCardNode:_refreshBthStateToBuy(data)
	--self._commonButton1:switchToNormal()

	local price = data.rmb

	if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        local _,currencyStr = UIHelper.convertCurrency(price)
		currencyStr = UIHelper.convertDollar(currencyStr)
		self._commonButton1:setString(Lang.get("lang_activity_monthly_card_btn_1",{value = currencyStr}))
	else
		self._commonButton1:setString(Lang.get("lang_activity_monthly_card_btn_1",{value = price}))
    end
	self._commonButton1:setEnabled(true)


	self._imageSend:setVisible(true)
end

function MonthCardNode:_refreshBthStateToRenew(cardData)
	--self._commonButton1:switchToNormal()

	local remainDay = cardData:getRemainDay()

	local price = cardData:getConfig().rmb

	if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        local _,currencyStr = UIHelper.convertCurrency(price)
		currencyStr = UIHelper.convertDollar(currencyStr)
		self._commonButton1:setString(Lang.get("lang_activity_monthly_card_renew",{value = currencyStr}))
	else
		self._commonButton1:setString(Lang.get("lang_activity_monthly_card_renew",{value = price}))
    end

	self._commonButton1:setEnabled(true)


	self._imageHintBg:setVisible(true)
	--self._textTitle:setString(Lang.get("lang_activity_monthly_card_remain_day",{day = remainDay}))
	self:_createConditionRichText(Lang.get("lang_activity_monthly_card_remain_day",{day = remainDay}))
end

function MonthCardNode:refreshUI(data)
	if not data then
		self._node:setVisible(false)
		return
	end
    self._data = data
	self._node:setVisible(true)


	self._imageHintBg:setVisible(false)
	self._imageSend:setVisible(false)

	local monthlyCardData = G_UserData:getActivityMonthCard()
	local cardData = monthlyCardData:getMonthCardDataById(data.id)


	local totalGold = data.last_day * data.size + data.gold
	local dailyGold = data.size
	local firstGold = data.gold

	self._atlasLabel01:setString(tostring(totalGold))
	self._atlasLabel02:setString(tostring(dailyGold))
	self._atlasLabel03:setString(tostring(firstGold))
	if not Lang.checkLang(Lang.CN) then
		self._labelTotalGold:setString(totalGold..Lang.getImgText("gold"))
		self:_updateTotalGetPosI18n()
	end
	
	if not Lang.checkLang(Lang.CN) then
		self:_updateDailyGetPosI18n()
	end


	self._imageReceive:setVisible(false)
	self._commonButton1:setVisible(true)

	--如果是最后一天,在玩家领取后显示购买按钮，购买完成后才显示已领取灰度按钮
	if cardData and cardData:isCanReceive() then
		self:_refreshBthStateToReceive(cardData)
	else

	    if not cardData then
			--购买
			self:_refreshBthStateToBuy(data)
		elseif cardData:getRemainDay() <= 0	 then
			--购买
			self:_refreshBthStateToBuy(data)
		elseif cardData:getRemainDay() <= cardData:getConfig().renew_day then
			--续费
			self:_refreshBthStateToRenew(cardData)
		else
			--不能领取
			self:_refreshBthStateToAlreadyReceive(cardData)
		end
	end
end

--创建领取条件富文本
function MonthCardNode:_createConditionRichText(richText)
    self._imageHintBg:removeAllChildren()
    local widget = ccui.RichText:createWithContent(richText)
    widget:setAnchorPoint(cc.p(0.5,0.5))
    self._imageHintBg:addChild(widget)
	local UIHelper = require("yoka.utils.UIHelper")
	UIHelper.setPosByPercent(widget, cc.p(0.5,0.5))
end



-- i18n change lable
function MonthCardNode:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")	
        self._imageReceive = UIHelper.swapSignImage(self._imageReceive,
		{ 
			 style = "signet_8", 
			 text = Lang.getImgText("img_seal_yilingqu03") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))


		self._labelTotalGold = UIHelper.createLabel(
			{ 
				style = self._index == 1 and "month_card_1" or "month_card_2", 
				anchorPoint = cc.p(1,0.5),
				position = cc.p(260,25)
			}
		)
		self._imageYuanbaoBg:addChild(self._labelTotalGold)
	end

	if Lang.checkSquareLanguage() then
		self._labelTotalGold:setFontSize(self._labelTotalGold:getFontSize()-2)
	end
end


-- i18n change lable
function MonthCardNode:_dealI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image1 = UIHelper.seekNodeByName(self._node,"Image_39")
		local image2 = UIHelper.seekNodeByName(self._node,"Image_send")
		

		local text1 = UIHelper.seekNodeByName(image1,"Text_02")
		local text2 = UIHelper.seekNodeByName(image2,"Text_03")
		
		text1:setPositionX(text1:getPositionX()-38)
		text2:setPositionX(text2:getPositionX()-42)

		image1:setPositionX(image1:getPositionX()+10)
		image2:setPositionX(image2:getPositionX()+21)

		
		local image3 = ccui.Helper:seekNodeByName(self._node, "Image_81")
		local size = image3:getContentSize()
		image3:setContentSize(cc.size(size.width+10,size.height))

		self._atlasLabel03:setPositionX(self._atlasLabel03:getPositionX()+10)

		self._atlasLabel02:setPositionX(self._atlasLabel02:getPositionX()+4)
	end
	if  not Lang.checkLang(Lang.CN) then
		self._textDes:setPositionX(self._textDes:getPositionX()-8)
	end

	if Lang.checkLang(Lang.JA) then -- i18n ja change pos
		self._labelTotalGold:setPosition(cc.p( self._labelTotalGold:getPositionX()+5, self._labelTotalGold:getPositionY() + 4))
		self._labelTotalGold:setFontSize(self._labelTotalGold:getFontSize() - 7)
		self._textDes:setFontSize(self._textDes:getFontSize()- 4)
		self._textDes:setPositionX(self._textDes:getPositionX()-2)

		local image3 = ccui.Helper:seekNodeByName(self._node, "Image_81")
		local size = image3:getContentSize()
		image3:setContentSize(cc.size(size.width+20,size.height))
		self._imageSend:setPositionX(self._imageSend:getPositionX()+18)
		self._atlasLabel03:setPositionX(self._atlasLabel03:getPositionX()-7)

		self._text03:setFontSize(self._text03:getFontSize()-5)
		self._text03:setPositionX(self._text03:getPositionX()-13)
	end
end

-- i18n change pos
function MonthCardNode:_updateDailyGetPosI18n()
end

-- i18n change pos
function MonthCardNode:_updateTotalGetPosI18n()
end

return MonthCardNode
