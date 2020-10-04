--guild_purview

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --职位-int 
  name = 2,    --职称-string 
  purview = 3,    --权限-string 

}

-- key type
local __key_type = {
  id = "int",    --职位-1 
  name = "string",    --职称-2 
  purview = "string",    --权限-3 

}


-- data
local guild_purview = {
    _data = {
        [1] = {1,"团长","1|3|4|5|6|7|8|10|11|12|13|14|15",},
        [2] = {2,"副团长","2|5|6|7|8|9|11|12|15",},
        [3] = {3,"长老","2|6|7|9",},
        [4] = {4,"成员","2|9",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in guild_purview")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function guild_purview.length()
    return #guild_purview._data
end

-- 
function guild_purview.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_purview.indexOf(index)
    if index == nil or not guild_purview._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/guild_purview.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_purview" )
        return setmetatable({_raw = guild_purview._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = guild_purview._data[index]}, mt)
end

--
function guild_purview.get(id)
    
    return guild_purview.indexOf(__index_id[id])
        
end

--
function guild_purview.set(id, key, value)
    local record = guild_purview.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function guild_purview.index()
    return __index_id
end

return guild_purview