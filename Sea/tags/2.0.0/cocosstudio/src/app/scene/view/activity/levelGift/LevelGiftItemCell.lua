
-- Author: nieming
-- Date:2017-12-21 11:45:25
-- Describle：

local ListViewCellBase = require("app.ui.ListViewCellBase")
local LevelGiftItemCell = class("LevelGiftItemCell", ListViewCellBase)
local UIActionHelper = require("app.utils.UIActionHelper")
function LevelGiftItemCell:ctor()

	--csb bind var name
	self._alreadyBuy = nil  --ImageView
	self._btnBuy = nil  --CommonButtonSwitchLevel1
	self._icon = nil  --CommonIconTemplate
	self._levelNum1 = nil  --TextAtlas
	self._levelNum2 = nil  --TextAtlas
    self._levelNum3 = nil  --TextAtlas
	self._levelRequireRichNode = nil  --SingleNode
	self._goldGetRichNode = nil --SingleNode
	self._lock = nil  --ImageView
	self._timeCountDown = nil --Text
	self._timeCountDownDes = nil
	if not Lang.checkLang(Lang.CN) then
		self._titleLable = nil -- i18n change lable
	end
	local resource = {
		file = Path.getCSB("LevelGiftItemCell", "activity/levelGift"),
		binding = {
			_btnBuy = {
				events = {{event = "touch", method = "_onBtnBuy"}}
			},
		},
	}
	LevelGiftItemCell.super.ctor(self, resource)
end

function LevelGiftItemCell:onCreate()
	-- i18n change lable
	self:_dealByI18n()
	-- i18n pos lable
	self:_dealPosByI18n()
	-- body
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

	self._btnBuy:setString(Lang.get("common_btn_name_confirm"))

	-- i18n change lable
	self:_createTitleLabelByI18n()
end

function LevelGiftItemCell:_lockState()
	self._lock:setVisible(true)
	self._alreadyBuy:setVisible(false)
	self._timeCountDown:setVisible(false)
	self._timeCountDownDes:setVisible(false)
	local config = self._data:getConfig()
	local richText = Lang.get("lang_activity_level_gift_level_require",
	{
		level = config.unlock_level,
	})
	local widget = ccui.RichText:createWithContent(richText)
	widget:setAnchorPoint(cc.p(0.5, 0.5))
	self._levelRequireRichNode:addChild(widget)

	local vipConfig = self._data:getVipConfig()
	self._btnBuy:setVisible(true)

	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local _,currencyStr1 = UIHelper.convertCurrency( vipConfig.rmb)
		currencyStr1 = UIHelper.convertDollar(currencyStr1)
		self._btnBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = currencyStr1}))
	else
		self._btnBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = vipConfig.rmb}))
	end
	self._btnBuy:setEnabled(false)
end

function LevelGiftItemCell:_alreadyBuyState()
	self._lock:setVisible(false)
	self._timeCountDown:setVisible(false)
	self._timeCountDownDes:setVisible(false)
	self._alreadyBuy:setVisible(true)
	self._timeCountDown:setVisible(false)

	self._btnBuy:setVisible(false)
	self._btnBuy:setEnabled(false)
	-- self._btnBuy:setString(Lang.get("lang_activity_level_gift_btn_alreadyBuy"))
end

function LevelGiftItemCell:_timeoutState()
	self._lock:setVisible(false)
	self._timeCountDown:setVisible(false)
	self._timeCountDownDes:setVisible(false)
	self._alreadyBuy:setVisible(false)
	self._btnBuy:setVisible(true)
	self._btnBuy:setEnabled(false)
	self._btnBuy:setString(Lang.get("lang_activity_level_gift_btn_timeout"))
end


function LevelGiftItemCell:_countDownState()
	self._lock:setVisible(false)
	self._alreadyBuy:setVisible(false)
	self._timeCountDown:setVisible(true)
	self._timeCountDownDes:setVisible(true)
	local action = UIActionHelper.createUpdateAction(function()

		local isTimeOut, limitTime = self._data:isTimeOut()
		if not isTimeOut then
			self._timeCountDown:setString(G_ServerTime:getLeftSecondsString(limitTime, "00:00:00"))
		else
			self:updateUI(self._data)
		end
	end)
	self._timeCountDown:runAction(action)
	local vipConfig = self._data:getVipConfig()
	self._btnBuy:setVisible(true)

	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local _,currencyStr1 = UIHelper.convertCurrency( vipConfig.rmb)
		currencyStr1 = UIHelper.convertDollar(currencyStr1)
		self._btnBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = currencyStr1}))
	else
		self._btnBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = vipConfig.rmb}))
	end


	
	self._btnBuy:setEnabled(true)
end

