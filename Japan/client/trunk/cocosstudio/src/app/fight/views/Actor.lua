local Actor =
    class(
    "Actor",
    function()
        return cc.Node:create()
    end
)

local FightConfig = require("app.fight.Config")
local Path = require("app.utils.Path")

local EffectActor = require("app.fight.views.EffectActor")

-- Actor.BUFF_POS_HEAD = 1
-- Actor.BUFF_POS_MIDDLE = 2
-- Actor.BUFF_POS_FOOT = 3

local BuffShow = {
    buffEffect = nil,
    buffColor = nil
}

function Actor:ctor(name, loadOverFunc, camp)
    self:setCascadeOpacityEnabled(true)
    self:setCascadeColorEnabled(true)
    -- root
    self._root = cc.Node:create()
    self._root:setCascadeOpacityEnabled(true)
    self._root:setCascadeColorEnabled(true)
    self:addChild(self._root)
    -- back
    self._backLayer = cc.Node:create()
    self._backLayer:setCascadeOpacityEnabled(true)
    self._backLayer:setCascadeColorEnabled(true)
    self._root:addChild(self._backLayer)

    -- body
    self._bodyLayer = cc.Node:create()
    self._bodyLayer:setCascadeOpacityEnabled(true)
    self._bodyLayer:setCascadeColorEnabled(true)
    self._root:addChild(self._bodyLayer)

    self._labelCount = {}

    self._camp = camp
    self._moving = nil

    -- action
    local spine = require("yoka.node.HeroSpineNode").new()
    spine:setScale(FightConfig.SCALE_ACTOR)
    spine.signalLoad:add(
        function(...)
            loadOverFunc()
        end
    )
    self._animation = require("app.fight.views.Animation").new(spine)
    self._bodyLayer:addChild(self._animation, 2)
    self._animation:setAsset(Path.getSpine(name))

    self._name = name

    if G_SpineManager:isSpineExist(Path.getSpine(name .. "_back_effect")) then
        local spineEffect = require("yoka.node.HeroSpineNode").new()
        spineEffect:setScale(FightConfig.SCALE_ACTOR)
        self._animationEffectBack = require("app.fight.views.Animation").new(spineEffect)
        self._bodyLayer:addChild(self._animationEffectBack, 1)
        self._animationEffectBack:setAsset(Path.getSpine(name .. "_back_effect"))
    end

    if G_SpineManager:isSpineExist(Path.getSpine(name .. "_fore_effect")) then
        local spineEffect = require("yoka.node.HeroSpineNode").new()
        spineEffect:setScale(FightConfig.SCALE_ACTOR)
        self._animationEffectFore = require("app.fight.views.Animation").new(spineEffect)
        self._bodyLayer:addChild(self._animationEffectFore, 3)
        self._animationEffectFore:setAsset(Path.getSpine(name .. "_fore_effect"))
    end

    --info
    self._infoRoot = cc.Node:create()
    self._infoRoot:setCascadeOpacityEnabled(true)
    self._infoRoot:setCascadeColorEnabled(true)
    self:addChild(self._infoRoot)

    --bufflayer
    self._buffLayer = cc.Node:create()
    self._buffLayer:setCascadeOpacityEnabled(true)
    self._buffLayer:setCascadeColorEnabled(true)
    self._infoRoot:addChild(self._buffLayer)

    -- self._labelCount = cc.Label:createWithTTF("x2", Path.getCommonFont(), 20)
    -- self._buffLayer:addChild(self._labelCount, 1)
    -- self._labelCount:setVisible(false)

    -- front
    self._frontLayer = cc.Node:create()
    self._frontLayer:setCascadeOpacityEnabled(true)
    self._frontLayer:setCascadeColorEnabled(true)
    self._root:addChild(self._frontLayer)

    self._buffEffect = {}
    self._chatBubble = nil
    self._chatText = nil
    self._talkIcon = nil

    self._effectIdle2 = nil
    self._nowColor = ""

    -- self._nowBuffID = 0
    -- self._effect = nil

    --战斗展示特效
    -- self._showEffect = nil
    -- self._skillImage = nil
