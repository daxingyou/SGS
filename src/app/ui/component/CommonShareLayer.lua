
local CommonShareLayer = class("CommonShareLayer")
local UIActionHelper = require("app.utils.UIActionHelper")
local EXPORTED_METHODS = {
    "setShowHideCallback",
    "setDownloadFileName",
    "setPopShareCallback",
    "updateData",
}

function CommonShareLayer:ctor()
    self._target = nil
    self._callback = nil
    self._downloadName = nil
end

--播放左右浮动动画
function CommonShareLayer:playFloatXEffect( node )
	-- body
	if not node then return end

	--不需要重复执行
	if node:getActionByTag(678) then
		return
	end

	local action1 = cc.MoveBy:create(0.75, cc.p(5, 0))
	local fade1 = cc.FadeTo:create(0.75,255)
	local spawn1 = cc.Spawn:create(action1,fade1)

	local action2 = cc.MoveBy:create(0.75, cc.p(-5, 0))
	local fade2 = cc.FadeTo:create(0.75,255*0.5)
	local spawn2 = cc.Spawn:create(action2,fade2)

	local seq = cc.Sequence:create(spawn1,spawn2)
	local rep = cc.RepeatForever:create(seq)
	rep:setTag(678)

	node:runAction(rep)
end


function CommonShareLayer:_init()
    self._nodePlatform = ccui.Helper:seekNodeByName(self._target, "NodePlatform")
    self._imageShare = ccui.Helper:seekNodeByName(self._target, "ImageShare")
    self._nodeShareRewardParent = ccui.Helper:seekNodeByName(self._target, "NodeShareRewardParent")
    self._nodeShareReward = ccui.Helper:seekNodeByName(self._target, "NodeShareReward")
    self._panel = ccui.Helper:seekNodeByName(self._target, "Panel")
    self._imageX = ccui.Helper:seekNodeByName(self._target, "ImageX")
    self._panelTwitter = ccui.Helper:seekNodeByName(self._target, "Panel_Twitter")
    self._panelDownload = ccui.Helper:seekNodeByName(self._target, "Panel_Download")
    self._nodeRich = ccui.Helper:seekNodeByName(self._target, "NodeRich")
    self._imageArrow = ccui.Helper:seekNodeByName(self._target, "ImageArrow")
    
    
    self._nodeShareUI = ccui.Helper:seekNodeByName(self._target, "NodeShareUI")
    self._nodeUserInfo = ccui.Helper:seekNodeByName(self._target, "NodeUserInfo")
    self._nodeUserInfo:setVisible(false)

    self:playFloatXEffect(self._imageArrow)
   

    self._imageShare:addClickEventListenerEx(handler(self,self._onShareClickCallBack))
    self._imageX:addClickEventListenerEx(handler(self,self._onXClickCallBack))
    self._panelTwitter:addClickEventListenerEx(handler(self,self._onShareTwitter))
    self._panelDownload:addClickEventListenerEx(handler(self,self._onDownload))
    self:_showSharePanel(false)


    self._target:onNodeEvent("exit", function ()
        logWarn("CommonShareLayer exit .......")
        self._signalWeelShareReward:remove()
        self._signalWeelShareReward = nil
        self._signalShareResultNotice:remove()
        self._signalShareResultNotice = nil
        self._signalCaptureResultNotice:remove()
        self._signalCaptureResultNotice = nil
    end)

     self._target:onNodeEvent("enter", function ()
        logWarn("CommonShareLayer enter .......")
        self._signalWeelShareReward = G_SignalManager:add(SignalConst.EVENT_WEEK_SHARE_REWARD, 
            handler(self,self._onEventWeelShareReward))
        self._signalShareResultNotice = G_SignalManager:add(SignalConst.EVENT_SHARE_RESULT_NOTICE,
             handler(self,self._onEventShareResultNotice))
        self._signalCaptureResultNotice = G_SignalManager:add(SignalConst.EVENT_CAPTURED_RESULT_NOTICE,
             handler(self,self._onEventCaptureResultNotice))
    end)

    self._target:onNodeEvent("cleanup", function ()
        self._callback = nil
        self._popView = nil
        self._popShareCallback = nil
        self._target = nil
    end)

    

    self._nodeRich:removeAllChildren()
    local CommonAward = require("app.config.common_award")
    local config =  CommonAward.get(8)
    
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local content = json.decode(Lang.get("show_hero2_share_reward",{num = config.size1}))
    for k,v in ipairs(content) do
        if v.type == "custom" then
            local param = TypeConvertHelper.convert(config.type1,config.value1)
            local sprite = display.newSprite(param.res_mini)
            local spriteSize = sprite:getContentSize()
            local node = cc.Node:create()
            node:addChild(sprite)
            node:setContentSize(cc.size(spriteSize.width,18))
            sprite:setPosition(spriteSize.width*0.5,12)
            v.customNode = node
            v.opacity = 255
        end
    end
    
    local label = nil
    if Lang.checkLang(Lang.CN) then
        label = ccui.RichText:create()
    else
        label = ccui.RichText:createByI18n()         
    end
    label:setRichText(content)
    label:setVerticalSpace(5)
    label:ignoreContentAdaptWithSize(false)
    label:setContentSize(cc.size(210, 0))
    label:formatText()
    
    label:setAnchorPoint(cc.p(0.5,0.5))
    self._nodeRich:addChild(label)
