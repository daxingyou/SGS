local DrawEffectBase = require("app.scene.view.drawCard.DrawEffectBase2")
local DrawNormalEffect = class("DrawNormalEffect", DrawEffectBase)

local EffectGfxNode = require("app.effect.EffectGfxNode")
local Hero = require("app.config.hero")

function DrawNormalEffect:ctor(awards)
    DrawNormalEffect.super.ctor(self, awards, DrawEffectBase.DRAW_TYPE_MONEY)
end

function DrawNormalEffect:onCreate()
    DrawNormalEffect.super.onCreate(self)

    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_BEGIN)
    self:_reset()
    self:_pushCardData(1)
    self:playGuang()
end

function DrawNormalEffect:onEnter()
    DrawNormalEffect.super.onEnter(self)
end

return DrawNormalEffect