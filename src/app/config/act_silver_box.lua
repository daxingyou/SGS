--act_silver_box

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  box_name = 2,    --宝箱标题-string 
  count = 3,    --领取次数-int 
  type = 4,    --类型1-int 
  value = 5,    --类型值1-int 
  size = 6,    --数量1-int 
  type_1 = 7,    --类型2-int 
  value_1 = 8,    --类型值2-int 
  size_1 = 9,    --数量2-int 
  type_2 = 10,    --类型3-int 
  value_2 = 11,    --类型值3-int 
  size_2 = 12,    --数量3-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  box_name = "string",    --宝箱标题-2 
  count = "int",    --领取次数-3 
  type = "int",    --类型1-4 
  value = "int",    --类型值1-5 
  size = "int",    --数量1-6 
  type_1 = "int",    --类型2-7 
  value_1 = "int",    --类型值2-8 
  size_1 = "int",    --数量2-9 
  type_2 = "int",    --类型3-10 
  value_2 = "int",    --类型值3-11 
  size_2 = "int",    --数量3-12 

}


-- data
local act_silver_box = {
    version =  1,
    _data = {
        [1] = {1,"10次礼包",10,5,2,20000,0,0,0,0,0,0,},
        [2] = {2,"20次礼包",20,5,2,50000,0,0,0,0,0,0,},
        [3] = {3,"30次礼包",30,5,2,80000,0,0,0,0,0,0,},
        [4] = {4,"40次礼包",40,5,2,100000,0,0,0,0,0,0,},
        [5] = {5,"50次礼包",50,5,2,120000,0,0,0,0,0,0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in act_silver_box")
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
function act_silver_box.length()
    return #act_silver_box._data
end

-- 
function act_silver_box.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function act_silver_box.isVersionValid(v)
    if act_silver_box.version then
        if v then
            return act_silver_box.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function act_silver_box.indexOf(index)
    if index == nil or not act_silver_box._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/act_silver_box.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/act_silver_box.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/act_silver_box.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "act_silver_box" )
                _isDataExist = act_silver_box.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "act_silver_box" )
                _isBaseExist = act_silver_box.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "act_silver_box" )
                _isExist = act_silver_box.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "act_silver_box" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "act_silver_box" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = act_silver_box._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "act_silver_box" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function act_silver_box.get(id)
    
    return act_silver_box.indexOf(__index_id[id])
        
end

--
function act_silver_box.set(id, key, value)
    local record = act_silver_box.get(id)
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
function act_silver_box.index()
    return __index_id
end

return act_silver_box