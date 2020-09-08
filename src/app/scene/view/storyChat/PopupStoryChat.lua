local PopupBase = require("app.ui.PopupBase")
local PopupStoryChat = class("PopupStoryChat", PopupBase)


local StoryChat = require("app.config.story_chat")
local Scheduler = require("cocos.framework.scheduler")
local Hero = require("app.config.hero")
local HeroRes = require("app.config.hero_res")
local StoryChatLength = require("app.config.story_chat_length")


--chat类型
PopupStoryChat.TYPE_CHAPTER_START = 1			--第一次进入章节触发

PopupStoryChat.ZORDER_BASE = 0          
PopupStoryChat.ZORDER_LINSTER = 1           --听话的人
PopupStoryChat.ZORDER_COVER = 2             --黑色遮罩
PopupStoryChat.ZORDER_TALKER = 3            --说话的人
PopupStoryChat.ZORDER_CONTENT_PANEL = 4     --说话面板
PopupStoryChat.ZORDER_TOUCH = 5				--触摸层
PopupStoryChat.ZORDER_JUMP = 6              --跳过按钮

PopupStoryChat.ROLE_LEFT = 1
PopupStoryChat.ROLE_RIGHT = 2

PopupStoryChat.AUTO_SKIP_TIME = 5

PopupStoryChat.DEFAULT_SOUND_LENGTH = 10

function PopupStoryChat:ctor(touchId, callback, isTutorial)
    self._touchId = touchId
	self._touchList = {}
	self._soundList = {}
	self._idx = 0	--放到第几段对话
	self._startTime = 0
    self._roles = {}	--场上人物  1,左， 2，右

	self._panelTouch = nil		--触摸版
	self._panelCover = nil		--黑色遮罩层

	self._scheduler = nil		--update
	self._startPlay = false

	self._callbackHandler = callback	--结束后回调
	self._jumpCallback = nil        --跳过时候特殊回掉

	self._isTutorial = isTutorial

	self._nowPlayId = nil
	self._hasSound = false	--播放的对话有没有配语音

	self._signalSpineLoaded = nil

	self._spineIdList = {}

	-- self._signalSoundEnd = nil

	self._myHeroId = G_UserData:getHero():getRoleBaseId()	--我的英雄id

	self._soundLength = PopupStoryChat.DEFAULT_SOUND_LENGTH		--声音长度

    -- i18n ja mouth
    self._pcmData       = nil
    self._hasMouth      = false                     -- 当前角色的动作是否有嘴巴
	self._mouthState    = -1						-- 嘴部状态 0 闭嘴 1 张嘴 -1 默认值
    self._pcmTime       = 0

	local resource = {
		file = Path.getCSB("StoryChatView", "storyChat"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onPanelTouch"}}
			},
			_imageJump = {
				events = {{event = "touch", method = "_onJumpTouch"}}
			}
		}
	}
	if Lang.checkUI("ui4") then
		resource.file = Path.getCSB("StoryChatView2", "storyChat")
	end
	self:setName("PopupStoryChat")
	PopupStoryChat.super.ctor(self, resource, false, true)
	if Lang.checkUI("ui4") then
		self._timeScale = cc.Director:getInstance():getScheduler():getTimeScale()
	end
end

