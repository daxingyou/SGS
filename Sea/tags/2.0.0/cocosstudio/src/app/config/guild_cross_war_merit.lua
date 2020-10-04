--guild_cross_war_merit

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  merit_min = 2,    --积分下限-int 
  merit_max = 3,    --积分上限-int 
  type = 4,    --类型-int 
  value = 5,    --值-int 
  size = 6,    --数量-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  merit_min = "int",    --积分下限-2 
  merit_max = "int",    --积分上限-3 
  type = "int",    --类型-4 
  value = "int",    --值-5 
  size = "int",    --数量-6 

}


-- data
local guild_cross_war_merit = {
    _data = {
        [1] = {1,0,99,6,115,1,},
        [2] = {2,100,199,6,115,2,},
        [3] = {3,200,399,6,115,3,},
        [4] = {4,400,599,6,115,4,},
        [5] = {5,600,9999,6,115,5,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in guild_cross_war_merit")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function guild_cross_war_merit.length()
    return #guild_cross_war_merit._data
end

-- 
function guild_cross_war_merit.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_cross_war_merit.indexOf(index)
    if index == nil or not guild_cross_war_merit._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/guild_cross_war_merit.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war_merit" )
        return setmetatable({_raw = guild_cross_war_merit._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = guild_cross_war_merit._data[index]}, mt)
end

--
function guild_cross_war_merit.get(id)
    
    return guild_cross_war_merit.indexOf(__index_id[id])
        
end

--
function guild_cross_war_merit.set(id, key, value)
    local record = guild_cross_war_merit.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function guild_cross_war_merit.index()
    return __index_id
end

return guild_cross_war_merit