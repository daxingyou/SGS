--little_charge_res

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  type = 2,    --类型-int 
  name = 3,    --名字-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  type = "int",    --类型-2 
  name = "string",    --名字-3 

}


-- data
local little_charge_res = {
    _data = {
        [1] = {1,1,"500",},
        [2] = {2,1,"600",},
        [3] = {3,1,"700",},
        [4] = {4,1,"800",},
        [5] = {5,1,"900",},
        [6] = {6,1,"1500",},
        [7] = {7,2,"61001",},
        [8] = {8,2,"61002",},
        [9] = {9,2,"61003",},
        [10] = {10,2,"61004",},
        [11] = {11,2,"61005",},
        [12] = {12,2,"61006",},
        [13] = {13,2,"61007",},
        [14] = {14,2,"61008",},
        [15] = {15,3,"little_recharge_sunshangxiang",},
    }
}

-- index
local __index_id_type = {
    ["10_2"] = 10,
    ["11_2"] = 11,
    ["12_2"] = 12,
    ["13_2"] = 13,
    ["14_2"] = 14,
    ["15_3"] = 15,
    ["1_1"] = 1,
    ["2_1"] = 2,
    ["3_1"] = 3,
    ["4_1"] = 4,
    ["5_1"] = 5,
    ["6_1"] = 6,
    ["7_2"] = 7,
    ["8_2"] = 8,
    ["9_2"] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in little_charge_res")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function little_charge_res.length()
    return #little_charge_res._data
end

-- 
function little_charge_res.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function little_charge_res.indexOf(index)
    if index == nil or not little_charge_res._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/little_charge_res.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "little_charge_res" )
        return setmetatable({_raw = little_charge_res._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = little_charge_res._data[index]}, mt)
end

--
function little_charge_res.get(id,type)
    
    local k = id .. '_' .. type
    return little_charge_res.indexOf(__index_id_type[k])
        
end

--
function little_charge_res.set(id,type, key, value)
    local record = little_charge_res.get(id,type)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function little_charge_res.index()
    return __index_id_type
end

return little_charge_res