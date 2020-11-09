local ViewBase = require("app.ui.ViewBase")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local StoryAvatarNode = class("StoryAvatarNode", ViewBase)
local SchedulerHelper = require("app.utils.SchedulerHelper")

local HeroRes = require("app.config.hero_res")
local Hero = require("app.config.hero")

function StoryAvatarNode:ctor()
    self:enableNodeEvents()
    self:setName("StoryAvatarNode")

    local CSHelper = require("yoka.utils.CSHelper")
    local storyAvatarNode = CSHelper.loadResourceNode(Path.getCSB("CommonStoryAvatar", "common"))
    local size = G_ResolutionManager:getDesignCCSize()
    storyAvatarNode:setPosition(-size.width/8, -size.height/2)
    self:addChild(storyAvatarNode)
    self._storyAvatarNode = storyAvatarNode

    local panel = ccui.Layout:create()
    panel:setContentSize(cc.size(350,500))
    -- panel:setBackGroundColorType(1)
    -- panel:setBackGroundColor(cc.c3b(255,0,0))
    panel:setAnchorPoint(0.5,0)
    panel:setTouchEnabled(true)
    panel:addClickEventListenerEx(handler(self, self._onClickAvatar))
    storyAvatarNode:addChild(panel)

    self:updateUI()

end

function StoryAvatarNode:updateUI(data)
    if data == nil then
        local id = G_UserData:getBase():getKan_ban_niang()
        -- data = G_UserData:getHero():getUnitDataWithId(id)
        data = G_UserData:getHandBook():getMainAvatarDataById(id)
    end
    if data == nil then
        local heroInfo = require("app.config.hero")
        local baseId = G_UserData:getHero():getRoleBaseId()
		local config = heroInfo.get(baseId)
        data = {
			baseId = baseId,
			limitLevel = 0,
			limitRedLevel = 0,
			resId = config.res_id
        }
    end
    self._data = data
    -- local heroBaseId, isEquipAvatar, avatarLimitLevel, arLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(data)
    -- local limitLevel = avatarLimitLevel or data:getLimit_level()
    -- local limitRedLevel = arLimitLevel or data:getLimit_rtg()
    local heroBaseId = data.baseId
    local limitLevel = data.limitLevel
    local limitRedLevel = data.limitRedLevel
    -- self._storyAvatarNode:updateUI(heroBaseId, limitLevel, limitRedLevel)
    self._storyAvatarNode:updateChatUI(heroBaseId, limitLevel, limitRedLevel)

    -- self._storyAvatarNode:setScale(0.8)

end

function StoryAvatarNode:playTalk()
    if not G_TutorialManager:isDoingStep() then
        G_HeroVoiceManager:stopPlayMainMenuVoice()
        if self._data and self._data.resId then
            G_HeroVoiceManager:startPlayMainMenuVoice2(self._data.resId,self._storyAvatarNode)
        end
    end
end

function StoryAvatarNode:moveAction(toLeft)
    if self._lastAction then
        self._storyAvatarNode:stopAction(self._lastAction)
        self._lastAction = nil
    end
    local width = G_ResolutionManager:getDesignCCSize().width

    local posY = self._storyAvatarNode:getPositionY()
    local tgtPosX = 0
    if toLeft then
        tgtPosX = -width/8
    end
    local moveAction = cc.MoveTo:create(0.2, cc.p(tgtPosX, posY))
    self._storyAvatarNode:runAction(moveAction)
    self._lastAction = moveAction
end

function StoryAvatarNode:onEnter()
	-- self._signalMainAvatarTalk =
	-- 	G_SignalManager:add(SignalConst.EVENT_MAIN_AVATAR_TALK, handler(self, self._onSignalMainAvatarTalk))

    G_HeroVoiceManager:setIsInMainMenu(true)
    if not G_TutorialManager:isDoingStep() then
        if self._playVoiceScheduler then
            SchedulerHelper.cancelSchedule(self._playVoiceScheduler)
            self._playVoiceScheduler = nil
        end
		self._playVoiceScheduler = SchedulerHelper.newScheduleOnce(function()
            if self._data and self._data.resId then
                G_HeroVoiceManager:stopPlayMainMenuVoice()
                G_HeroVoiceManager:startPlayMainMenuVoice2(self._data.resId,self._storyAvatarNode)
            end
    	end, 1)
    end
end

function StoryAvatarNode:onExit()
	-- self._signalMainAvatarTalk:remove()
	-- self._signalMainAvatarTalk = nil

    G_HeroVoiceManager:setIsInMainMenu(false)
    if not G_TutorialManager:isDoingStep() then
        G_HeroVoiceManager:stopPlayMainMenuVoice()
        G_HeroVoiceManager:stopCurrentVoice()
    end
end

-- function StoryAvatarNode:_onSignalMainAvatarTalk(_, param)
--     self._storyAvatarNode:startTalk(param)
-- end

function StoryAvatarNode:_onClickAvatar()
	self:playTalk()
end


return StoryAvatarNode