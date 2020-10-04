--language_length

local _lang = "cn"
local _isExist = false

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
    _data = {
        [1] = {1,"vn",15,15,110,110,110,10,100,},
        [2] = {2,"kr",6,6,60,60,60,6,60,},
        [3] = {3,"tw",7,7,120,120,120,10,100,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in language_length")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
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
function language_length.indexOf(index)
    if index == nil or not language_length._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/language_length.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "language_length" )
        return setmetatable({_raw = language_length._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = language_length._data[index]}, mt)
end

--
function language_length.get(id)
    
    return language_length.indexOf(__index_id[id])
        
end

--
function language_length.set(id, key, value)
    local record = language_length.get(id)
    if record then
        local keyIndex = __key_map[key]
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