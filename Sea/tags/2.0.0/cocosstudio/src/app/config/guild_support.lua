--guild_support

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  color = 1,    --捐献武将品质-int 
  guild_lv = 2,    --需要军团等级-int 
  launch_max = 3,    --最多可发起次数-int 
  times = 4,    --可获捐次数-int 
  contribution = 5,    --援助获得贡献-int 
  experience = 6,    --援助获得声望-int 

}

-- key type
local __key_type = {
  color = "int",    --捐献武将品质-1 
  guild_lv = "int",    --需要军团等级-2 
  launch_max = "int",    --最多可发起次数-3 
  times = "int",    --可获捐次数-4 
  contribution = "int",    --援助获得贡献-5 
  experience = "int",    --援助获得声望-6 

}


-- data
local guild_support = {
    _data = {
        [1] = {4,1,3,5,200,0,},
        [2] = {5,1,3,5,200,0,},
        [3] = {6,6,2,2,500,0,},
    }
}

-- index
local __index_color = {
    [4] = 1,
    [5] = 2,
    [6] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in guild_support")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function guild_support.length()
    return #guild_support._data
end

-- 
function guild_support.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_support.indexOf(index)
    if index == nil or not guild_support._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/guild_support.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_support" )
        return setmetatable({_raw = guild_support._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = guild_support._data[index]}, mt)
end

--
function guild_support.get(color)
    
    return guild_support.indexOf(__index_color[color])
        
end

--
function guild_support.set(color, key, value)
    local record = guild_support.get(color)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function guild_support.index()
    return __index_color
end

return guild_support