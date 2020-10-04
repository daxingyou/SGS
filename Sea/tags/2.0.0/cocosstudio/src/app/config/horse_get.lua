--horse_get

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  type = 2,    --种类-int 
  value = 3,    --值-int 
  size = 4,    --数量-int 
  content = 5,    --参数-string 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  type = "int",    --种类-2 
  value = "int",    --值-3 
  size = "int",    --数量-4 
  content = "string",    --参数-5 

}


-- data
local horse_get = {
    _data = {
        [1] = {1,6,97,1,"",},
        [2] = {2,5,2,10000,"",},
        [3] = {3,0,0,0,"3018|3023",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in horse_get")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function horse_get.length()
    return #horse_get._data
end

-- 
function horse_get.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function horse_get.indexOf(index)
    if index == nil or not horse_get._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/horse_get.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "horse_get" )
        return setmetatable({_raw = horse_get._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = horse_get._data[index]}, mt)
end

--
function horse_get.get(id)
    
    return horse_get.indexOf(__index_id[id])
        
end

--
function horse_get.set(id, key, value)
    local record = horse_get.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function horse_get.index()
    return __index_id
end

return horse_get