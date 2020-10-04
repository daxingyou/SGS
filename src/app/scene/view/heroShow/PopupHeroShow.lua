local Hero = require("app.config.hero")
local HeroRes = require("app.config.hero_res")
local PopupBase = require("app.ui.PopupBase")
local Instrument = require("app.config.instrument")
local SchedulerHelper = require ("app.utils.SchedulerHelper")
local UIHelper = require("yoka.utils.UIHelper")
local UTF8 = require("app.utils.UTF8")
   
local CSHelper  = require("yoka.utils.CSHelper")
local PopupHeroShow = class("PopupHeroShow", PopupBase)


PopupHeroShow.AUTO_CLOSE_TIME = 10

PopupHeroShow.Z_OEDER_BG = 1
PopupHeroShow.Z_OEDER_ANIM = 2
PopupHeroShow.Z_OEDER_SKIP = 3
PopupHeroShow.Z_OEDER_CONTINUE = 4

PopupHeroShow.HERO_NAME_BG = 
{
    "",
    "",
    "",
    "sr_name_bg",
    "ssr_name_bg",
    "ur_name_bg"
}

PopupHeroShow.HERO_COLOR_NAME = 
{
    "img_com_grade_lv",
    "img_com_grade_lv",
    "img_com_grade_lan",
    "img_com_grade_zi",
    "img_com_grade_cheng",
    "img_com_grade_hong",
    "img_com_grade_jin"
}

function PopupHeroShow:ctor(heroId, callback, needAutoClose, isRight,isFight)
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
    self._isFight = isFight

    self._isBgShow = true
    self._isContinueShow = true
    self._isSkipShow = false
    self._isShareShow = true
    self._isNewShow = true
    self._shareContrlNodeList = {}
    PopupHeroShow.super.ctor(self, nil, false, false)
end

function PopupHeroShow:onCreate()
    if self._isFight then
        self._isSkipShow = false
        self._isBgShow = false
        self._isShareShow = false
        self._isNewShow = false
    end
    if self._isBgShow then
        local sprite = display.newSprite(Path.getShowHeroUI4("bg"))
        sprite:setAnchorPoint(cc.p(0.5,0.5))
        sprite:setPosition(cc.p(0.5,0.5))
        sprite:setLocalZOrder(PopupHeroShow.Z_OEDER_BG)
        self:addChild(sprite)
        self._bgSprite1 = sprite
    
        local sprite2 = display.newSprite(Path.getDrawCard2("bg_guang"))
        sprite2:setAnchorPoint(cc.p(0.5,0.5))
        sprite2:setPosition(cc.p(0.5,0.5))
        sprite2:setLocalZOrder(PopupHeroShow.Z_OEDER_BG)
        self:addChild(sprite2)
        self._bgSprite2 = sprite2
    
    end
   

    if self._isSkipShow then
        self:_createSkip()
    end
    
end

function PopupHeroShow:_addControlNode(node)
    local parentNode = cc.Node:create()
    parentNode:addChild(node)
    parentNode:setLocalZOrder(node:getLocalZOrder())
    parentNode:setName("share_control")
    table.insert(self._shareContrlNodeList, parentNode)
    return parentNode
end



function PopupHeroShow:_createSkip()
    local layer = CSHelper.loadResourceNode(Path.getCSB("CommonSkipLayer", "common"))
    layer:setContentSize( G_ResolutionManager:getDesignCCSize())
    layer:setAnchorPoint( cc.p(0.5, 0.5))
    layer:setPosition(cc.p(0,0))
    ccui.Helper:doLayout(layer)
    layer:addClickEventListenerEx(handler(self, self._onClickSkip))
    layer:setLocalZOrder(PopupHeroShow.Z_OEDER_SKIP)
    self:addChild(self:_addControlNode(layer))
    self._skipLayer = layer
end



function PopupHeroShow:setBgVisible(bool)
    self._isBgShow = bool
    if self._bgSprite1 then
        self._bgSprite1:setVisible(bool)
    end
    if self._bgSprite2 then
        self._bgSprite2:setVisible(bool)
    end
end

function PopupHeroShow:setNewVisible(bool)
    self._isNewShow = bool
    if self._newNode then
        self._newNode:setVisible(bool)
    end
end

function PopupHeroShow:setSkipVisible(bool)
    self._isSkipShow = bool
    if self._skipLayer then
        self._skipLayer:setVisible(bool)
    end
end

function PopupHeroShow:setShareVisible(bool)
    self._isShareShow = bool
    if self._shareLayer then
        self._shareLayer:setVisible(bool)
    end
end

