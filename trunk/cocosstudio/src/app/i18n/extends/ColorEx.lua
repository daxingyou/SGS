-- cc.exports.Colors					= require("app.utils.Color")
local ColorEx = Colors
local TypeConst = require("app.i18n.utils.TypeConst")

-- 特效样式
ColorEx.EffectStyle =
{
    ["effect_text_5"] = { typeConst = TypeConst.FONT_TITLE, size = 26, outlineSize = 2, color = cc.c3b(0xff, 0xff, 0x44), outlineColor =  cc.c3b(0xf1, 0x88, 0x00)}, --讨伐
    ["effect_text_15_1"] = { typeConst = TypeConst.FONT_TITLE, size = 37, outlineSize = 2, color = cc.c3b(0x64, 0xed, 0x0d), outlineColor =  cc.c3b(0x38, 0x74, 0x07)}, --答题 正确
    ["effect_text_15_2"] = { typeConst = TypeConst.FONT_TITLE, size = 37, outlineSize = 2, color = cc.c3b(0xfb, 0x86, 0x14), outlineColor =  cc.c3b(0x93, 0x37, 0x05)},  --答题 错误
    ["effect_text_16"] = { typeConst = TypeConst.FONT_TITLE, size = 33, outlineSize = 1, color = cc.c3b(0xff, 0xf3, 0x00), outlineColor =  cc.c3b(0xc6, 0x67, 0x28)},  --阵容锁定
    ["effect_text_17"] = { typeConst = TypeConst.FONT_TITLE, size = 44, outlineSize = 3, color = cc.c3b(0xff, 0xeb, 0x2a), outlineColor =  cc.c3b(0x89, 0x21, 0x02)},  --先手
    ["effect_text_20"] = { typeConst = TypeConst.FONT_TITLE, size = 33, outlineSize = 1, color = cc.c3b(0xff, 0xf3, 0x00), outlineColor =  cc.c3b(0xc6, 0x67, 0x28)},  --攻克 寿春、长安等
    ["effect_text_21_1"] = { typeConst = TypeConst.FONT_TITLE, size = 85, outlineSize = 2, color = cc.c3b(0xff, 0xf3, 0x00), outlineColor =  cc.c3b(0xc6, 0x67, 0x28)}, --晋级成功等 黄色
    ["effect_text_21_2"] = { typeConst = TypeConst.FONT_TITLE, size = 85, outlineSize = 2, color = cc.c3b(0xc6, 0x67, 0x28), outlineColor =  cc.c3b(0x89, 0x96, 0xa4)}, --晋级失败等 灰色
    ["effect_text_23"] = { typeConst = TypeConst.FONT_NORMAL, size = 25, outlineSize = 2, color = cc.c3b(0xff, 0xd8, 0x00), outlineColor =  cc.c3b(0x77, 0x29, 0x09)}, --激活合击大招
    ["effect_text_27_1"] = { typeConst = TypeConst.FONT_TITLE, size = 85, outlineSize = 2, color = cc.c3b(0xff, 0xf3, 0x00), outlineColor =  cc.c3b(0xc6, 0x67, 0x28)}, --晋级成功等 黄色
    ["effect_text_27_2"] = { typeConst = TypeConst.FONT_TITLE, size = 85, outlineSize = 2, color = cc.c3b(0xc6, 0x67, 0x28), outlineColor =  cc.c3b(0x89, 0x96, 0xa4)}, --晋级失败等 灰色
    ["effect_text_34"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 0, color = cc.c3b(0x81, 0x47, 0x00), outlineColor =  cc.c3b(0x3c, 0x17, 0x00)},  --解锁天赋
    ["effect_text_36"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xd3, 0x97, 0x29), outlineColor =  cc.c3b(0x3c, 0x17, 0x00)},  --解锁天赋
    ["effect_text_38"] = { typeConst = TypeConst.FONT_TITLE, size = 30, outlineSize = 2, color = cc.c3b(0xff, 0xf7, 0x1f), outlineColor =  cc.c3b(0xc8, 0x62, 0x0d)},  --解锁天赋
    ["effect_text_40"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xf8, 0xbd, 0x45), outlineColor =  cc.c3b(0x57, 0x2c, 0x08)},  --解锁天赋
    ["effect_text_systen"] = { typeConst = TypeConst.FONT_TITLE, size = 58, outlineSize = 3, color = cc.c3b(0xfe, 0xeb, 0x59), outlineColor =  cc.c3b(0xc9, 0x30, 0x0e)},   -- 系统 突破成功
    ["effect_fnt_effect"] = { typeConst = TypeConst.FONT_TITLE, size = 56, outlineSize = 2, color = cc.c3b(0xfb, 0xde, 0x2f), outlineColor =  cc.c3b(0xa4, 0x32, 0x06)},   -- fnt 字体
    ["effect_fnt_newopen"] = { typeConst = TypeConst.FONT_TITLE, size = 54, outlineSize = 2, color = cc.c3b(0xff, 0xe4, 0x41), outlineColor =  cc.c3b(0xcf, 0x58, 0x00)},   -- fnt 开启功能预告


}

