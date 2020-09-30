--act_silver

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  count = 1,    --点金次数-int 
  cost = 2,    --消耗元宝-int 
  basic_silver = 3,    --基础银币-int 

}

-- key type
local __key_type = {
  count = "int",    --点金次数-1 
  cost = "int",    --消耗元宝-2 
  basic_silver = "int",    --基础银币-3 

}


-- data
local act_silver = {
    version =  1,
    _data = {
        [1] = {0,0,25000,},
        [2] = {1,20,25000,},
        [3] = {2,20,25000,},
        [4] = {3,20,25000,},
        [5] = {4,20,25000,},
        [6] = {5,20,25000,},
        [7] = {6,20,25000,},
        [8] = {7,20,25000,},
        [9] = {8,20,25000,},
        [10] = {9,20,25000,},
        [11] = {10,20,25000,},
        [12] = {11,20,25000,},
        [13] = {12,20,25000,},
        [14] = {13,20,25000,},
        [15] = {14,20,25000,},
        [16] = {15,20,25000,},
        [17] = {16,20,25000,},
        [18] = {17,20,25000,},
        [19] = {18,20,25000,},
        [20] = {19,20,25000,},
        [21] = {20,20,25000,},
        [22] = {21,20,25000,},
        [23] = {22,20,25000,},
        [24] = {23,20,25000,},
        [25] = {24,20,25000,},
        [26] = {25,20,25000,},
        [27] = {26,20,25000,},
        [28] = {27,20,25000,},
        [29] = {28,20,25000,},
        [30] = {29,20,25000,},
        [31] = {30,20,25000,},
    }
}

-- index
local __index_count = {
    [0] = 1,
    [1] = 2,
    [10] = 11,
    [11] = 12,
    [12] = 13,
    [13] = 14,
    [14] = 15,
    [15] = 16,
    [16] = 17,
    [17] = 18,
    [18] = 19,
    [19] = 20,
    [2] = 3,
    [20] = 21,
    [21] = 22,
    [22] = 23,
    [23] = 24,
    [24] = 25,
    [25] = 26,
    [26] = 27,
    [27] = 28,
    [28] = 29,
    [29] = 30,
    [3] = 4,
    [30] = 31,
    [4] = 5,
    [5] = 6,
    [6] = 7,
    [7] = 8,
    [8] = 9,
    [9] = 10,

}

-- index mainkey map
local __main_key_map = {
    [1] = 0,
    [2] = 1,
    [11] = 10,
    [12] = 11,
    [13] = 12,
    [14] = 13,
    [15] = 14,
    [16] = 15,
    [17] = 16,
    [18] = 17,
    [19] = 18,
    [20] = 19,
    [3] = 2,
    [21] = 20,
    [22] = 21,
    [23] = 22,
    [24] = 23,
    [25] = 24,
    [26] = 25,
    [27] = 26,
    [28] = 27,
    [29] = 28,
    [30] = 29,
    [4] = 3,
    [31] = 30,
    [5] = 4,
    [6] = 5,
    [7] = 6,
    [8] = 7,
    [9] = 8,
    [10] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in act_silver")
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
function act_silver.length()
    return #act_silver._data
end

-- 
function act_silver.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function act_silver.isVersionValid(v)
    if act_silver.version then
        if v then
            return act_silver.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function act_silver.indexOf(index)
    if index == nil or not act_silver._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/act_silver.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/act_silver.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/act_silver.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "act_silver" )
                _isDataExist = act_silver.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "act_silver" )
                _isBaseExist = act_silver.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "act_silver" )
                _isExist = act_silver.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "act_silver" )
        local main_key = __main_key_map[index]
		local index_key = "__index_count"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "act_silver" )
        local main_key = __main_key_map[index]
		local index_key = "__index_count"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = act_silver._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "act_silver" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function act_silver.get(count)
    
    return act_silver.indexOf(__index_count[count])
        
end

--
function act_silver.set(count, key, value)
    local record = act_silver.get(count)
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
function act_silver.index()
    return __index_count
end

return act_silver