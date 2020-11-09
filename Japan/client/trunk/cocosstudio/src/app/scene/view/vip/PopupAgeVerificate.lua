-- i18n ja 
-- Date: 2020-07-03  
-- 年龄弹框
local PopupBase = require("app.ui.PopupBase")
local PopupAgeVerificate = class("PopupAgeVerificate", PopupBase)
local Path = require("app.utils.Path") 
local KeyValueUrlRequest = require("app.manager.KeyValueUrlRequest") 

function PopupAgeVerificate:ctor()
	local resource = {
		file = Path.getCSB("PopupAgeVerificate", "vip"),
		binding = {
 
		}
	}

	PopupAgeVerificate.super.ctor(self, resource)
end

--
function PopupAgeVerificate:onCreate()
	self._isClickOtherClose = false
	self._KeyValueUrlRequest = KeyValueUrlRequest.new() 
	
	self._commonNodeBk:setTitle(Lang.get("age_title_confir"))  
	self._textUp:setString(Lang.get("age_des_confir")); 
	self._textDown:setString(Lang.get("age_des_tips")); 

	self._btnSixteen:getChildren()[1]:setString(Lang.get("age_btn_name_16")); 
	self._btnNineteen:getChildren()[1]:setString(Lang.get("age_btn_name_19")); 
	self._btnTwenty:getChildren()[1]:setString(Lang.get("age_btn_name_20")); 

	self._btnSixteen:addClickEventListenerEx(handler(self, self.onBtnSixteenClick))
	self._btnNineteen:addClickEventListenerEx(handler(self, self.onBtnNineteenClick))
	self._btnTwenty:addClickEventListenerEx(handler(self, self.onBtnTwentyClick))
end

function PopupAgeVerificate:onEnter()  
	--self._selectAge = G_NetworkManager:add(MessageIDConst.ID_S2C_SelectAge, handler(self, self._s2cSelectAge))  
	self._selectAge = self._KeyValueUrlRequest.signalSet:registerListener( handler(self, self._onEventSelectAge))  
end

function PopupAgeVerificate:onExit()
	self._selectAge:remove()
	self._selectAge = nil
end

function PopupAgeVerificate:_onEventSelectAge(e, param)
	if e ~= "fail" and param then
		self:close()
	end
end

function PopupAgeVerificate:onBtnSixteenClick()
	self:sendSelectAge(16)
end

function PopupAgeVerificate:onBtnNineteenClick()
	self:sendSelectAge(19)
end

function PopupAgeVerificate:onBtnTwentyClick()
	self:sendSelectAge(20)
end

function PopupAgeVerificate:onBtnCancel()
	self:close()
end

-- 年龄  0:没有选择 1:16未满 2:16-19岁 3:20岁以上
function PopupAgeVerificate:sendSelectAge(age)
	local uuid =  string.urlencode(G_GameAgent:getTopUserId())
	local server_id = G_GameAgent:getLoginServer():getServer() 
	if server_id == nil or uuid == nil then
		return
	end

 
	self._KeyValueUrlRequest:doRequestSetKeyValue("age", age)
end
 

    

return PopupAgeVerificate