-- 文本样式
-- @name res目录中对应功能文件名  有具体对应可以加上功能名 最后以数字结束
-- @data  typeConst 对应类型 size：文字大小 outlineSize：描边大小 color:颜色 outlineColor：描边颜色
ColorEx.TextStyle =
{
    ["skill_ui4"] = { typeConst = TypeConst.FONT_TITLE, size = 28, color = cc.c3b(0xf3, 0xc1, 0x02)},   --技能文本
    ["skill"] = { typeConst = TypeConst.FONT_TITLE, size = 30, outlineSize = 3, color = cc.c3b(0xff, 0xe4, 0x03), outlineColor =  cc.c3b(0x8c, 0x2e, 0x00)},   --技能文本
    ["city"] = { typeConst = TypeConst.FONT_TITLE, size = 46, outlineSize = 3, color = cc.c3b(0xff, 0xf2, 0x66), outlineColor =  cc.c3b(0xa8, 0x54, 0x07)},   --章节文本
    ["talent"] = { typeConst = TypeConst.FONT_TITLE, size = 36, outlineSize = 2, color = cc.c3b(0xff, 0xed, 0x50), outlineColor =  cc.c3b(0x8e, 0x29, 0x00)},   --被动技能文本
    ["big_tab"] = { typeConst = TypeConst.FONT_TITLE, size = 32, outlineSize = 2, color = cc.c3b(0xdf, 0xa7, 0x38), outlineColor =  cc.c3b(0x50, 0x25, 0x09)},   --功能标题文本
    ["activity_limit_1"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 1, color = cc.c3b(0x22, 0xdd, 0xf3), outlineColor =  cc.c3b(0x0c, 0x03, 0x4f)},         --活动夜观星象 蓝字
    ["activity_limit_2"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 1, color = cc.c3b(0xf3, 0xc9, 0x22), outlineColor =  cc.c3b(0x0c, 0x03, 0x4f)},         --活动夜观星象 黄字
    ["challenge_tower_1"] = { typeConst = TypeConst.FONT_NORMAL, size = 22, outlineSize = 2, color = cc.c3b(0xda, 0xff, 0xc1), outlineColor =  cc.c3b(0x39, 0x55, 0x1c)},         --难度 普通
    ["challenge_tower_2"] = { typeConst = TypeConst.FONT_NORMAL, size = 22, outlineSize = 2, color = cc.c3b(0xa9, 0xd3, 0xff), outlineColor =  cc.c3b(0x12, 0x45, 0x7e)},         --难度 困难
    ["challenge_tower_3"] = { typeConst = TypeConst.FONT_NORMAL, size = 22, outlineSize = 2, color = cc.c3b(0xed, 0xae, 0xff), outlineColor =  cc.c3b(0x7b, 0x1f, 0x7e)},         --难度 英雄
    ["challenge_tower_new_1"] = { typeConst = TypeConst.FONT_TITLE, size = 20,  color = cc.c3b(0xee, 0xff, 0xdd)},         --难度 普通
    ["challenge_tower_new_2"] = { typeConst = TypeConst.FONT_TITLE, size = 20,  color = cc.c3b(0xdd, 0xf7, 0xff)},         --难度 困难
    ["challenge_tower_new_3"] = { typeConst = TypeConst.FONT_TITLE, size = 20,  color = cc.c3b(0xf6, 0xdd, 0xff)},         --难度 英雄
    ["text_quality_2"] = { typeConst = TypeConst.FONT_NORMAL, size = 26, outlineSize = 2, color = cc.c3b(0xff, 0xff, 0xe4), outlineColor =  cc.c3b(0x25, 0xb4, 0x05)},   --文本品质 绿
    ["text_quality_3"] = { typeConst = TypeConst.FONT_NORMAL, size = 26, outlineSize = 2, color = cc.c3b(0xff, 0xf8, 0xff), outlineColor =  cc.c3b(0x00, 0x7e, 0xff)},   --文本品质 蓝
    ["text_quality_4"] = { typeConst = TypeConst.FONT_NORMAL, size = 26, outlineSize = 2, color = cc.c3b(0xff, 0xf6, 0xff), outlineColor =  cc.c3b(0xcc, 0x00, 0xff)},   --文本品质 紫
    ["text_quality_5"] = { typeConst = TypeConst.FONT_NORMAL, size = 26, outlineSize = 2, color = cc.c3b(0xff, 0xff, 0xda), outlineColor =  cc.c3b(0xff, 0x85, 0x00)},   --文本品质 橙
    ["text_quality_6"] = { typeConst = TypeConst.FONT_NORMAL, size = 26, outlineSize = 2, color = cc.c3b(0xff, 0xed, 0xda), outlineColor =  cc.c3b(0xff, 0x06, 0x00)},   --文本品质 红
    ["text_quality_7"] = { typeConst = TypeConst.FONT_NORMAL, size = 26, outlineSize = 2, color = cc.c3b(0xff, 0xff, 0xe9), outlineColor =  cc.c3b(0xff, 0xb8, 0x02)},   --文本品质 金
    ["text_status_2"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xb3, 0xff, 0xb1), outlineColor =  cc.c3b(0x33, 0x86, 0x01)},   --文本状态 绿
    ["text_status_3"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xa0, 0xf1, 0xff), outlineColor =  cc.c3b(0x19, 0x6b, 0xd6)},   --文本状态 蓝
    ["text_status_4"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff, 0xbb, 0xf0), outlineColor =  cc.c3b(0x9a, 0x08, 0xb4)},   --文本状态 紫
    ["text_status_5"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff, 0xed, 0x95), outlineColor =  cc.c3b(0xf5, 0x4b, 0x00)},   --文本状态 橙
    ["text_status_6"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff, 0xd5, 0xca), outlineColor =  cc.c3b(0xb1, 0x00, 0x00)},   --文本状态 红
    ["fetter_1"] = { typeConst = TypeConst.FONT_TITLE, size = 27, outlineSize = 0, color = cc.c3b(0xff, 0xfd, 0xea), outlineColor =  cc.c3b(0x70,0xC4,0x05)},   --文本 已激活
    ["runway_1"] = { typeConst = TypeConst.FONT_TITLE, size = 36, outlineSize = 2, color = cc.c3b(0xff, 0xe6, 0x84), outlineColor =  cc.c3b(0xe4, 0x7f, 0x41)},   --文本 华容道 大标题
    ["runway_2"] = { typeConst = TypeConst.FONT_NORMAL, size = 20, outlineSize = 0, color = cc.c3b(0xff, 0xf7, 0xe8), outlineColor =  cc.c3b(0xee, 0x7c, 0x20)},   --文本 华容道 小标题
    ["answer_1"] = { typeConst = TypeConst.FONT_TITLE, size = 37, outlineSize = 2, color = cc.c3b(0x93, 0x37, 0x05), outlineColor =  cc.c3b(0x38, 0x74, 0x07)},   --答题 正确
    ["answer_2"] = { typeConst = TypeConst.FONT_TITLE, size = 37, outlineSize = 2, color = cc.c3b(0xfb, 0x86, 0x14), outlineColor =  cc.c3b(0x93, 0x37, 0x05)},   --答题 错误
    ["notice_1"] = { typeConst = TypeConst.FONT_TITLE, size = 16, outlineSize = 1, color = cc.c3b(0xff, 0xed, 0x52), outlineColor =  cc.c3b(0x94, 0x1f, 0x00)},   --活动 竖标
    ["notice_2"] = { typeConst = TypeConst.FONT_TITLE, size = 16, outlineSize = 1, color = cc.c3b(0xdc, 0xff, 0x51), outlineColor =  cc.c3b(0x57, 0x77, 0x00)},   --公告 竖标
    ["qintomb_1"] = { typeConst = TypeConst.FONT_NORMAL, size = 18, outlineSize = 1, color = cc.c3b(0xfc, 0xe9, 0xcf), outlineColor =  cc.c3b(0xaa, 0x39, 0x2a)},   --先秦皇陵 攻击点
    ["qintomb_2"] = { typeConst = TypeConst.FONT_NORMAL, size = 18, outlineSize = 1, color = cc.c3b(0xdd, 0xf8, 0xff), outlineColor =  cc.c3b(0x2a, 0x45, 0xaa)},   --先秦皇陵 皇陵中
    ["qintomb_3"] = { typeConst = TypeConst.FONT_NORMAL, size = 18, outlineSize = 1, color = cc.c3b(0xff, 0xff, 0xff), outlineColor =  cc.c3b(0x10, 0xa6, 0x61)},   --先秦皇陵 复活点
    ["qintomb_4"] = { typeConst = TypeConst.FONT_NORMAL, size = 24, outlineSize = 2, color = cc.c3b(0xf9, 0xf1, 0xda), outlineColor =  cc.c3b(0x9b, 0x58, 0x34)},   --先秦皇陵 复活点

     --常规字 20号 描边：#662d06  颜色：#ffef4b 天位 地位 人位
     ["qintomb_5"] =  {typeConst = TypeConst.FONT_NORMAL, size =  20, color = cc.c3b(0x66, 0x2d , 0x06), outlineColor = cc.c3b(0xff,0xef,0x4b), outlineSize = 2},

     ["qintomb_6"] = { typeConst = TypeConst.FONT_NORMAL, size = 20, color = cc.c3b(0x60, 0xe5, 0x38)},   ----组队  绿
     ["qintomb_7"] = { typeConst = TypeConst.FONT_NORMAL, size = 20, color = cc.c3b(0xea, 0xb4, 0x10)},   ----组队  黄

    ["common_help_1"] = { typeConst = TypeConst.FONT_TITLE, size = 40, outlineSize = 2, color = cc.c3b(0xa0, 0x6c, 0x49), outlineColor =  cc.c3b(0xfc, 0xf3, 0xe7)},   --帮助  玩法说明
    ["guild_request_help_1"] = { typeConst = TypeConst.FONT_TITLE, size = 32, outlineSize = 2, color = cc.c3b(0xff, 0xae, 0x2f), outlineColor =  cc.c3b(0x85, 0x24, 0x07)},   --军团援助  求援奖励
    ["luxury_gift_1"] = { typeConst = TypeConst.FONT_TITLE, size = 24, outlineSize = 2, color = cc.c3b(0xff, 0xe1, 0x19), outlineColor =  cc.c3b(0xb4, 0x33, 0x00)},   --礼包  1、3、6元礼包
    ["crystal_shop_1"] = { typeConst = TypeConst.FONT_TITLE, size = 36, outlineSize = 2, color = cc.c3b(0xff, 0xe4, 0x00), outlineColor =  cc.c3b(0x94, 0x0e, 0x1e)},   --水晶商店 每日充值领水晶、参与活动领水晶
    ["camp_race_1"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 1, color = cc.c3b(0xff, 0xe9, 0x42), outlineColor =  cc.c3b(0x9f, 0x4a, 0x0c)},   --阵营竞技 魏国预赛排名
    ["camp_race_2"] = { typeConst = TypeConst.FONT_TITLE, size = 38, outlineSize = 2, color = cc.c3b(0xff, 0xff, 0x52), outlineColor =  cc.c3b(0xc2, 0x75, 0x00)},   --阵营竞技 第一场、第二场、决胜场
    ["camp_race_3"] = { typeConst = TypeConst.FONT_TITLE, size = 36, outlineSize = 2, color = cc.c3b(0xff, 0xe2, 0x37), outlineColor =  cc.c3b(0xb2, 0x5c, 0x0d)},   --阵营竞技 报名、 观战
    ["camp_race_4"] = { typeConst = TypeConst.FONT_TITLE, size = 17, outlineSize = 2, color = cc.c3b(0xfc, 0xfa, 0x83), outlineColor =  cc.c3b(0x80, 0x41, 0x20)},   --阵营竞技 战力
    ["camp_race_5"] = { typeConst = TypeConst.FONT_TITLE, size = 38, outlineSize = 2, color = cc.c3b(0xff, 0xff, 0x52), outlineColor =  cc.c3b(0xc2, 0x75, 0x00)},   --阵营竞技 本届冠军
    ["guild_contribution_1"] = { typeConst = TypeConst.FONT_TITLE, size = 35, outlineSize = 2, color = cc.c3b(0x00, 0xc3, 0xe0), outlineColor =  cc.c3b(0x00, 0x09, 0xc3)},   --军团 礼宗庙
    ["guild_contribution_2"] = { typeConst = TypeConst.FONT_TITLE, size = 35, outlineSize = 2, color = cc.c3b(0xfd, 0x3b, 0xff), outlineColor =  cc.c3b(0x85, 0x00, 0xc3)},   --军团 祭地袛
    ["guild_contribution_3"] = { typeConst = TypeConst.FONT_TITLE, size = 35, outlineSize = 2, color = cc.c3b(0xff, 0xff, 0x60), outlineColor =  cc.c3b(0xb8, 0x51, 0x0c)},   --军团 祀天神
    ["guild_dungeon_1"] = { typeConst = TypeConst.FONT_TITLE, size = 18, outlineSize = 1, color = cc.c3b(0xff, 0xfb, 0x79), outlineColor =  cc.c3b(0x80, 0x31, 0x12)},   --军团副本  积分、名次、 出手、 伤害 、体力
    ["guild_dungeon_2"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xff, 0xfb, 0x79), outlineColor =  cc.c3b(0x80, 0x31, 0x12)},   --军团副本  军团名称 、玩家名称
    ["homeland_1"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xf7, 0xc7, 0x06), outlineColor =  cc.c3b(0x91, 0x43, 0x03)},   --神树  1.主公！神树等级已达上限！2.主公！该装饰等级已达上限！
    ["mine_1"] = { typeConst = TypeConst.FONT_TITLE, size = 18, outlineSize = 1, color = cc.c3b(0xff, 0xe7, 0x00), outlineColor =  cc.c3b(0xa6, 0x33, 0x00)},   --矿战  占领
    ["mine_2"] = { typeConst = TypeConst.FONT_TITLE, size = 24, outlineSize = 2, color = cc.c3b(0xff, 0xe5, 0x3b), outlineColor =  cc.c3b(0x9f, 0x4a, 0x0c)},   --矿战  战斗统计 
    ["mine_3"] = { typeConst = TypeConst.FONT_TITLE, size = 30, outlineSize = 2, color = cc.c3b(0xfc, 0xd2, 0x39), outlineColor =  cc.c3b(0x6c, 0x21, 0x00)},   --矿战 前往
    ["mine_4"] = { typeConst = TypeConst.FONT_TITLE, size = 24, outlineSize = 2, color = cc.c3b(0xff, 0xe5 , 0x3b), outlineColor =  cc.c3b(0x9f, 0x4a, 0x0c)},   --矿战 1.兵力2.军团3.疲劳4.玩家5.战力
    
    ["mine_5"] = { typeConst = TypeConst.FONT_TITLE, size = 30, outlineSize = 2, color = cc.c3b(0xfc , 0xd2  , 0x39), outlineColor =  cc.c3b(0x6c  , 0x21  , 0x00   )},   -- 矿战 金色 ——1，2，11，12，22，31 
    ["mine_6"] = { typeConst = TypeConst.FONT_TITLE, size = 30, outlineSize = 2, color = cc.c3b(0xda , 0xe0  , 0xf3 ), outlineColor =  cc.c3b(0x24  , 0x34  , 0x4e   )},   --矿战 银色 ——3，4，5，13，15，23，24，25
    ["mine_7"] = { typeConst = TypeConst.FONT_TITLE, size = 30, outlineSize = 2, color = cc.c3b(0xdf , 0x99  , 0x8a), outlineColor =  cc.c3b(0x2f  , 0x0e  , 0x0a  )},   -- 矿战 铜色 ——6，7，8，9，10，16，17，18，19，20，26，27，28，29,30


    ["stronger_guide_1"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xb3, 0xff, 0xb1), outlineColor = cc.c3b(0x33, 0x86, 0x01)   },   --我要变强 绿
    ["stronger_guide_2"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xa0, 0xf1, 0xff), outlineColor =cc.c3b(0x19, 0x6b, 0xd6)  },   --我要变强 蓝
    ["stronger_guide_3"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff, 0xbb, 0xf0), outlineColor = cc.c3b(0x9a, 0x08, 0xb4) },   --我要变强 紫
    ["stronger_guide_4"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff, 0xed, 0x95), outlineColor = cc.c3b(0xf5, 0x4b, 0x00) },   --我要变强 橙
    ["stronger_guide_5"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff, 0xd5, 0xca),outlineColor = cc.c3b(0xb1, 0x00, 0x00)},   --我要变强 红
    ["common_continue"] = { typeConst = TypeConst.FONT_TITLE, size = 24, color = cc.c3b(0xff, 0xb8, 0x0c)},   --点击屏幕继续
    ["pet_act_1"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 1, color = cc.c3b(0x22, 0xdd, 0xf3), outlineColor =  cc.c3b(0x0c, 0x03, 0x4f)},   --夜观星象，可知“白虎神兽”之行踪 蓝字
    ["pet_act_2"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 1, color = cc.c3b(0xf3 , 0xc9 , 0x22), outlineColor =  cc.c3b(0x0c, 0x03, 0x4f)},   --夜观星象，可知"玄武神兽”之行踪 黄字

    ["team_1"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xf7, 0xc7 , 0x06), outlineColor =  cc.c3b(0x91, 0x43, 0x03)},   --1.主公！该神兽星级已达上限！ 2.神兵进阶等级已达上限，请先去界限突破！
    ["team_2"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xf7, 0xc7 , 0x06), outlineColor =  cc.c3b(0x91, 0x43, 0x03)},   --主公！你已经登峰造极！走上人生巅峰啦！
    ["team_3"] = { typeConst = TypeConst.FONT_TITLE, size = 30, outlineSize = 2, color = cc.c3b(0xff , 0xe6  , 0x51 ), outlineColor =  cc.c3b(0x43 , 0x2a , 0x1b )},   -- 队伍 1.变身卡 2.强化大师 3.更换 4.卸下 5.锦囊 7.一键强化
    ["team_4"] = { typeConst = TypeConst.FONT_NORMAL, size = 15, outlineSize = 2, color = cc.c3b(0xff , 0xe4  , 0x00), outlineColor = cc.c3b(0x6f  , 0x2b  , 0x01  )},   --队伍  6.升星预览
    ["team_5"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xc0  , 0x2a ), outlineColor =  cc.c3b(0x30 , 0x08 , 0x00 )},   --队伍 援军


    ["explore_1"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xd7  , 0x26 ), outlineColor =  cc.c3b(0x77, 0x1f, 0x00)},   --1.夏则资皮，冬则资絺，旱则资舟，水则资车！
    ["explore_2"] = { typeConst = TypeConst.FONT_NORMAL, size = 20, outlineSize = 2, color = cc.c3b(0xff , 0xd5  , 0x47 ), outlineColor =  cc.c3b(0x4a , 0x13 , 0x02 )},   -- 1.半价物资 2.董卓之乱 3.洛阳之乱 4.慕名而来 5.水镜学堂
    ["explore_3"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xc0  , 0x2a ), outlineColor =  cc.c3b(0x30 , 0x08 , 0x00 )},   -- 1.首通宝箱 2.通关宝箱
    ["explore_4"] = { typeConst = TypeConst.FONT_TITLE, size = 24, color = cc.c3b(0x64 , 0x1c  , 0x20 )},   -- 1.讨贼状

    ["reward_1"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xff , 0xe9  , 0x42 ), outlineColor =  cc.c3b(0x9f, 0x4a, 0x0c)},   --1.概率掉落 2.获得奖励4.通关奖励5.首通奖励
    ["reward_2"] = { typeConst = TypeConst.FONT_TITLE, size = 30, outlineSize = 2, color = cc.c3b(0xff , 0xe1  , 0x38 ), outlineColor =  cc.c3b(0xc9 , 0x53 , 0x1a )},   --3.求援奖励

    ["fight_1"] = { typeConst = TypeConst.FONT_TITLE, size = 24, outlineSize = 2, color = cc.c3b(0xf2 , 0xc9  , 0x45 ), outlineColor =  cc.c3b(0x41 , 0x17 , 0x01 )},   --1.回放 2.统计

    ["challenge_1"] = { typeConst = TypeConst.FONT_TITLE, size = 36, outlineSize = 2, color = cc.c3b(0xef , 0xa8  , 0x18 ), outlineColor =  cc.c3b(0x55 , 0x24 , 0x00 )},   --    1.竞技场 2.军团boss 3.日常副本 4.南蛮入侵 5.领地巡逻 6.过关斩将
    ["challenge_2"] = { typeConst = TypeConst.FONT_TITLE, size = 24, outlineSize = 2, color = cc.c3b(0xfb , 0xcf  , 0x31 ), outlineColor =  cc.c3b(0x64 , 0x24 , 0x01 )},   -- 黄色    1.宝物精炼石 2.宝物经验 3.突破丹 4.神兵进阶石 5.神兽经验 6.武将经验 7.银两 8.装备精炼石
    ["challenge_3"] = { typeConst = TypeConst.FONT_TITLE, size = 24, outlineSize = 2, color = cc.c3b(0x95 , 0x79  , 0x5a ), outlineColor =  cc.c3b(0x19 , 0x0e , 0x0e )},   -- 暗色    1.宝物精炼石 2.宝物经验 3.突破丹 4.神兵进阶石 5.神兽经验 6.武将经验 7.银两 8.装备精炼石
    ["challenge_2_ui4"] = { typeConst = TypeConst.FONT_TITLE, size = 22, color = cc.c3b(0xff , 0xfc  , 0xd0 )},   --    1.宝物精炼石 2.宝物经验 3.突破丹 4.神兵进阶石 5.神兽经验 6.武将经验 7.银两 8.装备精炼石
    ["challenge_3_ui4"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0x99 , 0x97  , 0x7d )},   -- 暗色    1.宝物精炼石 2.宝物经验 3.突破丹 4.神兵进阶石 5.神兽经验 6.武将经验 7.银两 8.装备精炼石
    ["challenge_4_ui4"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xe7, 0xe7, 0xe7)},   -- 暗色    日常副本新暗色
    ["guild_1"] = { typeConst = TypeConst.FONT_TITLE, size = 24, outlineSize = 2, color = cc.c3b(0xfb , 0xcf  , 0x31 ), outlineColor =  cc.c3b(0x64 , 0x24 , 0x01 )},   -- 黄色    
    ["guild_2"] = { typeConst = TypeConst.FONT_TITLE, size = 24, outlineSize = 2, color = cc.c3b(0x95 , 0x79  , 0x5a ), outlineColor =  cc.c3b(0x19 , 0x0e , 0x0e )},   -- 暗色   
    ["countryboss_1"] = { typeConst = TypeConst.FONT_NORMAL, size = 18, outlineSize = 2, color = cc.c3b(0xff , 0xd5  , 0x47 ), outlineColor =  cc.c3b(0x93 , 0x33 , 0x09 )},  -- 三国战纪 1.个人积分
    ["countryboss_2"] = { typeConst = TypeConst.FONT_TITLE, size = 18, outlineSize = 2, color = cc.c3b(0xff , 0xdf  , 0x2c ), outlineColor =  cc.c3b(0xc0 , 0x33 , 0x0b )},   -- 三国战纪 3. 奖励 4.积分排名    
    ["countryboss_3"] = { typeConst = TypeConst.FONT_TITLE, size = 46, outlineSize = 3, color = cc.c3b(0xff , 0xc0  , 0x35 ), outlineColor =  cc.c3b(0xbf , 0x34 , 0x0b )},   -- 三国战纪 7.拦截 9.讨伐  
    ["countryboss_4"] = { typeConst = TypeConst.FONT_TITLE, size = 46, outlineSize = 3, color = cc.c3b(0xff , 0xff  , 0x5e ), outlineColor =  cc.c3b(0xb8 , 0x4c , 0x04 )},   -- 三国战纪 8.掠夺 10.挑战
    ["create_role_1"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xc0  , 0x2a ), outlineColor =  cc.c3b(0x30  , 0x08  , 0x00  )},   -- 创角 创建角色
  

    ["season_sport_1"] = { typeConst = TypeConst.FONT_NORMAL, size = 20, outlineSize = 2, color = cc.c3b(0x8f , 0x4b  , 0x02 ), outlineColor =  cc.c3b(0xff  , 0xdd  , 0x2f  )},   -- 阵营竞技  等待匹配
    ["season_sport_2"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xc0  , 0x2a ), outlineColor =  cc.c3b(0x30  , 0x08  , 0x00  )},   -- 阵营竞技  神兽



    ["guild_war_3"] = { typeConst = TypeConst.FONT_TITLE, size = 30, outlineSize = 2, color = cc.c3b(0xfc , 0xd2  , 0x39 ), outlineColor =  cc.c3b(0x6c  , 0x21  , 0x00  )},   -- 军团战  金色
    ["guild_war_2"] = { typeConst = TypeConst.FONT_TITLE, size = 30, outlineSize = 2, color = cc.c3b(0xda , 0xe0  , 0xf3 ), outlineColor =  cc.c3b(0x24  , 0x34  , 0x4e  )},   -- 军团战  银色
    ["guild_war_1"] = { typeConst = TypeConst.FONT_TITLE, size = 30, outlineSize = 2, color = cc.c3b(0xdf , 0x99  , 0x8a ), outlineColor =  cc.c3b(0x2f  , 0x0e  , 0x0a  )},   -- 军团战  铜色


    ["horse_1"] = { typeConst = TypeConst.FONT_TITLE, size = 24, outlineSize = 2, color = cc.c3b(0xfb , 0xcf  , 0x31 ), outlineColor =  cc.c3b(0x64  , 0x24  , 0x01  )},   -- 战马  黄色
    

    ["limit_1"] = { typeConst = TypeConst.FONT_NORMAL, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xdd  , 0x00 ), outlineColor =  cc.c3b(0x7c  , 0x39  , 0x00  )},   -- 界限突破 1.左传 2.论语 3.春秋 4.战国
    ["limit_2"] = { typeConst = TypeConst.FONT_NORMAL, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xdd  , 0x00 ), outlineColor =  cc.c3b(0x7c  , 0x39  , 0x00  )},   -- 界限突破 突破至界3解锁新形象红将



    ["sign_1"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xe3 , 0xff  , 0xd9 ), outlineColor =  cc.c3b(0x42  , 0xa0  , 0x20  )},   -- 标签 1.已激活 3.已达成 5.已领取
    ["sign_2"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xfd , 0xda  , 0xd0 ), outlineColor =  cc.c3b(0xb0  , 0x00  , 0x00  )},   -- 标签 2.已击杀 4.未达成


    ["signet_1"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xfd , 0xda  , 0xd0 ), outlineColor =  cc.c3b(0xb0  , 0x00  , 0x00  )},   -- 标签 3.未开启
    ["signet_2"] = { typeConst = TypeConst.FONT_TITLE, size = 17, outlineSize = 2, color = cc.c3b(0xfd , 0xda  , 0xd0 ), outlineColor =  cc.c3b(0xb0  , 0x00  , 0x00  )},   -- 标签 4.已宣战
    ["signet_3"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xbf , 0xff  , 0x64 ), outlineColor =  cc.c3b(0x2f  , 0x99  , 0x03  )},   -- 标签 1.已支持 6.已预约
    ["signet_4"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xe3 , 0xff  , 0xd9 ), outlineColor =  cc.c3b(0x42  , 0xa0  , 0x20  )},   -- 标签 2.已邀请 5.已发送
    ["signet_5"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xe3 , 0xff  , 0xd9 ), outlineColor =  cc.c3b(0x42  , 0xa0  , 0x20  )},   -- 标签 1.我已完成 7.已祭祀 8.已开启 9.已领取
    ["signet_6"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xc0  , 0xff   , 0x64  ), outlineColor =  cc.c3b(0x0d  , 0x7b  , 0x00  )},   -- 标签 2.已报名 4.已分享 5.已购买 6.已结束
    ["signet_7"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xfd , 0xda  , 0xd0 ), outlineColor =  cc.c3b(0xb0  , 0x00  , 0x00  )},   -- 标签 3.已超时
    ["signet_8"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xe3 , 0xff  , 0xd9), outlineColor =  cc.c3b(0x42  , 0xa0  , 0x20   )},   -- 标签 1.已申请 3.已通关 5.已投票 9.已领取 （有两个绿色） 10.已赠送 11.已完成
    ["signet_9"] = { typeConst = TypeConst.FONT_TITLE, size = 19, outlineSize = 2, color = cc.c3b(0xc0   , 0xff    , 0x64 ), outlineColor =  cc.c3b(0x0d   , 0x7b   , 0x00    )},   -- 标签 6.已预约 8.已击杀
    ["signet_10"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xbf , 0xff  , 0x64), outlineColor =  cc.c3b(0x2f  , 0x99  , 0x03  )},   -- 标签 2.今日已挑战 4.今日已通关


    ["chat_1"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xff , 0xc0  , 0x2a), outlineColor =  cc.c3b(0x30  , 0x08  , 0x00  )},   -- 聊天 1.军 2.世



     ["countryboss_5"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xfb , 0xcf  , 0x31), outlineColor =  cc.c3b(0x64   , 0x24 ,0x01  )},   -- 三国战纪 黄色
     ["countryboss_6"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xff , 0x4b  , 0x27), outlineColor =  cc.c3b(0x5d  , 0x12  , 0x00  )},   -- 三国战纪 红色
     ["countryboss_7"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0x97 , 0x0c  , 0x0c), outlineColor =  cc.c3b(0x4f  , 0x15  , 0x00  )},   -- 三国战纪 暗红



    ["icon_txt_1"] = { typeConst = TypeConst.FONT_NORMAL, size = 18, outlineSize = 2, color = cc.c3b(0xe4 , 0xd7  , 0x00), outlineColor =  cc.c3b(0x97  , 0x35  , 0x00  )},  --function_level 1
    ["icon_txt_2"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xff , 0xe4  , 0x00), outlineColor =  cc.c3b(0x6f  , 0x2b  , 0x01  )},   -- function_level 2
    ["icon_txt_3"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xc0  , 0x2a), outlineColor =  cc.c3b(0x30  , 0x08  , 0x00  )},   -- function_level 3
    ["icon_txt_4"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xe5  , 0x3b), outlineColor =  cc.c3b(0x7f  , 0x2d  , 0x00  )},   -- function_level 4
    ["icon_txt_5"] = { typeConst = TypeConst.FONT_TITLE, size = 24, outlineSize = 2, color = cc.c3b(0xff , 0xe5  , 0x3b), outlineColor =  cc.c3b(0x7f  , 0x2d  , 0x00  )},   -- function_level 5
    ["icon_txt_20"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xff , 0xe4  , 0x00), outlineColor =  cc.c3b(0x6f  , 0x2b  , 0x01  )},   -- function_level 20 tw
    ["icon_txt_30"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xc0  , 0x2a), outlineColor =  cc.c3b(0x30  , 0x08  , 0x00  )},   -- function_level 30 tw
    ["icon_txt_3_ui4"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xc0  , 0x2a), outlineColor =  cc.c3b(0x9a  , 0x50  , 0x14  )},   -- function_level 3

    ["icon_txt_50"] = { typeConst = TypeConst.FONT_NORMAL, size = 18, outlineSize = 2, color = cc.c3b(0xff , 0xe4  , 0x00), outlineColor =  cc.c3b(0x6f  , 0x2b  , 0x01  )},   -- function_level 50 sea
    ["icon_txt_60"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xff , 0xc0  , 0x2a), outlineColor =  cc.c3b(0x30  , 0x08  , 0x00  )},   -- function_level 60 sea
    ["icon_txt_70"] = { typeConst = TypeConst.FONT_NORMAL, size = 19, outlineSize = 2, color = cc.c3b(0xff , 0xe4  , 0x00), outlineColor =  cc.c3b(0x6f  , 0x2b  , 0x01  )},   -- function_level 70 sea
    ["icon_txt_80"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xc0  , 0x2a), outlineColor =  cc.c3b(0x30  , 0x08  , 0x00  )},   -- function_level 80 sea

               
    ["chapter_1"] = { typeConst = TypeConst.FONT_TITLE, size = 18, outlineSize = 1, color = cc.c3b(0xff , 0xf3  , 0x55), outlineColor =  cc.c3b(0x7a  , 0x28  , 0x01  )},   -- 章节 名将传记 收回

    ["homeland_1"] = { typeConst = TypeConst.FONT_TITLE, size = 24, outlineSize = 2, color = cc.c3b(0xfb , 0xcf  , 0x31), outlineColor =  cc.c3b(0x64  , 0x24  , 0x01  )},   -- 家园 1.翠竹林 2.露坛 3.九天瑶池 4.赤灵芝 5.翠竹林 6.玲珑玉玦 7.九华灯
    ["homeland_2"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 1, color = cc.c3b(0xff , 0xe5  , 0x3b), outlineColor =  cc.c3b(0x7f  , 0x2d  , 0x00  )},   -- 家园 军团成员
    ["homeland_3"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 1, color = cc.c3b(0xff , 0xe5  , 0x3b), outlineColor =  cc.c3b(0x7f  , 0x2d  , 0x00  )},   -- 家园 军团成员


     ["homeland_tree_1"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0x78 , 0xff  , 0x13), outlineColor =  cc.c3b(0x14  , 0x63  , 0x09  )},   -- 家园 神树1阶
     ["homeland_tree_2"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0x32 , 0xd6  , 0xff), outlineColor =  cc.c3b(0x00  , 0x48  , 0xa9  )},   -- 家园 神树2阶
     ["homeland_tree_3"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0x00 , 0x84  , 0xff), outlineColor =  cc.c3b(0x00  , 0x2d  , 0x77  )},   -- 家园 神树3阶
     ["homeland_tree_4"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xff , 0x88  , 0xd6), outlineColor =  cc.c3b(0x76  , 0x00  , 0x48  )},   -- 家园 神树4阶
     ["homeland_tree_5"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xef , 0x2b  , 0xef), outlineColor =  cc.c3b(0x74  , 0x00  , 0x77  )},   -- 家园 神树5阶
     ["homeland_tree_6"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xcb , 0x32  , 0xff), outlineColor =  cc.c3b(0x43  , 0x00  , 0x9e  )},   -- 家园 神树6阶
     ["homeland_tree_7"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xff , 0xec  , 0x1c), outlineColor =  cc.c3b(0x9e  , 0x52  , 0x00  )},   -- 家园 神树7阶
     ["homeland_tree_8"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xff , 0xae  , 0x00), outlineColor =  cc.c3b(0x90  , 0x3a  , 0x00  )},   -- 家园 神树8阶
     ["homeland_tree_9"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xff , 0x7b  , 0x11), outlineColor =  cc.c3b(0x76  , 0x27  , 0x00  )},   -- 家园 神树9阶
     ["homeland_tree_10"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xff , 0x70  , 0x4a), outlineColor =  cc.c3b(0x8e  , 0x1e  , 0x00  )},   -- 家园 神树10阶
     ["homeland_tree_11"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xff , 0x00  , 0x00), outlineColor =  cc.c3b(0x7e  , 0x12  , 0x00  )},   -- 家园 神树11阶
     ["homeland_tree_12"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xff , 0xaa  , 0xae), outlineColor =  cc.c3b(0xa7  , 0x0e  , 0x0f  )},   -- 家园 神树12阶  
     ["homeland_tree_13"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xf4 , 0xf4  , 0x80), outlineColor =  cc.c3b(0xee  , 0x5b  , 0x26  )},   -- 家园 神树13阶   
     ["homeland_tree_ui4_1"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xbc , 0xff  , 0x5b), outlineColor =  cc.c3b(0x37  , 0x89  , 0x17  )},   -- 家园 神树1阶
     ["homeland_tree_ui4_2"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0x0e , 0xfe  , 0xff), outlineColor =  cc.c3b(0x25  , 0x75  , 0xc1  )},   -- 家园 神树2阶
     ["homeland_tree_ui4_3"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0x1a , 0xe4  , 0xff), outlineColor =  cc.c3b(0x28  , 0x5c  , 0xc5  )},   -- 家园 神树3阶
     ["homeland_tree_ui4_4"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xa0  , 0xf7), outlineColor =  cc.c3b(0xcf  , 0x27  , 0xa7  )},   -- 家园 神树4阶
     ["homeland_tree_ui4_5"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xee , 0xa8  , 0xff), outlineColor =  cc.c3b(0xb6  , 0x17  , 0xbc  )},   -- 家园 神树5阶
     ["homeland_tree_ui4_6"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color =  cc.c3b(0xe5  , 0xa0  , 0xff  ), outlineColor =  cc.c3b(0x83  , 0x31  , 0xc8  )},   -- 家园 神树6阶
     ["homeland_tree_ui4_7"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xff  , 0x17), outlineColor =  cc.c3b(0xa6  , 0x6b  , 0x00  )},   -- 家园 神树7阶
     ["homeland_tree_ui4_8"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xe3  , 0x00), outlineColor =  cc.c3b(0xcc  , 0x74  , 0x2a  )},   -- 家园 神树8阶
     ["homeland_tree_ui4_9"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xb0  , 0x00), outlineColor =  cc.c3b(0xbc  , 0x43  , 0x00  )},   -- 家园 神树9阶
     ["homeland_tree_ui4_10"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0x6f  , 0x80), outlineColor =  cc.c3b(0xa2  , 0x09  , 0x26  )},   -- 家园 神树10阶
     ["homeland_tree_ui4_11"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0x60  , 0x5b), outlineColor =  cc.c3b(0xb6  , 0x26  , 0x24  )},   -- 家园 神树11阶
     ["homeland_tree_ui4_12"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xfe , 0x4c  , 0x48), outlineColor =  cc.c3b(0xa8  , 0x18  , 0x00  )},   -- 家园 神树12阶  
     ["homeland_tree_ui4_13"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0x56  , 0x2d), outlineColor =  cc.c3b(0xb8  , 0x24  , 0x00  )},   -- 家园 神树13阶 
 
     
     ["homeland_4"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0x90, 0xff  , 0x14), outlineColor =  cc.c3b(0x0e  , 0x47  , 0x03  )},   -- 家园 绿色 拜访 返回 
     ["homeland_5"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 1, color = cc.c3b(0xff , 0xdb  , 0x3d), outlineColor =  cc.c3b(0x70  , 0x3d  , 0x13  )},   -- 家园 黄色 拜访 返回 
     
     
     ["fetter_1"] = { typeConst = TypeConst.FONT_TITLE, size = 27, color = cc.c3b(0xff , 0xff  , 0xff)  },   -- 已激活
     
     
     ["season_sport_3"] = { typeConst = TypeConst.FONT_TITLE, size = 42 ,color = cc.c3b(0xff , 0xfc  , 0xe6 )},   -- 无差别竞技  亮 开始匹配
     ["season_sport_4"] = { typeConst = TypeConst.FONT_TITLE, size = 42,color = cc.c3b(0xd9 , 0xd6  , 0xc4 )},   -- 无差别竞技  暗 开始匹配
     
     ["system_1"] = { typeConst = TypeConst.FONT_TITLE, size = 58, outlineSize = 3, color = cc.c3b(0xfe , 0xeb  , 0x59), outlineColor =  cc.c3b(0xc9  , 0x30  , 0x0e  )},   -- 系统 恭喜获得、升级啦等
     ["system_2"] = { typeConst = TypeConst.FONT_TITLE, size = 24, outlineSize = 1, color = cc.c3b(0xfe , 0xeb  , 0x59), outlineColor =  cc.c3b(0xc9  , 0x30  , 0x0e  )},   -- 系统 战斗、立绘等

     ["system_3"] = { typeConst = TypeConst.FONT_NORMAL, size = 22, outlineSize = 2, color = cc.c3b(0xef , 0xd8  , 0xa7), outlineColor =  cc.c3b(0x69  , 0x30  , 0x1c  )},   -- 系统 弹幕关
     ["system_4"] = { typeConst = TypeConst.FONT_NORMAL, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xed  , 0x9a), outlineColor =  cc.c3b(0x82  , 0x34  , 0x00  )},   -- 系统 弹幕开

     ["system_5"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xfe , 0xbd  , 0x10), outlineColor =  cc.c3b(0x67  , 0x1b  , 0x00  )},   -- 系统 神兵
     ["system_6"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xd7  , 0x49), outlineColor =  cc.c3b(0x97  , 0x34  , 0x03  )},   -- 系统 立绘，战斗
     ["system_7"] = { typeConst = TypeConst.FONT_TITLE, size = 18, outlineSize = 2, color = cc.c3b(0xff , 0xc0  , 0x2a), outlineColor =  cc.c3b(0x30  , 0x08  , 0x00  )},   -- 系统  军，世


    ["signet_11"] = { typeConst = TypeConst.FONT_TITLE, size = 18, outlineSize = 2, color = cc.c3b(0xc8 , 0xff  , 0xec), outlineColor =  cc.c3b(0x00  , 0x62  , 0x3f  )},   -- 标签  1.名将册 2.已求助
    ["signet_12"] = { typeConst = TypeConst.FONT_TITLE, size = 18, outlineSize = 2, color = cc.c3b(0xd2 , 0xff  , 0xfe), outlineColor =  cc.c3b(0x00  , 0x64  , 0x7a  )},   -- 标签  3.巡逻中



    ["sign_3"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xf7 , 0xdf  , 0xdf ), outlineColor =  cc.c3b(0x94  , 0x25  , 0x20  )},   -- 标签 红色
    ["sign_4"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xbd , 0xf3  , 0xe1 ), outlineColor =  cc.c3b(0x01  , 0x67  , 0x42  )},   -- 标签 蓝色+绿色 


    ["ranking_1"] = { typeConst = TypeConst.FONT_TITLE, size = 30, outlineSize = 2, color = cc.c3b(0xde , 0xde  , 0xe4 ), outlineColor =  cc.c3b(0x29  , 0x29  , 0x3b  )},   -- 标签 失败
    ["ranking_2"] = { typeConst = TypeConst.FONT_TITLE, size = 30, outlineSize = 2, color = cc.c3b(0xfa , 0xd4  , 0x5f ), outlineColor =  cc.c3b(0xd6  , 0x52  , 0x01  )},   -- 标签 胜利

    
    ["activity_limit_3"] = { typeConst = TypeConst.FONT_TITLE, size = 41, outlineSize = 4, color = cc.c3b(0xe1 , 0xe9  , 0xf5 ), outlineColor =  cc.c3b(0x8b  , 0x02  , 0xc8  )},   -- 限时活动 活动剩余 紫色
    ["activity_limit_4"] = { typeConst = TypeConst.FONT_TITLE, size = 35,  color = cc.c3b(0xff , 0xf2  , 0x93 )},   -- 限时活动 活动剩余 金色



    ["fund_1"] = { typeConst = TypeConst.FONT_TITLE, size = 42,   outlineSize = 2, color = cc.c3b(0xfe , 0xe9  , 0x45 ), outlineColor =  cc.c3b(0xb4  , 0x30  , 0x07  )},   -- 基金 已购买人数
    ["fund_2"] = { typeConst = TypeConst.FONT_TITLE, size = 40, color = cc.c3b(0xf7 , 0xe9  , 0x81 )},   -- 基金 第几期

    ["login_1"] = { typeConst = TypeConst.FONT_TITLE, size = 22,   outlineSize = 2, color = cc.c3b(0xff , 0xc0  , 0x2a ), outlineColor =  cc.c3b(0x30  , 0x08  , 0x00  )},   -- 登陆 公告 注销账号


    ["avatar_1"] = { typeConst = TypeConst.FONT_TITLE, size =  18,   outlineSize = 2, color = cc.c3b(0xff , 0xe8  , 0xbb ), outlineColor =  cc.c3b(0xdb  , 0x86  , 0x00  )},   -- 变身卡 装备中


   
    ["chatper_game_name_1"] = { typeConst = TypeConst.FONT_TITLE, size =  38,   outlineSize = 2, color = cc.c3b(0xff , 0xad  , 0x39 ), outlineColor =  cc.c3b(0x6d  , 0x2f , 0x0c   )},   
    

    ["pay_1"] = {typeConst = TypeConst.FONT_TITLE, size =  24, color = cc.c3b(0xff, 0xf3  , 0x99 ), outlineColor = cc.c3b(0xe5,0x07,0x07), outlineSize = 2}, 
    ["pay_2"] =  {typeConst = TypeConst.FONT_TITLE, size =  24, color = cc.c3b(0xff, 0xc8  , 0x29 ), outlineColor = cc.c3b(0xbe,0x3f,0x00), outlineSize = 2}, 
    ["pay_3"] =  {typeConst = TypeConst.FONT_TITLE, size =  22, color = cc.c3b(0xf8, 0xcc , 0x45 ), outlineColor = cc.c3b(0xa1,0x40,0x00), outlineSize = 2}, 
    ["pay_4"] = {typeConst = TypeConst.FONT_TITLE, size =  24, color = cc.c3b(0xB6, 0x65, 0x11 ), outlineColor = cc.c3b(0xe5,0x07,0x07), outlineSize = 2},

    ["carnival_1"] =  {typeConst = TypeConst.FONT_TITLE, size =  26, color = cc.c3b(0xf2, 0x55 , 0x00 ), outlineColor = cc.c3b(0xff,0xef,0xc0), outlineSize = 2}, 


    ["month_card_2"] =  {typeConst = TypeConst.FONT_TITLE, size =  30, color = cc.c3b(0xf9, 0x98 , 0x20 ) }, --月卡
    ["month_card_1"] =  {typeConst = TypeConst.FONT_TITLE, size =  30, color = cc.c3b(0xd4, 0x62 , 0xfe)}, --周卡
    ["luxuru_gift_pkg_alert"] =  {typeConst = TypeConst.FONT_NORMAL, size =  16, color = cc.c3b(0xd4, 0x73 , 0x2b)}, --豪华礼包警告



    ["single_race_1"] =  {typeConst = TypeConst.FONT_TITLE, size =  65, color = cc.c3b(0xfe, 0xe8 , 0x52),outlineColor = cc.c3b(0xf5,0x90,0x18), outlineSize = 2}, --16强赛开始
    ["single_race_2"] =  {typeConst = TypeConst.FONT_TITLE, size =  30, color = cc.c3b(0xfd, 0xe0 , 0x3c),outlineColor = cc.c3b(0x9e,0x37,0x00), outlineSize = 2}, --阵容总战力
    ["single_race_3"] =  {typeConst = TypeConst.FONT_TITLE, size =  36, color = cc.c3b(0xff, 0xff , 0x38),outlineColor = cc.c3b(0xc2,0x78,0x00), outlineSize = 2}, --第三场，第四场
    ["single_race_4"] =  {typeConst = TypeConst.FONT_NORMAL, size =  18, color = cc.c3b(0xff, 0xf8 , 0x75),outlineColor = cc.c3b(0x9f,0x48,0x24), outlineSize = 2}, --积分排名


    
    ["img_fight_01"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xf2 , 0xf0  , 0xf8), outlineColor =  cc.c3b(0x26  , 0x42  , 0x9f  )},   -- 标签  “+8赛区”
    ["img_fight_02"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xf3  , 0xcc), outlineColor =  cc.c3b(0xcf  , 0x5f  , 0x09  )},   -- 标签  “+10赛区”
    ["img_fight_03"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 2, color = cc.c3b(0xfb , 0xcc  , 0x2c), outlineColor =  cc.c3b(0xaf  , 0x00  , 0x01  )},   -- 标签  “+12赛区”



    ["activity_limit_5"] = {typeConst = TypeConst.FONT_TITLE,size = 30,color = cc.c3b(0xff,0xc2,0x25),outlineColor = cc.c3b(0xa6,0x20,0x21),outlineSize = 2},-- 限时活动 周基金 天数
    ["daily_challenge_1"] = {typeConst = TypeConst.FONT_TITLE,size = 40,color = cc.c3b(0xe6,0xba,0xa7),outlineColor = cc.c3b(0x8d,0x53,0x47),outlineSize = 2},-- 难度1
    ["daily_challenge_2"] = {typeConst = TypeConst.FONT_TITLE,size = 40,color = cc.c3b(0xa7,0xed,0x89),outlineColor = cc.c3b(0x48,0x94,0x49),outlineSize = 2},-- 难度2
    ["daily_challenge_3"] = {typeConst = TypeConst.FONT_TITLE,size = 40,color = cc.c3b(0x7a,0xce,0xf6),outlineColor = cc.c3b(0x33,0x62,0xc6),outlineSize = 2},-- 难度3
    ["daily_challenge_4"] = {typeConst = TypeConst.FONT_TITLE,size = 40,color = cc.c3b(0xe3,0xa7,0xe0),outlineColor = cc.c3b(0x89,0x3d,0xa1),outlineSize = 2},-- 难度4
    ["daily_challenge_5"] = {typeConst = TypeConst.FONT_TITLE,size = 40,color = cc.c3b(0xff,0xf4,0x8b),outlineColor = cc.c3b(0xc6,0x83,0x45),outlineSize = 2},-- 难度5
    ["daily_challenge_6"] = {typeConst = TypeConst.FONT_TITLE,size = 40,color = cc.c3b(0xf7,0xe8,0xb3),outlineColor = cc.c3b(0xde,0x89,0x46),outlineSize = 2},-- 难度6
    ["daily_challenge_7"] = {typeConst = TypeConst.FONT_TITLE,size = 40,color = cc.c3b(0xf5,0xf3,0xa0),outlineColor = cc.c3b(0xdb,0x55,0x31),outlineSize = 2},-- 难度7
    ["daily_challenge_8"] = {typeConst = TypeConst.FONT_TITLE,size = 40,color = cc.c3b(0xff,0xff,0xbf),outlineColor = cc.c3b(0xd7,0x43,0x43),outlineSize = 2},-- 难度8
    ["mine_privilege_1"] = {typeConst = TypeConst.FONT_TITLE,size = 26,color = cc.c3b(0xff,0xd4,0x27),outlineColor = cc.c3b(0xca,0x47,0x00),outlineSize = 2},-- 贵族5可购买
    ["text_anniversary_1"] = {typeConst = TypeConst.FONT_NORMAL,size = 20,color = cc.c3b(0xf6,0xce,0x61)},-- 本服排名前3的军团，可参与跨服庆典！
    ["text_anniversary_2"] = {typeConst = TypeConst.FONT_NORMAL,size = 20,color = cc.c3b(0xf4,0xd8,0x97),outlineColor = cc.c3b(0xbe,0x4f,0x16),outlineSize = 1},-- 长按可连续捐献
    ["camp_race_6"] = {typeConst = TypeConst.FONT_TITLE,size = 22,color = cc.c3b(0xff,0xe4,0x52), outlineColor =  cc.c3b(0xa5,0x65,0x0e), outlineSize = 1},   --阵营竞技 竞猜
    ["text_challenge_1"] = {typeConst = TypeConst.FONT_TITLE,size = 22,color = cc.c3b(0xff,0xc6,0x28)},   -- 奖励
    ["text_essence_1"] = {typeConst = TypeConst.FONT_TITLE,size = 24,color = cc.c3b(0xe8,0x69,0x42)},   -- 通关奖励
    ["text_explore_1"] = {typeConst = TypeConst.FONT_TITLE,size = 24,color = cc.c3b(0xff,0xaf,0x20),outlineColor = cc.c3b(0xff,0xfa,0xe5),outlineSize = 2},   -- 5折出售
    ["text_gold_hero_1"] = {typeConst = TypeConst.FONT_TITLE,size = 20,color = cc.c3b(0xff,0xea,0x44),outlineColor = cc.c3b(0xd0,0x3e,0x15),outlineSize = 1},   -- 欢乐抽奖
    ["text_gold_hero_2"] = {typeConst = TypeConst.FONT_TITLE,size = 20,color = cc.c3b(0xff,0xea,0x44),outlineColor = cc.c3b(0xd0,0x3e,0x15),outlineSize = 1},   -- 下轮抽奖
    ["text_gold_hero_3"] = {typeConst = TypeConst.FONT_NORMAL,size = 22,color = cc.c3b(0xff,0xef,0x4c)},   -- 参与条件：每轮使用一次付费道具抽将
    ["text_gold_hero_4"] = {typeConst = TypeConst.FONT_NORMAL,size = 22,color = cc.c3b(0xff,0xef,0x4c)},   -- 参与条件：进行一次招募
    ["text_gold_hero_5"] = {typeConst = TypeConst.FONT_NORMAL,size = 28,color = cc.c3b(0xff,0xef,0x4c)},   -- 恭喜主公！你获奖啦！
    ["text_gold_hero_6"] = {typeConst = TypeConst.FONT_NORMAL,size = 28,color = cc.c3b(0xdd,0xdd,0xdd)},   -- 很遗憾！主公你未中奖！
    ["text_individual_competitive_1"] = {typeConst = TypeConst.FONT_TITLE,size = 22,color = cc.c3b(0xff,0xc8,0x29),outlineColor = cc.c3b(0x9f,0x52,0x0d),outlineSize = 1},   --竞猜
    ["text_limit_1"] = {typeConst = TypeConst.FONT_NORMAL,size = 20,color = cc.c3b(0xff,0xff,0x00),outlineColor = cc.c3b(0x9f,0x52,0x0d),outlineSize = 1},   --修身，齐家，治国，南华，水镜，点击涅槃，子上，周姬，楚辞，周易，礼记，汉书
    ["text_limit_2"] = {typeConst = TypeConst.FONT_NORMAL,size = 20,color = cc.c3b(0xff,0xe9,0x49),outlineColor = cc.c3b(0x9f,0x52,0x0d),outlineSize = 1},   --涅槃详情
    ["text_redbag_1"] = {typeConst = TypeConst.FONT_NORMAL,size = 22,color = cc.c3b(0xff,0xdb,0x17),outlineColor = cc.c3b(0xaa,0x2c,0x00),outlineSize = 2},   --共获得,元宝
    ["vip_1"] = {typeConst = TypeConst.FONT_TITLE,size = 24,color = cc.c3b(0x8F,0x3F,0x0F)},   --特权


    ["text_1"] = {typeConst = TypeConst.FONT_NORMAL,size = 18,color = cc.c3b(0x40,0x52,0x8a),outlineColor = cc.c3b(0xaa,0xcb,0xff),outlineSize = 1},   --适度游戏 理性消费




    ["text_answer_1"] = {typeConst = TypeConst.FONT_TITLE,size = 26,color = cc.c3b(0xfe,0xea,0x38),outlineColor = cc.c3b(0xbf,0x54,0x0d),outlineSize = 1},-- 已凉！再见！
    ["text_answer_2"] = {typeConst = TypeConst.FONT_TITLE,size = 28,color = cc.c3b(0xfe,0xea,0x38),outlineColor = cc.c3b(0xbf,0x54,0x0d),outlineSize = 1},-- 答题即将开启，主公做好准备
    ["text_answer_3"] = {typeConst = TypeConst.FONT_TITLE,size = 58,color = cc.c3b(0xfe,0xea,0x38),outlineColor = cc.c3b(0xbf,0x54,0x0d),outlineSize = 2},-- 第一题
  
    ["text_main_icon_1"] = {typeConst = TypeConst.FONT_NORMAL,size = 18,color = cc.c3b(255,255,255),outlineColor = cc.c4b(0, 0, 0, 255),outlineSize = 2},-- 进行中，队伍中
    ["text_main_icon_2"] = {typeConst = TypeConst.FONT_NORMAL,size = 18,color = cc.c3b(255,255,255),outlineColor =  cc.c4b(0, 0, 0, 255),outlineSize = 2},-- 已结束
    ["return_1"] = {typeConst = TypeConst.FONT_NORMAL,size = 24,color = cc.c3b(0xff,0xcb,0x4e)},-- 老玩家回归奖励
    ["return_2"] = {typeConst = TypeConst.FONT_NORMAL,size = 24,color = cc.c3b(0xb8,0x4d,0x45)},-- 老玩家回归奖励
    ["text_voice_1"] = {typeConst = TypeConst.FONT_NORMAL,size = 26,color = cc.c3b(0xf3,0x7c,0x00)},-- 跨服1
    ["text_voice_2"] = {typeConst = TypeConst.FONT_NORMAL,size = 26,color = cc.c3b(0xff,0xe3,0x97)},-- 跨服2
    ["text_silkbag_1"] = {typeConst = TypeConst.FONT_NORMAL,size = 22,color = cc.c3b(0xea,0xb7,0x00),outlineColor = cc.c3b(0xb1,0x60,0x00),outlineSize = 1},-- 查看详情
    ["text_mine_craft_1"] = {typeConst = TypeConst.FONT_NORMAL,size = 26,color = cc.c3b(0xf3,0x7c,0x00)},-- 品阶 离开    
    ["text_individual_competitive_2"] = {typeConst = TypeConst.FONT_NORMAL,size = 22,color = cc.c3b(0xea,0xb7,0x00),outlineColor = cc.c3b(0xb1,0x60,0x00),outlineSize = 1},-- 奖励
    ["text_limit_3"] = {typeConst = TypeConst.FONT_NORMAL,size = 22,color = cc.c3b(0xff,0xe3,0x27),outlineColor = cc.c3b(0xb1,0x60,0x00),outlineSize = 2},
   
 
    ["historical_hero_1"] = {typeConst = TypeConst.FONT_NORMAL,size = 22,color = cc.c3b(0xf8,0xb5,0x26),outlineColor = cc.c3b(0xb7,0x3e,0x2b),outlineSize = 2},
    ["guild_cross_war_1"] = {typeConst = TypeConst.FONT_NORMAL,size = 18,color = cc.c3b(0xfe,0xe5,0x61),outlineColor = cc.c3b(0xb0,0x5d,0x0c),outlineSize = 1},--可驻扎   
    

    ["text_escort_1"] = {typeConst = TypeConst.FONT_NORMAL,size = 22,color = cc.c3b(0xff,0xd0,0x08),outlineColor = cc.c3b(0xbb,0x28,0x00),outlineSize = 1},
    ["txt_escort01_liangche"] = {typeConst = TypeConst.FONT_NORMAL,size = 22,color = cc.c3b(0x0b,0x77,0xf2)},
    ["txt_escort01_liuma"] = {typeConst = TypeConst.FONT_NORMAL,size = 22,color = cc.c3b(0xfb,0x81,0xe4)},
    ["txt_escort01_muniu"] = {typeConst = TypeConst.FONT_NORMAL,size = 22,color = cc.c3b(0xff,0xd0,0x08)},

    ["guild_cross_war_2"] = {typeConst = TypeConst.FONT_NORMAL,size = 18,color = cc.c3b(0xff,0x40,0x40),outlineColor = cc.c3b(0x51,0x1a,0x04),outlineSize = 1},--争夺中
    ["guild_cross_war_3"] = {typeConst = TypeConst.FONT_NORMAL,size = 22,color = cc.c3b(0xff,0xff,0x5d),outlineColor = cc.c3b(0xcf,0x54,0x00),outlineSize = 1},--攻击鼓舞,防御鼓舞
    ["guild_cross_war_4"] = {typeConst = TypeConst.FONT_NORMAL,size = 22,color = cc.c3b(0xff,0xff,0x5d),outlineColor = cc.c3b(0xcf,0x54,0x00),outlineSize = 2},--攻击鼓舞,防御鼓舞 --VN

    ["homeland_7"] = {typeConst = TypeConst.FONT_TITLE, size = 16, outlineSize = 1, color = cc.c3b(0xfe ,0xe1,0x02), outlineColor = cc.c3b(0x77, 0x1f,0x00)},   -- 神树 祈祷 图鉴 旌旗字颜色
   



}
-- i18n ja change
local ui4_TextStyle = ColorEx.TextStyle 

