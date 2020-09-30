--cake_task

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  cake_type = 1,    --活动类型-int 
  id = 2,    --id-int 
  type = 3,    --类型-int 
  times = 4,    --次数-int 
  desc = 5,    --描述-string 
  award_type = 6,    --奖励type-int 
  award_value = 7,    --奖励value-int 
  award_size = 8,    --奖励size-int 
  function_id = 9,    --跳转系统-string 

}

-- key type
local __key_type = {
  cake_type = "int",    --活动类型-1 
  id = "int",    --id-2 
  type = "int",    --类型-3 
  times = "int",    --次数-4 
  desc = "string",    --描述-5 
  award_type = "int",    --奖励type-6 
  award_value = "int",    --奖励value-7 
  award_size = "int",    --奖励size-8 
  function_id = "string",    --跳转系统-9 

}


-- data
local cake_task = {
    version =  1,
    _data = {
        [1] = {1,100,1,25,"成功挑战主线或精英副本25次",6,570,20,"51",},
        [2] = {1,101,1,50,"成功挑战主线或精英副本50次",6,570,20,"51",},
        [3] = {1,102,1,75,"成功挑战主线或精英副本75次",6,570,20,"51",},
        [4] = {1,103,1,100,"成功挑战主线或精英副本100次",6,570,20,"51",},
        [5] = {1,200,2,25,"游历25次",6,570,20,"73",},
        [6] = {1,201,2,50,"游历50次",6,570,20,"73",},
        [7] = {1,202,2,75,"游历75次",6,570,20,"73",},
        [8] = {1,203,2,100,"游历100次",6,570,20,"73",},
        [9] = {1,300,3,30,"每日任务活跃度达到30",6,570,20,"8",},
        [10] = {1,301,3,60,"每日任务活跃度达到60",6,570,20,"8",},
        [11] = {1,302,3,90,"每日任务活跃度达到90",6,570,20,"8",},
        [12] = {1,303,3,120,"每日任务活跃度达到120",6,570,20,"8",},
        [13] = {1,304,3,150,"每日任务活跃度达到150",6,570,20,"8",},
        [14] = {1,400,4,1,"参加12点军团BOSS活动1次",6,570,20,"803",},
        [15] = {1,500,5,1,"参加19点军团BOSS活动1次",6,570,20,"803",},
        [16] = {1,600,6,1,"参加答题活动1次",6,570,20,"87|1501",},
        [17] = {1,700,7,1,"参加军团试炼1次",6,570,20,"64",},
        [18] = {2,100,1,25,"成功挑战主线或精英副本25次",6,573,20,"51",},
        [19] = {2,101,1,50,"成功挑战主线或精英副本50次",6,573,20,"51",},
        [20] = {2,102,1,75,"成功挑战主线或精英副本75次",6,573,20,"51",},
        [21] = {2,103,1,100,"成功挑战主线或精英副本100次",6,573,20,"51",},
        [22] = {2,200,2,25,"游历25次",6,573,20,"73",},
        [23] = {2,201,2,50,"游历50次",6,573,20,"73",},
        [24] = {2,202,2,75,"游历75次",6,573,20,"73",},
        [25] = {2,203,2,100,"游历100次",6,573,20,"73",},
        [26] = {2,300,3,30,"每日任务活跃度达到30",6,573,20,"8",},
        [27] = {2,301,3,60,"每日任务活跃度达到60",6,573,20,"8",},
        [28] = {2,302,3,90,"每日任务活跃度达到90",6,573,20,"8",},
        [29] = {2,303,3,120,"每日任务活跃度达到120",6,573,20,"8",},
        [30] = {2,304,3,150,"每日任务活跃度达到150",6,573,20,"8",},
        [31] = {2,400,4,1,"参加12点军团BOSS活动1次",6,573,20,"803",},
        [32] = {2,500,5,1,"参加19点军团BOSS活动1次",6,573,20,"803",},
        [33] = {2,600,6,1,"参加答题活动1次",6,573,20,"87|1501",},
        [34] = {2,700,7,1,"参加军团试炼1次",6,573,20,"64",},
        [35] = {3,100,1,25,"成功挑战主线或精英副本25次",6,576,20,"51",},
        [36] = {3,101,1,50,"成功挑战主线或精英副本50次",6,576,20,"51",},
        [37] = {3,102,1,75,"成功挑战主线或精英副本75次",6,576,20,"51",},
        [38] = {3,103,1,100,"成功挑战主线或精英副本100次",6,576,20,"51",},
        [39] = {3,200,2,25,"游历25次",6,576,20,"73",},
        [40] = {3,201,2,50,"游历50次",6,576,20,"73",},
        [41] = {3,202,2,75,"游历75次",6,576,20,"73",},
        [42] = {3,203,2,100,"游历100次",6,576,20,"73",},
        [43] = {3,300,3,30,"每日任务活跃度达到30",6,576,20,"8",},
        [44] = {3,301,3,60,"每日任务活跃度达到60",6,576,20,"8",},
        [45] = {3,302,3,90,"每日任务活跃度达到90",6,576,20,"8",},
        [46] = {3,303,3,120,"每日任务活跃度达到120",6,576,20,"8",},
        [47] = {3,304,3,150,"每日任务活跃度达到150",6,576,20,"8",},
        [48] = {3,400,4,1,"参加12点军团BOSS活动1次",6,576,20,"803",},
        [49] = {3,500,5,1,"参加19点军团BOSS活动1次",6,576,20,"803",},
        [50] = {3,600,6,1,"参加答题活动1次",6,576,20,"87|1501",},
        [51] = {3,700,7,1,"参加军团试炼1次",6,576,20,"64",},
        [52] = {4,100,1,25,"成功挑战主线或精英副本25次",6,579,20,"51",},
        [53] = {4,101,1,50,"成功挑战主线或精英副本50次",6,579,20,"51",},
        [54] = {4,102,1,75,"成功挑战主线或精英副本75次",6,579,20,"51",},
        [55] = {4,103,1,100,"成功挑战主线或精英副本100次",6,579,20,"51",},
        [56] = {4,200,2,25,"游历25次",6,579,20,"73",},
        [57] = {4,201,2,50,"游历50次",6,579,20,"73",},
        [58] = {4,202,2,75,"游历75次",6,579,20,"73",},
        [59] = {4,203,2,100,"游历100次",6,579,20,"73",},
        [60] = {4,300,3,30,"每日任务活跃度达到30",6,579,20,"8",},
        [61] = {4,301,3,60,"每日任务活跃度达到60",6,579,20,"8",},
        [62] = {4,302,3,90,"每日任务活跃度达到90",6,579,20,"8",},
        [63] = {4,303,3,120,"每日任务活跃度达到120",6,579,20,"8",},
        [64] = {4,304,3,150,"每日任务活跃度达到150",6,579,20,"8",},
        [65] = {4,400,4,1,"参加12点军团BOSS活动1次",6,579,20,"803",},
        [66] = {4,500,5,1,"参加19点军团BOSS活动1次",6,579,20,"803",},
        [67] = {4,600,6,1,"参加答题活动1次",6,579,20,"87|1501",},
        [68] = {4,700,7,1,"参加军团试炼1次",6,579,20,"64",},
    }
}

