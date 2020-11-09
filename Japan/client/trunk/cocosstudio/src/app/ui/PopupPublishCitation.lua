-- i18n ja 
-- Date: 2020-06-30  
-- 发行引继账号相关功能
local PopupBase = require("app.ui.PopupBase")
local PopupPublishCitation = class("PopupPublishCitation", PopupBase)
local Path = require("app.utils.Path")
local UTF8 = require("app.utils.UTF8")
local InputUtils = require("app.utils.InputUtils")
local TextHelper = require("app.utils.TextHelper")

PopupPublishCitation.CITATIO_PWD_MIN_LEN = 6   --引继密码最小长度 
PopupPublishCitation.CITATIO_PWD_MAX_LEN = 12  --引继密码最大长度

function PopupPublishCitation:ctor(callback)
	local resource = {
		file = Path.getCSB("PopupPublishCitation", "common"),
		binding = {
			_btnComplete = {
				events = {{event = "touch", method = "onButtonComplete"}}
			}
		}
	}
	PopupPublishCitation.super.ctor(self, resource)

	self._callback = callback
end

--
function PopupPublishCitation:onCreate()
	--self._btnSure:setState(CommonButton.STATE_NORMAL)
  
	self._btnComplete:setString(Lang.get("citation_btn_name_complete")) 
	self._commonNodeBk:setTitle(Lang.get("citation_title_publish")) 
	self._commonNodeBk:addCloseEventListener(handler(self, self.onBtnCancel))
	self._txtPWD:setString(Lang.get("citation_des_password")); 
	self._txtConfirm:setString(Lang.get("citation_des_confirm")); 
	self._txtDes:setTextAreaSize(cc.size(443, 100))
	self._txtDes:getVirtualRenderer():setLineSpacing(6)
	self._txtDes:setString(Lang.get("citation_cfg_publish_citation")); 

	self._inputPwd = InputUtils.createInputView(
		{
			bgPanel = self._imageInput,
			fontSize = 20,
			placeholderFontColor = Colors.INPUT_PLACEHOLDER,
			-- fontColor = Colors.LIST_TEXT,
			fontColor = Colors.BRIGHT_BG_ONE,
			placeholder = Lang.get("citation_des_password2"),
			maxLength = PopupPublishCitation.CITATIO_PWD_MAX_LEN, 
		})
		
	self._inputConfirmPwd = InputUtils.createInputView(
		{
			bgPanel = self._imageInput2,
			fontSize = 20,
			placeholderFontColor = Colors.INPUT_PLACEHOLDER,
			fontColor = Colors.BRIGHT_BG_ONE,
			placeholder = Lang.get("citation_des_password2"), 
			maxLength = PopupPublishCitation.CITATIO_PWD_MAX_LEN,   
		})
end
 
function PopupPublishCitation:getPassword()
	return self._inputPwd:getText()  
end

--
function PopupPublishCitation:getConfirmPassword()
	return self._inputConfirmPwd:getText()
end

--
function PopupPublishCitation:onEnter()
    
end

function PopupPublishCitation:onExit()
    
end

--
function PopupPublishCitation:onButtonComplete()
	local pwd = self:getPassword()
	local pwd2 = self:getConfirmPassword() 
	if pwd == nil or pwd == "" then    
		G_Prompt:showTip(Lang.get("txt_check_error_empty_citation"))    
		return
	elseif TextHelper.checkNotNumOrLetter(pwd)  then   		 -- 非数字和英文
		G_Prompt:showTip(Lang.get("txt_check_error_not_num_letter"))   
		return	
	elseif TextHelper.checkNumLetterCombine(pwd) == false then  -- 数字和英文组合
		G_Prompt:showTip(Lang.get("txt_check_error_num_and_letter"))   
		return	
	elseif pwd ~= pwd2 then  
		G_Prompt:showTip(Lang.get("txt_check_error_pwd_not_same"))  
		return	
	elseif UTF8.utf8len(pwd) < PopupPublishCitation.CITATIO_PWD_MIN_LEN then   
		G_Prompt:showTip(Lang.get("txt_check_error_pwd_len"))  
		return		
	end  

	if self._callback then
		self._callback(pwd, pwd2)
		self:close()
	else  
		-- 调用native(若_callback=nil在此处理) 	
	end

	-- local PopupCitationCode = require("app.ui.PopupCitationCode")
    -- local code = PopupCitationCode.new(null)
    -- code:openWithAction()
	-- self:close()
end

function PopupPublishCitation:onBtnCancel()
	-- 返回切换账户面板 待修改???
	-- G_Prompt:showTip(Lang.get("chat_voice_will_come")) 
	self:close()
end

return PopupPublishCitation
 

 
 