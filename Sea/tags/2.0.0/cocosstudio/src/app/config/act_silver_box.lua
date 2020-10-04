--act_silver_box

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  box_name = 2,    --宝箱标题-string 
  count = 3,    --领取次数-int 
  type = 4,    --类型1-int 
  value = 5,    --类型值1-int 
  size = 6,    --数量1-int 
  type_1 = 7,    --类型2-int 
  value_1 = 8,    --类型值2-int 
  size_1 = 9,    --数量2-int 
  type_2 = 10,    --类型3-int 
  value_2 = 11,    --类型值3-int 
  size_2 = 12,    --数量3-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  box_name = "string",    --宝箱标题-2 
  count = "int",    --领取次数-3 
  type = "int",    --类型1-4 
  value = "int",    --类型值1-5 
  size = "int",    --数量1-6 
  type_1 = "int",    --类型2-7 
  value_1 = "int",    --类型值2-8 
  size_1 = "int",    --数量2-9 
  type_2 = "int",    --类型3-10 
  value_2 = "int",    --类型值3-11 
  size_2 = "int",    --数量3-12 

}


-- data
local act_silver_box = {
    _data = {
        [1] = {1,"10次礼包",10,5,2,20000,0,0,0,0,0,0,},
        [2] = {2,"20次礼包",20,5,2,50000,0,0,0,0,0,0,},
        [3] = {3,"30次礼包",30,5,2,80000,0,0,0,0,0,0,},
        [4] = {4,"40次礼包",40,5,2,100000,0,0,0,0,0,0,},
        [5] = {5,"50次礼包",50,5,2,120000,0,0,0,0,0,0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in act_silver_box")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function act_silver_box.length()
    return #act_silver_box._data
end

-- 
function act_silver_box.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function act_silver_box.indexOf(index)
    if index == nil or not act_silver_box._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/act_silver_box.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "act_silver_box" )
        return setmetatable({_raw = act_silver_box._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = act_silver_box._data[index]}, mt)
end

--
function act_silver_box.get(id)
    
    return act_silver_box.indexOf(__index_id[id])
        
end

--
function act_silver_box.set(id, key, value)
    local record = act_silver_box.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function act_silver_box.index()
    return __index_id
end

return act_silver_box