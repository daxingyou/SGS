local ViewBase = require("app.ui.ViewBase")
local PlayerDetailNode = class("PlayerDetailNode", ViewBase)
local PopUpPlayerFrame = require("app.scene.view.playerDetail.PopUpPlayerFrame2")
local UserDataHelper = require("app.utils.UserDataHelper")
local PopupHonorTitleHelper = require("app.scene.view.playerDetail.PopupHonorTitleHelper")
local KeyValueUrlRequest = require("app.manager.KeyValueUrlRequest")

function PlayerDetailNode:ctor()
	self._intervalTime = 0
	local resource = {
		file = Path.getCSB("PlayerDetailNode", "playerDetail"),
		binding = {
			_btnModifyName = {
				events = {{event = "touch", method = "onBtnModifyName"}}
			},
			_btnSwitchAccount = {
				events = {{event = "touch", method = "_onSwidthAccount"}}
			},
			_btnBind = {
				events = {{event = "touch", method = "_onClickBtnBind"}}
			},
			_btnChangeTitle = {
				events = {{event = "touch", method = "_onClickChangeTitle"}} -- 修改称号
			},
			_btnFrame = {
				events = {{event = "touch", method = "_onClickBtnFrame"}}
			},
			_btnSwitchServer = {
				events = {{event = "touch", method = "_onClickSwitchServer"}}
			},
			_btnCitation = {
				events = {{event = "touch", method = "_onClickCitation"}}
			},
			_btnBox = {
				events = {{event = "touch", method = "_onClickExpBoxEvent"}} -- exp over
			},
		}
	}
	self:setName("PlayerDetailNode")
	PlayerDetailNode.super.ctor(self, resource)
end

function PlayerDetailNode:onCreate()
	self._btnFrame:setTitleText(Lang.get("change_role_frame"))
	self._textCurrLevelLimit:setString(Lang.getImgText("max_level_limit"))
	local posX = self._textCurrLevelLimit:getContentSize().width+self._textCurrLevelLimit:getPositionX() + 10
	self._levelLimit:setPositionX(posX)
	self._titleText:setString(Lang.get("honor_title_title")..":")
	self._textBind:setString(Lang.get("player_detail_bind_text"))

	self._btnList = {
		self._btnBind,self._btnSwitchAccount,self._btnSwitchServer,self._btnCitation
	}
	for i, value in ipairs(self._btnList) do
		value:getDesc():setFontName(Path.getFontW8())
		-- value:getDesc():setFontSize(18)
	end
	self._btnCitation:setString(Lang.get("player_detail_get_citation"))
	self._btnSwitchServer:setString(Lang.get("citation_btn_name_select_servers"))


	self:_updatePlayerInfo()
	self:_initTitle()

	self._KeyValueUrlRequest = KeyValueUrlRequest.new(true)
end

-- 初始化称号信息
function PlayerDetailNode:_initTitle()
	self:_changeTitle()
	local FunctionCheck = require("app.utils.logic.FunctionCheck")
	local FunctionConst = require("app.const.FunctionConst")
	local isOpen = FunctionCheck.funcIsOpened(FunctionConst.FUNC_TITLE)
	self._btnChangeTitle:setVisible(isOpen)
	if not isOpen then
		self._titleImage:setVisible(false)
		self._titleTipText:setVisible(true)
	end
end

-- 改变称号
function PlayerDetailNode:_changeTitle()
	local titleItem = PopupHonorTitleHelper.getEquipedTitle() -- 获取已经装备的称号
	local titleId = titleItem and titleItem:getId() or 0
	UserDataHelper.appendNodeTitle(self._titleImage, titleId, self.__cname)
	self._titleTipText:setVisible(titleId == 0)
end

--玩家等级上限处理逻辑
function PlayerDetailNode:prcoLimitLevel(...)
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
			currLevelStar = currLevel--Lang.get("common_player_detail_level_limit", {num = currLevel})
		else
			nextPendStr = Lang.get("common_player_detail_level_limit1", {level = currLevel, day = currDay - nowDay})
		end
	end

	self._levelLimit:setString(currLevelStar)
	self._levelLimitDesc:setString(nextPendStr)
end

