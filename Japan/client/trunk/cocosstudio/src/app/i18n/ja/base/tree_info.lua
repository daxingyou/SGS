--tree_info

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  name = 2,    --主树名称-string 
  experience = 3,    --升级所需经验值-int 
  output_type = 4,    --资源产出类型-int 
  output_efficiency = 5,    --每天产出总值-int 
  adorn_type_1 = 6,    --限制装饰类型1-int 
  adorn_level_1 = 7,    --限制装饰等级1-int 
  adorn_type_2 = 8,    --限制装饰类型2-int 
  adorn_level_2 = 9,    --限制装饰等级2-int 
  type = 10,    --消耗类型-int 
  value = 11,    --消耗类型值-int 
  size = 12,    --消耗数量-int 
  attribute_type = 13,    --属性类型-int 
  attribute_percentage = 14,    --属性类型值-int 
  attribute_type1 = 15,    --属性1类型-int 
  attribute_value1 = 16,    --属性1类型值-int 
  attribute_type2 = 17,    --属性2类型-int 
  attribute_value2 = 18,    --属性2类型值-int 
  attribute_type3 = 19,    --属性3类型-int 
  attribute_value3 = 20,    --属性3类型值-int 
  attribute_type4 = 21,    --属性4类型-int 
  attribute_value4 = 22,    --属性4类型值-int 
  all_combat = 23,    --总战力-int 
  spine_res = 24,    --主界面资源图-string 
  animation_name = 25,    --主界面动画资源-string 
  moving_name = 26,    --主界面动画资源-string 
  up_loop_effect = 27,    --每级spine特效-string 
  up_resource = 28,    --升级界面资源图-string 
  up_text = 29,    --升级提示文本-string 
  up_text_1 = 30,    --升级界面提示文本-string 
  spine_x = 31,    --spine坐标x-int 
  spine_y = 32,    --spine坐标y-int 
  height = 33,    --点击区域高-int 
  width = 34,    --点击区域宽-int 
  click_x = 35,    --点击区域坐标x-int 
  click_y = 36,    --点击区域左边y-int 
  title_x = 37,    --ui标题坐标x-int 
  title_y = 38,    --ui标题坐标y-int 
  order = 39,    --层级排序-int 
  up_effect = 40,    --升级特效-string 
  icon_x = 41,    --icon坐标x-int 
  icon_y = 42,    --icon坐标y-int 
  prayer_times = 43,    --每日祈福次数-int 
  prayer_color = 44,    --祈福获得最高品质-int 
  prayer_cost_type = 45,    --祈福消耗道具类型-int 
  prayer_cost_value = 46,    --祈福消耗道具id-int 
  prayer_cost_size = 47,    --祈福消耗数量-int 
  breaktext = 48,    --突破预览文本-string 
  breaktext_level = 49,    --突破预览文本展示等级-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  name = "string",    --主树名称-2 
  experience = "int",    --升级所需经验值-3 
  output_type = "int",    --资源产出类型-4 
  output_efficiency = "int",    --每天产出总值-5 
  adorn_type_1 = "int",    --限制装饰类型1-6 
  adorn_level_1 = "int",    --限制装饰等级1-7 
  adorn_type_2 = "int",    --限制装饰类型2-8 
  adorn_level_2 = "int",    --限制装饰等级2-9 
  type = "int",    --消耗类型-10 
  value = "int",    --消耗类型值-11 
  size = "int",    --消耗数量-12 
  attribute_type = "int",    --属性类型-13 
  attribute_percentage = "int",    --属性类型值-14 
  attribute_type1 = "int",    --属性1类型-15 
  attribute_value1 = "int",    --属性1类型值-16 
  attribute_type2 = "int",    --属性2类型-17 
  attribute_value2 = "int",    --属性2类型值-18 
  attribute_type3 = "int",    --属性3类型-19 
  attribute_value3 = "int",    --属性3类型值-20 
  attribute_type4 = "int",    --属性4类型-21 
  attribute_value4 = "int",    --属性4类型值-22 
  all_combat = "int",    --总战力-23 
  spine_res = "string",    --主界面资源图-24 
  animation_name = "string",    --主界面动画资源-25 
  moving_name = "string",    --主界面动画资源-26 
  up_loop_effect = "string",    --每级spine特效-27 
  up_resource = "string",    --升级界面资源图-28 
  up_text = "string",    --升级提示文本-29 
  up_text_1 = "string",    --升级界面提示文本-30 
  spine_x = "int",    --spine坐标x-31 
  spine_y = "int",    --spine坐标y-32 
  height = "int",    --点击区域高-33 
  width = "int",    --点击区域宽-34 
  click_x = "int",    --点击区域坐标x-35 
  click_y = "int",    --点击区域左边y-36 
  title_x = "int",    --ui标题坐标x-37 
  title_y = "int",    --ui标题坐标y-38 
  order = "int",    --层级排序-39 
  up_effect = "string",    --升级特效-40 
  icon_x = "int",    --icon坐标x-41 
  icon_y = "int",    --icon坐标y-42 
  prayer_times = "int",    --每日祈福次数-43 
  prayer_color = "int",    --祈福获得最高品质-44 
  prayer_cost_type = "int",    --祈福消耗道具类型-45 
  prayer_cost_value = "int",    --祈福消耗道具id-46 
  prayer_cost_size = "int",    --祈福消耗数量-47 
  breaktext = "string",    --突破预览文本-48 
  breaktext_level = "int",    --突破预览文本展示等级-49 

}


