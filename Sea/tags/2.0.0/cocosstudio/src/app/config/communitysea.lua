--communitysea

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id_key-int 
  res = 2,    --图片名称-string 
  webname = 3,    --网页名称-string 
  web = 4,    --跳转网页-string 

}

-- key type
local __key_type = {
  id = "int",    --id_key-1 
  res = "string",    --图片名称-2 
  webname = "string",    --网页名称-3 
  web = "string",    --跳转网页-4 

}


-- data
local communitysea = {
    _data = {
        [1] = {1,"youtube","YouTube","https://m.youtube.com/channel/UCEvQivrRmpYIj_Ii35Mu1ig",},
        [2] = {2,"facebook","Facebook","https://www.facebook.com/OfficialDynastyHeroes/",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in communitysea")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function communitysea.length()
    return #communitysea._data
end

-- 
function communitysea.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function communitysea.indexOf(index)
    if index == nil or not communitysea._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/communitysea.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "communitysea" )
        return setmetatable({_raw = communitysea._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = communitysea._data[index]}, mt)
end

--
function communitysea.get(id)
    
    return communitysea.indexOf(__index_id[id])
        
end

--
function communitysea.set(id, key, value)
    local record = communitysea.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function communitysea.index()
    return __index_id
end

return communitysea