-- appstore 送审条件下  忽略限制条件
function LevelGiftItemCell:updateAppstoreCheckUI(data)
	if not data then
		return
	end

	self._data = data
	self._timeCountDown:stopAllActions()
	self._levelRequireRichNode:removeAllChildren()
	self:_refreshGetGoldInfo()
	local config = self._data:getConfig()
    if config.unlock_level >= 100 then
        self._levelNum1:setString((config.unlock_level %100)%10)
        self._levelNum2:setString(math.floor((config.unlock_level/10)%10))
        self._levelNum3:setString(math.floor(config.unlock_level/100))
        self._levelNum2:setVisible(true)
        self._levelNum3:setVisible(true)
    elseif config.unlock_level > 10 then
		self._levelNum1:setString(config.unlock_level %10)
		self._levelNum2:setString(math.floor(config.unlock_level /10))
		self._levelNum2:setVisible(true)
	else
		self._levelNum1:setString(config.unlock_level %10)
		self._levelNum2:setVisible(false)
	end
	
	 
	-- i18n change lable
	if not Lang.checkLang(Lang.CN) then
		self._titleLable:setString(Lang.getImgText("level_gift_1",{value = config.unlock_level}))
	end
	self._icon:unInitUI()
	self._icon:initUI(config.type, config.value, config.size)
	self._icon:setTouchEnabled(true)
	local itemParam = self._icon:getItemParams()
	self._textItemName:setString(itemParam.name)
	self._textItemName:setColor(itemParam.icon_color)


	
	if data:getIs_buy() then
		self:_alreadyBuyState()
	else
		self._lock:setVisible(false)
		self._alreadyBuy:setVisible(false)
		self._timeCountDown:setVisible(false)
		self._timeCountDownDes:setVisible(false)
		local vipConfig = self._data:getVipConfig()
		self._btnBuy:setVisible(true)

		if not Lang.checkLang(Lang.CN) then
			local UIHelper  = require("yoka.utils.UIHelper")
			local _,currencyStr1 = UIHelper.convertCurrency( vipConfig.rmb)
			currencyStr1 = UIHelper.convertDollar(currencyStr1)
			self._btnBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = currencyStr1}))
		else
			self._btnBuy:setString(Lang.get("lang_activity_level_gift_btn_buy",{value = vipConfig.rmb}))
		end
		self._btnBuy:setEnabled(true)
	end
end

function LevelGiftItemCell:updateUI(data)
	-- body
	if G_ConfigManager:isAppstore() then
		self:updateAppstoreCheckUI(data)
		return
	end

	if not data then
		return
	end

	self._data = data
	self._timeCountDown:stopAllActions()
	self._levelRequireRichNode:removeAllChildren()
	self:_refreshGetGoldInfo()
	local config = self._data:getConfig()
    if config.unlock_level >= 100 then
        self._levelNum1:setString((config.unlock_level %100)%10)
        self._levelNum2:setString(math.floor((config.unlock_level/10)%10))
        self._levelNum3:setString(math.floor(config.unlock_level/100))
        self._levelNum2:setVisible(true)
        self._levelNum3:setVisible(true)
    elseif config.unlock_level > 10 then
		self._levelNum1:setString(config.unlock_level %10)
		self._levelNum2:setString(math.floor(config.unlock_level /10))
		self._levelNum2:setVisible(true)
        self._levelNum3:setVisible(false)
	else
		self._levelNum1:setString(config.unlock_level %10)
		self._levelNum2:setVisible(false)
        self._levelNum3:setVisible(false)
	end
	-- i18n change lable
	if not Lang.checkLang(Lang.CN) then
		self._titleLable:setString(Lang.getImgText("level_gift_1",{value = config.unlock_level}))
	end
	self._icon:unInitUI()
	self._icon:initUI(config.type, config.value, config.size)
	self._icon:setTouchEnabled(true)
	local itemParam = self._icon:getItemParams()
	self._textItemName:setString(itemParam.name)
	self._textItemName:setColor(itemParam.icon_color)

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

function LevelGiftItemCell:_refreshGetGoldInfo()
	self._goldGetRichNode:removeAllChildren()
	local payCfg = self._data:getVipConfig()
	local richText = Lang.get("lang_activity_level_gift_gold_get_info",
	{
		value = payCfg.gold,
	})
	local widget = ccui.RichText:createWithContent(richText)
	widget:setAnchorPoint(cc.p(0.5, 0.5))
	self._goldGetRichNode:addChild(widget)
	if Lang.checkLang(Lang.ENID) then
		widget:ignoreContentAdaptWithSize(false)
		widget:setContentSize(cc.size(200,0))
		widget:formatText()
	end
end




-- Describle：
function LevelGiftItemCell:_onBtnBuy()
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



-- i18n change lable
function LevelGiftItemCell:_createTitleLabelByI18n()
	if not Lang.checkLang(Lang.CN) then
		local TypeConst = require("app.i18n.utils.TypeConst")
		local UIHelper  = require("yoka.utils.UIHelper")

		local levelTitle = ccui.Helper:seekNodeByName(self, "LevelTitle")
		levelTitle:setVisible(false)
		local parent = levelTitle:getParent()
		--local x,y = levelTitle:getPosition()
		self._titleLable = UIHelper.createLabel({
			style = "luxury_gift_1",
			styleType = TypeConst.TEXT,
			position = cc.p(125,388),
			anchorPoint = cc.p(0.5,0.5),
		})
		parent:addChild(self._titleLable)
	end
end

-- i18n change lable
function LevelGiftItemCell:_dealByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._alreadyBuy= UIHelper.swapSignImage(self._alreadyBuy,
		{ 
			 style = "signet_8", 
			 text = Lang.getImgText("img_yigoumai") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))


	end
end

-- i18n lable pos
function LevelGiftItemCell:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local size = self._resourceNode:getContentSize()
		self._timeCountDownDes:setPositionX(size.width*0.5)

		local label1 = UIHelper.seekNodeByName(self._timeCountDownDes,"Label1")
		local size1 = self._timeCountDown:getContentSize()
		local size2 = label1:getContentSize()
		label1:setPositionX(size1.width*0.5)
		self._timeCountDown:setPositionX(size.width*0.5-size2.width*0.5)

		local label10 = UIHelper.seekNodeByName(self._timeCountDownDes,"Label1_0")
		label10:setPositionX(0)

		if Lang.checkLang(Lang.TH) then
			UIHelper.alignCenter(self._resourceNode,{label1,self._timeCountDown},{0,0})
		end
	end
	if Lang.checkLang(Lang.EN) then
		self._textItemName:setAnchorPoint(0.5,1)
		self._textItemName:setPositionY(self._textItemName:getPositionY()+10)
        self._textItemName:getVirtualRenderer():setMaxLineWidth(200)
		self._textItemName:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
	end
end


return LevelGiftItemCell
