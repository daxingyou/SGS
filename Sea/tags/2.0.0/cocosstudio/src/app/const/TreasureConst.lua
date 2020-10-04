--
-- Author: Liangxu
-- Date: 2017-05-27 15:56:11
-- 宝物常量
local TreasureConst = {}

TreasureConst.FLAG = 2

--宝物显示时获取范围的定义
TreasureConst.TREASURE_RANGE_TYPE_1 = 1 --全范围
TreasureConst.TREASURE_RANGE_TYPE_2 = 2 --阵位上的宝物

--宝物培养方式的定义
TreasureConst.TREASURE_TRAIN_STRENGTHEN = 1 --强化
TreasureConst.TREASURE_TRAIN_REFINE = 2 --精炼
TreasureConst.TREASURE_TRAIN_LIMIT = 3 --界限

--宝物列表显示类型
TreasureConst.TREASURE_LIST_TYPE1 = 1 --宝物
TreasureConst.TREASURE_LIST_TYPE2 = 2 --宝物碎片

--宝物界限消耗物品的Key定义
TreasureConst.TREASURE_LIMIT_COST_KEY_1 = 1
TreasureConst.TREASURE_LIMIT_COST_KEY_2 = 2
TreasureConst.TREASURE_LIMIT_COST_KEY_3 = 3
TreasureConst.TREASURE_LIMIT_COST_KEY_4 = 4

--宝物界限突破等级
TreasureConst.TREASURE_LIMIT_RED_LEVEL = 1 --突界红等级

--强化等级上限额外增加
function TreasureConst.getAddStrLevelByLimit()
	local num = require("app.config.parameter").get(480).content
	return tonumber(num)
end

--精炼等级上限额外增加
function TreasureConst.getAddRefineLevelByLimit()
	local num = require("app.config.parameter").get(481).content
	return tonumber(num)
end

return readOnly(TreasureConst)