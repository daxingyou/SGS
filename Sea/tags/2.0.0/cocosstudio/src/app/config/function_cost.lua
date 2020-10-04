--function_cost

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --功能名称-int 
  name = 2,    --功能名称-string 
  free_count = 3,    --免费次数-int 
  buy_add_count = 4,    --每次购买增加次数-int 
  vip_function_id = 5,    --购买次数与vip的关系-int 
  price_id = 6,    --购买价格与次数的关系-int 

}

-- key type
local __key_type = {
  id = "int",    --功能名称-1 
  name = "string",    --功能名称-2 
  free_count = "int",    --免费次数-3 
  buy_add_count = "int",    --每次购买增加次数-4 
  vip_function_id = "int",    --购买次数与vip的关系-5 
  price_id = "int",    --购买价格与次数的关系-6 

}


-- data
local function_cost = {
    _data = {
        [1] = {10001,"竞技场挑战次数",10,5,10001,10001,},
        [2] = {10002,"军团援助次数",10,1,10002,10002,},
        [3] = {10003,"金将招募",5,1,10003,10003,},
    }
}

-- index
local __index_id = {
    [10001] = 1,
    [10002] = 2,
    [10003] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in function_cost")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function function_cost.length()
    return #function_cost._data
end

-- 
function function_cost.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function function_cost.indexOf(index)
    if index == nil or not function_cost._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/function_cost.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "function_cost" )
        return setmetatable({_raw = function_cost._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = function_cost._data[index]}, mt)
end

--
function function_cost.get(id)
    
    return function_cost.indexOf(__index_id[id])
        
end

--
function function_cost.set(id, key, value)
    local record = function_cost.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function function_cost.index()
    return __index_id
end

return function_cost