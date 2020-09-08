local ViewBase = require("app.ui.ViewBase")
local LoginView = class("LoginView", ViewBase)

local scheduler = require("cocos.framework.scheduler")
local Version = require("yoka.utils.Version")
local UIPopupHelper = require("app.utils.UIPopupHelper")
local AudioConst = require("app.const.AudioConst")
local fileUtils = cc.FileUtils:getInstance()
--
function LoginView:ctor()
    --
    local resource = {
        file = Path.getCSB("LoginView", "login"),
        size = G_ResolutionManager:getDesignSize(),
        binding = {
            _panelPrivacyTouch = {
                events = {{event = "touch", method = "_onClickPrivacyAgreement"}}
            },
            _panelServiceTouch = {
                events = {{event = "touch", method = "_onClickServiceAgreement"}}
            }
        }
    }

    LoginView.super.ctor(self, resource)
end

--
function LoginView:isRootScene()
    return true
end
--
function LoginView:onCreate()
    
    if not Lang.checkLang(Lang.CN) then
        self:_dealI18n()
    end
    local classBG = "app.scene.view.login.LoginBG1"
    if fileUtils:isFileExist("channel_login.jpg") then
        classBG = "app.scene.view.login.LoginBG2"
        self._textCopyrightInfo1:setString("")
        self._textCopyrightInfo2:setString("")

        self._nodeAgreementContent:setVisible(false)

        local AgreementSetting = require("app.data.AgreementSetting")
        AgreementSetting.saveAllAgreementIsCheck(true)
    else
        self._textCopyrightInfo1:setString(Lang.get("login_copyright_info_1"))
        self._textCopyrightInfo2:setString(Lang.get("login_copyright_info_2"))

        self._nodeAgreementContent:setVisible(true)
        local AgreementSetting = require("app.data.AgreementSetting")
        self._checkBoxService:setSelected(AgreementSetting.isAgreementCheck("check"))
        self._checkBoxService:addEventListener(handler(self, self._onClickCheckBox))

        self._checkBoxPrivacy:setSelected(AgreementSetting.isAgreementCheck(AgreementSetting.getPrivacyWords()))
        self._checkBoxPrivacy:addEventListener(handler(self, self._onClickCheckBox))
    end
    self._loginBG = require(classBG).create()
    self._panelBG:addChild(self._loginBG)

    --
    -- i18n change ja
    if Lang.checkLang(Lang.JA) then
        self._loginView = require("app.scene.view.login.StartView2").create()
        self:addChild(self._loginView)
        self._loginView:setVisible(false)
    else
        self._loginView = require("app.scene.view.login.StartView").create()
        self:addChild(self._loginView)
        self._loginView:setVisible(false)
    end

    --
    self._updateView = require("app.scene.view.login.UpdateView").create()
    self:addChild(self._updateView)
    ---self._updateView:setPosition(G_ResolutionManager:getDesignCCPoint())
    self._updateView:setVisible(false)

    if Lang.checkLang(Lang.JA) then
        self._textCopyrightInfo1:setVisible(false)
        self._textCopyrightInfo2:setVisible(false)
        self._nodeCopyrightInfo3:setVisible(false)
    end

end

--
function LoginView:onEnter()
    -- if G_UserData:isFlush() then
    --     cc.exports.G_UserData = require("app.data.UserData").new()
    -- end
    G_UserData:getUserSetting():updateMusic()

    G_TouchEffect:start()
    G_AudioManager:playMusicWithId(AudioConst.MUSIC_LOGIN_CREATE)
    G_ServiceManager:stop()
    logWarn("LoginView onEnter")

    self._signalSdkVersion = G_SignalManager:add(SignalConst.EVENT_SDK_CHECKVERSION, handler(self, self._onInitSDK))
    self._signalVersionUpdate =
        G_SignalManager:add(SignalConst.EVENT_LOGIN_VERSION_UPDATE, handler(self, self._onRefreshConfig))
    self._signalAgreeSecret =
        G_SignalManager:add(SignalConst.EVENT_AGREE_SECRET, handler(self, self._onRefreshCheckBoxService))
    self._signalOpenLogin = G_SignalManager:add(SignalConst.EVENT_AUTO_LOGIN, handler(self, self._onOpenLogin))

    self:showVersion()
    self:initSDK()
