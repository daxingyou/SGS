--
-- Author: hedl
-- Date: 2017-5-2 13:50:59
--
local ListViewCellBase = require("app.ui.ListViewCellBase")
local VipRechargePageView = class("VipRechargePageView", ListViewCellBase)


local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local UIPopupHelper	 = require("app.utils.UIPopupHelper")


function VipRechargePageView:ctor(callBack)

	self._fileNode1 = nil
	self._callback = callBack
    local resource = {
        file = Path.getCSB("VipRechargePageView", "vip"),
        size = {1136, 640},
       
    }
    VipRechargePageView.super.ctor(self, resource)
end

function VipRechargePageView:onCreate()
	
	if Lang.checkLang(Lang.KR) then
		self:_dealI18n()
	end
	local contentSize = self._panelRoot:getContentSize()
	self:setContentSize(contentSize)

	--self._rechargeList = G_UserData:getVipPay():getRechargeList()
end

function VipRechargePageView:updateUI(itemList)
	self._itemList = itemList
	dump(itemList)
	for i=1, 8 do 
		local fileNode = self["_fileNode"..i]
		if fileNode then
			fileNode:setVisible(false)
		end
	end
	for i, itemValue in ipairs(itemList) do
		local fileNode = self["_fileNode"..i]
		if fileNode then
			fileNode:setVisible(true)
			self:_updateRechargeItem(fileNode, itemValue )
		end
	end

end


function VipRechargePageView:_updateRechargeItem(itemNode, vipPayData)
	local isFirstRecharge = not vipPayData.isBuyed
	local firstBuyResetTime = G_UserData:getVipPay():getFirstBuyResetTime()
	isFirstRecharge = vipPayData.buyTime == 0 or vipPayData.buyTime < firstBuyResetTime

	local vipPayCfg = vipPayData.cfg

	if vipPayCfg.effect and vipPayCfg.effect ~= "" then
		dump(vipPayCfg.effect)
		local node = itemNode:getSubNodeByName("Node_effect")
		node:removeAllChildren()
		G_EffectGfxMgr:createPlayMovingGfx(node,vipPayCfg.effect)
	end
	--itemNode:setVisible(true)

	local itemInfo = itemNode:getSubNodeByName("ItemInfo")
	itemInfo:getSubNodeByName("Image_down"):setVisible(false)
	itemInfo:addTouchEventListener(handler(self,self._onTouchCallBack))
	itemInfo:setSwallowTouches(false)
	--itemInfo:getSubNodeByName("Image_first_time"):setVisible(isFirstRecharge)
    --itemInfo:getSubNodeByName("Image_first_time_bk"):setVisible(isFirstRecharge)

	local vipIconPath = Path.getCommonIcon("vip",vipPayCfg.icon_id) 
	dump(vipIconPath)

	itemInfo:updateImageView( "Image_gold_icon", { texture = vipIconPath  })
	itemInfo:updateLabel( "Text_gold_num", { text = vipPayCfg.gold  })
	itemInfo:setTag(vipPayCfg.id)
	local sendValue = vipPayCfg.gold_rebate_2
	if isFirstRecharge == true then
		sendValue = vipPayCfg.gold_rebate_1
	end

	if isFirstRecharge then
		if Lang.checkLang(Lang.CN) then
			itemInfo:updateLabel( "Text_send_value", { text = Lang.get("lang_recharge_first_yuanbao", {num= sendValue}),visible = sendValue > 0  })
		else
			itemInfo:updateLabel( "Text_send_value", { text = Lang.get("lang_recharge_first_yuanbao", {num= sendValue}),visible = sendValue > 0 ,fontSize = 18 })
		end
	else
		itemInfo:updateLabel( "Text_send_value", { text = Lang.get("lang_recharge_yuanbao", {num= sendValue}),visible = sendValue > 0   })	
	end
	

	
	
	itemInfo:updateLabel( "Text_rmb_num", { text = vipPayCfg.rmb  })
	itemInfo:updateImageView( "Image_rmb", Path.getRechargeRmb(vipPayCfg.rmb))
	
	--首充状态-首充赠xxx元宝；非首充状态-额外赠xxx元宝

	if  Lang.checkLang(Lang.KR) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		local label = UIHelper.seekNodeByName(itemInfo,"Text_rmb_num")

		local UIHelper  = require("yoka.utils.UIHelper")
        local _,currencyStr1,currencySymbol = UIHelper.convertCurrency( vipPayCfg.rmb)
		


		itemInfo:updateLabel( "Image_rmb", { visible = false  })
		itemInfo:updateLabel( "Text_rmb_num", { text ="￦".. currencyStr1.."\n"..currencySymbol ,visible = true  })

	elseif not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		local label = UIHelper.seekNodeByName(itemInfo,"Text_rmb_num")
		UIHelper.setLabelStyle(label,{
			style = "pay_1", 
		})
		label:setAnchorPoint(cc.p(0.5,0.5))
		label:setPosition(cc.p(40,33))
		label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		label:getVirtualRenderer():setLineSpacing(-7)
		local UIHelper  = require("yoka.utils.UIHelper")
        local _,currencyStr1,currencySymbol = UIHelper.convertCurrency( vipPayCfg.rmb)
		
		currencyStr1 = UIHelper.convertDollar(currencyStr1)


		itemInfo:updateLabel( "Image_rmb", { visible = false  })
		itemInfo:updateLabel( "Text_rmb_num", { text = currencyStr1.."\n"..currencySymbol ,visible = true  })
	end
	if Lang.checkChannel(Lang.CHANNEL_SEA) then
		local pngDic = {"hot","best"}
		local recommend = vipPayCfg.recommended
		local img = pngDic[recommend]
		if itemNode.recommendImg then
			itemNode.recommendImg:removeFromParent()
		end
		local recommendImg = ccui.ImageView:create()
		recommendImg:setPosition(cc.p(35,135))
		itemNode.recommendImg = recommendImg
		itemNode:addChild(recommendImg)
		if img then
			recommendImg:loadTexture(Path.getVip(img))
			recommendImg:setVisible(true)
		else
			recommendImg:setVisible(false)
		end
	end
