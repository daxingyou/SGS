--update_redpacket

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --红包id-int 
  name = 2,    --红包名称-string 

}

-- key type
local __key_type = {
  id = "int",    --红包id-1 
  name = "string",    --红包名称-2 

}


-- data
local update_redpacket = {
    version =  1,
    _data = {
        [1] = {99,"狂欢大红包",},
        [2] = {1,"红色整将一口价",},
        [3] = {2,"红将碎片一口价",},
        [4] = {3,"红色神兵一口价",},
        [5] = {4,"红色万能神兵一口价",},
        [6] = {5,"春秋一口价",},
        [7] = {6,"战国一口价",},
        [8] = {7,"红锦囊一口价",},
        [9] = {8,"橙锦囊一口价",},
        [10] = {9,"择贤令一口价",},
        [11] = {10,"择贤举善令一口价",},
    }
}

-- index
local __index_id = {
    [1] = 2,
    [10] = 11,
    [2] = 3,
    [3] = 4,
    [4] = 5,
    [5] = 6,
    [6] = 7,
    [7] = 8,
    [8] = 9,
    [9] = 10,
    [99] = 1,

}

-- index mainkey map
local __main_key_map = {
    [2] = 1,
    [11] = 10,
    [3] = 2,
    [4] = 3,
    [5] = 4,
    [6] = 5,
    [7] = 6,
    [8] = 7,
    [9] = 8,
    [10] = 9,
    [1] = 99,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in update_redpacket")
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
function update_redpacket.length()
    return #update_redpacket._data
end

-- 
function update_redpacket.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function update_redpacket.isVersionValid(v)
    if update_redpacket.version then
        if v then
            return update_redpacket.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function update_redpacket.indexOf(index)
    if index == nil or not update_redpacket._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/update_redpacket.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/update_redpacket.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/update_redpacket.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "update_redpacket" )
                _isDataExist = update_redpacket.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "update_redpacket" )
                _isBaseExist = update_redpacket.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "update_redpacket" )
                _isExist = update_redpacket.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "update_redpacket" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "update_redpacket" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = update_redpacket._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "update_redpacket" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function update_redpacket.get(id)
    
    return update_redpacket.indexOf(__index_id[id])
        
end

--
function update_redpacket.set(id, key, value)
    local record = update_redpacket.get(id)
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
function update_redpacket.index()
    return __index_id
end

return update_redpacket