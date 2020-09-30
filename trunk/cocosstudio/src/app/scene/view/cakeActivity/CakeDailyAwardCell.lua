--
-- Author: Liangxu
-- Date: 2019-6-21
-- 蛋糕活动每日奖励Cell
local ListViewCellBase = require("app.ui.ListViewCellBase")
local CakeDailyAwardCell = class("CakeDailyAwardCell", ListViewCellBase)
local CakeActivityDataHelper = require("app.utils.data.CakeActivityDataHelper")
local CakeActivityConst = require("app.const.CakeActivityConst")

function CakeDailyAwardCell:ctor()
	local resource = {
		file = Path.getCSB("CakeDailyAwardCell", "cakeActivity"),
		binding = {
			_button = {
				events = {{event = "touch", method = "_onClick"}}
			},
		}
	}
	CakeDailyAwardCell.super.ctor(self, resource)
end

function CakeDailyAwardCell:onCreate()
	--i18n change lable
	if not Lang.checkLang(Lang.CN) then
		self:_swapImageByI18n()
	end
	self._state = 0
	local size = self._panelBg:getContentSize()
	self:setContentSize(size.width, size.height)
end

function CakeDailyAwardCell:update(data)
	local awards = data.awards
	local strDay = Lang.get("cake_activity_daily_award_day_text", {day = Lang.get("common_days")[data.day]}) 
	local state = data.state
	for i = 1, 5 do
		local award = awards[i]
		if award then
			self["_icon"..i]:setVisible(true)
			self["_icon"..i]:unInitUI()
			self["_icon"..i]:initUI(award.type, award.value, award.size)
		else
			self["_icon"..i]:setVisible(false)
		end
	end

	self._textDay:setString(strDay)

	self._button:setVisible(false)
	self._imageReceived:setVisible(false)
	self._imageTimeOut:setVisible(false)
	if state == CakeActivityConst.DAILY_AWARD_STATE_1 then
		self._imageTimeOut:setVisible(true)
	elseif state == CakeActivityConst.DAILY_AWARD_STATE_2 then
		self._button:setVisible(true)
		self._button:setString(Lang.get("common_receive"))
		self._button:switchToHightLight()
		self._imageLock:setVisible(false)
	elseif state == CakeActivityConst.DAILY_AWARD_STATE_3 then
		self._imageReceived:setVisible(true)
	elseif state == CakeActivityConst.DAILY_AWARD_STATE_4 then
		self._button:setVisible(true)
		self._button:setString("")
		self._button:switchToNormal()
		self._imageLock:setVisible(true)
	elseif state == CakeActivityConst.DAILY_AWARD_STATE_0 then
		G_UserData:getCakeActivity():c2sEnterCakeActivity()
	end
end

function CakeDailyAwardCell:_onClick()
	self:dispatchCustomCallback(1)
end


-- i18n change lable
function CakeDailyAwardCell:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")

		self._imageReceived = UIHelper.swapSignImage(self._imageReceived,
		{ 
			 style = "sign_1", 
			 text = Lang.getImgText("img_seal_yilingqu01") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))


		self._imageTimeOut = UIHelper.swapSignImage(self._imageTimeOut,
		{ 
			 style = "signet_1", 
			 text = Lang.getImgText("img_yichaoshi01") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_red"))
		
	end
end

return CakeDailyAwardCell