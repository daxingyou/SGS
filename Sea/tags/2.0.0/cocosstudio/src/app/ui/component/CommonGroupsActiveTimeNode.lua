--组队活动时间显示控件
local CommonGroupsActiveTimeNode = class("CommonGroupsActiveTimeNode")

local EXPORTED_METHODS = {
    "updateUIOfStatic",
	"updateQinTomb",
}

function CommonGroupsActiveTimeNode:ctor()
	self._target = nil
	self._showPopup = false
end

function CommonGroupsActiveTimeNode:_init()
	self._panelTouch = ccui.Helper:seekNodeByName(self._target, "PanelTouch")
	self._imageClockStatic = ccui.Helper:seekNodeByName(self._target, "ImageClockStatic")
	self._textTimeTitle = ccui.Helper:seekNodeByName(self._target, "TextTimeTitle")
	self._textLeftTime = ccui.Helper:seekNodeByName(self._target, "TextLeftTime")
	self._imageTouch = ccui.Helper:seekNodeByName(self._target, "ImageTouch")
	self._imageTouch:addClickEventListenerEx(handler(self, self._onClick))
	self._imagePopup = ccui.Helper:seekNodeByName(self._target, "ImagePopup")
	self._text1 = ccui.Helper:seekNodeByName(self._target, "Text1")
	self._text2 = ccui.Helper:seekNodeByName(self._target, "Text2")
	self._textTime1 = ccui.Helper:seekNodeByName(self._target, "TextTime1")
	self._textTime2 = ccui.Helper:seekNodeByName(self._target, "TextTime2")
	self._nodeTimeEffect = ccui.Helper:seekNodeByName(self._target, "NodeTimeEffect")


	self._text1:setString(Lang.get("groups_active_time_title"))
	self._text2:setString(Lang.get("groups_assist_time_title"))

	self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
	self._panelTouch:setSwallowTouches(false)
	self._panelTouch:addClickEventListener(handler(self, self._onTouch)) --避免0.5秒间隔

	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		--self._imageTouch:setAnchorPoint(cc.p(0,0.5))
		--self._imageTouch:setAnchorPoint(cc.p(0,0.5))
		self:_dealPosI18n()
	end
end

function CommonGroupsActiveTimeNode:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonGroupsActiveTimeNode:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonGroupsActiveTimeNode:_adjustTouchArea()
	local nodePos = self._target:convertToWorldSpaceAR(cc.p(0,0))
	local size = G_ResolutionManager:getDesignCCSize()
	local posx = size.width/2 - nodePos.x
	local posy = size.height/2 - nodePos.y
	self._panelTouch:setPosition(cc.p(posx, posy))
end

function CommonGroupsActiveTimeNode:updateUIOfStatic()
	self:_adjustTouchArea()

	self._imageClockStatic:loadTexture(Path.getQinTomb("img_qintomb_time01"))

	local leftTime = G_UserData:getBase():getGrave_left_sec()
	local assistLeftTime = G_UserData:getBase():getGrave_assist_sec()
	if leftTime > 0 then
		self._textTimeTitle:setString(Lang.get("groups_active_time_title"))
		local leftTimeStr = G_ServerTime:_secondToString(leftTime)
		self._textLeftTime:setString(leftTimeStr)
	else
		self._textTimeTitle:setString(Lang.get("groups_assist_time_title"))
		local leftTimeStr = G_ServerTime:_secondToString(assistLeftTime)
		self._textLeftTime:setString(leftTimeStr)
	end

	
	if not Lang.checkLang(Lang.CN)  then
		self:_adjustPosI18n()
	end

	self._textTime1:setString(G_ServerTime:_secondToString(leftTime))
	self._textTime2:setString(G_ServerTime:_secondToString(assistLeftTime))

	self._imagePopup:setVisible(self._showPopup)
end

function CommonGroupsActiveTimeNode:_onClick()
	self._showPopup = not self._showPopup
	self._imagePopup:setVisible(self._showPopup)
end

function CommonGroupsActiveTimeNode:_onTouch()
	if self._showPopup then
		self._showPopup = false
		self._imagePopup:setVisible(self._showPopup)
	end
end

--更新秦皇陵
function CommonGroupsActiveTimeNode:updateQinTomb()
	local leftTime = G_UserData:getBase():getGrave_left_sec()
	local assistLeftTime = G_UserData:getBase():getGrave_assist_sec()

	self:updateUIOfStatic()
	if leftTime > 0 then
		self:_updateGraveLeftSec()
	elseif assistLeftTime > 0 then
		self:_updateGraveAssistSec()
	end
	
	
end


function CommonGroupsActiveTimeNode:_updateGraveAssistSec( ... )
	local leftSec = G_UserData:getBase():getGrave_left_sec()
	local beginTime =  G_UserData:getBase():getGrave_begin_time()
	local assistLeftTime = G_UserData:getBase():getGrave_assist_sec()
	local assistBeginTime = G_UserData:getBase():getGrave_assist_begin_time()
	self._textTime2:stopAllActions()
	self._textTime1:stopAllActions()
	local function initUI()
		self._textTimeTitle:setString(Lang.get("groups_assist_time_title"))
		self._nodeTimeEffect:removeAllChildren()
		self._imageClockStatic:loadTexture(Path.getQinTomb("img_qintomb_time03"))
		G_EffectGfxMgr:createPlayGfx(self._nodeTimeEffect, "effect_xianqinhuangling_biaolan", nil ,true)

		if not Lang.checkLang(Lang.CN)  then
			self:_adjustPosI18n()
		end
	end
	--协助时间处理
	if leftSec <=0 and assistLeftTime >0 then
		initUI()
		self:_playAssistLeftSec(self._textLeftTime)
		self:_playAssistLeftSec(self._textTime2)
		return true
	end
	return false
