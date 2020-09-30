--parameter_lang

local _lang = "cn"
local _isExist = false
local _isBaseExist = false

-- key
local __key_map = {
  id = 1,    --序号_key-int 
  content = 2,    --参数内容-string 

}

-- key type
local __key_type = {
  id = "int",    --序号_key-1 
  content = "string",    --参数内容-2 

}


-- data
local parameter_lang = {
    _data = {
        [1] = {14001,"天",},
        [2] = {14002,"时",},
        [3] = {14003,"分",},
        [4] = {14004,"秒",},
        [5] = {174,"无",},
        [6] = {245,"军团",},
        [7] = {31501,"魏国",},
        [8] = {31502,"蜀国",},
        [9] = {31503,"吴国",},
        [10] = {31504,"群雄",},
        [11] = {42101,"[双倍矿]",},
        [12] = {42102,"[三倍矿]",},
        [13] = {482,"永久",},
        [14] = {483,"天",},
        [15] = {634,"#server##name#获得了#goods#!",},
        [16] = {635,"#server##name#获得了#hero#!",},
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
function parameter_lang.indexOf(index)
    if index == nil or not parameter_lang._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.isFileExist("app/i18n/".. _lang .."/config/parameter_lang.lua") then 
            _isExist =  true 
        end
        _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/parameter_lang.lua")
    end
    
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "parameter_lang" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        local raw = parameter_lang._data[index]
        if _isBaseExist then
            local table_base = require( "app.i18n.".. _lang ..".base." .. "parameter_lang" )
            raw =  table_base._data[index] 
        end
        return setmetatable({_raw = raw,_raw_key_map = __key_map, _lang=table._data[lang_index], _lang_key_map=table.__key_map}, mt)
    end
    local raw = parameter_lang._data[index]
    if _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "parameter_lang" )
        raw =  table_base._data[index] 
    end
    return setmetatable({_raw = raw,_raw_key_map = __key_map}, mt)
end

--
function parameter_lang.get(id)
    
    return parameter_lang.indexOf(__index_id[id])
        
end

--
function parameter_lang.set(id, key, value)
    local record = parameter_lang.get(id)
    if record then
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