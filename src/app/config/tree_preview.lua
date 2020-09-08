--tree_preview

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

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
    version =  1,
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
        [10] = {12,300,99999,"1|10|11","2|10|11","3|10|11","5|10|11","6|10|11","4|10|11",},
        [11] = {13,300,99999,"1|11|12","2|11|12","3|11|12","5|11|12","6|11|12","4|11|12",},
    }
}

-- index
local __index_id = {
    [10] = 8,
    [11] = 9,
    [12] = 10,
    [13] = 11,
    [3] = 1,
    [4] = 2,
    [5] = 3,
    [6] = 4,
    [7] = 5,
    [8] = 6,
    [9] = 7,

}

-- index mainkey map
local __main_key_map = {
    [8] = 10,
    [9] = 11,
    [10] = 12,
    [11] = 13,
    [1] = 3,
    [2] = 4,
    [3] = 5,
    [4] = 6,
    [5] = 7,
    [6] = 8,
    [7] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in tree_preview")
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
function tree_preview.isVersionValid(v)
    if tree_preview.version then
        if v then
            return tree_preview.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function tree_preview.indexOf(index)
    if index == nil or not tree_preview._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/tree_preview.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/tree_preview.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/tree_preview.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "tree_preview" )
                _isDataExist = tree_preview.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "tree_preview" )
                _isBaseExist = tree_preview.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "tree_preview" )
                _isExist = tree_preview.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "tree_preview" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "tree_preview" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = tree_preview._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "tree_preview" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function tree_preview.get(id)
    
    return tree_preview.indexOf(__index_id[id])
        
end

--
function tree_preview.set(id, key, value)
    local record = tree_preview.get(id)
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
function tree_preview.index()
    return __index_id
end

return tree_preview