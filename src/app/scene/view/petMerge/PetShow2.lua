local PopupBase = require("app.ui.PopupBase")
local PetShow2 = class("PetShow2", PopupBase)

local CSHelper  = require("yoka.utils.CSHelper")
local Pet = require("app.config.pet")
local HeroRes = require("app.config.hero_res")
local Instrument = require("app.config.instrument")
local UIHelper = require("yoka.utils.UIHelper")
local UTF8 = require("app.utils.UTF8")
local Path = require("app.utils.Path")
local Color = require("app.utils.Color")
local SchedulerHelper = require ("app.utils.SchedulerHelper")


PetShow2.AUTO_CLOSE_TIME = 10

PetShow2.Z_OEDER_BG = 1
PetShow2.Z_OEDER_ANIM = 2
PetShow2.Z_OEDER_SKIP = 3
PetShow2.Z_OEDER_CONTINUE = 4

PetShow2.HERO_NAME_BG = 
{
    "",
    "",
    "",
    "color_bg_4",
    "color_bg_5",
    "color_bg_6"
}

PetShow2.HERO_COLOR_NAME = 
{
    "img_com_grade_lv",
    "img_com_grade_lv",
    "img_com_grade_lan",
    "img_com_grade_zi",
    "img_com_grade_cheng",
    "img_com_grade_hong",
    "img_com_grade_jin"
}


function PetShow2.create(heroId, callback, needAutoClose, isRight)
	-- assert(spriteFrames and num, "spriteFrames and num could not be nil !")
	local PetShow2 = PetShow2.new(heroId, callback, needAutoClose, isRight)
    PetShow2:open()
    return PetShow2
end

function PetShow2:ctor(heroId, callback, needAutoClose, isRight)
    local hero = Pet.get(heroId)
    assert(hero, "pet id is wrong "..heroId)
    self._petCfg = hero
    self._heroRes = HeroRes.get(hero.res_id)
    self._panelFinish = nil
    self._isAction = true
    self._effectShow = nil
    self._callback = callback
    self._needAutoClose = needAutoClose
    self._scheduleHandler = nil
    self._autoTime = 0
    self._isRight = isRight
   

    self._isBgShow = true
    self._isContinueShow = true
    self._isSkipShow = true
    self._isShareShow = true
    self._isNewShow = true

    PetShow2.super.ctor(self, nil, false, false)
end


function PetShow2:onCreate()
   
    if self._isBgShow then
        local sprite = display.newSprite(Path.getShowHeroUI4("bg"))
        sprite:setAnchorPoint(cc.p(0.5,0.5))
        sprite:setPosition(cc.p(0.5,0.5))
        sprite:setLocalZOrder(PetShow2.Z_OEDER_BG)
        self:addChild(sprite)
        self._bgSprite1 = sprite
    
        local sprite2 = display.newSprite(Path.getDrawCard2("bg_guang"))
        sprite2:setAnchorPoint(cc.p(0.5,0.5))
        sprite2:setPosition(cc.p(0.5,0.5))
        sprite2:setLocalZOrder(PetShow2.Z_OEDER_BG)
        self:addChild(sprite2)
        self._bgSprite2 = sprite2
    
    end
   

    if self._isSkipShow then
        self:_createSkip()
    end
    
end

function PetShow2:_createSkip()
    local layer = CSHelper.loadResourceNode(Path.getCSB("CommonSkipLayer", "common"))
    layer:setContentSize( G_ResolutionManager:getDesignCCSize())
    layer:setAnchorPoint( cc.p(0.5, 0.5))
    layer:setPosition(cc.p(0,0))
    ccui.Helper:doLayout(layer)
    layer:addClickEventListenerEx(handler(self, self._onClickSkip))
    layer:setLocalZOrder(PetShow2.Z_OEDER_SKIP)
    self:addChild(layer)
    self._skipLayer = layer
end


function PetShow2:setBgVisible(bool)
    self._isBgShow = bool
    if self._bgSprite1 then
        self._bgSprite1:setVisible(bool)
    end
    if self._bgSprite2 then
        self._bgSprite2:setVisible(bool)
    end
end

function PetShow2:setNewVisible(bool)
    self._isNewShow = bool
    if self._newNode then
        self._newNode:setVisible(bool)
    end
end

function PetShow2:setSkipVisible(bool)
    self._isSkipShow = bool
    if self._skipLayer then
        self._skipLayer:setVisible(bool)
    end
end

function PetShow2:setShareVisible(bool)
    self._isShareShow = bool
    if self._shareLayer then
        self._shareLayer:setVisible(bool)
    end
end

function PetShow2:setContinueVisible(bool)
    self._isContinueShow = bool
    if self._continueNode then
        self._continueNode:setVisible(bool)
    end
end

function PetShow2:onEnter()
    self:play()
end

function PetShow2:onExit()
    if self._scheduleHandler then
        SchedulerHelper.cancelSchedule(self._scheduleHandler)
    end
    self._scheduleHandler = nil
    if Lang.checkUI("ui4") then
        G_HeroVoiceManager:stopCurrentVoice()
    end
end

function PetShow2:_onFinishTouch(sender, event)
    if not self._isAction and event == 2 then
        if self._callback then
            self._callback()
        end
        self:close()
    end
