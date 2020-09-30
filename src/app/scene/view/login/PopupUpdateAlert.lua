local PopupBase = require("app.ui.PopupBase")
local PopupUpdateAlert = class("PopupUpdateAlert", PopupBase)
local Path = require("app.utils.Path")

function PopupUpdateAlert:ctor(callbackOK, callbackCancel)

	self._callbackOK = callbackOK
	self._callbackCancel = callbackCancel

	local resource = {
		file = Path.getCSB("PopupUpdateAlert", "login"),
		binding = {
            _btnCancel = {
                events = {{event = "touch", method = "_onButtonCancel"}}
            },
            _btnOk = {
                events = {{event = "touch", method = "_onButtonOk"}}
            }
		}
	}
	PopupUpdateAlert.super.ctor(self, resource,false)
end

--
function PopupUpdateAlert:onCreate()
	self._image:ignoreContentAdaptWithSize(true)
end

function PopupUpdateAlert:setOKBtn(str)
	self._btnOk:setString(str)
end

function PopupUpdateAlert:setTip(str)
	self._loadingLabel:setString(str)
end

function PopupUpdateAlert:setBtnStr(str,str2)
	self._btnOk:setString(str)
	self._btnCancel:setString(str2)
end

--
function PopupUpdateAlert:onEnter()
end

function PopupUpdateAlert:onExit()
end

function PopupUpdateAlert:onlyShowOkButton()
	self._btnCancel:setVisible(false)
	self._btnOk:setPositionX(0)
end

--
function PopupUpdateAlert:_onButtonOk()
    if self._callbackOK then
		self._callbackOK()
	end
	self:close()
end

function PopupUpdateAlert:_onButtonCancel()
	if self._callbackCancel then
		self._callbackCancel()
	end
	self:close()
end


return PopupUpdateAlert
