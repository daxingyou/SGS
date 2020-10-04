--equipment_active

local equipment_active = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      money = 2,    --充值额度_math-int 
      drop = 3,    --掉落库_math-string 
      back_name = 4,    --背景星星资源名-string 
      pic_name = 5,    --背景图资源名-string 
      title_name = 6,    --活动标题资源名-string 
      name1 = 7,    --抽奖名称1-string 
      name2 = 8,    --抽奖名称2-string 
      time_name = 9,    --倒计时描述-string 
      hit_chat_1 = 10,    --被击喊话1-string 
      hit_chat_2 = 11,    --被击喊话2-string 
      hit_chat_3 = 12,    --被击喊话3-string 
      hit_chat_4 = 13,    --被击喊话4-string 
      hit_chat_5 = 14,    --被击喊话5-string 
      chat_1_vn = 15,    --常规喊话1-string 
      chat_2_vn = 16,    --常规喊话2-string 
      chat_3 = 17,    --常规喊话3-string 
      chat_4 = 18,    --常规喊话4-string 
      chat_5 = 19,    --常规喊话5-string 
    
    },
    -- data
    _data = {
        [1] = {1,200,"1001","","","","追击1次","追击10次","","英雄别打我了!嘤嘤嘤~~~","英雄手下留情, 我给你好东西!","痛哉!痛哉!给你!","来呀, 追我呀, 来啊来啊来啊.","别打了, 装备都给你!","说我的战袍可换红装的定是那孙刘的阴谋!","哼!你若追得上我, 红装双手奉上.","你可是名将, 不要为了几件红装背叛朝廷!","何以解忧, 唯有红装!","设使天下无有孤, 不知当几人有红装",},
        [2] = {2,200,"1002","","","","追击1次","追击10次","","英雄别打我了!嘤嘤嘤~~~","英雄手下留情, 我给你好东西!","痛哉!痛哉!给你!","来呀, 追我呀, 来啊来啊来啊.","别打了, 装备都给你!","说我的战袍可换红装的定是那孙刘的阴谋!","哼!你若追得上我, 红装双手奉上.","你可是名将, 不要为了几件红装背叛朝廷!","何以解忧, 唯有红装!","设使天下无有孤, 不知当几人有红装",},
        [3] = {1001,200,"2002|2004|2003|2001","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title","观星1次","观星10次","玄武消失倒计时|白虎消失倒计时|圣鲲消失倒计时|青龙消失倒计时","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [4] = {1002,200,"2002|2004|2003|2001|2005|2006","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing|guanxingqilin|guanxingzhuque","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing|moving_guanxing_qilin|moving_guanxing_zhuque","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title|img_activity_qilin_title|img_activity_zhuque_title","观星1次","观星10次","玄武消失倒计时|白虎消失倒计时|圣鲲消失倒计时|青龙消失倒计时|麒麟消失倒计时|朱雀消失倒计时","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [5] = {1003,200,"2002|2004|2003|2001","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title","观星1次","观星10次","玄武消失倒计时|白虎消失倒计时|圣鲲消失倒计时|青龙消失倒计时","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [6] = {1004,200,"2002|2007|2004|2005|2003|2001|2006","guanxingxuanwu|guanxingnianshou|guanxingbaihu|guanxingqilin|guanxingkun|guanxingxing|guanxingzhuque","moving_guanxing_xuanwu|moving_guanxing_nianshou|moving_guanxing_baihu|moving_guanxing_qilin|moving_guanxing_kun|moving_guanxing|moving_guanxing_zhuque","img_activity_guanxing_title2|img_activity_nianshou_title|img_activity_baihu_title|img_activity_qilin_title|img_activity_shengkun_title|img_activity_guanxing_title|img_activity_zhuque_title","观星1次","观星10次","玄武消失倒计时|年兽消失倒计时|白虎消失倒计时|麒麟消失倒计时|圣鲲消失倒计时|青龙消失倒计时|朱雀消失倒计时","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了","憋打了",},
        [7] = {1401,200,"5010|5011|5009","","812|811|809","txt_xunma_chengma01|txt_xunma_chengma03|txt_xunma_chengma04","驯马1次","驯马10次","乌云踏雪离开倒计时|胭脂火龙离开倒计时|飞霜千里离开倒计时","","","","","","酒且斟下, 某去便来.","看尔等插标卖首","玉可碎而不可改其白, 竹可焚而不可毁其节.","一骑绝尘走千里, 五关斩将震坤乾.","此等小事难不倒我关某!",},
        [8] = {1501,200,"5010|5012|5011|5009","","812|810|811|809","txt_xunma_chengma01|txt_xunma_chengma02|txt_xunma_chengma03|txt_xunma_chengma04","驯马1次","驯马10次","乌云踏雪离开倒计时|夜照玉狮离开倒计时|胭脂火龙离开倒计时|飞霜千里离开倒计时","","","","","","酒且斟下, 某去便来.","看尔等插标卖首","玉可碎而不可改其白, 竹可焚而不可毁其节.","一骑绝尘走千里, 五关斩将震坤乾.","此等小事难不倒我关某!",},
    }
}

return equipment_active