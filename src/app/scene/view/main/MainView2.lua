local ViewBase = require("app.ui.ViewBase")
local MainView = class("MainView", ViewBase)

local FunctionLevel = require("app.config.function_level")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local AudioConst = require("app.const.AudioConst")
local MainUIHelper = require("app.scene.view.main.MainUIHelper")
local SETTING_NAME = "notice_time"

MainView.DELAY_MUSIC_TIME = 2 -- 音乐延迟时间

function MainView:ctor(sceneId)
	self._playerName = nil -- 玩家名称
	self._playerLevel = nil
	self._playerVip = nil
	self._imageVit = nil
	self._btnChallenge = nil --挑战按钮
	self._nodeMenu = nil
	self._sceneId = sceneId

	self._isNewMusic = false -- 是否播放新音乐
	self._isFirstEnter = true

	local resource = {
		file = Path.getCSB("MainView2", "main"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_imageVit = {
				events = {{event = "touch", method = "_onBtnVit"}}
			}
		}
	}
	self:setName("MainView")

	MainView.super.ctor(self, resource)
end

function MainView:onCreate()
	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	if self._topBarList then
		self._topBarList:updateUI(TopBarStyleConst.STYLE_MAIN, false)
	end
	local UIActionHelper = require("app.utils.UIActionHelper")
	UIActionHelper.playBlinkEffect(self._imageVit)

	-- G_GameAgent:getRealNameState()
	-- local isAvoid = G_ConfigManager:isAvoidHooked()
end

function MainView:onEnter()
	G_GameAgent:checkReturnEvent()
	
	if not G_GameAgent:isRealName() then
		G_GameAgent:getRealNameState(
			function()
				G_UserData:getBase():checkRealName()
			end
		)
	end

	local TopBarStyleConst = require("app.const.TopBarStyleConst")
    if self._topBarList then
        local FunctionCheck = require("app.utils.logic.FunctionCheck")
        local isOpen = FunctionCheck.funcIsOpened(FunctionConst.FUNC_JADE2)
        local topbarConst = isOpen and TopBarStyleConst.STYLE_MAIN2 or TopBarStyleConst.STYLE_MAIN
		self._topBarList:updateUI(topbarConst, false)
	end
    G_AudioManager:openMainMusic(true)

	local mainLayer = self._nodeMenu:getChildByName("MainMenuLayer")
	if mainLayer == nil then
		local mainLayer = require("app.scene.view.main.MainMenuLayer2").new(handler(self,self._showMainUI))
		mainLayer:setName("MainMenuLayer")
		self._nodeMenu:addChild(mainLayer)
	end

	if mainLayer and mainLayer.updateAll then
	--	mainLayer:updateAll()
	end

	-- local mainAvatorsNode = self:getEffectLayer(ViewBase.Z_ORDER_GRD_BACK + 1):getChildByName("MainAvatorsNode")
	-- if mainAvatorsNode == nil then
	-- 	local mainAvatorsNode = require("app.scene.view.main.MainAvatorsNode").new()
	-- 	mainAvatorsNode:setName("MainAvatorsNode")
	-- 	self:getEffectLayer(ViewBase.Z_ORDER_GRD_BACK + 1):addChild(mainAvatorsNode)
	-- end

	self._signalActDinnerResignin =
		G_SignalManager:add(SignalConst.EVENT_ACT_DINNER_RESIGNIN, handler(self, self._onSignalActDinnerResignin))
	self._signalSwitchAvatar =
		G_SignalManager:add(SignalConst.EVENT_SWITCH_AVATAR, handler(self, self._onSignalSwitchAvatar))
	self._signalSwitchScene =
		G_SignalManager:add(SignalConst.EVENT_SWITCH_SCENE, handler(self, self._onSignalSwitchScene))

	self:_refreshResignVit()

	-- local currSceneId = MainUIHelper.getCurrShowSceneId()
	local currSceneId = G_UserData:getMainScene():getSceneId()
	self:_updateScene(currSceneId)


	--抛出新手事件
	G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)

	-- local function testacc(event, x, y, z, timestamp)
	--     print("1112233 acc", event, x, y, z, timestamp)
	-- end
	-- self:addAccelerationEvent

	-- -- 创建一个重力加速计事件监听器
	-- local layer = cc.Layer:create()
	-- self:addChild(layer)
	-- layer:setAccelerometerEnabled(true)
	-- local function testacc(event, x, y, z, timestamp)
	--     print("1112233 acc", event, x, y, z, timestamp)
	-- end
	-- local listerner  = cc.EventListenerAcceleration:create(testacc)
	-- -- 获取事件派发器然后设置触摸绑定到精灵，优先级为默认的0
	-- layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listerner, self)

	self:_showStoryAvatar()
	if self._sceneId then
		self:_showMainUI(false)
		self._sceneId = nil
	end
	self:_showPopupNotice()
end

