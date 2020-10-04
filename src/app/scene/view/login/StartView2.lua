local ViewBase = require("app.ui.ViewBase")
local StartView2 = class("StartView2", ViewBase)
local UIPopupHelper = require("app.utils.UIPopupHelper")
local PopupServerList = require("app.scene.view.login.PopupServerList")

 
--
function StartView2:ctor()
	local resource = {
		file = Path.getCSB("StartView2", "login"),
        size = G_ResolutionManager:getDesignSize(),
		binding = {
			_panelDesign = {
				events = {{event = "touch", method = "_onTouchStart"}}    
			},
			_btnEnter = {
				events = {{event = "touch", method = "_onButtonEnter"}}
			},
			_btnAccount = {
				events = {{event = "touch", method = "_onSwitchAccount"}}
			},
			_btnUsingConventions = {
				events = {{event = "touch", method = "_onUsingConventions"}}    
			}
		}
	}
	StartView2.super.ctor(self, resource)
end

--
function StartView2:_onTouchStart()
	print("StartView2: onTouchStart")
	local UIActionHelper = require("app.utils.UIActionHelper")
	local action = UIActionHelper.createUpdateAction(function()
			self._isTouch = false
	end, 1)
	self._panelDesign:runAction(action)

	if self._isTouch then return end
	self:onButtonEnter()
	self._isTouch = true
end

--
function StartView2:_onButtonEnter()
	print("StartView2: _onButtonEnter")
	local UIActionHelper = require("app.utils.UIActionHelper")
	local action = UIActionHelper.createUpdateAction(function()
			self._isTouch = false
	end, 1)
	self._panelDesign:runAction(action)
	if self._isTouch then return end
	self:onButtonEnter()
	self._isTouch = true
end

--
function StartView2:_onSwitchAccount()
	print("StartView2: _onSwitchAccount")
	local platform = G_NativeAgent:getNativeType()
	if platform == "ios" or platform == "android" then	
		local NativeConst = require("app.const.NativeConst")
		G_NativeAgent:openSdkSystem(NativeConst.SDK_SYSTEM_SWITCH)
	else
		dump(G_GameAgent:isLastLogin(), "StartView2: _onSwitchAccount isLastLogin:")
		if G_GameAgent:isLastLogin() then
			G_GameAgent:logoutPlatform()
		else
			G_GameAgent:loginPlatform()
		end
	end
end

--
function StartView2:_onUsingConventions()
	print("StartView2: _onUsingConventions")

	local platform = G_NativeAgent:getNativeType()
	if platform == "ios" or platform == "android" then	
		-- i18n ja 利用规约
		local PopupUsingConventions = require("app.scene.view.login.PopupUsingConventions")
		local code = PopupUsingConventions.new(false)
		code:openWithAction()
	else
		G_SceneManager:showDialog("app.scene.view.login.PopupServerList",nil,nil,
		function (server)
			G_GameAgent:setLoginServer(server)
			G_ServerListManager:setLastServerId(server:getServer())
			-- G_GameAgent:loginGame()
		end)
	end
		
end

--
function StartView2:onCreate()
	print("StartView2")
	self._isTouch = false
	self:_show()
	-- i18n change lable
	-- self:_dealByI18n()

	-- local UIHelper  = require("yoka.utils.UIHelper")
	-- local size = self._buttonLogoutAccount:getContentSize()
	-- local label = UIHelper.createLabel({
	-- 	style = "login_1",
	-- 	text = Lang.getImgText("btn_loginlogoff") ,
	-- 	position = cc.p(size.width * 0.5,20),
	-- })
	-- label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
	-- label:getVirtualRenderer():setLineSpacing(-6)
	-- self._buttonLogoutAccount:addChild(label)



	-- local size2 = self._btnPlay:getContentSize()
	-- local label = UIHelper.createLabel({
	-- 	style = "login_1",
	-- 	text = Lang.getImgText("btn_loginplay") ,
	-- 	position = cc.p(size2.width * 0.5,20),
	-- })
	-- label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
	-- label:getVirtualRenderer():setLineSpacing(-6)
	-- self._btnPlay:addChild(label)
	self:checkUpdateList(true)
end

