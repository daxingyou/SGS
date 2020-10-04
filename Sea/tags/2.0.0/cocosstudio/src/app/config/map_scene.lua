--map_scene

local _lang = "cn"
local _isExist = false

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

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in map_scene")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
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
function map_scene.indexOf(index)
    if index == nil or not map_scene._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/map_scene.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "map_scene" )
        return setmetatable({_raw = map_scene._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = map_scene._data[index]}, mt)
end

--
function map_scene.get(id)
    
    return map_scene.indexOf(__index_id[id])
        
end

--
function map_scene.set(id, key, value)
    local record = map_scene.get(id)
    if record then
        local keyIndex = __key_map[key]
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