--顶部玩家信息更新
function PlayerDetailNode:_updatePlayerInfo()
	local baseData = G_UserData:getBase()

	self._textPlayerLevel:setString(tostring(baseData:getLevel()))
	self._textPlayerName:setString(baseData:getName())
	local hexstr = string.format("%x", baseData:getId())
	self._textPlayerId:setString(hexstr)

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
	self:_refreshExpOver() -- exp over

	--serverId
	local serverName = G_UserData:getBase():getServer_name()
	self._textServerName:setString(serverName)

	self._btnSwitchAccount:setString(Lang.get("system_setting_switch_acount"))
	self._btnBind:setString(Lang.get("citation_btn_name_bind_account"))

	self:_updateRecoverInfo(1)
	self:_updateRecoverInfo(2)
	self:_updateRecoverInfo(3)

	local officialInfo, officialLevel = G_UserData:getBase():getOfficialInfo()
	-- if officialLevel == 0 then
	-- 	self:updateImageView("Image_player_title", {visible = false})
	-- else
		self:updateImageView("Image_player_title", {texture = Path.getTextHero(officialInfo.picture), visible = true})
	-- end

	self._commonHeroIcon:updateIcon(G_UserData:getBase():getPlayerShowInfo(), nil, G_UserData:getHeadFrame():getCurrentFrame():getId())

	self._textPlayerName:setColor(Colors.getOfficialColor(officialLevel))
	require("yoka.utils.UIHelper").updateTextOfficialOutline(self._textPlayerName, officialLevel)

end

--更新回复信息
function PlayerDetailNode:_updateRecoverInfo(index)
	local unitIds = {1, 2, 4}
	local unitInfo = G_RecoverMgr:getRecoverUnit(unitIds[index])
	local serverTime = G_ServerTime:getTime()
	local resId = unitInfo:getResId()
	local recoverCfg = unitInfo:getConfig()

	local recoverWidget = self["_resRecover" .. index]
	recoverWidget:updateLabel("Text_titile2", Lang.get("player_detail_restore_desc", {value = recoverCfg.name}))
	recoverWidget:updateLabel("Text_titile1",Lang.get("player_detail_resource_desc", {title = recoverCfg.name}))

	local miniIcon = Path.getCommonIcon("resourcemini", resId)

	recoverWidget:updateImageView("Image_icon", {texture = miniIcon})
	if index == 2 then
		local UIHelper  = require("yoka.utils.UIHelper")	
		local image = UIHelper.seekNodeByName(recoverWidget,"Image_icon")
		image:setScale(0.8)
	end

	self:_updateRecoverTime(index)
end

function PlayerDetailNode:_updateRecoverTime(index)
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
		restoreFullTime = time1 - G_ServerTime:getTime()
		totalRestoreDesc = G_ServerTime:_secondToString(restoreFullTime)
	end
	local recoverWidget = self["_resRecover" .. index]
	recoverWidget:updateLabel(
		"Text_value2",
		{
			text = restoreFullTime == 0 and Lang.get("player_detail_restore_full") or totalRestoreDesc,
			color = restoreFullTime == 0 and Colors.COLOR_POPUP_ADD_PROPERTY or cc.c3b(0xc8 , 0xd4  , 0xf6 )
		}
	)
	recoverWidget:updateLabel(
		"Text_value1",
		string.format("%d/%d",currValue,unitInfo:getMaxLimit())
	)
end

function PlayerDetailNode:onEnter()
	self:scheduleUpdateWithPriorityLua(handler(self,self._onUpdate),0)

	-- 监听user数据更新
	self._signalUserDataUpdate = G_SignalManager:add(SignalConst.EVENT_RECV_ROLE_INFO, handler(self, self._onUserDataUpdate))

	self._signalEquipTitle = G_SignalManager:add(SignalConst.EVENT_EQUIP_TITLE, handler(self, self._onEventTitleChange)) -- 称号装备
	self._signalUnloadTitle = G_SignalManager:add(SignalConst.EVENT_UNLOAD_TITLE, handler(self, self._onEventTitleChange)) -- 称号卸下
	self._signalRedPoint = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self, self._onEventRedUpdate))
    self._signalUpdateTitleInfo = G_SignalManager:add(SignalConst.EVENT_UPDATE_TITLE_INFO, handler(self, self._onEventTitleChange)) -- 称号更新

	self._signalBindSuccess = G_SignalManager:add(SignalConst.EVENT_BIND_SUCCESS, handler(self, self._onEventBindSuccess)) -- 绑定成功
	self._signalBindInfo = self._KeyValueUrlRequest.signal:registerListener( handler(self, self._onEventBindInfo))
	if G_UserData:getBase():getIsBinded() == nil then
		self._textBind:setVisible(false)
		self._KeyValueUrlRequest:doRequestGetKeyValue("isBind")
	else
		self._textBind:setVisible(not G_UserData:getBase():getIsBinded())
	end

	self:_resetRedPoint()
	self:_resetHeadFramePoint()

 	-- exp over
	 self._signalExpOver = G_SignalManager:add(SignalConst.EVENT_GET_EXP_OVER_AWARD, handler(self, self._onEventGetExpOverAward))
end

