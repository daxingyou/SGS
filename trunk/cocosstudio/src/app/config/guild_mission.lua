--guild_mission

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  guild_level = 2,    --军团等级-int 
  box_id = 3,    --宝箱id-int 
  need_exp = 4,    --需要声望-int 
  drop = 5,    --掉落组id-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  guild_level = "int",    --军团等级-2 
  box_id = "int",    --宝箱id-3 
  need_exp = "int",    --需要声望-4 
  drop = "int",    --掉落组id-5 

}


-- data
local guild_mission = {
    version =  1,
    _data = {
        [1] = {1,1,1,5000,7101,},
        [2] = {2,1,2,10000,7102,},
        [3] = {3,1,3,15000,7103,},
        [4] = {4,1,4,20000,7104,},
        [5] = {11,2,1,5000,7105,},
        [6] = {12,2,2,10000,7106,},
        [7] = {13,2,3,15000,7107,},
        [8] = {14,2,4,20000,7108,},
        [9] = {21,3,1,5000,7109,},
        [10] = {22,3,2,10000,7110,},
        [11] = {23,3,3,15000,7111,},
        [12] = {24,3,4,20000,7112,},
        [13] = {31,4,1,5000,7113,},
        [14] = {32,4,2,10000,7114,},
        [15] = {33,4,3,15000,7115,},
        [16] = {34,4,4,20000,7116,},
        [17] = {41,5,1,5000,7117,},
        [18] = {42,5,2,10000,7118,},
        [19] = {43,5,3,15000,7119,},
        [20] = {44,5,4,20000,7120,},
        [21] = {51,6,1,5000,7121,},
        [22] = {52,6,2,10000,7122,},
        [23] = {53,6,3,15000,7123,},
        [24] = {54,6,4,20000,7124,},
        [25] = {61,7,1,5000,7125,},
        [26] = {62,7,2,10000,7126,},
        [27] = {63,7,3,15000,7127,},
        [28] = {64,7,4,20000,7128,},
        [29] = {71,8,1,5000,7129,},
        [30] = {72,8,2,10000,7130,},
        [31] = {73,8,3,15000,7131,},
        [32] = {74,8,4,20000,7132,},
        [33] = {81,9,1,5000,7133,},
        [34] = {82,9,2,10000,7134,},
        [35] = {83,9,3,15000,7135,},
        [36] = {84,9,4,20000,7136,},
        [37] = {91,10,1,5000,7137,},
        [38] = {92,10,2,10000,7138,},
        [39] = {93,10,3,15000,7139,},
        [40] = {94,10,4,20000,7140,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [11] = 5,
    [12] = 6,
    [13] = 7,
    [14] = 8,
    [2] = 2,
    [21] = 9,
    [22] = 10,
    [23] = 11,
    [24] = 12,
    [3] = 3,
    [31] = 13,
    [32] = 14,
    [33] = 15,
    [34] = 16,
    [4] = 4,
    [41] = 17,
    [42] = 18,
    [43] = 19,
    [44] = 20,
    [51] = 21,
    [52] = 22,
    [53] = 23,
    [54] = 24,
    [61] = 25,
    [62] = 26,
    [63] = 27,
    [64] = 28,
    [71] = 29,
    [72] = 30,
    [73] = 31,
    [74] = 32,
    [81] = 33,
    [82] = 34,
    [83] = 35,
    [84] = 36,
    [91] = 37,
    [92] = 38,
    [93] = 39,
    [94] = 40,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [5] = 11,
    [6] = 12,
    [7] = 13,
    [8] = 14,
    [2] = 2,
    [9] = 21,
    [10] = 22,
    [11] = 23,
    [12] = 24,
    [3] = 3,
    [13] = 31,
    [14] = 32,
    [15] = 33,
    [16] = 34,
    [4] = 4,
    [17] = 41,
    [18] = 42,
    [19] = 43,
    [20] = 44,
    [21] = 51,
    [22] = 52,
    [23] = 53,
    [24] = 54,
    [25] = 61,
    [26] = 62,
    [27] = 63,
    [28] = 64,
    [29] = 71,
    [30] = 72,
    [31] = 73,
    [32] = 74,
    [33] = 81,
    [34] = 82,
    [35] = 83,
    [36] = 84,
    [37] = 91,
    [38] = 92,
    [39] = 93,
    [40] = 94,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in guild_mission")
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
function guild_mission.length()
    return #guild_mission._data
end

-- 
function guild_mission.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_mission.isVersionValid(v)
    if guild_mission.version then
        if v then
            return guild_mission.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_mission.indexOf(index)
    if index == nil or not guild_mission._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_mission.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_mission.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_mission.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_mission" )
                _isDataExist = guild_mission.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_mission" )
                _isBaseExist = guild_mission.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_mission" )
                _isExist = guild_mission.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_mission" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_mission" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_mission._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_mission" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_mission.get(id)
    
    return guild_mission.indexOf(__index_id[id])
        
end

--
function guild_mission.set(id, key, value)
    local record = guild_mission.get(id)
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
function guild_mission.index()
    return __index_id
end

return guild_mission