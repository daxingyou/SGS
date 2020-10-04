--玩家信息弹框

local PopupBase = require("app.ui.PopupBase")
local PopupPlayerDetail = class("PopupPlayerDetail", PopupBase)
local Path = require("app.utils.Path")
local MailConst = require("app.const.MailConst")
local DataConst = require("app.const.DataConst")
local PopupHonorTitleHelper = require("app.scene.view.playerDetail.PopupHonorTitleHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local PopupPlayerSoundSlider = require("app.scene.view.playerDetail.PopupPlayerSoundSlider")
local PopUpPlayerFrame = require("app.scene.view.playerDetail.PopUpPlayerFrame")

local Path = require("app.utils.Path")
local USER_SETTING = "userSetting"

function PopupPlayerDetail:ctor(title, callback)
	--
	self._title = title or Lang.get("player_detail_title")
	self._callback = callback
	self._commonHeroIcon = nil --玩家头像
	self._textPlayerLevel = nil --玩家等级
	self._commonVipNode = nil --VIP等级
	self._textPlayerName = nil --玩家名称
	self._btnModifyName = nil --修改名称按钮
	self._btnSwitchAccount = nil --切换账号
	self._btnGameAnnounce = nil --玩家公告
	self._btnGameMaker = nil --制作人员
	self._btnGameReward = nil --礼品码
	self._textPlayerId = nil --玩家编号
	self._textServerName = nil --服务器名称
	self._imageMidBk = nil --中间背景图
	self._resRecover1 = nil --回复资源1
	self._resRecover2 = nil --回复资源2
	self._resRecover3 = nil --回复资源3
	self._loadingbarProcess = nil --进度条
	self._textExp = nil --进度条经验值
	self._checkBox1 = nil --选中框
	self._checkBox2 = nil
	self._checkBox3 = nil
	self._sliderMic = nil
	self._sliderSpeaker = nil
	self._textMic = nil
	self._textSpeaker = nil
	self._textMicValue = nil
	self._textSpeakerValue = nil
	self._btnChangeTitle = nil --修改称号按钮
	self._titleImage = nil -- 称号图片
	self._titleTipText = nil
	self._redPoint = nil
	self._btnFrame = nil
	---

	self._vitCountKey = nil --体力恢复倒数key
	self._spirteCountKey = nil --精力恢复倒数key
	self._intervalTime = 0
	self._restoreTime = {}
	self._refreshHandler = nil
	self._commonVipNode = nil

	for i = 1, 3 do
		self._restoreTime[i] = 0
	end

	local resource = {
		file = Path.getCSB("PopupPlayerDetail", "playerDetail"),
		binding = {
			_btnModifyName = {
				events = {{event = "touch", method = "onBtnModifyName"}}
			},
			_btnGameReward = {
				events = {{event = "touch", method = "_onBtnGiftCode"}}
			},
			_btnSwitchAccount = {
				events = {{event = "touch", method = "_onSwidthAccount"}}
			},
			_btnGameAnnounce = {
				events = {{event = "touch", method = "_onGameAnnounce"}}
			},
			_btnGameMaker = {
				events = {{event = "touch", method = "_onGameMaker"}}
			},
			_btnBind = {
				events = {{event = "touch", method = "_onClickBtnBind"}}
			},
			_btnChangeTitle = {
				events = {{event = "touch", method = "_onClickChangeTitle"}} -- 修改称号
			},
			_btnFrame = {
				events = {{event = "touch", method = "_onClickBtnFrame"}}
			}
		}
	}
	PopupPlayerDetail.super.ctor(self, resource, true)
end

--
function PopupPlayerDetail:onCreate()
	--i18n change function show
	if Lang.checkChannel(Lang.CHANNEL_SEA) then
		-- self._btnFrame:setVisible(false)
	end
	self:_initSound()
	-- i18n add btn
	self:_addBtnsByI18n()
	-- i18n change lable
	self:_swapImageByI18n()
	-- i18n pos lable
	self:_dealPosByI18n()
	-- i18n copy id
	self:_dealAddCopyIdByI18n()
	self._commonNodeBk:addCloseEventListener(handler(self, self.onBtnCancel))
	self._commonNodeBk:setTitle(self._title)
	self._settingTitle:setFontSize(30)
	self._settingTitle:setTitleAndAdjustBgSize(Lang.get("system_setting_title"))
	self._settingTitle:showTextBg(false)
	self:_onLoadSetting()
	self:_updatePlayerInfo()

	self._btnFrame:setTitleText(Lang.get("change_role_frame"))
	-- self._btnFrameTxt:setString(Lang.get("change_role_frame"))
	-- self._btnFrame:setVisible(false)

	self:_initMicTest()
	self:_initTitle()
end

function PopupPlayerDetail:_onClickBtnFrame()
	local popup = PopUpPlayerFrame.new()
	popup:openWithAction()
end

function PopupPlayerDetail:_initSound()
	local function updateSound(_control, _name)
		local soundControl = PopupPlayerSoundSlider.new(_control)
		local volume = G_UserData:getUserSetting():getSettingValue(_name) or 1
		soundControl:updateUI(volume * 100)
		G_UserData:getUserSetting():updateMusic()

		soundControl:setCallBack(
			function(_value, _event)
				if _event == "on" then
					if _name == "mus_volume" then
						if _value > 0 then
							G_AudioManager:setMusicEnabled(true)
						end
						G_AudioManager:setMusicVolume(_value / 100)
					elseif _name == "sou_volume" then
						if _value > 0 then
							G_AudioManager:setSoundEnabled(true)
						end
						G_AudioManager:setSoundVolume(_value / 100)
					end
				elseif _event == "up" then
					local index = _value > 0 and 1 or 0
					if _name == "mus_volume" then
						G_UserData:getUserSetting():setSettingValue("musicEnabled", index)
					elseif _name == "sou_volume" then
						G_UserData:getUserSetting():setSettingValue("soundEnabled", index)
					end
					G_UserData:getUserSetting():setSettingValue(_name, _value / 100)
					G_UserData:getUserSetting():updateMusic()
				end
			end
		)
	end

	updateSound(self._bgSlider, "mus_volume")
	updateSound(self._effectSlider, "sou_volume")
end

-- 初始化称号信息
function PopupPlayerDetail:_initTitle()
	self._btnChangeTitle:setTitleText(Lang.get("honor_title_title_btn"))
	self:_changeTitle()

	local FunctionCheck = require("app.utils.logic.FunctionCheck")
	local FunctionConst = require("app.const.FunctionConst")
	local isOpen = FunctionCheck.funcIsOpened(FunctionConst.FUNC_TITLE)
	self._btnChangeTitle:setVisible(isOpen)
	if not isOpen then
		self._titleImage:setVisible(false)
		self._titleTipText:setVisible(false)
	end

	-- i18n pos lable
	if not Lang.checkLang(Lang.CN) then
		self:_adjustPosByI18n()
	end
end

-- 改变称号
function PopupPlayerDetail:_changeTitle()
	local titleItem = PopupHonorTitleHelper.getEquipedTitle() -- 获取已经装备的称号
	local titleId = titleItem and titleItem:getId() or 0
	UserDataHelper.appendNodeTitle(self._titleImage, titleId, self.__cname)
	self._titleTipText:setVisible(titleId == 0)
end

--
function PopupPlayerDetail:_initMicTest()
	if APP_DEVELOP_MODE then
		self._sliderMic:addEventListener(handler(self, self.onMicSlider))
		self._sliderSpeaker:addEventListener(handler(self, self.onSpeakerSlider))

		local mic_volume = G_UserData:getUserSetting():getSettingValue("mic_volume") or 0
		local speaker_volume = G_UserData:getUserSetting():getSettingValue("speaker_volume") or 0
		self._sliderMic:setPercent(mic_volume / 8)
		self._textMicValue:setString(mic_volume)
		self._sliderSpeaker:setPercent(speaker_volume / 8)
		self._textSpeakerValue:setString(speaker_volume)
	else
		self._sliderMic:setVisible(false)
		self._sliderSpeaker:setVisible(false)
		self._textMic:setVisible(false)
		self._textSpeaker:setVisible(false)
		self._textMicValue:setVisible(false)
		self._textSpeakerValue:setVisible(false)
	end
end

--
function PopupPlayerDetail:onMicSlider(sender, event)
	local value = checkint(self._sliderMic:getPercent() * 8)
	if event == ccui.SliderEventType.percentChanged then
		self._textMicValue:setString(value)
	elseif event == ccui.SliderEventType.slideBallUp then
		G_VoiceAgent:setMicVolume(value)
		G_UserData:getUserSetting():setSettingValue("mic_volume", value)
	end
end

--
function PopupPlayerDetail:onSpeakerSlider(sender, event)
	local value = checkint(self._sliderSpeaker:getPercent() * 8)
	if event == ccui.SliderEventType.percentChanged then
		self._textSpeakerValue:setString(value)
	elseif event == ccui.SliderEventType.slideBallUp then
		G_VoiceAgent:setSpeakerVolume(value)
		G_UserData:getUserSetting():setSettingValue("speaker_volume", value)
	end
end

function PopupPlayerDetail:_onLoadSetting()
	local checkList = {}
	checkList[1] = G_UserData:getUserSetting():getSettingValue("musicEnabled")
	checkList[2] = G_UserData:getUserSetting():getSettingValue("soundEnabled")
	checkList[3] = G_UserData:getUserSetting():getSettingValue("gfxEnabled")

	for i = 1, 3 do
		local checkWidget = self["_checkBox" .. i]
		local checkValue = checkList[i] or 0

		if checkValue == 1 then
			checkWidget:setSelected(true)
		else
			checkWidget:setSelected(false)
		end
	end
end

--玩家等级上限处理逻辑
function PopupPlayerDetail:prcoLimitLevel(...)
	-- body
	local nowDay = G_UserData:getBase():getOpenServerDayNum()

	local UserCheck = require("app.utils.logic.UserCheck")
	local ParameterIDConst = require("app.const.ParameterIDConst")
	local paramMax = require("app.config.parameter").get(ParameterIDConst.PLAYER_DETAIL_LEVEL_MAX).content

	local nextPendStr = " "
	local currLevelStar = " "

	if nowDay < tonumber(paramMax) then
		self._levelLimit:setString(currLevelStar)
		self._levelLimitDesc:setString(nextPendStr)
		self._nodeLevelLimit:setVisible(false)
		return
	end
	self._nodeLevelLimit:setVisible(true)
	local paramContent = require("app.config.parameter").get(ParameterIDConst.PLAYER_DETAIL_LEVEL_LIMIT).content
	local valueList = string.split(paramContent, ",")

	for i, value in ipairs(valueList) do
		local day, level = unpack(string.split(value, "|"))
		local currLevel = tonumber(level)
		local currDay = tonumber(day)
		if UserCheck.enoughOpenDay(currDay) then
			currLevelStar = Lang.get("common_player_detail_level_limit", {num = currLevel})
		else
			nextPendStr = Lang.get("common_player_detail_level_limit1", {level = currLevel, day = currDay - nowDay})
		end
	end

	self._levelLimit:setString(currLevelStar)
	self._levelLimitDesc:setString(nextPendStr)

end

--顶部玩家信息更新
function PopupPlayerDetail:_updatePlayerInfo()
	local baseData = G_UserData:getBase()

	self._textPlayerLevel:setString(tostring(baseData:getLevel()))
	self._textPlayerName:setString(baseData:getName())
	local hexstr = string.format("%x", baseData:getId())
	self._textPlayerId:setString(hexstr)
	if Lang.checkChannel(Lang.CHANNEL_SEA) then
		local posX = self._textPlayerId:getPositionX()
		local width = self._textPlayerId:getContentSize().width
		self._btnCopy:setPositionX(posX+width+5)
	end
	--玩家经验
	local currExp = G_UserData:getBase():getExp()
	local level = G_UserData:getBase():getLevel()
	if level == 0 then
		return
	end

	local roleConfig = require("app.config.role").get(level)
	assert(roleConfig, "can not find role Config by level is " .. level)

	local levelUpExp = roleConfig.exp
	self._textExp:setString(currExp .. "/" .. levelUpExp)
	local percent = math.ceil(currExp / levelUpExp * 100)
	if percent > 100 then
		percent = 100
	end

	self:prcoLimitLevel()
	self._loadingbarProcess:setPercent(percent)

	--vip等级
	local vipLevel = G_UserData:getVip():getLevel()
	self._commonVipNode:setVip(vipLevel)
	--serverId
	--local serverId = G_ServerListManager:getServer()
	local serverName = G_UserData:getBase():getServer_name()
	self._textServerName:setString(serverName)

	self._btnSwitchAccount:setString(Lang.get("system_setting_switch_acount"))
	self._btnGameAnnounce:setString(Lang.get("system_setting_game_announce"))
	self._btnGameMaker:setString(Lang.get("system_setting_game_marker"))
	self._btnGameReward:setString(Lang.get("system_setting_game_reward"))
	self._btnBind:setString(Lang.get("system_setting_bind"))

	self:_updateRecoverInfo(1)
	self:_updateRecoverInfo(2)
	self:_updateRecoverInfo(3)

	local officialInfo, officialLevel = G_UserData:getBase():getOfficialInfo()
	if officialLevel == 0 then
		self:updateImageView("Image_player_title", {visible = false})
	else
		self:updateImageView("Image_player_title", {texture = Path.getTextHero(officialInfo.picture), visible = true})
	end
	--[[
	local baseId = G_UserData:getBase():getPlayerBaseId()
	if G_UserData:getBase():isEquipAvatar() then
		local avatarBaseId = G_UserData:getBase():getAvatar_base_id()
		baseId = require("app.utils.data.AvatarDataHelper").getAvatarConfig(avatarBaseId).hero_id
	end
	self._commonHeroIcon:updateUI(baseId)
]]
	self._commonHeroIcon:updateIcon(G_UserData:getBase():getPlayerShowInfo(), nil, G_UserData:getHeadFrame():getCurrentFrame():getId())
	--self._commonHeroIcon:updateHeadFrame(G_UserData:getHeadFrame():getCurrentFrame())
	--self._commonHeadFrame:updateIcon(G_UserData:getHeadFrame():getCurrentFrame(),self._commonHeroIcon:getScale())


	self._textPlayerName:setColor(Colors.getOfficialColor(officialLevel))

	for i = 1, 3 do
		local checkBox = self["_checkBox" .. i]
		checkBox:setTag(i)
		checkBox:addEventListener(handler(self, self._onCheckBoxClick))
	end
end

function PopupPlayerDetail:_onCheckBoxClick(sender)
	local index = sender:isSelected() and 1 or 0

	if sender:getName() == "_checkBox1" then
		local index = sender:isSelected() and 1 or 0
		G_UserData:getUserSetting():setSettingValue("musicEnabled", index)
	end
	if sender:getName() == "_checkBox2" then
		local index = sender:isSelected() and 1 or 0
		G_UserData:getUserSetting():setSettingValue("soundEnabled", index)
	end
	if sender:getName() == "_checkBox3" then
		local index = sender:isSelected() and 1 or 0
		G_UserData:getUserSetting():setSettingValue("gfxEnabled", index)
	end

	G_UserData:getUserSetting():updateMusic()
	--G_NetworkManager:send(MessageIDConst.ID_C2S_SystemSet, message)
end

--更新回复信息
function PopupPlayerDetail:_updateRecoverInfo(index)
	local unitIds = {1, 2, 4}
	local unitInfo = G_RecoverMgr:getRecoverUnit(unitIds[index])
	local serverTime = G_ServerTime:getTime()
	local resId = unitInfo:getResId()
	local recoverCfg = unitInfo:getConfig()

	--[[
	local currValue = G_UserData:getBase():getResValue(resId)
	local recoverCfg = unitInfo:getConfig()
	local needRestore = unitInfo:getMaxLimit() - currValue
	needRestore = needRestore >= 0 and needRestore or 0

	dump(recoverCfg)
	if needRestore > 0 then
		if self._restoreTime[index] == 0 then
			self._restoreTime[index] = recoverCfg.recover_time
		end
	else
		self._restoreTime[index] = 0
	end

	local restoreFullTime =  self._restoreTime[index] + (needRestore - 1) / recoverCfg.recover_num * recoverCfg.recover_time
	restoreFullTime = restoreFullTime >= 0 and restoreFullTime or 0

	local UIHelper = require("yoka.utils.UIHelper")
	local serverTime = G_ServerTime:getTime()
	local currentHour = os.date("%H", serverTime)
	local currentMinute = os.date("%M", serverTime)
	local currentSeconed = os.date("%S", serverTime)
	local totalSeconds = currentHour * 3600 + currentMinute * 60 + currentSeconed
	local blankSeconds = 24 * 3600 - totalSeconds 		--还差多少秒到达第二天
	local totalRestoreDesc = nil ---全部恢复的描述，要根据今天还是明天，做差异化
	local totalTimeStr = nil
	if blankSeconds - restoreFullTime >= 0 then
		totalTimeStr = UIHelper.fromatHHMMSS(restoreFullTime + totalSeconds)
		totalTimeStr = string.sub(totalTimeStr, 1, -4)
		totalRestoreDesc = Lang.get("player_detail_today", {value = totalTimeStr})
	else
		local tomorrowSeconds = restoreFullTime - blankSeconds
		totalTimeStr = UIHelper.fromatHHMMSS(tomorrowSeconds)
		totalTimeStr = string.sub(totalTimeStr, 1, -4)
		totalRestoreDesc = Lang.get("player_detail_tomorrow", {value = totalTimeStr})
	end
]]
	local recoverWidget = self["_resRecover" .. index]
	recoverWidget:updateLabel("Text_titile", Lang.get("player_detail_restore_desc", {value = recoverCfg.name}))

	--[[
	recoverWidget:updateLabel("Text_value",  {
		text = restoreFullTime == 0 and Lang.get("player_detail_restore_full") or totalRestoreDesc,
		color = restoreFullTime == 0 and Colors.COLOR_POPUP_ADD_PROPERTY or Colors.COLOR_POPUP_DESC_NOTE
	})
]]
	local miniIcon = Path.getCommonIcon("resourcemini", resId)

	recoverWidget:updateImageView("Image_icon", {texture = miniIcon})

	self:_updateRecoverTime(index)
end

function PopupPlayerDetail:_updateRecoverTime(index)
	local unitIds = {1, 2, 4}
	local unitInfo = G_RecoverMgr:getRecoverUnit(unitIds[index])
	local currValue = G_UserData:getBase():getResValue(unitInfo:getResId())
	local recoverCfg = unitInfo:getConfig()
	local needRestore = unitInfo:getMaxLimit() - currValue
	needRestore = needRestore >= 0 and needRestore or 0

	local restoreFullTime = 0
	local totalRestoreDesc = ""
	if needRestore > 0 then
		local time1 = UserDataHelper.getRefreshTime(unitInfo:getResId())
		--logWarn("xxxxxxxxxxxxxxxxx "..time1.."   "..G_ServerTime:getTime())
		--local time = ( time1- G_ServerTime:getTime() ) % recoverCfg.recover_time
		--restoreFullTime  =  time + (needRestore - 1) / recoverCfg.recover_num * recoverCfg.recover_time
		restoreFullTime = time1 - G_ServerTime:getTime()
		totalRestoreDesc = G_ServerTime:_secondToString(restoreFullTime)
		if Lang.checkChannel(Lang.CHANNEL_SEA ) then
			totalRestoreDesc = G_ServerTime:secondToHourAndMinuteString(restoreFullTime)
		end
	end
	local recoverWidget = self["_resRecover" .. index]
	recoverWidget:updateLabel(
		"Text_value",
		{
			text = restoreFullTime == 0 and Lang.get("player_detail_restore_full") or totalRestoreDesc,
			color = restoreFullTime == 0 and Colors.COLOR_POPUP_ADD_PROPERTY or Colors.COLOR_POPUP_DESC_NOTE
		}
	)

	if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
		local UIHelper  = require("yoka.utils.UIHelper")
		for i = 1,3,1 do
			local node = self["_resRecover"..i]
			local image_icon = UIHelper.seekNodeByName(node,"Image_icon")
			local text_titile = UIHelper.seekNodeByName(node,"Text_titile")
			local text_value = UIHelper.seekNodeByName(node,"Text_value")
			UIHelper.alignRight({image_icon,text_titile,text_value},{5,5,0})
		end
	end
end

--点击领取按钮
function PopupPlayerDetail:_onItemTouch(index, postIndex)
	local itemIndex = postIndex
	local mailInfo = self._dataList[itemIndex]
	if mailInfo then
		local message = {
			id  =  mailInfo.id
		}
		G_NetworkManager:send(MessageIDConst.ID_C2S_ProcessMail, message)
	end
end

function PopupPlayerDetail:_onItemUpdate(item, index)
	local mailInfo = self._dataList[index + 1]
	if mailInfo then
		item:updateUI(index,mailInfo)
	end
end

function PopupPlayerDetail:_onItemSelected()
end

function PopupPlayerDetail:_onInit()
end

function PopupPlayerDetail:onEnter()
	self:scheduleUpdateWithPriorityLua(handler(self,self._onUpdate),0)

	-- 监听user数据更新
	self._signalUserDataUpdate =
		G_SignalManager:add(SignalConst.EVENT_RECV_ROLE_INFO, handler(self, self._onUserDataUpdate))

	self._signalEquipTitle = G_SignalManager:add(SignalConst.EVENT_EQUIP_TITLE, handler(self, self._onEventTitleChange)) -- 称号装备
	self._signalUnloadTitle = G_SignalManager:add(SignalConst.EVENT_UNLOAD_TITLE, handler(self, self._onEventTitleChange)) -- 称号卸下
	self._signalRedPoint = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self, self._onEventRedUpdate))
    self._signalUpdateTitleInfo =
		G_SignalManager:add(SignalConst.EVENT_UPDATE_TITLE_INFO, handler(self, self._onEventTitleChange)) -- 称号更新
	self:_formatBtns()

	-- 是否打开礼品码
	if G_ConfigManager:isGiftcode() == false then
		self._btnGameReward:setVisible(false)
	end
	if G_ConfigManager:isAppstore() then
		self._btnBind:setVisible(false)
		self._btnGameReward:setVisible(false)
		self._btnGameMaker:setVisible(false)
	end
	self._btnGameMaker:setVisible(false)
	self:_resetRedPoint()
	self:_resetHeadFramePoint()
	
	-- i18n change kr
	self._signalSDKGuest = G_SignalManager:add(SignalConst.EVENT_SDK_BINDGUEST, handler(self, self._onBindGuestResult))
	self:switchAcountBtnUpdate()
