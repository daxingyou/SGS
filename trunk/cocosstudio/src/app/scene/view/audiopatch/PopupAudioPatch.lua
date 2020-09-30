local PopupBase = require("app.ui.PopupBase")
local UIPopupHelper = require("app.utils.UIPopupHelper")
local PopupAudioPatch = class("PopupAudioPatch", PopupBase)

function PopupAudioPatch:ctor()
	self._isSpaceEnough = true
	self._isConfirmed = false
	self._isReady = false
	self._isDownloading = false
	self._totalSize = 0
	self._totalSizeByte = 0
	--
	local resource = {
		file = Path.getCSB("PopupAudioPatch", "audiopatch"),
		binding = {
			_btnMinimize =
			{
				events = {{event = "touch", method = "_onBtnMinimize"}}
			},
			_btnOK =
			{
				events = {{event = "touch", method = "_onBtnOK"}}
            },
			_btnCancel =
			{
				events = {{event = "touch", method = "_onBtnCancel"}}
            },
		}
	}
	self:setName("PopupAudioPatch")
	PopupAudioPatch.super.ctor(self, resource,false)
end

--
function PopupAudioPatch:onCreate()
	self._btnOK:setString(Lang.get("common_btn_sure"))
	self._btnCancel:setString(Lang.get("common_btn_cancel"))
	self._btnMinimize:setString(Lang.get("audio_patch_minimize"))
	self._downloadTitle:setString(Lang.get("audio_patch_download_title"))
	self._desc:setString(Lang.get("audio_patch_desc3"))
	self:_showDownloadNode(false)
	self:checkUpdate()
end

--
function PopupAudioPatch:onEnter()

end

function PopupAudioPatch:onExit()
	self._upgrade:release()
end

function PopupAudioPatch:_showSpaceNotEnough()
	self._isSpaceEnough = false
	self:_showDownloadNode(false)
	self._btnCancel:setVisible(false)
	self._btnOK:setPositionX(0)
	self._desc:setString(Lang.get("audio_patch_space"))
end

function PopupAudioPatch:_showDownloadNode(bShow)
	self._downloadNode:setVisible(bShow)
	self._confirmNode:setVisible(not bShow)
end

--
function PopupAudioPatch:_onBtnOK()
	if not self._isReady then
		return
	end
	if self._isSpaceEnough == false then
		self:closeWithAction()
	elseif self._isConfirmed then
		self:_startDownload()
	else
		self._isConfirmed = true
		if self:_checkWifi() then
			self:_startDownload()
		else
			self._desc:setString(Lang.get("audio_patch_desc2"))
		end
	end
end

function PopupAudioPatch:_onBtnCancel()
	self:closeWithAction()
end

function PopupAudioPatch:_onBtnMinimize()
	self:minimize()
end

function PopupAudioPatch:onClose()
end

function PopupAudioPatch:_startDownload()
	if self:_checkSpace() then
		self._isDownloading = true
		self:_showDownloadNode(true)
		self._upgrade:update()
		G_SignalManager:dispatch(SignalConst.EVENT_SHOW_AUDIO_PATCH, true)
	else
		self:_showSpaceNotEnough()
	end
end

function PopupAudioPatch:isDownloading()
	return self._isDownloading
end

function PopupAudioPatch:_checkWifi()
	local networkType = G_NativeAgent.callStaticFunction("getNetworkType", nil, "string")
	if networkType == "wifi" then
		return true
	end
	return false
end

function PopupAudioPatch:_checkSpace()
	local space = tonumber(G_NativeAgent.callStaticFunction("getFreeDiskSpace", nil, "string") or 0)
	if space > self._totalSizeByte * 1.5 then
		return true
	end
	return false
end

