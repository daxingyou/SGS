--聊天设置页面
local PopupBase = require("app.ui.PopupBase")
local PopupChatSetting = class("PopupChatSetting", PopupBase)
local Path = require("app.utils.Path")
local UIHelper  = require("yoka.utils.UIHelper")
local CSHelper  = require("yoka.utils.CSHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst	 = require("app.const.DataConst")
local ChatConst  = require("app.const.ChatConst")

PopupChatSetting.CHECK_BOX_NUM = 7--复选框数量

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
		local nodeCheck3 = UIHelper.seekNodeByName(self._resourceNode,"Node_check1_5")
		
		text:setVisible(false)
		nodeCheck1:setVisible(false)
		nodeCheck2:setVisible(false)
		nodeCheck3:setVisible(false)
		
		--i18n 新增跨服消息控制
		-- if not Lang.checkLang(Lang.CN) then
		-- 	local nodeCheck13 = UIHelper.seekNodeByName(self._resourceNode,"Node_check_new_2")
		-- 	nodeCheck13:setVisible(false)
		-- end


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


	--i18n 新增跨服消息控制
	if not Lang.checkLang(Lang.CN) then
		local checkValue03 = G_UserData:getChat():getChatSetting():getCheckBoxValue(ChatConst.SETTING_KEY_AUTO_VOICE_CROSS_SERVER)
		if checkValue03 ~= 1 then
			G_UserData:getChat():clearAutoPlayVoiceList(ChatConst.CHANNEL_CROSS_SERVER)
		end
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
		local text = UIHelper.seekNodeByTag(self._resourceNode,483)
		text:setString(Lang.getImgText("editor.chat.2"))

		local text = UIHelper.seekNodeByTag(self._resourceNode,486)
		text:setString(Lang.getImgText("chat_auto_play_voice"))
		local instNode = text:clone()
		
		local text_desc = UIHelper.seekNodeByName(self._resourceNode,"Node_check1_5","Text_desc")
		text_desc:setString(Lang.getImgText("voice_kuafu"))
		text_desc:setPositionY(-5)
		text_desc:getVirtualRenderer():setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	
		local text_desc = UIHelper.seekNodeByName(self._resourceNode,"Node_check1_4","Text_desc")
		text_desc:setPositionY(-5)
		text_desc:getVirtualRenderer():setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
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

	-- if not Lang.checkLang(Lang.CN) then
	-- 	local UIHelper  = require("yoka.utils.UIHelper")
	-- 	local nodeCheck1 = UIHelper.seekNodeByName(self._resourceNode,"Node_check1")

	-- 	local cloneNodeHierarchy = function(srcNode)
	-- 		local node = cc.Node:create()
	-- 		for k,v in ipairs(srcNode:getChildren()) do
	-- 			node:addChild(v:clone())
	-- 		end
	-- 		node:setPosition(srcNode:getPosition())
	-- 		return node
	-- 	end 

	-- 	local instNode1 = cloneNodeHierarchy(nodeCheck1)
	-- 	instNode1:setName("Node_check_new_1")
	-- 	nodeCheck1:getParent():addChild(instNode1)
	-- 	local checkBox = UIHelper.seekNodeByName(instNode1,"_checkBox5")
	-- 	self["_checkBox"..ChatConst.SETTING_KEY_RECEPT_CROSS_SERVER] = checkBox
	-- 	local text_desc = UIHelper.seekNodeByName(instNode1,"Text_desc")
	-- 	text_desc:setString(Lang.getImgText("voice_kuafu"))
		


	-- 	local instNode2 = cloneNodeHierarchy(nodeCheck1)
	-- 	instNode2:setName("Node_check_new_2")
	-- 	nodeCheck1:getParent():addChild(instNode2)
	-- 	local checkBox = UIHelper.seekNodeByName(instNode2,"_checkBox5")
	-- 	self["_checkBox"..ChatConst.SETTING_KEY_AUTO_VOICE_CROSS_SERVER] = checkBox 
	-- 	local text_desc = UIHelper.seekNodeByName(instNode2,"Text_desc")
	-- 	text_desc:setString(Lang.getImgText("voice_kuafu"))

	-- 	local nodeCheck1 = UIHelper.seekNodeByName(self._resourceNode,"Node_check1")
	-- 	local nodeCheck2 = UIHelper.seekNodeByName(self._resourceNode,"Node_check1_3")
	
	-- 	UIHelper.alignCenter(self._resourceNode,{nodeCheck1,nodeCheck2,instNode1},{19,19,0},{156,156,156})
	-- 	nodeCheck1:setPositionX(nodeCheck1:getPositionX()+22)
	-- 	nodeCheck2:setPositionX(nodeCheck2:getPositionX()+22)
	-- 	instNode1:setPositionX(instNode1:getPositionX()+22)

	-- 	local nodeCheck3 = UIHelper.seekNodeByName(self._resourceNode,"Node_check1_0")
	-- 	local nodeCheck4 = UIHelper.seekNodeByName(self._resourceNode,"Node_check1_1")
	-- 	instNode2:setPositionY(nodeCheck3:getPositionY())
		
	-- 	UIHelper.alignCenter(self._resourceNode,{nodeCheck3,nodeCheck4,instNode2},{19,19,0},{156,156,156})
		
	-- 	nodeCheck3:setPositionX(nodeCheck3:getPositionX()+22)
	-- 	nodeCheck4:setPositionX(nodeCheck4:getPositionX()+22)
	-- 	instNode2:setPositionX(instNode2:getPositionX()+22)
	-- end
end



return PopupChatSetting