end

function PopupPlayerDetail:onExit()
	self:unscheduleUpdate()
	self._signalUserDataUpdate:remove()
	self._signalUserDataUpdate = nil
	self._signalSDKGuest:remove()
	self._signalSDKGuest = nil
	self._signalEquipTitle:remove()
	self._signalEquipTitle = nil
	self._signalUnloadTitle:remove()
	self._signalUnloadTitle = nil
	self._signalRedPoint:remove()
	self._signalRedPoint = nil
	self._signalUpdateTitleInfo:remove()
	self._signalUpdateTitleInfo=nil
end

function PopupPlayerDetail:_onUpdate(dt)
	self._intervalTime = self._intervalTime + dt
	if self._intervalTime >= 1 then
		self:_updateRecoverTime(1)
		self:_updateRecoverTime(2)
		self:_updateRecoverTime(3)
		self._intervalTime = 0
	end
end

function PopupPlayerDetail:_onEventRedUpdate()
	self:_resetRedPoint()
	self:_resetHeadFramePoint()
end

function PopupPlayerDetail:_resetRedPoint()
	local hasRed = G_UserData:getTitles():isHasRedPoint()
	self._redPoint:setVisible(hasRed)
end

function PopupPlayerDetail:_resetHeadFramePoint( )
	local frameRed = G_UserData:getHeadFrame():hasRedPoint()
	self._redPointFrame:setVisible(frameRed)
