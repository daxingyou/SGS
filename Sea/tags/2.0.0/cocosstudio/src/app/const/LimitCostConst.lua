--界限突破通用组件常量定义
local LimitCostConst = {}

LimitCostConst.HERO_LIMIT_COST = 1 -- 武将界限
LimitCostConst.EQUIPMENT_LIMIT_COST = 2 -- 装备界限

LimitCostConst.BREAK_LIMIT_UP = 0 -- 突破操作

LimitCostConst.LIMIT_COST_KEY_1 = 1 -- 第一类小球
LimitCostConst.LIMIT_COST_KEY_2 = 2 -- 第二类小球
LimitCostConst.LIMIT_COST_KEY_3 = 3 -- 第三类小球
LimitCostConst.LIMIT_COST_KEY_4 = 4 -- 第四类小球

LimitCostConst.LIMIT_UP_HERO = 1 -- 武将界限突破
LimitCostConst.LIMIT_UP_EQUIP = 2 -- 装备界限突破

LimitCostConst.MAX_SUIT_ID = 3001
--i18n change function show
if Lang.checkChannel(Lang.CHANNEL_SEA) then
	-- LimitCostConst.MAX_SUIT_ID = 2001
end

LimitCostConst.RES_NAME = {
	[LimitCostConst.LIMIT_COST_KEY_1] = {
		imageButtom = "img_limit_01",
		imageFront = "img_limit_01b",
		ripple = "green",
		imageName = "txt_limit_01",
		effectBg = "effect_tujiegreen", --背景特效
		moving = "moving_tujieballgreen",
		effectReceive = "effect_tujiedianjigreen", --材料到达后的特效
		effectFull = "effect_tujie_mannenglianggreen", --材料满了的特效
		smoving = "smoving_tujiehuangreen"
	},
	[LimitCostConst.LIMIT_COST_KEY_2] = {
		imageButtom = "img_limit_02",
		imageFront = "img_limit_02b",
		ripple = "blue",
		imageName = "txt_limit_02",
		effectBg = "effect_tujieblue",
		moving = "moving_tujieballblue",
		effectReceive = "effect_tujiedianjiblue",
		effectFull = "effect_tujie_mannengliangblue",
		smoving = "smoving_tujiehuanblue"
	},
	[LimitCostConst.LIMIT_COST_KEY_3] = {
		imageButtom = "img_limit_03",
		imageFront = "img_limit_03b",
		ripple = "purple",
		imageName = "txt_limit_03",
		effectBg = "effect_tujiepurple",
		moving = "moving_tujieballpurple",
		effectReceive = "effect_tujiedianjipurple",
		effectFull = "effect_tujie_mannengliangpurple",
		smoving = "smoving_tujiehuanpurple"
	},
	[LimitCostConst.LIMIT_COST_KEY_4] = {
		imageButtom = "img_limit_04",
		imageFront = "img_limit_04b",
		ripple = "orange",
		imageName = "txt_limit_04",
		effectBg = "effect_tujieorange",
		moving = "moving_tujieballorange",
		effectReceive = "effect_tujiedianjiorange",
		effectFull = "effect_tujie_mannengliangorange",
		smoving = "smoving_tujiehuanorange"
	}
}

LimitCostConst.FRON_RES={
	[LimitCostConst.LIMIT_UP_EQUIP]={
		[1]="",
		[2]="img_limit_02d",
		[3]="img_limit_03d",
		[4]="img_limit_04d",
	}
}

return readOnly(LimitCostConst)