function PopupHeroShow:setContinueVisible(bool)
    self._isContinueShow = bool
    if self._continueNode then
        self._continueNode:setVisible(bool)
    end
end

function PopupHeroShow:onEnter()
    self:play()
end

function PopupHeroShow:onExit()
    if self._scheduleHandler then
        SchedulerHelper.cancelSchedule(self._scheduleHandler)
    end
    self._scheduleHandler = nil
   
end

function PopupHeroShow:_stopVoice()
    if Lang.checkUI("ui4") then
        G_HeroVoiceManager:stopCurrentVoice()
    end
end

function PopupHeroShow:_onFinishTouch(sender, event)
    if not self._isAction and event == 2 then
        self:_stopVoice()
        if self._callback then
            self._callback()
        end
        self:close()
    end
end

function PopupHeroShow:_onClickSkip(sender, event)
    if not self._isAction  then
        self:_stopVoice()
        if self._skipCallback then
            self._skipCallback()
        end
        self:close()
    end
end

function PopupHeroShow:setSkipCallback(callback)
    self._skipCallback = callback
end

function PopupHeroShow:play()
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



-- 武将定位
function PopupHeroShow:_xiujiang_zi_dingwei_txt()
    local node = cc.Node:create()
    local x = 0

   
    
    local content = ""
    content = content ..UTF8.unicode_to_utf8("\\u25C6")
    content = content .. Lang.get("hero_show_position")..self._hero.feature

    content = string.gsub(content, ":", UTF8.unicode_to_utf8("\\u2025"))
    content = string.gsub(content, "-", "・")

    --UTF8.unicode_to_utf8("\\u002E")
    local label = cc.Label:createWithTTF(content, Path.getFontW8(), 30)
    local color = Colors.D_WHITE
    label:setColor(color)
    label:setMaxLineWidth(30)
    -- label:enableOutline(outline, 2) 
    label:setAnchorPoint(cc.p(0.5, 1))
    label:setPosition(x,0)
    label:setVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
    node:addChild(label)

    
    
    local content2 = self._hero.skill_name..self._hero.skill_description
    content2 = string.gsub(content2, "%[", UTF8.unicode_to_utf8("\\uFE47"))
    content2 = string.gsub(content2, "%]", UTF8.unicode_to_utf8("\\uFE48"))
    --content2 = string.gsub(content2, "。", UTF8.unicode_to_utf8("\\uFE12"))
    content2 = string.gsub(content2, "ー", UTF8.unicode_to_utf8("\\uFE31") )
    
    local UIHelper = require("yoka.utils.UIHelper")
    local tempList = UIHelper.getUTF8TxtList(content2,16)
    x = x - 47
    for k,v in ipairs(tempList) do
        local label = cc.Label:createWithTTF(v, Path.getCommonFont(), 20)
        label:setMaxLineWidth(20)
        label:setAnchorPoint(cc.p(0.5, 1))
        label:setPosition(x,0)
        label:setVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
        node:addChild(label)
        x = x - 30
    end
    return node
end


-- 武将神兵
function PopupHeroShow:_xiujiang_zi_shenbing_txt()
    local node = cc.Node:create()
    local x = 0
    local content = UTF8.unicode_to_utf8("\\u25C6") .. Lang.get("hero_show_instrument")..self._instrument.name
    content = string.gsub(content, ":", UTF8.unicode_to_utf8("\\u2025"))


    local label = cc.Label:createWithTTF(content, Path.getFontW8(), 30)
    local color = Colors.D_WHITE
    label:setColor(color)
    label:setMaxLineWidth(30)
    -- label:enableOutline(outline, 2) 
    label:setAnchorPoint(cc.p(0.5, 1))
    label:setPosition(x,0)
    label:setVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
    node:addChild(label)


    local content = self._hero.instrument_description
    content = string.gsub(content, "ー", UTF8.unicode_to_utf8("\\uFE31") )
    local UIHelper = require("yoka.utils.UIHelper")
    local tempList = UIHelper.getUTF8TxtList(content,16)
  
    x = x - 47
    for k,v in ipairs(tempList) do
        local label = cc.Label:createWithTTF(v, Path.getCommonFont(), 20)
        label:setMaxLineWidth(20)
        label:setAnchorPoint(cc.p(0.5, 1))
        label:setPosition(x,0)
        label:setVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
        node:addChild(label)
        x = x - 30
    end
    return node
end


