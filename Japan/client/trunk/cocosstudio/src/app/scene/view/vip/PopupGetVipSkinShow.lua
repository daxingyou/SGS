local PopupBase = require("app.ui.PopupBase")
local PopupGetVipSkinShow = class("PopupGetVipSkinShow", PopupBase)
local skinConfig = require("app.config.skin")
local UIHelper = require("yoka.utils.UIHelper")
local AudioConst = require("app.const.AudioConst")
local UTF8 = require("app.utils.UTF8")

function PopupGetVipSkinShow:ctor(skinId,callback)
    self._skinId = skinId
    self._callback = callback
    self._isAction = true
    self._isSharing = false
    PopupGetVipSkinShow.super.ctor(self, nil, false, false)
end

function PopupGetVipSkinShow:onCreate()
    G_AudioManager:playSoundWithId(AudioConst.SOUND_POPUP_REARD)
    self:_createTouchLayer()

    local icon = UIHelper.createImage({texture = Path.getUICommon("img_skin_bg")})
    self:addChild(icon)

    self:_createAnimation()
    self:_createShareLayer()
end

function PopupGetVipSkinShow:onEnter()
    self._layerColor:setOpacity(255)
end

function PopupGetVipSkinShow:onExit()
end

function PopupGetVipSkinShow:_createTouchLayer()
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

function PopupGetVipSkinShow:_onFinishTouch(sender, event)
    if not self._isAction and not self._isSharing and event == 2 then
        if self._callback then
            self._callback()
        end
        self:close()
    end
end

function PopupGetVipSkinShow:_createActionNode(effect)
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
function PopupGetVipSkinShow:_huode_tx()
    local image = Path.getTextCommon("txt_sys_skinhuode")
    local sprite = display.newSprite(image)
    return sprite
end

function PopupGetVipSkinShow:_biaoti_tx()
    local cfg = skinConfig.get(self._skinId)
    local TypeConst = require("app.i18n.utils.TypeConst")
    local content = cfg.name
    content = UIHelper.convertToVerticalTxt(content)

    local label = UIHelper.createLabel({text=content,style="challenge_2_ui4",styleType=TypeConst.TEXT})
    label:setAnchorPoint(0.5,1)
    label:getVirtualRenderer():setMaxLineWidth(24)
    label:setPositionY(80)
    local node = cc.Node:create()
    node:addChild(label)
    return node
end

function PopupGetVipSkinShow:_biaotiban_tx()
    local cfg = skinConfig.get(self._skinId)
    local content = cfg.name
    content = UIHelper.convertToVerticalTxt(content)
    local image = UIHelper.createImage({})
    UIHelper.loadCommonBgImageByI18n(image,content)
    image:setAnchorPoint(0.5,1)
    image:setPositionY(115)
    local node = cc.Node:create()
    node:addChild(image)
    return node
end

function PopupGetVipSkinShow:_kanbanniang_tx()
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local itemParams = TypeConvertHelper.convert(TypeConvertHelper.TYPE_POSTER_GIRL_SKIN,self._skinId )
    local image = itemParams.showImg 
    local sprite = display.newSprite(image)
    return sprite
end

function PopupGetVipSkinShow:_xianding_tx()
    local cfg = skinConfig.get(self._skinId)
    if cfg.quality == 0 then
        return cc.Node:create()
    else
        local image = Path.getUICommon("img_skin_quiality_"..cfg.quality)
        local sprite = display.newSprite(image)
        return sprite
    end
end

function PopupGetVipSkinShow:_createAnimation()
    local function effectFunction(effect)
        return self:_createActionNode(effect)    
    end
    local function eventFunction(event)
        if event == "finish" then
            self._isAction = false
        end
    end

    local movingName = "moving_kanbanniang_tx"
    local effect = G_EffectGfxMgr:createPlayMovingGfx( self, movingName, effectFunction, eventFunction , false )
end

function PopupGetVipSkinShow:_createShareLayer()
    local CSHelper = require("yoka.utils.CSHelper")
    local layer = CSHelper.loadResourceNode(Path.getCSB("CommonShareLayer", "common"))
    self._shareLayer = layer
    self._shareLayer:setContentSize( G_ResolutionManager:getDesignCCSize())
    self._shareLayer:setAnchorPoint( cc.p(0.5, 0.5))
    self._shareLayer:setPosition(cc.p(0,0))
    self._shareLayer:updateData()
    self._shareLayer:setShowHideCallback(function(show)
        self._isSharing = not show
    end,self)
    ccui.Helper:doLayout(self._shareLayer)
    self:addChild(layer)
end


function PopupGetVipSkinShow:_addControlNode(node)
    local parentNode = cc.Node:create()
    parentNode:addChild(node)
    parentNode:setLocalZOrder(node:getLocalZOrder())
    parentNode:setName("share_control")
    return parentNode
end


return PopupGetVipSkinShow