--guild_war_bg

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  battlefield_type = 1,    --对应战场类型-int 
  pic_name = 2,    --背景名称-string 
  infeed_num = 3,    --横向图片数量-int 
  endwise_num = 4,    --纵向图片数量-int 

}

-- key type
local __key_type = {
  battlefield_type = "int",    --对应战场类型-1 
  pic_name = "string",    --背景名称-2 
  infeed_num = "int",    --横向图片数量-3 
  endwise_num = "int",    --纵向图片数量-4 

}


-- data
local guild_war_bg = {
    _data = {
        [1] = {1,"guildwar_bg_1",4,1,},
        [2] = {2,"guildwar_bg_2",4,1,},
        [3] = {3,"guildwar_bg_3",4,2,},
    }
}

-- index
local __index_battlefield_type = {
    [1] = 1,
    [2] = 2,
    [3] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in guild_war_bg")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function guild_war_bg.length()
    return #guild_war_bg._data
end

-- 
function guild_war_bg.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_war_bg.indexOf(index)
    if index == nil or not guild_war_bg._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/guild_war_bg.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_war_bg" )
        return setmetatable({_raw = guild_war_bg._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = guild_war_bg._data[index]}, mt)
end

--
function guild_war_bg.get(battlefield_type)
    
    return guild_war_bg.indexOf(__index_battlefield_type[battlefield_type])
        
end

--
function guild_war_bg.set(battlefield_type, key, value)
    local record = guild_war_bg.get(battlefield_type)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function guild_war_bg.index()
    return __index_battlefield_type
end

return guild_war_bg