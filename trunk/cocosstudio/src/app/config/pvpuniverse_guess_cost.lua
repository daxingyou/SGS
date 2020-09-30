--pvpuniverse_guess_cost

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  round = 1,    --轮次-int 
  guess = 2,    --竞猜类型-int 
  type = 3,    --消耗材料type-int 
  value = 4,    --消耗材料value-int 
  size = 5,    --消耗材料size-int 

}

-- key type
local __key_type = {
  round = "int",    --轮次-1 
  guess = "int",    --竞猜类型-2 
  type = "int",    --消耗材料type-3 
  value = "int",    --消耗材料value-4 
  size = "int",    --消耗材料size-5 

}


-- data
local pvpuniverse_guess_cost = {
    version =  1,
    _data = {
        [1] = {1,1,5,36,1,},
        [2] = {2,1,5,36,1,},
        [3] = {3,1,5,36,1,},
        [4] = {4,1,5,36,1,},
        [5] = {5,1,5,36,2,},
        [6] = {6,1,5,36,3,},
        [7] = {1,2,5,36,4,},
        [8] = {2,2,5,36,4,},
        [9] = {3,2,5,36,4,},
        [10] = {4,2,5,36,4,},
        [11] = {5,2,5,36,4,},
    }
}

-- index
local __index_round_guess = {
    ["1_1"] = 1,
    ["1_2"] = 7,
    ["2_1"] = 2,
    ["2_2"] = 8,
    ["3_1"] = 3,
    ["3_2"] = 9,
    ["4_1"] = 4,
    ["4_2"] = 10,
    ["5_1"] = 5,
    ["5_2"] = 11,
    ["6_1"] = 6,

}

-- index mainkey map
local __main_key_map = {
    [1] = "1_1",
    [7] = "1_2",
    [2] = "2_1",
    [8] = "2_2",
    [3] = "3_1",
    [9] = "3_2",
    [4] = "4_1",
    [10] = "4_2",
    [5] = "5_1",
    [11] = "5_2",
    [6] = "6_1",

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in pvpuniverse_guess_cost")
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
function pvpuniverse_guess_cost.length()
    return #pvpuniverse_guess_cost._data
end

-- 
function pvpuniverse_guess_cost.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function pvpuniverse_guess_cost.isVersionValid(v)
    if pvpuniverse_guess_cost.version then
        if v then
            return pvpuniverse_guess_cost.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function pvpuniverse_guess_cost.indexOf(index)
    if index == nil or not pvpuniverse_guess_cost._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/pvpuniverse_guess_cost.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/pvpuniverse_guess_cost.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/pvpuniverse_guess_cost.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "pvpuniverse_guess_cost" )
                _isDataExist = pvpuniverse_guess_cost.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "pvpuniverse_guess_cost" )
                _isBaseExist = pvpuniverse_guess_cost.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "pvpuniverse_guess_cost" )
                _isExist = pvpuniverse_guess_cost.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "pvpuniverse_guess_cost" )
        local main_key = __main_key_map[index]
		local index_key = "__index_round_guess"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "pvpuniverse_guess_cost" )
        local main_key = __main_key_map[index]
		local index_key = "__index_round_guess"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = pvpuniverse_guess_cost._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "pvpuniverse_guess_cost" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function pvpuniverse_guess_cost.get(round,guess)
    
    local k = round .. '_' .. guess
    return pvpuniverse_guess_cost.indexOf(__index_round_guess[k])
        
end

--
function pvpuniverse_guess_cost.set(round,guess, key, value)
    local record = pvpuniverse_guess_cost.get(round,guess)
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
function pvpuniverse_guess_cost.index()
    return __index_round_guess
end

return pvpuniverse_guess_cost