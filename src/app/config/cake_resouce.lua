--cake_resouce

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  type = 1,    --活动类型-int 
  type_name = 2,    --盛宴吃的啥-string 
  icon = 3,    --活动icon-string 
  icon_word = 4,    --活动icon文字-string 
  effect_a = 5,    --前特效-string 
  xy_1 = 6,    --前坐标-string 
  effect_b = 7,    --后特效-string 
  xy_2 = 8,    --后坐标-string 
  gain_icon = 9,    --获取材料icon-string 
  gain_icon_word = 10,    --获取材料icon文字-string 
  cake_map1 = 11,    --本服场景-int 
  cake_map2 = 12,    --跨服场景-int 
  gift1_item_id = 13,    --礼物1ID-int 
  gift1_resouce = 14,    --礼物1资源-string 
  gift1_time = 15,    --礼物1持久度/s-int 
  gift1_moving = 16,    --礼物1动画-string 
  gift1_point = 17,    --礼物1积分功绩-int 
  gift1_max1 = 18,    --礼物1本服每天限制-int 
  gift1_max2 = 19,    --礼物1跨服每天限制-int 
  gift2_item_id = 20,    --礼物2ID-int 
  gift2_resouce = 21,    --礼物2资源-string 
  gift2_time = 22,    --礼物2持久度/s-int 
  gift2_moving = 23,    --礼物2动画-string 
  gift2_point = 24,    --礼物2积分功绩-int 
  gift2_max1 = 25,    --礼物2本服每天限制-int 
  gift2_max2 = 26,    --礼物2跨服每天限制-int 
  gift3_item_id = 27,    --礼物3ID-int 
  gift3_resouce = 28,    --礼物3资源-string 
  gift3_time = 29,    --礼物3持久度/s-int 
  gift3_moving = 30,    --礼物3动画-string 
  gift3_point = 31,    --礼物3积分功绩-int 
  gift3_max1 = 32,    --礼物3本服每天限制-int 
  gift3_max2 = 33,    --礼物3跨服每天限制-int 
  cake_name1 = 34,    --页签一名称-string 
  cake_name2 = 35,    --页签二名称-string 

}

-- key type
local __key_type = {
  type = "int",    --活动类型-1 
  type_name = "string",    --盛宴吃的啥-2 
  icon = "string",    --活动icon-3 
  icon_word = "string",    --活动icon文字-4 
  effect_a = "string",    --前特效-5 
  xy_1 = "string",    --前坐标-6 
  effect_b = "string",    --后特效-7 
  xy_2 = "string",    --后坐标-8 
  gain_icon = "string",    --获取材料icon-9 
  gain_icon_word = "string",    --获取材料icon文字-10 
  cake_map1 = "int",    --本服场景-11 
  cake_map2 = "int",    --跨服场景-12 
  gift1_item_id = "int",    --礼物1ID-13 
  gift1_resouce = "string",    --礼物1资源-14 
  gift1_time = "int",    --礼物1持久度/s-15 
  gift1_moving = "string",    --礼物1动画-16 
  gift1_point = "int",    --礼物1积分功绩-17 
  gift1_max1 = "int",    --礼物1本服每天限制-18 
  gift1_max2 = "int",    --礼物1跨服每天限制-19 
  gift2_item_id = "int",    --礼物2ID-20 
  gift2_resouce = "string",    --礼物2资源-21 
  gift2_time = "int",    --礼物2持久度/s-22 
  gift2_moving = "string",    --礼物2动画-23 
  gift2_point = "int",    --礼物2积分功绩-24 
  gift2_max1 = "int",    --礼物2本服每天限制-25 
  gift2_max2 = "int",    --礼物2跨服每天限制-26 
  gift3_item_id = "int",    --礼物3ID-27 
  gift3_resouce = "string",    --礼物3资源-28 
  gift3_time = "int",    --礼物3持久度/s-29 
  gift3_moving = "string",    --礼物3动画-30 
  gift3_point = "int",    --礼物3积分功绩-31 
  gift3_max1 = "int",    --礼物3本服每天限制-32 
  gift3_max2 = "int",    --礼物3跨服每天限制-33 
  cake_name1 = "string",    --页签一名称-34 
  cake_name2 = "string",    --页签二名称-35 

}


