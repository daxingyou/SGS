--
-- Author: Liangxu
-- Date: 2018-8-7
-- 武将界限消耗面板

local PopupCommonLimitCost = require("app.ui.PopupCommonLimitCost")
local HeroLimitCostPanel = class("HeroLimitCostPanel", PopupCommonLimitCost)
local CSHelper = require("yoka.utils.CSHelper")
local HeroConst = require("app.const.HeroConst")
local DataConst = require("app.const.DataConst")
local HeroDataHelper = require("app.utils.data.HeroDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local LimitCostConst = require("app.const.LimitCostConst")
local EquipTrainHelper = require("app.scene.view.equipTrain.EquipTrainHelper")

function HeroLimitCostPanel:ctor(costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode)
	HeroLimitCostPanel.super.ctor(self, costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode)
end

function HeroLimitCostPanel:_initView()
	local info = HeroDataHelper.getHeroLimitCostConfig(self._limitLevel)
	if self._costKey == LimitCostConst.LIMIT_COST_KEY_1 then
		local tbPos = {
			[1] = {46, 148},
			[2] = {110, 56},
			[3] = {225, 56},
			[4] = {290, 148}
		}
		for i = 1, 4 do
			local item =
				self:_createMaterialIcon(
				DataConst["ITEM_HERO_LEVELUP_MATERIAL_" .. i],
				info["consume_" .. self._costKey],
				TypeConvertHelper.TYPE_ITEM
			)
			item:setPosition(cc.p(tbPos[i][1], tbPos[i][2]))
		end
	else
		self:_createMaterialIcon(
			info["value_" .. self._costKey],
			info["consume_" .. self._costKey],
			TypeConvertHelper.TYPE_ITEM
		)
	end

	self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
	-- self._panelTouch:setSwallowTouches(false)
	self._panelTouch:addClickEventListener(handler(self, self._onClickPanel)) --避免0.5秒间隔
end

function HeroLimitCostPanel:onEnter()
	self._signalHeroLimitLvPutRes =
		G_SignalManager:add(SignalConst.EVENT_HERO_LIMIT_LV_PUT_RES, handler(self, self._onHeroLimitLvPutRes))
	--确定位置
	local nodePos = self._fromNode:convertToWorldSpaceAR(cc.p(0, 0))
	local dstPos = self:convertToNodeSpace(cc.p(nodePos.x, nodePos.y))
	self._imageBg:setPosition(dstPos)
end

function HeroLimitCostPanel:onExit()
	self._signalHeroLimitLvPutRes:remove()
	self._signalHeroLimitLvPutRes = nil
end

function HeroLimitCostPanel:_onHeroLimitLvPutRes(eventName, costKey)
	if self.updateUI then
		self:updateUI()
	end
end

return HeroLimitCostPanel
