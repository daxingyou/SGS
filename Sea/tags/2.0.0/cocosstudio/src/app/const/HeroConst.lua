--
-- Author: Liangxu
-- Date: 2017-05-27 15:51:32
-- 武将常量
local HeroConst = {}

--武将显示时获取范围的定义
HeroConst.HERO_RANGE_TYPE_1 = 1 --全范围
HeroConst.HERO_RANGE_TYPE_2 = 2 --上阵武将

--武将培养方式的定义
HeroConst.HERO_TRAIN_UPGRADE = 1 --升级
HeroConst.HERO_TRAIN_BREAK = 2 --突破
HeroConst.HERO_TRAIN_AWAKE = 3 --觉醒
HeroConst.HERO_TRAIN_LIMIT = 4 --界限

--武将列表显示类型
HeroConst.HERO_LIST_TYPE1 = 1 --武将
HeroConst.HERO_LIST_TYPE2 = 2 --武将碎片

HeroConst.HERO_EXP_TYPE = 3 --狗粮卡

HeroConst.HERO_TRANSFORM_NODE_TYPE_SRC = 1 --武将置换Node类型（被置换武将）
HeroConst.HERO_TRANSFORM_NODE_TYPE_TAR = 2 --武将置换Node类型（目标武将）

--武将界限消耗物品的Key定义
HeroConst.HERO_LIMIT_COST_KEY_1 = 1
HeroConst.HERO_LIMIT_COST_KEY_2 = 2
HeroConst.HERO_LIMIT_COST_KEY_3 = 3
HeroConst.HERO_LIMIT_COST_KEY_4 = 4

--武将界限突破最大等级
HeroConst.HERO_LIMIT_MAX_LEVEL = 3

--羁绊最大数量
HeroConst.HERO_YOKE_MAX = 27

--武将的品质色
HeroConst.HERO_QUALITY_GOLD = 7 --品质7的是金将

HeroConst.HERO_GOLD_MAX_RANK = 5

return readOnly(HeroConst)