-- index
local __index_cake_type_id = {
    ["1_100"] = 1,
    ["1_101"] = 2,
    ["1_102"] = 3,
    ["1_103"] = 4,
    ["1_200"] = 5,
    ["1_201"] = 6,
    ["1_202"] = 7,
    ["1_203"] = 8,
    ["1_300"] = 9,
    ["1_301"] = 10,
    ["1_302"] = 11,
    ["1_303"] = 12,
    ["1_304"] = 13,
    ["1_400"] = 14,
    ["1_500"] = 15,
    ["1_600"] = 16,
    ["1_700"] = 17,
    ["2_100"] = 18,
    ["2_101"] = 19,
    ["2_102"] = 20,
    ["2_103"] = 21,
    ["2_200"] = 22,
    ["2_201"] = 23,
    ["2_202"] = 24,
    ["2_203"] = 25,
    ["2_300"] = 26,
    ["2_301"] = 27,
    ["2_302"] = 28,
    ["2_303"] = 29,
    ["2_304"] = 30,
    ["2_400"] = 31,
    ["2_500"] = 32,
    ["2_600"] = 33,
    ["2_700"] = 34,
    ["3_100"] = 35,
    ["3_101"] = 36,
    ["3_102"] = 37,
    ["3_103"] = 38,
    ["3_200"] = 39,
    ["3_201"] = 40,
    ["3_202"] = 41,
    ["3_203"] = 42,
    ["3_300"] = 43,
    ["3_301"] = 44,
    ["3_302"] = 45,
    ["3_303"] = 46,
    ["3_304"] = 47,
    ["3_400"] = 48,
    ["3_500"] = 49,
    ["3_600"] = 50,
    ["3_700"] = 51,
    ["4_100"] = 52,
    ["4_101"] = 53,
    ["4_102"] = 54,
    ["4_103"] = 55,
    ["4_200"] = 56,
    ["4_201"] = 57,
    ["4_202"] = 58,
    ["4_203"] = 59,
    ["4_300"] = 60,
    ["4_301"] = 61,
    ["4_302"] = 62,
    ["4_303"] = 63,
    ["4_304"] = 64,
    ["4_400"] = 65,
    ["4_500"] = 66,
    ["4_600"] = 67,
    ["4_700"] = 68,

}

