--vip_content

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  day_min = 2,    --天数min-int 
  day_max = 3,    --天数max-int 
  type = 4,    --类型-int 
  value = 5,    --类型值id-int 
  size = 6,    --数量-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  day_min = "int",    --天数min-2 
  day_max = "int",    --天数max-3 
  type = "int",    --类型-4 
  value = "int",    --类型值id-5 
  size = "int",    --数量-6 

}


-- data
local vip_content = {
    version =  1,
    _data = {
        [1] = {1,1,3,5,2,250000,},
        [2] = {2,1,3,6,63,25,},
        [3] = {3,1,3,6,73,20,},
        [4] = {4,1,3,6,5,25,},
        [5] = {5,1,3,6,3,250,},
        [6] = {6,4,30,5,2,250000,},
        [7] = {7,4,30,6,63,25,},
        [8] = {8,4,30,6,73,20,},
        [9] = {9,4,30,6,5,25,},
        [10] = {10,4,30,6,3,250,},
        [11] = {11,4,30,6,19,250,},
        [12] = {12,4,30,6,10,25,},
        [13] = {13,31,999,5,2,250000,},
        [14] = {14,31,999,6,63,25,},
        [15] = {15,31,999,6,73,20,},
        [16] = {16,31,999,6,5,25,},
        [17] = {17,31,999,6,3,250,},
        [18] = {18,31,999,6,19,250,},
        [19] = {19,31,999,6,10,25,},
        [20] = {20,31,999,6,40,300,},
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
        assert(key_map[k], "cannot find " .. k .. " in vip_content")
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
function vip_content.length()
    return #vip_content._data
end

-- 
function vip_content.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function vip_content.isVersionValid(v)
    if vip_content.version then
        if v then
            return vip_content.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function vip_content.indexOf(index)
    if index == nil or not vip_content._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/vip_content.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/vip_content.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/vip_content.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "vip_content" )
                _isDataExist = vip_content.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "vip_content" )
                _isBaseExist = vip_content.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "vip_content" )
                _isExist = vip_content.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "vip_content" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "vip_content" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = vip_content._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "vip_content" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function vip_content.get(id)
    
    return vip_content.indexOf(__index_id[id])
        
end

--
function vip_content.set(id, key, value)
    local record = vip_content.get(id)
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
function vip_content.index()
    return __index_id
end

return vip_content