--equipment_active

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  money = 2,    --充值额度-int 
  money_type = 3,    --充值给予奖励类型-int 
  money_value = 4,    --充值给予奖励类型值-int 
  money_size = 5,    --充值给予奖励数量-int 
  toplimit = 6,    --每日充值获得次数上限-int 
  name1 = 7,    --抽奖名称1-string 
  day_free1 = 8,    --每日免费次数1-int 
  consume_time1 = 9,    --每次消耗次数1-int 
  name2 = 10,    --抽奖名称2-string 
  hit_num = 11,    --追击次数-int 
  consume_time2 = 12,    --每次消耗次数2-int 
  drop = 13,    --掉落库-string 
  fragment = 14,    --碎片ID-string 
  back_name = 15,    --背景星星资源名-string 
  pic_name = 16,    --背景图资源名-string 
  title_name = 17,    --活动标题资源名-string 
  time_name = 18,    --倒计时描述-string 
  hit_chat_1 = 19,    --被击喊话1-string 
  hit_chat_2 = 20,    --被击喊话2-string 
  hit_chat_3 = 21,    --被击喊话3-string 
  hit_chat_4 = 22,    --被击喊话4-string 
  hit_chat_5 = 23,    --被击喊话5-string 
  chat_1 = 24,    --常规喊话1-string 
  chat_2 = 25,    --常规喊话2-string 
  chat_3 = 26,    --常规喊话3-string 
  chat_4 = 27,    --常规喊话4-string 
  chat_5 = 28,    --常规喊话5-string 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  money = "int",    --充值额度-2 
  money_type = "int",    --充值给予奖励类型-3 
  money_value = "int",    --充值给予奖励类型值-4 
  money_size = "int",    --充值给予奖励数量-5 
  toplimit = "int",    --每日充值获得次数上限-6 
  name1 = "string",    --抽奖名称1-7 
  day_free1 = "int",    --每日免费次数1-8 
  consume_time1 = "int",    --每次消耗次数1-9 
  name2 = "string",    --抽奖名称2-10 
  hit_num = "int",    --追击次数-11 
  consume_time2 = "int",    --每次消耗次数2-12 
  drop = "string",    --掉落库-13 
  fragment = "string",    --碎片ID-14 
  back_name = "string",    --背景星星资源名-15 
  pic_name = "string",    --背景图资源名-16 
  title_name = "string",    --活动标题资源名-17 
  time_name = "string",    --倒计时描述-18 
  hit_chat_1 = "string",    --被击喊话1-19 
  hit_chat_2 = "string",    --被击喊话2-20 
  hit_chat_3 = "string",    --被击喊话3-21 
  hit_chat_4 = "string",    --被击喊话4-22 
  hit_chat_5 = "string",    --被击喊话5-23 
  chat_1 = "string",    --常规喊话1-24 
  chat_2 = "string",    --常规喊话2-25 
  chat_3 = "string",    --常规喊话3-26 
  chat_4 = "string",    --常规喊话4-27 
  chat_5 = "string",    --常规喊话5-28 

}