end

--
function LoginView:onExit()
    self._signalSdkVersion:remove()
    self._signalSdkVersion = nil
    self._signalVersionUpdate:remove()
    self._signalVersionUpdate = nil
    self._signalAgreeSecret:remove()
    self._signalAgreeSecret = nil
    self._signalOpenLogin:remove()
    self._signalOpenLogin = nil
end

--
function LoginView:showVersion()
    local resVersion = VERSION_RES
    -- logWarn(resVersion)
    -- logWarn(cc.Application:getInstance():getVersion())
    local version = resVersion .. "(" .. cc.Application:getInstance():getVersion() .. ")"

    if APP_DEVELOP_MODE then
        version = version .. " - developer"
    end

    self._labelVersion:setString(version)
end

--
function LoginView:showLoginView()
    self._loginView:showView()
    self._updateView:hideView()
    if not Lang.checkLang(Lang.JA) then
        self:showLoginNotice()
        self._textCopyrightInfo1:setVisible(true)
        self._textCopyrightInfo2:setVisible(true)
        self._nodeCopyrightInfo3:setVisible(true)
    end
    self._labelVersion:setVisible(true)
    -- 推送进入登录界面事件
    G_NativeAgent:eventEnterLogin()

    -- i18n change vn
    -- if not Lang.checkLang(Lang.CN) then
    --     self._textCopyrightInfo1:setVisible(false)
    --     self._textCopyrightInfo2:setVisible(false)
    --     self._nodeCopyrightInfo3:setVisible(false)
    -- end
end

--
function LoginView:showUpdateView(version)
    self._loginView:hideView()
    self._updateView:showView(version)
    self._textCopyrightInfo1:setVisible(false)
    self._textCopyrightInfo2:setVisible(false)
    self._nodeCopyrightInfo3:setVisible(false)
    self._labelVersion:setVisible(false)
    if self._loginBG.createLoadingBG then
        self._loginBG:createLoadingBG()
    end
end

function LoginView:_onOpenLogin()
    G_GameAgent:openLoginPlatform()
end
--
function LoginView:showLoginNotice()
    if ccexp.WebView then
        local url = G_ConfigManager:getPopupUrlI18n()
        if url ~= nil and url ~= "" then
            -- popup.signal:add(
            --     function(event)
            --         if event == "close" then
            --             -- 自动登录
            --         end
            --     end
            -- )
            local PopupNotice = require("app.ui.PopupNotice")
            local popup = PopupNotice:create(url, nil)
            popup:openAutoLogin()
        else
            -- 自动登录
            G_GameAgent:openLoginPlatform()
        end
    else
        -- 自动登录
        G_GameAgent:openLoginPlatform()
    end
end

-- 初始化sdk
function LoginView:initSDK()
    -- 如果已经初始化SDK完成，直接获取GM前端配置
    if G_GameAgent:isInit() == true then
        self:freshConfig()
    else
        G_GameAgent:initSDK()
    end
end

-- 初始化sdk返回处理
function LoginView:_onInitSDK()
    -- 标记sdk已经初始化完成，防止内更新后再次初始化sdk

    --cc.exports.SDK_INIT_FINISH = true
    self:freshConfig()
end

-- 刷新前端配置
function LoginView:_onRefreshConfig()
    self._loginView:hideView()
    self:freshConfig()
end

-- 刷新隐私协议的按钮
function LoginView:_onRefreshCheckBoxService()
    local AgreementSetting = require("app.data.AgreementSetting")
    self._checkBoxPrivacy:setSelected(AgreementSetting.isAgreementCheck(AgreementSetting.getPrivacyWords()))
    self._checkBoxService:setSelected(AgreementSetting.isAgreementCheck("check"))
