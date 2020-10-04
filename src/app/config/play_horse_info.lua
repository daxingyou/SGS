--play_horse_info

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  open_time = 2,    --开启时间（单位min）-string 
  bet_time = 3,    --投注时间（单位s）-int 
  ready_time = 4,    --准备时间（单位s）-int 
  show_time = 5,    --结束时间-int 
  show_time_1 = 6,    --结束框显示时间-int 
  match_time_min = 7,    --总比赛最低时间（单位s）-int 
  match_time_max = 8,    --总比赛最高时间（单位s）-int 
  type = 9,    --投注类型-int 
  value = 10,    --投注类型值-int 
  size = 11,    --投注金额-int 
  support_max = 12,    --投注上限-int 
  people_max = 13,    --投注人数上限-int 
  pixel_number = 14,    --总跑道长度（像素）-string 
  part_number = 15,    --每段对应的长度（像素）-string 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  open_time = "string",    --开启时间（单位min）-2 
  bet_time = "int",    --投注时间（单位s）-3 
  ready_time = "int",    --准备时间（单位s）-4 
  show_time = "int",    --结束时间-5 
  show_time_1 = "int",    --结束框显示时间-6 
  match_time_min = "int",    --总比赛最低时间（单位s）-7 
  match_time_max = "int",    --总比赛最高时间（单位s）-8 
  type = "int",    --投注类型-9 
  value = "int",    --投注类型值-10 
  size = "int",    --投注金额-11 
  support_max = "int",    --投注上限-12 
  people_max = "int",    --投注人数上限-13 
  pixel_number = "string",    --总跑道长度（像素）-14 
  part_number = "string",    --每段对应的长度（像素）-15 

}


-- data
local play_horse_info = {
    version =  1,
    _data = {
        [1] = {1,"600|608|840|848|960|968|1320|1328",180,4,3,0,800,900,5,1,200,1000,2,"9204","920|920|920|920|920|920|920|920|920|924",},
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
        assert(key_map[k], "cannot find " .. k .. " in play_horse_info")
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
function play_horse_info.length()
    return #play_horse_info._data
end

-- 
function play_horse_info.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function play_horse_info.isVersionValid(v)
    if play_horse_info.version then
        if v then
            return play_horse_info.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function play_horse_info.indexOf(index)
    if index == nil or not play_horse_info._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/play_horse_info.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/play_horse_info.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/play_horse_info.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "play_horse_info" )
                _isDataExist = play_horse_info.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "play_horse_info" )
                _isBaseExist = play_horse_info.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "play_horse_info" )
                _isExist = play_horse_info.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "play_horse_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "play_horse_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = play_horse_info._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "play_horse_info" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function play_horse_info.get(id)
    
    return play_horse_info.indexOf(__index_id[id])
        
end

--
function play_horse_info.set(id, key, value)
    local record = play_horse_info.get(id)
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
function play_horse_info.index()
    return __index_id
end

return play_horse_info