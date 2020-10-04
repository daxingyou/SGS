--
-- Author: Liangxu
-- Date: 2019-4-30
-- 蛋糕活动获取奶油Cell

local ListViewCellBase = require("app.ui.ListViewCellBase")
local CakeGetCreamCell = class("CakeGetCreamCell", ListViewCellBase)
local CakeActivityDataHelper = require("app.utils.data.CakeActivityDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")

function CakeGetCreamCell:ctor()
	local resource = {
		file = Path.getCSB("CakeGetCreamCell", "cakeActivity"),
		binding = {
			_buttonBuy = {
				events = {{event = "touch", method = "_onClickBuy"}}
			},
			_imageAward1 = {
				events = {{event = "touch", method = "_onClickIcon1"}}
			},
			_imageAward2 = {
				events = {{event = "touch", method = "_onClickIcon2"}}
			},
		}
	}
	CakeGetCreamCell.super.ctor(self, resource)
end

function CakeGetCreamCell:onCreate()
	local size = self._panelBg:getContentSize()
	self:setContentSize(size.width, size.height)
	self._info = nil
	self._vipPayInfo = nil
	self._imageAward1:setSwallowTouches(false)
	self._imageAward2:setSwallowTouches(false)
end

function CakeGetCreamCell:update(id)
	local info = CakeActivityDataHelper.getCakeChargeConfig(id)
	self._vipPayInfo = require("app.config.vip_pay").get(info.id)
	self._info = info
	for i = 1, 2 do
		self["_imageAward"..i]:loadTexture(Path.getAnniversaryImg(info["award"..i]))
	end
	self._textCount1:setString("x"..info.size1)
	self._textCount2:setString("x"..self._vipPayInfo.gold) --元宝数从vip_pay表里读
	
	self._buttonBuy:setString(self._vipPayInfo.name)
end

function CakeGetCreamCell:_onClickBuy()
	if CakeActivityDataHelper.isCanRecharge() == false then
		return
	end
	if self._vipPayInfo then
		G_GameAgent:pay(self._vipPayInfo.id, 
					self._vipPayInfo.rmb, 
					self._vipPayInfo.product_id, 
					self._vipPayInfo.name, 
					self._vipPayInfo.name)
	end
end

function CakeGetCreamCell:_onClickIcon1()
	local popup = require("app.ui.PopupItemInfo").new()
	popup:updateUI(self._info.type1, self._info.value1)
	popup:openWithAction()
end

function CakeGetCreamCell:_onClickIcon2()
	local popup = require("app.ui.PopupItemInfo").new()
	popup:updateUI(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_DIAMOND)
	popup:openWithAction()
end

return CakeGetCreamCell
