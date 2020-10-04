--guild_wages_type

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  type = 1,    --类型-int 
  name = 2,    --任务名称-string 
  index = 3,    --排列-int 
  is_open = 4,    --是否显示已开放-int 
  max_active = 5,    --最大活跃度-int 
  color1 = 6,    --毫无生气需要积分-int 
  color2 = 7,    --不活跃需要积分-int 
  color3 = 8,    --普通需要积分-int 
  color4 = 9,    --活跃需要积分-int 
  color5 = 10,    --非常活跃需要积分-int 
  function_id = 11,    --功能跳转-int 

}

-- key type
local __key_type = {
  type = "int",    --类型-1 
  name = "string",    --任务名称-2 
  index = "int",    --排列-3 
  is_open = "int",    --是否显示已开放-4 
  max_active = "int",    --最大活跃度-5 
  color1 = "int",    --毫无生气需要积分-6 
  color2 = "int",    --不活跃需要积分-7 
  color3 = "int",    --普通需要积分-8 
  color4 = "int",    --活跃需要积分-9 
  color5 = "int",    --非常活跃需要积分-10 
  function_id = "int",    --功能跳转-11 

}


-- data
local guild_wages_type = {
    _data = {
        [1] = {1,"三国战记",1,1,40,0,8,16,24,32,67,},
        [2] = {2,"军团捐献",2,1,40,0,8,16,24,32,62,},
        [3] = {3,"军团BOSS",4,1,80,0,16,32,48,64,803,},
        [4] = {4,"答题活动",6,1,40,0,8,16,24,32,87,},
        [5] = {5,"军团试炼",5,1,40,0,8,16,24,32,64,},
        [6] = {6,"军团援助",3,1,40,0,8,16,24,32,63,},
    }
}

-- index
local __index_type = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in guild_wages_type")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function guild_wages_type.length()
    return #guild_wages_type._data
end

-- 
function guild_wages_type.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_wages_type.indexOf(index)
    if index == nil or not guild_wages_type._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/guild_wages_type.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_wages_type" )
        return setmetatable({_raw = guild_wages_type._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = guild_wages_type._data[index]}, mt)
end

--
function guild_wages_type.get(type)
    
    return guild_wages_type.indexOf(__index_type[type])
        
end

--
function guild_wages_type.set(type, key, value)
    local record = guild_wages_type.get(type)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function guild_wages_type.index()
    return __index_type
end

return guild_wages_type