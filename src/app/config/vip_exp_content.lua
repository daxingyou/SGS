--vip_exp_content

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  reward_id = 2,    --奖励组id-int 
  day_min = 3,    --天数min-int 
  day_max = 4,    --天数max-int 
  type = 5,    --类型-int 
  value = 6,    --类型值id-int 
  size = 7,    --数量-int 
  produce_probability = 8,    --权重-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  reward_id = "int",    --奖励组id-2 
  day_min = "int",    --天数min-3 
  day_max = "int",    --天数max-4 
  type = "int",    --类型-5 
  value = "int",    --类型值id-6 
  size = "int",    --数量-7 
  produce_probability = "int",    --权重-8 

}


-- data
local vip_exp_content = {
    version =  1,
    _data = {
        [1] = {1,101,1,3,5,1,200,1000,},
        [2] = {2,101,1,3,5,1,300,1000,},
        [3] = {3,101,1,3,5,2,100000,1000,},
        [4] = {4,101,1,3,6,63,50,1000,},
        [5] = {5,101,1,3,6,73,40,1000,},
        [6] = {6,101,1,3,6,5,50,1000,},
        [7] = {7,102,4,30,6,63,50,1000,},
        [8] = {8,102,4,30,6,73,40,1000,},
        [9] = {9,102,4,30,6,5,50,1000,},
        [10] = {10,102,4,30,6,3,500,1000,},
        [11] = {11,102,4,30,6,19,500,1000,},
        [12] = {12,102,4,30,6,10,50,1000,},
        [13] = {13,103,31,999,6,63,50,1000,},
        [14] = {14,103,31,999,6,73,40,1000,},
        [15] = {15,103,31,999,6,5,50,1000,},
        [16] = {16,103,31,999,6,3,500,1000,},
        [17] = {17,103,31,999,6,19,500,1000,},
        [18] = {18,103,31,999,6,10,50,1000,},
        [19] = {19,103,31,999,6,40,500,1000,},
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
        assert(key_map[k], "cannot find " .. k .. " in vip_exp_content")
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
function vip_exp_content.length()
    return #vip_exp_content._data
end

-- 
function vip_exp_content.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function vip_exp_content.isVersionValid(v)
    if vip_exp_content.version then
        if v then
            return vip_exp_content.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function vip_exp_content.indexOf(index)
    if index == nil or not vip_exp_content._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/vip_exp_content.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/vip_exp_content.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/vip_exp_content.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "vip_exp_content" )
                _isDataExist = vip_exp_content.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "vip_exp_content" )
                _isBaseExist = vip_exp_content.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "vip_exp_content" )
                _isExist = vip_exp_content.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "vip_exp_content" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "vip_exp_content" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = vip_exp_content._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "vip_exp_content" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function vip_exp_content.get(id)
    
    return vip_exp_content.indexOf(__index_id[id])
        
end

--
function vip_exp_content.set(id, key, value)
    local record = vip_exp_content.get(id)
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
function vip_exp_content.index()
    return __index_id
end

return vip_exp_content