end

-- 刷新GM前端配置
function LoginView:freshConfig()
    --
    G_WaitingMask:showWaiting(true)
    G_ConfigManager.signal:addOnce(
        function(event, opId, opgameId)
        --
        if G_ConfigManager:isAppstore() then
            local params = {
                hideWeixin = "true",
                hideQQ = "true",
                boundIdCardType = "1",
                payEnvironment = "1"
            }
            G_NativeAgent:setPluginParams("TopSdkUserYokaAppstore", params)
        end
        
        if not Lang.checkLang(Lang.CN) then
            self._loginView:_createI18n()
        end
       
        G_WaitingMask:showWaiting(false)
        if event == "success" then
            self:checkAppVersion()
        else
            -- 获取失败点击重试
            local callback = function ()
                self:freshConfig()
            end
            if not Lang.checkLang(Lang.CN) then
                UIPopupHelper.popupOkDialog(nil,Lang.getImgText("gm_config_download_fail",{opId = opId,opgameId = opgameId}),callback)
            else    
	                UIPopupHelper.popupOkDialog(nil, "连接失败，请确保您的网络连接畅通！", callback)
            end
        end
    end)
    print("freshConfig")
    G_ConfigManager:fresh()
end

-- 检查整包版本号
function LoginView:checkAppVersion()
    --i18n custom event
    G_NativeAgent:eventCustom("AT_First_Open", '')

    local latestRunCode = G_ConfigManager:getRunCode()
    local currentRunCode = G_NativeAgent:getRunCode()

    if currentRunCode < latestRunCode then
        -- 检查runcode,如果runcode小于GM前端配置视为失效版本
        local callback = function()
            return true
        end
        if Lang.checkLang(Lang.CN) then
            UIPopupHelper.popupOkDialog(nil,G_ConfigManager:getRunCodeDesc(),callback,"我知道了")
        else
            UIPopupHelper.popupOkDialog(nil,G_ConfigManager:getRunCodeDesc(),callback, Lang.getImgText("i_know"))
        end
        
        return
    end

    local latestAppVersion = G_ConfigManager:getAppVersion()
    local currentAppVersion = G_NativeAgent:getAppVersion()

    local r = Version.compare(latestAppVersion, currentAppVersion)
    if r == Version.LATEST then
        local platform = G_NativeAgent:getNativeType()
        local appVersionUrl = G_ConfigManager:getAppVersionUrl()
        local appVersionDesc = G_ConfigManager:getAppVersionDesc()
        local appVersionType = G_ConfigManager:getAppVersionType()
        if appVersionType == "json" then
            local appVersionData = json.decode(appVersionUrl)
            if appVersionData then
                if appVersionData[platform] ~= nil then
                    appVersionUrl = appVersionData[platform]["url"]
                    appVersionType = appVersionData[platform]["type"]
                end
            end
        end

        --
        if appVersionUrl ~= nil and appVersionUrl ~= "" and appVersionType ~= nil and appVersionType ~= "" then
            local callback = function()
                if platform == "ios" then
                    G_NativeAgent:openURL(appVersionUrl)
                elseif platform == "android" then
                    if appVersionType == "download" then
                        G_NativeAgent:downloadApk(appVersionUrl)
                    else
                        G_NativeAgent:openURL(appVersionUrl)
                    end
                end
                return true
            end
            local tip = "发现新版本可以安装"
            if not Lang.checkLang(Lang.CN) then
                tip = Lang.getImgText("find_new_version")
            end
            if appVersionDesc ~= nil and appVersionDesc ~= "" then
                tip = appVersionDesc
            end

            if Lang.checkLang(Lang.CN) then
                UIPopupHelper.popupOkDialog(nil,tip,callback,"立即更新")
            else
                UIPopupHelper.popupOkDialog(nil,tip,callback,Lang.getImgText("update_now"))
            end
        else
			if Lang.checkLang(Lang.CN) then
                UIPopupHelper.popupOkDialog(
	                nil,
	                "APP更新出错了",
	                function()
	                end,
	                "我知道了"
	            )
            else
                UIPopupHelper.popupOkDialog(nil,Lang.getImgText("app_update_error"),function ()
                
                end,Lang.getImgText("i_know"))
            end
        end
    else
        self:checkResVersion()
    end
