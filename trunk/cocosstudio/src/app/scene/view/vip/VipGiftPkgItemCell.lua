
local ListViewCellBase = require("app.ui.ListViewCellBase")
local VipGiftPkgItemCell = class("VipGiftPkgItemCell", ListViewCellBase)

function VipGiftPkgItemCell:ctor()
	self._resourceNode = nil --根节点
	self._nodeCondition = nil--富文本节点
	self._imageReceive = nil--已领取图片
    self._buttonReceive = nil

    
	local resource = {
		file = Path.getCSB("VipGiftPkgItemCell", "vip"),
		binding = {
			_buttonReceive = {
				events = {{event = "touch", method = "_onItemClick"}}
			}
		},
    }
    if Lang.checkUI("ui4") then
        resource.file =  Path.getCSB("VipViewGiftPkgItemCell", "vip")
    end
	VipGiftPkgItemCell.super.ctor(self, resource)
end

function VipGiftPkgItemCell:onCreate()
    -- i18n change lable
    self:_swapImageByI18n()
    -- i18n add lable
    self:_addLabelByI18n()

	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

    self._buttonReceive:switchToNormal()
    self._buttonReceive:setString(Lang.get("lang_activity_fund_receive"))
    --self._buttonReceive:setSwallowTouches(false)


    if Lang.checkUI("ui4") then
        self._itemList:setListViewSize(440,74)
        self._itemList:setItemSpacing(1)
    else
        self._itemList:setListViewSize(536,98)
        self._itemList:setItemSpacing(6)
    end
end

function VipGiftPkgItemCell:_onItemClick(sender,state)
    if state == ccui.TouchEventType.ended or not state then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
		if moveOffsetX < 20 and moveOffsetY < 20 then
        	local curSelectedPos = self:getTag()
            logWarn("VipGiftPkgItemCell:_onIconClicked  "..curSelectedPos)
            self:dispatchCustomCallback(curSelectedPos)
		end
	end
end

--创建领取条件富文本
function VipGiftPkgItemCell:_createConditionRichText(richText)
    local widget = ccui.RichText:createWithContent(richText)
    if not Lang.checkLang(Lang.CN) and not Lang.checkUI("ui4")then
         widget:setAnchorPoint(cc.p(1,0.5))
         self._nodeCondition:setPositionX(685)
    elseif Lang.checkUI("ui4") then
        widget:setAnchorPoint(cc.p(1,0.5))
    else
         widget:setAnchorPoint(cc.p(0.5,0.5))
    end
    self._nodeCondition:removeAllChildren()
    self._nodeCondition:addChild(widget)
end

function VipGiftPkgItemCell:updateUI(vipItemData)
    self._vipItemData = vipItemData
    local vipLevel = vipItemData:getId()

 
    if Lang.checkUI("ui4") then
        self._textVip:setString(Lang.get("vip_gift_title",{level = vipLevel}))
    else
        self._vipNode:setString(tostring(vipLevel))
    end

   
    self:_updateVipButtonState()
    
    
    if not Lang.checkLang(Lang.CN) then
        self:_dealPosByI18n()
    end

	local itemList = vipItemData:getVipGiftList()

    if Lang.checkUI("ui4") then
        self._itemList:updateUI(itemList,0.8)
    else
        self._itemList:updateUI(itemList,1)
    end