-- 检查版本
function PopupAudioPatch:checkUpdate()
	local url = G_ConfigManager:getAudioVersionUrl()
	if self._upgrade == nil then
		local AudioPatchHelper = require("app.scene.view.audiopatch.AudioPatchHelper")
		local curVersion = AudioPatchHelper.getVersionString()
		print("lkmcheckUpdate-------",curVersion,url)
        self._upgrade = cc.AssetsManagerEx:createHD(curVersion, url, cc.FileUtils:getInstance():getWritablePath())
        self._upgrade:retain()
        self._upgradeListener = cc.EventListenerAssetsManagerEx:create(self._upgrade, handler(self, self.onUpdateEvent))
        cc.Director:getInstance():getEventDispatcher():addEventListenerWithFixedPriority(self._upgradeListener, 1)
    end
    self._upgrade:checkUpdate(url)
end

--
function PopupAudioPatch:onUpdateEvent(event)
    local eventCode = event:getEventCode()

    if eventCode == cc.EventAssetsManagerEx.EventCode.ERROR_NO_LOCAL_MANIFEST then
        --
    elseif eventCode == cc.EventAssetsManagerEx.EventCode.ERROR_PARSE_MANIFEST then
        -- 版本信息解析失败
        local txt = Lang.get("login_update_version_error")
        local callback = function()
            self:checkUpdate()
        end
        UIPopupHelper.popupOkDialog(nil, txt, callback)
	elseif eventCode == cc.EventAssetsManagerEx.EventCode.NEW_VERSION_FOUND then
		self._isReady = true
        -- 检查到新版本需要更新
		local assetId = event:getAssetId()
		self._totalSizeByte = event:getPercentByFile()
        local totalSize = math.ceil(event:getPercentByFile() / 1024 / 1024 * 100) / 100
        local txt = string.format(Lang.get("audio_patch_desc1"), totalSize)
		print("PopupAudioPatch file size = " .. totalSize)
		if self._desc then
			self._desc:setString(txt)
		end
		self._totalSize = totalSize
    elseif eventCode == cc.EventAssetsManagerEx.EventCode.UPDATE_PROGRESSION then
        -- 进度
        local assetId = event:getAssetId()
        local percent = event:getPercent()
        print("assetId = " .. assetId .. ", percent = " .. percent)
        if assetId == cc.AssetsManagerExStatic.VERSION_ID then
        elseif assetId == cc.AssetsManagerExStatic.INSTALL_ID then
            print("install assets")
            self._progressBar:setPercent(percent)
            self._progressLabel:setString(Lang.get("login_update_install"))
        else
			self._progressBar:setPercent(percent)
			local now = percent*self._totalSize/100
			local txt = string.format(Lang.get("audio_patch_progress"),now,self._totalSize)
            self._progressLabel:setString(txt)
        end
    elseif eventCode == cc.EventAssetsManagerEx.EventCode.ALREADY_UP_TO_DATE then
        -- 推送下载完成事件
		G_SignalManager:dispatch(SignalConst.EVENT_SHOW_AUDIO_PATCH, false)
		self:closeWithAction()
    elseif eventCode == cc.EventAssetsManagerEx.EventCode.UPDATE_FINISHED then
        print("Update finished.")
        -- 推送下载完成事件
		G_SignalManager:dispatch(SignalConst.EVENT_SHOW_AUDIO_PATCH, false)
        self:closeWithAction()
    elseif eventCode == cc.EventAssetsManagerEx.EventCode.ERROR_UPDATING then
        -- 推送检查内更新失败事件

        local txt = Lang.get("login_update_error", {curlecode = event:getCURLECode(), httpcode = event:getHTTPCode()})
        local callback = function()
            self:checkUpdate()
        end

        UIPopupHelper.popupOkDialog(nil, txt, callback)
    end
end


function PopupAudioPatch:maximize()
	self._resourceNode:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		self:setVisible(true)
		self._layerColor:setTouchEnabled(true)
	end),self:getOpenAction()))
end

function PopupAudioPatch:minimize()
	self._resourceNode:runAction(cc.Sequence:create(self:getCloseAction(), cc.CallFunc:create(function()
		self:setVisible(false)
		self._layerColor:setTouchEnabled(false)
	end)))
end

function PopupAudioPatch:open()
	self:setPosition(G_ResolutionManager:getDesignCCPoint())
	G_TopLevelNode:addToOfflineLevel(self)
end

return PopupAudioPatch
