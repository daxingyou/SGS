--guild_news

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  news = 2,    --描述-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  news = "string",    --描述-2 

}


-- data
local guild_news = {
    _data = {
        [1] = {1,"#name#加入了军团。",},
        [2] = {2,"#name#被踢出了军团。",},
        [3] = {3,"#name#退出了军团。",},
        [4] = {4,"#name#被任命为新的#position#，大家为其欢呼。",},
        [5] = {5,"#name#被解除了#position#的职位。",},
        [6] = {6,"#name#由于长时间的不作为，终于被弹劾了。",},
        [7] = {7,"#name#奋勇作战，终于通关了#stage#，大家快去抢宝库。",},
        [8] = {8,"#name#慷慨解囊，进行#id#，为军团增加了#prestige#声望。",},
        [9] = {9,"#name#完成了军团求援任务，为军团增加了#prestige#声望。",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in guild_news")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function guild_news.length()
    return #guild_news._data
end

-- 
function guild_news.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_news.indexOf(index)
    if index == nil or not guild_news._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/guild_news.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_news" )
        return setmetatable({_raw = guild_news._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = guild_news._data[index]}, mt)
end

--
function guild_news.get(id)
    
    return guild_news.indexOf(__index_id[id])
        
end

--
function guild_news.set(id, key, value)
    local record = guild_news.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function guild_news.index()
    return __index_id
end

return guild_news