function PlayerDetailNode:onExit()
	self._signalUserDataUpdate:remove()
	self._signalUserDataUpdate = nil
	self._signalEquipTitle:remove()
	self._signalEquipTitle = nil
	self._signalUnloadTitle:remove()
	self._signalUnloadTitle = nil
	self._signalRedPoint:remove()
	self._signalRedPoint = nil
	self._signalUpdateTitleInfo:remove()
	self._signalUpdateTitleInfo=nil
	self._signalBindSuccess:remove()
	self._signalBindSuccess = nil
	self._signalBindInfo:remove()
	self._signalBindInfo = nil
	self._signalExpOver:remove()
	self._signalExpOver=nil
end

function PlayerDetailNode:_onUpdate(dt)
	self._intervalTime = self._intervalTime + dt
	if self._intervalTime >= 1 then
		self:_updateRecoverTime(1)
		self:_updateRecoverTime(2)
		self:_updateRecoverTime(3)
		self._intervalTime = 0
	end
end

function PlayerDetailNode:onBtnModifyName(sender)
	local PopupPlayerModifyName = require("app.scene.view.playerDetail.PopupPlayerModifyName").new()
	PopupPlayerModifyName:openWithAction()
end

function PlayerDetailNode:_onSwidthAccount(sender)
	local platform = G_NativeAgent:getNativeType()
	if platform == "ios" or platform == "android" then	
		local NativeConst = require("app.const.NativeConst")
		G_NativeAgent:openSdkSystem(NativeConst.SDK_SYSTEM_SWITCH)
	else
		G_GameAgent:logoutPlatform()
	end
end

function PlayerDetailNode:_onClickBtnBind()
	-- self._KeyValueUrlRequest:doRequestSetKeyValue("isBind","binded")
	local platform = G_NativeAgent:getNativeType()
	if platform == "ios" or platform == "android" then	
		local NativeConst = require("app.const.NativeConst")
		G_NativeAgent:openSdkSystem(NativeConst.SDK_SYSTEM_BIND)
	else
		-- G_GameAgent:logoutPlatform()
	end
end

function PlayerDetailNode:_onClickChangeTitle()
	local PopupHonorTitle = require("app.scene.view.playerDetail.PopupHonorTitle").new()
	PopupHonorTitle:openWithAction()
	local hasRed = G_UserData:getTitles():isHasRedPoint()
	if hasRed then
		G_UserData:getTitles():c2sClearTitles()
	end
end

function PlayerDetailNode:_onClickBtnFrame()
	local popup = PopUpPlayerFrame.new()
	popup:openWithAction()
end

function PlayerDetailNode:_onClickSwitchServer()
	G_SceneManager:showDialog("app.scene.view.login.PopupServerList",nil,nil,
	function (server)
		G_GameAgent:returnToLogin()
		G_GameAgent:setLoginServer(server)
		G_ServerListManager:setLastServerId(server:getServer())
		G_GameAgent:loginGame()
	end)
end

function PlayerDetailNode:_onClickCitation()
	if G_NativeAgent:hasCitationCode() then
		local PopupPublishCitation = require("app.ui.PopupPublishCitation")
		local popup = PopupPublishCitation.new(function(password)
			local code_password = password
			print("PopupPlayerDetail:_onClickTempCitation() code_password = " .. code_password)
			G_NativeAgent:genCitationCode(code_password)
		end)
		popup:openWithAction()
	end
end

-- user数据更新
function PlayerDetailNode:_onUserDataUpdate(_, param)
	--dump(param)
	self:_updatePlayerInfo()
end

-- 称号装备和卸下事件处理
function PlayerDetailNode:_onEventTitleChange()
	self:_changeTitle()
end

function PlayerDetailNode:_onEventRedUpdate()
	self:_resetRedPoint()
	self:_resetHeadFramePoint()
end

function PlayerDetailNode:_resetRedPoint()
	local hasRed = G_UserData:getTitles():isHasRedPoint()
	self._redPoint:setVisible(hasRed)
end

function PlayerDetailNode:_resetHeadFramePoint( )
	local frameRed = G_UserData:getHeadFrame():hasRedPoint()
	self._redPointFrame:setVisible(frameRed)
end


function PlayerDetailNode:_onEventBindSuccess()
	print("PlayerDetailNode onEventBindSuccess")
	self._textBind:setVisible(not G_UserData:getBase():getIsBinded())
end

function PlayerDetailNode:_onEventBindInfo(e, data)
	if e == "fail" then
		return 
	end
	dump(data,"lkmPlayerDetailNode")

	if data and data.field and data.field == "binded" then
		G_UserData:getBase():setIsBinded(true)
	else
		G_UserData:getBase():setIsBinded(false)
	end
	self._textBind:setVisible(not G_UserData:getBase():getIsBinded())
