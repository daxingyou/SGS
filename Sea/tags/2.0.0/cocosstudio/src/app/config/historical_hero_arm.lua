--historical_hero_arm

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  color = 2,    --品质-int 
  name = 3,    --名称-string 
  res_id = 4,    --资源id-int 
  fragment_id = 5,    --碎片id-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  color = "int",    --品质-2 
  name = "string",    --名称-3 
  res_id = "int",    --资源id-4 
  fragment_id = "int",    --碎片id-5 

}


-- data
local historical_hero_arm = {
    _data = {
        [1] = {101,3,"高渐离武器",101,0,},
        [2] = {102,3,"荆轲武器",102,0,},
        [3] = {103,3,"韩信武器",103,0,},
        [4] = {104,3,"张良武器",104,0,},
        [5] = {201,4,"秦始皇武器",201,140001,},
        [6] = {202,4,"汉武帝武器",202,140002,},
        [7] = {203,4,"项羽武器",203,140003,},
        [8] = {204,4,"虞姬武器",204,140004,},
    }
}

-- index
local __index_id = {
    [101] = 1,
    [102] = 2,
    [103] = 3,
    [104] = 4,
    [201] = 5,
    [202] = 6,
    [203] = 7,
    [204] = 8,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in historical_hero_arm")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function historical_hero_arm.length()
    return #historical_hero_arm._data
end

-- 
function historical_hero_arm.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function historical_hero_arm.indexOf(index)
    if index == nil or not historical_hero_arm._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/historical_hero_arm.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "historical_hero_arm" )
        return setmetatable({_raw = historical_hero_arm._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = historical_hero_arm._data[index]}, mt)
end

--
function historical_hero_arm.get(id)
    
    return historical_hero_arm.indexOf(__index_id[id])
        
end

--
function historical_hero_arm.set(id, key, value)
    local record = historical_hero_arm.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function historical_hero_arm.index()
    return __index_id
end

return historical_hero_arm