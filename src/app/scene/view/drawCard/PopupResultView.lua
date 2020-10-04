local CSHelper  = require("yoka.utils.CSHelper")
local PopupBase = require("app.ui.PopupBase")
local PopupResultView = class("PopupResultView", PopupBase)

function PopupResultView:ctor(rewards,callback)
    self._rewards = rewards
    self._callback = callback
    self._isAction = true
    self._effectShow = nil
    self._textGetDetail = nil

    self._isContinueShow = true
    self._isShareShow = true

    dump(rewards)
   
    PopupResultView.super.ctor(self, nil, false, false)
end

function PopupResultView:onCreate()
    self._isTen = #self._rewards == 10
    self:_createTouchLayer()
    self:_createAnimation()
    if self._isShareShow then
        self:_createShareLayer()
    end
end


function PopupResultView:setShareVisible(bool)
    self._isShareShow = bool
    if self._shareLayer then
        self._shareLayer:setVisible(bool)
    end
end

function PopupResultView:setContinueVisible(bool)
    self._isContinueShow = bool
    if self._continueNode then
        self._continueNode:setVisible(bool)
    end
end


function PopupResultView:setGetDetail(show,txt)
    if not self._textGetDetail then
        local label = cc.Label:createWithTTF("", Path.getCommonFont(), 20)
        label:setAnchorPoint(cc.p(0.5, 0.5))
        label:setPosition(0,-250)
        label:setLocalZOrder(11)
        self:addChild(label)
        self._textGetDetail  = label
    end
    self._textGetDetail:setVisible(show)
    if txt then
        self._textGetDetail:setString(txt)
    end
end


function PopupResultView:onEnter()
    
end

function PopupResultView:onExit()
end

function PopupResultView:_createTouchLayer()
    local params = {
        contentSize = G_ResolutionManager:getDesignCCSize(),
        anchorPoint = cc.p(0.5, 0.5),
        position = cc.p(0, 0)
    }
    local UIHelper = require("yoka.utils.UIHelper")
    self._panelFinish = UIHelper.createPanel(params)
    self._panelFinish:setTouchEnabled(true)
    self._panelFinish:setSwallowTouches(true)
    self._panelFinish:addTouchEventListener(handler(self,self._onFinishTouch))
    self:addChild(self._panelFinish)
end

function PopupResultView:_onFinishTouch(sender, event)
    if not self._isAction and event == 2 then
        if self._callback then
            self._callback()
        end
        self:close()
    end
end


function PopupResultView:_kapai(index)
    local node = cc.Node:create()
    cc.bind(node,"CommonGetHeroItem")
    local reward = self._rewards[index]
    local isNew =  G_UserData:getHandBook():isNewHero(reward.value,"ShowResult") 
    node:playAnimation(reward.value,isNew)
    return node
end

function PopupResultView:_kapai1()
    return self:_kapai(1)
end

function PopupResultView:_kapai2()
    return self:_kapai(2)
end

function PopupResultView:_kapai3()
    return self:_kapai(3)
end

function PopupResultView:_kapai4()
    return self:_kapai(4)
end

function PopupResultView:_kapai5()
    return self:_kapai(5)
end

function PopupResultView:_kapai6()
    return self:_kapai(6)
end

function PopupResultView:_kapai7()
    return self:_kapai(7)
end

function PopupResultView:_kapai8()
    return self:_kapai(8)
end

function PopupResultView:_kapai9()
    return self:_kapai(9) 
end

function PopupResultView:_kapai10()
    return self:_kapai(10) 
end

function PopupResultView:_createActionNode(effect)
    local funcName = "_"..effect
    local func = self[funcName]
    assert(func, "has not func name = "..funcName)
    local node = func(self)
    local TextHelper = require("app.utils.TextHelper")
    if TextHelper.stringStartsWith(effect,"smoving_") then
        G_EffectGfxMgr:applySingleGfx(node, effect)
    end
    return node
end


function PopupResultView:_createAnimation()
    self._isAction = true
    local function effectFunction(effect)
        return self:_createActionNode(effect)    
    end
    local function eventFunction(event)
        if event == "finish" then
            self._isAction = false
            if self._isContinueShow then
                self:_createContinueNode()
            end
        end
    end
    
    print("PopupResultView _createAnimation")

    local movingName = "moving_kapai_ruchang_yige"
    if self._isTen then
        movingName = "moving_kapai_ruchang_shige"
    end
    local effect = G_EffectGfxMgr:createPlayMovingGfx( self, movingName, effectFunction, eventFunction , false )
    self._effectShow = effect
end

function PopupResultView:_createShareLayer()
    local CSHelper = require("yoka.utils.CSHelper")
    local layer = CSHelper.loadResourceNode(Path.getCSB("CommonShareLayer", "common"))
    self._shareLayer = layer
    self._shareLayer:setContentSize( G_ResolutionManager:getDesignCCSize())
    self._shareLayer:setAnchorPoint( cc.p(0.5, 0.5))
    self._shareLayer:setPosition(cc.p(0,0))
    self._shareLayer:updateData()
    ccui.Helper:doLayout(self._shareLayer)
    self:addChild(layer)
end

function PopupResultView:_createContinueNode()
    local continueNode = CSHelper.loadResourceNode(Path.getCSB("CommonContinueNode", "common"))
    self:addChild(continueNode)
    continueNode:setPosition(cc.p( 0, -250 ))
    self._continueNode = continueNode
end


return PopupResultView