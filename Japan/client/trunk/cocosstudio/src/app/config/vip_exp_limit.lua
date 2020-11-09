--vip_exp_limit

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  type = 2,    --类型-int 
  condition = 3,    --条件-int 
  require_value = 4,    --类型参数-int 
  num = 5,    --数量-int 
  vip_exp = 6,    --经验-int 
  reward_id1 = 7,    --奖励组id-int 
  reward_id2 = 8,    --奖励组id-int 
  reward_id3 = 9,    --奖励组id-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  type = "int",    --类型-2 
  condition = "int",    --条件-3 
  require_value = "int",    --类型参数-4 
  num = "int",    --数量-5 
  vip_exp = "int",    --经验-6 
  reward_id1 = "int",    --奖励组id-7 
  reward_id2 = "int",    --奖励组id-8 
  reward_id3 = "int",    --奖励组id-9 

}


-- data
local vip_exp_limit = {
    version =  1,
    _data = {
        [1] = {1,1,101,20,1,150,101,102,103,},
        [2] = {2,1,101,50,1,150,101,102,103,},
        [3] = {3,1,101,90,1,150,101,102,103,},
        [4] = {4,2,0,0,10,1,0,0,0,},
        [5] = {5,3,101,20,0,0,0,0,0,},
        [6] = {6,3,101,50,0,0,0,0,0,},
        [7] = {7,3,101,90,0,0,0,0,0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in vip_exp_limit")
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
function vip_exp_limit.length()
    return #vip_exp_limit._data
end

-- 
function vip_exp_limit.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function vip_exp_limit.isVersionValid(v)
    if vip_exp_limit.version then
        if v then
            return vip_exp_limit.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function vip_exp_limit.indexOf(index)
    if index == nil or not vip_exp_limit._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/vip_exp_limit.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/vip_exp_limit.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/vip_exp_limit.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "vip_exp_limit" )
                _isDataExist = vip_exp_limit.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "vip_exp_limit" )
                _isBaseExist = vip_exp_limit.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "vip_exp_limit" )
                _isExist = vip_exp_limit.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "vip_exp_limit" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "vip_exp_limit" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = vip_exp_limit._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "vip_exp_limit" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function vip_exp_limit.get(id)
    
    return vip_exp_limit.indexOf(__index_id[id])
        
end

--
function vip_exp_limit.set(id, key, value)
    local record = vip_exp_limit.get(id)
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
function vip_exp_limit.index()
    return __index_id
end

return vip_exp_limit