function PopupStoryChat:onCreate()
	-- i18n pos lable
	self:_dealPosI18n()
	self._spineIdList = {}
	local count = StoryChat.length()
	for i = 1, count do
		local touch = StoryChat.indexOf(i)
		if touch.story_touch == self._touchId then
			table.insert(self._touchList, touch)
		end
	end

	for i = 1, #self._touchList do
		local touch = self._touchList[i]
		local sound = touch.common_sound
		local myHeroId = self._myHeroId
		if myHeroId then
			if Hero.get(myHeroId).gender == 2 then
				sound = touch.common_sound2
			end
		end
		local soundPath = Path.getSkillVoice(sound)
		G_AudioManager:preLoadSound(soundPath)
		table.insert(self._soundList, soundPath)

		if touch.story_res1 ~= 1 then
			self:_addSpine(touch.story_res1)
		end 
		if touch.story_res2 ~= 1 then 
			self:_addSpine(touch.story_res2)
		end
		self:_addSpine(self._myHeroId)
	end

	assert(#self._touchList ~= 0 , "chat id is error "..self._touchId)
    table.sort(self._touchList, function(a, b) return a.step < b.step end)

    self._panelCover:setLocalZOrder(PopupStoryChat.ZORDER_COVER)
    self._panelChat:setLocalZOrder(PopupStoryChat.ZORDER_CONTENT_PANEL)
	self._panelTouch:setLocalZOrder(PopupStoryChat.ZORDER_TOUCH)
    self._imageJump:setLocalZOrder(PopupStoryChat.ZORDER_JUMP)

	local resolutionSize =  G_ResolutionManager:getDesignCCSize()
	self._panelCover:setContentSize(cc.size( resolutionSize.width*2, resolutionSize.height*2))
	self._panelCover:setTouchEnabled(true)
	self._panelCover:addClickEventListenerEx(handler(self, self.onTouchHandler))

	-- i18n ja 剧情自动播放
	if Lang.checkUI("ui4") then
		self:_updateAuto()
		self:_showArrowTip()
	end
end


function PopupStoryChat:_addSpine(id)
	local heroData = Hero.get(id)
	if not heroData then 
		return 
	end
	local resId = heroData.res_id
	local resData = HeroRes.get(resId)
	local spineId = resData.story_res_spine
	if spineId == 0 then 
		return 
	end
	for i, v in pairs(self._spineIdList) do 
		if v == spineId then 
			return 
		end
	end
	print("1112233 insert spine = ", spineId, id)
	table.insert(self._spineIdList, spineId)
end

function PopupStoryChat:_cacheSpine()
	local spineList = self._spineIdList
	self._loadCount = 0
	self._totalSpine = #spineList
	for i, v in pairs(spineList) do 
		G_SpineManager:addSpineAsync(Path.getStorySpine(v), 1, function ()
			G_SignalManager:dispatch(SignalConst.EVENT_CHAT_SPINE_LOADED)
		end, self)	
	end
end

function PopupStoryChat:onTouchHandler( ... )
	-- body
	logWarn("PopupStoryChat:onTouchHandler")
end
function PopupStoryChat:onEnter()
	if Lang.checkUI("ui4") then
		cc.Director:getInstance():getScheduler():setTimeScale(1)
	end

	self:setPosition(cc.p(0, 0))
	
    self._panelChat:setVisible(false)
	self._scheduler = Scheduler.scheduleGlobal(handler(self, self._update), 0.1)

	self._signalSpineLoaded = G_SignalManager:add(SignalConst.EVENT_CHAT_SPINE_LOADED, handler(self, self._onSpineLoaded))
	
	self:_cacheSpine()
	
	-- self._signalSoundEnd = G_SignalManager:add(SignalConst.EVENT_SOUND_END, handler(self, self._onEventSoundEnd))

	--对话要申请触摸
	G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_BEGIN)
end

function PopupStoryChat:onExit()
	if Lang.checkUI("ui4") then
		cc.Director:getInstance():getScheduler():setTimeScale(self._timeScale)
	end
	for i, v in pairs(self._soundList) do 
		G_AudioManager:unLoadSound(v)
	end
	self._signalSpineLoaded:remove()
	self._signalSpineLoaded = nil

	G_SpineManager:removeSpineLoadHandlerByTarget(self)
	-- self._signalSoundEnd:remove()
	-- self._signalSoundEnd = nil
end

function PopupStoryChat:onClose()
	--对话要申请触摸
	G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_END)
	if self._nowPlayId then 
		G_AudioManager:stopSound(self._nowPlayId)
		self._nowPlayId = nil
	end
	if self._scheduler then 
		Scheduler.unscheduleGlobal(self._scheduler)
		self._scheduler = nil
	end
	if self._callbackHandler then
		self._callbackHandler()
		self._callbackHandler = nil
	end

end

function PopupStoryChat:_onSpineLoaded()
	self._loadCount = self._loadCount + 1
	if self._loadCount == self._totalSpine then 
		self:_playNext()
	end
end

function PopupStoryChat:_playNext()
	self._startPlay = false
	self._idx = self._idx + 1
	if self._idx > #self._touchList then
        self:_talkEnd()
        return
	end
	self._startPlay = true
	self._startTime = 0
	self:_refreshTalk()
end

function PopupStoryChat:_refreshTalk()
    self:_refreshTalker()
    self:_refreshListener()
end

