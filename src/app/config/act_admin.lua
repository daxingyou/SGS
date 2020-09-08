--act_admin

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  name = 2,    --活动名称-string 
  order = 3,    --排序-int 
  function_id = 4,    --开启等级-int 
  is_work = 5,    --是否生效-int 
  value_1 = 6,    --参数1-int 
  value_2 = 7,    --参数2-int 
  value_3 = 8,    --参数3-int 
  show_control = 9,    --显示控制-int 
  position = 10,    --显示控制-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  name = "string",    --活动名称-2 
  order = "int",    --排序-3 
  function_id = "int",    --开启等级-4 
  is_work = "int",    --是否生效-5 
  value_1 = "int",    --参数1-6 
  value_2 = "int",    --参数2-7 
  value_3 = "int",    --参数3-8 
  show_control = "int",    --显示控制-9 
  position = "int",    --显示控制-10 

}


-- data
local act_admin = {
    version =  1,
    _data = {
        [1] = {1,"签到",1,0,1,50,0,0,0,1,},
        [2] = {2,"宴会",3,0,1,0,0,0,0,1,},
        [3] = {3,"豪华卡",5,0,1,0,0,0,0,2,},
        [4] = {40,"成长基金",6,0,1,0,0,0,1,2,},
        [5] = {41,"成长基金1",91,0,1,0,0,0,2,2,},
        [6] = {42,"成长基金2",92,0,1,0,0,0,2,2,},
        [7] = {43,"成长基金3",93,0,1,0,0,0,2,2,},
        [8] = {44,"成长基金4",94,0,1,0,0,0,2,2,},
        [9] = {45,"成长基金5",95,0,1,0,0,0,2,2,},
        [10] = {46,"成长基金6",96,0,1,0,0,0,2,2,},
        [11] = {47,"成长基金7",97,0,1,0,0,0,2,2,},
        [12] = {48,"成长基金8",98,0,1,0,0,0,2,2,},
        [13] = {49,"成长基金9",99,0,1,0,0,0,2,2,},
        [14] = {50,"成长基金10",100,0,1,0,0,0,2,2,},
        [15] = {51,"成长基金11",101,0,1,0,0,0,2,2,},
        [16] = {52,"成长基金12",102,0,1,0,0,0,2,2,},
        [17] = {53,"成长基金13",103,0,1,0,0,0,2,2,},
        [18] = {54,"成长基金14",104,0,1,0,0,0,2,2,},
        [19] = {55,"成长基金15",105,0,1,0,0,0,2,2,},
        [20] = {56,"成长基金16",106,0,1,0,0,0,2,2,},
        [21] = {57,"成长基金17",107,0,1,0,0,0,2,2,},
        [22] = {5,"每日礼包",14,605,1,1,10026,0,0,2,},
        [23] = {6,"聚宝盆",4,0,1,55,2,0,0,1,},
        [24] = {7,"每周礼包",15,604,1,0,0,0,0,1,},
        [25] = {8,"等级礼包",16,0,1,0,0,0,0,3,},
        [26] = {9,"公测预约",17,0,0,0,0,0,1,1,},
        [27] = {10,"充值返利",18,0,0,0,0,0,1,1,},
        [28] = {11,"资源找回",19,0,1,0,0,0,0,1,},
        [29] = {12,"五谷丰登",2,95,0,0,0,0,0,1,},
        [30] = {80,"后加入",20,0,0,0,0,0,0,1,},
        [31] = {39,"好友邀请",21,0,1,0,0,0,0,1,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 27,
    [11] = 28,
    [12] = 29,
    [2] = 2,
    [3] = 3,
    [39] = 31,
    [40] = 4,
    [41] = 5,
    [42] = 6,
    [43] = 7,
    [44] = 8,
    [45] = 9,
    [46] = 10,
    [47] = 11,
    [48] = 12,
    [49] = 13,
    [5] = 22,
    [50] = 14,
    [51] = 15,
    [52] = 16,
    [53] = 17,
    [54] = 18,
    [55] = 19,
    [56] = 20,
    [57] = 21,
    [6] = 23,
    [7] = 24,
    [8] = 25,
    [80] = 30,
    [9] = 26,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [27] = 10,
    [28] = 11,
    [29] = 12,
    [2] = 2,
    [3] = 3,
    [31] = 39,
    [4] = 40,
    [5] = 41,
    [6] = 42,
    [7] = 43,
    [8] = 44,
    [9] = 45,
    [10] = 46,
    [11] = 47,
    [12] = 48,
    [13] = 49,
    [22] = 5,
    [14] = 50,
    [15] = 51,
    [16] = 52,
    [17] = 53,
    [18] = 54,
    [19] = 55,
    [20] = 56,
    [21] = 57,
    [23] = 6,
    [24] = 7,
    [25] = 8,
    [30] = 80,
    [26] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in act_admin")
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
function act_admin.length()
    return #act_admin._data
end

-- 
function act_admin.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function act_admin.isVersionValid(v)
    if act_admin.version then
        if v then
            return act_admin.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function act_admin.indexOf(index)
    if index == nil or not act_admin._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/act_admin.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/act_admin.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/act_admin.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "act_admin" )
                _isDataExist = act_admin.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "act_admin" )
                _isBaseExist = act_admin.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "act_admin" )
                _isExist = act_admin.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "act_admin" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "act_admin" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = act_admin._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "act_admin" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function act_admin.get(id)
    
    return act_admin.indexOf(__index_id[id])
        
end

--
function act_admin.set(id, key, value)
    local record = act_admin.get(id)
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
function act_admin.index()
    return __index_id
end

return act_admin