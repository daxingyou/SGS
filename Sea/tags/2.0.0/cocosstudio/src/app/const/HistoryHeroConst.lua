local HistoryHeroConst = {}
local FunctionConst	= require("app.const.FunctionConst")


HistoryHeroConst.LIST_TYPE1 = 1 --历代名将
HistoryHeroConst.LIST_TYPE2 = 2 --名将碎片
HistoryHeroConst.LIST_TYPE3 = 3 --武器
HistoryHeroConst.LIST_TYPE4 = 4 --武器碎片

HistoryHeroConst.BREAK_STATE_0    = 0 -- 名将突破：1.不可突破
HistoryHeroConst.BREAK_STATE_1    = 1 -- 名将突破：2.可突破

HistoryHeroConst.TAB_TYPE_HERO    = 0   -- 名将（名将主界面）
HistoryHeroConst.TAB_TYPE_DETAIL  = 1   -- 详情
HistoryHeroConst.TAB_TYPE_AWAKE   = 2   -- 觉醒
HistoryHeroConst.TAB_TYPE_BREAK   = 3   -- 突破
HistoryHeroConst.TAB_TYPE_REBORN  = 4   -- 重生（重生）

HistoryHeroConst.TYPE_EQUIP_0     = 0   -- 更换：1.不存在：Normal 
HistoryHeroConst.TYPE_EQUIP_1     = 1   -- 更换：2.存在：同位置
HistoryHeroConst.TYPE_EQUIP_2     = 2   -- 更换：3.存在：不同位置


HistoryHeroConst.SQUADITEM_WIDTH = 90        -- 上阵坑位宽
HistoryHeroConst.EQUIPVIEW_OFFSETWIDTH = 470 -- 详情/觉醒/突破视窗偏移  

HistoryHeroConst.TYPE_MAINICON = {           -- 名将主界面更右上角图标
    FunctionConst.FUNC_HISTORY_HERO_LIST,
    FunctionConst.FUNC_HISTORY_HEROPIECE_LIST,
}

HistoryHeroConst.TYPE_BREAKTHROUGH_POS_1 = { -- 突破位置：1.一位
    cc.p(299.5, 334)
}

HistoryHeroConst.TYPE_BREAKTHROUGH_POS_2 = { -- 突破位置：2.两位
    cc.p(235.5, 334), cc.p(265.5, 334)
}

HistoryHeroConst.TYPE_BREAKTHROUGH_POS_3 = { -- 突破位置：3.三位
    cc.p(298, 435), cc.p(204, 275.5), cc.p(390, 275.5)
}


return readOnly(HistoryHeroConst)