end

function CommonShareLayer:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)

    cc.bind(self._nodeUserInfo, "CommonShareUserInfo")
end

function CommonShareLayer:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
    cc.unbind(self._nodeUserInfo, "CommonShareUserInfo")
end


function CommonShareLayer:_showSharePanel(show)
    if show then
        self._panel:setVisible(true)
        self._nodePlatform:setVisible(true)
        self._imageShare:setVisible(false)
        self._nodeShareRewardParent:setVisible(false)
    else
        self._panel:setVisible(false)
        self._nodePlatform:setVisible(false)
        self._imageShare:setVisible(true)
        self._nodeShareRewardParent:setVisible(true)
    end
    if self._popShareCallback then
        self._popShareCallback(show)
    end
end

function CommonShareLayer:_onXClickCallBack(sender,state)
    self:_showSharePanel(false)
end

function CommonShareLayer:_onShareClickCallBack(sender,state)
    self:_showSharePanel(true)
end

function CommonShareLayer:_onShareTwitter(sender,state)
    logWarn("CommonShareLayer  onShareTwitter click")
    self:_startShare()
end

function CommonShareLayer:_onDownload(sender,state)
    self:_startDownload()

    local platform = G_NativeAgent:getNativeType()
    if platform == "windows" then
        local NativeConst = require("app.const.NativeConst")
        local fileName = Lang.getTxt( NativeConst.SDK_DOWNLOAD_IMG_NAME,
            { name = tostring(G_ServerTime:getTime()) }) --tostring(self._downloadName)..

        local imagePath = cc.FileUtils:getInstance():getWritablePath()..fileName
        print("imagePath "..imagePath)

        local SchedulerHelper = require("app.utils.SchedulerHelper")
        self._countDownHandler = SchedulerHelper.newScheduleOnce(
            function() 
               -- G_SignalManager:dispatch(SignalConst.EVENT_CAPTURED_RESULT_NOTICE,...)
                self:_showHideUI(true)
                --测试
                local weekShare = G_UserData:getBase():hasDoWeekShare()
                if not weekShare then
                    G_UserData:getBase():c2sWeekShare()
                end
            end, 3)
            --[[
        local seq = cc.Sequence:create(cc.DelayTime:create(3),cc.CallFunc:create(function(actionNode)
          
        end))
         self._target:runAction(seq)
]]
       
        self:_showHideUI(false)
        
    end
end


