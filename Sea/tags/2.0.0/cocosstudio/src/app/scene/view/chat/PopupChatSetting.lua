--聊天设置页面
local PopupBase = require("app.ui.PopupBase")
local PopupChatSetting = class("PopupChatSetting", PopupBase)
local Path = require("app.utils.Path")
local UIHelper  = require("yoka.utils.UIHelper")
local CSHelper  = require("yoka.utils.CSHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst	 = require("app.const.DataConst")
local ChatConst  = require("app.const.ChatConst")

PopupChatSetting.CHECK_BOX_NUM = 5--复选框数量

function PopupChatSetting:ctor( title, callback)
	self._title = title or Lang.get("chat_popup_title_chat_setting") 
	self._callback = callback
	self._commonButtonSmallNormal = nil --
    self._commonResourceInfo = nil

	local resource = {
		file = Path.getCSB("PopupChatSetting", "chat"),
		binding = {
		}
	}
	PopupChatSetting.super.ctor(self, resource, true)
end

--
function PopupChatSetting:onCreate()
	-- i18n change lable
	self:_dealI18n()
	self:_dealPosByI18n()
	self:setName("PopupChatSetting")
	self._commonNodeBk:setTitle(self._title)
	self._commonButtonSmallNormal:setString(Lang.get("common_btn_name_confirm"))
    self._commonButtonSmallNormal:addClickEventListenerEx(handler(self, self.onBtnOk))
	self._commonNodeBk:addCloseEventListener(handler(self, self.onBtnCancel))

	self:_initCheckbox()
	self:_refreshCheckbox()

	
	-- i18n
	if not G_ConfigManager:isVoiceOpen() then
		local text = UIHelper.seekNodeByTag(self._resourceNode,486)
		local nodeCheck1 = UIHelper.seekNodeByName(self._resourceNode,"Node_check1_0")
		local nodeCheck2 = UIHelper.seekNodeByName(self._resourceNode,"Node_check1_1")
		text:setVisible(false)
		nodeCheck1:setVisible(false)
		nodeCheck2:setVisible(false)
	end

end

function PopupChatSetting:_initCheckbox()
	for i = 1,PopupChatSetting.CHECK_BOX_NUM,1 do
		local checkBox = self["_checkBox"..i]
		checkBox:setTag(i)
		checkBox:addEventListener(handler(self,self._onClickCheckBox))
	end
end

function PopupChatSetting:_refreshCheckbox()
	for i = 1,PopupChatSetting.CHECK_BOX_NUM,1 do
		local checkBox = self["_checkBox"..i]
		local checkValue = G_UserData:getChat():getChatSetting():getCheckBoxValue(i)
		if checkValue == 1 then
			checkBox:setSelected(true)
		else
			checkBox:setSelected(false)
		end
	end
end

function PopupChatSetting:_onClickCheckBox(sender)

	local checkboxData = {}
	for i = 1,PopupChatSetting.CHECK_BOX_NUM,1 do
		local checkBox = self["_checkBox"..i]
		table.insert(checkboxData, checkBox:isSelected() and 1 or 0 )
	end
	G_UserData:getChat():getChatSetting():saveSettingValue("checkbox",checkboxData)

	local checkValue01 = G_UserData:getChat():getChatSetting():getCheckBoxValue(ChatConst.SETTING_KEY_AUTO_VOICE_WORLD)
	local checkValue02 = G_UserData:getChat():getChatSetting():getCheckBoxValue(ChatConst.SETTING_KEY_AUTO_VOICE_GANG)
	if  checkValue01 ~= 1 then
		G_UserData:getChat():clearWorldAutoPlayVoiceList()
	end

	if checkValue02 ~= 1 then
		G_UserData:getChat():clearGuildAutoPlayVoiceList()
	end

	
end



function PopupChatSetting:setBtnEnable(enable)
	self._commonButtonSmallNormal:setEnabled(enable)
end

function PopupChatSetting:setBtnText(text)
	self._commonButtonSmallNormal:setString(text)
end

function PopupChatSetting:updateUI()
end

function PopupChatSetting:_onInit()
end

function PopupChatSetting:onEnter()
end

function PopupChatSetting:onExit()
end

function PopupChatSetting:onBtnOk()
	local isBreak
	if self._callback then
		isBreak = self._callback()
	end
	if not isBreak then
		self:close()
	end
end

function PopupChatSetting:onBtnCancel()
	if not isBreak then
		self:close()
	end
end


-- i18n change lable
function PopupChatSetting:_dealI18n()

	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		local text = UIHelper.seekNodeByTag(self._resourceNode,486)
		text:setString(Lang.getImgText("chat_auto_play_voice"))
	end
end




-- i18n pos lable
function PopupChatSetting:_dealPosByI18n()
	if Lang.checkLatinLanguage() then
		local UIHelper  = require("yoka.utils.UIHelper")
		local desc1 = UIHelper.seekNodeByName(self._resourceNode,"Node_check1","Text_desc")
		local desc2 = UIHelper.seekNodeByName(self._resourceNode,"Node_check1_0","Text_desc")
		local desc3 = UIHelper.seekNodeByName(self._resourceNode,"Node_check1_1","Text_desc")
		local desc4 = UIHelper.seekNodeByName(self._resourceNode,"Node_check1_2","Text_desc")
		local desc5 = UIHelper.seekNodeByName(self._resourceNode,"Node_check1_3","Text_desc")

		desc1:setAnchorPoint(cc.p(0.5,0))
		desc2:setAnchorPoint(cc.p(0.5,0))
		desc1:setAnchorPoint(cc.p(0.5,0))
		desc3:setAnchorPoint(cc.p(0.5,0))
		desc4:setAnchorPoint(cc.p(0.5,0))
		desc5:setAnchorPoint(cc.p(0.5,0))

		desc1:setPositionX(desc1:getPositionX()+27)
		desc2:setPositionX(desc2:getPositionX()+27)
		desc3:setPositionX(desc3:getPositionX()+27)
		desc4:setPositionX(desc4:getPositionX()+27)
		desc5:setPositionX(desc5:getPositionX()+27)

		--desc1:setFontSize(desc1:getFontSize()-3)
		--desc2:setFontSize(desc2:getFontSize()-3)
		--desc3:setFontSize(desc3:getFontSize()-3)
		--desc4:setFontSize(desc4:getFontSize()-3)
		--desc5:setFontSize(desc5:getFontSize()-3)
	end
end



return PopupChatSetting