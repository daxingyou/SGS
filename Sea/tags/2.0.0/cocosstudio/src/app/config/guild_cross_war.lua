--guild_cross_war

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --索引id-int 
  type = 2,    --据点类型-int 
  move = 3,    --可移动到的据点-string 
  point_name = 4,    --据点名字-string 
  name_x = 5,    --据点名字x-int 
  name_y = 6,    --据点名字y-int 
  yield = 7,    --据点产量-int 
  boss = 8,    --据点BOSS怪物组-int 
  name = 9,    --BOSS名称-string 
  color = 10,    --品质-int 
  boss_res = 11,    --Boss形象-int 
  boss_place = 12,    --Boss所在格子id-int 
  boss_x = 13,    --BOSSx坐标-int 
  boss_y = 14,    --BOSSy坐标-int 
  map_x = 15,    --据点坐标X-int 
  map_y = 16,    --据点坐标Y-int 
  range_x = 17,    --点击区域宽-int 
  range_y = 18,    --点击区域高-int 

}

-- key type
local __key_type = {
  id = "int",    --索引id-1 
  type = "int",    --据点类型-2 
  move = "string",    --可移动到的据点-3 
  point_name = "string",    --据点名字-4 
  name_x = "int",    --据点名字x-5 
  name_y = "int",    --据点名字y-6 
  yield = "int",    --据点产量-7 
  boss = "int",    --据点BOSS怪物组-8 
  name = "string",    --BOSS名称-9 
  color = "int",    --品质-10 
  boss_res = "int",    --Boss形象-11 
  boss_place = "int",    --Boss所在格子id-12 
  boss_x = "int",    --BOSSx坐标-13 
  boss_y = "int",    --BOSSy坐标-14 
  map_x = "int",    --据点坐标X-15 
  map_y = "int",    --据点坐标Y-16 
  range_x = "int",    --点击区域宽-17 
  range_y = "int",    --点击区域高-18 

}


-- data
local guild_cross_war = {
    _data = {
        [1] = {1,1,"17","军营驻地",3951,2959,0,3200101,"黄巾贼亡魂",5,10001,806,3913,2808,3951,2959,300,300,},
        [2] = {2,1,"17","军营驻地",4478,2591,0,3200101,"黄巾贼亡魂",5,10001,860,4234,2433,4478,2591,300,300,},
        [3] = {3,1,"18","军营驻地",4691,1912,0,3200101,"黄巾贼亡魂",5,10001,911,4448,1813,4691,1912,300,300,},
        [4] = {4,1,"18","军营驻地",4575,1332,0,3200101,"黄巾贼亡魂",5,10001,880,4340,1464,4575,1332,300,300,},
        [5] = {5,1,"19","军营驻地",4056,845,0,3200101,"黄巾贼亡魂",5,10001,793,3787,920,4056,845,300,300,},
        [6] = {6,1,"19","军营驻地",3311,596,0,3200101,"黄巾贼亡魂",5,10001,651,3230,782,3311,596,300,300,},
        [7] = {7,1,"20","军营驻地",2574,430,0,3200101,"黄巾贼亡魂",5,10001,538,2553,595,2574,430,300,300,},
        [8] = {8,1,"20","军营驻地",1700,649,0,3200101,"黄巾贼亡魂",5,10001,400,1973,807,1700,649,300,300,},
        [9] = {9,1,"21","军营驻地",861,842,0,3200101,"黄巾贼亡魂",5,10001,233,1125,905,861,842,300,300,},
        [10] = {10,1,"21","军营驻地",815,1387,0,3200101,"黄巾贼亡魂",5,10001,236,1077,1373,815,1387,300,300,},
        [11] = {11,1,"22","军营驻地",786,1839,0,3200101,"黄巾贼亡魂",5,10001,240,1055,1851,786,1839,300,300,},
        [12] = {12,1,"22","军营驻地",897,2319,0,3200101,"黄巾贼亡魂",5,10001,271,1107,2244,897,2319,300,300,},
        [13] = {13,1,"23","军营驻地",1349,2656,0,3200101,"黄巾贼亡魂",5,10001,329,1520,2527,1349,2656,300,300,},
        [14] = {14,1,"23","军营驻地",1830,2999,0,3200101,"黄巾贼亡魂",5,10001,415,1850,2874,1830,2999,300,300,},
        [15] = {15,1,"24","军营驻地",2487,2848,0,3200101,"黄巾贼亡魂",5,10001,554,2516,2693,2487,2848,300,300,},
        [16] = {16,1,"24","军营驻地",3137,3015,0,3200101,"黄巾贼亡魂",5,10001,639,3061,2883,3137,3015,300,300,},
        [17] = {17,2,"1|2|18|25","青州",3641,2305,1,0,"",0,0,0,0,0,3641,2305,400,400,},
        [18] = {18,2,"3|4|17|25","徐州",3834,1673,1,0,"",0,0,0,0,0,3834,1673,400,400,},
        [19] = {19,2,"5|6|20|25","扬州",3258,1130,1,0,"",0,0,0,0,0,3258,1130,400,400,},
        [20] = {20,2,"7|8|19|25","荆州",2341,947,1,0,"",0,0,0,0,0,2341,947,400,400,},
        [21] = {21,2,"9|10|22|25","益州",1531,1271,1,0,"",0,0,0,0,0,1531,1271,400,400,},
        [22] = {22,2,"11|12|21|25","凉州",1441,2001,1,0,"",0,0,0,0,0,1441,2001,400,400,},
        [23] = {23,2,"13|14|24|25","并州",2031,2344,1,0,"",0,0,0,0,0,2031,2344,400,400,},
        [24] = {24,2,"15|16|23|25","幽州",2866,2441,1,0,"",0,0,0,0,0,2866,2441,400,400,},
        [25] = {25,2,"17|18|19|20|21|22|23|24","中州",2624,1632,2,0,"",0,0,0,0,0,2624,1632,800,500,},
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

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in guild_cross_war")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
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
function guild_cross_war.indexOf(index)
    if index == nil or not guild_cross_war._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/guild_cross_war.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war" )
        return setmetatable({_raw = guild_cross_war._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = guild_cross_war._data[index]}, mt)
end

--
function guild_cross_war.get(id)
    
    return guild_cross_war.indexOf(__index_id[id])
        
end

--
function guild_cross_war.set(id, key, value)
    local record = guild_cross_war.get(id)
    if record then
        local keyIndex = __key_map[key]
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