local ViewBase = require("app.ui.ViewBase")
local StartView = class("StartView", ViewBase)
local UIPopupHelper = require("app.utils.UIPopupHelper")
local PopupServerList = require("app.scene.view.login.PopupServerList")


StartView.USING_CONNENTE = 50002  -- i18n ja 利用规约开关id
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
			_btnUsingConventions = {
				events = {{event = "touch", method = "_onAgreementClick"}}     -- i18n ja callback
			}
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
	self._signalUsingConvente = G_SignalManager:add(SignalConst.EVENT_ON_ENTER_GAME, handler(self,self.onEnterGame))
	self._signalServer = G_ServerListManager.signal:add(handler(self, self.onCheckUpdateList))
	
	-- i18n ja show btn
	if self:getParameterCfg() then
		local posY =  self._btnUsingConventions:getPositionY()
		self._btnUsingConventions:setPositionY(self._buttonGongGao:getPositionY())
		self._buttonGongGao:setPositionY(self._btnPlay:getPositionY())
		self._btnPlay:setPositionY(self._buttonLogoutAccount:getPositionY())
		self._buttonLogoutAccount:setPositionY(posY)
	else
		self._btnUsingConventions:setVisible(false) 
	end

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
	self._signalUsingConvente:remove()
	self._signalUsingConvente = nil  
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
	if ret == "success" or ret == "returnServerSuccess" then
		if self._openServerList then
			self._openServerList = false
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
	elseif ret == "fail" then
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

--
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
    	-- G_WaitingMask:showWaiting(true)
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
		G_GameAgent:loginPlatform()
        return
    end
    -- local isLogin = G_GameAgent:isLogin()
    -- print("1112233 islogin = ", isLogin)
	-- local AgreementSetting = require("app.data.AgreementSetting")
	-- if not AgreementSetting.isAgreementCheckMayLogin() or not AgreementSetting.isAllAgreementCheck() then
	-- 	--G_Prompt:showTip(Lang.get("login_tips_agreement_not_agree"))
	-- 	G_SceneManager:showDialog("app.scene.view.login.PopupSecretView")
	-- 	return 
	-- end
	if server:isBackserver() and G_GameAgent:isLogin() then
		if G_GameAgent:checkIsCanEnterReturnServer(server) == false then
			G_GameAgent:onCanNotEnterReturnServer()
			return
		end
	end
	local serverId = server:getServer()
    local serverName = server:getName()
	local serverInfo = serverId .. "|" .. serverName 
	G_NativeAgent:eventCustom("AT_Select_ServerId", tostring(serverInfo))

	-- i18n ja change enterGame
	if not self:getParameterCfg() or G_StorageManager:load("UsingConvente") ~= nil then 
		self:onEnterGame()
	else 
		self:sendSelectLaw()
	end
 
	-- dump(serverInfo,"AT_Select_ServerId")
     
    

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

-- i18n ja using convente
function StartView:onEnterGame()
	G_GameAgent:enterGame()
end

--
function StartView:onButtonUser()
	G_GameAgent:loginPlatform()
end

--
function StartView:onButtonServer()
	if G_ConfigManager:isCheckReturnServer() and G_GameAgent:getTopUserId() == nil then
		G_Prompt:showTip(Lang.get("return_server_first_login_tip"))
		return
	end
	self:checkUpdateList(true)
end

function StartView:_onPlayClick( )
    -- body
    -- G_SceneManager:showScene("cg", "start.mp4")
    local cgNode = require("app.scene.view.cg.CGView").new("start.mp4", true)
    self:addChild(cgNode)
end

-- i18n ja 利用规约按钮开关
function StartView:getParameterCfg()
	local ParameterIDConst = require("app.const.ParameterIDConst")
	local Parameter = require("app.config.parameter")
	
    local info = Parameter.get(StartView.USING_CONNENTE)  -- 不可直接写数字 写const配表(多)或类常量(少) (GrainCarConst.GRAINCAR_WEEK)  
    assert(info, string.format("graincar parameter config can not find id = %d", info.content))
	if info.content == "1" then  -- 开关打开
		return true
	else
		return false            
	end
end

-- i18n ja 利用规约
function StartView:_onAgreementClick( data )
	local bFirstShow = false
	local PopupUsingConventions = require("app.scene.view.login.PopupUsingConventions")
    local code = PopupUsingConventions.new(bFirstShow)
    code:openWithAction()
end  

-- i18n ja showUsingConvente  
function StartView:onShowUsingConvente(data) 
	if data and data.field and data.field == "" then
		local PopupUsingConventions = require("app.scene.view.login.PopupUsingConventions")
		local code = PopupUsingConventions.new(true)
		code:openWithAction()
	else  
		self:onEnterGame()
	end	
end
 
-- i18n ja http
function StartView:sendSelectLaw( )
	local uuid =  string.urlencode(G_GameAgent:getTopUserId())
	local server_id = G_GameAgent:getLoginServer():getServer() 
	if server_id == nil or uuid == nil then
		return
	end
 
	local ServerConst = require("app.const.ServerConst") 
	local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
	local url = "http://10.235.200.21:12168/getinfo?uuid=#uuid#&server_id=#server_id#&field=law&sign=#sign#"
	url = string.gsub(url, "#uuid#", uuid)
	url = string.gsub(url, "#server_id#", tostring(server_id) )
	local a = "law".."#".. ServerConst.SECRET_KEY_LIST[1]
	local content = md5.sum("law".."#".. ServerConst.SECRET_KEY_LIST[1])
	url = string.gsub(url, "#sign#",  tostring(content))
	local Http = require("app.utils.Http")
	Http.sendRequest(nil, url, handler(self, self.onShowUsingConvente))
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