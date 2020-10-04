--daily_dungeon

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  type = 2,    --副本类型-int 
  pre_id = 3,    --前置副本id-int 
  level = 4,    --开启等级-int 
  color = 5,    --难度品质-int 
  difficulty = 6,    --难度名称-string 
  battle_background = 7,    --战斗场景-int 
  monster_team_id = 8,    --怪物组关联id-int 
  drop_1 = 9,    --普通掉落1-int 
  drop_2 = 10,    --普通掉落2-int 
  drop_3 = 11,    --普通掉落3-int 
  drop_4 = 12,    --普通掉落4-int 
  drop_5 = 13,    --普通掉落5-int 
  drop_6 = 14,    --普通掉落6-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  type = "int",    --副本类型-2 
  pre_id = "int",    --前置副本id-3 
  level = "int",    --开启等级-4 
  color = "int",    --难度品质-5 
  difficulty = "string",    --难度名称-6 
  battle_background = "int",    --战斗场景-7 
  monster_team_id = "int",    --怪物组关联id-8 
  drop_1 = "int",    --普通掉落1-9 
  drop_2 = "int",    --普通掉落2-10 
  drop_3 = "int",    --普通掉落3-11 
  drop_4 = "int",    --普通掉落4-12 
  drop_5 = "int",    --普通掉落5-13 
  drop_6 = "int",    --普通掉落6-14 

}


-- data
local daily_dungeon = {
    _data = {
        [1] = {1001,1,0,27,1,"简单",1,2100001,5001,0,0,0,0,0,},
        [2] = {1002,1,1001,27,2,"普通",1,2100002,5002,0,0,0,0,0,},
        [3] = {1003,1,1002,27,3,"困难",1,2100003,5003,0,0,0,0,0,},
        [4] = {1004,1,1003,67,4,"英雄",1,2100004,5004,0,0,0,0,0,},
        [5] = {1005,1,1004,77,5,"史诗",1,2100005,5005,0,0,0,0,0,},
        [6] = {1006,1,1005,87,6,"传说",1,2100006,5006,0,0,0,0,0,},
        [7] = {1007,1,1006,95,6,"傲世",1,2100007,5007,0,0,0,0,0,},
        [8] = {1008,1,1007,102,6,"至尊",1,2100008,5008,0,0,0,0,0,},
        [9] = {2001,2,0,22,1,"简单",2,2200001,5101,0,0,0,0,0,},
        [10] = {2002,2,2001,22,2,"普通",2,2200002,5102,0,0,0,0,0,},
        [11] = {2003,2,2002,22,3,"困难",2,2200003,5103,0,0,0,0,0,},
        [12] = {2004,2,2003,62,4,"英雄",2,2200004,5104,0,0,0,0,0,},
        [13] = {2005,2,2004,72,5,"史诗",2,2200005,5105,0,0,0,0,0,},
        [14] = {2006,2,2005,87,6,"传说",2,2200006,5106,0,0,0,0,0,},
        [15] = {2007,2,2006,95,6,"傲世",2,2200007,5107,0,0,0,0,0,},
        [16] = {2008,2,2007,102,6,"至尊",2,2200008,5108,0,0,0,0,0,},
        [17] = {3001,3,0,32,1,"简单",3,2300001,5201,0,0,0,0,0,},
        [18] = {3002,3,3001,32,2,"普通",3,2300002,5202,0,0,0,0,0,},
        [19] = {3003,3,3002,32,3,"困难",3,2300003,5203,0,0,0,0,0,},
        [20] = {3004,3,3003,67,4,"英雄",3,2300004,5204,0,0,0,0,0,},
        [21] = {3005,3,3004,77,5,"史诗",3,2300005,5205,0,0,0,0,0,},
        [22] = {3006,3,3005,87,6,"传说",3,2300006,5206,0,0,0,0,0,},
        [23] = {3007,3,3006,95,6,"傲世",3,2300007,5207,0,0,0,0,0,},
        [24] = {3008,3,3007,102,6,"至尊",3,2300008,5208,0,0,0,0,0,},
        [25] = {4001,4,0,40,1,"简单",4,2400001,5301,0,0,0,0,0,},
        [26] = {4002,4,4001,52,2,"普通",4,2400002,5302,0,0,0,0,0,},
        [27] = {4003,4,4002,67,3,"困难",4,2400003,5303,0,0,0,0,0,},
        [28] = {4004,4,4003,82,4,"英雄",4,2400004,5304,0,0,0,0,0,},
        [29] = {4005,4,4004,90,5,"史诗",4,2400005,5305,0,0,0,0,0,},
        [30] = {4006,4,4005,95,6,"传说",4,2400006,5306,0,0,0,0,0,},
        [31] = {4007,4,4006,100,6,"傲世",4,2400007,5307,0,0,0,0,0,},
        [32] = {4008,4,4007,105,6,"至尊",4,2400008,5308,0,0,0,0,0,},
        [33] = {5001,5,0,37,1,"简单",5,2500001,5401,0,0,0,0,0,},
        [34] = {5002,5,5001,47,2,"普通",5,2500002,5402,0,0,0,0,0,},
        [35] = {5003,5,5002,62,3,"困难",5,2500003,5403,0,0,0,0,0,},
        [36] = {5004,5,5003,77,4,"英雄",5,2500004,5404,0,0,0,0,0,},
        [37] = {5005,5,5004,85,5,"史诗",5,2500005,5405,0,0,0,0,0,},
        [38] = {5006,5,5005,90,6,"传说",5,2500006,5406,0,0,0,0,0,},
        [39] = {5007,5,5006,95,6,"傲世",5,2500007,5407,0,0,0,0,0,},
        [40] = {5008,5,5007,100,6,"至尊",5,2500008,5408,0,0,0,0,0,},
        [41] = {6001,6,0,52,1,"简单",6,2600001,5501,0,0,0,0,0,},
        [42] = {6002,6,6001,60,2,"普通",6,2600002,5502,0,0,0,0,0,},
        [43] = {6003,6,6002,70,3,"困难",6,2600003,5503,0,0,0,0,0,},
        [44] = {6004,6,6003,80,4,"英雄",6,2600004,5504,0,0,0,0,0,},
        [45] = {6005,6,6004,88,5,"史诗",6,2600005,5505,0,0,0,0,0,},
        [46] = {6006,6,6005,96,6,"传说",6,2600006,5506,0,0,0,0,0,},
        [47] = {6007,6,6006,104,6,"傲世",6,2600007,5507,0,0,0,0,0,},
        [48] = {6008,6,6007,110,6,"至尊",6,2600008,5508,0,0,0,0,0,},
        [49] = {7001,7,0,46,1,"简单",7,2700001,5601,0,0,0,0,0,},
        [50] = {7002,7,7001,56,2,"普通",7,2700002,5602,0,0,0,0,0,},
        [51] = {7003,7,7002,66,3,"困难",7,2700003,5603,0,0,0,0,0,},
        [52] = {7004,7,7003,76,4,"英雄",7,2700004,5604,0,0,0,0,0,},
        [53] = {7005,7,7004,84,5,"史诗",7,2700005,5605,0,0,0,0,0,},
        [54] = {7006,7,7005,92,6,"传说",7,2700006,5606,0,0,0,0,0,},
        [55] = {7007,7,7006,100,6,"傲世",7,2700007,5607,0,0,0,0,0,},
        [56] = {7008,7,7007,112,6,"至尊",7,2700008,5608,0,0,0,0,0,},
        [57] = {8001,8,0,70,1,"简单",8,2800001,5701,0,0,0,0,0,},
        [58] = {8002,8,8001,80,2,"普通",8,2800002,5702,0,0,0,0,0,},
        [59] = {8003,8,8002,85,3,"困难",8,2800003,5703,0,0,0,0,0,},
        [60] = {8004,8,8003,90,4,"英雄",8,2800004,5704,0,0,0,0,0,},
        [61] = {8005,8,8004,95,5,"史诗",8,2800005,5705,0,0,0,0,0,},
        [62] = {8006,8,8005,100,6,"传说",8,2800006,5706,0,0,0,0,0,},
        [63] = {8007,8,8006,105,6,"傲世",8,2800007,5707,0,0,0,0,0,},
        [64] = {8008,8,8007,110,6,"至尊",8,2800008,5708,0,0,0,0,0,},
    }
}

