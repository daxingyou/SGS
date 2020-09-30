--mail_lang

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --ID-int 
  mail_type = 2,    --邮件类型-int 
  label_type = 3,    --标签类型-int 
  mail_name = 4,    --发件人-string 
  mail_title = 5,    --邮件标题-string 
  mail_is_delete = 6,    --邮件是否删除-int 
  mail_text = 7,    --邮件文本-string 

}

-- key type
local __key_type = {
  id = "int",    --ID-1 
  mail_type = "int",    --邮件类型-2 
  label_type = "int",    --标签类型-3 
  mail_name = "string",    --发件人-4 
  mail_title = "string",    --邮件标题-5 
  mail_is_delete = "int",    --邮件是否删除-6 
  mail_text = "string",    --邮件文本-7 

}


-- data
local mail_lang = {
    version =  1,
    _data = {
        [1] = {8401,1,2,"小乔","充值提醒",0,"您于xxxx年x月x日，xx：xx：xx点，在官网上购买了#name#，对应奖励已直接发放到您指定账户，同时激活当天对应累充活动；以下是本次网页充值的额外奖励，感谢您的支持！",},
        [2] = {8402,1,2,"小乔","充值提醒",0,"您于xxxx年x月x日，xx：xx：xx点，在官网上购买了#name#，部分奖励已直接发放到您账户，剩余奖励请到游戏内对应界面领取，同时激活当天对应累充活动，感谢您的支持！",},
    }
}

-- index
local __index_id = {
    [8401] = 1,
    [8402] = 2,

}

-- index mainkey map
local __main_key_map = {
    [1] = 8401,
    [2] = 8402,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in mail_lang")
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
function mail_lang.length()
    return #mail_lang._data
end

-- 
function mail_lang.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function mail_lang.isVersionValid(v)
    if mail_lang.version then
        if v then
            return mail_lang.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function mail_lang.indexOf(index)
    if index == nil or not mail_lang._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/mail_lang.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/mail_lang.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/mail_lang.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "mail_lang" )
                _isDataExist = mail_lang.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "mail_lang" )
                _isBaseExist = mail_lang.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "mail_lang" )
                _isExist = mail_lang.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "mail_lang" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "mail_lang" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = mail_lang._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "mail_lang" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function mail_lang.get(id)
    
    return mail_lang.indexOf(__index_id[id])
        
end

--
function mail_lang.set(id, key, value)
    local record = mail_lang.get(id)
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
function mail_lang.index()
    return __index_id
end

return mail_lang