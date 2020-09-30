--ten_jade_auction_para

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  key = 2,    --参数名称-string 
  content = 3,    --参数内容-string 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  key = "string",    --参数名称-2 
  content = "string",    --参数内容-3 

}


-- data
local ten_jade_auction_para = {
    version =  1,
    _data = {
        [1] = {1,"open_count_down","0",},
        [2] = {2,"extend_start_time","60",},
        [3] = {3,"extend_time","120",},
        [4] = {4,"safe_num","100",},
        [5] = {5,"server_num","8",},
        [6] = {6,"intrance_open_time","00|00|00",},
        [7] = {7,"intrance_close_time","23|59|59",},
        [8] = {8,"termination_time","3600",},
        [9] = {9,"cross_chat_open","300",},
        [10] = {10,"cross_chat_close","300",},
        [11] = {11,"show_icon_1","16|2102",},
        [12] = {12,"show_icon_2","16|4108",},
        [13] = {13,"show_icon_3","16|4104",},
        [14] = {14,"show_icon_4","11|1503",},
        [15] = {15,"activity_name","一元起拍",},
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
        assert(key_map[k], "cannot find " .. k .. " in ten_jade_auction_para")
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
function ten_jade_auction_para.length()
    return #ten_jade_auction_para._data
end

-- 
function ten_jade_auction_para.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function ten_jade_auction_para.isVersionValid(v)
    if ten_jade_auction_para.version then
        if v then
            return ten_jade_auction_para.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function ten_jade_auction_para.indexOf(index)
    if index == nil or not ten_jade_auction_para._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/ten_jade_auction_para.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/ten_jade_auction_para.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/ten_jade_auction_para.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "ten_jade_auction_para" )
                _isDataExist = ten_jade_auction_para.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "ten_jade_auction_para" )
                _isBaseExist = ten_jade_auction_para.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "ten_jade_auction_para" )
                _isExist = ten_jade_auction_para.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "ten_jade_auction_para" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "ten_jade_auction_para" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = ten_jade_auction_para._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "ten_jade_auction_para" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function ten_jade_auction_para.get(id)
    
    return ten_jade_auction_para.indexOf(__index_id[id])
        
end

--
function ten_jade_auction_para.set(id, key, value)
    local record = ten_jade_auction_para.get(id)
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
function ten_jade_auction_para.index()
    return __index_id
end

return ten_jade_auction_para