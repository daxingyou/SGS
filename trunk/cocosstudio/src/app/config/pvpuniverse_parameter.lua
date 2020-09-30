--pvpuniverse_parameter

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  key = 2,    --参数名称-string 
  content = 3,    --参数内容-string 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  key = "string",    --参数名称-2 
  content = "string",    --参数内容-3 

}


-- data
local pvpuniverse_parameter = {
    version =  1,
    _data = {
        [1] = {1,"pvpuniverse_day","1|3|5",},
        [2] = {4,"pvpuniverse_preview","0|01",},
        [3] = {5,"pvpuniverse_day_interval","86400",},
        [4] = {6,"pvpuniverse_winnershow","7229",},
        [5] = {7,"pvpuniverse_time","120",},
        [6] = {8,"pvpuniverse_interval","300",},
        [7] = {9,"pvpuniverse_win","3",},
        [8] = {10,"pvpuniverse_support_low","50|150",},
        [9] = {11,"pvpuniverse_support_high","200|500",},
        [10] = {12,"pvpuniverse_combo","1,100|2,100|3,100|4,100|5,200|6,100|7,100|8,100|9,100",},
        [11] = {13,"pvpuniverse_round","1,32进24|2,24进16|3,16进8|4,8进4|5,半决赛|6,决赛",},
        [12] = {14,"pvpuniverse_chat_begins","5|00|01",},
        [13] = {15,"pvpuniverse_chat_end","7|23|59",},
        [14] = {16,"pvpuniverse_open","180",},
        [15] = {17,"pvpuniverse_remain","60",},
        [16] = {18,"pvpuniverse_rank_list","50",},
        [17] = {19,"pvpuniverse_rank","200",},
        [18] = {20,"pvpuniverse_pot_base","3000",},
        [19] = {21,"pvpuniverse_pot_increase","1",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 8,
    [11] = 9,
    [12] = 10,
    [13] = 11,
    [14] = 12,
    [15] = 13,
    [16] = 14,
    [17] = 15,
    [18] = 16,
    [19] = 17,
    [20] = 18,
    [21] = 19,
    [4] = 2,
    [5] = 3,
    [6] = 4,
    [7] = 5,
    [8] = 6,
    [9] = 7,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [8] = 10,
    [9] = 11,
    [10] = 12,
    [11] = 13,
    [12] = 14,
    [13] = 15,
    [14] = 16,
    [15] = 17,
    [16] = 18,
    [17] = 19,
    [18] = 20,
    [19] = 21,
    [2] = 4,
    [3] = 5,
    [4] = 6,
    [5] = 7,
    [6] = 8,
    [7] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in pvpuniverse_parameter")
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
function pvpuniverse_parameter.length()
    return #pvpuniverse_parameter._data
end

-- 
function pvpuniverse_parameter.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function pvpuniverse_parameter.isVersionValid(v)
    if pvpuniverse_parameter.version then
        if v then
            return pvpuniverse_parameter.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function pvpuniverse_parameter.indexOf(index)
    if index == nil or not pvpuniverse_parameter._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/pvpuniverse_parameter.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/pvpuniverse_parameter.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/pvpuniverse_parameter.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "pvpuniverse_parameter" )
                _isDataExist = pvpuniverse_parameter.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "pvpuniverse_parameter" )
                _isBaseExist = pvpuniverse_parameter.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "pvpuniverse_parameter" )
                _isExist = pvpuniverse_parameter.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "pvpuniverse_parameter" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "pvpuniverse_parameter" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = pvpuniverse_parameter._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "pvpuniverse_parameter" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function pvpuniverse_parameter.get(id)
    
    return pvpuniverse_parameter.indexOf(__index_id[id])
        
end

--
function pvpuniverse_parameter.set(id, key, value)
    local record = pvpuniverse_parameter.get(id)
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
function pvpuniverse_parameter.index()
    return __index_id
end

return pvpuniverse_parameter