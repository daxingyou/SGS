--pvpuniverse_group

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  competitor = 1,    --选手-int 
  next_position = 2,    --下轮位置-int 
  round = 3,    --比赛轮次-int 
  side = 4,    --站位-int 
  red_packet = 5,    --晋级红包-int 
  series = 6,    --串联分组-int 

}

-- key type
local __key_type = {
  competitor = "int",    --选手-1 
  next_position = "int",    --下轮位置-2 
  round = "int",    --比赛轮次-3 
  side = "int",    --站位-4 
  red_packet = "int",    --晋级红包-5 
  series = "int",    --串联分组-6 

}


-- data
local pvpuniverse_group = {
    version =  1,
    _data = {
        [1] = {32,33,1,1,3601,1,},
        [2] = {17,33,1,2,3601,1,},
        [3] = {16,41,2,2,3602,3,},
        [4] = {33,41,2,1,3602,3,},
        [5] = {1,49,3,2,3603,5,},
        [6] = {41,49,3,1,3603,5,},
        [7] = {25,34,1,1,3601,1,},
        [8] = {24,34,1,2,3601,1,},
        [9] = {9,42,2,2,3602,3,},
        [10] = {34,42,2,1,3602,3,},
        [11] = {8,50,3,2,3603,5,},
        [12] = {42,50,3,1,3603,5,},
        [13] = {49,57,4,1,3604,7,},
        [14] = {50,57,4,2,3604,7,},
        [15] = {31,37,1,2,3601,2,},
        [16] = {18,37,1,1,3601,2,},
        [17] = {15,45,2,1,3602,4,},
        [18] = {37,45,2,2,3602,4,},
        [19] = {2,53,3,1,3603,6,},
        [20] = {45,53,3,2,3603,6,},
        [21] = {26,38,1,1,3601,2,},
        [22] = {23,38,1,2,3601,2,},
        [23] = {10,46,2,1,3602,4,},
        [24] = {38,46,2,2,3602,4,},
        [25] = {7,54,3,1,3603,6,},
        [26] = {46,54,3,2,3603,6,},
        [27] = {53,59,4,1,3604,7,},
        [28] = {54,59,4,2,3604,7,},
        [29] = {30,39,1,1,3601,2,},
        [30] = {19,39,1,2,3601,2,},
        [31] = {14,47,2,1,3602,4,},
        [32] = {39,47,2,2,3602,4,},
        [33] = {3,55,3,1,3603,6,},
        [34] = {47,55,3,2,3603,6,},
        [35] = {27,40,1,2,3601,2,},
        [36] = {22,40,1,1,3601,2,},
        [37] = {11,48,2,1,3602,4,},
        [38] = {40,48,2,2,3602,4,},
        [39] = {6,56,3,1,3603,6,},
        [40] = {48,56,3,2,3603,6,},
        [41] = {55,60,4,1,3604,7,},
        [42] = {56,60,4,2,3604,7,},
        [43] = {29,35,1,2,3601,1,},
        [44] = {20,35,1,1,3601,1,},
        [45] = {13,43,2,2,3602,3,},
        [46] = {35,43,2,1,3602,3,},
        [47] = {4,51,3,2,3603,5,},
        [48] = {43,51,3,1,3603,5,},
        [49] = {28,36,1,1,3601,1,},
        [50] = {21,36,1,2,3601,1,},
        [51] = {12,44,2,2,3602,3,},
        [52] = {36,44,2,1,3602,3,},
        [53] = {5,52,3,2,3603,5,},
        [54] = {44,52,3,1,3603,5,},
        [55] = {51,58,4,2,3604,7,},
        [56] = {52,58,4,1,3604,7,},
        [57] = {57,61,5,1,3605,9,},
        [58] = {58,61,5,2,3605,9,},
        [59] = {59,62,5,2,3605,9,},
        [60] = {60,62,5,1,3605,9,},
        [61] = {61,63,6,1,3606,0,},
        [62] = {62,63,6,2,3606,0,},
        [63] = {63,0,0,0,0,0,},
    }
}