end

--
function Actor:setAction(name, loop)
    self._animation:setAnimation(name, loop, true)

    if
        string.find(name, "skill") == 1 or string.find(name, "win") or string.find(name, "open") or
            string.find(name, "coming")
     then
        if self._animationEffectFore and self._animationEffectFore:isAnimationExist(name) then
            self._animationEffectFore:setAnimation(name, loop, true)
        end
        if self._animationEffectBack and self._animationEffectBack:isAnimationExist(name) then
            self._animationEffectBack:setAnimation(name, loop, true)
        end
    else
        if self._animationEffectFore then
            self._animationEffectFore:resetSkeletonPose()
        end
        if self._animationEffectBack then
            self._animationEffectBack:resetSkeletonPose()
        end
    end
end

function Actor:stopEffect()
    if self._animationEffectFore then
        self._animationEffectFore:resetSkeletonPose()
    end
    if self._animationEffectBack then
        self._animationEffectBack:resetSkeletonPose()
    end
end

function Actor:showIdle2Effect(isShow)
    if self._effectIdle2 then
        self._effectIdle2:death()
        self._effectIdle2 = nil
    end
    if isShow then
        self._effectIdle2 = EffectActor.new("idle2_effect")
        self._buffLayer:addChild(self._effectIdle2)
        self._effectIdle2:setAction("effect", true)
    end
end

-- function Actor:showOnce

--
function Actor:setTowards(towards)
    self._towards = towards == FightConfig.campLeft and 1 or -1
    self._root:setScaleX(self._towards)
    -- self._labelCount:setPosition(cc.p(self._towards*75, 200))
end

--
function Actor:death()
    local action1 = cc.FadeOut:create(0.2)
    local action2 = cc.RemoveSelf:create()
    local action = cc.Sequence:create(action1, action2)
    self:runAction(action)
end

--
function Actor:updateHP(value, max)
    --self._hpBarView:setValue(value, max)
end

--直接放出来的，不会替换的特效，例如加减怒
function Actor:doOnceBuff(res, pos)
    local effect = EffectActor.new(res)
    self._buffLayer:addChild(effect)
    effect:setScale(2.5)
    effect:setOnceAction("effect")
end

--播放一次性的特效
function Actor:doOnceEffect(res)
    local effect = EffectActor.new(res)
    effect:setScale(2)
    effect:setScaleX(self._camp * 2)
    self._buffLayer:addChild(effect)
    effect:setPositionY(0)
    effect:setOnceAction("effect")
end

function Actor:removeBuff(pos)
    if self._buffEffect[pos] then
        local effect = self._buffEffect[pos].buffEffect
        effect:death()
        effect = nil
        local color = self._buffEffect[pos].buffColor
        if color then
            local ShaderHalper = require("app.utils.ShaderHelper")
            ShaderHalper.filterNode(self._animation, "", true)
            self._nowColor = ""
        end
        -- if pos == FightConfig.BUFF_POS_HEAD then
        -- 	self._labelCount:setVisible(false)
        -- end
        if self._labelCount[pos] then
            self._labelCount[pos]:removeFromParent()
            self._labelCount[pos] = null
        end
        self._buffEffect[pos] = nil
    end
end

function Actor:setColorVisible(s)
    if self._nowColor == "" then
        return
    end
    if s then
        if self._nowColor ~= "" then
            local ShaderHalper = require("app.utils.ShaderHelper")
            ShaderHalper.filterNode(self._animation, self._nowColor)
        else
            local ShaderHalper = require("app.utils.ShaderHelper")
            ShaderHalper.filterNode(self._animation, "", true)
        end
    else
        local ShaderHalper = require("app.utils.ShaderHelper")
        ShaderHalper.filterNode(self._animation, "", true)
    end
end

