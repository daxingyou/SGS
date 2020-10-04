--boss_content

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  text_type = 2,    --类型-int 
  text = 3,    --相关文本-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  text_type = "int",    --类型-2 
  text = "string",    --相关文本-3 

}


-- data
local boss_content = {
    version =  1,
    _data = {
        [1] = {1,0,"主公，本次挑战军团BOSS，你所在军团参与人数#number#人，军团积分排名第#rank#名，获得军团声望#prestige#，奖励已发放到拍卖及邮件。",},
        [2] = {2,0,"主公，本次挑战军团BOSS，你个人积分排名第#rank#名，奖励已发放到邮件（加入军团可获得更多奖励哟！）",},
        [3] = {3,1,"#name1#成功夺走#name2##integral#积分",},
        [4] = {4,1,"#name1#被#name2#抢走#integral#积分",},
        [5] = {5,1,"#name1#挑战世界Boss获得#integral#积分",},
        [6] = {6,2,"被#name#夺走#integral#积分",},
        [7] = {7,2,"本次挑战世界Boss获得#integral#积分",},
        [8] = {8,2,"成功抢夺#name##integral#积分",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in boss_content")
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
function boss_content.length()
    return #boss_content._data
end

-- 
function boss_content.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function boss_content.isVersionValid(v)
    if boss_content.version then
        if v then
            return boss_content.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function boss_content.indexOf(index)
    if index == nil or not boss_content._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/boss_content.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/boss_content.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/boss_content.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "boss_content" )
                _isDataExist = boss_content.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "boss_content" )
                _isBaseExist = boss_content.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "boss_content" )
                _isExist = boss_content.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "boss_content" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "boss_content" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = boss_content._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "boss_content" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function boss_content.get(id)
    
    return boss_content.indexOf(__index_id[id])
        
end

--
function boss_content.set(id, key, value)
    local record = boss_content.get(id)
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
function boss_content.index()
    return __index_id
end

return boss_content