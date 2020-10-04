--parameter_lang

local _lang = "cn"
local _isExist = false

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

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in parameter_lang")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
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
        if Lang.isFileExist("app/i18n/".. _lang .."/config/parameter_lang.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "parameter_lang" )
        return setmetatable({_raw = parameter_lang._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = parameter_lang._data[index]}, mt)
end

--
function parameter_lang.get(id)
    
    return parameter_lang.indexOf(__index_id[id])
        
end

--
function parameter_lang.set(id, key, value)
    local record = parameter_lang.get(id)
    if record then
        local keyIndex = __key_map[key]
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