--i18n change
function StartView2:_show()
	local nodeName = "btn_touc2_1" 
	local s = self._btnEnter:getChildByName(nodeName)
	local sq = cc.Sequence:create(
		cc.FadeIn:create(0.8),
		cc.DelayTime:create(1),
		cc.FadeOut:create(0.8)
	)
	local action = cc.RepeatForever:create(sq)
	s:runAction(action)

	
	local effectName = "effect_dayoka"
	G_EffectGfxMgr:createPlayGfx(self._btnEnter, effectName)
end
	
--
function StartView2:onEnter()
	self._signalServer = G_ServerListManager.signal:add(handler(self, self.onCheckUpdateList))
end

--
function StartView2:onExit()
	self._signalServer:remove()
	self._signalServer = nil
end

--
function StartView2:showView()
	self:setVisible(true)
	self:checkUpdateList(false)
    --i18n ex 
    G_GameAgent:updateLastLoginStatus()   
end

--
function StartView2:hideView()
	self:setVisible(false)
end

--
function StartView2:checkUpdateList(open)
    self._openServerList = open
    if G_ServerListManager:isCheckUpdate() then
    	-- G_WaitingMask:showWaiting(true)
		G_ServerListManager:checkUpdateList()

	else
		self:onCheckUpdateList("success")
	end

	logWarn("checkUpdateList")


end

--
function StartView2:onButtonEnter()
	local server = G_GameAgent:getLoginServer()
	local AudioConst = require("app.const.AudioConst")
	G_AudioManager:playSoundWithId(AudioConst.SOUND_BUTTON_START_GAME)
	logWarn("onButtonEnter")

	-- if not G_GameAgent:isLastLogin() then
	-- 	G_GameAgent:loginPlatform()
    --     return
    -- end

	-- if server:isBackserver() and G_GameAgent:isLogin() then
	-- 	if G_GameAgent:checkIsCanEnterReturnServer(server) == false then
	-- 		G_GameAgent:onCanNotEnterReturnServer()
	-- 		return
	-- 	end
	-- end
	local serverId = server:getServer()
    local serverName = server:getName()
	local serverInfo = serverId .. "|" .. serverName 
	G_NativeAgent:eventCustom("AT_Select_ServerId", tostring(serverInfo))
	-- dump(serverInfo,"AT_Select_ServerId")
    -- G_GameAgent:enterGame()
	
	local platform = G_NativeAgent:getNativeType()
	if G_GameAgent:isLastLogin() then
		logWarn("onButtonEnter enterGame 1")
		G_GameAgent:enterGame()
	else
		if platform == "ios" or platform == "android" then
			logWarn("onButtonEnter enterGame 2")
			G_GameAgent:enterGame()
		else
			logWarn("onButtonEnter loginPlatform ")
			G_GameAgent:loginPlatform()
		end
	end


end


--
function StartView2:onCheckUpdateList(ret)
	print("onCheckUpdateList = " .. ret)
	G_WaitingMask:showWaiting(false)
	if ret == "success" then	
		G_GameAgent:setLoginServer(G_GameAgent:getRecommendServer())
	else
		--失败
		local callback = function ()
            self:checkUpdateList()
        end
		if Lang.checkLang(Lang.CN) then
			UIPopupHelper.popupOkDialog(nil,"获取服务器列表失败",callback,"更新")
		else
			UIPopupHelper.popupOkDialog(nil,Lang.getImgText("get_server_list_fail"),callback,Lang.getImgText("update"))
		end
	end
	
end
  
-- i18n ja 利用规约
function StartView2:_onAgreementClick( )
	local PopupUsingConventions = require("app.scene.view.login.PopupUsingConventions")
    local code = PopupUsingConventions.new(false)
    code:openWithAction()
end  

-- i18n change lable
function StartView2:_dealByI18n()
	local SwitchLanguageHelper = require("app.i18n.utils.SwitchLanguageHelper")
	SwitchLanguageHelper.showSwitchButton(self._panelDesign)
end

-- i18n create  18
function StartView2:_createI18n()
	if Lang.checkLang(Lang.VN) then
		logWarn("-------------xxxx121")
		if G_ConfigManager:isYearsOldWarn() then
			self._panelDesign:removeChildByName("18")
			local image = cc.Sprite:create(Path.getLoginImg("18"))
			image:setPosition(210,430)
			image:setName("18")
		-- image:setScale(0.7)
			self._panelDesign:addChild(image)
		else
			self._panelDesign:removeChildByName("18")	
		end
	end
end

return StartView2