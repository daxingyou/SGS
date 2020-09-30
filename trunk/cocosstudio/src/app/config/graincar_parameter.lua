--graincar_parameter

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
local graincar_parameter = {
    version =  1,
    _data = {
        [1] = {1,"graincar_week","3|5|7",},
        [2] = {2,"graincar_open","22|00",},
        [3] = {3,"graincar_close","22|30",},
        [4] = {4,"graincar_route","4|00",},
        [5] = {5,"graincar_copper_stop","24",},
        [6] = {6,"graincar_silver_stop","36",},
        [7] = {7,"graincar_gold_stop","48",},
        [8] = {8,"graincar_moving_time","20",},
        [9] = {9,"graincar_donate_cost","5|13|2000",},
        [10] = {10,"graincar_donate_exp","2000",},
        [11] = {11,"graincar_attack_times","3",},
        [12] = {12,"graincar_attack_bonus","6|175|1",},
        [13] = {13,"graincar_attack_CD","5",},
        [14] = {14,"graincar_attack_hurt","10",},
        [15] = {15,"graincar_damage_bonus","50",},
        [16] = {16,"graincar_protect_1","10|20",},
        [17] = {17,"graincar_protect_2","20|40",},
        [18] = {18,"graincar_protect_3","30|60",},
        [19] = {19,"graincar_max_num","100",},
        [20] = {20,"graincar_show","660",},
        [21] = {21,"graincar_attack_lose","2",},
        [22] = {22,"graincar_show_hero","1|11|101|102|109|110|201|202|204|205|206|211|301|303|304|308|403|402|404|407|410|412|91102|91109|91110|91112|91202|91204|91205|91206|91211|91302|91304|91308|91309|91402|91404|91407|91410|91412",},
        [23] = {23,"graincar_shame","52200",},
        [24] = {24,"graincar_days","21",},
        [25] = {25,"graincar_attack_bonus_new","6|175|1",},
        [26] = {26,"graincar_level_up","5",},
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
        assert(key_map[k], "cannot find " .. k .. " in graincar_parameter")
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
function graincar_parameter.length()
    return #graincar_parameter._data
end

-- 
function graincar_parameter.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function graincar_parameter.isVersionValid(v)
    if graincar_parameter.version then
        if v then
            return graincar_parameter.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function graincar_parameter.indexOf(index)
    if index == nil or not graincar_parameter._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/graincar_parameter.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/graincar_parameter.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/graincar_parameter.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "graincar_parameter" )
                _isDataExist = graincar_parameter.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "graincar_parameter" )
                _isBaseExist = graincar_parameter.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "graincar_parameter" )
                _isExist = graincar_parameter.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "graincar_parameter" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "graincar_parameter" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = graincar_parameter._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "graincar_parameter" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function graincar_parameter.get(id)
    
    return graincar_parameter.indexOf(__index_id[id])
        
end

--
function graincar_parameter.set(id, key, value)
    local record = graincar_parameter.get(id)
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
function graincar_parameter.index()
    return __index_id
end

return graincar_parameter