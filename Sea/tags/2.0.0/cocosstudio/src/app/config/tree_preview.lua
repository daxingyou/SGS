--tree_preview

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --神树id-int 
  day_min = 2,    --开服天数_min-int 
  day_max = 3,    --开服天数_max-int 
  condition_1 = 4,    --条件1-string 
  condition_2 = 5,    --条件2-string 
  condition_3 = 6,    --条件3-string 
  condition_4 = 7,    --条件4-string 
  condition_5 = 8,    --条件5-string 
  condition_6 = 9,    --条件6-string 

}

-- key type
local __key_type = {
  id = "int",    --神树id-1 
  day_min = "int",    --开服天数_min-2 
  day_max = "int",    --开服天数_max-3 
  condition_1 = "string",    --条件1-4 
  condition_2 = "string",    --条件2-5 
  condition_3 = "string",    --条件3-6 
  condition_4 = "string",    --条件4-7 
  condition_5 = "string",    --条件5-8 
  condition_6 = "string",    --条件6-9 

}


-- data
local tree_preview = {
    _data = {
        [1] = {3,14,99999,"1|1|2","","","","","",},
        [2] = {4,14,99999,"1|2|3","2|1|2","","","","",},
        [3] = {5,14,99999,"1|3|4","2|2|3","3|1|2","","","",},
        [4] = {6,14,99999,"1|4|5","2|3|5","3|2|5","5|1|3","","",},
        [5] = {7,14,99999,"1|5|6","2|5|6","3|5|6","5|3|5","6|1|4","",},
        [6] = {8,14,99999,"1|6|7","2|6|7","3|6|7","5|5|7","6|4|7","4|1|7",},
        [7] = {9,85,99999,"1|7|8","2|7|8","3|7|8","5|7|8","6|7|8","4|7|8",},
        [8] = {10,147,99999,"1|8|9","2|8|9","3|8|9","5|8|9","6|8|9","4|8|9",},
        [9] = {11,147,99999,"1|9|10","2|9|10","3|9|10","5|9|10","6|9|10","4|9|10",},
    }
}

-- index
local __index_id = {
    [10] = 8,
    [11] = 9,
    [3] = 1,
    [4] = 2,
    [5] = 3,
    [6] = 4,
    [7] = 5,
    [8] = 6,
    [9] = 7,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in tree_preview")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function tree_preview.length()
    return #tree_preview._data
end

-- 
function tree_preview.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function tree_preview.indexOf(index)
    if index == nil or not tree_preview._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/tree_preview.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "tree_preview" )
        return setmetatable({_raw = tree_preview._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = tree_preview._data[index]}, mt)
end

--
function tree_preview.get(id)
    
    return tree_preview.indexOf(__index_id[id])
        
end

--
function tree_preview.set(id, key, value)
    local record = tree_preview.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function tree_preview.index()
    return __index_id
end

return tree_preview