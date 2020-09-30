--红包雨结算界面
local PopupBase = require("app.ui.PopupBase")
local PopupRedRainSettlement = class("PopupRedRainSettlement", PopupBase)

local POSX = {
	[1] = {0},
	[2] = {-81, 82}
}

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
	local bigNum = self._data.bigNum
	local smallNum = self._data.smallNum
	self._textBigNum:setString(Lang.get("red_packet_rain_big_num", {num = bigNum}))
	self._textSmallNum:setString(Lang.get("red_packet_rain_small_num", {num = smallNum}))
	--数量为0的隐藏
	self._nodeBig:setVisible(bigNum > 0)
	self._nodeSmall:setVisible(smallNum > 0)
	local showCount = 0
	local showNodes = {}
	if bigNum > 0 then
		table.insert(showNodes, self._nodeBig)
		showCount = showCount + 1
	end
	if smallNum > 0 then
		table.insert(showNodes, self._nodeSmall)
		showCount = showCount + 1
	end
	--位置排版
	for i, node in ipairs(showNodes) do
		node:setPositionX(POSX[showCount][i])
	end

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
end


return PopupRedRainSettlement