--
-- Author: Liangxu
-- Date: 2018-8-7
-- 武将界限消耗Node
local CommonLimitCostNode = require("app.ui.component.CommonLimitCostNode")
local HeroLimitCostNode = class("HeroLimitCostNode", CommonLimitCostNode)
local HeroDataHelper = require("app.utils.data.HeroDataHelper")
local HeroConst = require("app.const.HeroConst")
local LimitCostConst = require("app.const.LimitCostConst")

-- local RES_NAME = {
-- 	[HeroConst.HERO_LIMIT_COST_KEY_1] = {
-- 		imageButtom = "img_limit_01",
-- 		imageFront = "img_limit_01b",
-- 		ripple = "green",
-- 		imageName = "txt_limit_01",
-- 		effectBg = "effect_tujiegreen", --背景特效
-- 		moving = "moving_tujieballgreen",
-- 		effectReceive = "effect_tujiedianjigreen", --材料到达后的特效
-- 		effectFull = "effect_tujie_mannenglianggreen", --材料满了的特效
-- 		smoving = "smoving_tujiehuangreen"
-- 	},
-- 	[HeroConst.HERO_LIMIT_COST_KEY_2] = {
-- 		imageButtom = "img_limit_02",
-- 		imageFront = "img_limit_02b",
-- 		ripple = "blue",
-- 		imageName = "txt_limit_02",
-- 		effectBg = "effect_tujieblue",
-- 		moving = "moving_tujieballblue",
-- 		effectReceive = "effect_tujiedianjiblue",
-- 		effectFull = "effect_tujie_mannengliangblue",
-- 		smoving = "smoving_tujiehuanblue"
-- 	},
-- 	[HeroConst.HERO_LIMIT_COST_KEY_3] = {
-- 		imageButtom = "img_limit_03",
-- 		imageFront = "img_limit_03b",
-- 		ripple = "purple",
-- 		imageName = "txt_limit_03",
-- 		effectBg = "effect_tujiepurple",
-- 		moving = "moving_tujieballpurple",
-- 		effectReceive = "effect_tujiedianjipurple",
-- 		effectFull = "effect_tujie_mannengliangpurple",
-- 		smoving = "smoving_tujiehuanpurple"
-- 	},
-- 	[HeroConst.HERO_LIMIT_COST_KEY_4] = {
-- 		imageButtom = "img_limit_04",
-- 		imageFront = "img_limit_04b",
-- 		ripple = "orange",
-- 		imageName = "txt_limit_04",
-- 		effectBg = "effect_tujieorange",
-- 		moving = "moving_tujieballorange",
-- 		effectReceive = "effect_tujiedianjiorange",
-- 		effectFull = "effect_tujie_mannengliangorange",
-- 		smoving = "smoving_tujiehuanorange"
-- 	}
-- }

function HeroLimitCostNode:ctor(target, costKey, callback)
	HeroLimitCostNode.super.ctor(self, target, costKey, callback)
end

function HeroLimitCostNode:_check()
	if self._costKey == HeroConst.HERO_LIMIT_COST_KEY_3 or self._costKey == HeroConst.HERO_LIMIT_COST_KEY_4 then
		self._isShowCount = true
	else
		self._isShowCount = false
	end
end

function HeroLimitCostNode:updateUI(limitLevel, curCount)
	if limitLevel >= 3 then
		self._isFull = false
		self._target:setVisible(false)
		return
	end
	self:_updateCommonUI(limitLevel, curCount)
	self:_adjustPosI18n()
end

function HeroLimitCostNode:_calPercent(limitLevel, curCount)
	local info = HeroDataHelper.getHeroLimitCostConfig(limitLevel)
	local size = info["size_" .. self._costKey] or 0
	local percent = math.floor(curCount / size * 100)
	return math.min(percent, 100), size
end

return HeroLimitCostNode
