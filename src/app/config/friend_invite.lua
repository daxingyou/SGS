--friend_invite

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  pre_id = 2,    --前置任务-int 
  name = 3,    --任务名称-string 
  tab = 4,    --所属页签-int 
  order = 5,    --排序-int 
  condition = 6,    --完成条件-int 
  require_value1 = 7,    --条件参数-int 
  require_value2 = 8,    --条件参数-int 
  reward_type1 = 9,    --奖励类型1-int 
  reward_value1 = 10,    --奖励类型值1-int 
  reward_size1 = 11,    --奖励数量1-int 
  reward_type2 = 12,    --奖励类型2-int 
  reward_value2 = 13,    --奖励类型值2-int 
  reward_size2 = 14,    --奖励数量2-int 
  reward_type3 = 15,    --奖励类型3-int 
  reward_value3 = 16,    --奖励类型值3-int 
  reward_size3 = 17,    --奖励数量3-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  pre_id = "int",    --前置任务-2 
  name = "string",    --任务名称-3 
  tab = "int",    --所属页签-4 
  order = "int",    --排序-5 
  condition = "int",    --完成条件-6 
  require_value1 = "int",    --条件参数-7 
  require_value2 = "int",    --条件参数-8 
  reward_type1 = "int",    --奖励类型1-9 
  reward_value1 = "int",    --奖励类型值1-10 
  reward_size1 = "int",    --奖励数量1-11 
  reward_type2 = "int",    --奖励类型2-12 
  reward_value2 = "int",    --奖励类型值2-13 
  reward_size2 = "int",    --奖励数量2-14 
  reward_type3 = "int",    --奖励类型3-15 
  reward_value3 = "int",    --奖励类型值3-16 
  reward_size3 = "int",    --奖励数量3-17 

}


-- data
local friend_invite = {
    version =  1,
    _data = {
        [1] = {1,0,"邀请1名玩家",1,1,101,1,0,5,1,200,6,7,4,0,0,0,},
        [2] = {2,1,"邀请2名玩家",1,1,101,2,0,5,1,300,6,7,6,0,0,0,},
        [3] = {3,2,"邀请3名玩家",1,1,101,3,0,5,1,500,6,112,1,0,0,0,},
        [4] = {4,0,"邀请1名玩家达到35级",1,2,102,1,35,5,1,300,6,20,10,6,21,10,},
        [5] = {5,4,"邀请2名玩家达到35级",1,2,102,2,35,5,1,500,6,19,1000,0,0,0,},
        [6] = {6,5,"邀请3名玩家达到35级",1,2,102,3,35,5,1,800,6,10,200,0,0,0,},
        [7] = {7,0,"邀请的1名玩家达到500万战力",1,3,103,1,5000000,5,1,500,6,3,1000,0,0,0,},
        [8] = {8,7,"邀请的2名玩家达到500万战力",1,3,103,2,5000000,5,1,800,6,107,1,17,1001,1,},
        [9] = {9,8,"邀请的3名玩家达到500万战力",1,3,103,3,5000000,5,1,1000,6,119,1,0,0,0,},
        [10] = {10,0,"成功被他人邀请",2,1,201,1,0,5,1,200,5,2,200000,0,0,0,},
        [11] = {11,0,"累计登陆1天",2,2,202,1,0,5,1,100,6,63,20,0,0,0,},
        [12] = {12,0,"累计登陆2天",2,3,202,2,0,5,1,300,6,73,20,0,0,0,},
        [13] = {13,0,"累计登陆3天",2,4,202,3,0,5,1,500,6,80,2,0,0,0,},
        [14] = {14,0,"等级达到20级",2,5,203,20,0,5,1,200,5,2,300000,0,0,0,},
        [15] = {15,0,"等级达到30级",2,6,203,30,0,5,1,500,6,3,500,0,0,0,},
        [16] = {16,0,"等级达到50级",2,7,203,50,0,5,1,800,6,109,1,0,0,0,},
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
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in friend_invite")
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
function friend_invite.length()
    return #friend_invite._data
end

-- 
function friend_invite.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function friend_invite.isVersionValid(v)
    if friend_invite.version then
        if v then
            return friend_invite.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function friend_invite.indexOf(index)
    if index == nil or not friend_invite._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/friend_invite.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/friend_invite.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/friend_invite.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "friend_invite" )
                _isDataExist = friend_invite.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "friend_invite" )
                _isBaseExist = friend_invite.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "friend_invite" )
                _isExist = friend_invite.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "friend_invite" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "friend_invite" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = friend_invite._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "friend_invite" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function friend_invite.get(id)
    
    return friend_invite.indexOf(__index_id[id])
        
end

--
function friend_invite.set(id, key, value)
    local record = friend_invite.get(id)
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
function friend_invite.index()
    return __index_id
end

return friend_invite