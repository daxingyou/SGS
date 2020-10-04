local CommonButton = import(".CommonButton")
local CommonButtonCountDown = class("CommonButtonCountDown", CommonButton)

CommonButtonCountDown.EXPORTED_METHODS = {
    "addClickEventListenerEx",
	"addTouchEventListenerEx",
    "setString",
    "showRedPoint",
    "setEnabled",
	"isEnabled",
	"setButtonTag",
	"setButtonName",
    "setWidth",
	"setTouchEnabled",
	"setSwallowTouches",
	"loadTexture",
	"getDesc",
	"addClickEventListenerExDelay",
	"setFontSize",
	"startCountDown",
}


function CommonButtonCountDown:ctor()
	CommonButtonCountDown.super.ctor(self)
end

function CommonButtonCountDown:_init()
    CommonButtonCountDown.super._init(self)

	self._countdownTime = ccui.Helper:seekNodeByName(self._target, "TextCountDown")
	self._timeNode = ccui.Helper:seekNodeByName(self._target, "TimeNode")
	self._timeNode:setVisible(false)

	-- i18n pos lable
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
			
		self._button = ccui.Helper:seekNodeByName(self._target, "Button")
		self._text = ccui.Helper:seekNodeByName(self._target, "Text")
	
	end
end

function CommonButtonCountDown._defaultFormatTime (time)
	return G_ServerTime:getLeftSecondsString(time, "00:00:00")
end

-- i18n pos lable 新增参数 isAlign
function CommonButtonCountDown:startCountDown(endTime, endCallback, timeFormatFunc,isAlign)

    self._endTime = endTime
	self._endCallback = endCallback
	self._formatTimeFunc = timeFormatFunc
	if not self._formatTimeFunc then
		self._formatTimeFunc = CommonButtonCountDown._defaultFormatTime
	end

	self._countdownTime:setVisible(true)
    self._countdownTime:stopAllActions()

	self._countdownTime:setString(self._formatTimeFunc(self._endTime))

	if not Lang.checkLang(Lang.CN) and isAlign then
		local UIHelper  = require("yoka.utils.UIHelper")	
		UIHelper.alignCenter(self._button,{self._text,self._countdownTime})
	end
	
	local curTime = G_ServerTime:getTime()
	if curTime <= self._endTime then
		local UIActionHelper = require("app.utils.UIActionHelper")
		local action = UIActionHelper.createUpdateAction(function()
			self:_timeUpdae()

			if not Lang.checkLang(Lang.CN) and isAlign then
				local UIHelper  = require("yoka.utils.UIHelper")	
				UIHelper.alignCenter(self._button,{self._text,self._countdownTime})
			end

		end, 0.5)
		self._countdownTime:runAction(action)
	else
		self:_CallEnd()
	end
end

function CommonButtonCountDown:_timeUpdae()
	local curTime = G_ServerTime:getTime()
	if  curTime > self._endTime then
		self._countdownTime:stopAllActions()
		self:_CallEnd()
	else
		self._countdownTime:setString(self._formatTimeFunc(self._endTime))
	end
end

function CommonButtonCountDown:_CallEnd()
	if self._endCallback then
		self._endCallback()
	end
end


return CommonButtonCountDown
