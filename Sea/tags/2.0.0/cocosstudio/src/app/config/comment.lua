--comment

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  level = 2,    --开启等级-int 
  type = 3,    --物品类型-int 
  value = 4,    --类型值-int 
  size = 5,    --数量-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  level = "int",    --开启等级-2 
  type = "int",    --物品类型-3 
  value = "int",    --类型值-4 
  size = "int",    --数量-5 

}


-- data
local comment = {
    _data = {
        [1] = {1,18,5,1,100,},
    }
}

-- index
local __index_id = {
    [1] = 1,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in comment")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function comment.length()
    return #comment._data
end

-- 
function comment.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function comment.indexOf(index)
    if index == nil or not comment._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/comment.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "comment" )
        return setmetatable({_raw = comment._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = comment._data[index]}, mt)
end

--
function comment.get(id)
    
    return comment.indexOf(__index_id[id])
        
end

--
function comment.set(id, key, value)
    local record = comment.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function comment.index()
    return __index_id
end

return comment