end

-- 检查GM后台配置版本号
function LoginView:checkResVersion()
    local latestResVersion = G_ConfigManager:getResVersion()
    if latestResVersion == "check" then
        self:checkUpdate()
    else
        local currentResVersion = VERSION_RES
        local r = Version.compare(latestResVersion, currentResVersion)
        if r == Version.LATEST then
            --检查到有新版本
            if Lang.checkUI("ui4") then
                -- i18n ja 移除语音分包下载
                local AudioPatchHelper = require("app.scene.view.audiopatch.AudioPatchHelper")
                AudioPatchHelper.removePopupAudioPatch()
            end
            self:checkUpdate()
        else
            self:showLoginView()
        end
    end
end

-- 检查版本
function LoginView:checkUpdate()
    print("LoginView:checkResVersion---------------------")
    local url = G_ConfigManager:getResVersionUrl()
    -- create AssetsManagerEx
    if self._upgrade == nil then
        print("LoginView:checkResVersion-1")
        self._upgrade = cc.AssetsManagerEx:create(VERSION_RES, url, cc.FileUtils:getInstance():getWritablePath())
        self._upgrade:retain()
        self._upgradeListener = cc.EventListenerAssetsManagerEx:create(self._upgrade, handler(self, self.onUpdateEvent))
        cc.Director:getInstance():getEventDispatcher():addEventListenerWithFixedPriority(self._upgradeListener, 1)
    else
        print("LoginView:checkResVersion-2")
    end

    -- check
    print("LoginView:checkResVersion-3")
    --G_widgets:getWaiting():showWaiting(true)
    self._upgrade:checkUpdate(url)
    print("LoginView:checkResVersion---------------------")
    -- 推送开始检查内更新的事件
    G_NativeAgent:eventCheckversionStart()
end

--
function LoginView:onUpdateEvent(event)
    local eventCode = event:getEventCode()

    if eventCode == cc.EventAssetsManagerEx.EventCode.ERROR_NO_LOCAL_MANIFEST then
        --
    elseif eventCode == cc.EventAssetsManagerEx.EventCode.ERROR_PARSE_MANIFEST then
        -- 推送检查内更新失败事件
        G_NativeAgent:eventCheckversionFailed()
        -- 版本信息解析失败
        local txt = Lang.get("login_update_version_error")
        local callback = function()
            self:checkUpdate()
        end

        UIPopupHelper.popupOkDialog(nil, txt, callback)
    elseif eventCode == cc.EventAssetsManagerEx.EventCode.NEW_VERSION_FOUND then
        -- 检查到新版本需要更新
        local assetId = event:getAssetId()
        local totalSize = math.ceil(event:getPercentByFile() / 1024 / 1024 * 100) / 100
        local txt = string.format(Lang.get("login_update_hint"), totalSize)
        print("new version file size = " .. totalSize)

        local callback = function()
            self:showUpdateView(assetId)
            self._updateView:setTotalSize(totalSize)
            self._upgrade:update()
            -- i18n ja CDN开始加载
            G_NativeAgent:eventCustom("AT_Res_Start", '')
        end

        if Lang.checkUI("ui4") then
            UIPopupHelper.popupVersionUpdate(txt,callback,Lang.get("login_update_button_title"),Lang.get("login_update_giveup_title"))
        else
            UIPopupHelper.popupOkDialog(nil, txt, callback, Lang.get("login_update_button_title"))
        end
    elseif eventCode == cc.EventAssetsManagerEx.EventCode.UPDATE_PROGRESSION then
        -- 进度
        local assetId = event:getAssetId()
        local percent = event:getPercent()
        print("assetId = " .. assetId .. ", percent = " .. percent)
        if assetId == cc.AssetsManagerExStatic.VERSION_ID then
        elseif assetId == cc.AssetsManagerExStatic.INSTALL_ID then
            print("install assets")
            self._updateView:setProgressPercent(percent)
            self._updateView:setProgressString(Lang.get("login_update_install"))
        else
            self._updateView:setPercent(percent)
        end
    elseif eventCode == cc.EventAssetsManagerEx.EventCode.ALREADY_UP_TO_DATE then
        -- 推送检查内更新完成事件
        G_NativeAgent:eventCheckversionSucceed()
        -- 无需更新，打开登陆界面
        self:showLoginView()
    elseif eventCode == cc.EventAssetsManagerEx.EventCode.UPDATE_FINISHED then
        -- i18n ja CDN完成加载
        G_NativeAgent:eventCustom("AT_Res_Finish", '')
        -- 推送检查内更新完成事件
        G_NativeAgent:eventCheckversionSucceed()
        -- 更新完成，重新加载游戏
        print("Update finished.")
        self:reloadModule()
        print("reloadModule finished.")
    elseif eventCode == cc.EventAssetsManagerEx.EventCode.ERROR_UPDATING then
        -- 推送检查内更新失败事件
        G_NativeAgent:eventCheckversionFailed()

        local txt = Lang.get("login_update_error", {curlecode = event:getCURLECode(), httpcode = event:getHTTPCode()})
        local callback = function()
            self:checkUpdate()
        end

        UIPopupHelper.popupOkDialog(nil, txt, callback)
    end
