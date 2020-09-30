--boss_legion

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  legion_rank_min = 2,    --军团排名min-int 
  legion_rank_max = 3,    --军团排名max-int 
  reward_type1 = 4,    --奖励类型1-int 
  reward_value1 = 5,    --奖励类型值1-int 
  reward_size1 = 6,    --奖励数量1-int 
  reward_type2 = 7,    --奖励类型2-int 
  reward_value2 = 8,    --奖励类型值2-int 
  reward_size2 = 9,    --奖励数量2-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  legion_rank_min = "int",    --军团排名min-2 
  legion_rank_max = "int",    --军团排名max-3 
  reward_type1 = "int",    --奖励类型1-4 
  reward_value1 = "int",    --奖励类型值1-5 
  reward_size1 = "int",    --奖励数量1-6 
  reward_type2 = "int",    --奖励类型2-7 
  reward_value2 = "int",    --奖励类型值2-8 
  reward_size2 = "int",    --奖励数量2-9 

}


-- data
local boss_legion = {
    version =  1,
    _data = {
        [1] = {1,1,1,0,0,0,0,0,0,},
        [2] = {2,2,2,0,0,0,0,0,0,},
        [3] = {3,3,3,0,0,0,0,0,0,},
        [4] = {4,4,5,0,0,0,0,0,0,},
        [5] = {5,6,10,0,0,0,0,0,0,},
        [6] = {6,11,20,0,0,0,0,0,0,},
        [7] = {7,21,50,0,0,0,0,0,0,},
        [8] = {8,51,9999,0,0,0,0,0,0,},
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
    [8] = 8,

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
    [8] = 8,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in boss_legion")
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
function boss_legion.length()
    return #boss_legion._data
end

-- 
function boss_legion.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function boss_legion.isVersionValid(v)
    if boss_legion.version then
        if v then
            return boss_legion.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function boss_legion.indexOf(index)
    if index == nil or not boss_legion._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/boss_legion.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/boss_legion.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/boss_legion.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "boss_legion" )
                _isDataExist = boss_legion.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "boss_legion" )
                _isBaseExist = boss_legion.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "boss_legion" )
                _isExist = boss_legion.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "boss_legion" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "boss_legion" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = boss_legion._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "boss_legion" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function boss_legion.get(id)
    
    return boss_legion.indexOf(__index_id[id])
        
end

--
function boss_legion.set(id, key, value)
    local record = boss_legion.get(id)
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
function boss_legion.index()
    return __index_id
end

return boss_legion