-- index
local __index_id = {
    [1001] = 1,
    [1002] = 2,
    [1003] = 3,
    [1004] = 4,
    [1005] = 5,
    [1006] = 6,
    [1007] = 7,
    [1008] = 8,
    [2001] = 9,
    [2002] = 10,
    [2003] = 11,
    [2004] = 12,
    [2005] = 13,
    [2006] = 14,
    [2007] = 15,
    [2008] = 16,
    [3001] = 17,
    [3002] = 18,
    [3003] = 19,
    [3004] = 20,
    [3005] = 21,
    [3006] = 22,
    [3007] = 23,
    [3008] = 24,
    [4001] = 25,
    [4002] = 26,
    [4003] = 27,
    [4004] = 28,
    [4005] = 29,
    [4006] = 30,
    [4007] = 31,
    [4008] = 32,
    [5001] = 33,
    [5002] = 34,
    [5003] = 35,
    [5004] = 36,
    [5005] = 37,
    [5006] = 38,
    [5007] = 39,
    [5008] = 40,
    [6001] = 41,
    [6002] = 42,
    [6003] = 43,
    [6004] = 44,
    [6005] = 45,
    [6006] = 46,
    [6007] = 47,
    [6008] = 48,
    [7001] = 49,
    [7002] = 50,
    [7003] = 51,
    [7004] = 52,
    [7005] = 53,
    [7006] = 54,
    [7007] = 55,
    [7008] = 56,
    [8001] = 57,
    [8002] = 58,
    [8003] = 59,
    [8004] = 60,
    [8005] = 61,
    [8006] = 62,
    [8007] = 63,
    [8008] = 64,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in daily_dungeon")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function daily_dungeon.length()
    return #daily_dungeon._data
end

-- 
function daily_dungeon.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function daily_dungeon.indexOf(index)
    if index == nil or not daily_dungeon._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/daily_dungeon.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "daily_dungeon" )
        return setmetatable({_raw = daily_dungeon._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = daily_dungeon._data[index]}, mt)
end

--
function daily_dungeon.get(id)
    
    return daily_dungeon.indexOf(__index_id[id])
        
end

--
function daily_dungeon.set(id, key, value)
    local record = daily_dungeon.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function daily_dungeon.index()
    return __index_id
end

return daily_dungeon