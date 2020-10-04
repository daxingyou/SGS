local PopupBase = require("app.ui.PopupBase")
local HeroShow = class("HeroShow", PopupBase)

local CSHelper  = require("yoka.utils.CSHelper")
local Hero = require("app.config.hero")
local HeroRes = require("app.config.hero_res")
local Instrument = require("app.config.instrument")
local UIHelper = require("yoka.utils.UIHelper")

local Path = require("app.utils.Path")
local Color = require("app.utils.Color")
local SchedulerHelper = require ("app.utils.SchedulerHelper")

HeroShow.AUTO_CLOSE_TIME = 10

HeroShow.HERO_COLOR_BACK = 
{
    "",
    "",
    "",
    "show_purple",
    "show_yellow1",
    "show_red",
    "show_gold",
}

HeroShow.SHENBING_BACK = 
{
    "",
    "",
    "",
    "show_purple2",
    "show_yellow2",    
    "show_red2",
    "show_gold2",
}

HeroShow.DES_BG1 = 
{
    "",
    "",
    "",
    "show_purple3",
    "show_yellow3",    
    "show_red3",
    "show_red3",
}

HeroShow.DES_BG2 = 
{
    "",
    "",
    "",
    "show_purple4",
    "show_yellow4",    
    "show_red4",
    "show_red4",
}

function HeroShow.create(heroId, callback, needAutoClose, isRight)
	-- assert(spriteFrames and num, "spriteFrames and num could not be nil !")
	local heroShow = HeroShow.new(heroId, callback, needAutoClose, isRight)
    heroShow:open()
end

--普通副本结算
function HeroShow:ctor(heroId, callback, needAutoClose, isRight)
    local hero = Hero.get(heroId)
    assert(hero, "hero id is wrong "..heroId)
    self._hero = hero
    self._heroRes = HeroRes.get(hero.res_id)
    self._instrument = Instrument.get(hero.instrument_id)
    self._panelFinish = nil
    self._isAction = true
    self._effectShow = nil
    self._callback = callback
    self._needAutoClose = needAutoClose
    self._scheduleHandler = nil
    self._autoTime = 0
    self._isRight = isRight
    HeroShow.super.ctor(self, nil, false, false)
end

function HeroShow:onCreate()
end

function HeroShow:onEnter()
    self:play()
end

function HeroShow:onExit()
    if self._scheduleHandler then
        SchedulerHelper.cancelSchedule(self._scheduleHandler)
    end
    self._scheduleHandler = nil
end

function HeroShow:_onFinishTouch(sender, event)
    if not self._isAction and event == 2 then
        if self._callback then
            self._callback()
        end
        self:close()
    end
end

function HeroShow:play()
    self._isAction = true
    local params = {
        name = index,
        contentSize = G_ResolutionManager:getDesignCCSize(),
        anchorPoint = cc.p(0.5, 0.5),
        position = cc.p(0, 0)
    }
    self._panelFinish = UIHelper.createPanel(params)
    self._panelFinish:setTouchEnabled(true)
    self._panelFinish:setSwallowTouches(true)
    self._panelFinish:addTouchEventListener(handler(self,self._onFinishTouch))
    self:addChild(self._panelFinish)
    self._isAction = true
    self._effectShow = nil
    self:_createAnimation()

    --onEnter
    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_BEGIN)
end

function HeroShow:_createActionNode(effect)
    local funcName = "_"..effect
	if funcName then
		local func = self[funcName]
		assert(func, "has not func name = "..funcName)
		local node = func(self)
        return node
	end
end

--node绑定-----------------------------------------------------------------------
function HeroShow:_xiujiang_zi_shenbing_wuqiu()
    local image = Path.getInstrument(self._instrument.res)
    local sprite = display.newSprite(image)
    return sprite    
end

function HeroShow:_xiujiang_zi_shenbing_o()
    local image = Path.getShowHero(HeroShow.SHENBING_BACK[self._hero.color])
    local sprite = display.newSprite(image)
    return sprite
end

function HeroShow:_xiujiang_zi_dingwei()
    local content = Lang.get("hero_show_position")..self._hero.feature
    local label = nil
     if not Lang.checkLang(Lang.CN) then
		 label = cc.Label:createWithTTF(content, Path.getCommonFont(), 32-8)
    else
         label = cc.Label:createWithTTF(content, Path.getCommonFont(), 32)
	end
    local color, outline = Color.getHeroYellowShowColor()
    label:setColor(color)
    label:enableOutline(outline, 2) 
    label:setAnchorPoint(cc.p(0, 0.5))
    return label
end

function HeroShow:_xiujiang_zi_dingwei_txt()
    local content = self._hero.skill_name..self._hero.skill_description
    local label = cc.Label:createWithTTF(content, Path.getCommonFont(), 20)
	label:setMaxLineWidth(370)
    label:setAnchorPoint(cc.p(0, 0.5))
    if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
        label:setMaxLineWidth(470)
        local node = cc.Node:create()
        node:addChild(label)
        if self._isRight then
            label:setPositionX(294)
            label:setAnchorPoint(cc.p(1, 0.5))
        end
        return node
    end
    return label
end

function HeroShow:_xiujiang_zi_dingwei_di()
    local image = Path.getShowHero(HeroShow.DES_BG1[self._hero.color])
    local sprite = display.newSprite(image)
    return sprite