-- index mainkey map
local __main_key_map = {
    [1] = "1_100",
    [2] = "1_101",
    [3] = "1_102",
    [4] = "1_103",
    [5] = "1_200",
    [6] = "1_201",
    [7] = "1_202",
    [8] = "1_203",
    [9] = "1_300",
    [10] = "1_301",
    [11] = "1_302",
    [12] = "1_303",
    [13] = "1_304",
    [14] = "1_400",
    [15] = "1_500",
    [16] = "1_600",
    [17] = "1_700",
    [18] = "2_100",
    [19] = "2_101",
    [20] = "2_102",
    [21] = "2_103",
    [22] = "2_200",
    [23] = "2_201",
    [24] = "2_202",
    [25] = "2_203",
    [26] = "2_300",
    [27] = "2_301",
    [28] = "2_302",
    [29] = "2_303",
    [30] = "2_304",
    [31] = "2_400",
    [32] = "2_500",
    [33] = "2_600",
    [34] = "2_700",
    [35] = "3_100",
    [36] = "3_101",
    [37] = "3_102",
    [38] = "3_103",
    [39] = "3_200",
    [40] = "3_201",
    [41] = "3_202",
    [42] = "3_203",
    [43] = "3_300",
    [44] = "3_301",
    [45] = "3_302",
    [46] = "3_303",
    [47] = "3_304",
    [48] = "3_400",
    [49] = "3_500",
    [50] = "3_600",
    [51] = "3_700",
    [52] = "4_100",
    [53] = "4_101",
    [54] = "4_102",
    [55] = "4_103",
    [56] = "4_200",
    [57] = "4_201",
    [58] = "4_202",
    [59] = "4_203",
    [60] = "4_300",
    [61] = "4_301",
    [62] = "4_302",
    [63] = "4_303",
    [64] = "4_304",
    [65] = "4_400",
    [66] = "4_500",
    [67] = "4_600",
    [68] = "4_700",

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in cake_task")
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
function cake_task.length()
    return #cake_task._data
end

-- 
function cake_task.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cake_task.isVersionValid(v)
    if cake_task.version then
        if v then
            return cake_task.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function cake_task.indexOf(index)
    if index == nil or not cake_task._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/cake_task.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/cake_task.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/cake_task.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "cake_task" )
                _isDataExist = cake_task.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "cake_task" )
                _isBaseExist = cake_task.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "cake_task" )
                _isExist = cake_task.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "cake_task" )
        local main_key = __main_key_map[index]
		local index_key = "__index_cake_type_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cake_task" )
        local main_key = __main_key_map[index]
		local index_key = "__index_cake_type_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = cake_task._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "cake_task" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function cake_task.get(cake_type,id)
    
    local k = cake_type .. '_' .. id
    return cake_task.indexOf(__index_cake_type_id[k])
        
end

--
function cake_task.set(cake_type,id, key, value)
    local record = cake_task.get(cake_type,id)
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
function cake_task.index()
    return __index_cake_type_id
end

return cake_task