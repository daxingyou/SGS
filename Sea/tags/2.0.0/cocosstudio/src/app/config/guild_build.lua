--guild_build

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  key = 2,    --参数名称-string 
  time = 3,    --每日建设次数-int 
  legion_capital = 4,    --获得军团资金-int 
  contribution = 5,    --获得个人贡献-int 
  need_people = 6,    --需要人数-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  key = "string",    --参数名称-2 
  time = "int",    --每日建设次数-3 
  legion_capital = "int",    --获得军团资金-4 
  contribution = "int",    --获得个人贡献-5 
  need_people = "int",    --需要人数-6 

}


-- data
local guild_build = {
    _data = {
        [1] = {1,"single_build",1,100,200,1,},
        [2] = {2,"cooperate_build",1,500,1000,5,},
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
        assert(__key_map[k], "cannot find " .. k .. " in guild_build")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function guild_build.length()
    return #guild_build._data
end

-- 
function guild_build.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_build.indexOf(index)
    if index == nil or not guild_build._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/guild_build.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_build" )
        return setmetatable({_raw = guild_build._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = guild_build._data[index]}, mt)
end

--
function guild_build.get(id)
    
    return guild_build.indexOf(__index_id[id])
        
end

--
function guild_build.set(id, key, value)
    local record = guild_build.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function guild_build.index()
    return __index_id
end

return guild_build