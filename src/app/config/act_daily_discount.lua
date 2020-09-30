--act_daily_discount

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  pay_type = 2,    --充值档次-int 
  vip_limit = 3,    --VIP限制-int 
  type_1 = 4,    --奖励类型1-int 
  value_1 = 5,    --类型值1-int 
  size_1 = 6,    --数量1-int 
  type_2 = 7,    --奖励类型2-int 
  value_2 = 8,    --类型值2-int 
  size_2 = 9,    --数量2-int 
  type_3 = 10,    --奖励类型3-int 
  value_3 = 11,    --类型值3-int 
  size_3 = 12,    --数量3-int 
  type_4 = 13,    --奖励类型4-int 
  value_4 = 14,    --类型值4-int 
  size_4 = 15,    --数量4-int 
  show_type_1 = 16,    --显示类型1-int 
  show_value_1 = 17,    --显示类型值1-int 
  show_size_1 = 18,    --显示数量1-int 
  show_type_2 = 19,    --显示类型2-int 
  show_value_2 = 20,    --显示类型值2-int 
  show_size_2 = 21,    --显示数量2-int 
  show_type_3 = 22,    --显示类型3-int 
  show_value_3 = 23,    --显示类型值3-int 
  show_size_3 = 24,    --显示数量3-int 
  show_type_4 = 25,    --显示类型4-int 
  show_value_4 = 26,    --显示类型值4-int 
  show_size_4 = 27,    --显示数量4-int 
  show_type_5 = 28,    --显示类型5-int 
  show_value_5 = 29,    --显示类型值5-int 
  show_size_5 = 30,    --显示数量5-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  pay_type = "int",    --充值档次-2 
  vip_limit = "int",    --VIP限制-3 
  type_1 = "int",    --奖励类型1-4 
  value_1 = "int",    --类型值1-5 
  size_1 = "int",    --数量1-6 
  type_2 = "int",    --奖励类型2-7 
  value_2 = "int",    --类型值2-8 
  size_2 = "int",    --数量2-9 
  type_3 = "int",    --奖励类型3-10 
  value_3 = "int",    --类型值3-11 
  size_3 = "int",    --数量3-12 
  type_4 = "int",    --奖励类型4-13 
  value_4 = "int",    --类型值4-14 
  size_4 = "int",    --数量4-15 
  show_type_1 = "int",    --显示类型1-16 
  show_value_1 = "int",    --显示类型值1-17 
  show_size_1 = "int",    --显示数量1-18 
  show_type_2 = "int",    --显示类型2-19 
  show_value_2 = "int",    --显示类型值2-20 
  show_size_2 = "int",    --显示数量2-21 
  show_type_3 = "int",    --显示类型3-22 
  show_value_3 = "int",    --显示类型值3-23 
  show_size_3 = "int",    --显示数量3-24 
  show_type_4 = "int",    --显示类型4-25 
  show_value_4 = "int",    --显示类型值4-26 
  show_size_4 = "int",    --显示数量4-27 
  show_type_5 = "int",    --显示类型5-28 
  show_value_5 = "int",    --显示类型值5-29 
  show_size_5 = "int",    --显示数量5-30 

}


