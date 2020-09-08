--equipment_limitup

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  limitup_templet_id = 1,    --模板id-int 
  consume_refinestone = 2,    --精炼石每次消耗-int 
  cost_equipment = 3,    --同名装备消耗量-int 
  consume_equipment = 4,    --同名装备每次消耗-int 
  resource_name_1 = 5,    --材料1名称-string 
  resource_type_1 = 6,    --消耗资源类型1-int 
  resource_id_1 = 7,    --消耗资源id1-int 
  resource_size_1 = 8,    --消耗资源数量1-int 
  resource_consume_1 = 9,    --材料1每次消耗-int 
  resource_name_2 = 10,    --材料2名称-string 
  resource_type_2 = 11,    --消耗资源类型2-int 
  resource_id_2 = 12,    --消耗资源id2-int 
  resource_size_2 = 13,    --消耗资源数量2-int 
  resource_consume_2 = 14,    --材料2每次消耗-int 

}

-- key type
local __key_type = {
  limitup_templet_id = "int",    --模板id-1 
  consume_refinestone = "int",    --精炼石每次消耗-2 
  cost_equipment = "int",    --同名装备消耗量-3 
  consume_equipment = "int",    --同名装备每次消耗-4 
  resource_name_1 = "string",    --材料1名称-5 
  resource_type_1 = "int",    --消耗资源类型1-6 
  resource_id_1 = "int",    --消耗资源id1-7 
  resource_size_1 = "int",    --消耗资源数量1-8 
  resource_consume_1 = "int",    --材料1每次消耗-9 
  resource_name_2 = "string",    --材料2名称-10 
  resource_type_2 = "int",    --消耗资源类型2-11 
  resource_id_2 = "int",    --消耗资源id2-12 
  resource_size_2 = "int",    --消耗资源数量2-13 
  resource_consume_2 = "int",    --材料2每次消耗-14 

}


-- data
local equipment_limitup = {
    version =  1,
    _data = {
        [1] = {1,5,2,1,"春秋",6,92,12,1,"战国",6,93,12,1,},
        [2] = {2,5,1,1,"礼记",6,555,12,1,"周易",6,556,12,1,},
    }
}

-- index
local __index_limitup_templet_id = {
    [1] = 1,
    [2] = 2,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in equipment_limitup")
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
function equipment_limitup.length()
    return #equipment_limitup._data
end

-- 
function equipment_limitup.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function equipment_limitup.isVersionValid(v)
    if equipment_limitup.version then
        if v then
            return equipment_limitup.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function equipment_limitup.indexOf(index)
    if index == nil or not equipment_limitup._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/equipment_limitup.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/equipment_limitup.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/equipment_limitup.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "equipment_limitup" )
                _isDataExist = equipment_limitup.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "equipment_limitup" )
                _isBaseExist = equipment_limitup.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "equipment_limitup" )
                _isExist = equipment_limitup.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "equipment_limitup" )
        local main_key = __main_key_map[index]
		local index_key = "__index_limitup_templet_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "equipment_limitup" )
        local main_key = __main_key_map[index]
		local index_key = "__index_limitup_templet_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = equipment_limitup._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "equipment_limitup" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function equipment_limitup.get(limitup_templet_id)
    
    return equipment_limitup.indexOf(__index_limitup_templet_id[limitup_templet_id])
        
end

--
function equipment_limitup.set(limitup_templet_id, key, value)
    local record = equipment_limitup.get(limitup_templet_id)
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
function equipment_limitup.index()
    return __index_limitup_templet_id
end

return equipment_limitup