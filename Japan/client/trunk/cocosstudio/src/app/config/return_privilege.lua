--return_privilege

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
  privilege_type = 6,    --特权类型-int 
  privilege_value = 7,    --特权次数-int 
  recover = 8,    --刷新方式-int 
  privilege_txt = 9,    --特权说明-string 
  function_id = 10,    --功能跳转-int 
  button_txt = 11,    --按钮文字-string 
  is_work = 12,    --是否生效-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  vip_min = "int",    --VIP等级下限-2 
  vip_max = "int",    --VIP等级上限-3 
  day_min = "int",    --流失天数下限-4 
  day_max = "int",    --流失天数上限-5 
  privilege_type = "int",    --特权类型-6 
  privilege_value = "int",    --特权次数-7 
  recover = "int",    --刷新方式-8 
  privilege_txt = "string",    --特权说明-9 
  function_id = "int",    --功能跳转-10 
  button_txt = "string",    --按钮文字-11 
  is_work = "int",    --是否生效-12 

}


-- data
local return_privilege = {
    version =  1,
    _data = {
        [1] = {1,0,16,3,13,1,7,0,"重置日常副本",54,"重置|去战斗",1,},
        [2] = {2,0,16,3,13,2,7,0,"重置过关斩将",76,"重置|去战斗",1,},
        [3] = {3,0,16,3,13,3,80,0,"攻打主线副本获得双倍奖励",51,"去战斗",1,},
        [4] = {4,0,16,3,13,4,45,0,"攻打精英副本获得双倍奖励",53,"去战斗",1,},
        [5] = {5,0,16,3,13,5,15,0,"攻打名将副本获得双倍奖励",56,"去战斗",1,},
        [6] = {6,0,16,3,13,6,120,0,"游历行动产出双倍宝物经验和银两",73,"去游历",1,},
        [7] = {7,0,16,3,13,7,0,0,"军团祭祀和今日军团声望双倍",5,"去军团",0,},
        [8] = {8,0,16,3,13,8,0,0,"每日签到获得的奖励双倍",608,"去领取",0,},
        [9] = {9,0,16,3,13,9,0,0,"五谷丰登获得的奖励双倍",95,"去领取",0,},
        [10] = {10,0,16,3,13,10,0,0,"每日任务奖励双倍",8,"去领取",0,},
        [11] = {11,0,16,14,28,1,15,0,"重置日常副本",54,"重置|去战斗",1,},
        [12] = {12,0,16,14,28,2,15,0,"重置过关斩将",76,"重置|去战斗",1,},
        [13] = {13,0,16,14,28,3,160,0,"攻打主线副本获得双倍奖励",51,"去战斗",1,},
        [14] = {14,0,16,14,28,4,90,0,"攻打精英副本获得双倍奖励",53,"去战斗",1,},
        [15] = {15,0,16,14,28,5,35,0,"攻打名将副本获得双倍奖励",56,"去战斗",1,},
        [16] = {16,0,16,14,28,6,240,0,"游历行动产出双倍宝物经验和银两",73,"去游历",1,},
        [17] = {17,0,16,14,28,7,0,0,"军团祭祀和今日军团声望双倍",5,"去军团",0,},
        [18] = {18,0,16,14,28,8,0,0,"每日签到获得的奖励双倍",608,"去领取",0,},
        [19] = {19,0,16,14,28,9,0,0,"五谷丰登获得的奖励双倍",95,"去领取",0,},
        [20] = {20,0,16,14,28,10,0,0,"每日任务奖励双倍",8,"去领取",0,},
        [21] = {21,0,16,29,42,1,30,0,"重置日常副本",54,"重置|去战斗",1,},
        [22] = {22,0,16,29,42,2,30,0,"重置过关斩将",76,"重置|去战斗",1,},
        [23] = {23,0,16,29,42,3,320,0,"攻打主线副本获得双倍奖励",51,"去战斗",1,},
        [24] = {24,0,16,29,42,4,180,0,"攻打精英副本获得双倍奖励",53,"去战斗",1,},
        [25] = {25,0,16,29,42,5,35,0,"攻打名将副本获得双倍奖励",56,"去战斗",1,},
        [26] = {26,0,16,29,42,6,480,0,"游历行动产出双倍宝物经验和银两",73,"去游历",1,},
        [27] = {27,0,16,29,42,7,0,0,"军团祭祀和今日军团声望双倍",5,"去军团",0,},
        [28] = {28,0,16,29,42,8,0,0,"每日签到获得的奖励双倍",608,"去领取",0,},
        [29] = {29,0,16,29,42,9,0,0,"五谷丰登获得的奖励双倍",95,"去领取",0,},
        [30] = {30,0,16,29,42,10,0,0,"每日任务奖励双倍",8,"去领取",0,},
        [31] = {31,0,16,43,9999,1,45,0,"重置日常副本",54,"重置|去战斗",1,},
        [32] = {32,0,16,43,9999,2,45,0,"重置过关斩将",76,"重置|去战斗",1,},
        [33] = {33,0,16,43,9999,3,480,0,"攻打主线副本获得双倍奖励",51,"去战斗",1,},
        [34] = {34,0,16,43,9999,4,270,0,"攻打精英副本获得双倍奖励",53,"去战斗",1,},
        [35] = {35,0,16,43,9999,5,35,0,"攻打名将副本获得双倍奖励",56,"去战斗",1,},
        [36] = {36,0,16,43,9999,6,720,0,"游历行动产出双倍宝物经验和银两",73,"去游历",1,},
        [37] = {37,0,16,43,9999,7,0,0,"军团祭祀和今日军团声望双倍",5,"去军团",0,},
        [38] = {38,0,16,43,9999,8,0,0,"每日签到获得的奖励双倍",608,"去领取",0,},
        [39] = {39,0,16,43,9999,9,0,0,"五谷丰登获得的奖励双倍",95,"去领取",0,},
        [40] = {40,0,16,43,9999,10,0,0,"每日任务奖励双倍",8,"去领取",0,},
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
    [25] = 25,
    [26] = 26,
    [27] = 27,
    [28] = 28,
    [29] = 29,
    [3] = 3,
    [30] = 30,
    [31] = 31,
    [32] = 32,
    [33] = 33,
    [34] = 34,
    [35] = 35,
    [36] = 36,
    [37] = 37,
    [38] = 38,
    [39] = 39,
    [4] = 4,
    [40] = 40,
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
    [25] = 25,
    [26] = 26,
    [27] = 27,
    [28] = 28,
    [29] = 29,
    [3] = 3,
    [30] = 30,
    [31] = 31,
    [32] = 32,
    [33] = 33,
    [34] = 34,
    [35] = 35,
    [36] = 36,
    [37] = 37,
    [38] = 38,
    [39] = 39,
    [4] = 4,
    [40] = 40,
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
        assert(key_map[k], "cannot find " .. k .. " in return_privilege")
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
function return_privilege.length()
    return #return_privilege._data
end

-- 
function return_privilege.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function return_privilege.isVersionValid(v)
    if return_privilege.version then
        if v then
            return return_privilege.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function return_privilege.indexOf(index)
    if index == nil or not return_privilege._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/return_privilege.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/return_privilege.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/return_privilege.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "return_privilege" )
                _isDataExist = return_privilege.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "return_privilege" )
                _isBaseExist = return_privilege.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "return_privilege" )
                _isExist = return_privilege.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "return_privilege" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "return_privilege" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = return_privilege._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "return_privilege" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function return_privilege.get(id)
    
    return return_privilege.indexOf(__index_id[id])
        
end

--
function return_privilege.set(id, key, value)
    local record = return_privilege.get(id)
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
function return_privilege.index()
    return __index_id
end

return return_privilege