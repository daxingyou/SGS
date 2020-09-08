-- i18n ja 
-- Date: 2020-07-03  
-- 利用规约
local PopupBase = require("app.ui.PopupBase")
local PopupUsingConventions = class("PopupUsingConventions", PopupBase)
local Path = require("app.utils.Path")
local PopupHelpRule = require("app.ui.PopupHelpRule") 
local KeyValueUrlRequest = require("app.manager.KeyValueUrlRequest") 


function PopupUsingConventions:ctor(bFisrtLogin)
	local resource = {
		file = Path.getCSB("PopupUsingConventions", "login"),
		binding = {
			_btnOK = {
				events = {{event = "touch", method = "onButtonOK"}}
			},
			_btnUnAgree = {
				events = {{event = "touch", method = "onButtonUnAgreen"}}
			}
		}
	}
 
	self.bFisrtLogin = bFisrtLogin 
	PopupUsingConventions.super.ctor(self, resource)
end
 
function PopupUsingConventions:onCreate()
	self._KeyValueUrlRequest = KeyValueUrlRequest.new()
	self._isClickOtherClose = false
	
	self._commonNodeBk:setTitle(Lang.get("UsingConvente_title"))  
	self._txtDes:setString(Lang.get("UsingConvente_des"));   
 
	self._btnOK:setString(Lang.get("UsingConvente_btn_Agree"))
	self._btnUnAgree:setString(Lang.get("UsingConvente_btn_UnAgree"))
	self._btnAgree:getChildren()[1]:setString(Lang.get("UsingConvente_btn_des1"));          
	self._btnSecrets:getChildren()[1]:setString(Lang.get("UsingConvente_btn_des2")); 

	self._btnAgree:addClickEventListenerEx(handler(self, self.onButtonUserAgreen))
	self._btnSecrets:addClickEventListenerEx(handler(self, self.onButtonPrivacyPolicy)) 

	self:adjustBtnPos(self.bFisrtLogin)  
end

function PopupUsingConventions:adjustBtnPos(bShow)
	self._btnOK:setVisible(bShow)
	self._btnUnAgree:setVisible(bShow)
	self._commonNodeBk:setCloseVisible(not bShow)	

	if not bShow then
		self._txtDes:setPositionY(312)
		self._btnAgree:setPositionY(200)
		self._btnSecrets:setPositionY(131) 
		self._isClickOtherClose = true
		self._commonNodeBk:addCloseEventListener(handler(self, self.onBtnCancel))
	end
end

function PopupUsingConventions:onEnter()
	self._selectLaw = self._KeyValueUrlRequest.signalSet:registerListener( handler(self, self._onEventCloseUsingConventions))  
end

function PopupUsingConventions:onExit()
	self._selectLaw:remove()
	self._selectLaw = nil
end

function PopupUsingConventions:sendSelectLaw(law)
	local uuid =  string.urlencode(G_GameAgent:getTopUserId())
	local server_id = G_GameAgent:getLoginServer():getServer() 
	if server_id == nil or uuid == nil then
		return
	end
	self._KeyValueUrlRequest:doRequestSetKeyValue("law", law)
end

function PopupUsingConventions:_onEventCloseUsingConventions(e, param) 
	if e ~= "fail" and param then
		self:close()
		G_StorageManager:save("UsingConvente", 1)
		G_GameAgent:checkAndLoginGame()  -- 开始登陆游戏
	end
end

function PopupUsingConventions:onButtonOK()	
	 self:sendSelectLaw(1)
	 --self:close() -- 首次登录强弹 但是延迟发送http
end

function PopupUsingConventions:onButtonUnAgreen()
	G_NativeAgent:exitGame()
	--G_GameAgent:exitGame()  
end
 
function PopupUsingConventions:onButtonUserAgreen()
    local rule = PopupHelpRule.new("UsingConvente_btn_des1", "rule_user_agree")
	rule:openWithAction()
end

function PopupUsingConventions:onButtonPrivacyPolicy()
    local rule = PopupHelpRule.new("UsingConvente_btn_des2", "rule_privacy_policy")
	rule:openWithAction()
end  	

function PopupUsingConventions:onBtnCancel()
	self:close()
end

return PopupUsingConventions

 
 