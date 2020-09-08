local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")
local UIActionHelper = require("app.utils.UIActionHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupLevelPkgItemCell = class("PopupLevelPkgItemCell", ListViewCellBase)


function PopupLevelPkgItemCell:ctor()
	self._imageTitle = nil
	self._buttonBuy = nil  --CommonButtonSwitchLevel1
	self._textTime = nil --Text
	self._listItem = nil
	self._textCondition = nil  --SingleNode
	local resource = {
		file = Path.getCSB("PopupLevelPkgItemCell", "new_level_pkg"),
		binding = {
			_buttonBuy = {
				events = {{event = "touch", method = "_onBtnBuy"}}
			},
		},
	}
	PopupLevelPkgItemCell.super.ctor(self, resource)
end

function PopupLevelPkgItemCell:onCreate()
	-- body
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
	self._buttonBuy:setString(Lang.get("common_btn_name_confirm"))
	self._listItem:setItemSpacing(2)
	self._listItem:setListViewSize(218,70)

	self._textHint:setString(Lang.get("lang_new_level_pkg_get"))
end

function PopupLevelPkgItemCell:_lockState()
	self._textTime:setVisible(false)

	local vipConfig = self._data:getVipConfig()
	self._buttonBuy:setVisible(true)

	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local _,currencyStr1 = UIHelper.convertCurrency( vipConfig.rmb)
		currencyStr1 = UIHelper.convertDollar(currencyStr1)
		self._buttonBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = currencyStr1}))
	else
		self._buttonBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = vipConfig.rmb}))
	end
	self._buttonBuy:setEnabled(false)
end

function PopupLevelPkgItemCell:_alreadyBuyState()
	self._textTime:setVisible(false)
	self._buttonBuy:setVisible(true)
	self._buttonBuy:setEnabled(false)
	self._buttonBuy:setString(Lang.get("lang_activity_level_gift_btn_alreadyBuy"))
end

function PopupLevelPkgItemCell:_timeoutState()
	self._textTime:setVisible(false)
	self._buttonBuy:setVisible(true)
	self._buttonBuy:setEnabled(false)
	self._buttonBuy:setString(Lang.get("lang_activity_level_gift_btn_timeout"))
end


function PopupLevelPkgItemCell:_countDownState()
	self._textTime:setVisible(true)
	local action = UIActionHelper.createUpdateAction(function()

		local isTimeOut, limitTime = self._data:isTimeOut()
		if not isTimeOut then
			self._textTime:setString(
				Lang.get("lang_new_level_pkg_time",{time = G_ServerTime:getLeftSecondsString(limitTime, "00:00:00")})
			)
		else
			self:updateUI(self._data)
		end
	end)
	self._textTime:runAction(action)
	local vipConfig = self._data:getVipConfig()
	self._buttonBuy:setVisible(true)

	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local _,currencyStr1 = UIHelper.convertCurrency( vipConfig.rmb)
		currencyStr1 = UIHelper.convertDollar(currencyStr1)
		self._buttonBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = currencyStr1}))
	else
		self._buttonBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = vipConfig.rmb}))
	end
	self._buttonBuy:setEnabled(true)
end

-- appstore 送审条件下  忽略限制条件
function PopupLevelPkgItemCell:updateAppstoreCheckUI(data)
	if not data then
		return
	end

	self._data = data
	self._textTime:stopAllActions()
	self._textCondition:setVisible(true)

	local config = self._data:getConfig()
	self._textCondition:setString(Lang.getTxt(config.good_name,{num = config.require_value}))
	self._imageTitle:loadTexture(Path.getNewLevelPkg(config.rebate_res) )
	
	local payCfg = self._data:getVipConfig()
	self._listItem:updateUI(
		UserDataHelper.getNewLevelPkgRewards(config), 0.75, true)
	self._listItem:alignCenter()

	local config = self._data:getConfig()
	if data:getIs_buy() then
		self:_alreadyBuyState()
	else
		self._textTime:setVisible(false)
		local vipConfig = self._data:getVipConfig()
		self._buttonBuy:setVisible(true)

		if not Lang.checkLang(Lang.CN) then
			local UIHelper  = require("yoka.utils.UIHelper")
			local _,currencyStr1 = UIHelper.convertCurrency( vipConfig.rmb)
			currencyStr1 = UIHelper.convertDollar(currencyStr1)
			self._buttonBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = currencyStr1}))
		else
			self._buttonBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = vipConfig.rmb}))
		end
		self._buttonBuy:setEnabled(true)
	end
end

function PopupLevelPkgItemCell:updateUI(data)
	-- body
	if G_ConfigManager:isAppstore() then
		self:updateAppstoreCheckUI(data)
		return
	end

	if not data then
		return
	end

	self._data = data
	self._textTime:stopAllActions()
	self._textCondition:setVisible(true)

	local config = self._data:getConfig()
	self._textCondition:setString(Lang.getTxt(config.good_name,{num = config.require_value}))
	self._imageTitle:loadTexture(Path.getNewLevelPkg(config.rebate_res) )
	
	local payCfg = self._data:getVipConfig()
	self._listItem:updateUI(
		UserDataHelper.getNewLevelPkgRewards(config), 0.75, true)
	self._listItem:alignCenter()

	if data:isReachUnLockLevel() then
		local isTimeOut = data:isTimeOut()
		if data:getIs_buy() then
			self:_alreadyBuyState()
		elseif isTimeOut then
			self:_timeoutState()
		else
			self:_countDownState()
		end
	else
		self:_lockState()
	end
end

-- Describle：
function PopupLevelPkgItemCell:_onBtnBuy()
	-- body
	if G_ConfigManager:isAppstore() then
		if self._data:getIs_buy() then
			return
		end
	else
		if not self._data:isReachUnLockLevel() then
			return
		end

		if self._data:getIs_buy() then
			return
		end

		if self._data:isTimeOut() then
			return
		end
	end
	
	local payCfg = self._data:getVipConfig()
	G_GameAgent:pay(payCfg.id, 
					payCfg.rmb, 
					payCfg.product_id, 
					payCfg.name, 
					payCfg.name)
end


return PopupLevelPkgItemCell