-- i18n ja change 
function MainView:onEnterTransitionFinish()
	if Lang.checkUI("ui4") then
		local LevelPkgConst = require("app.const.LevelPkgConst")
		G_SignalManager:dispatch(SignalConst.EVENT_NEW_LEVEL_PKG_OPEN_NOTICE,nil)
	end
end

function MainView:onExit()
	self._signalActDinnerResignin:remove()
	self._signalActDinnerResignin = nil
	self._signalSwitchAvatar:remove()
	self._signalSwitchAvatar = nil
	self._signalSwitchScene:remove()
	self._signalSwitchScene = nil
end

-- -- 切换背景音乐
-- function MainView:_changeMusic()
-- 	self._isNewMusic = not self._isNewMusic
-- 	local musicId = self._isNewMusic and AudioConst.MUSIC_BGM_NEW_CITY or AudioConst.MUSIC_CITY
-- 	G_AudioManager:playMusicWithId(musicId)
-- end

function MainView:_onSignalActDinnerResignin(eventName, miss)
	self:_refreshResignVit(miss)
end

function MainView:_refreshResignVit(miss)
	local missDinner = miss or G_UserData:getActivityDinner():hasMissEatDinner()
	self._imageVit:setVisible(missDinner)
end

--
function MainView:isRootScene()
	return true
end

function MainView:_onBtnVit()
	local UIPopupHelper = require("app.utils.UIPopupHelper")
	UIPopupHelper.popupResigninUI()
end

function MainView:_showMainUI(bShow)
	self._nodeMenu:setVisible(bShow)
	self._topBarList:setVisible(bShow)
	if not bShow then
		local switchAvatarLayer = require("app.scene.view.main.SwitchAvatarLayer").new(handler(self,self._showMainUI),self._sceneId)
		self:addChild(switchAvatarLayer,100)
	end

	local storyAvatarNode = self:getEffectLayer(ViewBase.Z_ORDER_GRD_BACK + 1):getChildByName("StoryAvatarNode")
	if storyAvatarNode then
		storyAvatarNode:moveAction(bShow)
	end
end

function MainView:_showStoryAvatar()
	local storyAvatarNode = self:getEffectLayer(ViewBase.Z_ORDER_GRD_BACK + 1):getChildByName("StoryAvatarNode")
	if storyAvatarNode == nil then
		local StoryAvatarNode = require("app.scene.view.main.StoryAvatarNode")
		local storyAvatarNode = StoryAvatarNode.new()
		self:getEffectLayer(ViewBase.Z_ORDER_GRD_BACK + 1):addChild(storyAvatarNode)
	else
		storyAvatarNode:updateUI()
	end
end

function MainView:_onSignalSwitchAvatar(_, param)
	local storyAvatarNode = self:getEffectLayer(ViewBase.Z_ORDER_GRD_BACK + 1):getChildByName("StoryAvatarNode")
	if storyAvatarNode then
		storyAvatarNode:updateUI(param)
		storyAvatarNode:playTalk()
	end
end
function MainView:_onSignalSwitchScene(_, param)
	local id = param.id
	local dayNight = param.dayNight
	self:_updateScene(id,dayNight)
end
function MainView:_updateScene(sceneId,dayNight)
	logWarn("MainView change sceneid " .. tostring(sceneId))
	local showSceneId = MainUIHelper.getShowSceneByMainSceneId(sceneId,dayNight)
	if self._currSceneId ~= showSceneId then
		self._currSceneId = showSceneId
		self:updateSceneId(showSceneId)
	end
end

function MainView:_getNoticeTime()
	local settingData = G_StorageManager:loadUser(SETTING_NAME) or {}
	local noticeTime = settingData.noticeTime or 0
    return checkint(noticeTime)
end

function MainView:_saveNoticeTime()
	local message = {noticeTime = G_ServerTime:getTime()}
	G_StorageManager:saveWithUser(SETTING_NAME, message)
end

--首次进入弹公告
function MainView:_showPopupNotice()
	if self._isFirstEnter then
		self._isFirstEnter = false
		if ccexp.WebView then
			local isNotTutorial = not G_TutorialManager:isDoingStep()
			local FunctionCheck = require("app.utils.logic.FunctionCheck")
			local isOpen = FunctionCheck.funcIsOpened(FunctionConst.FUNC_NOTICE)
			local noticeTime = self:_getNoticeTime()
			local currTime = G_ServerTime:getTime()
			local noticeZeroTime = G_ServerTime:secondsFromZero(noticeTime)
			local currZeroTime = G_ServerTime:secondsFromZero(currTime)
			local day = math.floor( (currZeroTime - noticeZeroTime) / (3600*24) )
			local isNewDay = day >= 1
			if isNotTutorial and isOpen and isNewDay then
				local url = G_ConfigManager:getPopupUrlI18n()
				if url ~= nil and url ~= "" then
					local PopupNotice = require("app.ui.PopupNotice")
					PopupNotice:create(url, nil)
					self:_saveNoticeTime()
				end
			end
		end
	end
end

return MainView
