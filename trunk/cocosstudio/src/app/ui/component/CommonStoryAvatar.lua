--通用武将立绘spine
local CommonStoryAvatar = class("CommonStoryAvatar")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local HeroRes = require("app.config.hero_res")
-- i18n ja mouth
local scheduler = require("cocos.framework.scheduler")

local EXPORTED_METHODS = {
    "updateUI",
    "updateUIByResId",
    "updateChatUI", -- i18n ja mouth
    "playPointAnimationOnceWithCallback",   -- i18n ja mouth
    "playPointDefaultAnimation", -- i18n ja mouth
    "startTalk", -- i18n ja mouth
    "stopTalk", -- i18n ja mouth
    "playAnimationOnce"  -- i18n ja add func
}

-- i18n ja mouth
local SPINE_POINT_DEFAULT_ACTION    = {
    mouth   = "quiet"
    -- mouth   = "talk"
}

function CommonStoryAvatar:ctor()
    self._target = nil
    self._spine = nil
    -- i18n ja mouth
    self._spinePoints   = {}
end


function CommonStoryAvatar:_init()
    self._imageAvatar = ccui.Helper:seekNodeByName(self._target, "ImageAvatar")
	self._nodeAvatar = ccui.Helper:seekNodeByName(self._target, "NodeAvatar")
    self._imageAvatar:setVisible(false)

    -- i18n ja mouth
    self._target:registerScriptHandler(
        function(state)
            if state == "enter" then
                self:_onEnter()
            elseif state == "exit" then
                self:_onExit()
            end
        end
    )
end

function CommonStoryAvatar:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonStoryAvatar:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonStoryAvatar:updateUI(heroId, limitLevel, limitRedLevel, setGray)
    local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroId, nil, nil, limitLevel, limitRedLevel)
    local resData = param.res_cfg
    if resData.story_res_spine ~= 0 then
        self:_createHeroSpine(resData.story_res_spine, setGray)
        self._imageAvatar:setVisible(false)
    else
        self:_createHeroImage(resData.story_res)
        if self._spine then
            self._spine:setVisible(false)
        end
    end
end

function CommonStoryAvatar:_createHeroSpine(spineId, setGray)
    if not self._spine then
        self._spine = require("yoka.node.SpineNode").new(1, cc.size(1024, 1024), setGray)
        self._nodeAvatar:addChild(self._spine)
    end
    self._spine:setAsset(Path.getStorySpine(spineId))
    self._spine:setAnimation("idle", true)
    self._spine:setVisible(true)
end

function CommonStoryAvatar:_createHistorySpine(spineId)
    if not self._spine then
        self._spine = require("yoka.node.SpineNode").new(1, cc.size(1024, 1024))
        self._nodeAvatar:addChild(self._spine)
    end
    self._spine:setAsset(Path.getSpine(spineId))
    self._spine:setAnimation("idle", true)
    self._spine:setVisible(true)
end

function CommonStoryAvatar:_createHeroImage(imageId)
    local imgPath = Path.getChatRoleRes(imageId)
    self._imageAvatar:ignoreContentAdaptWithSize(true)
    self._imageAvatar:loadTexture(imgPath)
    self._imageAvatar:setVisible(true)
end

function CommonStoryAvatar:updateUIByResId(resId)
    local resData = HeroRes.get(resId)
    if resData.story_res_spine ~= 0 then
        self:_createHistorySpine(resData.story_res_spine)
        self._imageAvatar:setVisible(false)
    else
        self:_createHeroImage(resData.story_res)
        if self._spine then
            self._spine:setVisible(false)
        end
    end   
end


-- i18n ja mouth start
function CommonStoryAvatar:_createChatHeroSpine(spineId,callback)
    if not self._spine then
        self._spine = require("yoka.node.SpineNode").new(1, cc.size(1024, 1024))
        self._nodeAvatar:addChild(self._spine)
    end
    self._spine:setAsset(Path.getStorySpine(spineId),callback)
    self._spine:setAnimation("idletalk", true)

    self._spine:setVisible(true)
end

function CommonStoryAvatar:updateChatUI(heroId,limitLevel,limitRedLevel)
    if self._schedulerMouth then
        scheduler.unscheduleGlobal(self._schedulerMouth)
        self._schedulerMouth     = nil
    end
    self._spinePoints = {}

    local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroId, nil, nil, limitLevel, limitRedLevel)
    local resData = param.res_cfg
    self._hasMouth = not (resData.mouth_act == 0)

    if resData.story_res_spine ~= 0 then
        if not self._hasMouth then
            self:_createHeroSpine(resData.story_res_spine)
            self._imageAvatar:setVisible(false)
            return
        end

        local function callback()
            self:_createPointNode("mouth",resData)
        end
        self:_createChatHeroSpine(resData.story_res_spine,callback)
        self._imageAvatar:setVisible(false)
    else
        self:_createHeroImage(resData.story_res)
        if self._spine then
            self._spine:setVisible(false)
        end
    end
end