function PopupStoryChat:_refreshTalker()
    local talkData = self._touchList[self._idx]
    local speakerPos = talkData.speaker_position
    local role = self._roles[speakerPos]
    if not role then
        local chatNode = require("app.scene.view.storyChat.PopupStoryChatNode").new(talkData.story_res1, speakerPos, self._myHeroId)
        local baseNode = self:getResourceNode()
        baseNode:addChild(chatNode)
        self._roles[speakerPos] = chatNode
        chatNode:enterStage(handler(self, self._refreshTalkContent))
    elseif role and role:getHeroId() ~= talkData.story_res1 then
        role:leaveStage()
        local chatNode = require("app.scene.view.storyChat.PopupStoryChatNode").new(talkData.story_res1, speakerPos, self._myHeroId)
        local baseNode = self:getResourceNode()
        baseNode:addChild(chatNode)
        self._roles[speakerPos] = chatNode
        chatNode:enterStage(handler(self, self._refreshTalkContent))
    else
        self:_refreshTalkContent()
    end
    self._roles[speakerPos]:setLocalZOrder(PopupStoryChat.ZORDER_TALKER)
end

function PopupStoryChat:_refreshListener()
    local talkData = self._touchList[self._idx]
    local speakerPos = talkData.speaker_position
    local listenPos = PopupStoryChat.ROLE_RIGHT
    if speakerPos == PopupStoryChat.ROLE_RIGHT then
        listenPos = PopupStoryChat.ROLE_LEFT
    end  

    local role = self._roles[listenPos]
    if role then
        role:setLocalZOrder(PopupStoryChat.ZORDER_LINSTER)
    end

    local res2 = talkData.story_res2
    if res2 == 0 or res2 == 999 then
        return
    end
    if role and role:getHeroId() == res2 then
        return
    end

    if role then
        role:leaveStage()
        self._roles[listenPos] = nil
    end
    local chatNode = require("app.scene.view.storyChat.PopupStoryChatNode").new(res2, listenPos, self._myHeroId)
    local baseNode = self:getResourceNode()
    baseNode:addChild(chatNode)
    self._roles[listenPos] = chatNode
    chatNode:setLocalZOrder(PopupStoryChat.ZORDER_LINSTER)
    chatNode:enterStage()
end

function PopupStoryChat:_refreshTalkContent()
    self._panelChat:setVisible(true)
	local talkData = self._touchList[self._idx]
	local showName = talkData.name1
	if talkData.name1 == Lang.get("main_role") then
		showName = G_UserData:getBase():getName()
	end
	self._chatName:setString(showName)

	local substance = talkData.substance
	local sound = talkData.common_sound
    local myHeroId = self._myHeroId
	if myHeroId then
		if Hero.get(myHeroId).gender == 2 then
			sound = talkData.common_sound2
			substance = talkData.substance2
		end
	end
    local richText = self:_parseDialogueContent(
        substance,
        26,
        Colors.getChatNormalColor(),
        self._chatContent:getContentSize()
    )
    if self._richTextNode then
        self._richTextNode:removeFromParent()
    end

    self._chatContent:addChild(richText)
    richText:setAnchorPoint(cc.p(0.5, 0.5))
    local posX = self._chatContent:getContentSize().width/2
    local posY = self._chatContent:getContentSize().height/2
    richText:setPosition(posX, posY)
	self._richTextNode = richText

	self._hasSound = false
	--播放声音
    -- i18n ja
	local isEnable = G_AudioManager:isSoundEnable()
	if Lang.checkUI("ui4") then
		isEnable = G_AudioManager:isVcEnable()
	end
	if isEnable and sound ~= "" then 
		local mp3 = Path.getSkillVoice(sound)
		if self._nowPlayId then 
			G_AudioManager:stopSound(self._nowPlayId)
			self._nowPlayId = nil
		end
		self._nowPlayId = G_AudioManager:playSound(mp3)
		-- if self._idx <= #self._touchList and self._nowPlayId then
		-- 	G_AudioManager:setCallback(self._nowPlayId, handler(self, self._playNext))
		-- end
		self._soundLength = math.ceil(StoryChatLength.get(sound).length/1000) 
		self._hasSound = true
		-- i18n ja mouth
		self:_parsePcmData(sound)
	else
		self._pcmData       = nil
        self._soundLength   = nil
        self._nowPlayId     = nil
	end

    if self:_checkSpineActionHasMouth(talkData.story_res1) then
        self._hasMouth  = true
    else
        self._hasMouth  = false
    end
end

function PopupStoryChat:_talkEnd()
	self._startPlay = false
	self:close()
end

function PopupStoryChat:_onPanelTouch()
	self:_playNext()
end

function PopupStoryChat:setJumpCallback(callback)
	self._jumpCallback = callback
end

function PopupStoryChat:_onJumpTouch()
    if self._jumpCallback then
		self._jumpCallback()
	end
    self:_talkEnd()