-- index
local __index_competitor = {
    [1] = 5,
    [10] = 23,
    [11] = 37,
    [12] = 51,
    [13] = 45,
    [14] = 31,
    [15] = 17,
    [16] = 3,
    [17] = 2,
    [18] = 16,
    [19] = 30,
    [2] = 19,
    [20] = 44,
    [21] = 50,
    [22] = 36,
    [23] = 22,
    [24] = 8,
    [25] = 7,
    [26] = 21,
    [27] = 35,
    [28] = 49,
    [29] = 43,
    [3] = 33,
    [30] = 29,
    [31] = 15,
    [32] = 1,
    [33] = 4,
    [34] = 10,
    [35] = 46,
    [36] = 52,
    [37] = 18,
    [38] = 24,
    [39] = 32,
    [4] = 47,
    [40] = 38,
    [41] = 6,
    [42] = 12,
    [43] = 48,
    [44] = 54,
    [45] = 20,
    [46] = 26,
    [47] = 34,
    [48] = 40,
    [49] = 13,
    [5] = 53,
    [50] = 14,
    [51] = 55,
    [52] = 56,
    [53] = 27,
    [54] = 28,
    [55] = 41,
    [56] = 42,
    [57] = 57,
    [58] = 58,
    [59] = 59,
    [6] = 39,
    [60] = 60,
    [61] = 61,
    [62] = 62,
    [63] = 63,
    [7] = 25,
    [8] = 11,
    [9] = 9,

}

-- index mainkey map
local __main_key_map = {
    [5] = 1,
    [23] = 10,
    [37] = 11,
    [51] = 12,
    [45] = 13,
    [31] = 14,
    [17] = 15,
    [3] = 16,
    [2] = 17,
    [16] = 18,
    [30] = 19,
    [19] = 2,
    [44] = 20,
    [50] = 21,
    [36] = 22,
    [22] = 23,
    [8] = 24,
    [7] = 25,
    [21] = 26,
    [35] = 27,
    [49] = 28,
    [43] = 29,
    [33] = 3,
    [29] = 30,
    [15] = 31,
    [1] = 32,
    [4] = 33,
    [10] = 34,
    [46] = 35,
    [52] = 36,
    [18] = 37,
    [24] = 38,
    [32] = 39,
    [47] = 4,
    [38] = 40,
    [6] = 41,
    [12] = 42,
    [48] = 43,
    [54] = 44,
    [20] = 45,
    [26] = 46,
    [34] = 47,
    [40] = 48,
    [13] = 49,
    [53] = 5,
    [14] = 50,
    [55] = 51,
    [56] = 52,
    [27] = 53,
    [28] = 54,
    [41] = 55,
    [42] = 56,
    [57] = 57,
    [58] = 58,
    [59] = 59,
    [39] = 6,
    [60] = 60,
    [61] = 61,
    [62] = 62,
    [63] = 63,
    [25] = 7,
    [11] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in pvpuniverse_group")
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
function pvpuniverse_group.length()
    return #pvpuniverse_group._data
end

-- 
function pvpuniverse_group.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function pvpuniverse_group.isVersionValid(v)
    if pvpuniverse_group.version then
        if v then
            return pvpuniverse_group.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function pvpuniverse_group.indexOf(index)
    if index == nil or not pvpuniverse_group._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/pvpuniverse_group.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/pvpuniverse_group.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/pvpuniverse_group.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "pvpuniverse_group" )
                _isDataExist = pvpuniverse_group.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "pvpuniverse_group" )
                _isBaseExist = pvpuniverse_group.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "pvpuniverse_group" )
                _isExist = pvpuniverse_group.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "pvpuniverse_group" )
        local main_key = __main_key_map[index]
		local index_key = "__index_competitor"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "pvpuniverse_group" )
        local main_key = __main_key_map[index]
		local index_key = "__index_competitor"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = pvpuniverse_group._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "pvpuniverse_group" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function pvpuniverse_group.get(competitor)
    
    return pvpuniverse_group.indexOf(__index_competitor[competitor])
        
end

--
function pvpuniverse_group.set(competitor, key, value)
    local record = pvpuniverse_group.get(competitor)
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
function pvpuniverse_group.index()
    return __index_competitor
end

return pvpuniverse_group