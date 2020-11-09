local DataConst = require("app.const.DataConst")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local MonthCardNode2 = class("MonthCardNode2")

MonthCardNode2.CARD_PNGS = {
	{type = "img_zhouka",color = cc.c3b(0xef, 0xcc, 0xff),color2 = cc.c3b(0xb0, 0x36, 0xf8)},
	{type = "img_yueka",color = cc.c3b(0xff, 0xf5, 0xd2),color2 = cc.c3b(0xf4, 0x69, 0x15)}
}

function MonthCardNode2:ctor(node,index,callBack)
    self._node = node
    self._index = index
    self._callBack = callBack
    self._data = nil

    self._image_bg = ccui.Helper:seekNodeByName(node, "Image_bg")
    self._dropListView = ccui.Helper:seekNodeByName(node, "DropAwardsListview")
	self._textTips = ccui.Helper:seekNodeByName(node, "TextTips")
	self._imageReceive = ccui.Helper:seekNodeByName(node, "Image_receive")
    self._commonButton1 = ccui.Helper:seekNodeByName(node, "CommonButton1")

    self._nodeReward1 = ccui.Helper:seekNodeByName(node, "nodeIcon1")
    self._nodeReward2 = ccui.Helper:seekNodeByName(node, "nodeIcon2")
    self._nodeReward3 = ccui.Helper:seekNodeByName(node, "nodeIcon3")

    self._text_1 = ccui.Helper:seekNodeByName(node, "Text_1")
    self._nodeTips = ccui.Helper:seekNodeByName(node, "NodeTips") 
    
	cc.bind(self._commonButton1, "CommonButtonSwitchLevel1")
	self._commonButton1:addClickEventListenerEx(handler(self,self._onBtnClick))
    self._commonButton1:setButtonTag(index)
    self._commonButton1:switchToHightLight()

	local uiData = MonthCardNode2.CARD_PNGS[self._index]
	self._image_bg:loadTexture(Path.getMonthlyCardRes2(uiData.type))
	
    
    
	self._text_1:setColor(uiData.color)
    self._imageReceive:updateLabel("Text", {text = Lang.getImgText("txt_yilingqu02") })


    cc.bind(self._dropListView, "CommonListViewLineItem")
    self:_updateDropAwards()
end

function MonthCardNode2:_updateDropAwards()
    -- body
    local MonthCardHelper = require("app.scene.view.activity.monthlycard.MonthCardHelper")
    local dropList = MonthCardHelper.getCurCanDropAwrads()

    if table.nums(dropList) <= 0 then
        return
    end

    self._dropListView:setMaxItemSize(3)
    self._dropListView:setListViewSize(280,120)
    self._dropListView:setItemsMargin(1)
    self._dropListView:setItemSpacing(3)
    self._dropListView:updateUI(dropList, 0.6)
    self._dropListView:setTextItemCountFontSize(26)

    local num = table.nums(dropList)
    if num < 3 then
        --self._dropListView:setPositionX((300 - self._dropListView:getItemContentSize().width * num)/2)
    elseif num == 3 then
        --self._dropListView:setPositionX((328 - self._dropListView:getItemContentSize().width * num)/2)
    end    
    self._dropListView:alignCenter()
end

function MonthCardNode2:_onBtnClick(sender)
    if self._callBack then
        self._callBack(sender,self._data)
    end
end

function MonthCardNode2:_refreshBthStateToReceive(cardData)
	local remainDay = cardData:getRemainDay()
	self._commonButton1:setString(Lang.get("lang_activity_monthly_card_btn_2"))
	self._commonButton1:setEnabled(true)

	self._nodeTips:setVisible(true)
	self:_createConditionRichText(Lang.get("vip_month_card_4",{day = remainDay}))
end

function MonthCardNode2:_refreshBthStateToAlreadyReceive(cardData)
	self._commonButton1:setVisible(false)
	self._imageReceive:setVisible(true)
	local remainDay = cardData:getRemainDay()

	self._nodeTips:setVisible(true)
	self:_createConditionRichText(Lang.get("vip_month_card_4",{day = remainDay}))
end

function MonthCardNode2:_refreshBthStateToBuy(data)
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
end

