--guild_cross_war

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --索引id-int 
  type = 2,    --据点类型-int 
  move = 3,    --可移动到的据点-string 
  point_name = 4,    --据点名字-string 
  name_x = 5,    --据点名字x-int 
  name_y = 6,    --据点名字y-int 
  flag_x = 7,    --大地图旗帜坐标X-int 
  flag_y = 8,    --大地图旗帜坐标y-int 
  yield = 9,    --据点产量-int 
  boss = 10,    --据点BOSS怪物组-int 
  name = 11,    --BOSS名称-string 
  face = 12,    --BOSS朝向0默认，1反向-int 
  color = 13,    --品质-int 
  boss_res = 14,    --Boss形象-int 
  boss_place = 15,    --Boss所在格子id-int 
  city_pic = 16,    --城池图片-string 
  city_hp = 17,    --城池血量-int 
  boss_x = 18,    --BOSSx坐标-int 
  boss_y = 19,    --BOSSy坐标-int 
  map_x = 20,    --据点坐标X-int 
  map_y = 21,    --据点坐标Y-int 
  range_x = 22,    --点击区域宽-int 
  range_y = 23,    --点击区域高-int 

}

-- key type
local __key_type = {
  id = "int",    --索引id-1 
  type = "int",    --据点类型-2 
  move = "string",    --可移动到的据点-3 
  point_name = "string",    --据点名字-4 
  name_x = "int",    --据点名字x-5 
  name_y = "int",    --据点名字y-6 
  flag_x = "int",    --大地图旗帜坐标X-7 
  flag_y = "int",    --大地图旗帜坐标y-8 
  yield = "int",    --据点产量-9 
  boss = "int",    --据点BOSS怪物组-10 
  name = "string",    --BOSS名称-11 
  face = "int",    --BOSS朝向0默认，1反向-12 
  color = "int",    --品质-13 
  boss_res = "int",    --Boss形象-14 
  boss_place = "int",    --Boss所在格子id-15 
  city_pic = "string",    --城池图片-16 
  city_hp = "int",    --城池血量-17 
  boss_x = "int",    --BOSSx坐标-18 
  boss_y = "int",    --BOSSy坐标-19 
  map_x = "int",    --据点坐标X-20 
  map_y = "int",    --据点坐标Y-21 
  range_x = "int",    --点击区域宽-22 
  range_y = "int",    --点击区域高-23 

}


