--equipment_active

local _lang = "cn"
local _isExist = false

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
  back_name = 14,    --背景星星资源名-string 
  pic_name = 15,    --背景图资源名-string 
  title_name = 16,    --活动标题资源名-string 
  time_name = 17,    --倒计时描述-string 
  hit_chat_1 = 18,    --被击喊话1-string 
  hit_chat_2 = 19,    --被击喊话2-string 
  hit_chat_3 = 20,    --被击喊话3-string 
  hit_chat_4 = 21,    --被击喊话4-string 
  hit_chat_5 = 22,    --被击喊话5-string 
  chat_1 = 23,    --常规喊话1-string 
  chat_2 = 24,    --常规喊话2-string 
  chat_3 = 25,    --常规喊话3-string 
  chat_4 = 26,    --常规喊话4-string 
  chat_5 = 27,    --常规喊话5-string 

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
  back_name = "string",    --背景星星资源名-14 
  pic_name = "string",    --背景图资源名-15 
  title_name = "string",    --活动标题资源名-16 
  time_name = "string",    --倒计时描述-17 
  hit_chat_1 = "string",    --被击喊话1-18 
  hit_chat_2 = "string",    --被击喊话2-19 
  hit_chat_3 = "string",    --被击喊话3-20 
  hit_chat_4 = "string",    --被击喊话4-21 
  hit_chat_5 = "string",    --被击喊话5-22 
  chat_1 = "string",    --常规喊话1-23 
  chat_2 = "string",    --常规喊话2-24 
  chat_3 = "string",    --常规喊话3-25 
  chat_4 = "string",    --常规喊话4-26 
  chat_5 = "string",    --常规喊话5-27 

}


-- data
local equipment_active = {
    _data = {
        [1] = {1,20,6,95,1,9999,"追击1次",5,1,"追击10次",10,1,"1001","","","","","英雄别打我了！嘤嘤嘤~~~","英雄手下留情，我给你好东西！","痛哉！痛哉！给你！","来呀，追我呀，来啊来啊来啊。","别打了，装备都给你！","说我的战袍可换红装的定是那孙刘的阴谋！","哼！你若追得上我，红装双手奉上。","你可是名将，不要为了几件红装背叛朝廷！","何以解忧，唯有红装！","设使天下无有孤，不知当几人有红装",},
        [2] = {2,20,6,95,1,9999,"追击1次",5,1,"追击10次",10,1,"1002","","","","","英雄别打我了！嘤嘤嘤~~~","英雄手下留情，我给你好东西！","痛哉！痛哉！给你！","来呀，追我呀，来啊来啊来啊。","别打了，装备都给你！","说我的战袍可换红装的定是那孙刘的阴谋！","哼！你若追得上我，红装双手奉上。","你可是名将，不要为了几件红装背叛朝廷！","何以解忧，唯有红装！","设使天下无有孤，不知当几人有红装",},
        [3] = {1001,20,6,94,1,0,"观星1次",5,1,"观星10次",10,1,"2001","guanxingxing","moving_guanxing","img_activity_guanxing_title","青龙消失倒计时","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [4] = {1002,20,6,94,1,0,"观星1次",5,1,"观星10次",10,1,"2002|2001","guanxingxuanwu|guanxingxing","moving_guanxing_xuanwu|moving_guanxing","img_activity_guanxing_title2|img_activity_guanxing_title","玄武消失倒计时|青龙消失倒计时","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [5] = {1003,20,6,94,1,0,"观星1次",5,1,"观星10次",10,1,"2002|2004|2003|2001","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title","玄武消失倒计时|白虎消失倒计时|圣鲲消失倒计时|青龙消失倒计时","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [6] = {1004,20,6,94,1,0,"观星1次",5,1,"观星10次",10,1,"2002|2007|2004|2005|2003|2001|2006","guanxingxuanwu|guanxingnianshou|guanxingbaihu|guanxingqilin|guanxingkun|guanxingxing|guanxingzhuque","moving_guanxing_xuanwu|moving_guanxing_nianshou|moving_guanxing_baihu|moving_guanxing_qilin|moving_guanxing_kun|moving_guanxing|moving_guanxing_zhuque","img_activity_guanxing_title2|img_activity_nianshou_title|img_activity_baihu_title|img_activity_qilin_title|img_activity_shengkun_title|img_activity_guanxing_title|img_activity_zhuque_title","玄武消失倒计时|年兽消失倒计时|白虎消失倒计时|麒麟消失倒计时|圣鲲消失倒计时|青龙消失倒计时|朱雀消失倒计时","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [7] = {1401,20,6,159,1,0,"驯马1次",5,1,"驯马10次",10,1,"5009","","809","txt_xunma_chengma04","飞霜千里离开倒计时","","","","","","酒且斟下，某去便来。","看尔等插标卖首","玉可碎而不可改其白，竹可焚而不可毁其节。","一骑绝尘走千里，五关斩将震坤乾。","此等小事难不倒我关某！",},
        [8] = {1501,20,6,159,1,0,"驯马1次",5,1,"驯马10次",10,1,"5010|5012|5011|5009","","812|810|811|809","txt_xunma_chengma01|txt_xunma_chengma02|txt_xunma_chengma03|txt_xunma_chengma04","乌云踏雪离开倒计时|夜照玉狮离开倒计时|胭脂火龙离开倒计时|飞霜千里离开倒计时","","","","","","酒且斟下，某去便来。","看尔等插标卖首","玉可碎而不可改其白，竹可焚而不可毁其节。","一骑绝尘走千里，五关斩将震坤乾。","此等小事难不倒我关某！",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [1001] = 3,
    [1002] = 4,
    [1003] = 5,
    [1004] = 6,
    [1401] = 7,
    [1501] = 8,
    [2] = 2,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in equipment_active")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
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
function equipment_active.indexOf(index)
    if index == nil or not equipment_active._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/equipment_active.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "equipment_active" )
        return setmetatable({_raw = equipment_active._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = equipment_active._data[index]}, mt)
end

--
function equipment_active.get(id)
    
    return equipment_active.indexOf(__index_id[id])
        
end

--
function equipment_active.set(id, key, value)
    local record = equipment_active.get(id)
    if record then
        local keyIndex = __key_map[key]
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