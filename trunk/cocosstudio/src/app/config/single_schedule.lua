--single_schedule

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  top32 = 1,    --32强位置-int 
  nxet_position = 2,    --下轮位置-int 
  score = 3,    --积分-int 

}

-- key type
local __key_type = {
  top32 = "int",    --32强位置-1 
  nxet_position = "int",    --下轮位置-2 
  score = "int",    --积分-3 

}


-- data
local single_schedule = {
    version =  1,
    _data = {
        [1] = {1,33,0,},
        [2] = {2,33,0,},
        [3] = {3,34,0,},
        [4] = {4,34,0,},
        [5] = {5,35,0,},
        [6] = {6,35,0,},
        [7] = {7,36,0,},
        [8] = {8,36,0,},
        [9] = {9,37,0,},
        [10] = {10,37,0,},
        [11] = {11,38,0,},
        [12] = {12,38,0,},
        [13] = {13,39,0,},
        [14] = {14,39,0,},
        [15] = {15,40,0,},
        [16] = {16,40,0,},
        [17] = {17,41,0,},
        [18] = {18,41,0,},
        [19] = {19,42,0,},
        [20] = {20,42,0,},
        [21] = {21,43,0,},
        [22] = {22,43,0,},
        [23] = {23,44,0,},
        [24] = {24,44,0,},
        [25] = {25,45,0,},
        [26] = {26,45,0,},
        [27] = {27,46,0,},
        [28] = {28,46,0,},
        [29] = {29,47,0,},
        [30] = {30,47,0,},
        [31] = {31,48,0,},
        [32] = {32,48,0,},
        [33] = {33,49,2,},
        [34] = {34,49,2,},
        [35] = {35,50,2,},
        [36] = {36,50,2,},
        [37] = {37,51,2,},
        [38] = {38,51,2,},
        [39] = {39,52,2,},
        [40] = {40,52,2,},
        [41] = {41,53,2,},
        [42] = {42,53,2,},
        [43] = {43,54,2,},
        [44] = {44,54,2,},
        [45] = {45,55,2,},
        [46] = {46,55,2,},
        [47] = {47,56,2,},
        [48] = {48,56,2,},
        [49] = {49,57,2,},
        [50] = {50,57,2,},
        [51] = {51,58,2,},
        [52] = {52,58,2,},
        [53] = {53,59,2,},
        [54] = {54,59,2,},
        [55] = {55,60,2,},
        [56] = {56,60,2,},
        [57] = {57,61,2,},
        [58] = {58,61,2,},
        [59] = {59,62,2,},
        [60] = {60,62,2,},
        [61] = {61,63,2,},
        [62] = {62,63,2,},
        [63] = {63,0,2,},
    }
}

-- index
local __index_top32 = {
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
    [41] = 41,
    [42] = 42,
    [43] = 43,
    [44] = 44,
    [45] = 45,
    [46] = 46,
    [47] = 47,
    [48] = 48,
    [49] = 49,
    [5] = 5,
    [50] = 50,
    [51] = 51,
    [52] = 52,
    [53] = 53,
    [54] = 54,
    [55] = 55,
    [56] = 56,
    [57] = 57,
    [58] = 58,
    [59] = 59,
    [6] = 6,
    [60] = 60,
    [61] = 61,
    [62] = 62,
    [63] = 63,
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
    [41] = 41,
    [42] = 42,
    [43] = 43,
    [44] = 44,
    [45] = 45,
    [46] = 46,
    [47] = 47,
    [48] = 48,
    [49] = 49,
    [5] = 5,
    [50] = 50,
    [51] = 51,
    [52] = 52,
    [53] = 53,
    [54] = 54,
    [55] = 55,
    [56] = 56,
    [57] = 57,
    [58] = 58,
    [59] = 59,
    [6] = 6,
    [60] = 60,
    [61] = 61,
    [62] = 62,
    [63] = 63,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in single_schedule")
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
function single_schedule.length()
    return #single_schedule._data
end

-- 
function single_schedule.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function single_schedule.isVersionValid(v)
    if single_schedule.version then
        if v then
            return single_schedule.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function single_schedule.indexOf(index)
    if index == nil or not single_schedule._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/single_schedule.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/single_schedule.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/single_schedule.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "single_schedule" )
                _isDataExist = single_schedule.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "single_schedule" )
                _isBaseExist = single_schedule.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "single_schedule" )
                _isExist = single_schedule.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "single_schedule" )
        local main_key = __main_key_map[index]
		local index_key = "__index_top32"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "single_schedule" )
        local main_key = __main_key_map[index]
		local index_key = "__index_top32"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = single_schedule._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "single_schedule" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function single_schedule.get(top32)
    
    return single_schedule.indexOf(__index_top32[top32])
        
end

--
function single_schedule.set(top32, key, value)
    local record = single_schedule.get(top32)
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
function single_schedule.index()
    return __index_top32
end

return single_schedule