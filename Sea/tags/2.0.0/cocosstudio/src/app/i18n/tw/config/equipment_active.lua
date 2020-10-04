--equipment_active

local equipment_active = {
    -- key
    __key_map = {
      id = 1,    --编号_key-int 
      money = 2,    --充值额度_math-int 
      name1 = 3,    --抽奖名称1-繁体-string 
      name2 = 4,    --抽奖名称2-繁体-string 
      drop = 5,    --掉落库-繁体_math-string 
      back_name = 6,    --背景星星资源名-繁体-string 
      pic_name = 7,    --背景图资源名-繁体-string 
      title_name = 8,    --活动标题资源名-繁体-string 
      time_name = 9,    --倒计时描述-繁体-string 
      hit_chat_1 = 10,    --被击喊话1-繁体-string 
      hit_chat_2 = 11,    --被击喊话2-繁体-string 
      hit_chat_3 = 12,    --被击喊话3-繁体-string 
      hit_chat_4 = 13,    --被击喊话4-繁体-string 
      hit_chat_5 = 14,    --被击喊话5-繁体-string 
      chat_1 = 15,    --常规喊话1-繁体-string 
      chat_2 = 16,    --常规喊话2-繁体-string 
      chat_3 = 17,    --常规喊话3-繁体-string 
      chat_4 = 18,    --常规喊话4-繁体-string 
      chat_5 = 19,    --常规喊话5-繁体-string 
    
    },
    -- data
    _data = {
        [1] = {1,200,"追擊1次","追擊10次","1001","","","","","英雄別打我了!嚶嚶嚶~~~","英雄手下留情, 我給你好東西!","痛哉!痛哉!給你!","來呀, 追我呀, 來啊來啊來啊.","別打了, 裝備都給你!","說我的戰袍可換紅裝的定是那孫劉的陰謀!","哼!你若追得上我, 紅裝雙手奉上.","你可是名將, 不要為了幾件紅裝背叛朝廷!","何以解憂, 唯有紅裝!","設使天下無有孤, 不知當幾人有紅裝",},
        [2] = {2,200,"追擊1次","追擊10次","1002","","","","","英雄別打我了!嚶嚶嚶~~~","英雄手下留情, 我給你好東西!","痛哉!痛哉!給你!","來呀, 追我呀, 來啊來啊來啊.","別打了, 裝備都給你!","說我的戰袍可換紅裝的定是那孫劉的陰謀!","哼!你若追得上我, 紅裝雙手奉上.","你可是名將, 不要為了幾件紅裝背叛朝廷!","何以解憂, 唯有紅裝!","設使天下無有孤, 不知當幾人有紅裝",},
        [3] = {1001,200,"觀星1次","觀星10次","2001","guanxingxing","moving_guanxing","img_activity_guanxing_title","青龍消失倒計時","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [4] = {1002,200,"觀星1次","觀星10次","2002|2001","guanxingxuanwu|guanxingxing","moving_guanxing_xuanwu|moving_guanxing","img_activity_guanxing_title2|img_activity_guanxing_title","玄武消失倒計時|青龍消失倒計時","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [5] = {1003,200,"觀星1次","觀星10次","2002|2004|2003|2001","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title","玄武消失倒計時|白虎消失倒計時|聖鯤消失倒計時|青龍消失倒計時","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [6] = {1004,200,"觀星1次","觀星10次","2002|2007|2004|2005|2003|2001|2006","guanxingxuanwu|guanxingnianshou|guanxingbaihu|guanxingqilin|guanxingkun|guanxingxing|guanxingzhuque","moving_guanxing_xuanwu|moving_guanxing_nianshou|moving_guanxing_baihu|moving_guanxing_qilin|moving_guanxing_kun|moving_guanxing|moving_guanxing_zhuque","img_activity_guanxing_title2|img_activity_nianshou_title|img_activity_baihu_title|img_activity_qilin_title|img_activity_shengkun_title|img_activity_guanxing_title|img_activity_zhuque_title","玄武消失倒計時|年獸消失倒計時|白虎消失倒計時|麒麟消失倒計時|聖鯤消失倒計時|青龍消失倒計時|朱雀消失倒計時","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [7] = {1401,200,"馴馬1次","馴馬10次","4001|4002","","","","","","","","","","","","","","",},
        [8] = {1501,200,"馴馬1次","馴馬10次","5010|5012|5011|5009","","812|810|811|809","txt_xunma_chengma01|txt_xunma_chengma02|txt_xunma_chengma03|txt_xunma_chengma04","烏雲踏雪離開倒計時|夜照玉獅離開倒計時|胭脂火龍離開倒計時|飛霜千里離開倒計時","","","","","","酒且斟下, 某去便來.","看爾等插標賣首","玉可碎而不可改其白, 竹可焚而不可毀其節.","一騎絕塵走千里, 五關斬將震坤乾.","此等小事難不倒我關某!",},
    }
}

return equipment_active