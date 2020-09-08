--cross_boss_reward_view

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  day_min = 2,    --开服天数min-int 
  day_max = 3,    --开服天数max-int 
  reward_type_1 = 4,    --奖励1-int 
  reward_type_2 = 5,    --奖励2-int 
  reward_type_3 = 6,    --奖励3-int 
  reward_type_4 = 7,    --奖励4-int 
  type_1 = 8,    --类型1-int 
  value_1 = 9,    --类型值1-int 
  size_1 = 10,    --数量1-int 
  type_2 = 11,    --类型2-int 
  value_2 = 12,    --类型值2-int 
  size_2 = 13,    --数量2-int 
  type_3 = 14,    --类型3-int 
  value_3 = 15,    --类型值3-int 
  size_3 = 16,    --数量3-int 
  type_4 = 17,    --类型4-int 
  value_4 = 18,    --类型值4-int 
  size_4 = 19,    --数量4-int 
  type_5 = 20,    --类型5-int 
  value_5 = 21,    --类型值5-int 
  size_5 = 22,    --数量5-int 
  type_6 = 23,    --类型6-int 
  value_6 = 24,    --类型值6-int 
  size_6 = 25,    --数量6-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  day_min = "int",    --开服天数min-2 
  day_max = "int",    --开服天数max-3 
  reward_type_1 = "int",    --奖励1-4 
  reward_type_2 = "int",    --奖励2-5 
  reward_type_3 = "int",    --奖励3-6 
  reward_type_4 = "int",    --奖励4-7 
  type_1 = "int",    --类型1-8 
  value_1 = "int",    --类型值1-9 
  size_1 = "int",    --数量1-10 
  type_2 = "int",    --类型2-11 
  value_2 = "int",    --类型值2-12 
  size_2 = "int",    --数量2-13 
  type_3 = "int",    --类型3-14 
  value_3 = "int",    --类型值3-15 
  size_3 = "int",    --数量3-16 
  type_4 = "int",    --类型4-17 
  value_4 = "int",    --类型值4-18 
  size_4 = "int",    --数量4-19 
  type_5 = "int",    --类型5-20 
  value_5 = "int",    --类型值5-21 
  size_5 = "int",    --数量5-22 
  type_6 = "int",    --类型6-23 
  value_6 = "int",    --类型值6-24 
  size_6 = "int",    --数量6-25 

}


-- data
local cross_boss_reward_view = {
    version =  1,
    _data = {
        [1] = {1,1,39,2,3,4,0,6,555,1,6,556,1,6,701,1,6,702,1,6,703,1,6,704,1,},
        [2] = {2,40,9999,6,7,0,0,6,555,1,6,556,1,6,701,1,6,702,1,6,703,1,6,704,1,},
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
        assert(key_map[k], "cannot find " .. k .. " in cross_boss_reward_view")
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
function cross_boss_reward_view.length()
    return #cross_boss_reward_view._data
end

-- 
function cross_boss_reward_view.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cross_boss_reward_view.isVersionValid(v)
    if cross_boss_reward_view.version then
        if v then
            return cross_boss_reward_view.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function cross_boss_reward_view.indexOf(index)
    if index == nil or not cross_boss_reward_view._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/cross_boss_reward_view.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/cross_boss_reward_view.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/cross_boss_reward_view.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "cross_boss_reward_view" )
                _isDataExist = cross_boss_reward_view.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "cross_boss_reward_view" )
                _isBaseExist = cross_boss_reward_view.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "cross_boss_reward_view" )
                _isExist = cross_boss_reward_view.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "cross_boss_reward_view" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cross_boss_reward_view" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = cross_boss_reward_view._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "cross_boss_reward_view" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function cross_boss_reward_view.get(id)
    
    return cross_boss_reward_view.indexOf(__index_id[id])
        
end

--
function cross_boss_reward_view.set(id, key, value)
    local record = cross_boss_reward_view.get(id)
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
function cross_boss_reward_view.index()
    return __index_id
end

return cross_boss_reward_view