--new_answer_point

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --坑位ID-int 
  type = 2,    --坑位类型-int 
  index = 3,    --坑位序号-int 
  x = 4,    --x坐标-int 
  y = 5,    --y坐标-int 

}

-- key type
local __key_type = {
  id = "int",    --坑位ID-1 
  type = "int",    --坑位类型-2 
  index = "int",    --坑位序号-3 
  x = "int",    --x坐标-4 
  y = "int",    --y坐标-5 

}


-- data
local new_answer_point = {
    version =  1,
    _data = {
        [1] = {1,1,1,950,400,},
        [2] = {2,1,2,870,455,},
        [3] = {3,1,3,870,345,},
        [4] = {4,1,4,770,455,},
        [5] = {5,1,5,770,345,},
        [6] = {6,1,6,670,455,},
        [7] = {7,1,7,670,345,},
        [8] = {8,1,8,570,455,},
        [9] = {9,1,9,570,345,},
        [10] = {10,1,10,470,455,},
        [11] = {11,1,11,470,345,},
        [12] = {12,1,12,370,455,},
        [13] = {13,1,13,370,345,},
        [14] = {14,1,14,270,455,},
        [15] = {15,1,15,270,345,},
        [16] = {16,1,16,170,455,},
        [17] = {17,1,17,170,345,},
        [18] = {18,1,18,820,455,},
        [19] = {19,1,19,820,345,},
        [20] = {20,1,20,720,455,},
        [21] = {21,1,21,720,345,},
        [22] = {22,1,22,620,455,},
        [23] = {23,1,23,620,345,},
        [24] = {24,1,24,520,455,},
        [25] = {25,1,25,520,345,},
        [26] = {26,1,26,420,455,},
        [27] = {27,1,27,420,345,},
        [28] = {28,1,28,320,455,},
        [29] = {29,1,29,320,345,},
        [30] = {30,1,30,220,455,},
        [31] = {31,1,31,220,345,},
        [32] = {32,1,32,120,455,},
        [33] = {33,1,33,120,345,},
        [34] = {34,2,1,950,130,},
        [35] = {35,2,2,870,200,},
        [36] = {36,2,3,870,90,},
        [37] = {37,2,4,770,200,},
        [38] = {38,2,5,770,90,},
        [39] = {39,2,6,670,200,},
        [40] = {40,2,7,670,90,},
        [41] = {41,2,8,570,200,},
        [42] = {42,2,9,570,90,},
        [43] = {43,2,10,470,200,},
        [44] = {44,2,11,470,90,},
        [45] = {45,2,12,370,200,},
        [46] = {46,2,13,370,90,},
        [47] = {47,2,14,270,200,},
        [48] = {48,2,15,270,90,},
        [49] = {49,2,16,170,200,},
        [50] = {50,2,17,170,90,},
        [51] = {51,2,18,820,200,},
        [52] = {52,2,19,820,90,},
        [53] = {53,2,20,720,200,},
        [54] = {54,2,21,720,90,},
        [55] = {55,2,22,620,200,},
        [56] = {56,2,23,620,90,},
        [57] = {57,2,24,520,200,},
        [58] = {58,2,25,520,90,},
        [59] = {59,2,26,420,200,},
        [60] = {60,2,27,420,90,},
        [61] = {61,2,28,320,200,},
        [62] = {62,2,29,320,90,},
        [63] = {63,2,30,220,200,},
        [64] = {64,2,31,220,90,},
        [65] = {65,2,32,120,200,},
        [66] = {66,2,33,120,90,},
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
    [64] = 64,
    [65] = 65,
    [66] = 66,
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
    [64] = 64,
    [65] = 65,
    [66] = 66,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in new_answer_point")
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
function new_answer_point.length()
    return #new_answer_point._data
end

-- 
function new_answer_point.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function new_answer_point.isVersionValid(v)
    if new_answer_point.version then
        if v then
            return new_answer_point.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function new_answer_point.indexOf(index)
    if index == nil or not new_answer_point._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/new_answer_point.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/new_answer_point.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/new_answer_point.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "new_answer_point" )
                _isDataExist = new_answer_point.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "new_answer_point" )
                _isBaseExist = new_answer_point.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "new_answer_point" )
                _isExist = new_answer_point.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "new_answer_point" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "new_answer_point" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = new_answer_point._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "new_answer_point" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function new_answer_point.get(id)
    
    return new_answer_point.indexOf(__index_id[id])
        
end

--
function new_answer_point.set(id, key, value)
    local record = new_answer_point.get(id)
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
function new_answer_point.index()
    return __index_id
end

return new_answer_point