end

function PetShow2:_onClickSkip(sender, event)
    if not self._isAction  then
        if self._skipCallback then
            self._skipCallback()
        end
        self:close()
    end
end

function PetShow2:setSkipCallback(callback)
    self._skipCallback = callback
end

function PetShow2:play()
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


-- 武将神兵
function PetShow2:_xiujiang_zi_shenbing_txt()
    local node = cc.Node:create()
    local x = 0
    local content = ""
    content = content ..UTF8.unicode_to_utf8("\\u25C6")
    content = content ..Lang.get("pet_show_skill")..self._petCfg.skill_name

    content = string.gsub(content, ":", UTF8.unicode_to_utf8("\\u2025"))
    content = string.gsub(content, "%[", UTF8.unicode_to_utf8("\\uFE47"))
    content = string.gsub(content, "%]", UTF8.unicode_to_utf8("\\uFE48"))


    local label = cc.Label:createWithTTF(content, Path.getFontW8(), 30)
    local color = Colors.D_WHITE
    label:setColor(color)
    label:setMaxLineWidth(30)
    -- label:enableOutline(outline, 2) 
    label:setAnchorPoint(cc.p(0.5, 1))
    label:setPosition(x,0)
    node:addChild(label)
    
    local content = self._petCfg.skill_description
    local UIHelper = require("yoka.utils.UIHelper")
    local tempList = UIHelper.getUTF8TxtList(content,16)
    x = x - 47
    for k,v in ipairs(tempList) do
        local label = cc.Label:createWithTTF(v, Path.getCommonFont(), 20)
        label:setMaxLineWidth(20)
        label:setAnchorPoint(cc.p(0.5, 1))
        label:setPosition(x,0)
        node:addChild(label)
        x = x - 30
    end
    return node
end



--spine
function PetShow2:_show_shengshou()
    local CSHelper  = require("yoka.utils.CSHelper")
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local avatar = CSHelper.loadResourceNode(Path.getCSB("CommonHeroAvatar", "common"))
    avatar:setConvertType(TypeConvertHelper.TYPE_PET)
    avatar:updateUI(self._petCfg.id)
    avatar:showName(false)
    avatar:setScale(1.5)
    return avatar
end


  
--武将名称
function PetShow2:_nianshou_name()
    local image = self._heroRes.show_name
    local sprite = display.newSprite(Path.getShowHeroName(image))
    sprite:setAnchorPoint(cc.p(0.5,1))
    return sprite
end



--分享
function PetShow2:_show()
    if not self._isShareShow then
        return cc.Node:create()
    end
    local layer = CSHelper.loadResourceNode(Path.getCSB("CommonShareLayer", "common"))
    self._shareLayer = layer
    self._shareLayer:setContentSize( G_ResolutionManager:getDesignCCSize())
    self._shareLayer:setAnchorPoint( cc.p(0.5, 0.5))
    self._shareLayer:setPosition(cc.p(0,0))
    self._shareLayer:updateData()
    ccui.Helper:doLayout(self._shareLayer)
    return layer
end



--品质名
function PetShow2:_show_ssr()
    local color = self._petCfg.color
    local image = Path.getTextTeam(PetShow2.HERO_COLOR_NAME[color])
    local sprite = display.newSprite(image)
    return sprite
end


--return sprite
--名字背景
function PetShow2:_nianshou_dibantiao()
    local color = self._petCfg.color
    local image = Path.getShowHeroUI4(PetShow2.HERO_NAME_BG[color])
    local sprite = display.newSprite(image)
    return sprite
end


--New
function PetShow2:_new_kk()
    if not self._isNewShow then
        return cc.Node:create()
    end

    local isNew =  G_UserData:getHandBook():isNewPet(self._petCfg.id,"Show")
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


---------------------------------------------------------------------------------------


function PetShow2:_createActionNode(effect)
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

function PetShow2:_createAnimation()
    local EffectGfxNode = require("app.effect.EffectGfxNode")
    local function effectFunction(effect)
        return self:_createActionNode(effect)    
    end
    local function eventFunction(event)
        if event == "finish" then
            if self._isContinueShow then
                self:_createContinueNode()
            end
            G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_END)
        end

        --do
    end
    local movingName = "moving_show_nianshou"
    local effect = G_EffectGfxMgr:createPlayMovingGfx( self, movingName, effectFunction, eventFunction , false )
    effect:setLocalZOrder(PetShow2.Z_OEDER_ANIM)
    self._effectShow = effect
end

function PetShow2:_createContinueNode()
    local continueNode = CSHelper.loadResourceNode(Path.getCSB("CommonContinueNode", "common"))
    self:addChild(continueNode)
    continueNode:setLocalZOrder(PetShow2.Z_OEDER_CONTINUE)
    self._continueNode  = continueNode
    continueNode:setPosition(cc.p(0, -250))
    self._isAction = false
    if self._needAutoClose then
        self._scheduleHandler = SchedulerHelper.newSchedule(function()
            self._autoTime = self._autoTime + 1
            if self._autoTime >= PetShow2.AUTO_CLOSE_TIME then
                if self._callback then
                    self._callback()
                end
                self:close()
            end
        end, 1)
    end
end



return PetShow2