--cake_rank

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  batch = 2,    --批次-int 
  type = 3,    --类型-int 
  rank_max = 4,    --排名上限-int 
  rank_min = 5,    --排名下限-int 
  drop = 6,    --奖励dropid-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  batch = "int",    --批次-2 
  type = "int",    --类型-3 
  rank_max = "int",    --排名上限-4 
  rank_min = "int",    --排名下限-5 
  drop = "int",    --奖励dropid-6 

}


-- data
local cake_rank = {
    _data = {
        [1] = {121,1,2,1,1,1001,},
        [2] = {122,1,2,2,2,1002,},
        [3] = {123,1,2,3,3,1003,},
        [4] = {124,1,2,4,50,1004,},
        [5] = {141,1,4,1,1,1021,},
        [6] = {142,1,4,2,2,1022,},
        [7] = {143,1,4,3,3,1023,},
        [8] = {144,1,4,4,10,1024,},
        [9] = {1411,1,4,11,20,1025,},
        [10] = {1421,1,4,21,30,1026,},
        [11] = {1430,1,4,31,50,1027,},
        [12] = {221,2,2,1,1,1001,},
        [13] = {222,2,2,2,2,1002,},
        [14] = {223,2,2,3,3,1003,},
        [15] = {224,2,2,4,50,1004,},
        [16] = {241,2,4,1,1,1021,},
        [17] = {242,2,4,2,2,1022,},
        [18] = {243,2,4,3,3,1023,},
        [19] = {244,2,4,4,10,1024,},
        [20] = {2411,2,4,11,20,1025,},
        [21] = {2421,2,4,21,30,1026,},
        [22] = {2431,2,4,31,50,1027,},
    }
}

-- index
local __index_id = {
    [121] = 1,
    [122] = 2,
    [123] = 3,
    [124] = 4,
    [141] = 5,
    [1411] = 9,
    [142] = 6,
    [1421] = 10,
    [143] = 7,
    [1430] = 11,
    [144] = 8,
    [221] = 12,
    [222] = 13,
    [223] = 14,
    [224] = 15,
    [241] = 16,
    [2411] = 20,
    [242] = 17,
    [2421] = 21,
    [243] = 18,
    [2431] = 22,
    [244] = 19,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in cake_rank")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function cake_rank.length()
    return #cake_rank._data
end

-- 
function cake_rank.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cake_rank.indexOf(index)
    if index == nil or not cake_rank._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/cake_rank.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cake_rank" )
        return setmetatable({_raw = cake_rank._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = cake_rank._data[index]}, mt)
end

--
function cake_rank.get(id)
    
    return cake_rank.indexOf(__index_id[id])
        
end

--
function cake_rank.set(id, key, value)
    local record = cake_rank.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function cake_rank.index()
    return __index_id
end

return cake_rank