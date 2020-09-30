local ViewBase = require("app.ui.ViewBase")
local ServiceNode = class("ServiceNode", ViewBase)
local DataConst = require("app.const.DataConst")
local ServiceButtonNode = require("app.scene.view.playerDetail.ServiceButtonNode")
local PopupServiceTips = require("app.scene.view.playerDetail.PopupServiceTips")
local PopupHelpRule = require("app.ui.PopupHelpRule")

local btnList = {
	{icon = "img_customer", text = Lang.get("player_detail_service_customer"), callback = "_onCustomer"},
	{icon = "img_twitter", text = Lang.get("player_detail_service_twitter"), callback = "_onTwitter"},
	{icon = "img_lobi", text = Lang.get("player_detail_service_lobi"), callback = "_onLobi"},
	{icon = "img_strategy", text = Lang.get("player_detail_service_strategy"), callback = "_onStrategy"},
	{icon = "img_rule", text = Lang.get("player_detail_service_rule"), callback = "_onRule"},
	{icon = "img_private", text = Lang.get("player_detail_service_private"), callback = "_onPrivate"},
	-- {icon = "img_language", text = Lang.get("player_detail_service_language"), callback = "_onLanguage"},
	-- i18n ja 新增临时测试函数 后期会删除
	-- {icon = "img_private", text = Lang.get("LIVE2D"), callback = "_onClickTempLive2d"},
	-- {icon = "img_private", text = Lang.get("CitationLogin"), callback = "_onClickTempCitationLogin"},
	-- {icon = "img_private", text = Lang.get("ShareFacebook"), callback = "_onClickTempShareFb"},
	-- {icon = "img_private", text = Lang.get("ShareTwitter"), callback = "_onClickTempShareTw"},
	-- {icon = "img_private", text = Lang.get("ShareLINE"), callback = "_onClickTempShareLINE"},
}

function ServiceNode:ctor()
	local resource = {
		file = Path.getCSB("ServiceNode", "playerDetail"),
		binding = {
			_commonTip = {
				events = {{event = "touch", method = "_onClickTip"}}
			},
		}
	}
	self:setName("ServiceNode")
	ServiceNode.super.ctor(self, resource)
end

function ServiceNode:onCreate()
	self._freeDesc:setString(Lang.get("player_detail_service_free"))
	local freeCount = G_UserData:getBase():getResValue(DataConst.RES_DIAMOND)
	self._freeNum:setString(freeCount)
	self._freeNum:setPositionX(self._freeDesc:getPositionX()+self._freeDesc:getContentSize().width+5)
	self._paidDesc:setString(Lang.get("player_detail_service_paid"))
	local paidCount = G_UserData:getBase():getResValue(DataConst.RES_JADE2)
	self._paidNum:setString(paidCount)
	self._paidDesc:setPositionX(self._paidNum:getPositionX()-self._paidNum:getContentSize().width-5)

	for i, v in ipairs(btnList) do
		local btn = ServiceButtonNode.new(v.icon,v.text,handler(self, self[v.callback]))
		self._btnNode:addChild(btn)
		local posX = 120 + (i - 1) % 3 * 210
		local posY = 404 - (math.ceil(i/3) - 1) * 109
		btn:setPosition(posX,posY)
	end
end

function ServiceNode:_onClickTip()
	local popup = PopupServiceTips.new(self._commonTip)
	popup:open()
end

function ServiceNode:_onCustomer()
	print("_onCustomer")
	if G_NativeAgent:hasService() then
		G_NativeAgent:openService()
	 end
end

function ServiceNode:_onTwitter()
	print("_onTwitter")
	self:_openURL("twitter")
end

function ServiceNode:_onLobi()
	print("_onLobi")
	if G_NativeAgent:hasForum() then
		G_NativeAgent:openForum()
	end
end

function ServiceNode:_onStrategy()
	print("_onStrategy")
	self:_openURL("forum")
end

function ServiceNode:_onRule()
	print("_onRule")
	local rule = PopupHelpRule.new("UsingConvente_btn_des1", "rule_user_agree")
	rule:openWithAction()
end

function ServiceNode:_onPrivate()
	print("_onPrivate")
	local rule = PopupHelpRule.new("UsingConvente_btn_des2", "rule_privacy_policy")
	rule:openWithAction()
end

function ServiceNode:_onLanguage()
	print("_onLanguage")
end

function ServiceNode:_openURL(urlType)
	local urlJson = G_ConfigManager:getCenterForumUrl()
	local urlList = json.decode(urlJson)
	assert(urlList, "centerForumUrl not configure")
	local url = urlList[urlType]
	if url == nil or url == "" then
		G_Prompt:showTip(Lang.get("player_detail_not_open"))
		return
	end
	-- assert(url, "centerForumUrl not configure for "..urlType)
	G_NativeAgent:openURL(url)
end

function ServiceNode:onEnter()
end

function ServiceNode:onExit()
end


