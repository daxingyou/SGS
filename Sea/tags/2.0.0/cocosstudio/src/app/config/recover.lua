--recover

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --数值ID-int 
  name = 2,    --数值名称-string 
  recover_num = 3,    --单次恢复数量-int 
  recover_time = 4,    --恢复时间间隔-int 
  time_limit = 5,    --自然恢复上限-int 
  client_limit = 6,    --客户端上限-int 
  max_limit = 7,    --最大上限-int 

}

-- key type
local __key_type = {
  id = "int",    --数值ID-1 
  name = "string",    --数值名称-2 
  recover_num = "int",    --单次恢复数量-3 
  recover_time = "int",    --恢复时间间隔-4 
  time_limit = "int",    --自然恢复上限-5 
  client_limit = "int",    --客户端上限-6 
  max_limit = "int",    --最大上限-7 

}


-- data
local recover = {
    _data = {
        [1] = {3,"体力",1,360,100,500,999,},
        [2] = {4,"精力",1,1800,30,200,999,},
        [3] = {11,"围剿次数",1,3600,10,100,999,},
        [4] = {12,"挑战次数",1,3600,5,5,5,},
        [5] = {22,"粮草",1,720,200,500,9999,},
        [6] = {23,"攻击次数",1,3600,20,500,999,},
    }
}

-- index
local __index_id = {
    [11] = 3,
    [12] = 4,
    [22] = 5,
    [23] = 6,
    [3] = 1,
    [4] = 2,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in recover")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function recover.length()
    return #recover._data
end

-- 
function recover.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function recover.indexOf(index)
    if index == nil or not recover._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/recover.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "recover" )
        return setmetatable({_raw = recover._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = recover._data[index]}, mt)
end

--
function recover.get(id)
    
    return recover.indexOf(__index_id[id])
        
end

--
function recover.set(id, key, value)
    local record = recover.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function recover.index()
    return __index_id
end

return recover