end

function HeroShow:_xiujiang_zi_shenbing()
    local content = Lang.get("hero_show_instrument")..self._instrument.name
    local label = nil
    if not Lang.checkLang(Lang.CN) then
		 label = cc.Label:createWithTTF(content, Path.getCommonFont(), 32-8)
    else
         label= cc.Label:createWithTTF(content, Path.getCommonFont(), 32)     
	end

    local color, outline = Color.getHeroYellowShowColor()
    label:setColor(color)
    label:enableOutline(outline, 2) 
    label:setAnchorPoint(cc.p(0, 0.5))
    return label
end

function HeroShow:_xiujiang_zi_shenbing_txt()
    local content = self._hero.instrument_description
    local label = cc.Label:createWithTTF(content, Path.getCommonFont(), 20)
    label:setMaxLineWidth(370)
    label:setAnchorPoint(cc.p(0, 0.5))
    if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
        label:setMaxLineWidth(470)
        local node = cc.Node:create()
        node:addChild(label)
        if  self._isRight then
            label:setPositionX(297)
            label:setAnchorPoint(cc.p(1, 0.5))
        end
        return node
    end
    return label
end

function HeroShow:_xiujiang_zi_shenbing_di()
    local image = Path.getShowHero(HeroShow.DES_BG2[self._hero.color])
    local sprite = display.newSprite(image)
    return sprite
end

function HeroShow:_xiujiang_zi_1()
    local content = Lang.get("hero_show_story_title")
    local label = cc.Label:createWithTTF(content, Path.getCommonFont(), 20)
	label:setMaxLineWidth(25)
    if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        UIHelper.dealVTextWidget(label,content)
        label:setMaxLineWidth(125)
    end
    label:setAnchorPoint(cc.p(0.5, 1))

    if not Lang.checkLang(Lang.CN) then
		return cc.Node:create()
	end


    return label
end

function HeroShow:_xiujiang_zi_2()
    local content = self._hero.description1
    local label = cc.Label:createWithTTF(content, Path.getCommonFont(), 20)
	label:setMaxLineWidth(25)
    if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        UIHelper.dealVTextWidget(label,content)
        label:setMaxLineWidth(125)
    end
    label:setAnchorPoint(cc.p(0.5, 1))


     if not Lang.checkLang(Lang.CN) then
		return cc.Node:create()
	end

    return label
end

function HeroShow:_xiujiang_zi_3()
    local content = self._hero.description2
    local label = cc.Label:createWithTTF(content, Path.getCommonFont(), 20)
	label:setMaxLineWidth(25)
    if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        UIHelper.dealVTextWidget(label,content)
        label:setMaxLineWidth(125)
    end
    label:setAnchorPoint(cc.p(0.5, 1))

    if not Lang.checkLang(Lang.CN) then
		return cc.Node:create()
	end

    return label
end

function HeroShow:_xiujiang_country()
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, self._hero.id)
    local sprite = display.newSprite(param.country_text)
    return sprite
end

function HeroShow:_xiujiang_mingzi()
    local image = self._heroRes.show_name
    local sprite = display.newSprite(Path.getShowHeroName(image))
    return sprite
end

function HeroShow:_xiujiang_role()
    -- local image = self._heroRes.story_res
    -- local sprite = display.newSprite(Path.getChatRoleRes(image))
    -- return sprite
    local CSHelper  = require("yoka.utils.CSHelper")
    local heroAvatar = CSHelper.loadResourceNode(Path.getCSB("CommonStoryAvatar", "common"))
    heroAvatar:updateUI(self._hero.id)
    G_HeroVoiceManager:playVoiceWithHeroId(self._hero.id, true)
    return heroAvatar
end

function HeroShow:_xiujiang_colour_di()
    local image = Path.getShowHero(HeroShow.HERO_COLOR_BACK[self._hero.color])
    local sprite = display.newSprite(image)
    return sprite
end

---------------------------------------------------------------------------------------

function HeroShow:_createAnimation()
    local EffectGfxNode = require("app.effect.EffectGfxNode")
    local function effectFunction(effect)
        if effect == "effect_xiujiang_heidi" then
            local subEffect = cc.Node:create()
            return subEffect
        else
            return self:_createActionNode(effect)    
        end
    end
    local function eventFunction(event)
        if event == "finish" then
            self:_createContinueNode()
            G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_END)
        end

        --do
    end
    local movingName = "moving_xiujiang"
    if self._isRight then
        movingName = "moving_xiujiangjx"
    end
    local effect = G_EffectGfxMgr:createPlayMovingGfx( self, movingName, effectFunction, eventFunction , false )
    self._effectShow = effect
end

function HeroShow:_createContinueNode()
    local continueNode = CSHelper.loadResourceNode(Path.getCSB("CommonContinueNode", "common"))
    self:addChild(continueNode)
    continueNode:setPosition(cc.p(0, -250))
    self._isAction = false
    if self._needAutoClose then
        self._scheduleHandler = SchedulerHelper.newSchedule(function()
            self._autoTime = self._autoTime + 1
            if self._autoTime >= HeroShow.AUTO_CLOSE_TIME then
                if self._callback then
                    self._callback()
                end
                self:close()
            end
        end, 1)
    end
end



return HeroShow