end



function PopupPlayerDetail:_updateListView()
	local listView = self._listView
	--获得奖励邮件数据列表
	self._dataList = G_UserData:getMails():getEmailListByType(MailConst.MAIL_TYPE_AWARD)
	local itemList = self._dataList
	if itemList then
		local lineCount = #itemList
		dump(lineCount)
		listView:clearAll()
		listView:resize(lineCount)
	end
end

function PopupPlayerDetail:onBtnOk()
	local isBreak
	if self._callback then
		isBreak = self._callback(self._buyItemId)
	end

	if not isBreak then
		self:close()
	end
end

function PopupPlayerDetail:onBtnCancel()
	if not isBreak then
		self:close()
	end
end

function PopupPlayerDetail:onBtnModifyName(sender)
	local PopupPlayerModifyName = require("app.scene.view.playerDetail.PopupPlayerModifyName").new()
	PopupPlayerModifyName:openWithAction()
end

-- user数据更新
function PopupPlayerDetail:_onUserDataUpdate(_, param)
	dump(param)
	self:_updatePlayerInfo()
end

-- 称号装备和卸下事件处理
function PopupPlayerDetail:_onEventTitleChange()
	self:_changeTitle()
end

function PopupPlayerDetail:_onBtnGiftCode(sender)
	local popupGiftCode = require("app.ui.PopupGiftCode").new()
	popupGiftCode:openWithAction()