-- data
local cake_resouce = {
    version =  1,
    _data = {
        [1] = {1,"蛋糕","btn_main_enter3_dangao","txt_main_enter3_zhounianqing","effect_youxiangtishi","0|4","effect_youxiangtishi_b","0|4","btn_main_enter6_cailiao","txt_main_enter6_cailiaohuoqu",2003,2004,570,"img_prop_egg",2,"effect_dangao_jidan",3,13600,40800,571,"img_prop_cream",3,"effect_dangao_naiyou",10,0,0,572,"img_prop_fruits",5,"effect_dangao_shuiguo",100,0,0,"获取鸡蛋","获取奶油",},
        [2] = {2,"火锅","btn_main_enter2_taotieshengyan","txt_main_enter3_zhounianqing","effect_ui_huoguo","0|0","effect_youxiangtishi_b","0|4","btn_main_enter6_cailiao2","txt_main_enter6_cailiaohuoqu2",2007,2008,573,"img_prop_mushrooms",2,"effect_dangao_xianggu",3,13600,40800,574,"img_prop_beef",3,"effect_dangao_niurou",10,0,0,575,"img_prop_seafood",5,"effect_dangao_haixian",100,0,0,"获取香菇","获取肥牛",},
        [3] = {3,"烧烤","btn_main_enter2_taotiekaorou","txt_main_enter3_zhounianqing","effect_ui_huoguo","0|0","effect_youxiangtishi_b","0|4","btn_main_enter6_cailiao3","txt_main_enter6_cailiaohuoqu3",2009,2010,576,"img_prop_vegetable",2,"effect_dangao_vegetable",3,13600,40800,577,"img_prop_meat",3,"effect_dangao_meat",10,0,0,578,"img_prop_lamb",5,"effect_dangao_lamb",100,0,0,"获取蔬菜","获取牛肉",},
        [4] = {4,"年夜饭","btn_main_enter2_taotieshengyan03","txt_main_enter3_zhounianqing","effect_ui_huoguo","0|0","effect_youxiangtishi_b","0|4","btn_main_enter6_cailiao4","txt_main_enter6_homeland_shengcaiyouji",2012,2013,579,"img_prop_tofu",2,"effect_nianyefan_doufu",3,13600,40800,580,"img_prop_chicken",3,"effect_nianyefan_chicken",10,0,0,581,"img_prop_fish",5,"effect_nianyefan_fish",100,0,0,"富贵富足","生财有计",},
    }
}

-- index
local __index_type = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in cake_resouce")
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
function cake_resouce.length()
    return #cake_resouce._data
end

-- 
function cake_resouce.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cake_resouce.isVersionValid(v)
    if cake_resouce.version then
        if v then
            return cake_resouce.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function cake_resouce.indexOf(index)
    if index == nil or not cake_resouce._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/cake_resouce.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/cake_resouce.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/cake_resouce.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "cake_resouce" )
                _isDataExist = cake_resouce.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "cake_resouce" )
                _isBaseExist = cake_resouce.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "cake_resouce" )
                _isExist = cake_resouce.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "cake_resouce" )
        local main_key = __main_key_map[index]
		local index_key = "__index_type"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cake_resouce" )
        local main_key = __main_key_map[index]
		local index_key = "__index_type"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = cake_resouce._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "cake_resouce" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function cake_resouce.get(type)
    
    return cake_resouce.indexOf(__index_type[type])
        
end

--
function cake_resouce.set(type, key, value)
    local record = cake_resouce.get(type)
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
function cake_resouce.index()
    return __index_type
end

return cake_resouce