function Actor:showBuff(res, pos, color, action)
    if self._buffEffect[pos] then
        self:removeBuff(pos)
    end
    local effect = EffectActor.new(res)
    self._buffLayer:addChild(effect)
    effect:setAction("effect", true)
    effect:setScale(2)
    effect:setScaleX(self._camp * 2)

    local eftColor = nil
    if color ~= "" then
        local ShaderHalper = require("app.utils.ShaderHelper")
        ShaderHalper.filterNode(self._animation, color)
        eftColor = color
    end
    local show = clone(BuffShow)
    show.buffEffect = effect
    show.buffColor = eftColor
    self._buffEffect[pos] = show
    if action ~= "" then
        self:setAction(action, true)
    end
    self._nowColor = color
end

function Actor:showBuffCount(count, colorType, pos)
    if count <= 1 then
        if self._labelCount[pos] then
            self._labelCount[pos]:removeFromParent()
            self._labelCount[pos] = nil
        end
        return
    end
    if not self._labelCount[pos] then
        self._labelCount[pos] = cc.Label:createWithTTF("x2", Path.getCommonFont(), 20)
        self._buffLayer:addChild(self._labelCount[pos], 1)
        self._labelCount[pos]:setPosition(cc.p(self._camp * 80, 195))
    end

    self._labelCount[pos]:setString("x" .. count)
    local buffColor = Colors.getBuffCountColor(colorType)
    self._labelCount[pos]:setColor(buffColor.color)
    self._labelCount[pos]:enableOutline(buffColor.outline, 2)
end

--检查动作
function Actor:isAnimationExist(name)
    return self._animation:isAnimationExist(name)
end

--播放带完成回掉的动作
function Actor:setActionWithCallback(name, callback)
    self._animation:setAnimationWithCallback(name, false, callback)
end

--技能展示
-- i18n change skill
function Actor:showSkill(imageId,name)
	local EffectGfxNode = require("app.effect.EffectGfxNode")
	local function effectFunction(effect)
		if effect == "effect_tiaozi_ditu" then
			local subEffect = EffectGfxNode.new("effect_tiaozi_ditu")
			subEffect:play()
			return subEffect
		elseif effect == "tiaozi_wenzi" then
			-- local image = Path.getSkillShow(imageId)
			-- local sprite = display.newSprite(image)
			-- return sprite   
			-- i18n change skill   
			if not Lang.checkLang(Lang.CN) then
				local UIHelper = require("yoka.utils.UIHelper")
				local TypeConst = require("app.i18n.utils.TypeConst")
				local subLabel = UIHelper.createLabel({text=name,style="skill",styleType=TypeConst.TEXT})
                if Lang.checkUI("ui4") then
                    subLabel = UIHelper.createLabel({text=name,style="skill_ui4",styleType=TypeConst.TEXT})
                end
				if Lang.checkLatinLanguage() then
					local node =  cc.Node:create()
					subLabel:setPositionY(5)
					node:addChild(subLabel)
					return node
				end	
				return subLabel
			else
				local image = Path.getSkillShow(imageId)
				local sprite = display.newSprite(image)
				return sprite  
			end
		end
	end
    local effect =
        G_EffectGfxMgr:createPlayMovingGfx(self._frontLayer, "moving_tiaozi_jineng", effectFunction, nil, true)
    effect:setPositionY(175)
    if self._towards == -1 then
        effect:setScaleX(self._towards)
    end
end

--说话
function Actor:talk(face, content)
    if not self._chatBubble then
        if Lang.checkUI("ui4") then
            self:_createChatBubble2()
        else
            self:_createChatBubble()
        end
    end
    self._chatBubble:setVisible(true)
    -- G_EffectGfxMgr:applySingleGfx(self._chatBubble, "smoving_duihuakuang")
    self._chatBubble:setScale(self._towards * 0.46, 0.46)
    local action1 = cc.ScaleTo:create(7 / 30, self._towards * 1.05, 1.05)
    local action2 = cc.ScaleTo:create(1 / 10, self._towards * 1, 1)
    local action = cc.Sequence:create(action1, action2)
    self._chatBubble:runAction(action)

    self._chatText:setString(content)
    if Lang.checkUI("ui4") then
        self:_updateChatBubble()
    end

    if self._talkIcon then
        self._talkIcon:removeFromParent()
        self._talkIcon = nil
    end
    if face ~= 0 then
        self._talkIcon = display.newSprite(Path.getChatFaceRes(face))
        self._chatBubble:addChild(self._talkIcon)
        self._talkIcon:setPosition(cc.p(25, 100))
        if self._towards == -1 then
            self._talkIcon:setPositionX(225)
        end
    end