-- data
local act_daily_discount = {
    version =  1,
    _data = {
        [1] = {1,1,0,6,63,10,6,3,200,5,2,200000,0,0,0,5,1,60,6,23,1,0,0,0,0,0,0,0,0,0,},
        [2] = {2,2,0,6,73,10,6,1,2,5,2,200000,0,0,0,5,1,60,6,23,1,0,0,0,0,0,0,0,0,0,},
        [3] = {3,3,0,6,73,10,6,2,2,5,2,200000,0,0,0,5,1,60,6,23,1,0,0,0,0,0,0,0,0,0,},
        [4] = {4,1,0,6,63,10,6,3,200,5,2,200000,0,0,0,5,1,60,6,24,1,0,0,0,0,0,0,0,0,0,},
        [5] = {5,2,0,6,73,10,6,1,2,5,2,200000,0,0,0,5,1,60,6,24,1,0,0,0,0,0,0,0,0,0,},
        [6] = {6,3,0,6,73,10,6,2,2,5,2,200000,0,0,0,5,1,60,6,24,1,0,0,0,0,0,0,0,0,0,},
        [7] = {7,1,0,6,63,10,6,3,200,5,2,200000,0,0,0,5,1,60,6,24,1,0,0,0,0,0,0,0,0,0,},
        [8] = {8,2,0,6,73,10,6,1,2,5,2,200000,0,0,0,5,1,60,6,24,1,0,0,0,0,0,0,0,0,0,},
        [9] = {9,3,0,6,19,200,6,2,2,5,2,200000,0,0,0,5,1,60,6,24,1,0,0,0,0,0,0,0,0,0,},
        [10] = {10,1,0,6,63,10,6,3,200,5,2,200000,0,0,0,5,1,60,6,25,1,0,0,0,0,0,0,0,0,0,},
        [11] = {11,2,0,6,73,10,6,1,2,5,2,200000,0,0,0,5,1,60,6,25,1,0,0,0,0,0,0,0,0,0,},
        [12] = {12,3,0,6,19,200,6,2,2,5,2,200000,0,0,0,5,1,60,6,25,1,0,0,0,0,0,0,0,0,0,},
        [13] = {19,1,0,6,85,4,6,3,200,5,2,200000,0,0,0,5,1,60,6,25,1,6,92,1,6,93,1,0,0,0,},
        [14] = {20,2,0,6,95,2,6,1,2,5,2,200000,0,0,0,5,1,60,6,25,1,6,92,1,6,93,1,0,0,0,},
        [15] = {21,3,0,6,94,2,6,2,2,5,2,200000,0,0,0,5,1,60,6,25,1,6,92,1,6,93,1,0,0,0,},
        [16] = {13,1,0,6,85,4,6,3,200,5,2,200000,0,0,0,5,1,60,6,26,1,6,92,1,6,93,1,0,0,0,},
        [17] = {14,2,0,6,95,2,6,1,2,5,2,200000,0,0,0,5,1,60,6,26,1,6,92,1,6,93,1,0,0,0,},
        [18] = {15,3,0,6,94,2,6,2,2,5,2,200000,0,0,0,5,1,60,6,26,1,6,92,1,6,93,1,0,0,0,},
        [19] = {16,1,0,6,85,4,6,3,200,5,2,200000,0,0,0,5,1,60,6,27,1,6,92,1,6,93,1,0,0,0,},
        [20] = {17,2,0,6,95,2,6,1,2,5,2,200000,0,0,0,5,1,60,6,27,1,6,92,1,6,93,1,0,0,0,},
        [21] = {18,3,0,6,94,2,6,2,2,5,2,200000,0,0,0,5,1,60,6,27,1,6,92,1,6,93,1,0,0,0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 16,
    [14] = 17,
    [15] = 18,
    [16] = 19,
    [17] = 20,
    [18] = 21,
    [19] = 13,
    [2] = 2,
    [20] = 14,
    [21] = 15,
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
    [16] = 13,
    [17] = 14,
    [18] = 15,
    [19] = 16,
    [20] = 17,
    [21] = 18,
    [13] = 19,
    [2] = 2,
    [14] = 20,
    [15] = 21,
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
        assert(key_map[k], "cannot find " .. k .. " in act_daily_discount")
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
function act_daily_discount.length()
    return #act_daily_discount._data
end

-- 
function act_daily_discount.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function act_daily_discount.isVersionValid(v)
    if act_daily_discount.version then
        if v then
            return act_daily_discount.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function act_daily_discount.indexOf(index)
    if index == nil or not act_daily_discount._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/act_daily_discount.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/act_daily_discount.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/act_daily_discount.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "act_daily_discount" )
                _isDataExist = act_daily_discount.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "act_daily_discount" )
                _isBaseExist = act_daily_discount.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "act_daily_discount" )
                _isExist = act_daily_discount.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "act_daily_discount" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "act_daily_discount" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = act_daily_discount._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "act_daily_discount" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function act_daily_discount.get(id)
    
    return act_daily_discount.indexOf(__index_id[id])
        
end

--
function act_daily_discount.set(id, key, value)
    local record = act_daily_discount.get(id)
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
function act_daily_discount.index()
    return __index_id
end

return act_daily_discount