--territory_parameter

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
local territory_parameter = {
    version =  1,
    _data = {
        [1] = {1,"riot_time_slot","710|1070",},
        [2] = {2,"riot_continue_time","7200",},
        [3] = {3,"patrol_profit_time","1800",},
        [4] = {4,"patrol_choice_time1","14400|5:3:5",},
        [5] = {5,"patrol_choice_time2","28800|5:3:10",},
        [6] = {6,"patrol_choice_time3","43200|5:3:15",},
        [7] = {16,"hero_drop_probability1","1000|0|0|0|0",},
        [8] = {17,"hero_drop_probability2","500|500|0|0|0",},
        [9] = {18,"hero_drop_probability3","400|600|0|0|0",},
        [10] = {19,"hero_drop_probability4","0|1000|0|0|0",},
        [11] = {20,"hero_drop_probability5","0|1000|0|0|0",},
        [12] = {21,"hero_drop_probability6","0|1000|0|0|0",},
        [13] = {22,"hero_drop_probability7","0|970|30|0|0",},
        [14] = {23,"hero_drop_probability8","0|961|39|0|0",},
        [15] = {24,"hero_drop_probability9","0|961|39|0|0",},
        [16] = {25,"hero_drop_probability10","0|961|39|0|0",},
        [17] = {26,"hero_drop_probability11","0|300|685|15|0",},
        [18] = {27,"hero_drop_probability12","0|0|985|14|1",},
        [19] = {31,"help_number","10",},
        [20] = {32,"time_display","每天11：50、17：50发生暴动！",},
        [21] = {33,"help_bubble","1301|1302|1303|1304|1305",},
        [22] = {34,"territory_hero","4|5|6",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [16] = 7,
    [17] = 8,
    [18] = 9,
    [19] = 10,
    [2] = 2,
    [20] = 11,
    [21] = 12,
    [22] = 13,
    [23] = 14,
    [24] = 15,
    [25] = 16,
    [26] = 17,
    [27] = 18,
    [3] = 3,
    [31] = 19,
    [32] = 20,
    [33] = 21,
    [34] = 22,
    [4] = 4,
    [5] = 5,
    [6] = 6,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [7] = 16,
    [8] = 17,
    [9] = 18,
    [10] = 19,
    [2] = 2,
    [11] = 20,
    [12] = 21,
    [13] = 22,
    [14] = 23,
    [15] = 24,
    [16] = 25,
    [17] = 26,
    [18] = 27,
    [3] = 3,
    [19] = 31,
    [20] = 32,
    [21] = 33,
    [22] = 34,
    [4] = 4,
    [5] = 5,
    [6] = 6,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in territory_parameter")
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
function territory_parameter.length()
    return #territory_parameter._data
end

-- 
function territory_parameter.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function territory_parameter.isVersionValid(v)
    if territory_parameter.version then
        if v then
            return territory_parameter.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function territory_parameter.indexOf(index)
    if index == nil or not territory_parameter._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/territory_parameter.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/territory_parameter.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/territory_parameter.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "territory_parameter" )
                _isDataExist = territory_parameter.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "territory_parameter" )
                _isBaseExist = territory_parameter.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "territory_parameter" )
                _isExist = territory_parameter.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "territory_parameter" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "territory_parameter" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = territory_parameter._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "territory_parameter" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function territory_parameter.get(id)
    
    return territory_parameter.indexOf(__index_id[id])
        
end

--
function territory_parameter.set(id, key, value)
    local record = territory_parameter.get(id)
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
function territory_parameter.index()
    return __index_id
end

return territory_parameter