end

function PopupStoryChat:_update(f)
	if self._startPlay then
		self._startTime = self._startTime + f
		if not self._hasSound then
			if self._startTime >= PopupStoryChat.AUTO_SKIP_TIME then
				if self:_checkAuto() then
					self:_playNext()
				end
			end
		else
			-- i18n ja mouth
            if self._hasMouth then
                self._pcmTime   = self._pcmTime + f
				
				for i, v in ipairs(self._pcmData) do
					if self._pcmTime >= v.from / 1000 and self._pcmTime <= v.to / 1000 then
						if self._mouthState ~= v.voice then
							self._mouthState    = v.voice
			
							if self._mouthState == 1 then
								self:_playSpeakerMouthAnimation()
							else
								self:_playSpeakerCloseMouthAnimation()
							end
						end
					end
				end

			end
			
			if self._soundLength ~= 0 and self._startTime >= self._soundLength then 
				if self:_checkAuto() then
					self._hasSound  = false
					self._hasMouth  = false
					self:_playNext()
				end
			end
		end
	end

end

local function colorToNumber(color)
    if type(color) == "table" then
        local num = 0
        if color.r then
            num = num + color.r * 65536
        end
        if color.g then
            num = num + color.g * 256
        end
        if color.b then
            num = num + color.b
        end

        return num
    else
        return checknumber(color)
    end
end

