--language_length

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  language = 2,    --语言-string 
  role_length = 3,    --角色名长度-int 
  legion_length = 4,    --军团名长度-int 
  legion_notice_length = 5,    --军团公告长度-int 
  legion_declaration_length = 6,    --军团宣言长度-int 
  legion_mail_length = 7,    --军团发送邮件字符限制-int 
  silk_bag = 8,    --锦囊组字符长度-int 
  chat_length = 9,    --聊天字符长度-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  language = "string",    --语言-2 
  role_length = "int",    --角色名长度-3 
  legion_length = "int",    --军团名长度-4 
  legion_notice_length = "int",    --军团公告长度-5 
  legion_declaration_length = "int",    --军团宣言长度-6 
  legion_mail_length = "int",    --军团发送邮件字符限制-7 
  silk_bag = "int",    --锦囊组字符长度-8 
  chat_length = "int",    --聊天字符长度-9 

}


-- data
local language_length = {
    version =  1,
    _data = {
        [1] = {1,"vn",15,15,110,110,110,10,100,},
        [2] = {2,"kr",6,6,60,60,60,6,60,},
        [3] = {3,"tw",7,7,120,120,120,10,100,},
        [4] = {4,"th",15,15,110,110,110,10,100,},
        [5] = {5,"en",15,15,110,110,110,10,100,},
        [6] = {6,"zh",7,7,60,60,60,6,60,},
        [7] = {7,"ja",7,6,60,60,60,6,60,},
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

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in language_length")
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
function language_length.length()
    return #language_length._data
end

-- 
function language_length.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function language_length.isVersionValid(v)
    if language_length.version then
        if v then
            return language_length.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function language_length.indexOf(index)
    if index == nil or not language_length._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/language_length.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/language_length.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/language_length.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "language_length" )
                _isDataExist = language_length.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "language_length" )
                _isBaseExist = language_length.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "language_length" )
                _isExist = language_length.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "language_length" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "language_length" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = language_length._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "language_length" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function language_length.get(id)
    
    return language_length.indexOf(__index_id[id])
        
end

--
function language_length.set(id, key, value)
    local record = language_length.get(id)
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
function language_length.index()
    return __index_id
end

return language_length