local DrawEffectBase = require("app.scene.view.drawCard.DrawEffectBase2")
local DrawOneEffect = class("DrawOneEffect", DrawEffectBase)

local EffectGfxNode = require("app.effect.EffectGfxNode")
local Hero = require("app.config.hero")

function DrawOneEffect:ctor(awards)
    DrawOneEffect.super.ctor(self, awards, DrawEffectBase.DRAW_TYPE_GOLD)
end

function DrawOneEffect:onCreate()
    DrawOneEffect.super.onCreate(self)

    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_BEGIN)
    self:_reset()
    self:_pushCardData(1)
    self:playGuang()
end

function DrawOneEffect:onEnter()
    DrawOneEffect.super.onEnter(self)
end



return DrawOneEffect