end

--
function LoginView:reloadModule()
    self._updateView:setProgressString(Lang.get("login_update_reload"))
    --
    G_GatewayListManager:clear()
    G_ServerListManager:clear()

    G_SignalManager:clear()

    G_UserData:clear()
    G_GameAgent:clear()
    G_NativeAgent:clear()
    G_NetworkManager:clear()
    G_SceneManager:clear()
    G_RecoverMgr:clear()
    G_TutorialManager:clear()
    G_BulletScreenManager:clear()
    G_ServiceManager:stop()
    G_RollNoticeService:clear()
    G_MineNoticeService:clear()
    G_RealNameService:clear()
    G_GuildSnatchRedPacketServe:clear()
    G_SpineManager:clear()

    G_WaitingMask:clear()
    G_TouchEffect:clear()
    G_TopLevelNode:clear()
    G_AudioManager:clear()
    --
    cc.CSLoader:getInstance():removeAllCacheReaders()
    sp.SpineCache:getInstance():removeSpines()
    cc.SpriteFrameCache:getInstance():removeSpriteFrames()
    cc.Director:getInstance():getTextureCache():removeAllTextures()
    cc.Director:getInstance():purgeCachedData()
    --
    cc.enable_global()
    local function tableContain(t, key)
        for _, v in ipairs(t) do
            if v == key then
                return true
            end
        end
        return false
    end
    for k, _ in pairs(package.loaded) do
        if not tableContain(g_package_loaded, k) then
            package.loaded[k] = nil
            print("package.loaded = " .. k)
        end
    end
    for k, _ in pairs(_G) do
        if not tableContain(g_G, k) then
            _G[k] = nil
            print("_G = " .. k)
        end
    end
    collectgarbage("collect")
    watchVideo = true

    require("main.lua")
end

--[[
function LoginView:_createAgreementRichNode()
	self._richNodeAgreement:removeAllChildren()
	local richText = Lang.get("login_copyright_info_3")
	local widget = ccui.RichText:createWithContent(richText)
	widget:setAnchorPoint(cc.p(0, 0.5))
	self._richNodeAgreement:addChild(widget)
end
]]
function LoginView:_onClickCheckBox(sender)
    local AgreementSetting = require("app.data.AgreementSetting")
    if sender == self._checkBoxService then
        AgreementSetting.saveAgreementIsCheck(sender:isSelected(), "check")
    elseif sender == self._checkBoxPrivacy then
        AgreementSetting.saveAgreementIsCheck(sender:isSelected(), AgreementSetting.getPrivacyWords())
    end
