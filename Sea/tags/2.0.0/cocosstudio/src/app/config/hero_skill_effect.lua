--hero_skill_effect

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  buff_type = 1,    --buff类型-int 
  buff_eff_time = 2,    --buff生效时间-int 
  buff_tween_pic = 3,    --buff生效时飘字-string 
  buff_tween = 4,    --buff生效飘字动作-string 
  buff_jiesuan = 5,    --buff回合结算飘字-string 
  buff_res = 6,    --buff特效名称-string 
  buff_pos = 7,    --buff特效位置-int 
  buff_pri = 8,    --buff特效显示优先级-int 
  buff_sustain = 9,    --buff持续表现-int 
  target_color = 10,    --目标变色效果-string 
  buff_name = 11,    --buff名称提示-string 
  buff_icon = 12,    --buff小icon-string 
  buff_action = 13,    --buff调用动作-string 
  buff_sum = 14,    --buff统计类型-int 
  buff_sum_txt = 15,    --buff统计文本-string 
  buff_sup = 16,    --buff是否需要显示叠加-int 
  buff_colour = 17,    --叠加数字的颜色-int 
  buff_front_effect = 18,    --受击前播放特效-string 
  buff_blow_time = 19,    --播放受击时间-int 
  buff_sum_ctrl = 20,    --buff统计控制-int 
  buff_sound = 21,    --buff音效-string 
  flash_action = 22,    --FLASH动作-string 
  special = 23,    --特殊动作-string 

}

-- key type
local __key_type = {
  buff_type = "int",    --buff类型-1 
  buff_eff_time = "int",    --buff生效时间-2 
  buff_tween_pic = "string",    --buff生效时飘字-3 
  buff_tween = "string",    --buff生效飘字动作-4 
  buff_jiesuan = "string",    --buff回合结算飘字-5 
  buff_res = "string",    --buff特效名称-6 
  buff_pos = "int",    --buff特效位置-7 
  buff_pri = "int",    --buff特效显示优先级-8 
  buff_sustain = "int",    --buff持续表现-9 
  target_color = "string",    --目标变色效果-10 
  buff_name = "string",    --buff名称提示-11 
  buff_icon = "string",    --buff小icon-12 
  buff_action = "string",    --buff调用动作-13 
  buff_sum = "int",    --buff统计类型-14 
  buff_sum_txt = "string",    --buff统计文本-15 
  buff_sup = "int",    --buff是否需要显示叠加-16 
  buff_colour = "int",    --叠加数字的颜色-17 
  buff_front_effect = "string",    --受击前播放特效-18 
  buff_blow_time = "int",    --播放受击时间-19 
  buff_sum_ctrl = "int",    --buff统计控制-20 
  buff_sound = "string",    --buff音效-21 
  flash_action = "string",    --FLASH动作-22 
  special = "string",    --特殊动作-23 

}