end


-- i18n change ex kr
-- 游客绑定按钮更新
function PopupPlayerDetail:switchAcountBtnUpdate()
	print("[PopupPlayerDetail] switchAcountBtnUpdate")
	if Lang.checkLang(Lang.KR)then
		if G_NativeAgent:hasGuest() then
			print("[PopupPlayerDetail] switchAcountBtnUpdate 1")
			self._btnSwitchAccount:setString(Lang.getImgText("system_bind_guest"))
		else
			print("[PopupPlayerDetail] switchAcountBtnUpdate 2")
			self._btnSwitchAccount:setString(Lang.get("system_setting_switch_acount"))
		end
	end
end	
-- i18n change ex kr
-- 游客绑定结果
function PopupPlayerDetail:_onBindGuestResult(_,data)
	local event = data.event
    local ret   = data.ret
	local param = data.param
	local NativeConst = require("app.const.NativeConst")
	dump(data,"[PopupPlayerDetail] SDKBindGuestResult")
	if Lang.checkLang(Lang.KR) and data then
		local platform = G_NativeAgent:getNativeType()
		print("[PopupPlayerDetail] SDKBindGuestResult result = " .. ret  .. "  platform = " .. platform)
		if platform == "ios" then
			print("platform ios ")
			print("platform ios NativeConst.STATUS_SUCCESS = " .. NativeConst.STATUS_SUCCESS)
			print("platform ios NativeConst.STATUS_CANCEL = " .. NativeConst.STATUS_CANCEL)
			print("platform ios NativeConst.STATUS_ERROR = " .. NativeConst.STATUS_ERROR)
			print("[PopupPlayerDetail] SDKBindGuestResult text = " .. Lang.getImgText("system_bind_guest_txt_success"))
			print("[PopupPlayerDetail] SDKBindGuestResult text = " .. Lang.getImgText("system_bind_guest_txt_error"))
			if ret == NativeConst.STATUS_SUCCESS then
				print("ret 0")
				G_Prompt:showTip(Lang.getImgText("system_bind_guest_txt_success"))
			elseif ret == NativeConst.STATUS_CANCEL then
				print("ret 3")
			elseif ret == NativeConst.STATUS_ERROR then
				print("ret 2")
				G_Prompt:showTip(Lang.getImgText("system_bind_guest_txt_error"))
			end
			self:switchAcountBtnUpdate()
		end
	end
