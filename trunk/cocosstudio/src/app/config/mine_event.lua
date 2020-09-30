--mine_event

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  event_type = 2,    --类型-int 
  event_value = 3,    --类型值-int 
  start_time = 4,    --开启时间-int 
  count_down_title = 5,    --倒计时标题-string 
  count_down_txt = 6,    --倒计时说明-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  event_type = "int",    --类型-2 
  event_value = "int",    --类型值-3 
  start_time = "int",    --开启时间-4 
  count_down_title = "string",    --倒计时标题-5 
  count_down_txt = "string",    --倒计时说明-6 

}


-- data
local mine_event = {
    version =  1,
    _data = {
        [1] = {1,1,0,28800,"距外圈矿区开启：","在普通矿区不能交战",},
        [2] = {2,1,1,201600,"距高级矿区开启：","在高级矿区可以剿灭敌军，占据矿区",},
        [3] = {3,1,2,374400,"距顶级矿区开启：","争夺最顶级的矿坑，获得最大收益",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in mine_event")
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
function mine_event.length()
    return #mine_event._data
end

-- 
function mine_event.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function mine_event.isVersionValid(v)
    if mine_event.version then
        if v then
            return mine_event.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function mine_event.indexOf(index)
    if index == nil or not mine_event._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/mine_event.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/mine_event.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/mine_event.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "mine_event" )
                _isDataExist = mine_event.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "mine_event" )
                _isBaseExist = mine_event.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "mine_event" )
                _isExist = mine_event.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "mine_event" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "mine_event" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = mine_event._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "mine_event" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function mine_event.get(id)
    
    return mine_event.indexOf(__index_id[id])
        
end

--
function mine_event.set(id, key, value)
    local record = mine_event.get(id)
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
function mine_event.index()
    return __index_id
end

return mine_event