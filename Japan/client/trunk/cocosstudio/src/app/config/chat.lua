--chat

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  key = 2,    --参数名称-string 
  content = 3,    --参数内容-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  key = "string",    --参数名称-2 
  content = "string",    --参数内容-3 

}


-- data
local chat = {
    version =  1,
    _data = {
        [1] = {1,"chat_world_accept_level","1",},
        [2] = {2,"chat_world_level","10",},
        [3] = {3,"chat_world_interval","10",},
        [4] = {4,"chat_gang_interval","1",},
        [5] = {5,"chat_voice","30",},
        [6] = {6,"chat_text","30",},
        [7] = {7,"sent_private_chat","10",},
        [8] = {8,"system","50",},
        [9] = {9,"private_chat_number","100",},
        [10] = {10,"chat_voice_min","1",},
        [11] = {11,"chat_gang_level","10",},
        [12] = {12,"low_vip_number","20",},
        [13] = {13,"low_vip","1",},
        [14] = {14,"low_level","30",},
        [15] = {15,"limite_number","5",},
        [16] = {16,"private_chat_level","18",},
        [17] = {17,"limite_level","30",},
        [18] = {18,"limite_vip","1",},
        [19] = {19,"qin_world_cd","20",},
        [20] = {20,"qin_guild_cd","20",},
        [21] = {21,"pvpsingle_chat_level","60",},
        [22] = {22,"private_chat_day","7",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [20] = 20,
    [21] = 21,
    [22] = 22,
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
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [20] = 20,
    [21] = 21,
    [22] = 22,
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
        assert(key_map[k], "cannot find " .. k .. " in chat")
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
function chat.length()
    return #chat._data
end

-- 
function chat.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function chat.isVersionValid(v)
    if chat.version then
        if v then
            return chat.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function chat.indexOf(index)
    if index == nil or not chat._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/chat.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/chat.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/chat.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "chat" )
                _isDataExist = chat.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "chat" )
                _isBaseExist = chat.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "chat" )
                _isExist = chat.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "chat" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "chat" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = chat._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "chat" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function chat.get(id)
    
    return chat.indexOf(__index_id[id])
        
end

--
function chat.set(id, key, value)
    local record = chat.get(id)
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
function chat.index()
    return __index_id
end

return chat