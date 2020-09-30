--goldenhero_draw

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  drop_id = 1,    --抽奖库-int 
  type = 2,    --奖品类型-int 
  value = 3,    --奖品类型值-int 
  size = 4,    --奖品数量-int 
  group = 5,    --奖品组数-int 
  time = 6,    --时间-int 

}

-- key type
local __key_type = {
  drop_id = "int",    --抽奖库-1 
  type = "int",    --奖品类型-2 
  value = "int",    --奖品类型值-3 
  size = "int",    --奖品数量-4 
  group = "int",    --奖品组数-5 
  time = "int",    --时间-6 

}


-- data
local goldenhero_draw = {
    version =  1,
    _data = {
        [1] = {1101,1,152,1,5,0,},
        [2] = {1102,6,555,12,10,1,},
        [3] = {1103,6,705,5,20,8,},
        [4] = {1104,1,251,1,5,9,},
        [5] = {1105,1,453,1,5,10,},
        [6] = {1106,6,705,5,20,11,},
        [7] = {1107,1,350,1,5,12,},
        [8] = {1108,6,555,12,10,13,},
        [9] = {1109,6,705,5,20,14,},
        [10] = {1110,1,452,1,5,15,},
        [11] = {1111,6,556,12,10,16,},
        [12] = {1112,6,705,5,20,17,},
        [13] = {1113,1,151,1,5,18,},
        [14] = {1114,1,353,1,5,19,},
        [15] = {1115,6,705,5,20,20,},
        [16] = {1116,1,250,1,5,21,},
        [17] = {1117,6,556,12,10,22,},
        [18] = {1118,6,705,5,20,23,},
        [19] = {1119,1,352,1,5,0,},
        [20] = {1120,6,555,12,10,1,},
        [21] = {1121,6,705,5,20,8,},
        [22] = {1122,1,451,1,5,9,},
        [23] = {1123,1,253,1,5,10,},
        [24] = {1124,6,705,5,20,11,},
        [25] = {1125,1,150,1,5,12,},
        [26] = {1126,6,555,12,10,13,},
        [27] = {1127,6,705,5,20,14,},
        [28] = {1128,1,252,1,5,15,},
        [29] = {1129,6,556,12,10,16,},
        [30] = {1130,6,705,5,20,17,},
        [31] = {1131,1,351,1,5,18,},
        [32] = {1132,1,153,1,5,19,},
        [33] = {1133,6,705,5,20,20,},
        [34] = {1134,1,450,1,5,21,},
    }
}

-- index
local __index_drop_id = {
    [1101] = 1,
    [1102] = 2,
    [1103] = 3,
    [1104] = 4,
    [1105] = 5,
    [1106] = 6,
    [1107] = 7,
    [1108] = 8,
    [1109] = 9,
    [1110] = 10,
    [1111] = 11,
    [1112] = 12,
    [1113] = 13,
    [1114] = 14,
    [1115] = 15,
    [1116] = 16,
    [1117] = 17,
    [1118] = 18,
    [1119] = 19,
    [1120] = 20,
    [1121] = 21,
    [1122] = 22,
    [1123] = 23,
    [1124] = 24,
    [1125] = 25,
    [1126] = 26,
    [1127] = 27,
    [1128] = 28,
    [1129] = 29,
    [1130] = 30,
    [1131] = 31,
    [1132] = 32,
    [1133] = 33,
    [1134] = 34,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1101,
    [2] = 1102,
    [3] = 1103,
    [4] = 1104,
    [5] = 1105,
    [6] = 1106,
    [7] = 1107,
    [8] = 1108,
    [9] = 1109,
    [10] = 1110,
    [11] = 1111,
    [12] = 1112,
    [13] = 1113,
    [14] = 1114,
    [15] = 1115,
    [16] = 1116,
    [17] = 1117,
    [18] = 1118,
    [19] = 1119,
    [20] = 1120,
    [21] = 1121,
    [22] = 1122,
    [23] = 1123,
    [24] = 1124,
    [25] = 1125,
    [26] = 1126,
    [27] = 1127,
    [28] = 1128,
    [29] = 1129,
    [30] = 1130,
    [31] = 1131,
    [32] = 1132,
    [33] = 1133,
    [34] = 1134,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in goldenhero_draw")
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
function goldenhero_draw.length()
    return #goldenhero_draw._data
end

-- 
function goldenhero_draw.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function goldenhero_draw.isVersionValid(v)
    if goldenhero_draw.version then
        if v then
            return goldenhero_draw.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function goldenhero_draw.indexOf(index)
    if index == nil or not goldenhero_draw._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/goldenhero_draw.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/goldenhero_draw.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/goldenhero_draw.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "goldenhero_draw" )
                _isDataExist = goldenhero_draw.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "goldenhero_draw" )
                _isBaseExist = goldenhero_draw.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "goldenhero_draw" )
                _isExist = goldenhero_draw.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "goldenhero_draw" )
        local main_key = __main_key_map[index]
		local index_key = "__index_drop_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "goldenhero_draw" )
        local main_key = __main_key_map[index]
		local index_key = "__index_drop_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = goldenhero_draw._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "goldenhero_draw" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function goldenhero_draw.get(drop_id)
    
    return goldenhero_draw.indexOf(__index_drop_id[drop_id])
        
end

--
function goldenhero_draw.set(drop_id, key, value)
    local record = goldenhero_draw.get(drop_id)
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
function goldenhero_draw.index()
    return __index_drop_id
end

return goldenhero_draw