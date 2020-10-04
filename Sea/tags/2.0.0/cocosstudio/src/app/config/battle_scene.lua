--battle_scene

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --地图id-int 
  background = 2,    --背景图-string 
  farground = 3,    --远景-string 
  front_eft = 4,    --前层特效（最前面）-string 
  middle_eft = 5,    --中层特效（背景前，人物后）-string 
  back_eft = 6,    --远景特效（远景前，中景后）-string 
  is_turn = 7,    --是否翻转，1翻转，0不翻转-int 

}

-- key type
local __key_type = {
  id = "int",    --地图id-1 
  background = "string",    --背景图-2 
  farground = "string",    --远景-3 
  front_eft = "string",    --前层特效（最前面）-4 
  middle_eft = "string",    --中层特效（背景前，人物后）-5 
  back_eft = "string",    --远景特效（远景前，中景后）-6 
  is_turn = "int",    --是否翻转，1翻转，0不翻转-7 

}


-- data
local battle_scene = {
    _data = {
        [1] = {1,"fight/scene/1_front.png","fight/scene/1_back.jpg","","gongchengmenzhandou_middle","gongchengmenzhandou_back",0,},
        [2] = {2,"fight/scene/2_middle.png","fight/scene/2_back.jpg","jiangbianzhandou_front","jiangbianzhandou_middle","jiangbianzhandou_back",0,},
        [3] = {3,"fight/scene/3_middle.png","fight/scene/3_back.jpg","huanggongzhandou_front","","huanggongzhandou_back",0,},
        [4] = {4,"fight/scene/4_middle.png","fight/scene/4_back.jpg","chengqiangzhandou_front","chengqiangzhandou_middle","chengqiangzhandou_back",0,},
        [5] = {5,"fight/scene/5.jpg","","fengyitingzhandou_front","fengyitingzhandou_middle","",0,},
        [6] = {6,"fight/scene/6_middle.png","fight/scene/6_back.jpg","","chuanshangzhandou_middle","chuanshangzhandou_back",0,},
        [7] = {7,"fight/scene/7.jpg","","taohuayuan_front","taohuayuan","",0,},
        [8] = {8,"fight/scene/8.jpg","","xiapizhandou_frnot","xiapizhandou_middle","",0,},
        [9] = {9,"fight/scene/9_middle.png","fight/scene/9_back.jpg","sanling_front","sanling_middle","sanling_back",0,},
        [10] = {10,"fight/scene/10_middle.png","fight/scene/10_back.jpg","","huangjinzhandou_middle","huangjinzhandou_back",0,},
        [11] = {11,"fight/scene/11_middle.png","fight/scene/11_back.jpg","changbanqiaozhandou_front","","changbanqiaozhandou_back",0,},
        [12] = {12,"fight/scene/12.jpg","","luoyangzhandou_front","luoyangzhandou_middle","",0,},
        [13] = {13,"fight/scene/13_middle.png","fight/scene/13_back.jpg","nanmanzhandou_front","nanmanzhandou_middle","nanmanzhandou_back",0,},
        [14] = {14,"fight/scene/14_middle.png","fight/scene/14_back.png","changbanpozhandou2_front","changbanpozhandou2_middle","changbanpozhandou2_back",0,},
        [15] = {15,"fight/scene/15_middle.png","fight/scene/15_back.jpg","junyingzhandou_front","junyingzhandou_middle","junyingzhandou_back",0,},
        [16] = {16,"fight/scene/16_middle.png","fight/scene/16_back.jpg","huanggongzoulang_front","","huanggongzoulang_back",0,},
        [17] = {17,"fight/scene/kuafujingjizhandou.jpg","","","kuafujingjizhandou","",0,},
        [18] = {101,"ui3/stage/dailymap_middle.png","ui3/stage/dailymap_back.jpg","","richangfuben_middle","richangfuben_back",0,},
        [19] = {102,"ui3/stage/city_winter_middle.png","ui3/stage/city_winter_back.jpg","newzhucheng_front","newzhucheng_middle","newzhucheng_back",0,},
        [20] = {103,"ui3/background/img_hs02_middle.png","ui3/background/img_hs02_back.jpg","","huishou_middle","huishou_back",0,},
        [21] = {104,"ui3/stage/city_night_middle.png","ui3/stage/city_night_back.jpg","zhucheng3_front","zhucheng3_middle","zhucheng3_back",0,},
        [22] = {105,"ui3/background/img_hs01.jpg","","","chongsheng_middle","",0,},
        [23] = {106,"ui3/stage/city_spring_middle.png","ui3/stage/city_spring_back.jpg","zhucheng4_front","zhucheng4_middle","",0,},
        [24] = {107,"ui3/stage/zhaomu_bj_middle.png","ui3/stage/zhaomu_bj_back.jpg","","zhaomu_middle","zhaomu_back",0,},
        [25] = {108,"ui3/stage/tower_bg_middle.png","ui3/stage/tower_bg_back.jpg","","guoguanzhanjiang_middle","guoguanzhanjiang_back",0,},
        [26] = {109,"ui3/stage/pet_main_scene.jpg","","shenshou_front","shenshou_back","",0,},
        [27] = {110,"ui3/stage/city_summer_middle.png","ui3/stage/city_summer_back.jpg","zhucheng5_front","","zhucheng5_back",0,},
        [28] = {111,"ui3/stage/city_summernight_middle.png","ui3/stage/city_summernight_back.jpg","zhucheng5night_front","","zhucheng5night_back",0,},
        [29] = {112,"ui3/stage/city_autumn_middle.png","ui3/stage/city_autumn_back.jpg","zhucheng6day_front","zhucheng6day_middle","zhucheng6day_back",0,},
        [30] = {113,"ui3/stage/city_autumnnight_middle.png","ui3/stage/city_autumnnight_back.jpg","zhucheng6night_front","zhucheng6night_middle","zhucheng6night_back",0,},
        [31] = {114,"ui3/background/img_judge_horse_bg.jpg","","","xiangmachangjing_middle","xiangmachangjing_back",0,},
        [32] = {115,"ui3/background/img_horse_main_bg.jpg","","","zhanmazhucheng_middle","",0,},
        [33] = {116,"ui3/stage/city_winter_middle.png","ui3/stage/city_winter_back.jpg","newzhucheng_front","newzhucheng_middle","newzhucheng_back",0,},
        [34] = {117,"ui3/stage/city_winternight_middle.png","ui3/stage/city_winternight_back.jpg","newzhuchengnight_front","newzhuchengnight_middle","newzhuchengnight_back",0,},
        [35] = {118,"ui3/stage/city_christmas_middle.png","ui3/stage/city_winter_back.jpg","shengdanzhucheng_front","shengdanzhucheng_middle","",0,},
        [36] = {119,"ui3/stage/city_christmasnight_middle.png","ui3/stage/city_winternight_back.jpg","shengdanzhuchengnight_front","shengdanzhuchengnight_middle","",0,},
        [37] = {120,"","ui3/stage/img_arena_bg.jpg","","","jingjichangchangjing_back",0,},
        [38] = {121,"ui3/stage/city_newyear_middle.png","ui3/stage/city_newyear_back.jpg","zhucheng9day_front","","zhucheng9day_middle",0,},
        [39] = {122,"ui3/stage/city_newyearnight_middle.png","ui3/stage/city_newyearnight_back.jpg","zhucheng9night_front","","zhucheng9night_back",0,},
        [40] = {123,"ui3/stage/zhucheng10day_middle.png","ui3/stage/zhucheng10day_back.jpg","zhucheng10day_front","","zhucheng10day_back",0,},
        [41] = {124,"ui3/stage/zhucheng10night_middle.png","ui3/stage/zhucheng10night_back.jpg","zhucheng10night_front","","zhucheng10night_back",0,},
        [42] = {125,"ui3/stage/zhucheng11day_middle.png","ui3/stage/zhucheng11day_back.jpg","zhucheng11day_front","","zhucheng11day_back",0,},
        [43] = {126,"ui3/stage/zhucheng11night_middle.png","ui3/stage/zhucheng11night_back.jpg","zhucheng11night_front","zhucheng11night_middle","zhucheng11night_back",0,},
        [44] = {1001,"fight/scene/1_front.png","fight/scene/1_back.jpg","","gongchengmenzhandou_middle","gongchengmenzhandou_back",1,},
        [45] = {1002,"fight/scene/2_middle.png","fight/scene/2_back.jpg","jiangbianzhandou_front","jiangbianzhandou_middle","jiangbianzhandou_back",1,},
        [46] = {1003,"fight/scene/3_middle.png","fight/scene/3_back.jpg","huanggongzhandou_front","","huanggongzhandou_back",1,},
        [47] = {1004,"fight/scene/4_middle.png","fight/scene/4_back.jpg","chengqiangzhandou_front","chengqiangzhandou_middle","chengqiangzhandou_back",1,},
        [48] = {1005,"fight/scene/5.jpg","","fengyitingzhandou_front","fengyitingzhandou_middle","",1,},
        [49] = {1006,"fight/scene/6_middle.png","fight/scene/6_back.jpg","","chuanshangzhandou_middle","chuanshangzhandou_back",1,},
        [50] = {1007,"fight/scene/7.jpg","","taohuayuan_front","taohuayuan","",1,},
        [51] = {1008,"fight/scene/8.jpg","","xiapizhandou_frnot","xiapizhandou_middle","",1,},
        [52] = {1009,"fight/scene/9_middle.png","fight/scene/9_back.jpg","sanling_front","sanling_middle","sanling_back",1,},
        [53] = {1010,"fight/scene/10_middle.png","fight/scene/10_back.jpg","","huangjinzhandou_middle","huangjinzhandou_back",1,},
        [54] = {1011,"fight/scene/11_middle.png","fight/scene/11_back.jpg","changbanqiaozhandou_front","","changbanqiaozhandou_back",1,},
        [55] = {1012,"fight/scene/12.jpg","","luoyangzhandou_front","luoyangzhandou_middle","",1,},
        [56] = {1013,"fight/scene/13_middle.png","fight/scene/13_back.jpg","nanmanzhandou_front","nanmanzhandou_middle","nanmanzhandou_back",1,},
        [57] = {1014,"fight/scene/14_middle.png","fight/scene/14_back.png","changbanpozhandou2_front","changbanpozhandou2_middle","changbanpozhandou2_back",1,},
        [58] = {1015,"fight/scene/15_middle.png","fight/scene/15_back.jpg","junyingzhandou_front","junyingzhandou_middle","junyingzhandou_back",1,},
        [59] = {1016,"fight/scene/16_middle.png","fight/scene/16_back.jpg","huanggongzoulang_front","","huanggongzoulang_back",1,},
        [60] = {2001,"ui3/stage/tree_qj.png","ui3/stage/tree_bj.jpg","shenshuchangjing_front","","shenshuchangjing_back",0,},
        [61] = {2002,"ui3/fight/img_fight_bg05.png","","","wuchabiexiahoudun","",0,},
        [62] = {2003,"ui3/background/img_bg_cake01.jpg","","zhounianqingdangao_dengguang","","",0,},
        [63] = {2004,"ui3/background/img_bg_cake02.jpg","","zhounianqingdangao_dengguang","","",0,},
        [64] = {2005,"ui3/stage/img_transform_bg.jpg","","","lidaimingjiang_back","",0,},
        [65] = {2101,"ui3/background/img_gold_bg05.jpg","","jinjiangzhaomu_dianjiang_front","jinjiangzhaomu_dianjiang","",0,},
        [66] = {9999,"ui3/stage/img_chuangjue_chengqiang.png","ui3/stage/img_chuangjue_yuanjing.jpg","","xinchuangjue_middle","xinchuangjue_back",0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [1001] = 44,
    [1002] = 45,
    [1003] = 46,
    [1004] = 47,
    [1005] = 48,
    [1006] = 49,
    [1007] = 50,
    [1008] = 51,
    [1009] = 52,
    [101] = 18,
    [1010] = 53,
    [1011] = 54,
    [1012] = 55,
    [1013] = 56,
    [1014] = 57,
    [1015] = 58,
    [1016] = 59,
    [102] = 19,
    [103] = 20,
    [104] = 21,
    [105] = 22,
    [106] = 23,
    [107] = 24,
    [108] = 25,
    [109] = 26,
    [11] = 11,
    [110] = 27,
    [111] = 28,
    [112] = 29,
    [113] = 30,
    [114] = 31,
    [115] = 32,
    [116] = 33,
    [117] = 34,
    [118] = 35,
    [119] = 36,
    [12] = 12,
    [120] = 37,
    [121] = 38,
    [122] = 39,
    [123] = 40,
    [124] = 41,
    [125] = 42,
    [126] = 43,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [17] = 17,
    [2] = 2,
    [2001] = 60,
    [2002] = 61,
    [2003] = 62,
    [2004] = 63,
    [2005] = 64,
    [2101] = 65,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,
    [9999] = 66,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in battle_scene")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
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
function battle_scene.indexOf(index)
    if index == nil or not battle_scene._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/battle_scene.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "battle_scene" )
        return setmetatable({_raw = battle_scene._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = battle_scene._data[index]}, mt)
end

--
function battle_scene.get(id)
    
    return battle_scene.indexOf(__index_id[id])
        
end

--
function battle_scene.set(id, key, value)
    local record = battle_scene.get(id)
    if record then
        local keyIndex = __key_map[key]
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