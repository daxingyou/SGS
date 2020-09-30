--map_scene

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --地图id-int 
  background = 2,    --背景图-string 
  front_eft = 3,    --前层特效-string 
  back_eft = 4,    --后层特效-string 
  particle = 5,    --粒子效果-string 

}

-- key type
local __key_type = {
  id = "int",    --地图id-1 
  background = "string",    --背景图-2 
  front_eft = "string",    --前层特效-3 
  back_eft = "string",    --后层特效-4 
  particle = "string",    --粒子效果-5 

}


-- data
local map_scene = {
    version =  1,
    _data = {
        [1] = {1,"1.jpg","","","",},
        [2] = {2,"2.jpg","","","",},
        [3] = {3,"3.jpg","","","",},
        [4] = {4,"4.jpg","","","",},
        [5] = {5,"5.jpg","","","",},
        [6] = {6,"6.jpg","","","",},
        [7] = {7,"7.jpg","taohuayuan_front","taohuayuan","",},
        [8] = {8,"8.jpg","","","",},
        [9] = {9,"9.jpg","","","",},
        [10] = {10,"10.jpg","","","",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [2] = 2,
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
    [2] = 2,
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
        assert(key_map[k], "cannot find " .. k .. " in map_scene")
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
function map_scene.length()
    return #map_scene._data
end

-- 
function map_scene.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function map_scene.isVersionValid(v)
    if map_scene.version then
        if v then
            return map_scene.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function map_scene.indexOf(index)
    if index == nil or not map_scene._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/map_scene.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/map_scene.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/map_scene.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "map_scene" )
                _isDataExist = map_scene.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "map_scene" )
                _isBaseExist = map_scene.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "map_scene" )
                _isExist = map_scene.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "map_scene" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "map_scene" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = map_scene._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "map_scene" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function map_scene.get(id)
    
    return map_scene.indexOf(__index_id[id])
        
end

--
function map_scene.set(id, key, value)
    local record = map_scene.get(id)
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
function map_scene.index()
    return __index_id
end

return map_scene