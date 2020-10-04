local PopupBase = require("app.ui.PopupBase")
local PopupNotice = class("PopupNotice", PopupBase)
local Path = require("app.utils.Path")

--
function PopupNotice:ctor(url, title)
    self._url = url
    self._title = title
    self._autoLogin = false
    local resource = {
        file = Path.getCSB("PopupNotice", "common"),
        size = G_ResolutionManager:getDesignSize(),
        binding = {
            _commonButton = {
                events = {{event = "touch", method = "_onKnowBtn"}}
            }
        }
    }
    PopupNotice.super.ctor(self, resource, false, true)
end

--
function PopupNotice:onCreate()
	if not Lang.checkLang(Lang.CN) then
		self._popupBG:setTitle(self._title or  Lang.getImgText("login_billboard") )
	else
    	self._popupBG:setTitle(self._title or "公   告")
	end
    self._popupBG:addCloseEventListener(
        function()
            self:closeWithAction()
        end
    )

    --self._popupBG:offsetCloseButton(0,4)--按钮向上移动4个像素
    self._commonButton:setString(Lang.get("login_notice_know"))

    if G_ConfigManager:isDalanVersion() then
        local imageLogo = self._resourceNode:getChildByName("Image_1")
        if imageLogo then
            imageLogo:setVisible(false)
        end
    end
end


-- tolua_function(L, "setOnShouldStartLoading", lua_cocos2dx_experimental_WebView_setOnShouldStartLoading);
-- tolua_function(L, "setOnDidFinishLoading", lua_cocos2dx_experimental_WebView_setOnDidFinishLoading);
-- tolua_function(L, "setOnDidFailLoading", lua_cocos2dx_experimental_WebView_setOnDidFailLoading);
-- tolua_function(L, "setOnJSCallback", lua_cocos2dx_experimental_WebView_setOnJSCallback);
-- tolua_beginmodule(tolua_S,"WebView");
-- tolua_function(tolua_S,"new",lua_cocos2dx_experimental_webview_WebView_constructor);
-- tolua_function(tolua_S,"canGoBack",lua_cocos2dx_experimental_webview_WebView_canGoBack);
-- tolua_function(tolua_S,"loadHTMLString",lua_cocos2dx_experimental_webview_WebView_loadHTMLString);
-- tolua_function(tolua_S,"goForward",lua_cocos2dx_experimental_webview_WebView_goForward);
-- tolua_function(tolua_S,"goBack",lua_cocos2dx_experimental_webview_WebView_goBack);
-- tolua_function(tolua_S,"setScalesPageToFit",lua_cocos2dx_experimental_webview_WebView_setScalesPageToFit);
-- tolua_function(tolua_S,"loadFile",lua_cocos2dx_experimental_webview_WebView_loadFile);
-- tolua_function(tolua_S,"loadURL",lua_cocos2dx_experimental_webview_WebView_loadURL);
-- tolua_function(tolua_S,"setBounces",lua_cocos2dx_experimental_webview_WebView_setBounces);
-- tolua_function(tolua_S,"evaluateJS",lua_cocos2dx_experimental_webview_WebView_evaluateJS);
-- tolua_function(tolua_S,"getOnJSCallback",lua_cocos2dx_experimental_webview_WebView_getOnJSCallback);
-- tolua_function(tolua_S,"canGoForward",lua_cocos2dx_experimental_webview_WebView_canGoForward);
-- tolua_function(tolua_S,"stopLoading",lua_cocos2dx_experimental_webview_WebView_stopLoading);
-- tolua_function(tolua_S,"reload",lua_cocos2dx_experimental_webview_WebView_reload);
-- tolua_function(tolua_S,"setJavascriptInterfaceScheme",lua_cocos2dx_experimental_webview_WebView_setJavascriptInterfaceScheme);
-- tolua_function(tolua_S,"create", lua_cocos2dx_experimental_webview_WebView_create);
--
function PopupNotice:onShowFinish()
    local discSize = self._webLayer:getContentSize()
    if ccexp.WebView then
        self._webView = ccexp.WebView:create()
        self._webView:setPosition(cc.p(discSize.width / 2 - 6, discSize.height / 2))
        self._webView:setContentSize(discSize.width, discSize.height)
        self._webView:loadURL(self._url)
        self._webView:setScalesPageToFit(false)
        self._webView:setBounces(false)

        self._webLayer:addChild(self._webView)

        -- i18n change ex
        -- 设置加载流程回调
        self._webView:setOnDidFinishLoading(handler(self, self._onWebViewDidFinishLoading));
        self._webView:setOnDidFailLoading(handler(self, self._onWebViewDidFailLoading));
        self._webView:setOnShouldStartLoading(handler(self, self._onWebViewShouldStartLoading));

        -- 设置一个JS跳转的规则，local是前缀，即当跳转界面local://xxxx时，会进行回调，查看下面的OnJSCallback()函数
        -- self._webView:setJavascriptInterfaceScheme("local");

        -- --设置JS回调
        self._webView:setOnJSCallback(handler(self, self._onWebViewJSCallback));
    end
end

