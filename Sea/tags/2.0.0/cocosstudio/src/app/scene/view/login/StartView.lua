local ViewBase = require("app.ui.ViewBase")
local StartView = class("StartView", ViewBase)
local UIPopupHelper = require("app.utils.UIPopupHelper")
local PopupServerList = require("app.scene.view.login.PopupServerList")

--
function StartView:ctor()
	local resource = {
		file = Path.getCSB("StartView", "login"),
        size = G_ResolutionManager:getDesignSize(),
		binding = {
			_btnEnter = {
				events = {{event = "touch", method = "onButtonEnter"}}
			},
			_btnUser = {
				events = {{event = "touch", method = "onButtonUser"}}
			},
			_btnServer = {
				events = {{event = "touch", method = "onButtonServer"}}
			},
			_buttonGongGao = {
				events = {{event = "touch", method = "_onGongGaoButton"}}
			},
			_buttonLogoutAccount = {
				events = {{event = "touch", method = "_onLogoutAccountButton"}}
			},
			_btnPlay = {
				events = {{event = "touch", method = "_onPlayClick"}}
			},
			
		}
	}
	StartView.super.ctor(self, resource)
end

--
function StartView:onCreate()
	-- i18n change lable
	self:_dealByI18n()
	--self._btnEnter:setString(Lang.get("login_start_game"))
	self._buttonLogoutAccount:setVisible(false)
end

--
function StartView:onEnter()
	self._signalSdkLogin = G_SignalManager:add(SignalConst.EVENT_SDK_LOGIN, handler(self,self.updateUserName))
    self._signalSdkLogout = G_SignalManager:add(SignalConst.EVENT_SDK_LOGOUT, handler(self,self.updateUserName))
    self._signalServer = G_ServerListManager.signal:add(handler(self, self.onCheckUpdateList))
    
    local CGHelper = require("app.scene.view.cg.CGHelper")
    if not CGHelper.checkCG(true) then 
        self._btnPlay:setVisible(false)
        self._buttonLogoutAccount:setPositionY(self._btnPlay:getPositionY())
end
end

--
function StartView:onExit()
	self._signalSdkLogin:remove()
	self._signalSdkLogin = nil
	self._signalSdkLogout:remove()
	self._signalSdkLogout = nil
	self._signalServer:remove()
	self._signalServer = nil
end

--
function StartView:showView()
	self:setVisible(true)
	self:updateUserName()
    self:checkUpdateList(false)
end

--
function StartView:hideView()
	self:setVisible(false)
end

function StartView:_onGongGaoButton(render)

    if ccexp.WebView then
        local url = G_ConfigManager:getPopupUrlI18n()
        if url ~= nil and url ~= "" then
			local PopupNotice = require("app.ui.PopupNotice")
            PopupNotice:create(url, nil)
		end
		return
	end
	if CONFIG_READ_REPORT then
		-- G_SceneManager:showScene("firstfight")
		G_SceneManager:showScene("fighttest")
		-- G_SceneManager:showScene("horseRace", 1)
	-- 	local storyChat = require("app.scene.view.storyChat.PopupStoryChat").new(22)
	-- 	storyChat:open()
		-- G_SceneManager:showScene("uicontrol")
    end
end

function StartView:_onLogoutAccountButton(render)
    G_GameAgent:loginPlatform()
end


--
function StartView:onCheckUpdateList(ret)
	print("onCheckUpdateList = " .. ret)
	G_WaitingMask:showWaiting(false)
	if ret == "success" then
		if self._openServerList then

			G_SceneManager:showDialog("app.scene.view.login.PopupServerList",nil,nil,
				function (server)
					G_GameAgent:setLoginServer(server)
					self:updateUserServer()
				end)
--[[
			local popup = PopupServerList.new(function (server)
				G_GameAgent:setLoginServer(server)
                self:updateUserServer()
			end)
			popup:openWithAction()
			]]
		else
			self:updateUserServer() 
		end
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

function StartView:updateUserName()
    local str_name = G_GameAgent:getLoginUserName()
    if str_name then
		self._buttonLogoutAccount:setVisible(true)
        self._labelUser:setString(str_name)
    else
		self._buttonLogoutAccount:setVisible(false)
        self._labelUser:setString("")
    end
	
	
	
