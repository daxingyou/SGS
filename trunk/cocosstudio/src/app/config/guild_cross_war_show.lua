--guild_cross_war_show

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  x_position = 2,    --人X轴坐标-int 
  y_position = 3,    --人Y轴坐标-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  x_position = "int",    --人X轴坐标-2 
  y_position = "int",    --人Y轴坐标-3 

}


-- data
local guild_cross_war_show = {
    version =  1,
    _data = {
        [1] = {1,900,100,},
        [2] = {2,800,300,},
        [3] = {3,1000,300,},
        [4] = {4,800,500,},
        [5] = {5,1000,500,},
        [6] = {6,650,500,},
        [7] = {7,1150,500,},
        [8] = {8,800,700,},
        [9] = {9,1000,700,},
        [10] = {10,650,700,},
        [11] = {11,1150,700,},
        [12] = {12,500,700,},
        [13] = {13,1300,700,},
        [14] = {14,800,900,},
        [15] = {15,1000,900,},
        [16] = {16,650,900,},
        [17] = {17,1150,900,},
        [18] = {18,500,900,},
        [19] = {19,1300,900,},
        [20] = {20,800,1100,},
        [21] = {21,1000,1100,},
        [22] = {22,650,1100,},
        [23] = {23,1150,1100,},
        [24] = {24,500,1100,},
        [25] = {25,1300,1100,},
        [26] = {26,800,1300,},
        [27] = {27,1000,1300,},
        [28] = {28,650,1300,},
        [29] = {29,1150,1300,},
        [30] = {30,500,1300,},
        [31] = {31,1300,1300,},
        [32] = {32,800,1500,},
        [33] = {33,1000,1500,},
        [34] = {34,650,1500,},
        [35] = {35,1150,1500,},
        [36] = {36,500,1500,},
        [37] = {37,1300,1500,},
        [38] = {38,800,1700,},
        [39] = {39,1000,1700,},
        [40] = {40,650,1700,},
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
        assert(key_map[k], "cannot find " .. k .. " in guild_cross_war_show")
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
function guild_cross_war_show.length()
    return #guild_cross_war_show._data
end

-- 
function guild_cross_war_show.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_cross_war_show.isVersionValid(v)
    if guild_cross_war_show.version then
        if v then
            return guild_cross_war_show.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_cross_war_show.indexOf(index)
    if index == nil or not guild_cross_war_show._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_cross_war_show.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_cross_war_show.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_cross_war_show.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war_show" )
                _isDataExist = guild_cross_war_show.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war_show" )
                _isBaseExist = guild_cross_war_show.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war_show" )
                _isExist = guild_cross_war_show.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war_show" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war_show" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_cross_war_show._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war_show" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_cross_war_show.get(id)
    
    return guild_cross_war_show.indexOf(__index_id[id])
        
end

--
function guild_cross_war_show.set(id, key, value)
    local record = guild_cross_war_show.get(id)
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
function guild_cross_war_show.index()
    return __index_id
end

return guild_cross_war_show