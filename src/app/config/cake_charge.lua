--cake_charge

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  type = 2,    --活动类型-int 
  cost_type = 3,    --消耗type-int 
  cost_value = 4,    --消耗value-int 
  cost_size = 5,    --消耗size-int 
  type1 = 6,    --奖励type-int 
  value1 = 7,    --奖励value-int 
  size1 = 8,    --奖励size-int 
  type2 = 9,    --奖励type-int 
  value2 = 10,    --奖励value-int 
  size2 = 11,    --奖励size-int 
  award1 = 12,    --奖励1图片名称-string 
  award2 = 13,    --奖励1图片名称-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  type = "int",    --活动类型-2 
  cost_type = "int",    --消耗type-3 
  cost_value = "int",    --消耗value-4 
  cost_size = "int",    --消耗size-5 
  type1 = "int",    --奖励type-6 
  value1 = "int",    --奖励value-7 
  size1 = "int",    --奖励size-8 
  type2 = "int",    --奖励type-9 
  value2 = "int",    --奖励value-10 
  size2 = "int",    --奖励size-11 
  award1 = "string",    --奖励1图片名称-12 
  award2 = "string",    --奖励1图片名称-13 

}


-- data
local cake_charge = {
    version =  1,
    _data = {
        [1] = {1,1,5,33,50,6,571,6,0,0,0,"img_prop_cream","img_prop_yuanbao",},
        [2] = {2,1,5,33,250,6,571,30,0,0,0,"img_prop_cream","img_prop_yuanbao",},
        [3] = {3,1,5,33,1000,6,571,120,0,0,0,"img_prop_cream","img_prop_yuanbao",},
        [4] = {4,1,5,33,2000,6,571,240,0,0,0,"img_prop_cream","img_prop_yuanbao",},
        [5] = {5,1,5,33,3000,6,571,360,0,0,0,"img_prop_cream","img_prop_yuanbao",},
        [6] = {6,1,5,33,5000,6,571,600,0,0,0,"img_prop_cream","img_prop_yuanbao",},
        [7] = {7,2,5,33,50,6,574,6,0,0,0,"img_prop_beef","img_prop_yuanbao",},
        [8] = {8,2,5,33,250,6,574,30,0,0,0,"img_prop_beef","img_prop_yuanbao",},
        [9] = {9,2,5,33,1000,6,574,120,0,0,0,"img_prop_beef","img_prop_yuanbao",},
        [10] = {10,2,5,33,2000,6,574,240,0,0,0,"img_prop_beef","img_prop_yuanbao",},
        [11] = {11,2,5,33,3000,6,574,360,0,0,0,"img_prop_beef","img_prop_yuanbao",},
        [12] = {12,2,5,33,5000,6,574,600,0,0,0,"img_prop_beef","img_prop_yuanbao",},
        [13] = {13,3,5,33,50,6,577,6,0,0,0,"img_prop_meat","img_prop_yuanbao",},
        [14] = {14,3,5,33,250,6,577,30,0,0,0,"img_prop_meat","img_prop_yuanbao",},
        [15] = {15,3,5,33,1000,6,577,120,0,0,0,"img_prop_meat","img_prop_yuanbao",},
        [16] = {16,3,5,33,2000,6,577,240,0,0,0,"img_prop_meat","img_prop_yuanbao",},
        [17] = {17,3,5,33,3000,6,577,360,0,0,0,"img_prop_meat","img_prop_yuanbao",},
        [18] = {18,3,5,33,5000,6,577,600,0,0,0,"img_prop_meat","img_prop_yuanbao",},
        [19] = {19,4,5,33,50,6,580,6,0,0,0,"img_prop_chicken","img_prop_yuanbao",},
        [20] = {20,4,5,33,250,6,580,30,0,0,0,"img_prop_chicken","img_prop_yuanbao",},
        [21] = {21,4,5,33,1000,6,580,120,0,0,0,"img_prop_chicken","img_prop_yuanbao",},
        [22] = {22,4,5,33,2000,6,580,240,0,0,0,"img_prop_chicken","img_prop_yuanbao",},
        [23] = {23,4,5,33,3000,6,580,360,0,0,0,"img_prop_chicken","img_prop_yuanbao",},
        [24] = {24,4,5,33,5000,6,580,600,0,0,0,"img_prop_chicken","img_prop_yuanbao",},
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
        assert(key_map[k], "cannot find " .. k .. " in cake_charge")
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
function cake_charge.length()
    return #cake_charge._data
end

-- 
function cake_charge.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cake_charge.isVersionValid(v)
    if cake_charge.version then
        if v then
            return cake_charge.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function cake_charge.indexOf(index)
    if index == nil or not cake_charge._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/cake_charge.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/cake_charge.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/cake_charge.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "cake_charge" )
                _isDataExist = cake_charge.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "cake_charge" )
                _isBaseExist = cake_charge.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "cake_charge" )
                _isExist = cake_charge.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "cake_charge" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cake_charge" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = cake_charge._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "cake_charge" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function cake_charge.get(id)
    
    return cake_charge.indexOf(__index_id[id])
        
end

--
function cake_charge.set(id, key, value)
    local record = cake_charge.get(id)
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
function cake_charge.index()
    return __index_id
end

return cake_charge