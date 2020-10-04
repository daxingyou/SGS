local CSHelper = require("yoka.utils.CSHelper")
local UIHelper = require("yoka.utils.UIHelper")
local RichTextHelper = require("app.utils.RichTextHelper")
local ChatConst = require("app.const.ChatConst")
local ViewBase = require("app.ui.ViewBase")
--单个聊天信息显示
local ChatMsgItemCell = class("ChatMsgItemCell", ViewBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local HonorTitleConst = require("app.const.HonorTitleConst")
--i18n 参数scrollView
function ChatMsgItemCell:ctor(chatMsgData, listWidth,scrollView)
    self._isLeft = not chatMsgData:getSender():isSelf()
    self._isVoice = chatMsgData:isVoice()
    self._chatMsg = chatMsgData --聊天数据
    self._needShowTime = self._chatMsg:getNeedShowTimeLabel() --是否需要显示时间。
    self._listWidth = listWidth --列表的宽度。
    self._resourceNode = nil
    self._extraHeight = 0 --聊天消息多出的显示高度
    self._viewTimeNode = nil
    self._commonHeroIcon = nil
    self._imageBgRichText = nil --富文本的聊天气泡
    self._panelRichText = nil
    self._imageChannel = nil
	--i18n 参数scrollView
    self._scrollViewI18n = scrollView
    --频道Icon

    self._voiceBtn = nil
    self._textVoiceLen = nil
    self._spriteTitle = nil -- 称号图片

    self._isEvent = chatMsgData:isEvent()

    local resource = nil
    if self._isVoice then
        local csb = self._isLeft and "ChatVoiceItemCell" or "ChatVoiceRightItemCell"
        resource = {
            file = Path.getCSB(csb, "chat"),
            binding = {
                _voiceBtn = {events = {{event = "touch", method = "_onClickItem"}}}
                --  _imageBgRichText = {events = {{event = "touch", method = "_onClickItem"}}},
            }
        }
    else
        local csb = self._isLeft and "ChatMsgItemCell" or "ChatMsgRightItemCell"
        resource = {
            file = Path.getCSB(csb, "chat")
        }
    end
    ChatMsgItemCell.super.ctor(self, resource)
end

function ChatMsgItemCell:onCreate(...)
    --i18n 有2个聊天底框_imageBgRichText，隐藏
    if Lang.checkChannel(Lang.CHANNEL_SEA) then
        if self._isVoice and not self._isLeft then
            local imageBg = self._resourceNode:getChildByTag(490)
            if imageBg then
                imageBg:setVisible(false)
            end
        end
        self:_createTranslateNodeForI18n()
    end
 
    -- body
    self._imageVocie = ccui.Helper:seekNodeByName(self, "Image_voice")
    self._imageBgRichText:addTouchEventListener(handler(self, self._onScrollViewTouchCallBack))

    self:_initUI()
    self:_updateUI()
end
function ChatMsgItemCell:onEnter()
    self._signalVoicePlayNotice =
        G_SignalManager:add(SignalConst.EVENT_VOICE_PLAY_NOTICE, handler(self, self._onEventVoicePlayNotice))

    self:_clearVoiceEffect()
end

function ChatMsgItemCell:_clearVoiceEffect(...)
    -- body
    if not self._isVoice then
        return
    end
    --清理特效
    local imageVoice = self:getSubNodeByName("Image_voice")
    imageVoice:removeAllChildren()
end

function ChatMsgItemCell:onExit()
    self._signalVoicePlayNotice:remove()
    self._signalVoicePlayNotice = nil
end

-- chatMsg 可能是空值
function ChatMsgItemCell:_onEventVoicePlayNotice(event, chatMsg, isPlay)
    if not self._isVoice then
        return
    end
    if isPlay and chatMsg and chatMsg:voiceEquil(self._chatMsg) then
        --播放语音动画
        self:_clearVoiceEffect()
        local imageVoice = self:getSubNodeByName("Image_voice")
        G_EffectGfxMgr:createPlayGfx(imageVoice, "effect_yuyin")
    --self._textVoiceLen:setScale(2.0)
    end
    if not isPlay and chatMsg and chatMsg:voiceEquil(self._chatMsg) then
        --暂停语音动画
        self:_clearVoiceEffect()
    --G_EffectGfxMgr:createPlayGfx(imageVoice,"effect_yuyin")
    --self._textVoiceLen:setScale(1.0)
    end
end

function ChatMsgItemCell:_initUI()
    self._commonHeroIcon:setTouchEnabled(true)
    self._commonHeroIcon:setCallBack(handler(self, self.onClickHeroHead))
    self._imageBgRichText:setSwallowTouches(false)

    --i18n 新增变量
    self._panelSizeI18n = self._panelRichText:getContentSize()
    self._imgSizeI18n  = self._imageBgRichText:getContentSize()
end

function ChatMsgItemCell:onClickHeroHead(sender)
    local chatPlayerData = self._chatMsg:getSender()
    if not chatPlayerData:isSelf() then
        G_SignalManager:dispatch(SignalConst.EVENT_CHAT_SHOW_PLAYER_DETAIL, chatPlayerData)
    else
        dump(chatPlayerData)
    end
end

function ChatMsgItemCell:getTotalHeight()
    local viewSize = self._resourceNode:getContentSize()
    local viewTimeHeight = self._viewTimeNode == nil and 0 or self._viewTimeNode:getContentSize().height

    return viewSize.height + viewTimeHeight + self._extraHeight
end

function ChatMsgItemCell:_updateUI()
    local viewSize = self._resourceNode:getContentSize()
    local officialLevel = self._chatMsg:getSender():getOffice_level()
    local playerInfo = self._chatMsg:getSender():getPlayer_info()
    local baseId = self._chatMsg:getSender():getPlayer_info().covertId
    local senderTitle = self._chatMsg:getSender():getTitles() --称号
    local nameColor = Colors.getOfficialColor(officialLevel)
    local nameOutline = Colors.getOfficialColorOutline(officialLevel)
    local channel = self._chatMsg:getChannel()

    self._imageChannel:loadTexture(Path.getTextSignet(ChatConst.CHANNEL_PNGS[channel]))
    self._imageChannel:setVisible(true)
    self._textPlayerName:setString(self._chatMsg:getSender():getName())
    self._textPlayerName:setColor(nameColor)

    -- settexture of Title
    if self._spriteTitle ~= nil then
        dump(senderTitle)
        if senderTitle and senderTitle > 0 then
            UserDataHelper.appendNodeTitle(self._spriteTitle,senderTitle,self.__cname)
            self._spriteTitle:setVisible(true)
        else
            self._spriteTitle:setVisible(false)
        end
    end

    --聊天频道，如果是私聊
    if channel == ChatConst.CHANNEL_PRIVATE then
        local chatPlayerData = self._chatMsg:getSender()
        local chatTargetId = chatPlayerData:getId()
        if chatPlayerData:isSelf() then
            self._imageChannel:loadTexture(Path.getTextSignet("img_voice_ziji"))
            self._imageChannel:setVisible(false)
            local targetPox = self._textPlayerName:getPositionX() + self._imageChannel:getContentSize().width
            self._textPlayerName:setPositionX(targetPox)

            if self._spriteTitle ~= nil then
                local titilePosX =
                    (self._textPlayerName:getPositionX() - (self._textPlayerName:getContentSize().width+ChatConst.CHAT_TITLE_OFFSET))
                self._spriteTitle:setPositionX(titilePosX)
            end
        else
            local isFriend = G_UserData:getFriend():isUserIdInFriendList(chatTargetId)
            if isFriend then
                self._imageChannel:loadTexture(Path.getTextSignet("img_voice_haoyou"))
            else
                self._imageChannel:loadTexture(Path.getTextSignet("img_voice_moshengren"))
            end

            if self._spriteTitle ~= nil then
                local titilePosX =
                    (self._textPlayerName:getPositionX() + (self._textPlayerName:getContentSize().width+ChatConst.CHAT_TITLE_OFFSET))
                self._spriteTitle:setPositionX(titilePosX)
            end
        end
    else
        if self._spriteTitle ~= nil then
            local chatPlayerData = self._chatMsg:getSender()
            if chatPlayerData:isSelf() then
                local titilePosX =
                    (self._textPlayerName:getPositionX() - (self._textPlayerName:getContentSize().width+ChatConst.CHAT_TITLE_OFFSET))
                self._spriteTitle:setPositionX(titilePosX)
            else
                local titilePosX =
                    (self._textPlayerName:getPositionX() +  (self._textPlayerName:getContentSize().width+ChatConst.CHAT_TITLE_OFFSET))
                self._spriteTitle:setPositionX(titilePosX)
            end
        end
    end

    self._commonHeroIcon:updateIcon(playerInfo, nil, self._chatMsg:getSender():getHead_frame_id())
    --self._commonHeadFrame:updateUI(self._chatMsg:getSender():getHead_frame_id(),self._commonHeroIcon:getScale())

    -- self._textPlayerName:enableOutline(nameOutline,2)

    --在内部定位左边和右边
    if self._isLeft then
        self._resourceNode:setAnchorPoint(0, 0)
        self._resourceNode:setPositionX(0)
    else
        self._resourceNode:setAnchorPoint(1, 0)
        self._resourceNode:setPositionX(self._listWidth)
    end

    if self._needShowTime then
        self._viewTimeNode = self:_createTimeTipNode(G_ServerTime:getTimeString(self._chatMsg:getTime()))
        self._viewTimeNode:setPosition(viewSize.width * 0.5, viewSize.height)
        self._resourceNode:addChild(self._viewTimeNode)
    end



    if not Lang.checkLang(Lang.CN) and self._isVoice then
         self:_showTxt("",self._chatMsg:getMsg_type())
    else
         

         if Lang.checkChannel(Lang.CHANNEL_SEA) then
            local needTranslate = self:_needTranslateForI18n()
            if self._chatMsg:isTranslate() then
                local tran = G_UserData:getChat():getTranslateI18n(self._chatMsg:getContent(),Lang.lang)
                self:_showTxt(self._chatMsg:getContent(),self._chatMsg:getMsg_type(),tran)
                self:_showTranslateNodeForI18n(2)
                self:_updateTranslateNodePosForI18n()
            elseif needTranslate then
                self:_showTxt(self._chatMsg:getContent(),self._chatMsg:getMsg_type())
                self:_showTranslateNodeForI18n(1)
                self:_updateTranslateNodePosForI18n()
            else
                self:_showTxt(self._chatMsg:getContent(),self._chatMsg:getMsg_type())
                self:_showTranslateNodeForI18n(3)
            end
        else
            self:_showTxt(self._chatMsg:getContent(),self._chatMsg:getMsg_type())
        end

    end

    if self._isVoice then
        local voiceInfo = self._chatMsg:getVoiceInfo()
        self._textVoiceLen:setString(Lang.get("chat_voice_time", {value = voiceInfo.voiceLen}))
    end

    
end

function ChatMsgItemCell:_createTimeTipNode(text)
    local viewTimeNode = CSHelper.loadResourceNode(Path.getCSB("ChatTimeTipLayer", "chat"))
    local textTime = ccui.Helper:seekNodeByName(viewTimeNode, "Text_Time")
    textTime:setString(text)
    viewTimeNode:setAnchorPoint(0.5, 0)
    return viewTimeNode
end

--i18n 新增翻译参数 translateTxt
---将文本转换为可以使用的富文本格式。
function ChatMsgItemCell:_showTxt(chatContent, type, translateTxt)
    --i18n 添加翻译节点
    local createRichLabel = function(chatContent)
        local richElementList =
            RichTextHelper.parse2RichMsgArr(
            {
                strInput = chatContent,
                textColor = Colors.CHAT_MSG,
                fontSize = 20,
                msgType = type,
            }
        )
        local richStr = json.encode(richElementList)

        local label = ccui.RichText:createWithContent(richStr)
        -- i18n richtext 
        if Lang.checkLang(Lang.CN) or Lang.checkSquareLanguage() then
            label:setWrapMode(1)
        elseif Lang.checkChannel(Lang.CHANNEL_SEA) then
            if G_NativeAgent:getNativeVersion() >=4 then
                label:setWrapMode(2)
            else
                label:setWrapMode(1)
            end
        end
        label:setAnchorPoint(cc.p(0.5, 0.5))
        label:setCascadeOpacityEnabled(true)
        --=======================================================
        --计算富文本的Size
        label:ignoreContentAdaptWithSize(false)
        label:setContentSize(cc.size(310, 0))
        --高度0则高度自适应
        label:formatText()
        local virtualContentSize = label:getVirtualRendererSize()
        local richTextWidth = virtualContentSize.width
        local richtextHeight = virtualContentSize.height
        logWarn("---->>>>>>chat msg width:" .. tostring(richTextWidth) .. " height:" .. tostring(richtextHeight))
        --=======================================================
        return label
    end
    
    if Lang.checkChannel(Lang.CHANNEL_SEA) and translateTxt then
        self._panelRichText:removeAllChildren()

        local label1 = createRichLabel(chatContent)
        local label2 = createRichLabel(translateTxt)
        self._panelRichText:addChild(label1)
        self._panelRichText:addChild(label2)
        
        local virtualContentSize1 = label1:getVirtualRendererSize()
        local virtualContentSize2 = label2:getVirtualRendererSize()

        local panelSize = self._panelSizeI18n--self._panelRichText:getContentSize()
        local imgSize =  self._imgSizeI18n  --self._imageBgRichText:getContentSize()
        local horizonBlank = imgSize.width - panelSize.width
        local verticalBlank = imgSize.height - panelSize.height
        logWarn("chat msg horizonBlank:" .. tostring(horizonBlank) .. " verticalBlank:" .. tostring(verticalBlank))
        local newWidth = math.max(panelSize.width,math.max(virtualContentSize1.width, virtualContentSize2.width))
        local newHeight = math.max(panelSize.height, virtualContentSize1.height + virtualContentSize2.height + 20)
        logWarn("chat msg newHeight:" .. tostring(virtualContentSize1.height) .. " " .. tostring(virtualContentSize2.height))
        local imgNewWidth = newWidth + horizonBlank
        local imgNewHeight = newHeight + verticalBlank
        self._extraHeight = imgNewHeight - imgSize.height 
        self._extraHeight =  self._extraHeight + self._alreadyTransIconSprite:getContentSize().height + 5

        logWarn("chat msg Fixxx:" ..self._extraHeight)

        self._resourceNode:setPositionY(self._extraHeight)

        self._imageBgRichText:setContentSize(imgNewWidth, imgNewHeight)
        self._panelRichText:setContentSize(newWidth, newHeight)

        label1:setAnchorPoint(cc.p(0.5, 1))
        label1:setPosition(cc.p(newWidth * 0.5, newHeight))
        label2:setAnchorPoint(cc.p(0.5, 0))
        label2:setPosition(cc.p(newWidth * 0.5, 0))
    else
        local label = createRichLabel(chatContent)

        local virtualContentSize = label:getVirtualRendererSize()
        local richTextWidth = virtualContentSize.width
        local richtextHeight = virtualContentSize.height

        self._panelRichText:removeAllChildren()
        self._panelRichText:addChild(label)

        local panelSize = self._panelRichText:getContentSize()
        local imgSize = self._imageBgRichText:getContentSize()
        local horizonBlank = imgSize.width - panelSize.width
        local verticalBlank = imgSize.height - panelSize.height
        logWarn("chat msg horizonBlank:" .. tostring(horizonBlank) .. " verticalBlank:" .. tostring(verticalBlank))
        local newWidth = math.max(panelSize.width, richTextWidth)
        local newHeight = math.max(panelSize.height, richtextHeight)

        local imgNewWidth = newWidth + horizonBlank
        local imgNewHeight = newHeight + verticalBlank
        self._extraHeight = imgNewHeight - imgSize.height
        self._resourceNode:setPositionY(self._extraHeight)

        self._imageBgRichText:setContentSize(imgNewWidth, imgNewHeight)
        self._panelRichText:setContentSize(newWidth, newHeight)

        label:setPosition(cc.p(newWidth * 0.5, newHeight * 0.5))
    end 
end

function ChatMsgItemCell:getChatMsg()
    return self._chatMsg
end

function ChatMsgItemCell:_onClickItem(sender)
    local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
    local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
    if offsetX < 20 and offsetY < 20 then
        if self._isVoice then
            G_VoiceManager:playRecordVoice(self._chatMsg)
        elseif self._isEvent then
            local sceneName = G_SceneManager:getRunningScene():getName()
            if sceneName == "fight" then
                G_Prompt:showTip(Lang.get("chat_pk_hint_when_infight"))
            else
                if G_SceneManager:getRunningSceneName() == "guildTrain" and not G_UserData:getGuild():getTrainEndState() then
                    G_Prompt:showTipOnTop(Lang.get("guild_exit_tanin_forbid"))
                    return
                end

                local teamType = tonumber(self._chatMsg:getParameter():getValue("teamType"))
                local teamId = tonumber(self._chatMsg:getParameter():getValue("teamId"))
                logWarn("ChatMsgItemCell on click event item ----------------"..tostring(teamId) )
                local isOk, func = require("app.scene.view.groups.GroupsViewHelper").checkIsCanApplyJoin(teamType)
                if isOk then
                    G_UserData:getGroups():c2sApplyTeam(teamType,teamId)
                else
                    if func then
                        func()
                    end
                end
            end
        end
    end
end

function ChatMsgItemCell:_onLongPressCallBack(sender, state)
    if self._moveX < 20 and self._moveY < 20 then
        --复制图片
        local point = cc.p(sender:getTouchBeganPosition().x, sender:getTouchBeganPosition().y)
        local txt = self._chatMsg:getContent()

        --local worldPos = node:convertToWorldSpaceAR(cc.p(0,0))
        --local btnNewPos = container:convertToNodeSpace(cc.p(worldPos))

        local chatCopyNode = G_SceneManager:getRunningScene():getVoiceViewByName("ChatCopyNode")
        if chatCopyNode then
            chatCopyNode:removeFromParent()
        end
        local ChatCopyNode = require("app.scene.view.chat.ChatCopyNode")
        local node = ChatCopyNode.new(point, txt)
        node:setName("ChatCopyNode")

        G_SceneManager:getRunningScene():addChildToVoiceLayer(node)
    end
end

function ChatMsgItemCell:_onScrollViewTouchCallBack(sender, state)
    if state == ccui.TouchEventType.began then
        self._delayStamp = timer:getms()
        self._moveX, self._moveY = 0, 0
        --启动计时器
        local scheduler = require("cocos.framework.scheduler")
        if self._listener then
            scheduler.unscheduleGlobal(self._listener)
        end
        self._listener =
            scheduler.performWithDelayGlobal(
            function()
                logWarn("ChatMsgItemCell long click------------------")
                if self._delayStamp then
                    self._delayStamp = nil
                    logWarn("ChatMsgItemCell long click ok ------------------")
                    self:_onLongPressCallBack(sender, state)
                end
            end,
            0.6
        )
    elseif state == ccui.TouchEventType.moved then
        local offsetX = math.abs(sender:getTouchMovePosition().x - sender:getTouchBeganPosition().x)
        local offsetY = math.abs(sender:getTouchMovePosition().y - sender:getTouchBeganPosition().y)
        -- logWarn( offsetX.." ------------------ "..offsetY)
        self._moveX, self._moveY = offsetX, offsetY
    elseif state == ccui.TouchEventType.ended or state == ccui.TouchEventType.canceled then
        if state == ccui.TouchEventType.ended and self._delayStamp then
            self:_onClickItem(sender, state)
        end
        self._delayStamp = nil
    end
end

--i18n 创建翻译节点
function ChatMsgItemCell:_createTranslateNodeForI18n()
    local transIconSprite = ccui.ImageView:create()
    transIconSprite:loadTexture(Path.getTranslate("img_chat_fanyi"))
        
    local alreadyTransIconSprite = ccui.ImageView:create()
    alreadyTransIconSprite:loadTexture(Path.getTranslate("img_chat_bg"), ccui.TextureResType.localType)
    alreadyTransIconSprite:setScale9Enabled(true)
    alreadyTransIconSprite:setCapInsets(cc.rect(37,7,10,10))
    local transSplitLineSprite = cc.Sprite:create(Path.getTranslate("img_chat_line"))
    transIconSprite:setTouchEnabled(true)
    transIconSprite:addClickEventListenerEx(handler(self,self.onTranClickListenerForI18n))
    self._resourceNode:addChild(transIconSprite)
    self._resourceNode:addChild(alreadyTransIconSprite)
    self._resourceNode:addChild(transSplitLineSprite)

    local fontSize = 15
    if Lang.checkLang(Lang.ZH) then
        fontSize = 15
    elseif Lang.checkLang(Lang.TH) or Lang.checkLang(Lang.EN)  then
        fontSize = 18
    end
    local label = UIHelper.createLabel({
        text = Lang.getImgText("chat_translated"),
        position = cc.p(23,13),
        color = cc.c3b(0xff, 0xff, 0xff),
        fontSize = fontSize
    })
    label:setAnchorPoint(cc.p(0,0.5))
    if Lang.checkLang(Lang.TH) then
        label:setPositionY(label:getPositionY()-3)
    end
    local labelSize = label:getContentSize()
    
    local size = alreadyTransIconSprite:getContentSize()
    alreadyTransIconSprite:setContentSize(cc.size(labelSize.width + 28,size.height))
    alreadyTransIconSprite:addChild(label)

    self._transIconSprite = transIconSprite
    self._alreadyTransIconSprite = alreadyTransIconSprite
    self._transSplitLineSprite = transSplitLineSprite

    self:_showTranslateNodeForI18n(3)
end

--i18n 显示翻译节点
function ChatMsgItemCell:_showTranslateNodeForI18n(status,tranTxt)
    self._i18nTranslateStatus = status 
    if status == 1 then--未翻译
        self._transIconSprite:setVisible(true)
        self._alreadyTransIconSprite:setVisible(false)
        self._transSplitLineSprite:setVisible(false)
    elseif status == 2 then--已翻译
        self._transIconSprite:setVisible(false)
        self._alreadyTransIconSprite:setVisible(true)
        self._transSplitLineSprite:setVisible(true)

       
    else --不需要翻译
        self._transIconSprite:setVisible(false)
        self._alreadyTransIconSprite:setVisible(false)
        self._transSplitLineSprite:setVisible(false)
    end
end

--i18n 显示翻译节点
function ChatMsgItemCell:_updateTranslateNodePosForI18n()
    if self._i18nTranslateStatus == 1 then--未翻译
        self._transIconSprite:setAnchorPoint(cc.p(0,0))
        self._transIconSprite:setPositionX(self._imageBgRichText:getPositionX()+self._imageBgRichText:getContentSize().width+2)
        self._transIconSprite:setPositionY(self._imageBgRichText:getPositionY()-self._imageBgRichText:getContentSize().height+2)
    elseif self._i18nTranslateStatus == 2 then--已翻译
        local size = self._panelRichText:getContentSize()
        local label2 = self._panelRichText:getChildren()[2]
        if label2 then
            local virtualContentSize2 = label2:getVirtualRendererSize()
            local newWorldPos = self._panelRichText:convertToWorldSpace(cc.p(size.width*0.5,virtualContentSize2.height + 10))
            local linePos = self._resourceNode:convertToNodeSpace(newWorldPos)
            self._transSplitLineSprite:setPosition(linePos.x,linePos.y)
            self._transSplitLineSprite:setContentSize(cc.size(size.width,2))
            self._alreadyTransIconSprite:setAnchorPoint(cc.p(0,1))
            self._alreadyTransIconSprite:setPositionX(self._imageBgRichText:getPositionX()+10)
            self._alreadyTransIconSprite:setPositionY(self._imageBgRichText:getPositionY()-self._imageBgRichText:getContentSize().height-5)
        end
    else --不需要翻译
    end
end

--i18n 是否需要翻译
function ChatMsgItemCell:_needTranslateForI18n()
    --local Version = require("yoka.utils.Version")
    --local r = Version.compare("0.1.26", VERSION_RES)
    --if r ~= Version.CURRENT then
    --    return false
    --end
    local isVoice = self._chatMsg:isVoice()
    if isVoice then
        return false
    end
    local isSelf = self._chatMsg:getSender():isSelf()
    if isSelf then
        return false
    end
    if not G_NativeAgent:hasTranslate() then
       return false
    end
    local content = self._chatMsg:getContent()
    local start,endIndex = string.find(content,".*[^#0-9]+.*")
    return start ~= nil 
end

function ChatMsgItemCell:_updateTranTxtForI18n(tranTxt)
    self:_showTxt(self._chatMsg:getContent(),self._chatMsg:getMsg_type(),tranTxt)
    self:_showTranslateNodeForI18n(2)
    self:_updateTranslateNodePosForI18n()
end

--i18n 翻译
function ChatMsgItemCell:_translateForI18n()
    G_NativeAgent:translateWithText(tostring(self._chatMsg:getId()),Lang.lang,self._chatMsg:getContent())
    --[[
    if tranTxt == txt then
        return
    end
    self._chatMsg:setTranslate(true)
    G_UserData:getChat():cacheTranslateI18n(self._chatMsg:getContent(),tranTxt,Lang.lang)

    local index = self._scrollViewI18n:getItemIndexByChatMsgForI18n(self._chatMsg)
    local dis = self._scrollViewI18n:getItemTopToScreenBottomDisForI18n(index)

    self:_updateTranTxtForI18n(tranTxt)

    self._scrollViewI18n:_refreshItemsPos()
    self._scrollViewI18n:fixItemToScreenPosForI18n(index,dis)
    ]]
end

function ChatMsgItemCell:onTranClickListenerForI18n(sender)
    local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
    local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
    if offsetX < 20 and offsetY < 20 then
        self:_translateForI18n()
    end
end

return ChatMsgItemCell
