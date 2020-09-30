
local ListViewCellBase = require("app.ui.ListViewCellBase")
local FirstPayItenCell = class("FirstPayItenCell", ListViewCellBase)
local UserDataHelper = require("app.utils.UserDataHelper")

function FirstPayItenCell:ctor()
	self._resourceNode = nil --根节点
	self._nodeCondition = nil--富文本节点
	self._imageReceive = nil--已领取图片
    self._buttonReceive = nil

	if not Lang.checkLang(Lang.CN) then
    	self._priceLabel = nil
 	end
    self._items = {}
	local resource = {
		file = Path.getCSB("FirstPayItemCell", "firstpay"),
		binding = {
			_buttonReceive = {
				events = {{event = "touch", method = "_onItemClick"}}
			}
		},
    }
      -- i18n ui4 change CSB
	if Lang.checkUI("ui4") then
        resource.file = Path.getCSB("FirstPayItemCell2", "firstpay")
	end
	FirstPayItenCell.super.ctor(self, resource)
end

function FirstPayItenCell:onCreate()
    -- i18n pos lable
    self:_dealPosByI18n()

	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width+self._resourceNode:getPositionX(), size.height+self._resourceNode:getPositionY())

    if Lang.checkUI("ui4") then
        local btn = ccui.Helper:seekNodeByName(self._buttonReceive, "Button")
        btn:setContentSize(cc.size(174, 60))
        local text = ccui.Helper:seekNodeByName(self._buttonReceive, "Text")
        text:setFontSize(26)

        local UIHelper  = require("yoka.utils.UIHelper")	
        self._imageReceive = UIHelper.swapSignImage(self._imageReceive,
		{ 
			 style = "signet_8", 
			 text = Lang.getImgText("txt_yilingqu02") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))
	end

    self._buttonReceive:switchToNormal()
   
    --self._buttonReceive:setSwallowTouches(false)

    self._items = {self._item01,self._item02,self._item03,self._item04,self._item05}
end

function FirstPayItenCell:_onItemClick(sender,state)
    if state == ccui.TouchEventType.ended or not state then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
		if moveOffsetX < 20 and moveOffsetY < 20 then
        	local curSelectedPos = self:getTag()
            logWarn("FirstPayItenCell:_onIconClicked  "..curSelectedPos)
            self:dispatchCustomCallback(curSelectedPos)
		end
	end
end


function FirstPayItenCell:_updateButtonState()

    self._buttonReceive:setEnabled(true)

	local firstPayData = G_UserData:getActivityFirstPay()
    if firstPayData:canReceive(self._data.id) then
        self._imageReceive:setVisible(false)
        self._buttonReceive:setVisible(true)
        self._buttonReceive:setString(Lang.get("lang_buy_gift"))
        self._buttonReceive:switchToNormal()
    elseif firstPayData:hasReceive(self._data.id) then
        self._imageReceive:setVisible(true)
	    self._buttonReceive:setVisible(false)
    else
        self._imageReceive:setVisible(false)
	    self._buttonReceive:setVisible(true)
		self._buttonReceive:setString(Lang.get("lang_vip_gift_pkg_go_recharge"))
        self._buttonReceive:switchToHightLight()
    end 
end

-- i18n 新增参数index
function FirstPayItenCell:updateUI(data,index)
    self._data = data
    self:_updateButtonState()
    
	local itemList = UserDataHelper.makeRewards(data,3)
    for i, item in ipairs(self._items ) do
        local itemData = itemList[i]
        if itemData then
            item:setVisible(true)
            item:unInitUI()
            item:initUI(itemData.type, itemData.value, itemData.size)
            item:setTouchEnabled(true)
		    item:showIconEffect()
        else
            item:setVisible(false)
        end
	end

    if not Lang.checkLang(Lang.CN) then
        if index == 1 then
            self._priceLabel:setString(Lang.getImgText("any_recharge"))
        else
            local UIHelper  = require("yoka.utils.UIHelper")
            local _,currencyStr = UIHelper.convertCurrency(data.charge)
            -- local _,currencyStr = UIHelper.convertDollar(currencyStr)
            self._priceLabel:setString(Lang.getImgText("shouchong_leichong").." "..currencyStr)  
        end
    end
end


-- i18n pos lable
function FirstPayItenCell:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
        local size = self._resourceNode:getContentSize()
		local UIHelper  = require("yoka.utils.UIHelper")	
		self._priceLabel = UIHelper.createLabel(
            { 
                style = "pay_1", 
                text = "",
                position = cc.p(size.width * 0.5,size.height-4)
            }
        )
        self._resourceNode:addChild(self._priceLabel)
    end
    if Lang.checkUI("ui4") then
        self._priceLabel:setVisible(false)
    end
end
return FirstPayItenCell