-- data
local hero_skill_effect = {
    _data = {
        [1] = {2101,0,"","","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [2] = {2102,0,"","","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [3] = {2103,0,"buff_01shanghai","0","","sp_10shanghaijia",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [4] = {2104,1,"buff_01shanghai","0","","sp_06jianshangdun",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [5] = {2114,1,"","","","sp_12chixuzhiliao",2,3,1,"","","","",0,"",0,0,"",0,0,"","","",},
        [6] = {3333,1,"zhuangtai_teshu_b_01mianyi","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [7] = {2105,2,"buff_01jianshang","0","","sp_06jianshangdun",3,2,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [8] = {2106,2,"buff_01shanghai","0","","sp_10shanghaijia",9,2,0,"","","","",0,"",1,1,"",0,0,"","","",},
        [9] = {2108,2,"buff_01nuqi","0","","sp_15nuqijia",10,3,0,"","","","",5,"加怒|点",0,0,"",0,0,"","","",},
        [10] = {2121,2,"buff_01baoji","0","","sp_11baojijia",9,3,0,"","","","",0,"",1,2,"",0,0,"","","",},
        [11] = {2302,2,"buff_01shanghai","0","","sp_10shanghaijia",9,3,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [12] = {2308,2,"zhuangtai_teshu_b_01wudi","0","","sp_08wudi",1,1,0,"","","","idle",0,"",0,0,"",0,0,"","","",},
        [13] = {2311,2,"zhuangtai_teshu_b_01wudi","0","","sp_08wudi",1,1,0,"","","","idle",0,"",0,0,"",0,0,"","","",},
        [14] = {2335,2,"zhuangtai_teshu_b_01wudi","0","","sp_09wudixixuedun",1,2,0,"","","","idle",0,"",0,0,"",0,0,"","","",},
        [15] = {2336,2,"zhuangtai_teshu_b_01xishou","0","","sp_07xishoushanghaidun",3,2,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [16] = {2351,2,"zhuangtai_teshu_b_01xishou","0","","sp_07xishoushanghaidun",3,2,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [17] = {2201,3,"property_red_01zhuoshao","1","","sp_01zhuoshao",4,3,1,"burn","","","",0,"",0,0,"",0,0,"","","",},
        [18] = {2202,3,"zhuangtai_hui_04mabi","1","","sp_02mabi",5,3,1,"","","","",3,"麻痹|人",0,0,"",0,0,"","","",},
        [19] = {2203,3,"zhuangtai_teshu_a_01xuanyun","1","","sp_03yunxuan",6,1,1,"","","","dizzy",2,"晕眩|人",0,0,"",0,0,"","","",},
        [20] = {2204,3,"zhuangtai_teshu_b_01chenmo","1","","sp_04chenmo",7,3,1,"","","","",4,"沉默|人",0,0,"",0,0,"","","",},
        [21] = {2205,3,"zhuangtai_teshu_d_01zhongdu","1","","sp_05zhongdu",8,3,1,"poison","","","",0,"",0,0,"",0,0,"","","",},
        [22] = {2117,3,"buff_02jianshang","2","","sp_14shoushangjia",9,3,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [23] = {2110,3,"buff_02gongji","2","","sp_13shanghaijian",9,3,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [24] = {2109,3,"buff_02nuqi","2","","sp_16nuqijian",10,3,0,"","","","",6,"减怒|点",0,0,"",0,0,"","","",},
        [25] = {2306,2,"zhuangtai_teshu_b_01zhuiji","1","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [26] = {2307,0,"zhuangtai_teshu_b_01zhuiji","1","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [27] = {2303,2,"","","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [28] = {2107,2,"","","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [29] = {2401,3,"","","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [30] = {2402,0,"zhuangtai_teshu_b_01ganglie","1","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [31] = {2206,2,"zhuangtai_teshu_a_01xuanyun","1","","sp_03yunxuan",6,2,1,"","","","dizzy",1,"晕眩|人",0,0,"",0,0,"","","",},
        [32] = {2309,0,"zhuangtai_teshu_b_01fuhuo","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [33] = {2113,2,"","","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [34] = {2338,1,"zhuangtai_teshu_b_01qingchu","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [35] = {2339,3,"zhuangtai_teshu_b_01fengliao","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [36] = {2340,3,"zhuangtai_teshu_a_fengwudi","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [37] = {2341,1,"zhuangtai_teshu_a_01miankong","0","","",0,0,0,"","","","idle",0,"",0,0,"",0,0,"","","",},
        [38] = {2342,0,"","","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [39] = {2343,6,"","","","sp_17mianyi",11,1,0,"","","","idle",0,"",0,0,"",0,0,"","","",},
        [40] = {2344,1,"buff_01jianshang","0","","sp_06jianshangdun",3,3,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [41] = {2345,1,"zhuangtai_teshu_b_01jieyun","0","","",0,0,0,"","","","",7,"解晕|人",0,0,"",0,1,"","","",},
        [42] = {2362,2,"zhuangtai_teshu_b_01mianyi","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [43] = {2363,2,"buff_01jianshang","0","","sp_06jianshangdun",3,3,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [44] = {2365,3,"zhuangtai_teshu_d_01zhongdu","1","","sp_05zhongdu",8,3,1,"poison","","","",0,"",0,0,"",0,0,"","","",},
        [45] = {2370,3,"zhuangtai_teshu_b_01chenmo","1","","sp_04chenmo",7,3,1,"","","","",4,"沉默|人",0,0,"",0,0,"","","",},
        [46] = {2367,2,"zhuangtai_teshu_b_01mianyi","0","","",0,0,0,"","","","idle",0,"",0,0,"",0,0,"","","",},
        [47] = {2368,2,"zhuangtai_teshu_b_01wudi","0","","sp_08wudi",1,1,0,"","","","idle",0,"",0,0,"",0,0,"","","",},
        [48] = {2373,3,"zhuangtai_teshu_d_01zhongdu","1","","sp_05zhongdu",8,3,1,"poison","","","",0,"",0,0,"",0,0,"","","",},
        [49] = {2374,3,"zhuangtai_teshu_d_01zhongdu","1","","sp_05zhongdu",8,3,1,"poison","","","",0,"",0,0,"",0,0,"","","",},
        [50] = {2369,1,"zhuangtai_teshu_a_01miankong","0","","sp_17mianyi",11,1,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [51] = {2352,1,"zhuangtai_teshu_b_01jiekong","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [52] = {2375,3,"property_red_01zhuoshao","1","","sp_01zhuoshao",4,3,1,"burn","","","",0,"",0,0,"",0,0,"","","",},
        [53] = {2359,3,"zhuangtai_teshu_b_01buqu","1","","",0,0,0,"translucent","","","",0,"",0,0,"",0,0,"","","",},
        [54] = {2376,3,"","1","","sp_710_flash",12,1,1,"","","","",8,"击中|人",0,0,"sp_710",1900,0,"fy_710003","","",},
        [55] = {2377,1,"zhuangtai_teshu_b_01qingchu","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [56] = {2378,1,"zhuangtai_teshu_b_01jiekong","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [57] = {2379,1,"","","","sp_12chixuzhiliao",2,3,1,"","","","",0,"",0,0,"",0,0,"","","",},
        [58] = {2380,2,"","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [59] = {2381,3,"","","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [60] = {2382,3,"zhuangtai_teshu_a_01xuanyun","1","","sp_03yunxuan",6,1,1,"","","","dizzy",2,"晕眩|人",0,0,"",0,0,"","","",},
        [61] = {2383,2,"zhuangtai_teshu_b_01wudi","0","","sp_08wudi",1,1,0,"","","","idle",0,"",0,0,"",0,0,"","","",},
        [62] = {2384,2,"zhuangtai_teshu_b_01xishou","0","","sp_07xishoushanghaidun",3,2,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [63] = {2385,3,"","","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [64] = {2392,2,"","","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [65] = {2393,3,"zhuangtai_teshu_b_01chenmo","1","","sp_04chenmo",7,3,1,"","","","",4,"沉默|人",0,0,"",0,0,"","","",},
        [66] = {2394,3,"zhuangtai_teshu_a_01xuanyun","1","","sp_03yunxuan",6,1,1,"","","","dizzy",2,"晕眩|人",0,0,"",0,0,"","","",},
        [67] = {2395,3,"zhuangtai_teshu_a_01xuanyun","1","","sp_03yunxuan",6,1,1,"","","","dizzy",2,"晕眩|人",0,0,"",0,0,"","","",},
        [68] = {2396,3,"zhuangtai_teshu_b_01chenmo","1","","sp_04chenmo",7,3,1,"","","","",4,"沉默|人",0,0,"",0,0,"","","",},
        [69] = {2397,3,"zhuangtai_teshu_b_01chenmo","1","","sp_04chenmo",7,3,1,"","","","",4,"沉默|人",0,0,"",0,0,"","","",},
        [70] = {2399,2,"zhuangtai_teshu_b_01qingchu","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [71] = {2400,2,"buff_01nuqi","0","","sp_15nuqijia",10,3,0,"","","","",5,"加怒|点",0,0,"",0,0,"","","",},
        [72] = {2403,2,"","","","sp_11baojijia",9,3,0,"","","","",0,"",1,2,"",0,0,"","","",},
        [73] = {2404,0,"zhuangtai_teshu_b_01qingchu","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [74] = {2405,2,"buff_01nuqi","0","","sp_15nuqijia",10,3,0,"","","","",5,"加怒|点",0,0,"",0,0,"","","",},
        [75] = {2407,2,"zhuangtai_teshu_b_menghu","","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [76] = {3001,6,"","","","sp_20010101",10,3,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [77] = {3002,6,"","","","sp_20010201",10,3,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [78] = {3003,6,"","","","sp_20010301",10,3,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [79] = {3004,6,"","","","sp_20010401",10,3,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [80] = {3005,6,"","","","sp_20020101",10,3,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [81] = {2410,2,"buff_01nuqi","0","","sp_15nuqijia",10,3,0,"","","","",5,"加怒|点",0,0,"",0,0,"","","",},
        [82] = {2411,2,"zhuangtai_teshu_b_01xishou","0","","sp_07xishoushanghaidun",3,2,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [83] = {2412,3,"zhuangtai_teshu_d_0fangzhu","1","","sp_7120021",15,1,0,"","","","dizzy",6,"放逐|人",0,0,"",0,0,"","smoving_losing","",},
        [84] = {2414,0,"zhuangtai_teshu_b_01qingchu","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [85] = {2416,0,"","","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [86] = {2419,3,"zhuangtai_teshu_b_01benlei","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [87] = {2420,2,"zhuangtai_teshu_b_01mianyi","0","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [88] = {2421,3,"zhuangtai_teshu_d_01zhongdu","1","","sp_05zhongdu",8,3,1,"poison","","","",0,"",0,0,"",0,0,"","","",},
        [89] = {2422,3,"zhuangtai_teshu_d_01zhongdu","1","","sp_05zhongdu",8,3,1,"poison","","","",0,"",0,0,"",0,0,"","","",},
        [90] = {2423,3,"zhuangtai_teshu_d_01zhongdu","1","","sp_05zhongdu",8,3,1,"poison","","","",0,"",0,0,"",0,0,"","","",},
        [91] = {2424,3,"zhuangtai_teshu_d_01zhongdu","1","","sp_05zhongdu",8,3,1,"poison","","","",0,"",0,0,"",0,0,"","","",},
        [92] = {2425,3,"zhuangtai_teshu_d_01zhongdu","1","","sp_05zhongdu",8,3,1,"poison","","","",0,"",0,0,"",0,0,"","","",},
        [93] = {2426,3,"zhuangtai_teshu_d_01zhongdu","1","","sp_05zhongdu",8,3,1,"poison","","","",0,"",0,0,"",0,0,"","","",},
        [94] = {2427,1,"zhuangtai_teshu_d_01jifei","1","","",0,0,0,"","","","",4,"击飞|人",0,0,"",0,0,"","","jifei",},
        [95] = {2428,3,"zhuangtai_teshu_d_01tiesuo","1","","sp_4500021",8,3,1,"","","","",0,"",0,0,"",0,0,"","","",},
        [96] = {2429,2,"","","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [97] = {2432,2,"zhuangtai_teshu_b_01zhuiji","1","","",0,0,0,"","","","",0,"",0,0,"",0,0,"","","",},
        [98] = {2433,2,"buff_01nuqi","0","","sp_15nuqijia",10,3,0,"","","","",5,"加怒|点",0,0,"",0,0,"","","",},
        [99] = {2435,0,"buff_01nuqi","0","","sp_15nuqijia",10,3,0,"","","","",5,"加怒|点",0,0,"",0,0,"","","",},
    }
}

-- index
local __index_buff_type = {
    [2101] = 1,
    [2102] = 2,
    [2103] = 3,
    [2104] = 4,
    [2105] = 7,
    [2106] = 8,
    [2107] = 28,
    [2108] = 9,
    [2109] = 24,
    [2110] = 23,
    [2113] = 33,
    [2114] = 5,
    [2117] = 22,
    [2121] = 10,
    [2201] = 17,
    [2202] = 18,
    [2203] = 19,
    [2204] = 20,
    [2205] = 21,
    [2206] = 31,
    [2302] = 11,
    [2303] = 27,
    [2306] = 25,
    [2307] = 26,
    [2308] = 12,
    [2309] = 32,
    [2311] = 13,
    [2335] = 14,
    [2336] = 15,
    [2338] = 34,
    [2339] = 35,
    [2340] = 36,
    [2341] = 37,
    [2342] = 38,
    [2343] = 39,
    [2344] = 40,
    [2345] = 41,
    [2351] = 16,
    [2352] = 51,
    [2359] = 53,
    [2362] = 42,
    [2363] = 43,
    [2365] = 44,
    [2367] = 46,
    [2368] = 47,
    [2369] = 50,
    [2370] = 45,
    [2373] = 48,
    [2374] = 49,
    [2375] = 52,
    [2376] = 54,
    [2377] = 55,
    [2378] = 56,
    [2379] = 57,
    [2380] = 58,
    [2381] = 59,
    [2382] = 60,
    [2383] = 61,
    [2384] = 62,
    [2385] = 63,
    [2392] = 64,
    [2393] = 65,
    [2394] = 66,
    [2395] = 67,
    [2396] = 68,
    [2397] = 69,
    [2399] = 70,
    [2400] = 71,
    [2401] = 29,
    [2402] = 30,
    [2403] = 72,
    [2404] = 73,
    [2405] = 74,
    [2407] = 75,
    [2410] = 81,
    [2411] = 82,
    [2412] = 83,
    [2414] = 84,
    [2416] = 85,
    [2419] = 86,
    [2420] = 87,
    [2421] = 88,
    [2422] = 89,
    [2423] = 90,
    [2424] = 91,
    [2425] = 92,
    [2426] = 93,
    [2427] = 94,
    [2428] = 95,
    [2429] = 96,
    [2432] = 97,
    [2433] = 98,
    [2435] = 99,
    [3001] = 76,
    [3002] = 77,
    [3003] = 78,
    [3004] = 79,
    [3005] = 80,
    [3333] = 6,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in hero_skill_effect")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function hero_skill_effect.length()
    return #hero_skill_effect._data
end

-- 
function hero_skill_effect.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function hero_skill_effect.indexOf(index)
    if index == nil or not hero_skill_effect._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/hero_skill_effect.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "hero_skill_effect" )
        return setmetatable({_raw = hero_skill_effect._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = hero_skill_effect._data[index]}, mt)
end

--
function hero_skill_effect.get(buff_type)
    
    return hero_skill_effect.indexOf(__index_buff_type[buff_type])
        
end

--
function hero_skill_effect.set(buff_type, key, value)
    local record = hero_skill_effect.get(buff_type)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function hero_skill_effect.index()
    return __index_buff_type
end

return hero_skill_effect