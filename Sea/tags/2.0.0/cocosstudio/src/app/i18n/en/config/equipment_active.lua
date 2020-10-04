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
      chat_1 = 15,    --常规喊话1-string 
      chat_2 = 16,    --常规喊话2-string 
      chat_3 = 17,    --常规喊话3-string 
      chat_4 = 18,    --常规喊话4-string 
      chat_5 = 19,    --常规喊话5-string 
    
    },
    -- data
    _data = {
        [1] = {1,200,"1001","","","","Pursue x1","Pursue x10","","Hero, please don't hit me! Sobbing...","Hero, please spare my life. I'll give you something good!","Good! Here you are!","Catch me if you can. Come on!","Don't hit me! I'll give you the gear!","It must be Sun Quan and Liu Bei's conspiracy to say that my robe can be changed into Divine Gear!","If you can catch up with me, I'll give you my Divine Gear.","You are a warrior. Don't betray our country for a few Divine Gear!","Only Divine Gear can eliminate my sorrow!","If I am not here in this world, no one will ever have Divine Gear.",},
        [2] = {2,200,"1002","","","","Pursue x1","Pursue x10","","Hero, please don't hit me! Sobbing...","Hero, please spare my life. I'll give you something good!","Good! Here you are!","Catch me if you can. Come on!","Don't hit me! I'll give you the gear!","It must be Sun Quan and Liu Bei's conspiracy to say that my robe can be changed into Divine Gear!","If you can catch up with me, I'll give you my Divine Gear.","You are a warrior. Don't betray our country for a few Divine Gear!","Only Divine Gear can eliminate my sorrow!","If I am not here in this world, no one will ever have Divine Gear.",},
        [3] = {1001,200,"2002|2004|2003|2001","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title","Stargaze x1","Stargaze x10","Black Tortoise Disappearance Countdown |White Tiger Disappearance Countdown |Sacred Kun Disappearance Countdown|Azure Dragon Disappearance Countdown","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me",},
        [4] = {1002,200,"2002|2004|2003|2001|2005|2006","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing|guanxingqilin|guanxingzhuque","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing|moving_guanxing_qilin|moving_guanxing_zhuque","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title|img_activity_qilin_title|img_activity_zhuque_title","Stargaze x1","Stargaze x10","Black Tortoise Disappearance Countdown |White Tiger Disappearance Countdown |Sacred Kun Disappearance Countdown|Azure Dragon Disappearance Countdown|Kylin Disappearance Countdown|Vermilion Bird Disappearance Countdown","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me",},
        [5] = {1003,200,"2002|2004|2003|2001","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title","Stargaze x1","Stargaze x10","Black Tortoise Disappearance Countdown |White Tiger Disappearance Countdown |Sacred Kun Disappearance Countdown|Azure Dragon Disappearance Countdown","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me",},
        [6] = {1004,200,"2002|2007|2004|2005|2003|2001|2006","guanxingxuanwu|guanxingnianshou|guanxingbaihu|guanxingqilin|guanxingkun|guanxingxing|guanxingzhuque","moving_guanxing_xuanwu|moving_guanxing_nianshou|moving_guanxing_baihu|moving_guanxing_qilin|moving_guanxing_kun|moving_guanxing|moving_guanxing_zhuque","img_activity_guanxing_title2|img_activity_nianshou_title|img_activity_baihu_title|img_activity_qilin_title|img_activity_shengkun_title|img_activity_guanxing_title|img_activity_zhuque_title","Stargaze x1","Stargaze x10","Black Tortoise Disappearance Countdown|Monster Nian Disappearance Countdown|White Tiger Disappearance Countdown|Kylin Disappearance Countdown|Sacred Kun Disappearance Countdown|Azure Dragon Disappearance Countdown|Vermilion Bird Disappearance Countdown","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me","Don't hit me",},
        [7] = {1401,200,"5010|5011|5009","","812|811|809","txt_xunma_chengma01|txt_xunma_chengma03|txt_xunma_chengma04","Train Horse x1","Train Horse x10","Cloudy Snow Disappearance Countdown |Fire Dragon Disappearance Countdown|Flying Frost Disappearance Countdown","","","","","","Just pour the wine, I'll be back soon.","It looks like you're selling your heads with a price tag.","Jade can be broken, but its white essence can never be changed.","Ride for a thousand miles, and kill warriors along the way. ","Such a small thing can't defeat me!",},
        [8] = {1501,200,"5010|5012|5011|5009","","812|810|811|809","txt_xunma_chengma01|txt_xunma_chengma02|txt_xunma_chengma03|txt_xunma_chengma04","Train Horse x1","Train Horse x10","Cloudy Snow Disappearance Countdown |Jade Lion Disappearance Countdown|Fire Dragon Disappearance Countdown|Flying Frost Disappearance Countdown","","","","","","Just pour the wine, I'll be back soon.","It looks like you're selling your heads with a price tag.","Jade can be broken, but its white essence can never be changed.","Ride for a thousand miles, and kill warriors along the way. ","Such a small thing can't defeat me!",},
    }
}

return equipment_active