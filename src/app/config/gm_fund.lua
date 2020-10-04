--gm_fund

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

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
    version =  1,
    _data = {
        [1] = {1,1,101,1,5,1,1840,0,0,0,"",0,},
        [2] = {2,1,101,2,6,146,2,0,0,0,"",0,},
        [3] = {3,1,101,3,6,14,40,0,0,0,"",0,},
        [4] = {4,1,101,4,6,162,1,0,0,0,"",0,},
        [5] = {5,1,101,5,6,118,1,0,0,0,"",0,},
        [6] = {8,1,102,1,5,1,1840,0,0,0,"img_activity_bg11",1,},
        [7] = {9,1,102,2,5,1,920,0,0,0,"img_activity_bg11",0,},
        [8] = {10,1,102,3,5,1,1840,0,0,0,"img_activity_bg11",1,},
        [9] = {11,1,102,4,5,1,920,0,0,0,"img_activity_bg11",0,},
        [10] = {12,1,102,5,5,1,1840,0,0,0,"img_activity_bg11",1,},
        [11] = {13,1,103,1,5,1,1840,0,0,0,"",0,},
        [12] = {14,1,103,2,6,146,2,0,0,0,"",0,},
        [13] = {15,1,103,3,6,14,40,0,0,0,"",0,},
        [14] = {16,1,103,4,6,162,1,0,0,0,"",0,},
        [15] = {17,1,103,5,6,705,1,0,0,0,"",0,},
        [16] = {18,1,104,1,5,1,1840,0,0,0,"",0,},
        [17] = {19,1,104,2,6,162,1,0,0,0,"",0,},
        [18] = {20,1,104,3,6,14,40,0,0,0,"",0,},
        [19] = {21,1,104,4,6,162,1,0,0,0,"",0,},
        [20] = {22,1,104,5,6,705,1,0,0,0,"",0,},
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
    [18] = 16,
    [19] = 17,
    [2] = 2,
    [20] = 18,
    [21] = 19,
    [22] = 20,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [8] = 6,
    [9] = 7,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [8] = 10,
    [9] = 11,
    [10] = 12,
    [11] = 13,
    [12] = 14,
    [13] = 15,
    [14] = 16,
    [15] = 17,
    [16] = 18,
    [17] = 19,
    [2] = 2,
    [18] = 20,
    [19] = 21,
    [20] = 22,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 8,
    [7] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in gm_fund")
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
function gm_fund.isVersionValid(v)
    if gm_fund.version then
        if v then
            return gm_fund.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function gm_fund.indexOf(index)
    if index == nil or not gm_fund._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/gm_fund.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/gm_fund.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/gm_fund.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "gm_fund" )
                _isDataExist = gm_fund.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "gm_fund" )
                _isBaseExist = gm_fund.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "gm_fund" )
                _isExist = gm_fund.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "gm_fund" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "gm_fund" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = gm_fund._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "gm_fund" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function gm_fund.get(id)
    
    return gm_fund.indexOf(__index_id[id])
        
end

--
function gm_fund.set(id, key, value)
    local record = gm_fund.get(id)
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
function gm_fund.index()
    return __index_id
end

return gm_fund