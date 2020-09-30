local CSHelper = require("yoka.utils.CSHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local RichTextHelper = require("app.utils.RichTextHelper")
local ChatConst = require("app.const.ChatConst")
local ViewBase = require("app.ui.ViewBase")
local PopupHonorTitleHelper = require("app.scene.view.playerDetail.PopupHonorTitleHelper")
local HonorTitleConst = require("app.const.HonorTitleConst")

--单个聊天信息显示
local PopupTipoffCheckMsgCell = class("PopupTipoffCheckMsgCell", ViewBase)

PopupTipoffCheckMsgCell.TEXT_WIDTH = 390
PopupTipoffCheckMsgCell.TEXT_MARGIN_BOTTOM = 0 --间隔
PopupTipoffCheckMsgCell.TEXT_MARGIN_TOP = 0 --图片尺寸28  字体20 （28-20）/2

function PopupTipoffCheckMsgCell:ctor(chatMsgData, listWidth)
    self._chatMsg = chatMsgData --聊天数据
    self._listWidth = listWidth --列表的宽度。
    self._resourceNode = nil
    self._extraHeight = 0 --聊天消息多出的显示高度
    self._senderTitle = 0
    self._isVoice = chatMsgData:isVoice()

    self._nodeMsg = nil
    local resource = nil
    if self._isVoice then
        local csb ="PopupTipOffChatMsgVoiceCell"
        resource = {
            file = Path.getCSB(csb, "chat"),
            binding = {
                _voiceBtn = {events = {{event = "touch", method = "_onClickItem"}}}
            }
        }
    else
        local csb = "PopupTipoffCheckMsgCell" 
        resource = {
            file = Path.getCSB(csb, "chat")
        }
    end
    PopupTipoffCheckMsgCell.super.ctor(self, resource)
end


function PopupTipoffCheckMsgCell:onCreate(...)
    self:_updateUI()
end

function PopupTipoffCheckMsgCell:onEnter()
    self._signalVoicePlayNotice =
        G_SignalManager:add(SignalConst.EVENT_VOICE_PLAY_NOTICE, handler(self, self._onEventVoicePlayNotice))

    self:_clearVoiceEffect()
end


function PopupTipoffCheckMsgCell:onExit()
    self._signalVoicePlayNotice:remove()
    self._signalVoicePlayNotice = nil
end

-- chatMsg 可能是空值
function PopupTipoffCheckMsgCell:_onEventVoicePlayNotice(event, chatMsg, isPlay)
    if not chatMsg or not chatMsg:voiceEquil(self._chatMsg) then
        return
    end
    if not self._isVoice then
        return
    end
    if isPlay then
        --播放语音动画
        self:_clearVoiceEffect()
        local imageVoice = self:getSubNodeByName("Image_voice")
        G_EffectGfxMgr:createPlayGfx(imageVoice, "effect_yuyin")
    else
        --暂停语音动画
        self:_clearVoiceEffect()
    end
end



function PopupTipoffCheckMsgCell:getTotalHeight()
    local viewSize = self._resourceNode:getContentSize()
    return viewSize.height + self._extraHeight
end



function PopupTipoffCheckMsgCell:_updateVoiceChatMsg()
    local voiceInfo = self._chatMsg:getVoiceInfo()
    self._textVoiceLen:setString(Lang.get("chat_voice_time", {value = voiceInfo.voiceLen}))


    local channel = self._chatMsg:getChannel()
    local baseId = self._chatMsg:getSender():getBase_id()
    local officialLevel = self._chatMsg:getSender():getOffice_level()
    self._senderTitle = self._chatMsg:getSender():getTitles() --称号
    local itemParams = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, baseId)
    local richElementList = {}

    --[[
    local serverName = ""
    if self._chatMsg:getSender().getServer_name then
        serverName = self._chatMsg:getSender():getServer_name()
    end
    local serverNameElement = self:_createServerNameElement(channel, serverName)
    table.insert(richElementList, 1, serverNameElement)
]]

    local timeElement = self:_createTimeElement(G_ServerTime:getTimeString(self._chatMsg:getTime()))
    table.insert(richElementList, 1, timeElement)

  --[[
    local channelElement = self:_createChannelRichElement(channel)
    table.insert(richElementList, 1, channelElement)
]]

    local richStr = json.encode(richElementList)

    self:_showTxt(richStr)

   

    local label = self._nodeMsg:getChildren()[1]
    local virtualContentSize = label:getVirtualRendererSize()
    self._nodeVoice:setPositionX(self._nodeMsg:getPositionX()+virtualContentSize.width+10)

end

function PopupTipoffCheckMsgCell:_updateUI()
    local channel = self._chatMsg:getChannel()
    self._imageChannel:loadTexture( Path.getTextSignet(ChatConst.CHANNEL_PNGS[channel]))
    if self._isVoice then
        self:_updateVoiceChatMsg()
    else
        self:_updateChatMsg()
    end
end