function MonthCardNode2:_refreshBthStateToRenew(cardData)

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


	self._nodeTips:setVisible(true)
	self:_createConditionRichText(Lang.get("vip_month_card_4",{day = remainDay}))
end

function MonthCardNode2:refreshUI(data)
	if not data then
		self._node:setVisible(false)
		return
	end
    self._data = data
	self._node:setVisible(true)
	self._nodeTips:setVisible(false)

	local monthlyCardData = G_UserData:getActivityMonthCard()
	local cardData = monthlyCardData:getMonthCardDataById(data.id)

	local totalGold = data.last_day * data.size + data.gold
	local dailyGold = data.size
	local firstGold = data.gold

    self:_refreshReward(self._nodeReward1,
            {type = TypeConvertHelper.TYPE_RESOURCE,value = DataConst.RES_DIAMOND,size = firstGold},
            Lang.get("vip_month_card_1"),1)

    self:_refreshReward(self._nodeReward2,
            {type = TypeConvertHelper.TYPE_RESOURCE,value = DataConst.RES_DIAMOND,size =dailyGold},
            Lang.get("vip_month_card_2"),1)

            
    self:_refreshReward(self._nodeReward3,
        {type = TypeConvertHelper.TYPE_RESOURCE,value = DataConst.RES_DIAMOND,size =totalGold},
        Lang.get("vip_month_card_3"),2)

    self:_refreshRewardState(self._nodeReward3,false)

	self._imageReceive:setVisible(false)
	self._commonButton1:setVisible(true)

	--如果是最后一天,在玩家领取后显示购买按钮，购买完成后才显示已领取灰度按钮
	if cardData and cardData:isCanReceive() then
        self:_refreshBthStateToReceive(cardData)
        self:_refreshRewardState(self._nodeReward1,true)
        self:_refreshRewardState(self._nodeReward2,false)
	else
	    if not cardData then
			--购买
            self:_refreshBthStateToBuy(data)
            self:_refreshRewardState(self._nodeReward1,false)
            self:_refreshRewardState(self._nodeReward2,false)
		elseif cardData:getRemainDay() <= 0	 then
			--购买
            self:_refreshBthStateToBuy(data)
            self:_refreshRewardState(self._nodeReward1,false)
            self:_refreshRewardState(self._nodeReward2,false)
		elseif cardData:getRemainDay() <= cardData:getConfig().renew_day then
			--续费
            self:_refreshBthStateToRenew(cardData)
            self:_refreshRewardState(self._nodeReward1,true)
            self:_refreshRewardState(self._nodeReward2,true)
		else
			--不能领取
            self:_refreshBthStateToAlreadyReceive(cardData)
            self:_refreshRewardState(self._nodeReward1,true)
            self:_refreshRewardState(self._nodeReward2,true)
		end
	end
end

--创建领取条件富文本
function MonthCardNode2:_createConditionRichText(richText)
    
    local label = self._nodeTips:getParent():getChildByName("TextTips")
    --local label = ccui.Helper:seekNodeByName(self._nodeTips, "Text")
    label:setString(richText)
    local uiData = MonthCardNode2.CARD_PNGS[self._index]
	label:setColor(uiData.color2)
end

function MonthCardNode2:_refreshReward(node,item,txt,bgType)
    local label = ccui.Helper:seekNodeByName(node, "Text")
    local icon =  ccui.Helper:seekNodeByName(node, "Icon")
    label:setString(txt)
    cc.bind(icon,"CommonIconTemplate")
    icon:initUI(item.type,item.value,item.size)
    icon:getIconTemplate():setTextItemCountFontSize(26)
    local uiData = MonthCardNode2.CARD_PNGS[self._index]
	label:setColor( bgType == 1 and uiData.color or uiData.color2)
end

function MonthCardNode2:_refreshRewardState(node,isGet)
    local image =  ccui.Helper:seekNodeByName(node, "Image")
    local label = ccui.Helper:seekNodeByName(node, "Text")
    local imageSelect = ccui.Helper:seekNodeByName(node, "Image_Select")
    
    imageSelect:setVisible(isGet)
    image:setVisible(isGet)
end

return MonthCardNode2
