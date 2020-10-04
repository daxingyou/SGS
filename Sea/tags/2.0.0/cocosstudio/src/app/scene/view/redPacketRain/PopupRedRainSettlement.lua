--红包雨结算界面
local PopupBase = require("app.ui.PopupBase")
local PopupRedRainSettlement = class("PopupRedRainSettlement", PopupBase)

function PopupRedRainSettlement:ctor(data, onExitCallback)
	self._data = data
	self._onExitCallback = onExitCallback

	local resource = {
		file = Path.getCSB("PopupRedRainSettlement", "redPacketRain"),
		binding = {
			_buttonClose = {
				events = {{event = "touch", method = "_onClickClose"}}
			}
		}
	}
	PopupRedRainSettlement.super.ctor(self, resource, false)
end

function PopupRedRainSettlement:onCreate()
	-- i18n change lable
	if not Lang.checkLang(Lang.CN) then
		self:_swapImageByI18n()
	end
	self._textNum:setString(tostring(self._data.money))
	self._textBigNum:setString(Lang.get("red_packet_rain_big_num", {num = self._data.bigNum}))
	self._textSmallNum:setString(Lang.get("red_packet_rain_small_num", {num = self._data.smallNum}))
	local size = self._textNum:getVirtualRendererSize()
	local posX = self._textNum:getPositionX()
	self._imageTextMoney:setPositionX(posX + size.width)
	self._buttonClose:setString(Lang.get("red_pacekt_rain_settlement_confirm_btn"))
	
	G_EffectGfxMgr:createPlayMovingGfx(self._nodeMoving, "moving_gongxizhugong", nil, nil, false)

	if not Lang.checkLang(Lang.CN) then
		self:_updatePosByI18n()
	end
	
end

function PopupRedRainSettlement:onEnter()
	
end

function PopupRedRainSettlement:onExit()
	if self._onExitCallback then
		self._onExitCallback()
	end
end

function PopupRedRainSettlement:_onClickClose()
	self:close()
end

-- i18n change lable
function PopupRedRainSettlement:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image1 = UIHelper.seekNodeByName(self,"Image_7")
		UIHelper.swapWithLabel(image1,{ 
			 style = "text_redbag_1", 
			 text = Lang.getImgText("img_gonghuode") ,
		})
		
	
		self._imageTextMoney = UIHelper.swapWithLabel(self._imageTextMoney,{ 
			 style = "text_redbag_1", 
			 text = Lang.getImgText("img_gonghuode2") ,
		})
	end
end

-- i18n change lable
function PopupRedRainSettlement:_updatePosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image1 = UIHelper.seekNodeByName(self,"Image_7")
		UIHelper.alignCenter(self._nodeMoving,{image1,self._textNum,self._imageTextMoney})
	end
	if Lang.checkChannel(Lang.CHANNEL_SEA) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image5 = UIHelper.seekNodeByName(self,"Image_5")
		local offset = 35
		image5:setPositionX(image5:getPositionX()-offset)
		self._textBigNum:setPositionX(self._textBigNum:getPositionX()-offset)
		local image6 = UIHelper.seekNodeByName(self,"Image_6")
		image6:setPositionX(image6:getPositionX()+offset)
		self._textSmallNum:setPositionX(self._textSmallNum:getPositionX()+offset)
	end
end


return PopupRedRainSettlement