--city_timeshow

local _lang = "cn"
local _isExist = false
local _isBaseExist = false

-- key
local __key_map = {
  id = 1,    --id-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 

}


-- data
local city_timeshow = {
    _data = {
        [1] = {1,},
        [2] = {2,},
        [3] = {3,},
        [4] = {4,},
        [5] = {5,},
        [6] = {6,},
        [7] = {7,},
        [8] = {8,},
        [9] = {9,},
        [10] = {10,},
        [11] = {11,},
        [12] = {12,},
        [13] = {13,},
        [14] = {14,},
        [15] = {15,},
        [16] = {16,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in city_timeshow")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[key_map[k]]
    end
}

-- 
function city_timeshow.length()
    return #city_timeshow._data
end

-- 
function city_timeshow.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function city_timeshow.indexOf(index)
    if index == nil or not city_timeshow._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.isFileExist("app/i18n/".. _lang .."/config/city_timeshow.lua") then 
            _isExist =  true 
        end
        _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/city_timeshow.lua")
    end
    
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "city_timeshow" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        local raw = city_timeshow._data[index]
        if _isBaseExist then
            local table_base = require( "app.i18n.".. _lang ..".base." .. "city_timeshow" )
            raw =  table_base._data[index] 
        end
        return setmetatable({_raw = raw,_raw_key_map = __key_map, _lang=table._data[lang_index], _lang_key_map=table.__key_map}, mt)
    end
    local raw = city_timeshow._data[index]
    if _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "city_timeshow" )
        raw =  table_base._data[index] 
    end
    return setmetatable({_raw = raw,_raw_key_map = __key_map}, mt)
end

--
function city_timeshow.get(id)
    
    return city_timeshow.indexOf(__index_id[id])
        
end

--
function city_timeshow.set(id, key, value)
    local record = city_timeshow.get(id)
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
function city_timeshow.index()
    return __index_id
end

return city_timeshow