
-- Author: conley
-- Date:2018-11-23 17:08:06
-- Rebuilt By Panhoa

local ListViewCellBase = require("app.ui.ListViewCellBase")
local HistoryHeroAvatarItemCell = class("HistoryHeroAvatarItemCell", ListViewCellBase)


function HistoryHeroAvatarItemCell:ctor()
	self._heroName   = nil
	self._avatar     = nil
	self._panelTouch = nil
	self._touchCallBackData = {}

	local resource = {
		file = Path.getCSB("HistoryHeroAvatarItemCell", "historyhero"),

	}
	HistoryHeroAvatarItemCell.super.ctor(self, resource)
end

function HistoryHeroAvatarItemCell:onCreate()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
	self._imageAdd:setVisible(false)
	self._imageAdd:setScale(1.5)
	--local UIActionHelper = require("app.utils.UIActionHelper")
	--UIActionHelper.playBlinkEffect(self._imageAdd)
end

-- @Role 	Pick Animation
function HistoryHeroAvatarItemCell:_playHeroPickAnimation(rootNode, data)
	local function effectFunction(effect)
		local EffectGfxNode = require("app.effect.EffectGfxNode")
		if effect == "effect_zm_boom" then
			local subEffect = EffectGfxNode.new("effect_zm_boom")
            subEffect:play()
			return subEffect
		end
    end
    local function eventFunction(event)
		if event == "finish" then
			-- 1: 插入数据要同步
			
		elseif event == "hero" then
			self._avatar:setVisible(true)
			self._avatar:updateUI(data.cfg:getSystem_id())
			self._avatar:setScale(1.5)
			local params = self._avatar:getItemParams()
			self._heroName:setName(params.name)
			self._heroName:setColor(params.icon_color)
        end
	end
	
    G_EffectGfxMgr:createPlayMovingGfx(rootNode, "moving_wuchabiebuzhen_wujiang", effectFunction, eventFunction , false)
end


function HistoryHeroAvatarItemCell:_onSelectTouch(sender, state)
    if state == ccui.TouchEventType.ended or not state then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
        if moveOffsetX < 20 and moveOffsetY < 20 then
			self:dispatchCustomCallback(self._touchCallBackData)
		end
	end
end

-- @Role 	UpdateName
function HistoryHeroAvatarItemCell:updateNameVisible(bVisible)
	self._heroName:setVisible(self._touchCallBackData.id ~= nil and bVisible)
end

-- @Role 	UpdateOpcacity
function HistoryHeroAvatarItemCell:UpdateOpcacity(bEquiped)
	self._avatar:updateOpcacity(bEquiped and 0.4 or 1)
end

-- @Role	GetCellData
function HistoryHeroAvatarItemCell:getCurCellData()
	return self._touchCallBackData
end

-- @Role 	UpdateUI
function HistoryHeroAvatarItemCell:updateUI(data)
	if data == nil then return end
	if data.cfg == nil then
		self._touchCallBackData.id = nil
		self._touchCallBackData.index = data.index
		self._touchCallBackData.state = 2
		self._touchCallBackData.heroId = 0
		self._touchCallBackData.breakthrough = 0
		self._heroName:setVisible(false)
		self._avatar:setVisible(false)
		self._panelTouch:setVisible(false)

		self._imageAdd:setScale(1.5)
		self._imageAdd:setVisible(true)
		self._imageAdd:setEnabled(true)
		self._imageAdd:setSwallowTouches(false)
		self._imageAdd:setTouchEnabled(true)
		self._imageAdd:addClickEventListenerEx(handler(self, self._onSelectTouch))
	else
		self._imageAdd:setVisible(false)
		self._touchCallBackData.id = data.cfg:getId()
		self._touchCallBackData.index = data.index
		self._touchCallBackData.state = 1
		self._touchCallBackData.heroId = data.cfg:getSystem_id()
		self._touchCallBackData.breakthrough = data.cfg:getBreak_through()

		if data.isEquiping then
			self._nodeEffect:removeAllChildren()
			self:_playHeroPickAnimation(self._nodeEffect, data)

		else
			self._avatar:setVisible(true)
			self._avatar:updateUI(data.cfg:getSystem_id())
			self._avatar:setScale(1.5)
			local params = self._avatar:getItemParams()
			self._heroName:setName(params.name)
			self._heroName:setColor(params.icon_color)
		end	
		self:updateNameVisible(data.isGallery)

		self._panelTouch:setVisible(true)
		self._panelTouch:setEnabled(true)
		self._panelTouch:setSwallowTouches(false)
		self._panelTouch:setTouchEnabled(true)
		self._panelTouch:addClickEventListenerEx(handler(self, self._onSelectTouch))
	end
end

return HistoryHeroAvatarItemCell