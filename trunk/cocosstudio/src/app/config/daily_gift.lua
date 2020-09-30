--daily_gift

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  day_begin = 2,    --开始天数-int 
  day_end = 3,    --结束天数-int 
  hour_begin = 4,    --开始时间-int 
  hour_end = 5,    --结束时间-int 
  type_1 = 6,    --奖励类型1-int 
  value_1 = 7,    --类型值1-int 
  size_1 = 8,    --数量1-int 
  type_2 = 9,    --奖励类型2-int 
  value_2 = 10,    --类型值2-int 
  size_2 = 11,    --数量2-int 
  type_3 = 12,    --奖励类型3-int 
  value_3 = 13,    --类型值3-int 
  size_3 = 14,    --数量3-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  day_begin = "int",    --开始天数-2 
  day_end = "int",    --结束天数-3 
  hour_begin = "int",    --开始时间-4 
  hour_end = "int",    --结束时间-5 
  type_1 = "int",    --奖励类型1-6 
  value_1 = "int",    --类型值1-7 
  size_1 = "int",    --数量1-8 
  type_2 = "int",    --奖励类型2-9 
  value_2 = "int",    --类型值2-10 
  size_2 = "int",    --数量2-11 
  type_3 = "int",    --奖励类型3-12 
  value_3 = "int",    --类型值3-13 
  size_3 = "int",    --数量3-14 

}


-- data
local daily_gift = {
    version =  1,
    _data = {
        [1] = {1,999,999,8,10,5,1,77,0,0,0,0,0,0,},
        [2] = {2,999,999,8,10,5,2,70000,0,0,0,0,0,0,},
        [3] = {3,999,999,8,10,6,21,1,0,0,0,0,0,0,},
        [4] = {4,999,999,8,10,6,3,50,0,0,0,0,0,0,},
        [5] = {5,999,999,8,10,6,19,50,0,0,0,0,0,0,},
        [6] = {6,999,999,8,10,6,20,1,0,0,0,0,0,0,},
        [7] = {7,999,999,8,10,5,2,70000,0,0,0,0,0,0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in daily_gift")
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
function daily_gift.length()
    return #daily_gift._data
end

-- 
function daily_gift.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function daily_gift.isVersionValid(v)
    if daily_gift.version then
        if v then
            return daily_gift.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function daily_gift.indexOf(index)
    if index == nil or not daily_gift._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/daily_gift.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/daily_gift.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/daily_gift.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "daily_gift" )
                _isDataExist = daily_gift.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "daily_gift" )
                _isBaseExist = daily_gift.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "daily_gift" )
                _isExist = daily_gift.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "daily_gift" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "daily_gift" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = daily_gift._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "daily_gift" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function daily_gift.get(id)
    
    return daily_gift.indexOf(__index_id[id])
        
end

--
function daily_gift.set(id, key, value)
    local record = daily_gift.get(id)
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
function daily_gift.index()
    return __index_id
end

return daily_gift