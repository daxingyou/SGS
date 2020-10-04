--通用武将立绘spine
local scheduler = require("cocos.framework.scheduler")
local CommonStoryAvatar = require("app.ui.component.CommonStoryAvatar")
local CommonPosterGirlAvatar = class("CommonPosterGirlAvatar",CommonStoryAvatar)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local HeroRes = require("app.config.hero_res")

local EXPORTED_METHODS = {
    "setAvatarScale"
}

-- i18n ja mouth
local SPINE_POINT_DEFAULT_ACTION    = {
    mouth   = "quiet"
    -- mouth   = "talk"
}

function CommonPosterGirlAvatar:ctor()
    CommonPosterGirlAvatar.super.ctor(self)
end


function CommonPosterGirlAvatar:_init()
    CommonPosterGirlAvatar.super._init(self)
end

function CommonPosterGirlAvatar:bind(target)
    CommonPosterGirlAvatar.super.bind(self, target)
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonPosterGirlAvatar:unbind(target)
    CommonHeroIcon.super.unbind(self, target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonPosterGirlAvatar:updateUI(skinId)
    local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_POSTER_GIRL_SKIN,skinId )
    --local resData = param.res_cfg
   -- if resData.story_res_spine ~= 0 then
        self:_createHeroSpine("123")
        self._imageAvatar:setVisible(false)
    --end
end

function CommonPosterGirlAvatar:_createHeroSpine(spineId)
    if not self._spine then
        self._spine = require("yoka.node.SpineNode").new(1, cc.size(1024, 1024))
        self._nodeAvatar:addChild(self._spine)
    end
    self._spine:setAsset(Path.getSkinSpine(spineId))
    self._spine:setAnimation("idle", true)
    self._spine:setVisible(true)
end

function CommonPosterGirlAvatar:setAvatarScale(scale)
    -- body
    self._nodeAvatar:setScale(scale)
end

function CommonPosterGirlAvatar:updateChatUI(skinId)
    local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_POSTER_GIRL_SKIN,skinId )
    if self._schedulerMouth then
        scheduler.unscheduleGlobal(self._schedulerMouth)
        self._schedulerMouth     = nil
    end
    self._spinePoints = {}
    self._hasMouth = true

    local resData = { story_res_spine = "123" }
    
    if not self._hasMouth then
        self:_createHeroSpine(resData.story_res_spine)
        self._imageAvatar:setVisible(false)
        return
    end

    local function callback()
        self:_createPointNode("mouth",skinId)
    end
    self:_createChatHeroSpine(resData.story_res_spine,callback)
    self._imageAvatar:setVisible(false)
    
end

function CommonPosterGirlAvatar:startTalk(sound,playSound)
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
            local mp3 = Path.getPosterGirlVoice(sound)
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


-- i18n ja mouth start
function CommonPosterGirlAvatar:_createChatHeroSpine(spineId,callback)
    if not self._spine then
        self._spine = require("yoka.node.SpineNode").new(1, cc.size(1024, 1024))
        self._nodeAvatar:addChild(self._spine)
    end
    self._spine:setAsset(Path.getSkinSpine(spineId),callback)
    self._spine:setAnimation("idletalk", true)

    self._spine:setVisible(true)
end

function CommonPosterGirlAvatar:_createPointNode(pointName,skinId)
   
    local resData = { story_res_spine = "123" }
    dump(self._spinePoints[pointName])
    
    assert(self._spinePoints[pointName] == nil,"Spine 已经包含了节点 "..pointName.." 不能重复创建")
    
    local parent        = self._spine:getSpinePoint(pointName)

    local assetPath     = resData.story_res_spine.."_"..pointName
    local spinePoint    = require("yoka.node.SpineNode").new(1, cc.size(50, 50))
    spinePoint:setAsset(Path.getSkinSpinePointAsset(assetPath))
    spinePoint:setAnimation(SPINE_POINT_DEFAULT_ACTION[pointName],true)
    -- spinePoint:setRotation(90)

    parent:addChild(spinePoint)

    self._spinePoints[pointName]    = {spinePoint = spinePoint,parent = parent}
end

function CommonPosterGirlAvatar:playAnimationOnce(name)
 
    self:_playAnim(name, false)
	self._spine.signalComplet:addOnce(
		function(...)
            -- self._spineHero:setAnimation("idle", true)
            self:_playAnim("idletalk", true)
		end
	)
end

-- i18n ja add func
function CommonPosterGirlAvatar:_playAnim(anim, isLoop, isReset)
    self._spine:setAnimation(anim, isLoop, isReset)
end

return CommonPosterGirlAvatar