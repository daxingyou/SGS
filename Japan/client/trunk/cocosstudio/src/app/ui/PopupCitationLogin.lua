-- i18n ja 
-- Date: 2020-06-30  
-- 引继码登录弹框
local PopupBase = require("app.ui.PopupBase")
local PopupCitationLogin = class("PopupCitationLogin", PopupBase)
local Path = require("app.utils.Path")
local UTF8 = require("app.utils.UTF8")
local InputUtils = require("app.utils.InputUtils")
local TextHelper = require("app.utils.TextHelper")


PopupCitationLogin.CITATIO_CODE_MIN_LEN = 6  --引继码最小长度 
PopupCitationLogin.CITATIO_PWD_MIN_LEN = 6   --引继密码最小长度 
PopupCitationLogin.CITATIO_CODE_MAX_LEN = 12 --引继码最大长度 
PopupCitationLogin.CITATIO_PWD_MAX_LEN = 12  --引继密码最大长度
function PopupCitationLogin:ctor(callback)
	local resource = {
		file = Path.getCSB("PopupCitationLogin", "common"),
		binding = {
			_btnSure = {
				events = {{event = "touch", method = "onButtonSure"}}
			}
		}
	}
	PopupCitationLogin.super.ctor(self, resource)

	self._callback = callback
end

--
function PopupCitationLogin:onCreate()
	--self._btnSure:setState(CommonButton.STATE_NORMAL)
  
	self._btnSure:setString(Lang.get("citation_btn_name_login")) 
	self._commonNodeBk:setTitle(Lang.get("citation_title_citatioAccount")) 
	self._commonNodeBk:addCloseEventListener(handler(self, self.onBtnCancel))
	self._txtDes:setTextAreaSize(cc.size(443, 100))
	self._txtDes:getVirtualRenderer():setLineSpacing(4)
	self._txtDes:setString(Lang.get("citation_cfg_citation_account")); 

	self._inputCode = InputUtils.createInputView(
		{
			bgPanel = self._imageInput,
			fontSize = 20,
			placeholderFontColor = Colors.INPUT_PLACEHOLDER,
			-- fontColor = Colors.LIST_TEXT,
			fontColor = Colors.BRIGHT_BG_ONE,
			placeholder = Lang.get("citation_des_input_code"),
			maxLength = PopupCitationLogin.CITATIO_CODE_MAX_LEN, 
		})
		
	self._inputPwd = InputUtils.createInputView(
		{
			bgPanel = self._imageInput2,
			fontSize = 20,
			placeholderFontColor = Colors.INPUT_PLACEHOLDER,
			fontColor = Colors.BRIGHT_BG_ONE,
			placeholder = Lang.get("citation_des_input_citationCode"), 
			maxLength = PopupCitationLogin.CITATIO_PWD_MAX_LEN,   
		})
end
 
function PopupCitationLogin:getUserName()
	return self._inputCode:getText()  
end

--
function PopupCitationLogin:getPassword()
	return self._inputPwd:getText()
end

--
function PopupCitationLogin:onEnter()
end

function PopupCitationLogin:onExit()
    
end

--
function PopupCitationLogin:onButtonSure()
	local name = self:getUserName()
	local password = self:getPassword()  
	
	local citationCode = ""  -- 通过原生接口获取  ???待修改
	local citationPWD = ""

	if name == citationCode or password == citationPWD then 
		G_Prompt:showTip(Lang.get("txt_check_error_input_again")) 
		return
	end

	if self._callback then
		self._callback(name, password)
	-- else  
		-- 调用native (若_callback=nil在此处理) 	
	end
	
	self:close()
end 

function PopupCitationLogin:onBtnCancel()
	self:close()
end

return PopupCitationLogin


 