function PopupStoryChat:_parseDialogueContent(dialogueContent, fontSize, fontColor, contentSize)
	-- 先找出所有的关键词，并整理
	local content = dialogueContent
	local contents = {}
	local lastIndex = 0
	while true do

		local headIndex = string.find(content, "#", lastIndex+1)
		local tailIndex

		if headIndex then
			tailIndex = string.find(content, "#", headIndex+1)
		else
			contents[#contents+1] = {content = string.sub(content, lastIndex+1), isKeyWord = false}
			break
		end

		if headIndex > lastIndex+1 then
			contents[#contents+1] = {content = string.sub(content, lastIndex+1, headIndex-1), isKeyWord = false}
		end

		if headIndex and tailIndex then
			if tailIndex > headIndex+1 then
				contents[#contents+1] = {content = string.sub(content, headIndex+1, tailIndex-1), isKeyWord = true}
			end
			lastIndex = tailIndex
		else
			if headIndex+1 < string.len(dialogueContent) then
				contents[#contents+1] = {content = string.sub(content, headIndex+1), isKeyWord = false}
			end
			break
		end

	end

	-- 文本模板
	local richTextContents = {}

	for i=1, #contents do

		local content = contents[i]
		
		table.insert(richTextContents, {
			type = "text",
			msg = content.content,
			color = colorToNumber(content.isKeyWord and cc.c3b(255, 0, 0) or fontColor),
			fontSize = fontSize,
			opacity = 255
		})

	end

	local richText = nil
	-- i18n richtext 
	if Lang.checkLang(Lang.CN) then
		richText = ccui.RichText:create()
	else
		richText = ccui.RichText:createByI18n()
	end

	richText:setCascadeOpacityEnabled(true)

	richText:setRichText(richTextContents)

	richText:setAnchorPoint(cc.p(0.5, 0.5))

	richText:ignoreContentAdaptWithSize(false)
	richText:setContentSize(contentSize)

	richText:formatText()

	local node = display.newNode()
	node:setAnchorPoint(cc.p(0.5, 0.5))
	node:setCascadeOpacityEnabled(true)
	node:setContentSize(contentSize)

	node:addChild(richText)

	richText:setPosition(contentSize.width/2, contentSize.height/2)

	return node

end

function PopupStoryChat:_onEventSoundEnd(eventName, soundId)
	if self._nowPlayId == soundId then 
		self._nowPlayId = nil
		self:_playNext()
	end
end

-- i18n pos lable
function PopupStoryChat:_dealPosI18n()
	if not Lang.checkLang(Lang.CN) and not Lang.checkUI("ui4") then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._chatContent:setFontSize(18)
		local size = self._chatContent:getContentSize()
		self._chatContent:setPositionY(self._chatContent:getPositionY()+15)
		self._chatContent:setContentSize(cc.size(size.width+20,size.height+20))
		local size1 = self._panelChat:getContentSize()
		self._panelChat:setContentSize(cc.size(size1.width,size1.height+20))

		self._chatName:setPositionY(self._chatName:getPositionY()+18)
		self._chatName:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
		self._chatName:getVirtualRenderer():setLineSpacing(-4)
		self._chatName:getVirtualRenderer():setMaxLineWidth(150)
	end
	if Lang.checkLang(Lang.ZH) then
		self._chatName:setFontSize(self._chatName:getFontSize()+2)
	end
end

-- i18n ja mouth start
-- 解析声音文件的pcm
function PopupStoryChat:_parsePcmData(sound)
    self._pcmData       = {}
	local SoundTrack    = require("app.config.soundtrack")
	local cfg = SoundTrack.get(sound)
	local content = string.split(cfg.soundtrack,"|") or {}
	local time      = 0
    for i, v in ipairs(content) do
        local data      = string.split(v,"-")
        local interval  = tonumber(data[2])
        table.insert(self._pcmData,{
            voice       = tonumber(data[1]),
            from        = time,
            to          = (time + interval),
            interval    = interval,
        })
        time        = time + interval
    end
	self._mouthState    = -1
    self._pcmTime       = 0

    -- dump(self._pcmData)
end

-- 这里策划要新增字段，判断立绘是否有嘴部动作，如果没有嘴部动作，走老的模式
function PopupStoryChat:_checkSpineActionHasMouth(heroRes)
    local heroId    = heroRes
	if heroId == 1 then
		local heroData = Hero.get(G_UserData:getHero():getRoleBaseId())
		if not heroData then
			return false
		end
		heroId = heroData.res_id
    end

    local resInfo   = HeroRes.get(heroId)
    local mouth     = resInfo.mouth_act
    if mouth == 0 then
        return false
    end

    return true
end

-- 播放讲话者嘴巴动作
function PopupStoryChat:_playSpeakerMouthAnimation()
    local talkData = self._touchList[self._idx]
    self._roles[talkData.speaker_position]:playMouthAnimationOnceWithCallback(handler(self,self._talkActionFinish))
end

-- 播放闭嘴动作
function PopupStoryChat:_playSpeakerCloseMouthAnimation()
    local talkData = self._touchList[self._idx]
    self._roles[talkData.speaker_position]:playCloseMouthAnimationForever()
end

function PopupStoryChat:_talkActionFinish()
	self._mouthState    = -1
    logWarn("[ PopupStoryChat:_talkActionFinish ]")
end
-- i18n ja mouth end

-- i18n ja 剧情自动播放 start
function PopupStoryChat:_updateAuto()
	if self._btnAuto == nil then
		self:_loadAuto()
		local btn = ccui.Button:create()
		btn:addClickEventListenerEx(handler(self, self._onAutoClick))
		self._imageJump:getParent():addChild(btn)
		btn:setLocalZOrder(PopupStoryChat.ZORDER_JUMP)
		local posX,posY = self._imageJump:getPosition()
		btn:setPosition(posX-113,posY)
		self._btnAuto = btn
	end
	local img = Path.getStoryChat("img_auto")
	if self:_checkAuto() then
		img = Path.getStoryChat("img_auto2")
	end
	self._btnAuto:loadTextureNormal(img)
end

function PopupStoryChat:_onAutoClick()
	self:_writeAuto()
	self:_updateAuto()
end

function PopupStoryChat:_loadAuto()
    local data = G_StorageManager:load("autostorychat") or {}
	local autoEnabled = checkint(data.autoEnabled or 0)
	self._autoEnabled = autoEnabled
end

function PopupStoryChat:_checkAuto()
	if not Lang.checkUI("ui4") then
		return true
	end
	return self._autoEnabled == 1
end

function PopupStoryChat:_writeAuto()
	if self:_checkAuto() then
		self._autoEnabled = 0
	else
		self._autoEnabled = 1
	end
    local data = G_StorageManager:load("autostorychat") or {}
    data["autoEnabled"] = self._autoEnabled
    G_StorageManager:save("autostorychat", data)
end
-- i18n ja 剧情自动播放 end

-- i18n ja 箭头提示
function PopupStoryChat:_showArrowTip()
	local UIHelper  = require("yoka.utils.UIHelper")
	local arrow = UIHelper.createImage({texture = Path.getStoryChat("img_jiantou") })
	arrow:setPosition(802,25)
	self._panelChat:addChild(arrow)
	local action1 = cc.MoveBy:create(0.2, cc.p(0,5))
	local action2 = action1:reverse()
	local action3 = cc.DelayTime:create(0.2)
	local seq = cc.Sequence:create(action1, action2, action3)
	local rep = cc.RepeatForever:create(seq)
	arrow:runAction(rep)
end


return PopupStoryChat