end

-- exp over
function PlayerDetailNode:_refreshExpOver()
	--玩家经验
	local currExp = G_UserData:getBase():getExp()
	local level = G_UserData:getBase():getLevel()

	local exp_over = require("app.config.exp_over").get(1)
	assert(exp_over, "can not find exp_over Config by id is " .. 1)
	if level < exp_over.level then
		self._nodeEffectBox:setVisible(false)
		self._nodeEffectLoading:setVisible(false)
		self._btnBox:setVisible(false)
		self._loadingbarProcess2:setVisible(false)
		return
	end

	-- 进度条
	local levelUpExp = exp_over.exp
	self._textExp:setString(currExp .. "/" .. levelUpExp)
	local percent = math.ceil(currExp / levelUpExp * 100)
	if percent >= 100 then
		percent = 100
		if currExp < levelUpExp then   -- bug：ceil向上取整 在不足100%时会报错 <如：(14900/1500)==100% 不是99.1% >
			percent = 99
		end
	end

	self._loadingbarProcess:setVisible(false)
	self._loadingbarProcess2:setVisible(true)
	self._loadingbarProcess2:setPercent(percent)  

	-- 宝箱
	local iconPath = ""
	if percent < 100 then
		iconPath = Path.getPlayerDetail("img_box1")
	else
		iconPath = Path.getPlayerDetail("img_box2")
	end
	self._btnBox:setOpacity(255)
	self._btnBox:ignoreContentAdaptWithSize(true)
	self._btnBox:loadTextureNormal(iconPath)

	-- 特效
	if percent >= 100 then
		local effect_baoxiang_tx = "effect_baoxiang_tx"
		G_EffectGfxMgr:createPlayGfx(self._nodeEffectBox, effect_baoxiang_tx)
		local effectTitle = "effect_baoxiang_guangtiao"
		G_EffectGfxMgr:createPlayGfx(self._nodeEffectLoading, effectTitle)

		self._btnBox:setOpacity(0)
		self._nodeEffectBox:setVisible(true)
		self._nodeEffectLoading:setVisible(true)
	else   
		self._nodeEffectBox:setVisible(false)
		self._nodeEffectLoading:setVisible(false)
	end
end

-- exp over
function PlayerDetailNode:_onClickExpBoxEvent()
	local exp = self._loadingbarProcess2:getPercent()
	if exp >= 100 then
		G_NetworkManager:send(MessageIDConst.ID_C2S_GetExpOverAward, {})
	else
		self:_showAward()
	end
end

-- exp over
function PlayerDetailNode:_onEventGetExpOverAward(id, message) 
	self:_refreshExpOver()

	local awards = rawget(message, "awards") or {}
	local PopupGetRewards = require("app.ui.PopupGetRewards").new()
	PopupGetRewards:showRewards(awards)
end

-- exp over
function PlayerDetailNode:_showAward() 
 	
	local exp_over = require("app.config.exp_over").get(1)
	local dropInfo = require("app.config.drop").get(exp_over.drop_id)
	local itemList = {}
    for i=1,10 do
        local itemType = dropInfo["type_" ..i]
        if type(itemType) and itemType > 0 then
            table.insert(itemList, {type = dropInfo["type_" ..i], value = dropInfo["value_" ..i], size = dropInfo["size_" ..i]})
        end
	end
	
	local popupReward = require("app.ui.PopupReward").new(Lang.get("exp_over_title"), true)
	popupReward:updateUI(itemList)
	popupReward:openWithAction()
	local content = Lang.get("exp_over_detail", {exp = exp_over.exp})  
	--popupReward:setDetailText(content)
	--popupReward:openWithTarget(self) 
	
	local textDetail = ccui.Helper:seekNodeByName(popupReward, "_textDetail")
	textDetail:ignoreContentAdaptWithSize(true)
	textDetail:setTextAreaSize(cc.size(458, 0))
	textDetail:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER )
	textDetail:setAnchorPoint(cc.p(0.5, 1))
	textDetail:setPositionY(85.00)
	textDetail:setFontSize(18)
	textDetail:setString(content)

	local listViewDrop = ccui.Helper:seekNodeByName(popupReward, "_listViewDrop")
	listViewDrop:setPositionY(-80)
	listViewDrop:doLayout()

 
	local items = listViewDrop:getChildren()--getItems()
	for i, item in ipairs(items) do
		 local imageNameBg = ccui.Helper:seekNodeByName(item,"ImageNameBg")
		 imageNameBg:setVisible(false)
	end
	listViewDrop:doLayout()
end

return PlayerDetailNode