-- data
local guild_cross_war = {
    version =  1,
    _data = {
        [1] = {1,1,"17","邯郸北",3426,2821,953,531,0,5400012,"黄巾贼亡魂",0,5,10001,806,"",0,3913,2808,3951,2959,300,300,},
        [2] = {2,1,"17","邯郸东",3877,2447,1063,463,0,5400012,"黄巾贼亡魂",0,5,10001,860,"",0,4234,2433,4478,2591,300,300,},
        [3] = {3,1,"18","合肥北",4076,1818,1102,339,0,5400012,"黄巾贼亡魂",0,5,10001,911,"",0,4448,1813,4691,1912,300,300,},
        [4] = {4,1,"18","合肥南",3974,1317,1087,249,0,5400012,"黄巾贼亡魂",0,5,10001,880,"",0,4340,1464,4575,1332,300,300,},
        [5] = {5,1,"19","武陵东",3543,881,984,162,0,5400012,"黄巾贼亡魂",0,5,10001,793,"",0,3787,920,4056,845,300,300,},
        [6] = {6,1,"19","武陵南",2923,623,826,113,0,5400012,"黄巾贼亡魂",0,5,10001,651,"",0,3230,782,3311,596,300,300,},
        [7] = {7,1,"20","白帝南",2330,496,680,89,0,5400012,"黄巾贼亡魂",0,5,10001,538,"",0,2553,595,2574,430,300,300,},
        [8] = {8,1,"20","白帝西",1616,711,509,140,0,5400012,"黄巾贼亡魂",1,5,10001,400,"",0,1973,807,1700,649,300,300,},
        [9] = {9,1,"21","街亭南",924,863,336,164,0,5400012,"黄巾贼亡魂",1,5,10001,233,"",0,1125,905,861,842,300,300,},
        [10] = {10,1,"21","街亭北",843,1370,316,259,0,5400012,"黄巾贼亡魂",1,5,10001,236,"",0,1077,1373,815,1387,300,300,},
        [11] = {11,1,"22","石城南",813,1772,311,337,0,5400012,"黄巾贼亡魂",1,5,10001,240,"",0,1055,1851,786,1839,300,300,},
        [12] = {12,1,"22","石城北",917,2249,332,429,0,5400012,"黄巾贼亡魂",1,5,10001,271,"",0,1107,2244,897,2319,300,300,},
        [13] = {13,1,"23","朔方西",1281,2556,425,489,0,5400012,"黄巾贼亡魂",1,5,10001,329,"",0,1520,2527,1349,2656,300,300,},
        [14] = {14,1,"23","朔方北",1708,2851,529,540,0,5400012,"黄巾贼亡魂",1,5,10001,415,"",0,1850,2874,1830,2999,300,300,},
        [15] = {15,1,"24","乌巢西",2243,2740,661,521,0,5400012,"黄巾贼亡魂",1,5,10001,554,"",0,2516,2693,2487,2848,300,300,},
        [16] = {16,1,"24","乌巢东",2780,2853,791,543,0,5400012,"黄巾贼亡魂",0,5,10001,639,"",0,3061,2883,3137,3015,300,300,},
        [17] = {17,2,"1|2|18|25","邯郸",3211,2228,642,445,20,0,"",0,0,0,747,"city_2",100,0,0,3641,2305,400,400,},
        [18] = {18,2,"3|4|17|25","合肥",3363,1610,672,322,20,0,"",0,0,0,798,"city_2",100,0,0,3834,1673,400,400,},
        [19] = {19,2,"5|6|20|25","武陵",2870,1107,574,221,20,0,"",0,0,0,682,"city_2",100,0,0,3258,1130,400,400,},
        [20] = {20,2,"7|8|19|25","白帝",2144,992,428,198,20,0,"",0,0,0,513,"city_2",100,0,0,2341,947,400,400,},
        [21] = {21,2,"9|10|22|25","街亭",1454,1234,460,240,20,0,"",0,0,0,347,"city_2",100,0,0,1531,1271,400,400,},
        [22] = {22,2,"11|12|21|25","石城",1406,1942,281,388,20,0,"",0,0,0,353,"city_2",100,0,0,1441,2001,400,400,},
        [23] = {23,2,"13|14|24|25","朔方",1883,2237,376,447,20,0,"",0,0,0,440,"city_2",100,0,0,2031,2344,400,400,},
        [24] = {24,2,"15|16|23|25","乌巢",2492,2325,498,465,20,0,"",0,0,0,608,"city_2",100,0,0,2866,2441,400,400,},
        [25] = {25,2,"17|18|19|20|21|22|23|24","宛城",2374,1638,474,327,50,0,"",0,0,0,546,"city_1",100,0,0,2624,1632,800,500,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [20] = 20,
    [21] = 21,
    [22] = 22,
    [23] = 23,
    [24] = 24,
    [25] = 25,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [20] = 20,
    [21] = 21,
    [22] = 22,
    [23] = 23,
    [24] = 24,
    [25] = 25,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in guild_cross_war")
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
function guild_cross_war.length()
    return #guild_cross_war._data
end

-- 
function guild_cross_war.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_cross_war.isVersionValid(v)
    if guild_cross_war.version then
        if v then
            return guild_cross_war.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_cross_war.indexOf(index)
    if index == nil or not guild_cross_war._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_cross_war.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_cross_war.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_cross_war.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war" )
                _isDataExist = guild_cross_war.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war" )
                _isBaseExist = guild_cross_war.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war" )
                _isExist = guild_cross_war.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_cross_war._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_cross_war.get(id)
    
    return guild_cross_war.indexOf(__index_id[id])
        
end

--
function guild_cross_war.set(id, key, value)
    local record = guild_cross_war.get(id)
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
function guild_cross_war.index()
    return __index_id
end

return guild_cross_war