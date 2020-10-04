--vip_level_price

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  pay_level = 2,    --等级显示-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  pay_level = "int",    --等级显示-2 

}


-- data
local vip_level_price = {
    _data = {
        [1] = {1,250,},
    }
}

-- index
local __index_id = {
    [1] = 1,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in vip_level_price")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function vip_level_price.length()
    return #vip_level_price._data
end

-- 
function vip_level_price.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function vip_level_price.indexOf(index)
    if index == nil or not vip_level_price._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/vip_level_price.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "vip_level_price" )
        return setmetatable({_raw = vip_level_price._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = vip_level_price._data[index]}, mt)
end

--
function vip_level_price.get(id)
    
    return vip_level_price.indexOf(__index_id[id])
        
end

--
function vip_level_price.set(id, key, value)
    local record = vip_level_price.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function vip_level_price.index()
    return __index_id
end

return vip_level_price