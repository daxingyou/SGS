--time_limit_activity

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  name = 2,    --限时活动名称-string 
  rule = 3,    --显示规则-int 
  start_week = 4,    --开启时间-string 
  start_time = 5,    --开始时段-string 
  finish_time = 6,    --结束时段-string 
  start_des = 7,    --开启描述-string 
  function_id = 8,    --跳转功能id-int 
  icon = 9,    --功能icon-string 
  reward_type1 = 10,    --奖励类型1-int 
  reward_value1 = 11,    --奖励1-int 
  reward_type2 = 12,    --奖励类型2-int 
  reward_value2 = 13,    --奖励2-int 
  reward_type3 = 14,    --奖励类型3-int 
  reward_value3 = 15,    --奖励3-int 
  reward_type4 = 16,    --奖励类型4-int 
  reward_value4 = 17,    --奖励4-int 
  description = 18,    --活动描述-string 
  is_work = 19,    --是否显示-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  name = "string",    --限时活动名称-2 
  rule = "int",    --显示规则-3 
  start_week = "string",    --开启时间-4 
  start_time = "string",    --开始时段-5 
  finish_time = "string",    --结束时段-6 
  start_des = "string",    --开启描述-7 
  function_id = "int",    --跳转功能id-8 
  icon = "string",    --功能icon-9 
  reward_type1 = "int",    --奖励类型1-10 
  reward_value1 = "int",    --奖励1-11 
  reward_type2 = "int",    --奖励类型2-12 
  reward_value2 = "int",    --奖励2-13 
  reward_type3 = "int",    --奖励类型3-14 
  reward_value3 = "int",    --奖励3-15 
  reward_type4 = "int",    --奖励类型4-16 
  reward_value4 = "int",    --奖励4-17 
  description = "string",    --活动描述-18 
  is_work = "int",    --是否显示-19 

}


-- data
local time_limit_activity = {
    _data = {
        [1] = {1,"军团BOSS",0,"1|2|3|4|5|6|7","43200|68400","43560|68760","每日",803,"icon_activity_guildboss",0,0,0,0,0,0,0,0,"军团BOSS每天12点、19点开启；军团参与人数越多，拍卖奖励越多；参与活动均可获得军团拍卖分红。",1,},
        [2] = {2,"军团答题",0,"1|2|3|4|5|6|7","64800","65100","每日",87,"icon_activity_answer",0,0,0,0,0,0,0,0,"军团答题每天18点开启；军团参与人数越多，拍卖奖励越多；参与活动的玩家均可获得军团拍卖分红。",1,},
        [3] = {3,"军团试炼",0,"1|2|3|4|5|6|7","65400","67800","每日",64,"icon_activity_guildpve",0,0,0,0,0,0,0,0,"军团试炼每天18点10分至18点40分开启；军团试炼积分越多，拍卖奖励越多；参与活动均可获得军团拍卖分红。",1,},
        [4] = {4,"三国战记",0,"3|5|7","75600","76500","每周三、五、日",67,"icon_activity_threecountrybattle",0,0,0,0,0,0,0,0,"纵横乱世间，霸气冲云天。三国名将，战！战！战！每周三、五、日的21点准时开启，等你来战！！！",1,},
        [5] = {5,"阵营竞技",0,"1|4","75600","76500","每周一、四",163,"icon_activity_campbattle",0,0,0,0,0,0,0,0,"阵营竞技每周一、四4点开始报名，21点准时开战；报名人数越多，拍卖奖励越多；所有报名玩家都可获得阵营竞技拍卖分红。",1,},
        [6] = {6,"华容道",0,"1|2|3|4|5|6|7","36000|50400|57600|79200","37500|51900|59100|80700","每日",90,"icon_activity_runway",6,33,0,0,0,0,0,0,"华容道每天10点、14点、16点、22点各开启2场，一天共开启8场，可前去支持参赛的武将，支持武将跑第一可以获得奖励！",1,},
        [7] = {7,"军团战",0,"2|6","75600","76560","每周二、六",59,"icon_activity_guildbattle",0,0,0,0,0,0,0,0,"中原风雨来，三国豪杰聚；沙场秋点兵，豪气冲天起。\n每周二、六21点准时开启军团战。来，战个痛快！",1,},
        [8] = {8,"王者之战",16,"1|2|3|4|5|6|7","39600|68400","50400|79200","每天",1100,"icon_activity_fight",5,29,0,0,0,0,0,0,"无差别公平竞技，无视战力，只比战术！\n每天11-14点和19-22点，一起来战！",1,},
        [9] = {9,"先秦皇陵",5,"1|2|3|4|5|6|7","36000","79200","每天",855,"icon_activity_qintomb",6,92,6,93,0,0,0,0,"每天10-22点，组队闯皇陵，有机会获得春秋战国！",1,},
        [10] = {10,"阵营竞技",0,"1","75600","76500","每周一",163,"icon_activity_campbattle",0,0,0,0,0,0,0,0,"阵营竞技每周一4点开始报名，21点准时开战；报名人数越多，拍卖奖励越多；所有报名玩家都可获得阵营竞技、周四跨服个人竞技拍卖分红。",1,},
        [11] = {11,"跨服军团战",995,"6","75600","76560","每周六",183,"icon_activity_guildbattle",0,0,0,0,0,0,0,0,"周二21点开启军团战，周六21点开启跨服军团战\n占领虎牢关、函谷关、剑阁、逍遥津的军团可参加跨服军团战\n其他军团仍然参加本服军团战。",1,},
        [12] = {12,"跨服个人竞技",25,"4","75600","77850","每周四",168,"icon_activity_campbattle02",0,0,0,0,0,0,0,0,"同组8个服务器均开服30天，每周四开启跨服个人竞技；阵营竞技报名人数越多，拍卖奖励越多，报名玩家都可获得跨服个人竞技拍卖分红。",1,},
        [13] = {13,"军团答题",0,"2|4|6","64800","65100","每周二、四、六",87,"icon_activity_answer",0,0,0,0,0,0,0,0,"军团答题周二、四、六18点开启；军团参与人数越多，拍卖奖励越多；参与活动的玩家均可获得军团拍卖分红。",1,},
        [14] = {14,"全服答题",9,"1|3|5|7","64800","65100","每周一、三、五、日",1501,"icon_activity_answer",0,0,0,0,0,0,0,0,"全服答题每周一、三、五、日18点开启；军团参与人数越多，拍卖奖励越多；参与活动的玩家均可获得军团拍卖分红。",1,},
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
        assert(__key_map[k], "cannot find " .. k .. " in time_limit_activity")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function time_limit_activity.length()
    return #time_limit_activity._data
end

-- 
function time_limit_activity.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function time_limit_activity.indexOf(index)
    if index == nil or not time_limit_activity._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/time_limit_activity.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "time_limit_activity" )
        return setmetatable({_raw = time_limit_activity._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = time_limit_activity._data[index]}, mt)
end

--
function time_limit_activity.get(id)
    
    return time_limit_activity.indexOf(__index_id[id])
        
end

--
function time_limit_activity.set(id, key, value)
    local record = time_limit_activity.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function time_limit_activity.index()
    return __index_id
end

return time_limit_activity