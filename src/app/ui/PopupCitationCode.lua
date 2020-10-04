-- i18n ja 
-- Date: 2020-06-30  
-- 引继码相关功能
local PopupBase = require("app.ui.PopupBase")
local PopupCitationCode = class("PopupCitationCode", PopupBase)
local Path = require("app.utils.Path")

function PopupCitationCode:ctor(citationCode)
	local resource = {
		file = Path.getCSB("PopupCitationCode", "common"),
		binding = {
			_btnCopy = {
				events = {{event = "touch", method = "onButtonCopy"}}
			},
			_btnSaveImg = {
				events = {{event = "touch", method = "onButtonSaveImg"}}
			}
		}
	}
	PopupCitationCode.super.ctor(self, resource)
	print("PopupCitationCode init citationCode = " .. citationCode)
	self._citationCode = citationCode
	self._isPhotoPermission = false
end

--
function PopupCitationCode:onCreate()
	--self._btnSure:setState(CommonButton.STATE_NORMAL)
  
	self._btnCopy:setString(Lang.get("citation_btn_name_copy")) 
	self._btnSaveImg:setString(Lang.get("citation_btn_save_image")) 
	self._commonNodeBk:setTitle(Lang.get("citation_title_code"))  
	self._commonNodeBk:addCloseEventListener(handler(self, self.onBtnCancel))
	self._txtDes:setTextAreaSize(cc.size(443, 100))
	self._txtDes:getVirtualRenderer():setLineSpacing(4)
	self._txtDes:setString(Lang.get("citation_cfg_citation_code")); 

	local strContent = "我是引继码"   -- 待修改 ???
	self._textCitationCode:setString(strContent)

	self:_readStorage()
end

function PopupCitationCode:onEnter()
	local strContent = self._citationCode
	dump(strContent,"PopupCitationCode citationCode =")
	self._textCitationCode:setString(strContent)
	self:_readStorage()
end

function PopupCitationCode:onExit()
    self:_writeStorage()
end

--
function PopupCitationCode:onButtonCopy()
	-- body
	G_NativeAgent:clipboard(self._textCitationCode:getString()) 
	G_Prompt:showTip(Lang.get("linkage_activity_copy_tip"))  
	self:close()
end

function PopupCitationCode:onButtonSaveImg()
	 -- body
	 local platform = G_NativeAgent:getNativeType()
	 local PopupAlert = require("app.ui.PopupAlert")
	 self:_readStorage()
	 if platform == "ios" or platform == "android" then	
		if self._isPhotoPermission == true or platform == "ios" then
			self:_takePhoto()
			return
		end

		local callbackOk = function(self)
			self._isPhotoPermission = true
			dump("callbackOk photoPermission",self._isPhotoPermission)
			self:_writeStorage()
			self:_takePhoto()
		end	
		local callbackCancel = function(self)
			self._isPhotoPermission = false
			dump("callbackCancel photoPermission",self._isPhotoPermission)
			self:_writeStorage()
		end	
		
		local alert =
            PopupAlert.new(
            Lang.get("sys_permission_title"),
            Lang.get("sys_permission_content"),
            handler(self,callbackOk),
			handler(self,callbackCancel)
			)
		alert:setBtnStr(Lang.get("sys_permission_btn_right"),Lang.get("sys_permission_btn_left"))
        alert:openWithAction()
	else
		G_Prompt:showTip(Lang.get("chat_voice_will_come"))   -- 待修改 ???
	end
end

function PopupCitationCode:onBtnCancel()
	self:close()
end


function PopupCitationCode:_readStorage()
	logWarn("PopupCitationCode readStorage")
    local agreementStorage = G_StorageManager:load("agreement") or {}
    dump(agreementStorage,"agreement read Storage")
    if agreementStorage and agreementStorage["photoPermission"] then
		self._isPhotoPermission = agreementStorage["photoPermission"]
    end
end

function PopupCitationCode:_writeStorage()
	logWarn("PopupCitationCode writeStorage")
    local agreement = G_StorageManager:load("agreement") or {}
    agreement["photoPermission"] = self._isPhotoPermission
    dump("photoPermission",self._isPhotoPermission)
    dump("agreement writeStorage photoPermission",agreement["photoPermission"])
    G_StorageManager:save("agreement",agreement)
end


function PopupCitationCode:_takePhoto()
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
	end

	cc.utils:captureScreen(function( ... )
		afterCaptured( ... )
		logWarn("PopupCitationCode save photo close ")
		self:close()
	end,imagePath)
end

return PopupCitationCode