-- data
local equipment_active = {
    version =  1,
    _data = {
        [1] = {1,20,6,95,1,9999,"追击1次",5,1,"追击10次",10,1,"1001","","","","","","英雄别打我了！嘤嘤嘤~~~","英雄手下留情，我给你好东西！","痛哉！痛哉！给你！","来呀，追我呀，来啊来啊来啊。","别打了，装备都给你！","说我的战袍可换红装的定是那孙刘的阴谋！","哼！你若追得上我，红装双手奉上。","你可是名将，不要为了几件红装背叛朝廷！","何以解忧，唯有红装！","设使天下无有孤，不知当几人有红装",},
        [2] = {2,20,6,95,1,9999,"追击1次",5,1,"追击10次",10,1,"1002","","","","","","英雄别打我了！嘤嘤嘤~~~","英雄手下留情，我给你好东西！","痛哉！痛哉！给你！","来呀，追我呀，来啊来啊来啊。","别打了，装备都给你！","说我的战袍可换红装的定是那孙刘的阴谋！","哼！你若追得上我，红装双手奉上。","你可是名将，不要为了几件红装背叛朝廷！","何以解忧，唯有红装！","设使天下无有孤，不知当几人有红装",},
        [3] = {1001,20,6,94,1,0,"观星1次",5,1,"观星10次",10,1,"2001","","guanxingxing","moving_guanxing","img_activity_guanxing_title","青龙消失倒计时","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [4] = {1002,20,6,94,1,0,"观星1次",5,1,"观星10次",10,1,"2002|2001","","guanxingxuanwu|guanxingxing","moving_guanxing_xuanwu|moving_guanxing","img_activity_guanxing_title2|img_activity_guanxing_title","玄武消失倒计时|青龙消失倒计时","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [5] = {1003,20,6,94,1,0,"观星1次",5,1,"观星10次",10,1,"2002|2004|2003|2001","100008|100005|100009|100006","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title","玄武消失倒计时|白虎消失倒计时|圣鲲消失倒计时|青龙消失倒计时","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [6] = {1004,20,6,94,1,0,"观星1次",5,1,"观星10次",10,1,"2002|2007|2004|2005|2008|2003|2001|2006","100008|100011|100005|100010|100012|100009|100006|100007","guanxingxuanwu|guanxingnianshou|guanxingbaihu|guanxingqilin|guanxingbaize|guanxingkun|guanxingxing|guanxingzhuque","moving_guanxing_xuanwu|moving_guanxing_nianshou|moving_guanxing_baihu|moving_guanxing_qilin|moving_guanxing_baize|moving_guanxing_kun|moving_guanxing|moving_guanxing_zhuque","img_activity_guanxing_title2|img_activity_nianshou_title|img_activity_baihu_title|img_activity_qilin_title|img_activity_baize_title|img_activity_shengkun_title|img_activity_guanxing_title|img_activity_zhuque_title","玄武消失倒计时|年兽消失倒计时|白虎消失倒计时|麒麟消失倒计时|白泽消失倒计时|圣鲲消失倒计时|青龙消失倒计时|朱雀消失倒计时","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [7] = {1005,20,6,94,1,0,"观星1次",5,1,"观星10次",10,1,"2002|2007|2004|2005|2008|2003|2001|2006|2009","100008|100011|100005|100010|100012|100009|100006|100007|6559","guanxingxuanwu|guanxingnianshou|guanxingbaihu|guanxingqilin|guanxingbaize|guanxingkun|guanxingxing|guanxingzhuque|guanxinghong","moving_guanxing_xuanwu|moving_guanxing_nianshou|moving_guanxing_baihu|moving_guanxing_qilin|moving_guanxing_baize|moving_guanxing_kun|moving_guanxing|moving_guanxing_zhuque|moving_guanxing_hong","img_activity_guanxing_title2|img_activity_nianshou_title|img_activity_baihu_title|img_activity_qilin_title|img_activity_baize_title|img_activity_shengkun_title|img_activity_guanxing_title|img_activity_zhuque_title|img_activity_zhenyuan_title","玄武消失倒计时|年兽消失倒计时|白虎消失倒计时|麒麟消失倒计时|白泽消失倒计时|圣鲲消失倒计时|青龙消失倒计时|朱雀消失倒计时|真元消失倒计时","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [8] = {1401,20,6,159,1,0,"驯马1次",5,1,"驯马10次",10,1,"4001|4002","","","","","","","","","","","","","","","",},
        [9] = {1501,20,6,159,1,0,"驯马1次",5,1,"驯马10次",10,1,"5010|5012|5013|5014|5011|5009|5015","120010|120012|120015|120016|120011|120009|120017","","812|810|815|816|811|809|817","txt_xunma_chengma01|txt_xunma_chengma02|txt_xunma_chengma05|txt_xunma_chengma06|txt_xunma_chengma03|txt_xunma_chengma04|txt_xunma_chengma07","乌云踏雪离开倒计时|夜照玉狮离开倒计时|奔雷青骢离开倒计时|铁血红鬃离开倒计时|胭脂火龙离开倒计时|飞霜千里离开倒计时|暗夜紫骍离开倒计时","","","","","","酒且斟下，某去便来。","看尔等插标卖首","玉可碎而不可改其白，竹可焚而不可毁其节。","一骑绝尘走千里，五关斩将震坤乾。","此等小事难不倒我关某！",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [1001] = 3,
    [1002] = 4,
    [1003] = 5,
    [1004] = 6,
    [1005] = 7,
    [1401] = 8,
    [1501] = 9,
    [2] = 2,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [3] = 1001,
    [4] = 1002,
    [5] = 1003,
    [6] = 1004,
    [7] = 1005,
    [8] = 1401,
    [9] = 1501,
    [2] = 2,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in equipment_active")
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
function equipment_active.length()
    return #equipment_active._data
end

-- 
function equipment_active.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function equipment_active.isVersionValid(v)
    if equipment_active.version then
        if v then
            return equipment_active.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function equipment_active.indexOf(index)
    if index == nil or not equipment_active._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/equipment_active.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/equipment_active.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/equipment_active.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "equipment_active" )
                _isDataExist = equipment_active.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "equipment_active" )
                _isBaseExist = equipment_active.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "equipment_active" )
                _isExist = equipment_active.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "equipment_active" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "equipment_active" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = equipment_active._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "equipment_active" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function equipment_active.get(id)
    
    return equipment_active.indexOf(__index_id[id])
        
end

--
function equipment_active.set(id, key, value)
    local record = equipment_active.get(id)
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
function equipment_active.index()
    return __index_id
end

return equipment_active