end

function LoginView:_onClickPrivacyAgreement(sender)
    if Lang.checkLang(Lang.CN) then
        --G_NativeAgent:openURL("http://mjz.sanguosha.com/static/privacy/")
    	G_SceneManager:showDialog("app.scene.view.login.PopupSecretView", nil, nil, nil, 2)
    end
end

function LoginView:_onClickServiceAgreement(sender)
    if Lang.checkLang(Lang.CN) then
         --G_NativeAgent:openURL("http://register.dobest.cn/public/service_agreements.html?v1")
    	G_SceneManager:showDialog("app.scene.view.login.PopupSecretView", nil, nil, nil, 1)
    end
end


-- i18n change lable
function LoginView:_dealI18n()
    if not Lang.checkLang(Lang.CN) then
        local function convertNone(str)
            if str == "None" then
                return ""
            end
            return str
        end
		local UIHelper  = require("yoka.utils.UIHelper")
        local privateText1 = UIHelper.seekNodeByName(self._nodeAgreementContent,"Text1")
        privateText1:setString(convertNone(privateText1:getString()))
        local privateText2 = UIHelper.seekNodeByName(self._nodeAgreementContent,"Text1_1")
        local line1 = UIHelper.seekNodeByName(self._nodeAgreementContent,"Text1_1_0")
        
        local serviceText1 = UIHelper.seekNodeByName(self._nodeAgreementContent,"Text2")
        serviceText1:setString(convertNone(serviceText1:getString()))
        local serviceText2 = UIHelper.seekNodeByName(self._nodeAgreementContent,"Text1_0")
        local line2 = UIHelper.seekNodeByName(self._nodeAgreementContent,"Text1_1_1")

        privateText1:setAnchorPoint(cc.p(0,0.5))
        privateText1:setPositionX(self._checkBoxPrivacy:getPositionX()+self._checkBoxPrivacy:getContentSize().width*0.5+2)
        
        privateText2:setAnchorPoint(cc.p(0,0.5))
        privateText2:setPositionX(privateText1:getPositionX()+privateText1:getContentSize().width)
        line1:setVisible(false)
        self._panelPrivacyTouch:setContentSize(cc.size(privateText1:getContentSize().width+privateText2:getContentSize().width,self._panelPrivacyTouch:getContentSize().height))
        local x1 = privateText1:getPositionX()+privateText1:getContentSize().width
        local y1 = privateText2:getPositionY()-8

        local drawNode = cc.DrawNode:create()
        drawNode:drawLine(cc.p( x1, y1),cc.p(x1 + privateText2:getContentSize().width,y1), cc.c4f(0x99/255, 0xCE/255, 0x1B/255,1))
   

        serviceText1:setAnchorPoint(cc.p(0,0.5))
        serviceText1:setPositionX(self._checkBoxService:getPositionX()+self._checkBoxService:getContentSize().width*0.5+2)

        serviceText2:setAnchorPoint(cc.p(0,0.5))
        serviceText2:setPositionX(serviceText1:getPositionX()+serviceText1:getContentSize().width)
        line2:setVisible(false)
        self._panelServiceTouch:setContentSize(cc.size(serviceText1:getContentSize().width+serviceText2:getContentSize().width,self._panelServiceTouch:getContentSize().height))
        
        local x2 = serviceText1:getPositionX()+serviceText1:getContentSize().width
        local y2 = serviceText2:getPositionY()-8
        drawNode:drawLine(cc.p( x2, y2),cc.p(x2 + serviceText2:getContentSize().width,y2), cc.c4f(0x99/255, 0xCE/255, 0x1B/255,1))
        self._nodeAgreementContent:addChild(drawNode)    

	end
end


return LoginView
