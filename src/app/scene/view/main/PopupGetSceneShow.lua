local PopupBase = require("app.ui.PopupBase")
local PopupGetSceneShow = class("PopupGetSceneShow", PopupBase)
local mainScene = require("app.config.main_scene")
local UIHelper = require("yoka.utils.UIHelper")

function PopupGetSceneShow:ctor(sceneId,callback)
    self._sceneId = sceneId
    self._callback = callback
    self._isAction = true
   
    PopupGetSceneShow.super.ctor(self, nil, false, false)
end

function PopupGetSceneShow:onCreate()
    self:_createTouchLayer()

    local cfg = mainScene.get(self._sceneId)
	local BattleScene = require("app.config.battle_scene")
	local sceneData = BattleScene.get(cfg.scene_day)
    local icon = UIHelper.createImage({texture = Path.getMainSceneBigIcon(sceneData.icon)})
    self:addChild(icon)

    self:_createAnimation()
    self:_createShareLayer()
end

function PopupGetSceneShow:onEnter()
    self._layerColor:setOpacity(255)
end

function PopupGetSceneShow:onExit()
end

function PopupGetSceneShow:_createTouchLayer()
    local params = {
        contentSize = G_ResolutionManager:getDesignCCSize(),
        anchorPoint = cc.p(0.5, 0.5),
        position = cc.p(0, 0)
    }
    self._panelFinish = UIHelper.createPanel(params)
    self._panelFinish:setTouchEnabled(true)
    self._panelFinish:setSwallowTouches(true)
    self._panelFinish:addTouchEventListener(handler(self,self._onFinishTouch))
    self:addChild(self._panelFinish)
end

function PopupGetSceneShow:_onFinishTouch(sender, event)
    if not self._isAction and event == 2 then
        if self._callback then
            self._callback()
        end
        self:close()
    end
end

function PopupGetSceneShow:_createActionNode(effect)
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

--恭喜获得
function PopupGetSceneShow:_biaotizi_tx()
    local image = Path.getTextCommon("txt_sys_bghuode")
    local sprite = display.newSprite(image)
    return sprite
end

function PopupGetSceneShow:_biaoti_tx()
    local cfg = mainScene.get(self._sceneId)
    local TypeConst = require("app.i18n.utils.TypeConst")
    local label = UIHelper.createLabel({text=cfg.name,style="challenge_2_ui4",styleType=TypeConst.TEXT})
    label:setAnchorPoint(0.5,1)
    label:getVirtualRenderer():setMaxLineWidth(24)
    label:setPositionY(90)
    local node = cc.Node:create()
    node:addChild(label)
    return node
end

function PopupGetSceneShow:_biaotiban_tx()
    local cfg = mainScene.get(self._sceneId)
    local image = UIHelper.createImage({})
    UIHelper.loadCommonBgImageByI18n(image,cfg.name)
    image:setAnchorPoint(0.5,1)
    image:setPositionY(125)
    local node = cc.Node:create()
    node:addChild(image)
    return node
end

function PopupGetSceneShow:_createAnimation()
    local function effectFunction(effect)
        return self:_createActionNode(effect)    
    end
    local function eventFunction(event)
        if event == "finish" then
            self._isAction = false
        end
    end

    local movingName = "moving_cj_huode"
    local effect = G_EffectGfxMgr:createPlayMovingGfx( self, movingName, effectFunction, eventFunction , false )
end

function PopupGetSceneShow:_createShareLayer()
    local CSHelper = require("yoka.utils.CSHelper")
    local layer = CSHelper.loadResourceNode(Path.getCSB("CommonShareLayer", "common"))
    self._shareLayer = layer
    self._shareLayer:setContentSize( G_ResolutionManager:getDesignCCSize())
    self._shareLayer:setAnchorPoint( cc.p(0.5, 0.5))
    self._shareLayer:setPosition(cc.p(0,0))
    ccui.Helper:doLayout(self._shareLayer)
    self:addChild(layer)
end


return PopupGetSceneShow