function PopupTipoffCheckMsgCell:_updateChatMsg()
    local channel = self._chatMsg:getChannel()
    local baseId = self._chatMsg:getSender():getBase_id()
    local officialLevel = self._chatMsg:getSender():getOffice_level()
    self._senderTitle = self._chatMsg:getSender():getTitles() --称号
    local itemParams = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, baseId)
    local richElementList =
        RichTextHelper.parse2RichMsgArr(
        {
            strInput = self._chatMsg:getContent(),
            textColor = Colors.NORMAL_BG_ONE , --Colors.channelColors[channel].c3b,
            fontSize = 20,
            msgType = self._chatMsg:getMsg_type(),
            -- outlineColor = Colors.channelColors[channel].outlineColor,
            -- outlineSize = 2,
        },
        {faceWidth = 20, faceHeight = 20}
    )

    --[[
    local serverName = ""
    if self._chatMsg:getSender().getServer_name then
        serverName = self._chatMsg:getSender():getServer_name()
    end
    local serverNameElement = self:_createServerNameElement(channel, serverName)
    table.insert(richElementList, 1, serverNameElement)
]]

    local timeElement = self:_createTimeElement(self:_getTimeStr(self._chatMsg:getTime()))
    table.insert(richElementList, 1, timeElement)


    --local channelElement = self:_createChannelRichElement(channel)
    --table.insert(richElementList, 1, channelElement)
    

    local richStr = json.encode(richElementList)

    self:_showTxt(richStr)
end

function PopupTipoffCheckMsgCell:_getTimeStr(time)
    local localdate = G_ServerTime:getDateObject(time)
    return string.format("[%02d-%02d %02d:%02d] ", localdate.month, localdate.day,
        localdate.hour, localdate.min)
end

---将文本转换为可以使用的富文本格式。
function PopupTipoffCheckMsgCell:_showTxt(richStr)
    local label = ccui.RichText:createWithContent(richStr)
    -- i18n richtext 
    if Lang.checkLang(Lang.CN) or Lang.checkSquareLanguage() then
        label:setWrapMode(1)
    end
    label:setAnchorPoint(cc.p(0, 1))
    label:setCascadeOpacityEnabled(true)
    --=======================================================
    --计算富文本的Size
    label:setVerticalSpace(18)
    label:ignoreContentAdaptWithSize(false)
    -- i18n ja
    -- label:setContentSize(cc.size(PopupTipoffCheckMsgCell.TEXT_WIDTH, 0))
    label:setContentSize(cc.size(self._listWidth, 0))
    --高度0则高度自适应
    label:formatText()
    local virtualContentSize = label:getVirtualRendererSize()
    local richTextWidth = virtualContentSize.width
    local richtextHeight = virtualContentSize.height
    --=======================================================
    label:setPosition(0, 0)
    self._nodeMsg:removeAllChildren()
    self._nodeMsg:addChild(label)

    local panelSize = self._resourceNode:getContentSize()
    local totalHeight = math.max(richtextHeight, panelSize.height)

    self._extraHeight = totalHeight - panelSize.height
    self._resourceNode:setPositionY(self._extraHeight)
end

function PopupTipoffCheckMsgCell:_createTimeElement(content)
    local element = {}
    element.type = "text"
    element.msg = content
    element.color = Colors.NORMAL_BG_ONE  
    element.opacity = 255
    -- element.outlineColor = outlineColor
    -- element.outlineSize = outlineSize
    element.fontSize = 20
    return element
end

function PopupTipoffCheckMsgCell:_createNameRichElement(content, fontSize, textColor, outlineColor, outlineSize)
    local element = {}
    element.type = "text"
    element.msg = content
    element.color = textColor
    element.opacity = 255
    -- element.outlineColor = outlineColor
    -- element.outlineSize = outlineSize
    element.fontSize = fontSize
    return element
end

function PopupTipoffCheckMsgCell:_createChannelRichElement(channel)
    local element = {}
    element.type = "image"
    element.filePath = Path.getTextSignet(ChatConst.CHANNEL_PNGS[channel])
    element.width = ChatConst.IMAGE_CHANNEL_WIDTH * 1
    element.height = ChatConst.IMAGE_CHANNEL_HEIGHT * 1
    return element
end

function PopupTipoffCheckMsgCell:_createServerNameElement(channel, serverName)
    local formatName = require("app.utils.TextHelper").cutText(serverName)
    local element = {}
    element.type = "text"
    element.msg = formatName
    element.color = Colors.channelColors[1].c3b --用世界频道的颜色
    element.opacity = 255
    element.fontSize = 20
    return element
end

function PopupTipoffCheckMsgCell:_createVoiceRichElement(channel)
    local element = {}
    element.type = "image"
    element.filePath = Path.getVoiceRes(ChatConst.CHANNEL_VOICE_PNGS[channel])
    return element
end

function PopupTipoffCheckMsgCell:getChatMsg()
    return self._chatMsg
end


function PopupTipoffCheckMsgCell:_onClickItem(sender)
    local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
    local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
    if offsetX < 20 and offsetY < 20 then
        if self._isVoice then
            G_VoiceManager:playRecordVoice(self._chatMsg)
        end
    end
end

function PopupTipoffCheckMsgCell:_clearVoiceEffect(...)
    -- body
    if not self._isVoice then
        return
    end
    --清理特效
    local imageVoice = self:getSubNodeByName("Image_voice")
    imageVoice:removeAllChildren()
end

return PopupTipoffCheckMsgCell
