--parameter_lang

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
local parameter_lang = {
    version =  1,
    _data = {
        [1] = {14001,"redpacket_time_1","天",},
        [2] = {14002,"redpacket_time_2","时",},
        [3] = {14003,"redpacket_time_3","分",},
        [4] = {14004,"redpacket_time_4","秒",},
        [5] = {174,"answer_no_one","无",},
        [6] = {245,"minecraft_juntuan_txt","军团",},
        [7] = {31501,"country_txt_1","魏国",},
        [8] = {31502,"country_txt_2","蜀国",},
        [9] = {31503,"country_txt_3","吴国",},
        [10] = {31504,"country_txt_4","群雄",},
        [11] = {42101,"pit_type_1","【双倍矿】",},
        [12] = {42102,"pit_type_2","【三倍矿】",},
        [13] = {482,"title_forever","永久",},
        [14] = {483,"title_days","天",},
        [15] = {634,"goldenhero_bullet_goods","#server##name#获得了#goods#！",},
        [16] = {635,"goldenhero_bullet_hero","#server##name#获得了#hero#！",},
    }
}

-- index
local __index_id = {
    [14001] = 1,
    [14002] = 2,
    [14003] = 3,
    [14004] = 4,
    [174] = 5,
    [245] = 6,
    [31501] = 7,
    [31502] = 8,
    [31503] = 9,
    [31504] = 10,
    [42101] = 11,
    [42102] = 12,
    [482] = 13,
    [483] = 14,
    [634] = 15,
    [635] = 16,

}

-- index mainkey map
local __main_key_map = {
    [1] = 14001,
    [2] = 14002,
    [3] = 14003,
    [4] = 14004,
    [5] = 174,
    [6] = 245,
    [7] = 31501,
    [8] = 31502,
    [9] = 31503,
    [10] = 31504,
    [11] = 42101,
    [12] = 42102,
    [13] = 482,
    [14] = 483,
    [15] = 634,
    [16] = 635,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in parameter_lang")
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
function parameter_lang.length()
    return #parameter_lang._data
end

-- 
function parameter_lang.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function parameter_lang.isVersionValid(v)
    if parameter_lang.version then
        if v then
            return parameter_lang.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function parameter_lang.indexOf(index)
    if index == nil or not parameter_lang._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/parameter_lang.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/parameter_lang.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/parameter_lang.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "parameter_lang" )
                _isDataExist = parameter_lang.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "parameter_lang" )
                _isBaseExist = parameter_lang.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "parameter_lang" )
                _isExist = parameter_lang.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "parameter_lang" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "parameter_lang" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = parameter_lang._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "parameter_lang" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function parameter_lang.get(id)
    
    return parameter_lang.indexOf(__index_id[id])
        
end

--
function parameter_lang.set(id, key, value)
    local record = parameter_lang.get(id)
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
function parameter_lang.index()
    return __index_id
end

return parameter_lang