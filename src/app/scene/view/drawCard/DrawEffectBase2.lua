local PopupBase = require("app.ui.PopupBase")
local DrawEffectBase2 = class("DrawEffectBase2", PopupBase)

local CSHelper  = require("yoka.utils.CSHelper")
local DrawCardCell = require("app.scene.view.drawCard.DrawCardCell")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local UIHelper = require("yoka.utils.UIHelper")
local HeroShow = require("app.scene.view.heroShow.HeroShow")

local Hero = require("app.config.hero")

DrawEffectBase2.DRAW_TYPE_MONEY = 1
DrawEffectBase2.DRAW_TYPE_GOLD = 2


DrawEffectBase2.Z_ORDER_BK = 1
DrawEffectBase2.Z_ORDER_EFFECT = 2
DrawEffectBase2.Z_ORDER_TOUCH = 3


local Parameter = require("app.config.parameter")
local ParameterIDConst = require("app.const.ParameterIDConst")

function DrawEffectBase2:ctor(awards, type)
    -- self._rootNode = rootNode
    self._awards = awards
    self._cardNode = nil
    self._cardToOpen = nil
    self._showEffectCard = {}
    self._isAction = false
    DrawEffectBase2.super.ctor(self, nil, false, true)
end

function DrawEffectBase2:onCreate()
    self:_createEffectRootNode()
end

function DrawEffectBase2:onEnter()
  
end

function DrawEffectBase2:onExit()
end

function DrawEffectBase2:_reset()
    self._isAction = true 
    self._cardNode = {}
    self._cardToOpen = {}
    self._showEffectCard = {}
    if self._effectRootNode then
        self._effectRootNode:removeAllChildren()
    end
end

--滑动触发卡牌特效
function DrawEffectBase2:_onFinishTouch(sender, event)
    if self._isAction then
        return 
    end
    local point = nil
	if event == ccui.TouchEventType.began then
		point = sender:getTouchBeganPosition()
    elseif event == ccui.TouchEventType.moved then    
        point = sender:getTouchMovePosition()
	elseif event == ccui.TouchEventType.ended then
        point = sender:getTouchEndPosition()
    end
  
    if not point then
       return
    end
    local getMatchCardIndex = function(k)
        if k > 5 then
            return k - 5 
        else
            return k + 5
        end
    end
    --print("_onFinishTouch "..point.x.." "..point.y)
    for k,node in ipairs(self._cardNode) do
        if not self._showEffectCard[k] then
            local x,y = node:getPosition()
            local size = node:getContentSize()
            local worldPos = node:convertToWorldSpaceAR(cc.p(0,0))

            --print(k.." worldPos "..worldPos.x.." "..worldPos.y)

            local left = worldPos.x-size.width*0.5
            local right = worldPos.x+size.width*0.5
            if point.x >= left and point.x <= right then
                self:_lightCard(k)
                local matchK = getMatchCardIndex(k)
                self:_playAudio(k,matchK)
                self:_lightCard(matchK)

              

                if self:_checkIsAllCardLight() then
                     self:playGuang()
                end
                break
            end
        end
    end
    if(event == ccui.TouchEventType.ended)then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
        local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
        print("_onFinishTouch move dis "..moveOffsetX)
        if moveOffsetX >= 500 then
          
            if not self:_checkIsAllCardLight() then
                self:_lightAllCard()
                self:playGuang()
           end
        end
    end
end

function DrawEffectBase2:_playAudio(k,matchK)
    local heroId = self._awards[k].value
    local hero = Hero.get(heroId)

    local heroId2 = self._awards[matchK].value
    local hero2 = Hero.get(heroId2)

    local color = math.max(hero.color,hero2.color)
    local AudioConst = require("app.const.AudioConst")
    if color <= 4 then
        G_AudioManager:playSound(Path.getUIVoice("drawcard_touch1"))
    else
        G_AudioManager:playSound(Path.getUIVoice("drawcard_touch2"))
    end
end

function DrawEffectBase2:_lightAllCard()
    for k, v in pairs(self._cardNode) do
        if not self._showEffectCard[k] then
            self:_lightCard(k)
        end
    end
end

function DrawEffectBase2:_lightCard(k)
    if self._showEffectCard[k] then
        return
    end
    local node = self._cardNode[k]
    local effectNode = node:getChildByName("effect")
    effectNode:setVisible(true)
    self._showEffectCard[k] = true
end

function DrawEffectBase2:_checkIsAllCardLight()
    local count = 0
    for k, v in pairs(self._showEffectCard) do
        if v ~= nil then
            count = count + 1
        end
    end
    return count == #self._cardNode
end

function DrawEffectBase2:play()
    self:_reset()
    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_BEGIN)
end

function DrawEffectBase2:_pushCardData(nodeIndex)
    local showColor = 5
    if G_TutorialManager:isDoingStep() then
        showColor = 4
    end
    local index = nodeIndex or 1
    local heroId = self._awards[index].value
    local hero = Hero.get(heroId)
    if hero.color >= showColor then
        table.insert(self._cardToOpen, index)
    end
