--cake_task

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  type = 2,    --类型-int 
  times = 3,    --次数-int 
  desc = 4,    --描述-string 
  award_type = 5,    --奖励type-int 
  award_value = 6,    --奖励value-int 
  award_size = 7,    --奖励size-int 
  function_id = 8,    --跳转系统-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  type = "int",    --类型-2 
  times = "int",    --次数-3 
  desc = "string",    --描述-4 
  award_type = "int",    --奖励type-5 
  award_value = "int",    --奖励value-6 
  award_size = "int",    --奖励size-7 
  function_id = "string",    --跳转系统-8 

}


-- data
local cake_task = {
    _data = {
        [1] = {100,1,25,"挑战主线或精英副本25次",6,570,20,"51",},
        [2] = {101,1,50,"挑战主线或精英副本50次",6,570,20,"51",},
        [3] = {102,1,75,"挑战主线或精英副本75次",6,570,20,"51",},
        [4] = {103,1,100,"挑战主线或精英副本100次",6,570,20,"51",},
        [5] = {200,2,25,"游历25次",6,570,20,"73",},
        [6] = {201,2,50,"游历50次",6,570,20,"73",},
        [7] = {202,2,75,"游历75次",6,570,20,"73",},
        [8] = {203,2,100,"游历100次",6,570,20,"73",},
        [9] = {300,3,30,"每日任务活跃度达到30",6,570,20,"8",},
        [10] = {301,3,60,"每日任务活跃度达到60",6,570,20,"8",},
        [11] = {302,3,90,"每日任务活跃度达到90",6,570,20,"8",},
        [12] = {303,3,120,"每日任务活跃度达到120",6,570,20,"8",},
        [13] = {304,3,150,"每日任务活跃度达到150",6,570,20,"8",},
        [14] = {400,4,1,"参加12点军团BOSS活动1次",6,570,20,"803",},
        [15] = {500,5,1,"参加19点军团BOSS活动1次",6,570,20,"803",},
        [16] = {600,6,1,"参加答题活动1次",6,570,20,"87|1501",},
        [17] = {700,7,1,"参加军团试炼1次",6,570,20,"64",},
    }
}

-- index
local __index_id = {
    [100] = 1,
    [101] = 2,
    [102] = 3,
    [103] = 4,
    [200] = 5,
    [201] = 6,
    [202] = 7,
    [203] = 8,
    [300] = 9,
    [301] = 10,
    [302] = 11,
    [303] = 12,
    [304] = 13,
    [400] = 14,
    [500] = 15,
    [600] = 16,
    [700] = 17,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in cake_task")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function cake_task.length()
    return #cake_task._data
end

-- 
function cake_task.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cake_task.indexOf(index)
    if index == nil or not cake_task._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/cake_task.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cake_task" )
        return setmetatable({_raw = cake_task._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = cake_task._data[index]}, mt)
end

--
function cake_task.get(id)
    
    return cake_task.indexOf(__index_id[id])
        
end

--
function cake_task.set(id, key, value)
    local record = cake_task.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function cake_task.index()
    return __index_id
end

return cake_task