--guild_stage_atk_reward

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  name = 2,    --名称-string 
  win_reward = 3,    --胜利奖励-int 
  lose_reward = 4,    --失败奖励-int 
  x_position = 5,    --人X轴坐标-int 
  y_position = 6,    --人Y轴坐标-int 
  boat = 7,    --船只类型-int 
  boat_x_position = 8,    --船X轴坐标-int 
  boat_y_position = 9,    --船Y轴坐标-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  name = "string",    --名称-2 
  win_reward = "int",    --胜利奖励-3 
  lose_reward = "int",    --失败奖励-4 
  x_position = "int",    --人X轴坐标-5 
  y_position = "int",    --人Y轴坐标-6 
  boat = "int",    --船只类型-7 
  boat_x_position = "int",    --船X轴坐标-8 
  boat_y_position = "int",    --船Y轴坐标-9 

}


-- data
local guild_stage_atk_reward = {
    version =  1,
    _data = {
        [1] = {1,"大将军",2000,200,590,3777,5,620,3792,},
        [2] = {2,"车骑将军",2000,200,990,3776,6,1020,3791,},
        [3] = {3,"骠骑将军",2000,200,1390,3795,5,1420,3810,},
        [4] = {4,"翊军将军",1900,200,590,3486,5,620,3501,},
        [5] = {5,"龙骧将军",1900,200,990,3518,6,1020,3533,},
        [6] = {6,"奋威将军",1900,200,1390,3502,3,1420,3517,},
        [7] = {7,"破虏将军",1800,200,590,3221,4,620,3236,},
        [8] = {8,"奋武将军",1800,200,990,3249,4,1020,3264,},
        [9] = {9,"讨逆将军",1800,200,1390,3244,3,1420,3259,},
        [10] = {10,"征虏将军",1700,200,590,2957,4,620,2972,},
        [11] = {11,"平东将军",1700,200,990,2958,4,1020,2973,},
        [12] = {12,"平南将军",1700,200,1390,2970,4,1420,2985,},
        [13] = {13,"平西将军",1600,200,590,2659,4,620,2674,},
        [14] = {14,"平北将军",1600,200,990,2687,4,1020,2702,},
        [15] = {15,"镇军将军",1600,200,1390,2680,3,1420,2695,},
        [16] = {16,"荡寇将军",1500,200,590,2409,3,620,2424,},
        [17] = {17,"平虏将军",1500,200,990,2385,4,1020,2400,},
        [18] = {18,"威远将军",1500,200,1390,2366,3,1420,2381,},
        [19] = {19,"绥远将军",1400,200,590,2112,3,620,2127,},
        [20] = {20,"牙门将军",1400,200,990,2104,4,1020,2119,},
        [21] = {21,"武威将军",1400,200,1390,2082,1,1420,2097,},
        [22] = {22,"武卫将军",1300,200,590,1801,1,620,1816,},
        [23] = {23,"平狄将军",1300,200,990,1811,2,1020,1826,},
        [24] = {24,"威虏将军",1300,200,1390,1815,1,1420,1830,},
        [25] = {25,"扬威将军",1200,200,590,1570,2,620,1585,},
        [26] = {26,"振威将军",1200,200,990,1549,1,1020,1564,},
        [27] = {27,"振武将军",1100,200,1390,1532,1,1420,1547,},
        [28] = {28,"鹰扬将军",1100,200,590,1283,1,620,1298,},
        [29] = {29,"偏将军",1000,200,990,1278,1,1020,1293,},
        [30] = {30,"扬武将军",1000,200,1390,1286,1,1420,1301,},
        [31] = {31,"折冲将军",900,200,590,976,2,620,991,},
        [32] = {32,"虎翼将军",900,200,990,1010,1,1020,1025,},
        [33] = {33,"裨将军",800,200,1390,995,2,1420,1010,},
        [34] = {34,"横野将军",800,200,590,685,2,620,700,},
        [35] = {35,"横江将军",700,200,990,704,1,1020,719,},
        [36] = {36,"建武将军",700,200,1390,699,2,1420,714,},
        [37] = {37,"伏波将军",600,200,590,427,2,620,442,},
        [38] = {38,"虎威将军",600,200,990,404,2,1020,419,},
        [39] = {39,"虎烈将军",500,200,1390,450,1,1420,465,},
        [40] = {40,"校尉",500,200,590,159,2,620,174,},
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
    [26] = 26,
    [27] = 27,
    [28] = 28,
    [29] = 29,
    [3] = 3,
    [30] = 30,
    [31] = 31,
    [32] = 32,
    [33] = 33,
    [34] = 34,
    [35] = 35,
    [36] = 36,
    [37] = 37,
    [38] = 38,
    [39] = 39,
    [4] = 4,
    [40] = 40,
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
    [26] = 26,
    [27] = 27,
    [28] = 28,
    [29] = 29,
    [3] = 3,
    [30] = 30,
    [31] = 31,
    [32] = 32,
    [33] = 33,
    [34] = 34,
    [35] = 35,
    [36] = 36,
    [37] = 37,
    [38] = 38,
    [39] = 39,
    [4] = 4,
    [40] = 40,
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
        assert(key_map[k], "cannot find " .. k .. " in guild_stage_atk_reward")
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
function guild_stage_atk_reward.length()
    return #guild_stage_atk_reward._data
end

-- 
function guild_stage_atk_reward.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_stage_atk_reward.isVersionValid(v)
    if guild_stage_atk_reward.version then
        if v then
            return guild_stage_atk_reward.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_stage_atk_reward.indexOf(index)
    if index == nil or not guild_stage_atk_reward._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_stage_atk_reward.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_stage_atk_reward.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_stage_atk_reward.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_stage_atk_reward" )
                _isDataExist = guild_stage_atk_reward.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_stage_atk_reward" )
                _isBaseExist = guild_stage_atk_reward.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_stage_atk_reward" )
                _isExist = guild_stage_atk_reward.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_stage_atk_reward" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_stage_atk_reward" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_stage_atk_reward._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_stage_atk_reward" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_stage_atk_reward.get(id)
    
    return guild_stage_atk_reward.indexOf(__index_id[id])
        
end

--
function guild_stage_atk_reward.set(id, key, value)
    local record = guild_stage_atk_reward.get(id)
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
function guild_stage_atk_reward.index()
    return __index_id
end

return guild_stage_atk_reward