--mine_output

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  templet_id = 2,    --模板id-int 
  population = 3,    --人数-int 
  state = 4,    --状态-int 
  description = 5,    --状态描述-string 
  icon = 6,    --状态图片-string 
  output = 7,    --产量-int 
  output_change = 8,    --产量变化-int 
  output_show = 9,    --显示产量-string 
  proportion = 10,    --比例-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  templet_id = "int",    --模板id-2 
  population = "int",    --人数-3 
  state = "int",    --状态-4 
  description = "string",    --状态描述-5 
  icon = "string",    --状态图片-6 
  output = "int",    --产量-7 
  output_change = "int",    --产量变化-8 
  output_show = "string",    --显示产量-9 
  proportion = "int",    --比例-10 

}


-- data
local mine_output = {
    version =  1,
    _data = {
        [1] = {1,0,20,0,"正常","img_mine_quantity01",0,1000,"",1000,},
        [2] = {2,0,30,0,"正常","img_mine_quantity01",0,1000,"",1000,},
        [3] = {3,0,40,0,"正常","img_mine_quantity01",0,1000,"",1000,},
        [4] = {4,0,50,0,"正常","img_mine_quantity01",0,1000,"",1000,},
        [5] = {5,0,99999,0,"正常","img_mine_quantity01",0,1000,"",1000,},
        [6] = {6,1,20,0,"正常","img_mine_quantity01",695,1000,"600/天",1000,},
        [7] = {7,1,30,1,"拥挤","img_mine_quantity03",695,800,"480/天",1000,},
        [8] = {8,1,40,2,"爆满","img_mine_quantity04",695,600,"360/天",1000,},
        [9] = {9,1,50,2,"爆满","img_mine_quantity04",695,600,"360/天",1000,},
        [10] = {10,1,99999,2,"爆满","img_mine_quantity04",695,600,"360/天",1000,},
        [11] = {11,2,20,0,"正常","img_mine_quantity01",463,1000,"400/天",1000,},
        [12] = {12,2,30,1,"拥挤","img_mine_quantity03",463,800,"320/天",1000,},
        [13] = {13,2,40,2,"爆满","img_mine_quantity04",463,600,"240/天",1000,},
        [14] = {14,2,50,2,"爆满","img_mine_quantity04",463,600,"240/天",1000,},
        [15] = {15,2,99999,2,"爆满","img_mine_quantity04",463,600,"240/天",1000,},
        [16] = {16,3,20,0,"正常","img_mine_quantity01",232,1000,"200/天",1000,},
        [17] = {17,3,30,1,"拥挤","img_mine_quantity03",232,800,"160/天",1000,},
        [18] = {18,3,40,2,"爆满","img_mine_quantity04",232,600,"120/天",1000,},
        [19] = {19,3,50,2,"爆满","img_mine_quantity04",232,600,"120/天",1000,},
        [20] = {20,3,99999,2,"爆满","img_mine_quantity04",232,600,"120/天",1000,},
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

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in mine_output")
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
function mine_output.length()
    return #mine_output._data
end

-- 
function mine_output.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function mine_output.isVersionValid(v)
    if mine_output.version then
        if v then
            return mine_output.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function mine_output.indexOf(index)
    if index == nil or not mine_output._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/mine_output.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/mine_output.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/mine_output.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "mine_output" )
                _isDataExist = mine_output.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "mine_output" )
                _isBaseExist = mine_output.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "mine_output" )
                _isExist = mine_output.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "mine_output" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "mine_output" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = mine_output._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "mine_output" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function mine_output.get(id)
    
    return mine_output.indexOf(__index_id[id])
        
end

--
function mine_output.set(id, key, value)
    local record = mine_output.get(id)
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
function mine_output.index()
    return __index_id
end

return mine_output