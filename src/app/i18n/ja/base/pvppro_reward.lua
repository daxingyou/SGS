--pvppro_reward

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --奖励id-int 
  type_1 = 2,    --类型1-int 
  value_1 = 3,    --类型值1-int 
  size_1 = 4,    --数量1-int 
  type_2 = 5,    --类型2-int 
  value_2 = 6,    --类型值2-int 
  size_2 = 7,    --数量2-int 
  type_3 = 8,    --类型3-int 
  value_3 = 9,    --类型值3-int 
  size_3 = 10,    --数量3-int 
  type_4 = 11,    --类型4-int 
  value_4 = 12,    --类型值4-int 
  size_4 = 13,    --数量4-int 
  type_5 = 14,    --类型5-int 
  value_5 = 15,    --类型值5-int 
  size_5 = 16,    --数量5-int 
  type_6 = 17,    --类型6-int 
  value_6 = 18,    --类型值6-int 
  size_6 = 19,    --数量6-int 
  type_7 = 20,    --类型7-int 
  value_7 = 21,    --类型值7-int 
  size_7 = 22,    --数量7-int 
  type_8 = 23,    --类型8-int 
  value_8 = 24,    --类型值8-int 
  size_8 = 25,    --数量8-int 
  type_9 = 26,    --类型9-int 
  value_9 = 27,    --类型值9-int 
  size_9 = 28,    --数量9-int 
  type_10 = 29,    --类型10-int 
  value_10 = 30,    --类型值10-int 
  size_10 = 31,    --数量10-int 

}

-- key type
local __key_type = {
  id = "int",    --奖励id-1 
  type_1 = "int",    --类型1-2 
  value_1 = "int",    --类型值1-3 
  size_1 = "int",    --数量1-4 
  type_2 = "int",    --类型2-5 
  value_2 = "int",    --类型值2-6 
  size_2 = "int",    --数量2-7 
  type_3 = "int",    --类型3-8 
  value_3 = "int",    --类型值3-9 
  size_3 = "int",    --数量3-10 
  type_4 = "int",    --类型4-11 
  value_4 = "int",    --类型值4-12 
  size_4 = "int",    --数量4-13 
  type_5 = "int",    --类型5-14 
  value_5 = "int",    --类型值5-15 
  size_5 = "int",    --数量5-16 
  type_6 = "int",    --类型6-17 
  value_6 = "int",    --类型值6-18 
  size_6 = "int",    --数量6-19 
  type_7 = "int",    --类型7-20 
  value_7 = "int",    --类型值7-21 
  size_7 = "int",    --数量7-22 
  type_8 = "int",    --类型8-23 
  value_8 = "int",    --类型值8-24 
  size_8 = "int",    --数量8-25 
  type_9 = "int",    --类型9-26 
  value_9 = "int",    --类型值9-27 
  size_9 = "int",    --数量9-28 
  type_10 = "int",    --类型10-29 
  value_10 = "int",    --类型值10-30 
  size_10 = "int",    --数量10-31 

}


-- data
local pvppro_reward = {
    version =  1,
    _data = {
        [1] = {99,6,121,1,11,1301,1,11,1303,1,11,1313,1,11,1304,1,11,1308,1,11,1312,1,11,1314,1,0,0,0,0,0,0,},
        [2] = {1,6,153,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [3] = {2,6,152,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [4] = {3,6,151,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [5] = {4,6,150,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [6] = {5,6,149,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
    }
}

-- index
local __index_id = {
    [1] = 2,
    [2] = 3,
    [3] = 4,
    [4] = 5,
    [5] = 6,
    [99] = 1,

}

-- index mainkey map
local __main_key_map = {
    [2] = 1,
    [3] = 2,
    [4] = 3,
    [5] = 4,
    [6] = 5,
    [1] = 99,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in pvppro_reward")
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
function pvppro_reward.length()
    return #pvppro_reward._data
end

-- 
function pvppro_reward.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function pvppro_reward.isVersionValid(v)
    if pvppro_reward.version then
        if v then
            return pvppro_reward.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function pvppro_reward.indexOf(index)
    if index == nil or not pvppro_reward._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/pvppro_reward.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/pvppro_reward.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/pvppro_reward.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "pvppro_reward" )
                _isDataExist = pvppro_reward.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "pvppro_reward" )
                _isBaseExist = pvppro_reward.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "pvppro_reward" )
                _isExist = pvppro_reward.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "pvppro_reward" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "pvppro_reward" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = pvppro_reward._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "pvppro_reward" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function pvppro_reward.get(id)
    
    return pvppro_reward.indexOf(__index_id[id])
        
end

--
function pvppro_reward.set(id, key, value)
    local record = pvppro_reward.get(id)
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
function pvppro_reward.index()
    return __index_id
end

return pvppro_reward