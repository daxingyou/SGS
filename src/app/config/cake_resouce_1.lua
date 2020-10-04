--cake_resouce_1

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  type = 1,    --活动类型-int 
  icon_word = 2,    --活动icon文字-string 
  icon_word_script = 3,    --字体-string 
  icon_word_place = 4,    --位置-string 
  icon_word_space = 5,    --行间距-string 
  icon_word_alignment = 6,    --对齐方式-string 
  gain_icon_word = 7,    --获取材料icon文字-string 
  gain_icon_word_script = 8,    --字体-string 
  gain_icon_word_place = 9,    --位置-string 
  gain_icon_word_space = 10,    --行间距-string 
  gain_icon_word_alignment = 11,    --对齐方式-string 

}

-- key type
local __key_type = {
  type = "int",    --活动类型-1 
  icon_word = "string",    --活动icon文字-2 
  icon_word_script = "string",    --字体-3 
  icon_word_place = "string",    --位置-4 
  icon_word_space = "string",    --行间距-5 
  icon_word_alignment = "string",    --对齐方式-6 
  gain_icon_word = "string",    --获取材料icon文字-7 
  gain_icon_word_script = "string",    --字体-8 
  gain_icon_word_place = "string",    --位置-9 
  gain_icon_word_space = "string",    --行间距-10 
  gain_icon_word_alignment = "string",    --对齐方式-11 

}


-- data
local cake_resouce_1 = {
    version =  1,
    _data = {
        [1] = {1,"饕餮盛宴","2","30,0","","","奶油获取","3","0,-37","","",},
        [2] = {2,"饕餮盛宴","2","30,0","","","肥牛获取","3","0,-37","","",},
        [3] = {3,"饕餮盛宴","2","30,0","","","牛肉获取","3","0,-37","","",},
        [4] = {4,"饕餮盛宴","2","30,0","","","生财有计","3","0,-37","","",},
    }
}

-- index
local __index_type = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in cake_resouce_1")
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
function cake_resouce_1.length()
    return #cake_resouce_1._data
end

-- 
function cake_resouce_1.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cake_resouce_1.isVersionValid(v)
    if cake_resouce_1.version then
        if v then
            return cake_resouce_1.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function cake_resouce_1.indexOf(index)
    if index == nil or not cake_resouce_1._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/cake_resouce_1.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/cake_resouce_1.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/cake_resouce_1.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "cake_resouce_1" )
                _isDataExist = cake_resouce_1.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "cake_resouce_1" )
                _isBaseExist = cake_resouce_1.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "cake_resouce_1" )
                _isExist = cake_resouce_1.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "cake_resouce_1" )
        local main_key = __main_key_map[index]
		local index_key = "__index_type"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cake_resouce_1" )
        local main_key = __main_key_map[index]
		local index_key = "__index_type"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = cake_resouce_1._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "cake_resouce_1" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function cake_resouce_1.get(type)
    
    return cake_resouce_1.indexOf(__index_type[type])
        
end

--
function cake_resouce_1.set(type, key, value)
    local record = cake_resouce_1.get(type)
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
function cake_resouce_1.index()
    return __index_type
end

return cake_resouce_1