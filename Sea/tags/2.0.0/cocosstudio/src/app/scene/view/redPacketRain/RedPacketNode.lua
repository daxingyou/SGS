-- Author: Liangxu
-- Date: 2019-4-12
-- 红包
local ViewBase = require("app.ui.ViewBase")
local RedPacketNode = class("RedPacketNode", ViewBase)
local RedPacketRainConst = require("app.const.RedPacketRainConst")
local AudioConst = require("app.const.AudioConst")

local INFO = {
	[RedPacketRainConst.TYPE_BIG] = {normal = "img_bigbag", open = "img_bigbag_open", effectFront = "effect_hongbaofaguang_up", effectBack = "effect_hongbaofaguang_down"},
	[RedPacketRainConst.TYPE_SMALL] = {normal = "img_small", open = "img_small_open"},
}

function RedPacketNode:ctor(data)
	self._data = data

	local resource = {
		file = Path.getCSB("RedPacketNode", "redPacketRain"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_imageBg = {
				events = {{event = "touch", method = "_onClicked"}}
			},
		}
	}
	RedPacketNode.super.ctor(self, resource)
end

function RedPacketNode:onCreate()
	self._isOpened = false --是否已经打开了
	self:setCascadeOpacityEnabled(true)
	self:_updateUI()
end

function RedPacketNode:onEnter()
	
end

function RedPacketNode:onExit()
	
end

function RedPacketNode:_updateUI()
	local type = self._data:getRedpacket_type()
	local resName = INFO[type].normal
	self._imageBg:loadTexture(Path.getRedBagImg(resName))
	local effectFront = INFO[type].effectFront
	local effectBack = INFO[type].effectBack
	if effectFront then
		G_EffectGfxMgr:createPlayGfx(self._effectFront, effectFront, nil, false)
	end
	if effectBack then
		G_EffectGfxMgr:createPlayGfx(self._effectBack, effectBack, nil, false)
	end
end

function RedPacketNode:_onClicked()
	if self._isOpened then
		return
	end

	if self._data:isReal() then
		G_UserData:getRedPacketRain():c2sGetNewRedPacket(self._data:getId())
	else
		G_SignalManager:dispatch(SignalConst.EVENT_RED_PACKET_RAIN_GET_SUCCESS, self._data:getId())
	end
	G_AudioManager:playSoundWithId(AudioConst.SOUND_RED_PACKAGE_OPEN)
	self:stopAllActions()

	local function effectFunction(effect)
        if effect == "shuzi" then
        	local UIHelper = require("yoka.utils.UIHelper")
        	local money = self._data:getMoney()
            local num = UIHelper.createLabel({text = "+"..money, fontSize = 30, color = Colors.getNumberColor(6), outlineColor = cc.c4b(0xb7, 0x22, 0x09, 0xff)})
            local node = cc.Node:create()
            local gold = cc.Sprite:create(Path.getCommonIcon("vip", "1") )
            gold:setPosition(cc.p(0, 40))
            node:addChild(gold)
            node:addChild(num)
            return node
        end
    		
        return cc.Node:create()
    end

    local function eventFunction(event)
    	if event == "finish" then
            self:_disappear()
        end
    end

    local type = self._data:getRedpacket_type()
	self._imageBg:loadTexture(Path.getRedBagImg(INFO[type].open))
	self._isOpened = true
	if self._data:isReal() then
		G_EffectGfxMgr:createPlayMovingGfx(self, "moving_hongbao_open", effectFunction, eventFunction , true)
	else
		self:_disappear()
	end
end

function RedPacketNode:_disappear()
	self:runAction(cc.Sequence:create(cc.FadeOut:create(0.1), cc.RemoveSelf:create()))
end

return RedPacketNode