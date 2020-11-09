--return_activity

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  vip_min = 2,    --VIP等级下限-int 
  vip_max = 3,    --VIP等级上限-int 
  day_min = 4,    --流失天数下限-int 
  day_max = 5,    --流失天数上限-int 
  week_circle = 6,    --每周循环限制-string 
  mission_type = 7,    --任务类型-int 
  mission_time = 8,    --完成次数-int 
  mission_description = 9,    --任务说明-string 
  is_work = 10,    --是否生效-int 
  reward_type1 = 11,    --奖励类型1-int 
  reward_value1 = 12,    --奖励类性值1-int 
  reward_size1 = 13,    --奖励数量1-int 
  reward_type2 = 14,    --奖励类型2-int 
  reward_value2 = 15,    --奖励类性值2-int 
  reward_size2 = 16,    --奖励数量2-int 
  reward_type3 = 17,    --奖励类型3-int 
  reward_value3 = 18,    --奖励类性值3-int 
  reward_size3 = 19,    --奖励数量3-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  vip_min = "int",    --VIP等级下限-2 
  vip_max = "int",    --VIP等级上限-3 
  day_min = "int",    --流失天数下限-4 
  day_max = "int",    --流失天数上限-5 
  week_circle = "string",    --每周循环限制-6 
  mission_type = "int",    --任务类型-7 
  mission_time = "int",    --完成次数-8 
  mission_description = "string",    --任务说明-9 
  is_work = "int",    --是否生效-10 
  reward_type1 = "int",    --奖励类型1-11 
  reward_value1 = "int",    --奖励类性值1-12 
  reward_size1 = "int",    --奖励数量1-13 
  reward_type2 = "int",    --奖励类型2-14 
  reward_value2 = "int",    --奖励类性值2-15 
  reward_size2 = "int",    --奖励数量2-16 
  reward_type3 = "int",    --奖励类型3-17 
  reward_value3 = "int",    --奖励类性值3-18 
  reward_size3 = "int",    --奖励数量3-19 

}


-- data
local return_activity = {
    version =  1,
    _data = {
        [1] = {1,0,16,1,28,"1|2|3|4|5|6|0",1,1,"参加12:00军团BOSS活动",1,6,120,3,5,20,2,0,0,0,},
        [2] = {2,0,16,1,28,"1|2|3|4|5|6|0",2,1,"参加军团答题活动",1,6,120,3,5,20,2,0,0,0,},
        [3] = {3,0,16,1,28,"1|2|3|4|5|6|0",3,1,"参加军团试炼活动",1,6,120,3,5,20,2,0,0,0,},
        [4] = {4,0,16,1,28,"1|2|3|4|5|6|0",4,1,"参加19:00军团BOSS活动",1,6,120,3,5,20,2,0,0,0,},
        [5] = {5,0,16,1,28,"1",5,1,"参加阵营竞技",1,6,120,3,5,20,2,0,0,0,},
        [6] = {6,0,16,1,28,"2|6",6,1,"参加军团战",0,6,120,3,5,20,2,0,0,0,},
        [7] = {7,0,16,1,28,"3|5|0",7,1,"参加三国战纪",1,6,120,3,5,20,2,0,0,0,},
        [8] = {8,0,16,1,28,"1|2|3|4|5|6|0",8,2,"参加华容道#num#次",1,6,120,3,5,20,2,0,0,0,},
        [9] = {9,0,16,29,42,"1|2|3|4|5|6|0",1,1,"参加12:00军团BOSS活动",1,6,120,6,5,20,4,0,0,0,},
        [10] = {10,0,16,29,42,"1|2|3|4|5|6|0",2,1,"参加军团答题活动",1,6,120,6,5,20,4,0,0,0,},
        [11] = {11,0,16,29,42,"1|2|3|4|5|6|0",3,1,"参加军团试炼活动",1,6,120,6,5,20,4,0,0,0,},
        [12] = {12,0,16,29,42,"1|2|3|4|5|6|0",4,1,"参加19:00军团BOSS活动",1,6,120,6,5,20,4,0,0,0,},
        [13] = {13,0,16,29,42,"1",5,1,"参加阵营竞技",1,6,120,6,5,20,4,0,0,0,},
        [14] = {14,0,16,29,42,"2|6",6,1,"参加军团战",0,6,120,6,5,20,4,0,0,0,},
        [15] = {15,0,16,29,42,"3|5|0",7,1,"参加三国战纪",1,6,120,6,5,20,4,0,0,0,},
        [16] = {16,0,16,29,42,"1|2|3|4|5|6|0",8,2,"参加华容道#num#次",1,6,120,6,5,20,4,0,0,0,},
        [17] = {17,0,16,43,9999,"1|2|3|4|5|6|0",1,1,"参加12:00军团BOSS活动",1,6,120,9,5,20,6,0,0,0,},
        [18] = {18,0,16,43,9999,"1|2|3|4|5|6|0",2,1,"参加军团答题活动",1,6,120,9,5,20,6,0,0,0,},
        [19] = {19,0,16,43,9999,"1|2|3|4|5|6|0",3,1,"参加军团试炼活动",1,6,120,9,5,20,6,0,0,0,},
        [20] = {20,0,16,43,9999,"1|2|3|4|5|6|0",4,1,"参加19:00军团BOSS活动",1,6,120,9,5,20,6,0,0,0,},
        [21] = {21,0,16,43,9999,"1",5,1,"参加阵营竞技",1,6,120,9,5,20,6,0,0,0,},
        [22] = {22,0,16,43,9999,"2|6",6,1,"参加军团战",0,6,120,9,5,20,6,0,0,0,},
        [23] = {23,0,16,43,9999,"3|5|0",7,1,"参加三国战纪",1,6,120,9,5,20,6,0,0,0,},
        [24] = {24,0,16,43,9999,"1|2|3|4|5|6|0",8,2,"参加华容道#num#次",1,6,120,9,5,20,6,0,0,0,},
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
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [20] = 20,
    [21] = 21,
    [22] = 22,
    [23] = 23,
    [24] = 24,
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
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [20] = 20,
    [21] = 21,
    [22] = 22,
    [23] = 23,
    [24] = 24,
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
        assert(key_map[k], "cannot find " .. k .. " in return_activity")
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
function return_activity.length()
    return #return_activity._data
end

-- 
function return_activity.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function return_activity.isVersionValid(v)
    if return_activity.version then
        if v then
            return return_activity.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function return_activity.indexOf(index)
    if index == nil or not return_activity._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/return_activity.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/return_activity.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/return_activity.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "return_activity" )
                _isDataExist = return_activity.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "return_activity" )
                _isBaseExist = return_activity.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "return_activity" )
                _isExist = return_activity.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "return_activity" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "return_activity" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = return_activity._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "return_activity" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function return_activity.get(id)
    
    return return_activity.indexOf(__index_id[id])
        
end

--
function return_activity.set(id, key, value)
    local record = return_activity.get(id)
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
function return_activity.index()
    return __index_id
end

return return_activity