end

function VipRechargePageView:_onTouchCallBack(sender,state)
	if state == ccui.TouchEventType.began then
		sender:getSubNodeByName("Image_down"):setVisible(true)
	end
	if state == ccui.TouchEventType.ended then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)

		sender:getSubNodeByName("Image_down"):setVisible(false)
		if moveOffsetX < 20 and moveOffsetY < 20 then
			local vipIndex = sender:getTag()
			--[[
			if self._callback and type(self._callback) == "function" then
				self._callback(vipIndex)
			end
			]]
			logWarn("VipRechargePageView ------------  "..tostring(vipIndex))
			self:dispatchCustomCallback(vipIndex)
		end
		
	end

	if state == ccui.TouchEventType.canceled then
		sender:getSubNodeByName("Image_down"):setVisible(false)
	end
end

function VipRechargePageView:onEnter()

end

function VipRechargePageView:onExit()

end

-- i18n change lable
function VipRechargePageView:_dealI18n()
	if Lang.checkLang(Lang.KR) then
		local UIHelper  = require("yoka.utils.UIHelper")

		for i=1, 8 do 
			local fileNode = self["_fileNode"..i]
			if fileNode then
				local panelBottom = UIHelper.seekNodeByName(fileNode,"Panel_bottom")
				panelBottom:setBackGroundImage(Path.getVip("vip_qizi"))
				panelBottom:ignoreContentAdaptWithSize(false)
				panelBottom:setPosition(-1,129)
				panelBottom:setContentSize(cc.size(108,71))

				local panelTop = UIHelper.seekNodeByName(fileNode,"Panel_top")
				local image1 = UIHelper.seekNodeByName(panelTop,"Image_14_0")
				local text1 = UIHelper.seekNodeByName(panelTop,"Text_gold_num")
				
				image1:setScale(0.9)
				image1:setPositionX(100)
				text1:setPositionX(164)

				local textRmbNum = UIHelper.seekNodeByName(panelBottom,"Text_rmb_num")
				textRmbNum:setColor(cc.c3b(0xf9, 0xd7, 0x5f))
				textRmbNum:disableEffect(cc.LabelEffect.OUTLINE)
				textRmbNum:setFontSize(22)
				textRmbNum:setAnchorPoint(cc.p(0,0.5))
				textRmbNum:setPosition(4,38)

				
				local imageGoldIcon = UIHelper.seekNodeByName(fileNode,"Image_gold_icon")
				imageGoldIcon:setPositionY(imageGoldIcon:getPositionY()-6)

				local textSendValue = UIHelper.seekNodeByName(fileNode,"Text_send_value")
				textSendValue:setPositionY(textSendValue:getPositionY()-3)
			end
		end

		
	
	end
end


return VipRechargePageView
