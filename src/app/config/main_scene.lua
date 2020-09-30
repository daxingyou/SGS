--main_scene

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  name = 2,    --背景名-string 
  color = 3,    --品质-int 
  scene_day = 4,    --白天主城-int 
  scene_night = 5,    --晚上主城-int 
  order = 6,    --默认展示顺序-int 
  type_0 = 7,    --重复获得分解奖励类型-int 
  value_0 = 8,    --重复获得分解奖励类型值-int 
  size_0 = 9,    --重复获得分解奖励数量-int 
  type = 10,    --奖励类型1-int 
  value = 11,    --奖励类型值1-int 
  size = 12,    --奖励数量1-int 
  type_1 = 13,    --奖励类型2-int 
  value_1 = 14,    --奖励类型值2-int 
  size_1 = 15,    --奖励数量2-int 
  description = 16,    --获取途径-string 
  description_1 = 17,    --描述-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  name = "string",    --背景名-2 
  color = "int",    --品质-3 
  scene_day = "int",    --白天主城-4 
  scene_night = "int",    --晚上主城-5 
  order = "int",    --默认展示顺序-6 
  type_0 = "int",    --重复获得分解奖励类型-7 
  value_0 = "int",    --重复获得分解奖励类型值-8 
  size_0 = "int",    --重复获得分解奖励数量-9 
  type = "int",    --奖励类型1-10 
  value = "int",    --奖励类型值1-11 
  size = "int",    --奖励数量1-12 
  type_1 = "int",    --奖励类型2-13 
  value_1 = "int",    --奖励类型值2-14 
  size_1 = "int",    --奖励数量2-15 
  description = "string",    --获取途径-16 
  description_1 = "string",    --描述-17 

}


-- data
local main_scene = {
    version =  1,
    _data = {
        [1] = {2,"春",5,20021,20022,2,5,51,20,5,33,600,5,51,60,"充值获得","重复获得会直接分解为#num#个背景交换券",},
        [2] = {3,"默认",5,20011,20012,1,5,51,20,0,0,0,0,0,0,"默认","重复获得会直接分解为#num#个背景交换券",},
    }
}

-- index
local __index_id = {
    [2] = 1,
    [3] = 2,

}

-- index mainkey map
local __main_key_map = {
    [1] = 2,
    [2] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in main_scene")
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
function main_scene.length()
    return #main_scene._data
end

-- 
function main_scene.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function main_scene.isVersionValid(v)
    if main_scene.version then
        if v then
            return main_scene.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function main_scene.indexOf(index)
    if index == nil or not main_scene._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/main_scene.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/main_scene.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/main_scene.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "main_scene" )
                _isDataExist = main_scene.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "main_scene" )
                _isBaseExist = main_scene.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "main_scene" )
                _isExist = main_scene.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "main_scene" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "main_scene" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = main_scene._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "main_scene" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function main_scene.get(id)
    
    return main_scene.indexOf(__index_id[id])
        
end

--
function main_scene.set(id, key, value)
    local record = main_scene.get(id)
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
function main_scene.index()
    return __index_id
end

return main_scene