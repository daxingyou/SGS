--equipment_suit

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --套装id-int 
  name = 2,    --套装名称-string 
  quantity_1 = 3,    --部件1数量-int 
  suit_1_type_1 = 4,    --部件1激活属性类型1-int 
  suit_1_value_1 = 5,    --部件1激活属性数值1-int 
  suit_1_type_2 = 6,    --部件1激活属性类型2-int 
  suit_1_value_2 = 7,    --部件1激活属性数值2-int 
  quantity_2 = 8,    --部件2数量-int 
  suit_2_type_1 = 9,    --部件2激活属性类型1-int 
  suit_2_value_1 = 10,    --部件2激活属性数值1-int 
  suit_2_type_2 = 11,    --部件2激活属性类型2-int 
  suit_2_value_2 = 12,    --部件2激活属性数值2-int 
  quantity_3 = 13,    --部件3数量-int 
  suit_3_type_1 = 14,    --部件3激活属性类型1-int 
  suit_3_value_1 = 15,    --部件3激活属性数值1-int 
  suit_3_type_2 = 16,    --部件3激活属性类型2-int 
  suit_3_value_2 = 17,    --部件3激活属性数值2-int 
  suit_3_type_3 = 18,    --部件3激活属性类型3-int 
  suit_3_value_3 = 19,    --部件3激活属性数值3-int 
  suit_3_type_4 = 20,    --部件3激活属性类型4-int 
  suit_3_value_4 = 21,    --部件3激活属性数值4-int 

}

-- key type
local __key_type = {
  id = "int",    --套装id-1 
  name = "string",    --套装名称-2 
  quantity_1 = "int",    --部件1数量-3 
  suit_1_type_1 = "int",    --部件1激活属性类型1-4 
  suit_1_value_1 = "int",    --部件1激活属性数值1-5 
  suit_1_type_2 = "int",    --部件1激活属性类型2-6 
  suit_1_value_2 = "int",    --部件1激活属性数值2-7 
  quantity_2 = "int",    --部件2数量-8 
  suit_2_type_1 = "int",    --部件2激活属性类型1-9 
  suit_2_value_1 = "int",    --部件2激活属性数值1-10 
  suit_2_type_2 = "int",    --部件2激活属性类型2-11 
  suit_2_value_2 = "int",    --部件2激活属性数值2-12 
  quantity_3 = "int",    --部件3数量-13 
  suit_3_type_1 = "int",    --部件3激活属性类型1-14 
  suit_3_value_1 = "int",    --部件3激活属性数值1-15 
  suit_3_type_2 = "int",    --部件3激活属性类型2-16 
  suit_3_value_2 = "int",    --部件3激活属性数值2-17 
  suit_3_type_3 = "int",    --部件3激活属性类型3-18 
  suit_3_value_3 = "int",    --部件3激活属性数值3-19 
  suit_3_type_4 = "int",    --部件3激活属性类型4-20 
  suit_3_value_4 = "int",    --部件3激活属性数值4-21 

}


-- data
local equipment_suit = {
    version =  1,
    _data = {
        [1] = {1001,"破军套装",2,1,2400,0,0,3,7,18000,0,0,4,19,50,20,50,0,0,0,0,},
        [2] = {2001,"四神套装",2,1,3200,0,0,3,7,24000,0,0,4,19,100,20,100,0,0,0,0,},
        [3] = {3001,"八荒套装",2,1,4800,0,0,3,7,36000,0,0,4,19,150,20,150,0,0,0,0,},
    }
}

-- index
local __index_id = {
    [1001] = 1,
    [2001] = 2,
    [3001] = 3,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1001,
    [2] = 2001,
    [3] = 3001,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in equipment_suit")
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
function equipment_suit.length()
    return #equipment_suit._data
end

-- 
function equipment_suit.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function equipment_suit.isVersionValid(v)
    if equipment_suit.version then
        if v then
            return equipment_suit.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function equipment_suit.indexOf(index)
    if index == nil or not equipment_suit._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/equipment_suit.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/equipment_suit.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/equipment_suit.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "equipment_suit" )
                _isDataExist = equipment_suit.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "equipment_suit" )
                _isBaseExist = equipment_suit.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "equipment_suit" )
                _isExist = equipment_suit.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "equipment_suit" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "equipment_suit" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = equipment_suit._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "equipment_suit" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function equipment_suit.get(id)
    
    return equipment_suit.indexOf(__index_id[id])
        
end

--
function equipment_suit.set(id, key, value)
    local record = equipment_suit.get(id)
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
function equipment_suit.index()
    return __index_id
end

return equipment_suit