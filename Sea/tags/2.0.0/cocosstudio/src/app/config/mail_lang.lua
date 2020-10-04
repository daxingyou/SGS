--mail_lang

local _lang = "cn"
local _isExist = false

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
    _data = {
        [1] = {8401,1,2,"小乔","充值提醒",0,"您于xxxx年x月x日，xx：xx：xx点，在官网上购买了#name#，对应奖励已直接发放到您指定账户，同时激活当天对应累充活动；以下是本次网页充值的额外奖励，感谢您的支持！",},
        [2] = {8402,1,2,"小乔","充值提醒",0,"您于xxxx年x月x日，xx：xx：xx点，在官网上购买了#name#，部分奖励已直接发放到您账户，基金月卡类请到游戏内对应界面领取，同时激活当天对应累充活动；以下是本次网页充值的额外奖励，感谢您的支持！",},
    }
}

-- index
local __index_id = {
    [8401] = 1,
    [8402] = 2,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in mail_lang")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
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
function mail_lang.indexOf(index)
    if index == nil or not mail_lang._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/mail_lang.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "mail_lang" )
        return setmetatable({_raw = mail_lang._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = mail_lang._data[index]}, mt)
end

--
function mail_lang.get(id)
    
    return mail_lang.indexOf(__index_id[id])
        
end

--
function mail_lang.set(id, key, value)
    local record = mail_lang.get(id)
    if record then
        local keyIndex = __key_map[key]
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