--spine
function PopupHeroShow:_xiujiang_role()
    -- local image = self._heroRes.story_res
    -- local sprite = display.newSprite(Path.getChatRoleRes(image))
    -- return sprite
    local CSHelper  = require("yoka.utils.CSHelper")
    local heroAvatar = CSHelper.loadResourceNode(Path.getCSB("CommonStoryAvatar2", "common"))
    heroAvatar:updateUI(self._hero.id)
    G_HeroVoiceManager:playVoiceWithHeroId(self._hero.id, true)
    return heroAvatar
end

--武将名称
function PopupHeroShow:_xiujiang_mingzi()
    local image = self._heroRes.show_name
    local sprite = display.newSprite(Path.getShowHeroNameTrue(image))
    sprite:setAnchorPoint(cc.p(0.5,1))
    return sprite
end


--国籍
function PopupHeroShow:_xiujiang_country()
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, self._hero.id)
    local sprite = display.newSprite(param.country_text_2_highlight)
    return sprite
end


--分享
function PopupHeroShow:_show()
    if not self._isShareShow then
        return cc.Node:create()
    end
    local layer = CSHelper.loadResourceNode(Path.getCSB("CommonShareLayer", "common"))
    self._shareLayer = layer
    self._shareLayer:setContentSize( G_ResolutionManager:getDesignCCSize())
    self._shareLayer:setAnchorPoint( cc.p(0.5, 0.5))
    self._shareLayer:setPosition(cc.p(0,0))
    self._shareLayer:updateData()
    self._shareLayer:setShowHideCallback(function(show)
        for k,v in ipairs(self._shareContrlNodeList) do
            v:setVisible(show)
        end
    end)

    
    ccui.Helper:doLayout(self._shareLayer)
    return self:_addControlNode(layer)
end

--配音名
function PopupHeroShow:_cv_show()
    local node = CSHelper.loadResourceNode(Path.getCSB("CommonCvName", "common"))
    node:updateData(self._hero.id)

    node:setPositionY(-3)
    local node1 = cc.Node:create()
    node1:addChild(node)

    return node1
end

--品质名
function PopupHeroShow:_show_ssr()
    local color = self._hero.color
    local image = Path.getTextTeam(PopupHeroShow.HERO_COLOR_NAME[color])
    local sprite = display.newSprite(image)
    return sprite
end

--名字背景
function PopupHeroShow:_show_pingzhi_ditu()
    local color = self._hero.color
    local image = Path.getDrawCard2(PopupHeroShow.HERO_NAME_BG[color])
    local sprite = display.newSprite(image)
    return sprite
end

--New
function PopupHeroShow:_new_kk()
    if not self._isNewShow then
        return cc.Node:create()
    end

    local isNew =  G_UserData:getHandBook():isNewHero(self._hero.id,"Show") 
    local node = cc.Node:create()
    if isNew then
        G_EffectGfxMgr:createPlayGfx(node, "effect_new_tx",nil,nil)

        local image = Path.getDrawCard2("NEW")
        local sprite = display.newSprite(image)
        node:addChild(sprite)
    end
    self._newNode = node
    return node
end

function PopupHeroShow:_createActionNode(effect)
    local funcName = "_"..effect
	if funcName then
		local func = self[funcName]
		assert(func, "has not func name = "..funcName)
		local node = func(self)
        return node
    else
        return cc.Node:create()
	end
end

function PopupHeroShow:_createAnimation()
    local function effectFunction(effect)
        return self:_createActionNode(effect)    
    end
    local function eventFunction(event)
        if event == "finish" then
            if self._isContinueShow then
                self:_createContinueNode()
            end
            self._isAction = false
            if self._needAutoClose then
                self._scheduleHandler = SchedulerHelper.newSchedule(function()
                    self._autoTime = self._autoTime + 1
                    if self._autoTime >= PopupHeroShow.AUTO_CLOSE_TIME then
                        self:_stopVoice()
                        if self._callback then
                            self._callback()
                        end
                        self:close()
                    end
                end, 1)
            end
            G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_END)
        end
    end
    local movingName = "moving_show_xiujiang"
    local effect = G_EffectGfxMgr:createPlayMovingGfx( self, movingName, effectFunction, eventFunction , false )
    effect:setLocalZOrder(PopupHeroShow.Z_OEDER_ANIM)
    
    self._effectShow = effect
end

function PopupHeroShow:_createContinueNode()
    local continueNode = CSHelper.loadResourceNode(Path.getCSB("CommonContinueNode", "common"))
    continueNode:setLocalZOrder(PopupHeroShow.Z_OEDER_CONTINUE)
    continueNode:setPosition(cc.p(0, -250))
    self._continueNode  = continueNode
    self:addChild(self:_addControlNode(continueNode))
end



return PopupHeroShow