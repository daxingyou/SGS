--cross_minecraft_parameter

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
local cross_minecraft_parameter = {
    version =  1,
    _data = {
        [1] = {1,"server_num","4",},
        [2] = {2,"server_match_day","4",},
        [3] = {3,"server_match_time","14400",},
        [4] = {4,"preparation_duration","24",},
        [5] = {5,"season_start_day","5",},
        [6] = {6,"season_start_time","14400",},
        [7] = {7,"season_duration","504",},
        [8] = {8,"move_max","14",},
        [9] = {9,"move_time_cost","10",},
        [10] = {10,"move_resource_cost","1",},
        [11] = {11,"protect_time","600",},
        [12] = {12,"produce_speed","100",},
        [13] = {13,"abandon_num","10",},
        [14] = {14,"station_num","0",},
        [15] = {15,"attack_num","0",},
        [16] = {16,"","",},
        [17] = {17,"","",},
        [18] = {18,"","",},
        [19] = {19,"","",},
        [20] = {20,"","",},
        [21] = {21,"","",},
        [22] = {22,"","",},
        [23] = {23,"","",},
        [24] = {24,"","",},
        [25] = {25,"","",},
        [26] = {26,"","",},
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
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
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
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in cross_minecraft_parameter")
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
function cross_minecraft_parameter.length()
    return #cross_minecraft_parameter._data
end

-- 
function cross_minecraft_parameter.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cross_minecraft_parameter.isVersionValid(v)
    if cross_minecraft_parameter.version then
        if v then
            return cross_minecraft_parameter.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function cross_minecraft_parameter.indexOf(index)
    if index == nil or not cross_minecraft_parameter._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/cross_minecraft_parameter.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/cross_minecraft_parameter.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/cross_minecraft_parameter.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "cross_minecraft_parameter" )
                _isDataExist = cross_minecraft_parameter.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "cross_minecraft_parameter" )
                _isBaseExist = cross_minecraft_parameter.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "cross_minecraft_parameter" )
                _isExist = cross_minecraft_parameter.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "cross_minecraft_parameter" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cross_minecraft_parameter" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = cross_minecraft_parameter._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "cross_minecraft_parameter" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function cross_minecraft_parameter.get(id)
    
    return cross_minecraft_parameter.indexOf(__index_id[id])
        
end

--
function cross_minecraft_parameter.set(id, key, value)
    local record = cross_minecraft_parameter.get(id)
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
function cross_minecraft_parameter.index()
    return __index_id
end

return cross_minecraft_parameter