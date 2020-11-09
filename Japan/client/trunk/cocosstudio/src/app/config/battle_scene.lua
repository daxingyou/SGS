--battle_scene

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --地图id-int 
  name = 2,    --场景名-string 
  background = 3,    --背景图-string 
  farground = 4,    --远景-string 
  front_eft = 5,    --前层特效（最前面）-string 
  middle_eft = 6,    --中层特效（背景前，人物后）-string 
  back_eft = 7,    --远景特效（远景前，中景后）-string 
  is_turn = 8,    --是否翻转，1翻转，0不翻转-int 
  icon = 9,    --背景列表icon-string 
  order = 10,    --背景默认展示顺序-int 

}

-- key type
local __key_type = {
  id = "int",    --地图id-1 
  name = "string",    --场景名-2 
  background = "string",    --背景图-3 
  farground = "string",    --远景-4 
  front_eft = "string",    --前层特效（最前面）-5 
  middle_eft = "string",    --中层特效（背景前，人物后）-6 
  back_eft = "string",    --远景特效（远景前，中景后）-7 
  is_turn = "int",    --是否翻转，1翻转，0不翻转-8 
  icon = "string",    --背景列表icon-9 
  order = "int",    --背景默认展示顺序-10 

}


-- data
local battle_scene = {
    version =  1,
    _data = {
        [1] = {1,"战斗-攻城门","fight/scene/1_front.png","fight/scene/1_back.jpg","","gongchengmenzhandou_middle","gongchengmenzhandou_back",0,"",0,},
        [2] = {2,"战斗-江边","fight/scene/2_middle.png","fight/scene/2_back.jpg","jiangbianzhandou_front","jiangbianzhandou_middle","jiangbianzhandou_back",0,"",0,},
        [3] = {3,"战斗-皇宫","fight/scene/3_middle.png","fight/scene/3_back.jpg","huanggongzhandou_front","","huanggongzhandou_back",0,"",0,},
        [4] = {4,"战斗-城墙","fight/scene/4_middle.png","fight/scene/4_back.jpg","chengqiangzhandou_front","chengqiangzhandou_middle","chengqiangzhandou_back",0,"",0,},
        [5] = {5,"战斗-凤仪亭","fight/scene/5.jpg","","fengyitingzhandou_front","fengyitingzhandou_middle","",0,"",0,},
        [6] = {6,"战斗-船上","fight/scene/6_middle.png","fight/scene/6_back.jpg","","chuanshangzhandou_middle","chuanshangzhandou_back",0,"",0,},
        [7] = {7,"战斗-桃园","fight/scene/7.jpg","","taohuayuan_front","taohuayuan","",0,"",0,},
        [8] = {8,"战斗-水淹","fight/scene/8.jpg","","xiapizhandou_frnot","xiapizhandou_middle","",0,"",0,},
        [9] = {9,"战斗-冬关","fight/scene/9_middle.png","fight/scene/9_back.jpg","sanling_front","sanling_middle","sanling_back",0,"",0,},
        [10] = {10,"战斗-黄巾","fight/scene/10_middle.png","fight/scene/10_back.jpg","","huangjinzhandou_middle","huangjinzhandou_back",0,"",0,},
        [11] = {11,"战斗-长板桥","fight/scene/11_middle.png","fight/scene/11_back.jpg","changbanqiaozhandou_front","","changbanqiaozhandou_back",0,"",0,},
        [12] = {12,"战斗-洛阳","fight/scene/12.jpg","","luoyangzhandou_front","luoyangzhandou_middle","",0,"",0,},
        [13] = {13,"战斗-南蛮","fight/scene/13_middle.png","fight/scene/13_back.jpg","nanmanzhandou_front","nanmanzhandou_middle","nanmanzhandou_back",0,"",0,},
        [14] = {14,"战斗-军营","fight/scene/14_middle.png","fight/scene/14_back.png","changbanpozhandou2_front","changbanpozhandou2_middle","changbanpozhandou2_back",0,"",0,},
        [15] = {15,"战斗-军营2","fight/scene/15_middle.png","fight/scene/15_back.jpg","junyingzhandou_front","junyingzhandou_middle","junyingzhandou_back",0,"",0,},
        [16] = {16,"皇宫走廊","fight/scene/16_middle.png","fight/scene/16_back.jpg","huanggongzoulang_front","","huanggongzoulang_back",0,"",0,},
        [17] = {17,"跨服阵营竞技战斗","fight/scene/kuafujingjizhandou.jpg","","","kuafujingjizhandou","",0,"",0,},
        [18] = {18,"跨服BOSS战斗1","fight/scene/img_cross_boss_01b.png","fight/scene/img_cross_boss_bg01.jpg","","","kuafuboss_changjing",0,"",0,},
        [19] = {19,"跨服BOSS战斗2","fight/scene/img_cross_boss_02b.png","fight/scene/img_cross_boss_bg02.jpg","","","kuafuboss_changjing",0,"",0,},
        [20] = {101,"日常副本场景","ui3/stage/dailymap_middle.png","ui3/stage/dailymap_back.jpg","","richangfuben_middle","richangfuben_back",0,"",0,},
        [21] = {102,"主城冬天白天","ui3/stage/city_winter_middle.png","ui3/stage/city_winter_back.jpg","newzhucheng_front","newzhucheng_middle","newzhucheng_back",0,"visble_bj03",3,},
        [22] = {103,"装备宝物回收场景","ui3/background/img_hs02_middle.png","ui3/background/img_hs02_back.jpg","","huishou_middle","huishou_back",0,"",0,},
        [23] = {104,"主城春天晚上","ui3/stage/city_night_middle.png","ui3/stage/city_night_back.jpg","zhucheng3_front","zhucheng3_middle","zhucheng3_back",0,"visble_bj02",2,},
        [24] = {105,"武将回收","ui3/background/img_hs01.jpg","","","chongsheng_middle","",0,"",0,},
        [25] = {106,"主城春天白天","ui3/stage/city_spring_middle.png","ui3/stage/city_spring_back.jpg","zhucheng4_front","zhucheng4_middle","",0,"visble_bj01",1,},
        [26] = {107,"招募场景","ui3/stage/zhaomu_bj_middle.png","ui3/stage/zhaomu_bj_back.jpg","","zhaomu_middle","zhaomu_back",0,"",0,},
        [27] = {108,"爬塔场景","ui3/stage/tower_bg_middle.png","ui3/stage/tower_bg_back.jpg","","guoguanzhanjiang_middle","guoguanzhanjiang_back",0,"",0,},
        [28] = {109,"神兽之家","ui3/stage/pet_main_scene.jpg","","shenshou_front","shenshou_back","",0,"",0,},
        [29] = {110,"主城夏天","ui3/stage/city_summer_middle.png","ui3/stage/city_summer_back.jpg","zhucheng5_front","","zhucheng5_back",0,"visble_bj01",4,},
        [30] = {111,"主城夏天晚上","ui3/stage/city_summernight_middle.png","ui3/stage/city_summernight_back.jpg","zhucheng5night_front","","zhucheng5night_back",0,"",0,},
        [31] = {112,"主城秋天白天","ui3/stage/city_autumn_middle.png","ui3/stage/city_autumn_back.jpg","zhucheng6day_front","zhucheng6day_middle","zhucheng6day_back",0,"visble_bj02",5,},
        [32] = {113,"主城秋天晚上","ui3/stage/city_autumnnight_middle.png","ui3/stage/city_autumnnight_back.jpg","zhucheng6night_front","zhucheng6night_middle","zhucheng6night_back",0,"",0,},
        [33] = {114,"相马","ui3/background/img_judge_horse_bg.jpg","","","xiangmachangjing_middle","xiangmachangjing_back",0,"",0,},
        [34] = {115,"战马主城","ui3/background/img_horse_main_bg.jpg","","","zhanmazhucheng_middle","",0,"",0,},
        [35] = {116,"主城冬天白天","ui3/stage/city_winter_middle.png","ui3/stage/city_winter_back.jpg","newzhucheng_front","newzhucheng_middle","newzhucheng_back",0,"",0,},
        [36] = {117,"主城冬天晚上","ui3/stage/city_winternight_middle.png","ui3/stage/city_winternight_back.jpg","newzhuchengnight_front","newzhuchengnight_middle","newzhuchengnight_back",0,"",0,},
        [37] = {118,"主城圣诞白天","ui3/stage/city_christmas_middle.png","ui3/stage/city_winter_back.jpg","shengdanzhucheng_front","shengdanzhucheng_middle","",0,"",0,},
        [38] = {119,"主城圣晚上","ui3/stage/city_christmasnight_middle.png","ui3/stage/city_winternight_back.jpg","shengdanzhuchengnight_front","shengdanzhuchengnight_middle","",0,"",0,},
        [39] = {120,"竞技场背景图","","ui3/stage/img_arena_bg.jpg","","","jingjichangchangjing_back",0,"",0,},
        [40] = {121,"主城春节白天","ui3/stage/city_newyear_middle.png","ui3/stage/city_newyear_back.jpg","zhucheng9day_front","","zhucheng9day_middle",0,"",0,},
        [41] = {122,"主城春节晚上","ui3/stage/city_newyearnight_middle.png","ui3/stage/city_newyearnight_back.jpg","zhucheng9night_front","","zhucheng9night_back",0,"",0,},
        [42] = {123,"主城春天白天","ui3/stage/zhucheng10day_middle.png","ui3/stage/zhucheng10day_back.jpg","zhucheng10day_front","","zhucheng10day_back",0,"",0,},
        [43] = {124,"主城春天晚上","ui3/stage/zhucheng10night_middle.png","ui3/stage/zhucheng10night_back.jpg","zhucheng10night_front","","zhucheng10night_back",0,"",0,},
        [44] = {125,"主城周年庆白天","ui3/stage/zhucheng11day_middle.png","ui3/stage/zhucheng11day_back.jpg","zhucheng11day_front","","zhucheng11day_back",0,"",0,},
        [45] = {126,"主城周年庆晚上","ui3/stage/zhucheng11night_middle.png","ui3/stage/zhucheng11night_back.jpg","zhucheng11night_front","zhucheng11night_middle","zhucheng11night_back",0,"",0,},
        [46] = {127,"主城夏天白天","ui3/stage/zhucheng12day_middle.png","ui3/stage/zhucheng12day_back.jpg","","","zhucheng12day_back",0,"",0,},
        [47] = {128,"主城夏天晚上","ui3/stage/zhucheng12night_middle.png","ui3/stage/zhucheng12night_back.jpg","","","zhucheng12night_back",0,"",0,},
        [48] = {129,"主城秋天白天","","ui3/stage/zhucheng13day_middle.jpg","zhucheng13day_front","zhucheng13day_middle","",0,"",0,},
        [49] = {130,"主城秋天晚上","","ui3/stage/zhucheng13night_middle.jpg","zhucheng13night_front","zhucheng13night_middle","",0,"",0,},
        [50] = {131,"主城深秋庭院白天","","ui3/stage/zhucheng14day_middle.jpg","zhucheng14day_front","zhucheng14day_middle","",0,"",0,},
        [51] = {132,"主城深秋庭院夜晚","","ui3/stage/zhucheng14night_middle.jpg","zhucheng14night_front","zhucheng14night_middle","",0,"",0,},
        [52] = {133,"新年新主城白天","","ui3/stage/zhucheng15day_middle.jpg","","zhucheng15day","",0,"",0,},
        [53] = {134,"新年新主城夜晚","","ui3/stage/zhucheng15night_middle.jpg","","zhucheng15night_middle","",0,"",0,},
        [54] = {1001,"镜像-战斗-攻城门","fight/scene/1_front.png","fight/scene/1_back.jpg","","gongchengmenzhandou_middle","gongchengmenzhandou_back",1,"",0,},
        [55] = {1002,"镜像-战斗-江边","fight/scene/2_middle.png","fight/scene/2_back.jpg","jiangbianzhandou_front","jiangbianzhandou_middle","jiangbianzhandou_back",1,"",0,},
        [56] = {1003,"镜像-战斗-皇宫","fight/scene/3_middle.png","fight/scene/3_back.jpg","huanggongzhandou_front","","huanggongzhandou_back",1,"",0,},
        [57] = {1004,"镜像-战斗-城墙","fight/scene/4_middle.png","fight/scene/4_back.jpg","chengqiangzhandou_front","chengqiangzhandou_middle","chengqiangzhandou_back",1,"",0,},
        [58] = {1005,"镜像-战斗-凤仪亭","fight/scene/5.jpg","","fengyitingzhandou_front","fengyitingzhandou_middle","",1,"",0,},
        [59] = {1006,"镜像-战斗-船上","fight/scene/6_middle.png","fight/scene/6_back.jpg","","chuanshangzhandou_middle","chuanshangzhandou_back",1,"",0,},
        [60] = {1007,"镜像-战斗-桃园","fight/scene/7.jpg","","taohuayuan_front","taohuayuan","",1,"",0,},
        [61] = {1008,"镜像-战斗-水淹","fight/scene/8.jpg","","xiapizhandou_frnot","xiapizhandou_middle","",1,"",0,},
        [62] = {1009,"镜像-战斗-冬关","fight/scene/9_middle.png","fight/scene/9_back.jpg","sanling_front","sanling_middle","sanling_back",1,"",0,},
        [63] = {1010,"镜像-战斗-黄巾","fight/scene/10_middle.png","fight/scene/10_back.jpg","","huangjinzhandou_middle","huangjinzhandou_back",1,"",0,},
        [64] = {1011,"镜像-战斗-长板桥","fight/scene/11_middle.png","fight/scene/11_back.jpg","changbanqiaozhandou_front","","changbanqiaozhandou_back",1,"",0,},
        [65] = {1012,"镜像-战斗-洛阳","fight/scene/12.jpg","","luoyangzhandou_front","luoyangzhandou_middle","",1,"",0,},
        [66] = {1013,"镜像-战斗-南蛮","fight/scene/13_middle.png","fight/scene/13_back.jpg","nanmanzhandou_front","nanmanzhandou_middle","nanmanzhandou_back",1,"",0,},
        [67] = {1014,"镜像-战斗-军营","fight/scene/14_middle.png","fight/scene/14_back.png","changbanpozhandou2_front","changbanpozhandou2_middle","changbanpozhandou2_back",1,"",0,},
        [68] = {1015,"镜像-战斗-军营2","fight/scene/15_middle.png","fight/scene/15_back.jpg","junyingzhandou_front","junyingzhandou_middle","junyingzhandou_back",1,"",0,},
        [69] = {1016,"镜像-战斗-皇宫走廊","fight/scene/16_middle.png","fight/scene/16_back.jpg","huanggongzoulang_front","","huanggongzoulang_back",1,"",0,},
        [70] = {2001,"家园-种树","ui3/stage/tree_qj.png","ui3/stage/tree_bj.jpg","shenshuchangjing_front","","shenshuchangjing_back",0,"",0,},
        [71] = {2002,"无差别背景图","ui3/fight/img_fight_bg05.png","","","wuchabiexiahoudun","",0,"",0,},
        [72] = {2003,"周年庆蛋糕本服背景","ui3/background/img_bg_cake01.jpg","","zhounianqingdangao_dengguang","","",0,"",0,},
        [73] = {2004,"周年庆蛋糕全服背景","ui3/background/img_bg_cake02.jpg","","zhounianqingdangao_dengguang","","",0,"",0,},
        [74] = {2005,"阵容界面场景特效","ui3/stage/img_transform_bg_new.jpg","","","","",0,"",0,},
        [75] = {2006,"神兽橙升红","","ui3/background/shengshoushenghong01.jpg","shengshoushenghong_front","","shengshoushenghong_back",0,"",0,},
        [76] = {2007,"饕餮盛宴火锅本服背景","ui3/background/img_bg_huoguo01.jpg","","zhounianqingdangao_dengguang","","",0,"",0,},
        [77] = {2008,"饕餮盛宴火锅全服背景","ui3/background/img_bg_huoguo02.jpg","","zhounianqingdangao_dengguang","","",0,"",0,},
        [78] = {2009,"饕餮盛宴烧烤本服背景","ui3/background/img_bg_shaokao01.jpg","","benfukaorou_middle","","",0,"",0,},
        [79] = {2010,"饕餮盛宴烧烤全服背景","ui3/background/img_bg_shaokao02.jpg","","quanfukaorou_middle","","",0,"",0,},
        [80] = {2011,"武将红升金场景","ui3/background/wujiangshengjin.jpg","","wujiangshenghong_cj","","",0,"",0,},
        [81] = {2012,"饕餮盛宴烧烤本服背景","ui3/background/img_bg_nianye01.jpg","","benfunianyefan_middle","","",0,"",0,},
        [82] = {2013,"饕餮盛宴烧烤全服背景","ui3/background/img_bg_nianye02.jpg","","quanfunianyefan_middle","","",0,"",0,},
        [83] = {2014,"红神兽活动场景","ui3/background/pet_red_activity.jpg","","qiling_changjing","","",0,"",0,},
        [84] = {2101,"金将招募主场景","ui3/background/img_gold_bg05.jpg","","jinjiangzhaomu_dianjiang_front","jinjiangzhaomu_dianjiang","",0,"",0,},
        [85] = {9999,"创角场景","ui3/stage/chuangjue.jpg","","","chuangjuechangjing","",0,"",0,},
        [86] = {10001,"招募场景（白天）","ui3/stage/zhaomu_day_middle.jpg","","","zhaomuday","",0,"",0,},
        [87] = {10002,"招募场景（黑夜）","ui3/stage/zhaomu_night_middle.jpg","","","zhaomunight","",0,"",0,},
        [88] = {20011,"默认（白天）","ui3/stage/zhucheng1_day_middle.png","ui3/stage/zhucheng1_day_back.jpg","","zhucheng1day_middle","zhucheng1day_back",0,"visble_bj1",0,},
        [89] = {20012,"默认（夜晚）","ui3/stage/zhucheng1_night_middle.png","ui3/stage/zhucheng1_night_back.jpg","","zhucheng1night_middle","",0,"visble_bj2",0,},
        [90] = {20021,"春（白天）","ui3/stage/zhucheng2_day_middle.jpg","","","zhucheng2day","",0,"visble_bj3",0,},
        [91] = {20022,"春（夜晚）","ui3/stage/zhucheng2_night_middle.jpg","","","zhucheng2night","",0,"visble_bj4",0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [10001] = 86,
    [10002] = 87,
    [1001] = 54,
    [1002] = 55,
    [1003] = 56,
    [1004] = 57,
    [1005] = 58,
    [1006] = 59,
    [1007] = 60,
    [1008] = 61,
    [1009] = 62,
    [101] = 20,
    [1010] = 63,
    [1011] = 64,
    [1012] = 65,
    [1013] = 66,
    [1014] = 67,
    [1015] = 68,
    [1016] = 69,
    [102] = 21,
    [103] = 22,
    [104] = 23,
    [105] = 24,
    [106] = 25,
    [107] = 26,
    [108] = 27,
    [109] = 28,
    [11] = 11,
    [110] = 29,
    [111] = 30,
    [112] = 31,
    [113] = 32,
    [114] = 33,
    [115] = 34,
    [116] = 35,
    [117] = 36,
    [118] = 37,
    [119] = 38,
    [12] = 12,
    [120] = 39,
    [121] = 40,
    [122] = 41,
    [123] = 42,
    [124] = 43,
    [125] = 44,
    [126] = 45,
    [127] = 46,
    [128] = 47,
    [129] = 48,
    [13] = 13,
    [130] = 49,
    [131] = 50,
    [132] = 51,
    [133] = 52,
    [134] = 53,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [2001] = 70,
    [20011] = 88,
    [20012] = 89,
    [2002] = 71,
    [20021] = 90,
    [20022] = 91,
    [2003] = 72,
    [2004] = 73,
    [2005] = 74,
    [2006] = 75,
    [2007] = 76,
    [2008] = 77,
    [2009] = 78,
    [2010] = 79,
    [2011] = 80,
    [2012] = 81,
    [2013] = 82,
    [2014] = 83,
    [2101] = 84,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,
    [9999] = 85,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [10] = 10,
    [86] = 10001,
    [87] = 10002,
    [54] = 1001,
    [55] = 1002,
    [56] = 1003,
    [57] = 1004,
    [58] = 1005,
    [59] = 1006,
    [60] = 1007,
    [61] = 1008,
    [62] = 1009,
    [20] = 101,
    [63] = 1010,
    [64] = 1011,
    [65] = 1012,
    [66] = 1013,
    [67] = 1014,
    [68] = 1015,
    [69] = 1016,
    [21] = 102,
    [22] = 103,
    [23] = 104,
    [24] = 105,
    [25] = 106,
    [26] = 107,
    [27] = 108,
    [28] = 109,
    [11] = 11,
    [29] = 110,
    [30] = 111,
    [31] = 112,
    [32] = 113,
    [33] = 114,
    [34] = 115,
    [35] = 116,
    [36] = 117,
    [37] = 118,
    [38] = 119,
    [12] = 12,
    [39] = 120,
    [40] = 121,
    [41] = 122,
    [42] = 123,
    [43] = 124,
    [44] = 125,
    [45] = 126,
    [46] = 127,
    [47] = 128,
    [48] = 129,
    [13] = 13,
    [49] = 130,
    [50] = 131,
    [51] = 132,
    [52] = 133,
    [53] = 134,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [70] = 2001,
    [88] = 20011,
    [89] = 20012,
    [71] = 2002,
    [90] = 20021,
    [91] = 20022,
    [72] = 2003,
    [73] = 2004,
    [74] = 2005,
    [75] = 2006,
    [76] = 2007,
    [77] = 2008,
    [78] = 2009,
    [79] = 2010,
    [80] = 2011,
    [81] = 2012,
    [82] = 2013,
    [83] = 2014,
    [84] = 2101,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,
    [85] = 9999,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in battle_scene")
        if _lang ~= "cn" and _isDataExist  and t._data_key_map[k] then
            return t._data[t._data_key_map[k]]
        end
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[key_map[k]]
    end
}

-- 
function battle_scene.length()
    return #battle_scene._data
end

-- 
function battle_scene.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function battle_scene.isVersionValid(v)
    if battle_scene.version then
        if v then
            return battle_scene.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function battle_scene.indexOf(index)
    if index == nil or not battle_scene._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/battle_scene.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/battle_scene.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/battle_scene.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "battle_scene" )
                _isDataExist = battle_scene.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "battle_scene" )
                _isBaseExist = battle_scene.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "battle_scene" )
                _isExist = battle_scene.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "battle_scene" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "battle_scene" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = battle_scene._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "battle_scene" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function battle_scene.get(id)
    
    return battle_scene.indexOf(__index_id[id])
        
end

--
function battle_scene.set(id, key, value)
    local record = battle_scene.get(id)
    if record then
        if _lang ~= "cn" and _isDataExist then
            local keyIndex =  record._data_key_map[key]
            if keyIndex then
                record._data[keyIndex] = value
                return
            end
        end
        if _lang ~= "cn" and _isExist then
            local keyIndex =  record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
                return
            end
        end
        local keyIndex = record._raw_key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function battle_scene.index()
    return __index_id
end

return battle_scene