end

--
function StartView:updateUserServer()
    local server = G_GameAgent:getLoginServer()
    if server then
		local statusIcon,showStatusIcon = Path.getServerStatusIcon(server:getStatus())
		self._image_server_type:setVisible(showStatusIcon)
		if showStatusIcon then
			self._image_server_type:loadTexture(statusIcon)
		end
        self._labelServer:setString(server:getName())
    else
		self._image_server_type:setVisible(false)
        self._labelServer:setString("")
    end

	
end

--
function StartView:checkUpdateList(open)
    self._openServerList = open
    if G_ServerListManager:isCheckUpdate() then
    	G_WaitingMask:showWaiting(true)
	    G_ServerListManager:checkUpdateList()
	else
		self:onCheckUpdateList("success")
	end
end

--
function StartView:onButtonEnter()
    local server = G_GameAgent:getLoginServer()
	local AudioConst = require("app.const.AudioConst")
	G_AudioManager:playSoundWithId(AudioConst.SOUND_BUTTON_START_GAME)
	logWarn("onButtonEnter")
    if server == nil then
        return
    end
	
	local AgreementSetting = require("app.data.AgreementSetting")
	if not AgreementSetting.isAgreementCheckMayLogin() or not AgreementSetting.isAllAgreementCheck() then
		if not Lang.checkLang(Lang.CN) then
			G_Prompt:showTip(Lang.get("login_tips_agreement_not_agree"))
		else
			G_SceneManager:showDialog("app.scene.view.login.PopupSecretView")
		end
		
		return 
	end

	local serverId = server:getServer()
    local serverName = server:getName()
	local serverInfo = serverId .. "|" .. serverName 
	G_NativeAgent:eventCustom("AT_Select_ServerId", tostring(serverInfo))
	-- dump(serverInfo,"AT_Select_ServerId")

    G_GameAgent:enterGame()


    -- local videoPlayer = ccexp.VideoPlayer:create()
    -- videoPlayer:setPosition(cc.p(700, 320))
    -- videoPlayer:setAnchorPoint(cc.p(0.5, 0.5))
    -- videoPlayer:setContentSize(cc.size(700, 320))
    -- videoPlayer:setKeepAspectRatioEnabled(false)
    -- videoPlayer:setTouchEnabled(false)
    -- videoPlayer:setFullScreenEnabled(true)
    -- self:addChild(videoPlayer)
    -- videoPlayer:setFileName("video/opening.mp4")
    -- videoPlayer:play()


end

--
function StartView:onButtonUser()
	G_GameAgent:loginPlatform()
end

--
function StartView:onButtonServer()
	self:checkUpdateList(true)
end

function StartView:_onPlayClick( )
    -- body
    local cgNode = require("app.scene.view.cg.CGView").new("start.mp4", true)
    self:addChild(cgNode)
end

-- i18n change lable
function StartView:_dealByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local size = self._buttonLogoutAccount:getContentSize()
		local label = UIHelper.createLabel({
			style = "login_1",
			text = Lang.getImgText("btn_loginlogoff") ,
			position = cc.p(size.width * 0.5,20),
		})
		label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
		label:getVirtualRenderer():setLineSpacing(-6)
		self._buttonLogoutAccount:addChild(label)


		local size1 = self._buttonGongGao:getContentSize()
		local label = UIHelper.createLabel({
			style = "login_1",
			text = Lang.getImgText("btn_loginnotice") ,
			position = cc.p(size1.width * 0.5,20),
		})
		self._buttonGongGao:addChild(label)
		

		local size2 = self._btnPlay:getContentSize()
		local label = UIHelper.createLabel({
			style = "login_1",
			text = Lang.getImgText("btn_loginplay") ,
			position = cc.p(size2.width * 0.5,20),
		})
		label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
		label:getVirtualRenderer():setLineSpacing(-6)
		self._btnPlay:addChild(label)
	
	end

	local SwitchLanguageHelper = require("app.i18n.utils.SwitchLanguageHelper")
	SwitchLanguageHelper.showSwitchButton(self._panelDesign)
end

-- i18n create  18
function StartView:_createI18n()
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

return StartView