end



function CommonGroupsActiveTimeNode:_updateGraveLeftSec( ... )
	-- body
	self:_adjustTouchArea()

	local leftSec = G_UserData:getBase():getGrave_left_sec()
	local beginTime =  G_UserData:getBase():getGrave_begin_time()
	local assistLeftTime = G_UserData:getBase():getGrave_assist_sec()
	local assistBeginTime = G_UserData:getBase():getGrave_assist_begin_time()
	self._textTime2:stopAllActions()
	self._textTime1:stopAllActions()
	--协助时间处理
	local function initUI()
		self._textTimeTitle:setString(Lang.get("groups_active_time_title"))
		self._nodeTimeEffect:removeAllChildren()
		self._imageClockStatic:loadTexture(Path.getQinTomb("img_qintomb_time02"))
		G_EffectGfxMgr:createPlayGfx(self._nodeTimeEffect, "effect_xianqinhuangling_biao", nil ,true)

		if not Lang.checkLang(Lang.CN)  then
			self:_adjustPosI18n()
		end
	end

	if beginTime > 0 then 
		initUI()
		self:_playGraveLeftSec(self._textLeftTime)
		self:_playGraveLeftSec(self._textTime1)
	end

end


--播放剩余倒计时
function CommonGroupsActiveTimeNode:_playGraveLeftSec(timeNode)

	local leftSec = G_UserData:getBase():getGrave_left_sec()
	local beginTime =  G_UserData:getBase():getGrave_begin_time()
	if beginTime == 0 then --暂停状态
		local endTime = leftSec + G_ServerTime:getTime()
		local leftTimeStr =  G_ServerTime:getLeftSecondsString(endTime, "00:00:00")
		timeNode:stopAllActions()
		timeNode:setString(leftTimeStr)
		return 
	end

	timeNode:setString("00:00:00")
	local UIActionHelper = require("app.utils.UIActionHelper")
	local function timeUpdate()
		local endTime = leftSec + beginTime
		local leftTimeStr =  G_ServerTime:getLeftSecondsString(endTime, "00:00:00")
		local curTime = G_ServerTime:getTime()
		if  curTime > endTime then
			timeNode:stopAllActions()
			G_SignalManager:dispatch(SignalConst.EVENT_GRAVE_TIME_FINISH)
		else
			timeNode:setString(leftTimeStr)
		end
	end
	local action = UIActionHelper.createUpdateAction(function()
		timeUpdate()
	end, 0.5)
	timeNode:runAction(action)
end

--播放协助倒计时
function CommonGroupsActiveTimeNode:_playAssistLeftSec(timeNode)


	local leftSec = G_UserData:getBase():getGrave_assist_sec()
	local beginTime = G_UserData:getBase():getGrave_assist_begin_time()

	if beginTime == 0 then --暂停状态
		local endTime = leftSec + G_ServerTime:getTime()
		local leftTimeStr =  G_ServerTime:getLeftSecondsString(endTime, "00:00:00")
		timeNode:stopAllActions()
		timeNode:setString(leftTimeStr)
		return 
	end

	timeNode:setString("00:00:00")
	local UIActionHelper = require("app.utils.UIActionHelper")
	local function timeUpdate()
		local endTime = leftSec + beginTime
		local leftTimeStr =  G_ServerTime:getLeftSecondsString(endTime, "00:00:00")
		local curTime = G_ServerTime:getTime()
		if  curTime > endTime then
			timeNode:stopAllActions()
			G_SignalManager:dispatch(SignalConst.EVENT_GRAVE_TIME_FINISH)
		else
			timeNode:setString(leftTimeStr)
		end
	end
	local action = UIActionHelper.createUpdateAction(function()
		timeUpdate()
	end, 0.5)
	timeNode:runAction(action)
end


-- i18n pos lable
function CommonGroupsActiveTimeNode:_adjustPosI18n()
	if Lang.checkLang(Lang.TH) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local size = self._imageTouch:getContentSize()
		self._imageTouch:setAnchorPoint(0,0.5)
		self._imageTouch:setPositionX(135)
		local width = self._textTimeTitle:getContentSize().width+185
		self._imageTouch:setContentSize(width,size.height)
		local image1 = UIHelper.seekNodeByName(self._imageTouch,"Image_1")
		image1:setPositionX(width-18)
	elseif not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image1 = UIHelper.seekNodeByName(self._imageTouch,"Image_1")
		local width = self._imageTouch:getContentSize().width 
		local y = width - (width *0.5 - self._textTimeTitle:getContentSize().width-13-16)--_imageTouch旋转了180度，需要镜像下
		image1:setPositionX(y)
	end
end

-- i18n pos lable_dealPosI18n
function CommonGroupsActiveTimeNode:_dealPosI18n()
	if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		local size = self._imagePopup:getContentSize()
		local text1 = UIHelper.seekNodeByName(self._imagePopup,"Text1")
		local text2 = UIHelper.seekNodeByName(self._imagePopup,"Text2")
		local leftPos1 = text1:getPositionX()-text1:getContentSize().width
		local leftPos2 = text2:getPositionX()-text2:getContentSize().width
		local leftPos = math.min(leftPos1,leftPos2)
		if leftPos < 4 then
			local addWidth = 4-leftPos
			self._imagePopup:setContentSize(cc.size(size.width+ addWidth,size.height))
			self._imagePopup:setPositionX( - addWidth * 0.5)

			text1:setPositionX( text1:getPositionX()+addWidth)
			text2:setPositionX( text2:getPositionX()+addWidth)

			self._textTime1:setPositionX( self._textTime1:getPositionX()+addWidth)
			self._textTime2:setPositionX( self._textTime2:getPositionX()+addWidth)
		end
	end
end

return CommonGroupsActiveTimeNode