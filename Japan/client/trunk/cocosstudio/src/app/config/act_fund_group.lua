--act_fund_group

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  group_id = 1,    --组id-int 
  show_level = 2,    --开放等级-int 
  good_id = 3,    --商品id-int 
  txt = 4,    --说明文字-string 
  txt2 = 5,    --返利倍数-string 

}

-- key type
local __key_type = {
  group_id = "int",    --组id-1 
  show_level = "int",    --开放等级-2 
  good_id = "int",    --商品id-3 
  txt = "string",    --说明文字-4 
  txt2 = "string",    --返利倍数-5 

}


-- data
local act_fund_group = {
    version =  1,
    _data = {
        [1] = {1,1,10027,"3660","12",},
        [2] = {2,1,10028,"7840","16",},
        [3] = {3,1,10029,"18400","20",},
        [4] = {4,1,10030,"23000","25",},
        [5] = {5,1,10031,"23000","25",},
        [6] = {6,1,10032,"23000","25",},
        [7] = {7,1,10047,"23000","25",},
        [8] = {8,1,10048,"27600","30",},
        [9] = {9,1,10049,"27600","30",},
        [10] = {10,1,10050,"27600","30",},
        [11] = {11,1,10051,"27600","30",},
        [12] = {12,1,10060,"27600","30",},
        [13] = {13,1,10061,"32200","35",},
        [14] = {14,1,10062,"32200","35",},
        [15] = {15,1,10063,"32200","35",},
        [16] = {16,1,10064,"32200","35",},
        [17] = {17,1,10065,"32200","35",},
    }
}

-- index
local __index_group_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [17] = 17,
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
        assert(key_map[k], "cannot find " .. k .. " in act_fund_group")
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
function act_fund_group.length()
    return #act_fund_group._data
end

-- 
function act_fund_group.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function act_fund_group.isVersionValid(v)
    if act_fund_group.version then
        if v then
            return act_fund_group.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function act_fund_group.indexOf(index)
    if index == nil or not act_fund_group._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/act_fund_group.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/act_fund_group.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/act_fund_group.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "act_fund_group" )
                _isDataExist = act_fund_group.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "act_fund_group" )
                _isBaseExist = act_fund_group.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "act_fund_group" )
                _isExist = act_fund_group.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "act_fund_group" )
        local main_key = __main_key_map[index]
		local index_key = "__index_group_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "act_fund_group" )
        local main_key = __main_key_map[index]
		local index_key = "__index_group_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = act_fund_group._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "act_fund_group" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function act_fund_group.get(group_id)
    
    return act_fund_group.indexOf(__index_group_id[group_id])
        
end

--
function act_fund_group.set(group_id, key, value)
    local record = act_fund_group.get(group_id)
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
function act_fund_group.index()
    return __index_group_id
end

return act_fund_group