function CommonStoryAvatar:_createPointNode(pointName,resData)
    -- local resData = HeroRes.get(heroId)
    logWarn("[ CommonStoryAvatar:_createPointNode heroId "..resData.story_res_spine.." pointName "..pointName.." ]")
    -- dump(self._spinePoints[pointName])
    if self._spinePoints[pointName] then
        self._spinePoints[pointName].spinePoint:removeFromParent()
        self._spinePoints[pointName] = nil
    end
    
    -- assert(self._spinePoints[pointName] == nil,"Spine 已经包含了节点 "..pointName.." 不能重复创建")
    
    local parent        = self._spine:getSpinePoint(pointName)

    local assetPath     = resData.story_res_spine.."_"..pointName
    local spinePoint    = require("yoka.node.SpineNode").new(1, cc.size(50, 50))
    spinePoint:setAsset(Path.getStorySpinePointAsset(assetPath))
    spinePoint:setAnimation(SPINE_POINT_DEFAULT_ACTION[pointName],true)
    -- spinePoint:setRotation(90)

    parent:addChild(spinePoint)

    self._spinePoints[pointName]    = {spinePoint = spinePoint,parent = parent}
end

function CommonStoryAvatar:playPointAnimationOnceWithCallback(pointName,action,callback)
    if self._spinePoints[pointName] then
        self._spinePoints[pointName].spinePoint:setAnimation(action, false)

        self._spinePoints[pointName].spinePoint.signalComplet:addOnce(
            function(...)
                self._spinePoints[pointName].spinePoint:setAnimation(SPINE_POINT_DEFAULT_ACTION[pointName], true)

                if callback then
                    callback()
                end
            end
        )
    end
end

function CommonStoryAvatar:playPointDefaultAnimation(pointName)
    if self._spinePoints[pointName] then
        self._spinePoints[pointName].spinePoint:setAnimation(SPINE_POINT_DEFAULT_ACTION[pointName],true)
    end
end

function CommonStoryAvatar:startTalk(sound,playSound)
	self._startTalk = true
    self._pcmTime = 0
    self._soundLength = 0
    -- i18n ja
	local isEnable = G_AudioManager:isSoundEnable()
	if Lang.checkUI("ui4") then
		isEnable = G_AudioManager:isVcEnable()
	end
	if isEnable and sound ~= "" then
        if playSound then
            local mp3 = Path.getSkillVoice(sound)
            if self._nowPlayId then
                G_AudioManager:stopSound(self._nowPlayId)
                self._nowPlayId = nil
            end
            self._nowPlayId = G_AudioManager:playSound(mp3)
        end

        if not self._hasMouth then
	        self._startTalk = false
            return
        end
		-- self._soundLength = math.ceil(StoryChatLength.get(sound).length/1000)
        self:_parsePcmData(sound)
        if self._schedulerMouth == nil then
            self._schedulerMouth = scheduler.scheduleGlobal(handler(self, self._updateMouth), 0.1)
        end
    else
		self._pcmData       = nil
        self._nowPlayId     = nil
	    self._startTalk     = false
	end
end

-- 解析声音文件的pcm
function CommonStoryAvatar:_parsePcmData(sound)
    self._pcmData       = {}
	local SoundTrack    = require("app.config.soundtrack")
    local cfg = SoundTrack.get(sound)
    if cfg == nil then
	    self._startTalk = false
        return
    end
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
    self._soundLength = time/1000

    -- dump(self._pcmData)
    -- print("lkm_soundLength=",self._soundLength)
end

function CommonStoryAvatar:_updateMouth(f)
	if self._startTalk then
		self._pcmTime = self._pcmTime + f
        if self._hasMouth then
            for i, v in ipairs(self._pcmData) do
                if self._pcmTime >= v.from / 1000 and self._pcmTime <= v.to / 1000 then
                    if self._mouthState ~= v.voice then
                        self._mouthState = v.voice
                        if self._mouthState == 1 then
                            self:playPointAnimationOnceWithCallback("mouth","talk",handler(self,self._talkActionFinish))
                        else
                            self:playPointDefaultAnimation("mouth")
                        end
                    end
                end
            end
        end
        
        if self._soundLength ~= 0 and self._pcmTime >= self._soundLength then
            self._startTalk  = false
        end
	end

end

function CommonStoryAvatar:_talkActionFinish()
	self._mouthState    = -1
end

function CommonStoryAvatar:_onEnter()
end

function CommonStoryAvatar:_onExit()
    if self._schedulerMouth then
        scheduler.unscheduleGlobal(self._schedulerMouth)
        self._schedulerMouth     = nil
    end
end

function CommonStoryAvatar:stopTalk()
    self._startTalk  = false
end
-- i18n ja mouth end

-- i18n ja add playAni func （秀将动作）
function CommonStoryAvatar:playAnimationOnce(name)
    do return end  --先写死 挡掉
    self:_playAnim(name, false)
	self._spine.signalComplet:addOnce(
		function(...)
            -- self._spineHero:setAnimation("idle", true)
            self:_playAnim("idle", true)
		end
	)
end

-- i18n ja add func
function CommonStoryAvatar:_playAnim(anim, isLoop, isReset)
    self._spine:setAnimation(anim, isLoop, isReset)
end


return CommonStoryAvatar