--[[ 
--  * 加载完成后的回调
--  * @param sender WebView
--  * @param url    链接
 ]]
function PopupNotice:_onWebViewDidFinishLoading(sender, url)
    print("PopupNotice onWebViewDidFinishLoading url = " .. url)


end

--[[ 
--  * 加载失败后的回调
--  * @param sender WebView
--  * @param url    链接
 ]]
function PopupNotice:_onWebViewDidFailLoading(sender, url)
    print("PopupNotice onWebViewDidFailLoading url = " .. url)
    -- local://?extension=213&game_system_id=33
    if url and self._url ~= url and self._activeUrl ~= url then
        local WebviewHelper = require("app.i18n.utils.WebviewHelper")
        local isLocal = WebviewHelper.isLocalUrl(url)
        local isHttp = WebviewHelper.isHttpUrl(url)
        if isLocal then
            local param = WebviewHelper.getLocalParams(url)
            dump(param,"PopupNotice onWebViewDidFailLoading param")
            if param then
                -- local://?extension=213&game_system_id=33
                local game_system_id = param["game_system_id"]
                local extension = param["extension"]
    
                local functionId = tonumber(game_system_id) 
                print("PopupNotice onWebViewDidFailLoading functionId = " .. functionId)
                local FunctionCheck = require("app.utils.logic.FunctionCheck")
                local isOpen, des = FunctionCheck.funcIsOpened(functionId)
                if isOpen then
                    self:close()
                    local WayFuncDataHelper = require("app.utils.data.WayFuncDataHelper")
                    WayFuncDataHelper.gotoModuleByFuncId(functionId, param)
                else
                    -- self:close()
                    G_Prompt:showTip(des)
                    print("PopupNotice onWebViewDidFailLoading gotoModuleByFuncId fial, is not open .  function = " .. functionId .. "  des=" .. des)
                end
            end
        end
        if isHttp then
            print("PopupNotice onWebViewDidFailLoading open http url = " .. url)
            G_NativeAgent:openURL(url)
        end
        self._activeUrl = url
    end

end

--[[ 
--  * 开始加载时的回调
--  * @param sender WebView
--  * @param url    链接
 ]]
function PopupNotice:_onWebViewShouldStartLoading(sender, url)
    print("PopupNotice onWebViewShouldStartLoading url = " .. url)
    local isActive = true
    if url and self._url ~= url and self._activeUrl ~= url then
        local WebviewHelper = require("app.i18n.utils.WebviewHelper")
        local isLocal = WebviewHelper.isLocalUrl(url)
        local isHttp = WebviewHelper.isHttpUrl(url)
        if isLocal then
            local param = WebviewHelper.getLocalParams(url)
            dump(param,"PopupNotice onWebViewDidFailLoading param")
            if param then
                -- local://?extension=213&game_system_id=33
                local game_system_id = param["game_system_id"]
                local extension = param["extension"]
    
                local functionId = tonumber(game_system_id) 
                print("PopupNotice onWebViewDidFailLoading functionId = " .. functionId)
                local FunctionCheck = require("app.utils.logic.FunctionCheck")
                local isOpen, des = FunctionCheck.funcIsOpened(functionId)
                if isOpen then
                    self:close()
                    local WayFuncDataHelper = require("app.utils.data.WayFuncDataHelper")
                    WayFuncDataHelper.gotoModuleByFuncId(functionId, param)
                else
                    -- self:close()
                    G_Prompt:showTip(des)
                    print("PopupNotice onWebViewDidFailLoading gotoModuleByFuncId fial, is not open .  function = " .. functionId .. "  des=" .. des)
                end
            end
        end
        if isHttp then
            print("PopupNotice onWebViewDidFailLoading open http url = " .. url)
            G_NativeAgent:openURL(url)
            isActive = false
        end
        self._activeUrl = url
    end
    return isActive
end


--[[ 
 * JS触发时的回调
 * @param sender WebView
 * @param url    链接
 ]]
function PopupNotice:_onWebViewJSCallback(sender, url)
    print("PopupNotice onWebViewJSCallback url = " .. url)
    local event = "local://closeKefuH5"
    if url == event then

    end
end


--
function PopupNotice:_onKnowBtn(sender)
    self:close()
end

--
function PopupNotice:onEnter()

end

--
function PopupNotice:onExit()
    if self._autoLogin then
        G_SignalManager:dispatch(SignalConst.EVENT_AUTO_LOGIN)
    end
    -- i18n ja 刷新公告红点
    if Lang.checkUI("ui4") then
        G_SignalManager:dispatch(SignalConst.EVENT_NOTICE_RED_POINT)
    end
end

--
function PopupNotice:create(url, title)
    local popup = PopupNotice.new(url, title)
    popup:openWithAction()
    return popup
end

--
function PopupNotice:closeWithAction()
    self:close()
end

--
function PopupNotice:open()
    self:setPosition(G_ResolutionManager:getDesignCCPoint())
    G_TopLevelNode:addToNoticeLevel(self)
end

function PopupNotice:openAutoLogin()
    self._autoLogin = true
end

return PopupNotice