------------------------------- i18n ja 新增一些临时函数 后期删除掉------------------------------------
function ServiceNode:_onClickTempLive2d()
	print("ServiceNode:_onClickTempLive2d() ")
	if not self._live2dMode and l2d and l2d.Model then
		local scene = self:getResourceNode()
		local live2d_motion = "TapBody"
		-- local model = l2d.Model:create('Haru', 'Haru.model3.json')
		-- local model = l2d.Model:create('Hiyori', 'Hiyori.model3.json')
		-- local model = l2d.Model:create('Mark', 'Mark.model3.json')
		-- local model = l2d.Model:create('Natori', 'Natori.model3.json')
		local model = l2d.Model:create('live2d/res/Rice', 'Rice.model3.json')
		scene:addChild(model)
		-- model:setPosition(display.center)
		model:setTouchEnabled(true)
		model:setAutoDragging(true)
		-- model:startRandomMotion(live2d_motion,1)
		model:startMotion( live2d_motion,0,1)
		model:addClickEventListener(handler(self,function()
			model:startRandomMotion(live2d_motion,2)
			-- model:startMotion( live2d_motion,1,2)
			-- print('model add click')
			local pos = model:getTouchEndPosition()
			-- dump(pos,"pos")
			if model:areaHitTest('Head', pos.x, pos.y) then
				print('hit at head')
			end
		end))
		self._live2dMode = model
	end
end

function ServiceNode:_onClickTempCitationLogin()
	print("ServiceNode:_onClickTempCitationLogin() ")
	if G_NativeAgent:hasCitationCode() then
		local PopupCitationLogin = require("app.ui.PopupCitationLogin")
		local popup = PopupCitationLogin.new(function(code,password)
			print("ServiceNode:_onClickTempCitationLogin() code = " .. code)
			print("ServiceNode:_onClickTempCitationLogin() password = " .. password)
			G_NativeAgent:loginWithCitationCode(code,password)
		end)
		popup:openWithAction()
	end
end


-- NativeConst.SDK_CHANNEL_GUEST 			    = "guest"           --i18n sdk 游客
-- NativeConst.SDK_CHANNEL_FACEBOOK 			= "facebook"        --i18n sdk facebook
-- NativeConst.SDK_CHANNEL_TWITTER 			= "twitter"         --i18n sdk twitter
-- NativeConst.SDK_CHANNEL_LINE       			= "line"            --i18n sdk line
-- NativeConst.SDK_CHANNEL_GAMECENTER			= "gamecenter"      --i18n sdk gamecenter
-- NativeConst.SDK_CHANNEL_GOOGLE			    = "google"          --i18n sdk google
-- NativeConst.SDK_CHANNEL_APPLE			    = "apple"           --i18n sdk apple
-- NativeConst.SDK_CHANNEL_CITATIONCODE		= "citationcode"    --i18n sdk 引继码

-- {icon = "img_private", text = Lang.get("ShareFacebook"), callback = "_onClickTempShareFb"},
-- {icon = "img_private", text = Lang.get("ShareTwitter"), callback = "_onClickTempShareTw"},
-- {icon = "img_private", text = Lang.get("ShareLine"), callback = "_onClickTempShareLine"},
function ServiceNode:_onClickTempShareFb()
	print("ServiceNode:_onClickTempShareFb() ")
	local platform = G_NativeAgent:getNativeType()
	if platform == "ios" or platform == "android" then
		local NativeConst = require("app.const.NativeConst")
		local channel = NativeConst.SDK_CHANNEL_FACEBOOK;
		self:_takePhoto(channel, NativeConst.SDK_SHARE_IMAGE)
	end
end

function ServiceNode:_onClickTempShareTw()
	print("ServiceNode:_onClickTempShareTw() ")
	local platform = G_NativeAgent:getNativeType()
	if platform == "ios" or platform == "android" then
		local NativeConst = require("app.const.NativeConst")
		local channel = NativeConst.SDK_CHANNEL_TWITTER;
		self:_takePhoto(channel, NativeConst.SDK_SHARE_IMAGE)
	end
end

function ServiceNode:_onClickTempShareLine()
	print("ServiceNode:_onClickTempShareLine() ")
	local platform = G_NativeAgent:getNativeType()
	if platform == "ios" or platform == "android" then
		local NativeConst = require("app.const.NativeConst")
		local channel = NativeConst.SDK_CHANNEL_LINE;
		self:_takePhoto(channel, NativeConst.SDK_SHARE_IMAGE)
	end
end

function ServiceNode:_takePhoto( channel, type )
	logWarn("ServiceNode Share takePhoto ")
	if not type or not channel then return end
	local NativeConst = require("app.const.NativeConst")
	local FileUtils = cc.FileUtils:getInstance()
	logWarn(FileUtils:getWritablePath())

	local function doShare()
		local FileUtils = cc.FileUtils:getInstance()
		G_GameAgent:shareImage(channel, type, FileUtils:getWritablePath()..NativeConst.SDK_SHARE_IMG_NAME,Lang.get("share_comment"))
	end

	local function afterCaptured( success, fileName )
		if success then
			logWarn("ServiceNode Share capture successs ")
			doShare()
		else
			logWarn("ServiceNode Share capture fail ")
			G_Prompt:showTip("capture fail")	
		end
	end

	-- cc.utils:captureScreen(handler(self,self._afterCaptured),FileUtils:getWritablePath()..NativeConst.SDK_SHARE_IMG_NAME)
	cc.utils:captureScreen(function( ... )
		afterCaptured( ... )
	end,FileUtils:getWritablePath()..NativeConst.SDK_SHARE_IMG_NAME)
end

return ServiceNode
