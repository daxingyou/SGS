-- i18n ja 
-- Date: 2020-06-30  
-- 引继账号相关功能
local PopupBase = require("app.ui.PopupBase")
local PopupCitationAccount = class("PopupCitationAccount", PopupBase)
local Path = require("app.utils.Path")
local UTF8 = require("app.utils.UTF8")
local InputUtils = require("app.utils.InputUtils")
local TextHelper = require("app.utils.TextHelper")


PopupCitationAccount.CITATIO_CODE_MIN_LEN = 6  --引继码最小长度 
PopupCitationAccount.CITATIO_PWD_MIN_LEN = 6   --引继密码最小长度 
PopupCitationAccount.CITATIO_CODE_MAX_LEN = 12 --引继码最大长度 
PopupCitationAccount.CITATIO_PWD_MAX_LEN = 12  --引继密码最大长度
function PopupCitationAccount:ctor(callback)
	local resource = {
		file = Path.getCSB("PopupCitationAccount", "common"),
		binding = {
			_btnSure = {
				events = {{event = "touch", method = "onButtonSure"}}
			}
		}
	}
	PopupCitationAccount.super.ctor(self, resource)

	self._callback = callback
end

--
function PopupCitationAccount:onCreate()
	--self._btnSure:setState(CommonButton.STATE_NORMAL)
  
	self._btnSure:setString(Lang.get("citation_btn_name_login")) 
	self._commonNodeBk:setTitle(Lang.get("citation_title_citatioAccount")) 
	self._commonNodeBk:addCloseEventListener(handler(self, self.onBtnCancel))
	self._txtDes:setTextAreaSize(cc.size(443, 100))
	self._txtDes:getVirtualRenderer():setLineSpacing(4)
	self._txtDes:setString(Lang.get("citation_cfg_citation_account")); 


	self._inputPwd = InputUtils.createInputView(
		{
			bgPanel = self._imageInput2,
			fontSize = 18,
			placeholderFontColor = Colors.INPUT_PLACEHOLDER,
			-- fontColor = Colors.LIST_TEXT,
			fontColor = Colors.BRIGHT_BG_ONE,
			placeholder = Lang.get("citation_des_input_citationCode"),
			maxLength = PopupCitationAccount.CITATIO_CODE_MAX_LEN, 
		})			

	self._inputCode = InputUtils.createInputView(
		{
			bgPanel = self._imageInput,
			fontSize = 18,
			placeholderFontColor = Colors.INPUT_PLACEHOLDER,
			-- fontColor = Colors.LIST_TEXT,
			fontColor = Colors.BRIGHT_BG_ONE,
			placeholder = Lang.get("citation_des_input_code"),
			maxLength = PopupCitationAccount.CITATIO_CODE_MAX_LEN, 
		})
end
 
function PopupCitationAccount:getCitationCode()
	return self._inputCode:getText()  
end

--
function PopupCitationAccount:getPassword()
	return self._inputPwd:getText()
end

--
function PopupCitationAccount:onEnter()
    
end

function PopupCitationAccount:onExit()
    
end

--
function PopupCitationAccount:onButtonSure()
	local code = self:getCitationCode()
	local password = self:getPassword()  
	
	local citationCode = ""  -- 通过原生接口获取  ???待修改
	local citationPWD = ""

	if code ~= citationCode or password ~= citationPWD then 
		G_Prompt:showTip(Lang.get("txt_check_error_input_again")) 
		return
	end

	if self._callback then
		self._callback(code, password)
	else  
		-- 调用native (若_callback=nil在此处理) 	
	end
	
	self:close()
end 

function PopupCitationAccount:onBtnCancel()
	self:close()
end

return PopupCitationAccount


 
