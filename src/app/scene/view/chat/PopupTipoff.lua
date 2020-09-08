local ChatConst = require("app.const.ChatConst")
local PopupTipoffCheckMsgCell = require("app.scene.view.chat.PopupTipoffCheckMsgCell")
local PopupBase = require("app.ui.PopupBase")
local PopupTipoff = class("PopupTipoff", PopupBase)


function PopupTipoff:ctor(chatMsg)
    self._chatMsg = chatMsg
    self._nodeCheckList = {}
    self._currTabIndex = 0
	local resource = {
		file = Path.getCSB("PopupTipoff", "chat"),
		binding = {
            _buttonOk = {
				events = {{event = "touch", method = "_onBtnOk"}}
            },
            _buttonCancel = {
				events = {{event = "touch", method = "_onBtnClose"}}
			}
		}
	}
	PopupTipoff.super.ctor(self, resource,true)
end

function PopupTipoff:onCreate()
    self._popBase:setTitle(Lang.get("chat2_tip_off_title"))
    self._popBase:addCloseEventListener(handler(self,self._onBtnClose))

    -- i18n ja
    if Lang.checkLang(Lang.JA) then
        self._popBase:setOpacity(255)
    end

    self._buttonOk:setString(Lang.get("chat2_tip_off_btn_ok"))
    self._buttonCancel:setString(Lang.get("chat2_tip_off_btn_cancel"))

    self._nodeCheckList = {self._nodeCheck1,self._nodeCheck2,self._nodeCheck3,self._nodeCheck4,self._nodeCheck5}

    self:_initTips()
    self:_refreshTipOffCategory()

    local cell = PopupTipoffCheckMsgCell.new(self._chatMsg ,480)
    self._nodeMsg:addChild(cell)
    cell:setPositionY(-cell:getTotalHeight())

    self:_setCurrTabIndex(1)
end

function PopupTipoff:_initTips()
    local officialLevel = self._chatMsg:getSender():getOffice_level()
    local nameIconColor = Colors.getOfficialColor(officialLevel)
    local nameIconOutline = Colors.getOfficialColorOutline(officialLevel)
    local name = self._chatMsg:getSender():getName()

    local richTxt = Lang.get("chat2_tip_off_tips",{name = name,color = Colors.toHexNum(nameIconColor)})
    local textDesc = ccui.RichText:createWithContent(richTxt)
    textDesc:setAnchorPoint(cc.p(0.5, 0.5))
    -- textDesc:ignoreContentAdaptWithSize(false)
    self._nodeTitle:addChild(textDesc)
end

function PopupTipoff:_makeTipOffCategoryListData()
    return Lang.get("chat2_categoty")
end

function PopupTipoff:_refreshTipOffCategory()
    local listData = self:_makeTipOffCategoryListData()
    for k,node in ipairs(self._nodeCheckList) do
        local data = listData[k]  
        if data then
            self:_refreshTipOffCategoryItem(k,node,data)
        else
            node:setVisible(false)
        end
    end
end

function PopupTipoff:_refreshTipOffCategoryItem(index,node,data)
    local checkBox = node:getSubNodeByName("CheckBox")
    local text = node:getSubNodeByName("Text")
    text:setString(data)
    checkBox:addEventListener(handler(self,self._onClickCheckBox))
    checkBox:setSelected(false)
    checkBox:setTag(index)
end

function PopupTipoff:_setCurrTabIndex(index)
    if self._currTabIndex == index then
        return 
    end
    self._currTabIndex = index
    for k,v in ipairs(self._nodeCheckList) do
        local checkBox = v:getSubNodeByName("CheckBox")
        checkBox:setSelected(self._currTabIndex == k)
    end
end

function PopupTipoff:_onClickCheckBox(sender)
    local index = sender:getTag()
    self:_setCurrTabIndex(index)
end

function PopupTipoff:_onBtnOk()
    
    local user_id = self._chatMsg:getSender():getId()
    local channel = self._chatMsg:getChannel()
    local time = G_ServerTime:getTime()
    local report_type = self._currTabIndex
    local content_type = self._chatMsg:getMsg_type()
    local content = self._chatMsg:getContent()
    local msg_id = self._chatMsg:getId()
    local tar_server_name  = self._chatMsg:getSender():getServer_name()
    local tar_user_name = self._chatMsg:getSender():getName()
    local tar_server_id = self._chatMsg:getSender():getServer_id()
    if content_type == ChatConst.MSG_TYPE_VOICE then
        content = self._chatMsg:getVoiceInfo().voiceUrl
    end
    if channel ~= ChatConst.CHANNEL_PRIVATE then
        msg_id = nil
    end
    G_UserData:getChat():c2sChatReport(user_id,channel,time,report_type,
        content_type,content,msg_id,tar_user_name,tar_server_name,tar_server_id)
end

function PopupTipoff:_onBtnClose()
    self:close()
end

function PopupTipoff:onEnter()
    self._signalChatTipOffSuccess = G_SignalManager:add(SignalConst.EVENT_CHAT_TIPOFF_SUCCESS, 
        handler(self, self._onEventChatTipOffSuccess))
end

function PopupTipoff:onExit()
	self._signalChatTipOffSuccess:remove()
	self._signalChatTipOffSuccess = nil
end

function PopupTipoff:_onEventChatTipOffSuccess()
    logWarn("PopupTipoff ok")
    G_Prompt:showTip(Lang.get("chat2_already_tipoff"))
    --客户端自己记录状态
    local chatMsg = self._chatMsg
    chatMsg:setIs_report(1)
    local UserDataHelper = require("app.utils.UserDataHelper")
    local channel = chatMsg:getChannel()
    if channel == ChatConst.CHANNEL_PRIVATE and not UserDataHelper.isSlienceToPlayer(chatMsg:getSender():getId()) then
        local title = Lang.get("chat2_slience_title")
        local content = Lang.get("chat2_slience_alert")
        local popupSystemAlert = require("app.ui.PopupSystemAlert").new(title, content,function() 
            G_UserData:getChat():c2sChatSliencePrivate(chatMsg:getSender():getId())
        end)
        --popupSystemAlert:showGoButton(Lang.get("fight_kill_comfirm"))
        popupSystemAlert:setCheckBoxVisible(false)
        popupSystemAlert:openWithAction()
    end
    self:close()
end

return PopupTipoff