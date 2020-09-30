--recommend_upgrade

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  function_level_id = 2,    --功能id-int 
  upgrade_limit = 3,    --上限参数-int 
  upgrade_percent = 4,    --预期参数1-string 
  percent_1_Lower = 5,    --预期参数1等级下限-int 
  percent_1_upper = 6,    --预期参数1等级上限-int 
  upgrade_percent_2 = 7,    --预期参数2-string 
  percent_2_Lower = 8,    --预期参数2等级下限-int 
  percent_2_upper = 9,    --预期参数2等级上限-int 
  upgrade_percent_3 = 10,    --预期参数3-string 
  percent_3_Lower = 11,    --预期参数3等级下限-int 
  percent_3_upper = 12,    --预期参数3等级上限-int 
  upgrade_level = 13,    --推荐等级-int 
  function_jump = 14,    --跳转方向-int 
  bubble_id = 15,    --提示文字id-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  function_level_id = "int",    --功能id-2 
  upgrade_limit = "int",    --上限参数-3 
  upgrade_percent = "string",    --预期参数1-4 
  percent_1_Lower = "int",    --预期参数1等级下限-5 
  percent_1_upper = "int",    --预期参数1等级上限-6 
  upgrade_percent_2 = "string",    --预期参数2-7 
  percent_2_Lower = "int",    --预期参数2等级下限-8 
  percent_2_upper = "int",    --预期参数2等级上限-9 
  upgrade_percent_3 = "string",    --预期参数3-10 
  percent_3_Lower = "int",    --预期参数3等级下限-11 
  percent_3_upper = "int",    --预期参数3等级上限-12 
  upgrade_level = "int",    --推荐等级-13 
  function_jump = "int",    --跳转方向-14 
  bubble_id = "int",    --提示文字id-15 

}


-- data
local recommend_upgrade = {
    version =  1,
    _data = {
        [1] = {0,0,0,"",0,0,"",0,0,"",0,0,0,0,2000,},
        [2] = {1,102,1000,"#LEVEL#*1",1,999,"",0,0,"",0,0,1,3,2001,},
        [3] = {2,104,1000,"(#LEVEL#+5)/10",1,999,"",0,0,"",0,0,1,3,2002,},
        [4] = {3,107,1000,"#LEVEL#-50",1,999,"",0,0,"",0,0,85,3,2003,},
        [5] = {4,112,1000,"#LEVEL#*2",1,999,"",0,0,"",0,0,1,3,2004,},
        [6] = {5,114,1000,"#LEVEL#/4",1,999,"",0,0,"",0,0,1,3,2005,},
        [7] = {6,122,1000,"#LEVEL#/2",1,107,"(#LEVEL#+40)/2",108,119,"80",120,999,1,3,2006,},
        [8] = {7,123,1000,"#LEVEL#*120/1000",1,107,"(#LEVEL#*120+5000)/1000",108,119,"25",120,999,1,3,2007,},
        [9] = {8,134,1000,"#LEVEL#/2",1,101,"#LEVEL#*10/16",102,119,"100",120,999,1,3,2008,},
    }
}

-- index
local __index_id = {
    [0] = 1,
    [1] = 2,
    [2] = 3,
    [3] = 4,
    [4] = 5,
    [5] = 6,
    [6] = 7,
    [7] = 8,
    [8] = 9,

}

-- index mainkey map
local __main_key_map = {
    [1] = 0,
    [2] = 1,
    [3] = 2,
    [4] = 3,
    [5] = 4,
    [6] = 5,
    [7] = 6,
    [8] = 7,
    [9] = 8,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in recommend_upgrade")
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
function recommend_upgrade.length()
    return #recommend_upgrade._data
end

-- 
function recommend_upgrade.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function recommend_upgrade.isVersionValid(v)
    if recommend_upgrade.version then
        if v then
            return recommend_upgrade.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function recommend_upgrade.indexOf(index)
    if index == nil or not recommend_upgrade._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/recommend_upgrade.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/recommend_upgrade.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/recommend_upgrade.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "recommend_upgrade" )
                _isDataExist = recommend_upgrade.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "recommend_upgrade" )
                _isBaseExist = recommend_upgrade.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "recommend_upgrade" )
                _isExist = recommend_upgrade.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "recommend_upgrade" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "recommend_upgrade" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = recommend_upgrade._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "recommend_upgrade" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function recommend_upgrade.get(id)
    
    return recommend_upgrade.indexOf(__index_id[id])
        
end

--
function recommend_upgrade.set(id, key, value)
    local record = recommend_upgrade.get(id)
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
function recommend_upgrade.index()
    return __index_id
end

return recommend_upgrade