--gm_fund

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  type = 2,    --类型-int 
  group = 3,    --分组-int 
  day = 4,    --天数-int 
  reward_type_1 = 5,    --奖励类型1-int 
  reward_value_1 = 6,    --类型值1-int 
  reward_size_1 = 7,    --数量1-int 
  reward_type_2 = 8,    --奖励类型2-int 
  reward_value_2 = 9,    --类型值2-int 
  reward_size_2 = 10,    --数量2-int 
  background = 11,    --背景图片-string 
  effects = 12,    --物品特效-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  type = "int",    --类型-2 
  group = "int",    --分组-3 
  day = "int",    --天数-4 
  reward_type_1 = "int",    --奖励类型1-5 
  reward_value_1 = "int",    --类型值1-6 
  reward_size_1 = "int",    --数量1-7 
  reward_type_2 = "int",    --奖励类型2-8 
  reward_value_2 = "int",    --类型值2-9 
  reward_size_2 = "int",    --数量2-10 
  background = "string",    --背景图片-11 
  effects = "int",    --物品特效-12 

}


-- data
local gm_fund = {
    _data = {
        [1] = {1,1,101,1,5,1,1960,0,0,0,"",0,},
        [2] = {2,1,101,2,6,14,40,0,0,0,"",0,},
        [3] = {3,1,101,3,6,146,2,0,0,0,"",0,},
        [4] = {4,1,101,4,6,14,40,0,0,0,"",0,},
        [5] = {5,1,101,5,6,118,1,0,0,0,"",0,},
        [6] = {8,1,102,1,5,1,1960,0,0,0,"img_activity_bg11",1,},
        [7] = {9,1,102,2,5,1,980,0,0,0,"img_activity_bg11",0,},
        [8] = {10,1,102,3,5,1,1960,0,0,0,"img_activity_bg11",1,},
        [9] = {11,1,102,4,5,1,980,0,0,0,"img_activity_bg11",0,},
        [10] = {12,1,102,5,5,1,1960,0,0,0,"img_activity_bg11",1,},
        [11] = {13,1,103,1,5,1,1960,0,0,0,"",0,},
        [12] = {14,1,103,2,6,146,2,0,0,0,"",0,},
        [13] = {15,1,103,3,6,14,40,0,0,0,"",0,},
        [14] = {16,1,103,4,6,146,2,0,0,0,"",0,},
        [15] = {17,1,103,5,6,705,1,0,0,0,"",0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 8,
    [11] = 9,
    [12] = 10,
    [13] = 11,
    [14] = 12,
    [15] = 13,
    [16] = 14,
    [17] = 15,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [8] = 6,
    [9] = 7,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in gm_fund")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function gm_fund.length()
    return #gm_fund._data
end

-- 
function gm_fund.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function gm_fund.indexOf(index)
    if index == nil or not gm_fund._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/gm_fund.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "gm_fund" )
        return setmetatable({_raw = gm_fund._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = gm_fund._data[index]}, mt)
end

--
function gm_fund.get(id)
    
    return gm_fund.indexOf(__index_id[id])
        
end

--
function gm_fund.set(id, key, value)
    local record = gm_fund.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function gm_fund.index()
    return __index_id
end

return gm_fund