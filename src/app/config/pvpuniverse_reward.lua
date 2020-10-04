--pvpuniverse_reward

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --奖励id-int 
  txt = 2,    --说明-string 
  type_1 = 3,    --类型1-int 
  value_1 = 4,    --类型值1-int 
  size_1 = 5,    --数量1-int 
  type_2 = 6,    --类型2-int 
  value_2 = 7,    --类型值2-int 
  size_2 = 8,    --数量2-int 
  type_3 = 9,    --类型3-int 
  value_3 = 10,    --类型值3-int 
  size_3 = 11,    --数量3-int 
  type_4 = 12,    --类型4-int 
  value_4 = 13,    --类型值4-int 
  size_4 = 14,    --数量4-int 
  type_5 = 15,    --类型5-int 
  value_5 = 16,    --类型值5-int 
  size_5 = 17,    --数量5-int 

}

-- key type
local __key_type = {
  id = "int",    --奖励id-1 
  txt = "string",    --说明-2 
  type_1 = "int",    --类型1-3 
  value_1 = "int",    --类型值1-4 
  size_1 = "int",    --数量1-5 
  type_2 = "int",    --类型2-6 
  value_2 = "int",    --类型值2-7 
  size_2 = "int",    --数量2-8 
  type_3 = "int",    --类型3-9 
  value_3 = "int",    --类型值3-10 
  size_3 = "int",    --数量3-11 
  type_4 = "int",    --类型4-12 
  value_4 = "int",    --类型值4-13 
  size_4 = "int",    --数量4-14 
  type_5 = "int",    --类型5-15 
  value_5 = "int",    --类型值5-16 
  size_5 = "int",    --数量5-17 

}


-- data
local pvpuniverse_reward = {
    version =  1,
    _data = {
        [1] = {1,"32强奖励",5,35,4800,0,0,0,0,0,0,0,0,0,0,0,0,},
        [2] = {2,"24强奖励",5,35,6000,0,0,0,0,0,0,0,0,0,0,0,0,},
        [3] = {3,"16强奖励",5,35,7200,0,0,0,0,0,0,0,0,0,0,0,0,},
        [4] = {4,"8强奖励",5,35,8400,0,0,0,0,0,0,0,0,0,0,0,0,},
        [5] = {5,"4强奖励",5,35,9600,0,0,0,0,0,0,0,0,0,0,0,0,},
        [6] = {6,"亚军奖励",5,35,10800,0,0,0,0,0,0,0,0,0,0,0,0,},
        [7] = {7,"冠军奖励",5,35,12000,0,0,0,0,0,0,0,0,0,0,0,0,},
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
        assert(key_map[k], "cannot find " .. k .. " in pvpuniverse_reward")
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
function pvpuniverse_reward.length()
    return #pvpuniverse_reward._data
end

-- 
function pvpuniverse_reward.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function pvpuniverse_reward.isVersionValid(v)
    if pvpuniverse_reward.version then
        if v then
            return pvpuniverse_reward.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function pvpuniverse_reward.indexOf(index)
    if index == nil or not pvpuniverse_reward._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/pvpuniverse_reward.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/pvpuniverse_reward.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/pvpuniverse_reward.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "pvpuniverse_reward" )
                _isDataExist = pvpuniverse_reward.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "pvpuniverse_reward" )
                _isBaseExist = pvpuniverse_reward.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "pvpuniverse_reward" )
                _isExist = pvpuniverse_reward.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "pvpuniverse_reward" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "pvpuniverse_reward" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = pvpuniverse_reward._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "pvpuniverse_reward" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function pvpuniverse_reward.get(id)
    
    return pvpuniverse_reward.indexOf(__index_id[id])
        
end

--
function pvpuniverse_reward.set(id, key, value)
    local record = pvpuniverse_reward.get(id)
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
function pvpuniverse_reward.index()
    return __index_id
end

return pvpuniverse_reward