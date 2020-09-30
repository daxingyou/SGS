--act_week_discount

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  name = 2,    --礼包名称-string 
  vip = 3,    --vip条件-int 
  price_show = 4,    --原价-int 
  price = 5,    --元宝价格-int 
  type = 6,    --物品类型-int 
  value = 7,    --类型值-int 
  size = 8,    --数量-int 
  time = 9,    --次数-int 
  vip_show = 10,    --VIP显示条件-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  name = "string",    --礼包名称-2 
  vip = "int",    --vip条件-3 
  price_show = "int",    --原价-4 
  price = "int",    --元宝价格-5 
  type = "int",    --物品类型-6 
  value = "int",    --类型值-7 
  size = "int",    --数量-8 
  time = "int",    --次数-9 
  vip_show = "int",    --VIP显示条件-10 

}


-- data
local act_week_discount = {
    version =  1,
    _data = {
        [1] = {1,"体力丹",0,125,50,6,1,5,1,0,},
        [2] = {2,"精力丹",0,125,50,6,2,5,1,0,},
        [3] = {3,"突破丹",1,200,80,6,3,200,1,0,},
        [4] = {4,"宝物之魂",2,500,200,5,17,5000,1,0,},
        [5] = {5,"十年杜康",3,600,240,6,63,30,1,0,},
        [6] = {6,"将魂",4,1000,400,5,9,1000,1,0,},
        [7] = {7,"高级精炼石",5,1250,500,6,13,50,1,0,},
        [8] = {8,"神兵进阶石",6,500,200,6,19,500,1,0,},
        [9] = {9,"橙色万能神兵",7,1000,400,6,80,2,1,0,},
        [10] = {10,"金砚台",8,2000,800,6,73,80,1,0,},
        [11] = {11,"宝物精炼石",9,2000,800,6,10,200,1,0,},
        [12] = {12,"体力丹",0,125,50,6,1,5,1,0,},
        [13] = {13,"精力丹",0,125,50,6,2,5,1,0,},
        [14] = {14,"突破丹",1,200,80,6,3,200,1,0,},
        [15] = {15,"宝物之魂",2,500,200,5,17,5000,1,0,},
        [16] = {16,"十年杜康",3,600,240,6,63,30,1,0,},
        [17] = {17,"将魂",4,1000,400,5,9,1000,1,0,},
        [18] = {18,"高级精炼石",5,1250,500,6,13,50,1,0,},
        [19] = {19,"神兵进阶石",6,500,200,6,19,500,1,0,},
        [20] = {20,"橙色万能神兵",7,1000,400,6,80,2,1,0,},
        [21] = {21,"宝物精炼石",8,2000,800,6,10,200,1,0,},
        [22] = {22,"高级精炼石",9,2000,800,6,13,80,1,0,},
        [23] = {23,"高级精炼石",10,2500,1000,6,13,100,1,9,},
        [24] = {24,"橙色万能神兵",11,2000,800,6,80,4,1,9,},
        [25] = {25,"红色万能神兵",12,2000,1000,6,81,2,1,9,},
        [26] = {26,"金砚台",10,2000,800,6,73,80,1,9,},
        [27] = {27,"橙色万能神兵",11,2000,800,6,80,4,1,9,},
        [28] = {28,"红色万能神兵",12,2000,1000,6,81,2,1,9,},
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
    [21] = 21,
    [22] = 22,
    [23] = 23,
    [24] = 24,
    [25] = 25,
    [26] = 26,
    [27] = 27,
    [28] = 28,
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
    [21] = 21,
    [22] = 22,
    [23] = 23,
    [24] = 24,
    [25] = 25,
    [26] = 26,
    [27] = 27,
    [28] = 28,
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
        assert(key_map[k], "cannot find " .. k .. " in act_week_discount")
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
function act_week_discount.length()
    return #act_week_discount._data
end

-- 
function act_week_discount.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function act_week_discount.isVersionValid(v)
    if act_week_discount.version then
        if v then
            return act_week_discount.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function act_week_discount.indexOf(index)
    if index == nil or not act_week_discount._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/act_week_discount.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/act_week_discount.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/act_week_discount.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "act_week_discount" )
                _isDataExist = act_week_discount.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "act_week_discount" )
                _isBaseExist = act_week_discount.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "act_week_discount" )
                _isExist = act_week_discount.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "act_week_discount" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "act_week_discount" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = act_week_discount._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "act_week_discount" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function act_week_discount.get(id)
    
    return act_week_discount.indexOf(__index_id[id])
        
end

--
function act_week_discount.set(id, key, value)
    local record = act_week_discount.get(id)
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
function act_week_discount.index()
    return __index_id
end

return act_week_discount