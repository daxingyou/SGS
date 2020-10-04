--instrument_rank

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  rank_id = 1,    --id-int 
  instrument_id = 2,    --界限突破id-int 
  cost_silver = 3,    --进阶消耗银币-int 
  name_1 = 4,    --材料1名称-string 
  type_1 = 5,    --消耗资源类型1-int 
  value_1 = 6,    --消耗资源id1-int 
  size_1 = 7,    --消耗资源数量1-int 
  consume_1 = 8,    --材料1每次消耗-int 
  name_2 = 9,    --材料2名称-string 
  type_2 = 10,    --消耗资源类型2-int 
  value_2 = 11,    --消耗资源id2-int 
  size_2 = 12,    --消耗资源数量2-int 
  consume_2 = 13,    --材料2每次消耗-int 
  level = 14,    --神兵突破等级-int 
  level_max = 15,    --突破后进阶等级上限-int 
  cost_size = 16,    --神兵突破后品质-int 
  rank_size = 17,    --进阶模板ID-int 

}

-- key type
local __key_type = {
  rank_id = "int",    --id-1 
  instrument_id = "int",    --界限突破id-2 
  cost_silver = "int",    --进阶消耗银币-3 
  name_1 = "string",    --材料1名称-4 
  type_1 = "int",    --消耗资源类型1-5 
  value_1 = "int",    --消耗资源id1-6 
  size_1 = "int",    --消耗资源数量1-7 
  consume_1 = "int",    --材料1每次消耗-8 
  name_2 = "string",    --材料2名称-9 
  type_2 = "int",    --消耗资源类型2-10 
  value_2 = "int",    --消耗资源id2-11 
  size_2 = "int",    --消耗资源数量2-12 
  consume_2 = "int",    --材料2每次消耗-13 
  level = "int",    --神兵突破等级-14 
  level_max = "int",    --突破后进阶等级上限-15 
  cost_size = "int",    --神兵突破后品质-16 
  rank_size = "int",    --进阶模板ID-17 

}


-- data
local instrument_rank = {
    _data = {
        [1] = {1,0,18000000,"春秋",6,92,36,1,"战国",6,93,36,1,50,75,6,5,},
        [2] = {1,1,0,"春秋",0,0,0,0,"战国",0,0,0,0,0,0,6,5,},
    }
}

-- index
local __index_rank_id_instrument_id = {
    ["1_0"] = 1,
    ["1_1"] = 2,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in instrument_rank")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function instrument_rank.length()
    return #instrument_rank._data
end

-- 
function instrument_rank.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function instrument_rank.indexOf(index)
    if index == nil or not instrument_rank._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/instrument_rank.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "instrument_rank" )
        return setmetatable({_raw = instrument_rank._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = instrument_rank._data[index]}, mt)
end

--
function instrument_rank.get(rank_id,instrument_id)
    
    local k = rank_id .. '_' .. instrument_id
    return instrument_rank.indexOf(__index_rank_id_instrument_id[k])
        
end

--
function instrument_rank.set(rank_id,instrument_id, key, value)
    local record = instrument_rank.get(rank_id,instrument_id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function instrument_rank.index()
    return __index_rank_id_instrument_id
end

return instrument_rank