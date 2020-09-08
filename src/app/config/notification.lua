--notification

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  start_time = 2,    --触发时间-string 
  week = 3,    --周几触发-string 
  day_min = 4,    --开服天数MIN-int 
  day_max = 5,    --开服天数MAX-int 
  lv_min = 6,    --玩家等级MIN-int 
  lv_max = 7,    --玩家等级MAX-int 
  time_txt = 8,    --标题-string 
  chat_before = 9,    --文本-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  start_time = "string",    --触发时间-2 
  week = "string",    --周几触发-3 
  day_min = "int",    --开服天数MIN-4 
  day_max = "int",    --开服天数MAX-5 
  lv_min = "int",    --玩家等级MIN-6 
  lv_max = "int",    --玩家等级MAX-7 
  time_txt = "string",    --标题-8 
  chat_before = "string",    --文本-9 

}


-- data
local notification = {
    version =  1,
    _data = {
        [1] = {1,"12|00|02","1|2|3|4|5|6|7",0,999,0,23,"午宴开始了","各位主公，午宴已经开始，快去参加午宴补充大量体力吧！",},
        [2] = {2,"18|00|02","1|2|3|4|5|6|7",0,999,0,23,"晚宴开始了","各位主公，晚宴已经开始，快去参加晚宴补充大量体力吧！",},
        [3] = {3,"21|00|02","1|2|3|4|5|6|7",0,999,0,255,"夜宵开始了","各位主公，夜宵已经开始，快去参加夜宵补充大量体力吧！",},
        [4] = {4,"11|55|00","1|2|3|4|5|6|7",0,999,24,255,"军团BOSS来临","军团BOSS将在5分钟后来临，主公请前往挑战，击退BOSS后可参与拍卖和分红！",},
        [5] = {5,"18|55|00","1|2|3|4|5|6|7",0,999,24,255,"军团BOSS来临","军团BOSS将在5分钟后来临，主公请前往挑战，击退BOSS后可参与拍卖和分红！",},
        [6] = {6,"08|00|00","1|2|3|4|5|6|7",0,999,255,255,"每日早上礼物","各位主公，快点登陆领取您的早上礼物吧~~~",},
        [7] = {7,"20|55|00","3|5|7",3,999,30,999,"三国战纪开战","三国战纪将在5分钟后开战，挑战BOSS并击破之，可以参与拍卖和分红！",},
        [8] = {8,"20|55|00","1|4",7,999,30,999,"阵营竞技开战","阵营竞技将在5分钟后开战，谁是阵营王者，请前往一决高下！",},
        [9] = {9,"20|55|00","2|6",8,999,30,999,"军团战一触即发","军团战将在5分钟后开战，夺城占地，做巅峰军团，就在此时！",},
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
    [9] = 9,

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
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in notification")
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
function notification.length()
    return #notification._data
end

-- 
function notification.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function notification.isVersionValid(v)
    if notification.version then
        if v then
            return notification.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function notification.indexOf(index)
    if index == nil or not notification._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/notification.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/notification.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/notification.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "notification" )
                _isDataExist = notification.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "notification" )
                _isBaseExist = notification.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "notification" )
                _isExist = notification.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "notification" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "notification" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = notification._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "notification" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function notification.get(id)
    
    return notification.indexOf(__index_id[id])
        
end

--
function notification.set(id, key, value)
    local record = notification.get(id)
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
function notification.index()
    return __index_id
end

return notification