function CommonShareLayer:_startDownload()
    local platform = G_NativeAgent:getNativeType()
    logWarn("CommonShareLayer download ")
    if platform ~= "ios" and platform ~= "android" then
        return
    end
    logWarn("PopupCitationCode save photo takePhoto ")
	local NativeConst = require("app.const.NativeConst")
	local FileUtils = cc.FileUtils:getInstance()
	logWarn(FileUtils:getWritablePath())

	local imagePath =  cc.FileUtils:getInstance():getWritablePath()..NativeConst.SDK_TEMP_CITATIONCODE_IMG
	local function doShare()
		logWarn("PopupCitationCode save photo doShare ")
		G_NativeAgent:savePhoto(imagePath)
	end

	local function afterCaptured( success, fileName )
		if success then
			logWarn("PopupCitationCode save capture successs ")
			doShare()
		else
			logWarn("PopupCitationCode save capture fail ")
			G_Prompt:showTip("capture fail")	
        end
        self:_showHideUI(true)
        
	end
    self:_showHideUI(false)
	cc.utils:captureScreen(function( ... )
        afterCaptured( ... )
      
		logWarn("PopupCitationCode save photo close ")
		
	end,imagePath)
end

function CommonShareLayer:_startShare()
	print("CommonShareLayer: share")
	local platform = G_NativeAgent:getNativeType()
	if platform == "ios" or platform == "android" then
		local NativeConst = require("app.const.NativeConst")
		-- self:_takePhoto(NativeConst.SDK_CHANNEL_TWITTER, NativeConst.SDK_SHARE_IMAGE)
		local channel = NativeConst.SDK_CHANNEL_TWITTER
		self:_takePhoto(channel, NativeConst.SDK_SHARE_IMAGE)
    end
    

end

function CommonShareLayer:_takePhoto( channel, type )
	logWarn("CommonShareLayer Share takePhoto ")
	if not type or not channel then return end
	local NativeConst = require("app.const.NativeConst")
	local FileUtils = cc.FileUtils:getInstance()
	logWarn(FileUtils:getWritablePath())

    
	local function doShare()
		local FileUtils = cc.FileUtils:getInstance()
        G_GameAgent:shareImage(channel, type, 
            FileUtils:getWritablePath()..NativeConst.SDK_SHARE_IMG_NAME,Lang.get("share_comment")
        )
	end

	local function afterCaptured( success, fileName )
		if success then
			logWarn("PopupPlayerDetail Share capture successs ")
			doShare()
		else
			logWarn("PopupPlayerDetail Share capture fail ")
			G_Prompt:showTip("capture fail")	
        end
        self:_showHideUI(true)
	end

    self:_showHideUI(false)


    cc.utils:captureScreen(function( ... )
       
		afterCaptured( ... )
	end,FileUtils:getWritablePath()..NativeConst.SDK_SHARE_IMG_NAME)

end


function CommonShareLayer:_showHideUI(show)
    if not self._target then
        return
    end
    local popView = self._popView
    if not popView then
        popView = self._target:getParent()
    end
    if popView then
        local list = {}
        local UIHelper = require("yoka.utils.UIHelper")
        UIHelper.seekNodeListByName(popView,"share_control",list)
        for k,v in ipairs(list) do
            v:setVisible(show)
        end
    end

    self._nodeUserInfo:updateUI()
    self._nodeUserInfo:setVisible(not show)
    self._nodeShareUI:setVisible(show)
    if self._callback then
        self._callback(show)
    end
end

function CommonShareLayer:setShowHideCallback(callback,popView)
    
    self._callback = callback
    self._popView = popView
end

function CommonShareLayer:setPopShareCallback(callback)
    self._popShareCallback = callback
end

function CommonShareLayer:setDownloadFileName(downloadName)
    self._downloadName = downloadName
end

function CommonShareLayer:updateData()
    self:_refreshReward()
end

function CommonShareLayer:_refreshReward()
    local weekShare = G_UserData:getBase():hasDoWeekShare()
    self._nodeShareReward:setVisible(not weekShare)
end

function CommonShareLayer:_onEventWeelShareReward(event,awards)
    self:_refreshReward()
    G_Prompt:showAwards(awards)
end


function CommonShareLayer:_onEventShareResultNotice(event,ret)
    local NativeConst = require("app.const.NativeConst")
    if ret == NativeConst.STATUS_SUCCESS then
        --G_Prompt:showTip(Lang.get("common_share_success"))
        local weekShare = G_UserData:getBase():hasDoWeekShare()
        if not weekShare then
            G_UserData:getBase():c2sWeekShare()
        end
		
	end

end

function CommonShareLayer:_onEventCaptureResultNotice(event,success,fileName)

end

return CommonShareLayer