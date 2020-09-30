--late_regist

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  day_between = 2,    --日期差-int 
  sheet = 3,    --所属页签-int 
  week = 4,    --星期-string 
  order = 5,    --排序-int 
  task_type = 6,    --条件类型-int 
  task_value = 7,    --条件值-int 
  name = 8,    --条件名-string 
  button_txt = 9,    --按钮文字-string 
  show_rate = 10,    --是否显示进度-int 
  type_1 = 11,    --奖励类型1-int 
  value_1 = 12,    --类型值1-int 
  size_1 = 13,    --数量1-int 
  type_2 = 14,    --奖励类型2-int 
  value_2 = 15,    --类型值2-int 
  size_2 = 16,    --数量2-int 
  type_3 = 17,    --奖励类型3-int 
  value_3 = 18,    --类型值3-int 
  size_3 = 19,    --数量3-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  day_between = "int",    --日期差-2 
  sheet = "int",    --所属页签-3 
  week = "string",    --星期-4 
  order = "int",    --排序-5 
  task_type = "int",    --条件类型-6 
  task_value = "int",    --条件值-7 
  name = "string",    --条件名-8 
  button_txt = "string",    --按钮文字-9 
  show_rate = "int",    --是否显示进度-10 
  type_1 = "int",    --奖励类型1-11 
  value_1 = "int",    --类型值1-12 
  size_1 = "int",    --数量1-13 
  type_2 = "int",    --奖励类型2-14 
  value_2 = "int",    --类型值2-15 
  size_2 = "int",    --数量2-16 
  type_3 = "int",    --奖励类型3-17 
  value_3 = "int",    --类型值3-18 
  size_3 = "int",    --数量3-19 

}


-- data
local late_regist = {
    version =  1,
    _data = {
        [1] = {1,1,1,"1,2,3,4,5,6,7",1,1,5,"等级达到%d级","领取",1,5,1,100,5,2,100000,0,0,0,},
        [2] = {2,1,1,"1,2,3,4,5,6,7",2,1,10,"等级达到%d级","领取",1,5,2,200000,6,1,2,6,2,1,},
        [3] = {3,1,1,"1,2,3,4,5,6,7",3,1,15,"等级达到%d级","领取",1,5,1,150,5,2,200000,6,3,200,},
        [4] = {4,1,1,"1,2,3,4,5,6,7",4,1,18,"等级达到%d级","领取",1,6,1,3,6,2,1,6,63,20,},
        [5] = {5,1,1,"1,2,3,4,5,6,7",5,1,22,"等级达到%d级","领取",1,5,1,200,6,3,300,6,63,20,},
        [6] = {6,1,1,"1,2,3,4,5,6,7",6,1,25,"等级达到%d级","领取",1,6,1,3,6,2,2,5,2,200000,},
        [7] = {7,1,1,"1,2,3,4,5,6,7",7,1,28,"等级达到%d级","领取",1,5,1,300,6,3,300,6,72,30,},
        [8] = {8,1,1,"1,2,3,4,5,6,7",8,1,30,"等级达到%d级","领取",1,5,1,200,5,2,500000,6,3,500,},
        [9] = {9,2,1,"1,2,3,4,5,6,7",1,1,32,"等级达到%d级","领取",1,5,1,300,5,2,200000,6,3,300,},
        [10] = {10,2,1,"1,2,3,4,5,6,7",2,1,34,"等级达到%d级","领取",1,6,1,3,6,2,1,6,63,30,},
        [11] = {11,2,1,"1,2,3,4,5,6,7",3,1,35,"等级达到%d级","领取",1,5,1,300,6,3,300,6,63,30,},
        [12] = {12,2,1,"1,2,3,4,5,6,7",4,1,36,"等级达到%d级","领取",1,6,1,3,6,2,2,5,2,300000,},
        [13] = {13,2,1,"1,2,3,4,5,6,7",5,1,37,"等级达到%d级","领取",1,5,1,300,6,3,300,6,72,50,},
        [14] = {14,2,1,"1,2,3,4,5,6,7",6,1,38,"等级达到%d级","领取",1,6,3,300,5,2,500000,5,1,500,},
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

-- index mainkey map
local __main_key_map = {
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
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in late_regist")
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
function late_regist.length()
    return #late_regist._data
end

-- 
function late_regist.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function late_regist.isVersionValid(v)
    if late_regist.version then
        if v then
            return late_regist.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function late_regist.indexOf(index)
    if index == nil or not late_regist._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/late_regist.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/late_regist.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/late_regist.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "late_regist" )
                _isDataExist = late_regist.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "late_regist" )
                _isBaseExist = late_regist.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "late_regist" )
                _isExist = late_regist.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "late_regist" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "late_regist" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = late_regist._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "late_regist" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function late_regist.get(id)
    
    return late_regist.indexOf(__index_id[id])
        
end

--
function late_regist.set(id, key, value)
    local record = late_regist.get(id)
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
function late_regist.index()
    return __index_id
end

return late_regist