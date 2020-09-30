--guild_news

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

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
    version =  1,
    _data = {
        [1] = {1," #name# 加入了军团。",},
        [2] = {2," #name# 被踢出了军团。",},
        [3] = {3," #name# 退出了军团。",},
        [4] = {4," #name# 被任命为新的 #position# ，大家为其欢呼。",},
        [5] = {5," #name# 被解除了 #position# 的职位。",},
        [6] = {6," #name# 由于长时间的不作为，终于被弹劾了。",},
        [7] = {7," #name# 奋勇作战，终于通关了 #stage# ，大家快去抢宝库。",},
        [8] = {8," #name# 慷慨解囊，进行 #id# ，为军团增加了 #prestige# 声望。",},
        [9] = {9," #name# 完成了军团求援任务，为军团增加了 #prestige# 声望。",},
        [10] = {10," #name# 对 #graincar# 进行了捐献，为 #graincar# 增加了 #num# 经验。",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [10] = 10,
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
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in guild_news")
        if _lang ~= "cn" and _isDataExist  and t._data_key_map[k] then
            return t._data[t._data_key_map[k]]
        end
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[key_map[k]]
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
function guild_news.isVersionValid(v)
    if guild_news.version then
        if v then
            return guild_news.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_news.indexOf(index)
    if index == nil or not guild_news._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_news.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_news.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_news.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_news" )
                _isDataExist = guild_news.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_news" )
                _isBaseExist = guild_news.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_news" )
                _isExist = guild_news.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_news" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_news" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_news._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_news" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_news.get(id)
    
    return guild_news.indexOf(__index_id[id])
        
end

--
function guild_news.set(id, key, value)
    local record = guild_news.get(id)
    if record then
        if _lang ~= "cn" and _isDataExist then
            local keyIndex =  record._data_key_map[key]
            if keyIndex then
                record._data[keyIndex] = value
                return
            end
        end
        if _lang ~= "cn" and _isExist then
            local keyIndex =  record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
                return
            end
        end
        local keyIndex = record._raw_key_map[key]
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