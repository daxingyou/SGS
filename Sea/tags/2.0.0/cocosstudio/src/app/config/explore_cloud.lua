--explore_cloud

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --对应章节id-int 
  x1 = 2,    --云1x坐标-int 
  y1 = 3,    --云1y坐标-int 
  movex1 = 4,    --云1位移x-int 
  movey1 = 5,    --云1位移y-int 
  x2 = 6,    --云2x坐标-int 
  y2 = 7,    --云2y坐标-int 
  movex2 = 8,    --云2位移x-int 
  movey2 = 9,    --云2位移y-int 
  x3 = 10,    --云3x坐标-int 
  y3 = 11,    --云3y坐标-int 
  movex3 = 12,    --云3位移x-int 
  movey3 = 13,    --云3位移y-int 
  x4 = 14,    --云4x坐标-int 
  y4 = 15,    --云4y坐标-int 
  movex4 = 16,    --云4位移x-int 
  movey4 = 17,    --云4位移y-int 
  x5 = 18,    --云5x坐标-int 
  y5 = 19,    --云5y坐标-int 
  movex5 = 20,    --云5位移x-int 
  movey5 = 21,    --云5位移y-int 
  x6 = 22,    --云6x坐标-int 
  y6 = 23,    --云6y坐标-int 
  movex6 = 24,    --云6位移x-int 
  movey6 = 25,    --云6位移y-int 
  x7 = 26,    --云7x坐标-int 
  y7 = 27,    --云7y坐标-int 
  movex7 = 28,    --云7位移x-int 
  movey7 = 29,    --云7位移y-int 
  x8 = 30,    --云8x坐标-int 
  y8 = 31,    --云8y坐标-int 
  movex8 = 32,    --云8位移x-int 
  movey8 = 33,    --云8位移y-int 

}

-- key type
local __key_type = {
  id = "int",    --对应章节id-1 
  x1 = "int",    --云1x坐标-2 
  y1 = "int",    --云1y坐标-3 
  movex1 = "int",    --云1位移x-4 
  movey1 = "int",    --云1位移y-5 
  x2 = "int",    --云2x坐标-6 
  y2 = "int",    --云2y坐标-7 
  movex2 = "int",    --云2位移x-8 
  movey2 = "int",    --云2位移y-9 
  x3 = "int",    --云3x坐标-10 
  y3 = "int",    --云3y坐标-11 
  movex3 = "int",    --云3位移x-12 
  movey3 = "int",    --云3位移y-13 
  x4 = "int",    --云4x坐标-14 
  y4 = "int",    --云4y坐标-15 
  movex4 = "int",    --云4位移x-16 
  movey4 = "int",    --云4位移y-17 
  x5 = "int",    --云5x坐标-18 
  y5 = "int",    --云5y坐标-19 
  movex5 = "int",    --云5位移x-20 
  movey5 = "int",    --云5位移y-21 
  x6 = "int",    --云6x坐标-22 
  y6 = "int",    --云6y坐标-23 
  movex6 = "int",    --云6位移x-24 
  movey6 = "int",    --云6位移y-25 
  x7 = "int",    --云7x坐标-26 
  y7 = "int",    --云7y坐标-27 
  movex7 = "int",    --云7位移x-28 
  movey7 = "int",    --云7位移y-29 
  x8 = "int",    --云8x坐标-30 
  y8 = "int",    --云8y坐标-31 
  movex8 = "int",    --云8位移x-32 
  movey8 = "int",    --云8位移y-33 

}


-- data
local explore_cloud = {
    _data = {
        [1] = {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [2] = {2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [3] = {3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [4] = {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [5] = {5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [6] = {6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [7] = {7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [8] = {8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [9] = {9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [10] = {10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [11] = {11,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [12] = {12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [13] = {13,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [14] = {14,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [15] = {15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [16] = {16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [17] = {17,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [18] = {18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [19] = {19,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [20] = {20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [21] = {991,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [22] = {992,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [23] = {993,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [24] = {994,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [25] = {995,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [26] = {996,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [27] = {997,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [28] = {998,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [29] = {999,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
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
    [16] = 16,
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [20] = 20,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,
    [991] = 21,
    [992] = 22,
    [993] = 23,
    [994] = 24,
    [995] = 25,
    [996] = 26,
    [997] = 27,
    [998] = 28,
    [999] = 29,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in explore_cloud")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function explore_cloud.length()
    return #explore_cloud._data
end

-- 
function explore_cloud.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function explore_cloud.indexOf(index)
    if index == nil or not explore_cloud._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/explore_cloud.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "explore_cloud" )
        return setmetatable({_raw = explore_cloud._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = explore_cloud._data[index]}, mt)
end

--
function explore_cloud.get(id)
    
    return explore_cloud.indexOf(__index_id[id])
        
end

--
function explore_cloud.set(id, key, value)
    local record = explore_cloud.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function explore_cloud.index()
    return __index_id
end

return explore_cloud