-- data
local tree_info = {
    version =  1,
    _data = {
        [1] = {1,"神树",0,112,0,0,0,0,0,5,1,0,111,0,1,0,5,0,6,0,7,0,0,"shenshushu","effect1","","","img_homeland_tree01","露坛","突破解锁新的装饰：露坛",0,-98,289,289,8,62,-121,141,5,"effect_shenshu_shushengji",40,80,0,5,5,2,200000,"",70,},
        [2] = {2,"神树",0,112,1800,0,0,0,0,5,1,1800,111,4,1,200,5,100,6,100,7,1500,72000,"shenshushu","effect2","","","img_homeland_tree02","赤灵芝","突破解锁新的装饰：赤灵芝",0,-98,348,304,15,82,-121,200,5,"effect_shenshu_shushengji",62,163,0,5,5,2,200000,"",70,},
        [3] = {3,"神树",0,112,200,1,2,0,0,5,1,2700,111,8,1,300,5,150,6,150,7,2250,108000,"shenshushu","effect2","","effect_shenshugaojie_shu","img_homeland_tree02","翠竹林","突破解锁新的装饰：翠竹林",0,-98,348,304,15,82,-121,200,5,"effect_shenshu_shushengji",62,163,0,5,5,2,200000,"",70,},
        [4] = {4,"神树",0,112,200,1,3,0,0,5,1,4500,111,12,1,500,5,250,6,250,7,3750,180000,"shenshushu","effect3","","","img_homeland_tree03","九天瑶池","突破后每日可祈福神树3次\n突破解锁新的装饰：九天瑶池",0,-98,369,323,7,92,-121,200,5,"effect_shenshu_shushengji",118,245,0,5,5,2,200000,"",70,},
        [5] = {5,"神树",0,112,200,1,4,0,0,5,1,5400,111,16,1,800,5,400,6,400,7,6000,270000,"shenshushu","effect3","","effect_shenshugaojie_shu","img_homeland_tree03","玲珑玉玦","突破解锁新的装饰：玲珑玉玦",0,-98,369,323,7,92,-121,200,5,"effect_shenshu_shushengji",118,245,3,5,5,2,200000,"（每日可祈福3次）",999,},
        [6] = {6,"神树",0,112,200,1,5,5,3,5,1,9000,111,20,1,900,5,450,6,450,7,6750,320000,"shenshushu","effect4","","","img_homeland_tree04","九华灯","突破后每日可祈福神树5次\n突破解锁新的装饰：九华灯",0,-98,369,323,7,92,-121,200,5,"effect_shenshu_shushengji",190,300,3,5,5,2,200000,"（120级可在商店购买卧龙观星盘）",999,},
        [7] = {7,"神树",0,112,200,1,6,5,5,5,1,10800,111,24,1,1400,5,700,6,700,7,10500,520000,"shenshushu","effect4","","effect_shenshugaojie_shu","img_homeland_tree04","","",0,-98,369,323,7,92,-121,200,5,"effect_shenshu_shushengji",190,300,5,5,5,2,200000,"（每日可祈福5次）",999,},
        [8] = {8,"神树",0,112,200,1,7,5,7,5,1,18000,111,28,1,1800,5,900,6,900,7,13500,640000,"shenshushu","effect5","","","img_homeland_tree05","","",0,-98,423,336,7,120,-121,260,5,"effect_shenshu_shushengji",190,300,5,5,5,2,200000,"",70,},
        [9] = {9,"神树",0,112,200,1,8,5,8,5,1,22500,111,32,1,3000,5,1500,6,1500,7,22500,1080000,"shenshushu","effect5","","effect_shenshugaojie_shu","img_homeland_tree05","","",0,-98,423,336,7,120,-121,260,5,"effect_shenshu_shushengji",190,300,5,5,5,2,200000,"",70,},
        [10] = {10,"神树",0,112,200,1,9,5,9,5,1,36000,111,36,1,3500,5,1750,6,1750,7,26250,1250000,"shenshushu","effect6","","","img_homeland_tree06","","",0,-98,423,336,7,120,-121,260,5,"effect_shenshu_shushengji",190,300,5,5,5,2,200000,"",70,},
        [11] = {11,"神树",0,112,200,1,10,5,10,5,1,40000,111,40,1,5800,5,2900,6,2900,7,43500,2100000,"shenshushu","effect6","","effect_shenshugaojie_shu","img_homeland_tree06","","",0,-98,423,336,7,120,-121,260,5,"effect_shenshu_shushengji",190,300,5,5,5,2,200000,"",70,},
        [12] = {12,"神树",0,112,200,1,11,5,11,5,1,57000,111,44,1,6400,5,3200,6,3200,7,48000,2400000,"shenshushu","","moving_shenshushu_1112","","img_homeland_tree07","","",0,-98,423,336,7,120,-121,260,5,"effect_shenshu_shushengji",190,300,5,5,5,2,200000,"",70,},
        [13] = {13,"神树",0,112,200,1,12,5,12,5,1,0,111,48,1,8000,5,4000,6,4000,7,60000,3440000,"shenshushu","","moving_shenshushu_1112","effect_shenshugaojie_shu","img_homeland_tree07","","",0,-98,423,336,7,120,-121,260,5,"effect_shenshu_shushengji",190,300,5,5,5,2,200000,"",70,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
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
        assert(key_map[k], "cannot find " .. k .. " in tree_info")
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
function tree_info.length()
    return #tree_info._data
end

-- 
function tree_info.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function tree_info.isVersionValid(v)
    if tree_info.version then
        if v then
            return tree_info.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function tree_info.indexOf(index)
    if index == nil or not tree_info._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/tree_info.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/tree_info.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/tree_info.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "tree_info" )
                _isDataExist = tree_info.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "tree_info" )
                _isBaseExist = tree_info.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "tree_info" )
                _isExist = tree_info.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "tree_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "tree_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = tree_info._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "tree_info" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function tree_info.get(id)
    
    return tree_info.indexOf(__index_id[id])
        
end

--
function tree_info.set(id, key, value)
    local record = tree_info.get(id)
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
function tree_info.index()
    return __index_id
end

return tree_info