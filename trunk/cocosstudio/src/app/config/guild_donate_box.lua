--guild_donate_box

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  guild_level = 2,    --军团等级-int 
  box_id = 3,    --宝箱id-int 
  need_score = 4,    --需要声望-int 
  drop = 5,    --掉落组id-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  guild_level = "int",    --军团等级-2 
  box_id = "int",    --宝箱id-3 
  need_score = "int",    --需要声望-4 
  drop = "int",    --掉落组id-5 

}


-- data
local guild_donate_box = {
    version =  1,
    _data = {
        [1] = {1,1,1,8,7001,},
        [2] = {2,1,2,16,7002,},
        [3] = {3,1,3,24,7003,},
        [4] = {4,1,4,32,7004,},
        [5] = {11,2,1,8,7005,},
        [6] = {12,2,2,16,7006,},
        [7] = {13,2,3,24,7007,},
        [8] = {14,2,4,32,7008,},
        [9] = {21,3,1,8,7009,},
        [10] = {22,3,2,16,7010,},
        [11] = {23,3,3,24,7011,},
        [12] = {24,3,4,32,7012,},
        [13] = {31,4,1,8,7013,},
        [14] = {32,4,2,16,7014,},
        [15] = {33,4,3,24,7015,},
        [16] = {34,4,4,32,7016,},
        [17] = {41,5,1,8,7017,},
        [18] = {42,5,2,16,7018,},
        [19] = {43,5,3,24,7019,},
        [20] = {44,5,4,32,7020,},
        [21] = {51,6,1,8,7021,},
        [22] = {52,6,2,16,7022,},
        [23] = {53,6,3,24,7023,},
        [24] = {54,6,4,32,7024,},
        [25] = {61,7,1,8,7025,},
        [26] = {62,7,2,16,7026,},
        [27] = {63,7,3,24,7027,},
        [28] = {64,7,4,32,7028,},
        [29] = {71,8,1,8,7029,},
        [30] = {72,8,2,16,7030,},
        [31] = {73,8,3,24,7031,},
        [32] = {74,8,4,32,7032,},
        [33] = {81,9,1,8,7033,},
        [34] = {82,9,2,16,7034,},
        [35] = {83,9,3,24,7035,},
        [36] = {84,9,4,32,7036,},
        [37] = {91,10,1,8,7037,},
        [38] = {92,10,2,16,7038,},
        [39] = {93,10,3,24,7039,},
        [40] = {94,10,4,32,7040,},
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
        assert(key_map[k], "cannot find " .. k .. " in guild_donate_box")
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
function guild_donate_box.length()
    return #guild_donate_box._data
end

-- 
function guild_donate_box.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_donate_box.isVersionValid(v)
    if guild_donate_box.version then
        if v then
            return guild_donate_box.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_donate_box.indexOf(index)
    if index == nil or not guild_donate_box._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_donate_box.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_donate_box.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_donate_box.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_donate_box" )
                _isDataExist = guild_donate_box.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_donate_box" )
                _isBaseExist = guild_donate_box.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_donate_box" )
                _isExist = guild_donate_box.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_donate_box" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_donate_box" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_donate_box._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_donate_box" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_donate_box.get(id)
    
    return guild_donate_box.indexOf(__index_id[id])
        
end

--
function guild_donate_box.set(id, key, value)
    local record = guild_donate_box.get(id)
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
function guild_donate_box.index()
    return __index_id
end

return guild_donate_box