end	

function PopupPlayerDetail:_onSwidthAccount(sender)
	-- 切换账号
	-- G_GameAgent:logoutPlatform()
	print("[PopupPlayerDetail] _onSwidthAccount")
	if Lang.checkLang(Lang.KR)then
		if G_NativeAgent:hasGuest() then
			G_NativeAgent:bindGuest()
		else
			G_GameAgent:logoutPlatform()
		end
	else
		G_GameAgent:logoutPlatform()
	end

end

function PopupPlayerDetail:_onGameAnnounce(sender)
	-- 打开游戏公告
	if ccexp.WebView then
		local url = G_ConfigManager:getPopupUrlI18n()
		if url ~= nil and url ~= "" then
			local PopupNotice = require("app.ui.PopupNotice")
            PopupNotice:create(url, nil)
		end
	end
end

function PopupPlayerDetail:_onGameMaker()
	-- G_SceneManager:showScene("producer")
end

function PopupPlayerDetail:_onClickBtnBind()
	local popup = require("app.ui.PopupBindPublicAccount").new()
	popup:openWithAction()
end

function PopupPlayerDetail:_onClickChangeTitle() -- 弹出修改称号框
	local PopupHonorTitle = require("app.scene.view.playerDetail.PopupHonorTitle").new()
	PopupHonorTitle:openWithAction()
	local hasRed = G_UserData:getTitles():isHasRedPoint()
	if hasRed then
		G_UserData:getTitles():c2sClearTitles()
	end