ui4_TextStyle["team_btnSecelt_6"] = { typeConst = TypeConst.FONT_NORMAL, size = 24, outlineSize = 2, color = cc.c3b(0xaf , 0x74  , 0x4c ), outlineColor =  cc.c3b(0xff , 0xf7 , 0xe5 )}   --养成系统侧边栏button(升级 突破 唤醒 觉醒...) 
ui4_TextStyle["team_btnUnSecelt_6"] = { typeConst = TypeConst.FONT_NORMAL,   color = cc.c3b(0xc8 , 0xd4  , 0xf6 ) }   --养成系统侧边栏button(升级 突破 唤醒 觉醒...)   
ui4_TextStyle["limit_2_des"] = { typeConst = TypeConst.FONT_NORMAL, size = 18,   color = cc.c3b(0xb4 , 0x64  , 0x14 ) }   -- 界限突破 突破至界3解锁新形象红将
ui4_TextStyle["text_gold_limit_1"] = {typeConst = TypeConst.FONT_NORMAL, size = 18, color = cc.c3b(0xb4,0x64,0x14) }   --修身，齐家，治国，南华，水镜，点击涅槃，子上，周姬，楚辞，周易，礼记，汉书
ui4_TextStyle["limit_1_ja"] = { typeConst = TypeConst.FONT_NORMAL, size = 18, outlineSize = 2, color = cc.c3b(0xfb , 0xcc  , 0x27 ), outlineColor =  cc.c3b(0x67  , 0x1e  , 0x04  )}   -- 突破/界限/涅槃详情按钮 +  阵容强化大师...
ui4_TextStyle["team_max_level_ja"] = { typeConst = TypeConst.FONT_NORMAL, size = 20, outlineSize = 2, color = cc.c3b(0xe6 , 0x8e  , 0x26 ), outlineColor =  cc.c3b(0xff  , 0xff  , 0xff  )}   -- 养成系统满级   主公！你已经登峰造极！走上人生巅峰啦！
ui4_TextStyle["instrument_limit_1"] = { typeConst = TypeConst.FONT_NORMAL, size = 18, color = cc.c3b(0x71 , 0x43  , 0x06 )}   -- 神兵界限描述
ui4_TextStyle["text_main_icon_12"] = {typeConst = TypeConst.FONT_NORMAL,size = 18,color = cc.c3b(0x39, 0xe7, 0x32),outlineColor = cc.c4b(0x0f,0x4c,0x07),outlineSize = 2}    -- 进行中，队伍中
ui4_TextStyle["chatper_game_name_1_ja"] = { typeConst = TypeConst.FONT_TITLE, size =  45,   outlineSize = 2, color = cc.c3b(0xff , 0xad  , 0x39 ), outlineColor =  cc.c3b(0x6d  , 0x2f , 0x0c   )}  
ui4_TextStyle["explore_2_ja"] = { typeConst = TypeConst.FONT_NORMAL, size = 22, outlineSize = 2, color = cc.c3b(0xff , 0xd5  , 0x47 ), outlineColor =  cc.c3b(0x4a , 0x13 , 0x02 )}   -- 1.半价物资 2.董卓之乱 3.洛阳之乱 4.慕名而来 5.水镜学堂
ui4_TextStyle["ranking_1_ja"] = { typeConst = TypeConst.FONT_TITLE, size = 32, outlineSize = 2, color = cc.c3b(0xde , 0xde  , 0xe4 ), outlineColor =  cc.c3b(0x29  , 0x29  , 0x3b  )}   -- 标签 失败
ui4_TextStyle["ranking_2_ja"] = { typeConst = TypeConst.FONT_TITLE, size = 32, outlineSize = 2, color = cc.c3b(0xfa , 0xd4  , 0x5f ), outlineColor =  cc.c3b(0xd6  , 0x52  , 0x01  )}   -- 标签 胜利
ui4_TextStyle["text_explore_1_ja"] = {typeConst = TypeConst.FONT_TITLE,size = 24,color = cc.c3b(0xff,0xfa,0xe5) }   -- 5折出售
ui4_TextStyle["text_Rlevel_ja"] = { typeConst = TypeConst.FONT_TITLE, size = 20, outlineSize = 2, color = cc.c3b(0xa8 , 0xff  , 0x00 ), outlineColor =  cc.c3b(0x32  , 0x69  , 0x11  )}  -- icon精炼等级
ui4_TextStyle["activity_limit_3_ja"] = { typeConst = TypeConst.FONT_NORMAL, size = 20, color = cc.c3b(0xa8, 0xff, 0x00) }  -- 限时活动 活动剩余 新换的字体和颜色



function ColorEx.getTypeStyle(id,type)
    type = type or TypeConst.TEXT
    -- print("  ColorEx.getTypeStyle  id: " .. id)
    -- print("  ColorEx.getTypeStyle  type: " .. type)
    local constName = ""
    if type ==  TypeConst.TEXT then
        constName = "TextStyle"
    elseif type ==  TypeConst.EFFECT then
        constName = "EffectStyle"
    end
    -- print("  ColorEx.getTypeStyle  constName: " .. constName)
    if not constName or constName == "" then
        return nil
    end
    local colorData = Colors[constName][id]
    assert(colorData, "cannot find id: " .. id .. "     type:" .. type .. " in Colors.getColorWithList")
    return colorData
end 

function ColorEx.getStyle(id,type)
    type = type or TypeConst.TEXT
    return Colors.getTypeStyle(id,type)
end