end

--停止说话
function Actor:stopTalk()
    if self._chatBubble then
        self._chatBubble:setVisible(false)
    end
end

--创建说话泡泡
function Actor:_createChatBubble()
    self._chatBubble = display.newSprite(Path.getChatFormRes("03"))
    self._chatBubble:setAnchorPoint(cc.p(0, 0))
    local parentNode = self:getParent()
    parentNode:addChild(self._chatBubble, FightConfig.UNIT_TALK_Z_ORDER)
    local positionX, positionY = self:getPosition()
    self._chatBubble:setPosition(cc.p(positionX + 30, positionY + 60))
    self._chatBubble:setScaleX(self._towards)

    self._chatText = cc.Label:createWithTTF("", Path.getCommonFont(), 20)
    self._chatText:setAnchorPoint(cc.p(0, 0.5))
    self._chatText:setPosition(cc.p(40, 48))
    self._chatText:setColor(Colors.getTypeAColor())
    self._chatBubble:addChild(self._chatText)
    if self._towards == -1 then
        self._chatText:setScaleX(-1)
    end

    if self._towards == -1 then
        self._chatText:setPositionX(225)
        self._chatBubble:setPositionX(positionX - 30)
    end

    self._chatText:setMaxLineWidth(195)

    -- labelName:setPosition(cc.p(0, 22))

	-- i18n pos lable
	if Lang.checkSquareLanguage() then
		
	elseif not Lang.checkLang(Lang.CN)  then
		self._chatText:setLineSpacing(-4 )
		local size = self._chatBubble:getContentSize()
		self._chatText:setPositionY(self._chatText:getPositionY()+15)
		self._chatBubble:setContentSize(cc.size(size.width,size.height+30))
	end
    -- labelName:setPosition(cc.p(0, 22))
	
end
--隐藏，显示bufflayer
function Actor:showBuffLayer(s)
    self._buffLayer:setVisible(s)
end

--播放合击duang
function Actor:playCombineDuang(callback)
    local function effectFunc(event)
        if event == "finish" then
            if callback then
                callback()
            end
        end
    end
	-- i18n change effect
	local function effectFunction(effect)
		if  not Lang.checkLang(Lang.CN) and effect == "routine_word_heji_zi" then
			local TypeConst = require("app.i18n.utils.TypeConst")
			local UIHelper = require("yoka.utils.UIHelper")
			local subLabel = UIHelper.createLabel({text=Lang.getEffectText("effect_heji"),style="effect_text_34",styleType=TypeConst.EFFECT})
			return subLabel
		end	
	end	
	-- i18n change effect
	local effect = G_EffectGfxMgr:createPlayMovingGfx( self._frontLayer, "moving_hejitiaozi_duang", effectFunction, nil, true )
    effect:setPositionY(175)
    if self._towards == -1 then
        effect:setScaleX(self._towards)
    end
end

--渐隐渐出
function Actor:playFade(isIn, istransparent)
    if isIn then
        if self._chatBubble then
            self._chatBubble:setVisible(false)
        end
        if istransparent then
            self:setOpacity(100)
            return
        end
        local action = cc.FadeIn:create(0.5)
        self:runAction(action)
    else
        local action = cc.FadeOut:create(0.5)
        self:runAction(action)
    end
end

--播放指定特效
function Actor:playEffect(spine, action)
    local effect = EffectActor.new(spine)
    self._buffLayer:addChild(effect)
    effect:setAction(action)
end

--播放smoving
function Actor:doMoving(moving)
    if not self._moving then
        self._moving = G_EffectGfxMgr:applySingleGfx(self._root, moving)
    end
end

function Actor:stopMoving()
    if self._moving then
        self._moving:stop()
        self._root:setPosition(cc.p(0, 0))
    end
    self._moving = nil
end

