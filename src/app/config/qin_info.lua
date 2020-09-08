--qin_info

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  open_time = 2,    --每天开启时间-int 
  close_time = 3,    --每天结束时间-int 
  stay_time = 4,    --每天自动增加活动时间（秒）-int 
  stay_time_max = 5,    --上限累计活动时间（秒）-int 
  help_time = 6,    --每天自动增加协助时间（秒）-int 
  help_time_max = 7,    --上限累计协助时间（秒）-int 
  one_small_time = 8,    --一个人刷小怪时间-int 
  one_big_time = 9,    --一个人刷精英怪时间-int 
  refresh_time = 10,    --怪物刷新时间-int 
  pk_time = 11,    --pk消耗时间-int 
  revive_time = 12,    --死亡复活时间-int 
  tombstone_time = 13,    --墓碑停留时间-int 
  speed = 14,    --每秒移动像素长度-int 
  error_time = 15,    --前后端误差时间-int 
  min_time = 16,    --大于等于时间才能获得奖励（百分比）-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  open_time = "int",    --每天开启时间-2 
  close_time = "int",    --每天结束时间-3 
  stay_time = "int",    --每天自动增加活动时间（秒）-4 
  stay_time_max = "int",    --上限累计活动时间（秒）-5 
  help_time = "int",    --每天自动增加协助时间（秒）-6 
  help_time_max = "int",    --上限累计协助时间（秒）-7 
  one_small_time = "int",    --一个人刷小怪时间-8 
  one_big_time = "int",    --一个人刷精英怪时间-9 
  refresh_time = "int",    --怪物刷新时间-10 
  pk_time = "int",    --pk消耗时间-11 
  revive_time = "int",    --死亡复活时间-12 
  tombstone_time = "int",    --墓碑停留时间-13 
  speed = "int",    --每秒移动像素长度-14 
  error_time = "int",    --前后端误差时间-15 
  min_time = "int",    --大于等于时间才能获得奖励（百分比）-16 

}


-- data
local qin_info = {
    version =  1,
    _data = {
        [1] = {1,36000,79200,600,4200,600,4200,150,450,5,0,20,180,170,3000,60,},
    }
}

-- index
local __index_id = {
    [1] = 1,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in qin_info")
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
function qin_info.length()
    return #qin_info._data
end

-- 
function qin_info.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function qin_info.isVersionValid(v)
    if qin_info.version then
        if v then
            return qin_info.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function qin_info.indexOf(index)
    if index == nil or not qin_info._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/qin_info.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/qin_info.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/qin_info.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "qin_info" )
                _isDataExist = qin_info.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "qin_info" )
                _isBaseExist = qin_info.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "qin_info" )
                _isExist = qin_info.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "qin_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "qin_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = qin_info._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "qin_info" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function qin_info.get(id)
    
    return qin_info.indexOf(__index_id[id])
        
end

--
function qin_info.set(id, key, value)
    local record = qin_info.get(id)
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
function qin_info.index()
    return __index_id
end

return qin_info