end

function DrawEffectBase2:_createCard(nodeIndex)
    self:_pushCardData(nodeIndex)
    local node = self._cardNode[nodeIndex]
    if not node then
        local node = cc.Node:create()
        local effectName = 
        {
            "effect_zhaomu_lv",
            "effect_zhaomu_lv",
            "effect_zhaomu_lan",
            "effect_zhaomu_zi",
            "effect_zhaomu_cheng",
            "effect_zhaomu_hong",
            "effect_zhaomu_hong",
        }
        local cardW = 114
        local cardH = 139
        node:setAnchorPoint(cc.p(0.5,0.5))
        node:setContentSize(cardW,cardW)
        local heroId = self._awards[nodeIndex].value
        local hero = Hero.get(heroId)

        
       
        local effectNode = G_EffectGfxMgr:createPlayGfx(node, effectName[hero.color], nil, nil )
        effectNode:setVisible(false)
        effectNode:setName("effect")

        self._cardNode[nodeIndex] = node
    end
    return  self._cardNode[nodeIndex] 
end


function DrawEffectBase2:_openCard(index)
    local hero = Hero.get(self._awards[index].value)
    self:_removeCardToOpenByIndex(index)
end

function DrawEffectBase2:_removeCardToOpenByIndex(index)
    for i = #self._cardToOpen, 1, -1 do
        local val = self._cardToOpen[i]
        if val == index then
            table.remove(self._cardToOpen, i)
            return
        end
    end
end

function DrawEffectBase2:_playHeroShow(index)
    local hero = Hero.get(self._awards[index].value)
    local HeroShow = require("app.scene.view.heroShow.HeroShow")
    local pop = HeroShow.create(hero.id, function() 
        self:_openCard(index) 
        self:_nextCard()
    end,false,false,false)
    pop:setSkipCallback(function() 
        self:_openCard(index)
        self:_nextNewCard()
    end)
end

--i18n ui4 
function DrawEffectBase2:_playJieSuan()
    local rewards = self._awards
    local popupResultView = require("app.scene.view.drawCard.PopupResultView").new(rewards,function() 
        self:removeFromParent()
        G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
        G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_END)
    end)
    popupResultView:open()
end

--i18n ui4 
function DrawEffectBase2:_nextCard()
    if #self._cardToOpen == 0 then
        self:_playJieSuan()
    else
        self:_playHeroShow(self._cardToOpen[1])
    end

end

--i18n ui4 next new card
function DrawEffectBase2:_nextNewCard()
    local nextIndex = nil
    local openIndexs = {}
    for k,index in ipairs(self._cardToOpen) do
        local reward = self._awards[index]
        local isNew =  G_UserData:getHandBook():isNewHero(reward.value,"DrawEffect") 
        if isNew then
            nextIndex = index
            break
        else
           table.insert(openIndexs,index)
        end
    end
    
    for k,index in ipairs(openIndexs) do
        self:_openCard(index)
    end
    if nextIndex then
        self:_playHeroShow(nextIndex)
    else
        self:_playJieSuan()
    end
end

function DrawEffectBase2:_startShowHero()
    self:_nextCard()
end

function DrawEffectBase2:playGuang()
    local function effectFunction(effect)
        return cc.Node:create()
    end
    local function eventFunction(event)
        if event == "boom" then
            self:_startShowHero()
        elseif event == "finish" then
        end
    end
    local AudioConst = require("app.const.AudioConst")
    G_AudioManager:playSound(Path.getUIVoice("drawcard_shine"))
    local effect = G_EffectGfxMgr:createPlayMovingGfx(self._effectRootNode, "moving_lingpai_qptx", 
        effectFunction, eventFunction , true )
end

--场景特效
function DrawEffectBase2:_createBackEffect()
    local ViewBase = require("app.ui.ViewBase")
    local bgView = ViewBase.new(nil,nil)
    cc.bind(bgView,"CommonSceneEffect")
    bgView:setScene(G_SceneIdConst.SCENE_ID_DRAW_CARD,G_SceneIdConst.SCENE_ID_DRAW_CARD_NIGHT)
    local point = G_ResolutionManager:getDesignCCPoint()
    bgView:setPosition(-point.x,-point.y)
    local node =  cc.Node:create()
    node:addChild(bgView)
    return node    
end

function DrawEffectBase2:_createContinueNode()
    local continueNode = CSHelper.loadResourceNode(Path.getCSB("CommonContinueNode", "common"))
    self:addChild(continueNode)
    continueNode:setPosition(cc.p( G_ResolutionManager:getDesignCCPoint().x, 70 ))-- -250
end

function DrawEffectBase2:_createTouchLayer()
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
    self._panelFinish:setLocalZOrder(DrawEffectBase2.Z_ORDER_TOUCH)

    self:addChild(self._panelFinish)
end

function DrawEffectBase2:_createEffectRootNode()
    local node = cc.Node:create()
    node:setLocalZOrder(DrawEffectBase2.Z_ORDER_EFFECT)
    self:addChild(node)
    self._effectRootNode = node
end

return DrawEffectBase2