function Actor:playHistoryShowAnim(hisHeroId, skillId, stageId)
    local CSHelper = require("yoka.utils.CSHelper")
    local HistoricalHero = require("app.config.historical_hero")
    local HeroSkillPlay = require("app.config.hero_skill_play")
    local FightSignalConst = require("app.fight.FightSignalConst")
    local FightSignalManager = require("app.fight.FightSignalManager")
    local HeroRes = require("app.config.hero_res")

    local fightSignalManager = FightSignalManager.getFightSignalManager()
    local heroData = HistoricalHero.get(hisHeroId)
    assert(heroData, "wrong history hero id " .. hisHeroId)
    local heroResData = HeroRes.get(heroData.res_id)
    assert(heroResData, "wrong history hero res id " .. heroData.res_id)
    -- local anim = FightConfig.getHistoryAnimShow(heroData.color, hisCamp)
    local anim = FightConfig.getHistoryAnimShow(heroData.color)
    -- local node = self["_nodeSkill" .. hisCamp]
    local function effectFunction(effect)
        if effect == "weizi" then
            local skillShow = HeroSkillPlay.get(skillId)
            assert(skillShow, "wrong skill show id = " .. skillId)
            local image = Path.getSkillShow(skillShow.txt)
            local sprite = display.newSprite(image)
            return sprite
        elseif effect == "lihui" then
            local avatar = CSHelper.loadResourceNode(Path.getCSB("CommonStoryAvatar", "common"))
            local resId = heroData.res_id
            avatar:updateUIByResId(resId)
            return avatar
        elseif effect == "texiao" then
            local spineNode = require("yoka.node.SpineNode").new(1)
            spineNode:setAsset(Path.getFightEffectSpine(heroResData.hero_show_effect))
            spineNode:setAnimation("effect")
            return spineNode
        end
    end
    local function eventFunction(event)
        if event == "skill" then
            fightSignalManager:dispatchSignal(FightSignalConst.SIGNAL_HISTORY_BUFF, stageId)
        elseif event == "finish" then
            fightSignalManager:dispatchSignal(FightSignalConst.SIGNAL_HISTORY_SHOW_END, stageId)
        end
    end
    G_EffectGfxMgr:createPlayMovingGfx(self._frontLayer, anim, effectFunction, eventFunction, true)
    if heroData.color == 5 then --橙色历代名家，播音效
        local voiceRes = Path.getHeroVoice(heroResData.voice)
        G_AudioManager:playSound(voiceRes)
    end
end

--i18n ja 创建说话泡泡
function Actor:_createChatBubble2()
    local UIHelper  = require("yoka.utils.UIHelper")
	local bg = UIHelper.createImage({texture = Path.getChatFormRes("04") })
	bg:setScale9Enabled(true)
    bg:setCapInsets(cc.rect(126,38,1,1))
    local size = cc.size(241,73)
	bg:setContentSize(size)
    bg:setAnchorPoint(0,0)
    self._chatBubble = bg

    local parentNode = self:getParent()
    parentNode:addChild(self._chatBubble, FightConfig.UNIT_TALK_Z_ORDER)
    local positionX, positionY = self:getPosition()
    self._chatBubble:setPosition(cc.p(positionX - 20, positionY + 110))
    self._chatBubble:setScaleX(self._towards)

    self._chatText = cc.Label:createWithTTF("", Path.getCommonFont(), 20)
    self._chatText:setAnchorPoint(cc.p(0.5, 0.5))
    self._chatText:setPosition(cc.p(size.width/2, size.height/2))
    self._chatText:setColor(Colors.getTypeAColor())
    self._chatBubble:addChild(self._chatText)
    if self._towards == -1 then
        self._chatText:setScaleX(-1)
    end

    if self._towards == -1 then
        self._chatBubble:setPositionX(positionX + 20)
    end

    self._chatText:setWidth(195)
end
--i18n ja 自适应说话泡泡
function Actor:_updateChatBubble()
    local size = self._chatBubble:getContentSize()
    size.height = self._chatText:getContentSize().height + 54
    self._chatBubble:setContentSize(size)
    self._chatText:setPosition(cc.p(size.width/2, size.height/2+2))
end


return Actor