end

function PopupPlayerDetail:_formatBtns()
	local type2Pos = {
		[1] = {{233, 80}, {455, 80}, {679, 80}, {901, 80}}, --901
		[2] = {{198, 80}, {383, 80}, {568, 80}, {753, 80}, {938, 80}}
	}

	--self._btnGameMaker,
	self._btnGameMaker:setVisible(false)
	self._btnBind:setVisible(false)
	local btns = {self._btnSwitchAccount, self._btnGameAnnounce,  self._btnGameReward, self._btnBind}
	-- i18n KR add btns
	btns = self:_getBtnsByI18n(btns)

	local isShowBindWeChat = G_ConfigManager:isShowBindWeChat()
	local isBinded = G_UserData:getBase():isBindedWeChat()
	if isShowBindWeChat and isBinded == false then
		self._btnBind:setVisible(true)
	end
	
	local type = 1
	local posList = type2Pos[type]
	for i, btn in ipairs(btns) do
		local pos = posList[i]
		if pos then
			btn:setPosition(pos[1], pos[2])
		end
	end
end


-- i18n change lable
function PopupPlayerDetail:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		local textCurrlevelLimit = UIHelper.seekNodeByName(self,"Text_currlevel_limit")
		textCurrlevelLimit:setString(Lang.getImgText("max_level_limit"))

	end
