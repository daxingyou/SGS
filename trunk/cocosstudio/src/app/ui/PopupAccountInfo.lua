-- i18n ja 
-- Date: 2020-06-30  
-- 引继码账户总面板相关功能 
local PopupBase = require("app.ui.PopupBase")
local PopupAccountInfo = class("PopupAccountInfo", PopupBase)
local Path = require("app.utils.Path")
local PopupServerList = require("app.scene.view.login.PopupServerList")
local UIPopupHelper = require("app.utils.UIPopupHelper")

function PopupAccountInfo:ctor(callback)
	local resource = {
		file = Path.getCSB("PopupAccountInfo", "common"),
		binding = {
			_btnBind = {
				events = {{event = "touch", method = "onButtonBind"}}
			},
			_btnSwitch = {
				events = {{event = "touch", method = "onButtonSwitchAccount"}}
			},
			_btnPublish = {
				events = {{event = "touch", method = "onButtonPublishCode"}}
			},
			_btnSelectServers = {
				events = {{event = "touch", method = "onButtonSelectServers"}}
			}
		}
	}

	self:enableNodeEvents()    
	PopupAccountInfo.super.ctor(self, resource)
	self._callback = callback
end 

--
function PopupAccountInfo:onCreate()
	--self._btnSure:setState(CommonButton.STATE_NORMAL)
  
	self._btnBind:setString(Lang.get("citation_btn_name_bind_account")) 
	self._btnSwitch:setString(Lang.get("citation_btn_name_switch_account")) 
	self._btnPublish:setString(Lang.get("citation_btn_name_publish_code")) 
	self._btnSelectServers:setString(Lang.get("citation_btn_name_select_servers")) 

	self._commonNodeBk:setTitle(Lang.get("citation_title_account"))  
	self._commonNodeBk:addCloseEventListener(handler(self, self.onBtnCancel))
	self._txtDes:setTextAreaSize(cc.size(443, 100))
	self._txtDes:getVirtualRenderer():setLineSpacing(4)
	self._txtDes:setString(Lang.get("citation_cfg_account")); 
end

function PopupAccountInfo:onEnter()
	self._signalServer = G_ServerListManager.signal:add(handler(self, self.onCheckUpdateList))

end

function PopupAccountInfo:onExit()
	self._signalServer:remove()
	self._signalServer = nil
end

--
function PopupAccountInfo:onButtonBind()
 	-- body  待修改???

	self:close()
end

function PopupAccountInfo:onButtonSwitchAccount()
	-- body  待修改???
 
	self:close()
end

function PopupAccountInfo:onButtonPublishCode()
	-- body
	local PopupPublishCitation = require("app.ui.PopupPublishCitation")
    local code = PopupPublishCitation.new(null)
    code:openWithAction()
 
	self:close()
end

function PopupAccountInfo:onButtonSelectServers()
	-- body
	self:checkUpdateList(true)
end

function PopupAccountInfo:onBtnCancel()
	self:close()
end

--选择区服
function PopupAccountInfo:checkUpdateList(open)
    self._openServerList = open
    if G_ServerListManager:isCheckUpdate() then
    	G_WaitingMask:showWaiting(true)
	    G_ServerListManager:checkUpdateList()
	else
		self:onCheckUpdateList("success")
	end
end

function PopupAccountInfo:onCheckUpdateList(ret)
	print("onCheckUpdateList = " .. ret)
	G_WaitingMask:showWaiting(false)
	if ret == "success" then 
		if self._openServerList then

			G_SceneManager:showDialog("app.scene.view.login.PopupServerList",nil,nil,
				function (server)
					G_GameAgent:setLoginServer(server)
					--self:updateUserServer()
				end)
		else
			--self:updateUserServer()
		end
		self:close() 
	else
		--失败
		local callback = function ()
			self:checkUpdateList()
			--self:close()  无法调用函数checkUpdateList
        end
		if Lang.checkLang(Lang.CN) then
			UIPopupHelper.popupOkDialog(nil,"获取服务器列表失败",callback,"更新")
		else
			UIPopupHelper.popupOkDialog(nil,Lang.getImgText("get_server_list_fail"),callback,Lang.getImgText("update"))
		end 
		self:setVisible(false)
	end

end

return PopupAccountInfo

 