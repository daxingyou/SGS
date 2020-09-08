--cross_boss_text

local _lang = "cn"
local _isExist = false
local _isBaseExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  text = 2,    --相关文本-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  text = "string",    --相关文本-2 

}


-- data
local cross_boss_text = {
    _data = {
        [1] = {1,"主公, 本次挑战跨服BOSS, 你所在军团参与人数#number#人, 军团积分排名第#rank#名, 获得军团声望#prestige#, 奖励已发放到军团拍卖及邮件.",},
        [2] = {2,"主公, 本次挑战跨服BOSS, 你个人积分排名第#rank#名, 奖励已发放到邮件(加入军团可获得更多奖励哟!)",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in cross_boss_text")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[key_map[k]]
    end
}

-- 
function cross_boss_text.length()
    return #cross_boss_text._data
end

-- 
function cross_boss_text.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cross_boss_text.indexOf(index)
    if index == nil or not cross_boss_text._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.isFileExist("app/i18n/".. _lang .."/config/cross_boss_text.lua") then 
            _isExist =  true 
        end
        _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/cross_boss_text.lua")
    end
    
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cross_boss_text" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        local raw = cross_boss_text._data[index]
        if _isBaseExist then
            local table_base = require( "app.i18n.".. _lang ..".base." .. "cross_boss_text" )
            raw =  table_base._data[index] 
        end
        return setmetatable({_raw = raw,_raw_key_map = __key_map, _lang=table._data[lang_index], _lang_key_map=table.__key_map}, mt)
    end
    local raw = cross_boss_text._data[index]
    if _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "cross_boss_text" )
        raw =  table_base._data[index] 
    end
    return setmetatable({_raw = raw,_raw_key_map = __key_map}, mt)
end

--
function cross_boss_text.get(id)
    
    return cross_boss_text.indexOf(__index_id[id])
        
end

--
function cross_boss_text.set(id, key, value)
    local record = cross_boss_text.get(id)
    if record then
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
function cross_boss_text.index()
    return __index_id
end

return cross_boss_text