end

-- i18n change pos
function PopupPlayerDetail:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		self._commonVipNode:setPositionX(self._commonVipNode:getPositionX()+8)
		self._titleTipText:setAnchorPoint(cc.p(0,0.5))
		self._titleTipText:setPositionX(self._btnChangeTitle:getPositionX()+self._btnChangeTitle:getContentSize().width * 0.5+10)
	
		self._levelLimitDesc:setAnchorPoint(cc.p(1,0.5))
		self._levelLimitDesc:setPositionX(481)
		self._levelLimitDesc:setPositionY(self._levelLimitDesc:getPositionY()-11)

	
	end
	if Lang.checkLatinLanguage() then
		self._commonNodeBk:setTitleFontSize(26)

		local UIHelper  = require("yoka.utils.UIHelper")
		local textDesc1 = UIHelper.seekNodeByName(self,"Node_12","Node_check1","Text_desc")	
		local textDesc2 = UIHelper.seekNodeByName(self,"Node_12","Node_check2","Text_desc")
		
		textDesc1:setFontSize(textDesc1:getFontSize()-2)
		textDesc2:setFontSize(textDesc2:getFontSize()-2)

		if Lang.checkLang(Lang.EN)  then
			--textDesc1:setVisible(false)
			--textDesc2:setVisible(false)
		end
	end

	if Lang.checkLang(Lang.EN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		for i = 1,3,1 do
			local node = self["_resRecover"..i]
			local image_icon = UIHelper.seekNodeByName(node,"Image_icon")
			local text_titile = UIHelper.seekNodeByName(node,"Text_titile")
			local text_value = UIHelper.seekNodeByName(node,"Text_value")

			image_icon:setPositionX(image_icon:getPositionX()-4)
			--text_titile:setPosition(text_titile:getPositionX()-8)

			UIHelper.alignRight({image_icon,text_titile,text_value},{5,5,0})
		end
	end

end


-- i18n KR add btns
function PopupPlayerDetail:_addBtnsByI18n()
	if Lang.checkLang(Lang.KR) then
		local function openURL(urlType)
			local urlJson = G_ConfigManager:getCenterForumUrl()
			local urlList = json.decode(urlJson)
			assert(urlList, "centerForumUrl not configure")
			local url = urlList[urlType]
			assert(url, "centerForumUrl not configure for "..urlType)
			G_NativeAgent:openURL(url)
		end
		local CSHelper = require("yoka.utils.CSHelper")
		local parent = self._btnSwitchAccount:getParent()
		local btnCenter = CSHelper.loadResourceNode(Path.getCSB("CommonButtonLevel0Highlight", "common"))
		parent:addChild(btnCenter)
		btnCenter:setString(Lang.get("system_setting_gm_center"))
		btnCenter:addClickEventListenerEx(function()
			openURL("center")
		end)
		self._btnCenter = btnCenter

		local btnForum = CSHelper.loadResourceNode(Path.getCSB("CommonButtonLevel0Highlight", "common"))
		parent:addChild(btnForum)
		btnForum:setString(Lang.getImgText("txt_system_forum"))
		btnForum:addClickEventListenerEx(function()
			openURL("forum")
		end)
		self._btnForum = btnForum
	end
	if Lang.checkChannel(Lang.CHANNEL_SEA) then
		local function onLanguage()
			local popup = require("app.i18n.extends.ui.PopupLanguage").new()
			popup:openWithAction()
		end
		local CSHelper = require("yoka.utils.CSHelper")
		local parent = self._btnSwitchAccount:getParent()
		local btnLanguage = CSHelper.loadResourceNode(Path.getCSB("CommonButtonLevel0Highlight", "common"))
		parent:addChild(btnLanguage)
		btnLanguage:setString(Lang.getImgText("txt_language_title"))
		btnLanguage:addClickEventListenerEx(function()
			onLanguage()
		end)
		self._btnLanguage = btnLanguage
	end
end
-- i18n KR get btns
function PopupPlayerDetail:_getBtnsByI18n(btns)
	if Lang.checkLang(Lang.KR) then
		if G_ConfigManager:isGiftcode() then
			btns = {self._btnSwitchAccount, self._btnGameReward,  self._btnCenter, self._btnForum}
		else
			btns = {self._btnSwitchAccount, self._btnCenter, self._btnForum}
		end
		self._btnGameAnnounce:setVisible(false)
	end
	if Lang.checkChannel(Lang.CHANNEL_SEA) then
		if G_ConfigManager:isGiftcode() then
			btns = {self._btnSwitchAccount, self._btnGameAnnounce,  self._btnGameReward, self._btnLanguage}
		else
			btns = {self._btnSwitchAccount, self._btnGameAnnounce, self._btnLanguage}
		end
	end
	return btns
end


-- i18n pos lable
function PopupPlayerDetail:_adjustPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		local label = self._btnChangeTitle:getTitleLabel()
		local image9 = UIHelper.seekNodeByName(self._btnChangeTitle,"Image_9")
		
		self:_alignNodeByI18n(self._btnChangeTitle,label,image9)
	end
end



-- i18n pos lable
function PopupPlayerDetail:_alignNodeByI18n(node,child1,child2)
	local size = node:getContentSize()
	local size1 = child1:getContentSize()
	local size2 = child2:getContentSize()
	child1:setPositionX(size.width*0.5-size2.width*0.5)
	child2:setPositionX(size.width*0.5+size1.width*0.5)

end

-- i18n copy id
function PopupPlayerDetail:_dealAddCopyIdByI18n()
	if not Lang.checkChannel(Lang.CHANNEL_SEA) then
		return
	end
	local UIHelper  = require("yoka.utils.UIHelper")
	local imgTitle = UIHelper.seekNodeByName(self,"Image_player_title")	
	imgTitle:setPositionX(imgTitle:getPositionX()-20)
	local textTitle = UIHelper.seekNodeByName(self,"Text_PlayerLevel_Title")	
	textTitle:setPositionX(textTitle:getPositionX()-20)
	self._textPlayerLevel:setPositionX(self._textPlayerLevel:getPositionX()-20)

	self._commonVipNode:setPositionX(self._commonVipNode:getPositionX()-58)

	local img37 = UIHelper.seekNodeByName(self,"Image_37")	
	img37:setPositionX(img37:getPositionX()-13)
	local size = img37:getContentSize()
	img37:setContentSize(cc.size(size.width-40,size.height))
	self._textExp:setPositionX((size.width-40)/2)
	local size = self._loadingbarProcess:getContentSize()
	self._loadingbarProcess:setContentSize(cc.size(size.width-40,size.height))

	local textCurrlevelLimit = UIHelper.seekNodeByName(self,"Text_currlevel_limit")
	textCurrlevelLimit:setPositionX(textCurrlevelLimit:getPositionX()-71)
	local textServerId = UIHelper.seekNodeByName(self,"Text_server_id")
	textServerId:setPositionX(textServerId:getPositionX()-71)
	local textServerName = UIHelper.seekNodeByName(self,"Text_server_name")
	textServerName:setPositionX(textServerName:getPositionX()-71)
	self._levelLimit:setPositionX(textCurrlevelLimit:getPositionX()+textCurrlevelLimit:getContentSize().width+10)
	self._textPlayerId:setPositionX(textServerId:getPositionX()+textServerId:getContentSize().width+10)
	self._textServerName:setPositionX(textServerName:getPositionX()+textServerName:getContentSize().width+10)

	self._commonHeroIcon:setPositionX(self._commonHeroIcon:getPositionX()-12)

	local imgNameBk = UIHelper.seekNodeByName(self,"Image_player_name_bk")	
	imgNameBk:setPositionX(imgNameBk:getPositionX()-13)
	local size = imgNameBk:getContentSize()
	imgNameBk:setContentSize(cc.size(size.width-40,size.height))
	self._textPlayerName:setPositionX(self._textPlayerName:getPositionX()-13)
	self._btnModifyName:setPositionX(self._btnModifyName:getPositionX()-56)
	
	if Lang.checkLang(Lang.ZH) then
		self._levelLimitDesc:setAnchorPoint(cc.p(0,0.5))
		self._levelLimitDesc:setPositionX(textCurrlevelLimit:getPositionX())
	end

	self._nodeTitle:setPositionX(self._nodeTitle:getPositionX()-15)
	local line = UIHelper.seekNodeByName(self,"line")
	line:setPositionX(line:getPositionX()-20)
	self._btnFrame:setPositionX(self._btnFrame:getPositionX()-12)
	
	local onCopy = function()
		local number = self._textPlayerId:getString()
		G_NativeAgent:clipboard(number)
		G_Prompt:showTip(Lang.get("svip_copy_success"))
	end
    local btn = ccui.Button:create()
    btn:loadTextureNormal(Path.getUICommon("img_copy_id"))
    btn:addClickEventListenerEx(onCopy)
    self._textPlayerId:getParent():addChild(btn)
	local posX,posY = self._textPlayerId:getPosition()
	local width = self._textPlayerId:getContentSize().width
	btn:setPosition(posX+width+5,posY+2)
	btn:setAnchorPoint(0,0.5)
	self._btnCopy = btn
end

return PopupPlayerDetail