--[[
    for i, item in ipairs(self._items) do
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
    
]]

    local currentVipExp = G_UserData:getVip():getExp()
    local currentVipTotalExp = G_UserData:getVip():getCurVipTotalExp()

    local max =  G_UserData:getVip():getVipTotalExp(0,vipLevel)
    --[[
    if vipLevel - 1 >= 0 then
        local VipLevelInfo = require("app.config.vip_level")
        local preLevelInfo = VipLevelInfo.indexOf(vipLevel-1+1)
        assert(preLevelInfo, "vip_level can not find id "..tostring(vipLevel-1))
        max = preLevelInfo.vip_exp    
    end
]]
    local exp = math.min(currentVipTotalExp,max)
    
    local richText = Lang.get("lang_vip_gift_pkg_progress",
            {
                progress =  math.floor(exp/10),
                max = math.floor(max/10),
                titleColor = Colors.colorToNumber(exp < max and Colors.BRIGHT_BG_TWO or Colors.BRIGHT_BG_GREEN ),
                progressColor =  Colors.colorToNumber(Colors.BRIGHT_BG_GREEN), 
                maxColor = Colors.colorToNumber(exp < max and Colors.BRIGHT_BG_TWO or Colors.BRIGHT_BG_GREEN )
            })
    
    if Lang.checkUI("ui4") then
        richText = Lang.get("vip_gift_condition_des",
            {
                progress =  math.floor(exp),
                max = math.floor(max),
                titleColor = Colors.colorToNumber(exp < max and Colors.BRIGHT_BG_TWO or Colors.BRIGHT_BG_GREEN ),
                progressColor =  Colors.colorToNumber(Colors.BRIGHT_BG_GREEN), 
                maxColor = Colors.colorToNumber(exp < max and Colors.BRIGHT_BG_TWO or Colors.BRIGHT_BG_GREEN )
            })
    end
    if not Lang.checkLang(Lang.CN) and not Lang.checkUI("ui4") then
        local UIHelper  = require("yoka.utils.UIHelper")
        local _,currencyStr1 = UIHelper.convertCurrency( UIHelper.convertExpToCurrency(exp))
        local _,currencyStr2 = UIHelper.convertCurrency( UIHelper.convertExpToCurrency(max))
       
        richText = Lang.get("lang_vip_gift_pkg_progress",
        {
            progress = currencyStr1,
            max = currencyStr2,
            titleColor = Colors.colorToNumber(exp < max and Colors.BRIGHT_BG_TWO or Colors.BRIGHT_BG_GREEN ),
            progressColor =  Colors.colorToNumber(Colors.BRIGHT_BG_GREEN), 
            maxColor = Colors.colorToNumber(exp < max and Colors.BRIGHT_BG_TWO or Colors.BRIGHT_BG_GREEN )
        })


    end
    self:_createConditionRichText(richText)       
end

function VipGiftPkgItemCell:_updateVipButtonState()
	local currVipLevel = self._vipItemData:getId()
	local playerVipLevel = G_UserData:getVip():getLevel()
	
	if currVipLevel > playerVipLevel then	
        self._nodeCondition:setVisible(true)
        self._imageReceive:setVisible(false)
	    self._buttonReceive:setVisible(true)
		self._buttonReceive:setString(Lang.get("lang_vip_gift_pkg_go_recharge"))
        self._buttonReceive:switchToHightLight()
		return
	else
		if G_UserData:getVip():isVipRewardTake(currVipLevel) then
            self._nodeCondition:setVisible(false)
            self._imageReceive:setVisible(true)
			self._buttonReceive:setVisible(false)
			return
		end
	end
    self._nodeCondition:setVisible(true)
    self._imageReceive:setVisible(false)
	self._buttonReceive:setVisible(true)
	self._buttonReceive:setString(Lang.get("lang_buy_gift"))
    self._buttonReceive:switchToNormal()
end


-- i18n change lable
function VipGiftPkgItemCell:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")	
        self._imageReceive = UIHelper.swapSignImage(self._imageReceive,
		{ 
			 style = "signet_8", 
			 text = Lang.getImgText("txt_yilingqu02") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))

    end
end
    

-- i18n change lable
function VipGiftPkgItemCell:_dealPosByI18n()
    if Lang.checkUI("ui4") then
        return
    end
    if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")	
        local image1 = UIHelper.seekNodeByName(self,"Image_19")
        UIHelper.alignCenter(image1,{self._vipNode},{self._vipNode:getWidth()})
        self._vipNode:setPositionX(self._vipNode:getPositionX()-5)
	end
end
function VipGiftPkgItemCell:_addLabelByI18n()
    if Lang.checkUI("ui4") then
        return
    end
end


return VipGiftPkgItemCell
