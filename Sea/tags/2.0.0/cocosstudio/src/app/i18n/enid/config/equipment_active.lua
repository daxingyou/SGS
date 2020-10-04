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
        [1] = {1,200,"1001","","","","Kejar 1x","Kejar 10x","","Pendekar jangan memukulku lagi! Aduduh~~~","Pendekar ampuni aku, aku akan memberimu barang bagus!","Sakit! Sakit! Rasakan!","Sini, kejar aku, ayo ayo ayo.","Jangan berkelahi lagi, gear kuserahkan padamu!","Pasti mata-mata Sun - Liu yang bilang bahwa jubahku bisa ditukarkan dengan Gear Merah!","Huh! Jika kamu bisa mengejarku, kuserahkan Gear Merah.","Kamu adalah Hero, jangan demi Gear Merah lalu mengkhianati kerajaan!","Satu-satunya cara menyelesaikan masalah adalah Gear merah!","Jika tidak ada kesunyian di dunia, tidak tahu berapa orang yang memiliki gear merah",},
        [2] = {2,200,"1002","","","","Kejar 1x","Kejar 10x","","Pendekar jangan memukulku lagi! Aduduh~~~","Pendekar ampuni aku, aku akan memberimu barang bagus!","Sakit! Sakit! Rasakan!","Sini, kejar aku, ayo ayo ayo.","Jangan berkelahi lagi, gear kuserahkan padamu!","Pasti mata-mata Sun - Liu yang bilang bahwa jubahku bisa ditukarkan dengan Gear Merah!","Huh! Jika kamu bisa mengejarku, kuserahkan Gear Merah.","Kamu adalah Hero, jangan demi Gear Merah lalu mengkhianati kerajaan!","Satu-satunya cara menyelesaikan masalah adalah Gear merah!","Jika tidak ada kesunyian di dunia, tidak tahu berapa orang yang memiliki gear merah",},
        [3] = {1001,200,"2002|2004|2003|2001","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title","Astronomi 1x","Astronomi 10x","Kura Hitam akan hilang dalam | Macan Putih akan hilang dalam |Kun akan hilang dalam | Naga akan hilang dalam ","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi",},
        [4] = {1002,200,"2002|2004|2003|2001|2005|2006","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing|guanxingqilin|guanxingzhuque","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing|moving_guanxing_qilin|moving_guanxing_zhuque","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title|img_activity_qilin_title|img_activity_zhuque_title","Astronomi 1x","Astronomi 10x","Kura Hitam akan hilang dalam | Macan Putih akan hilang dalam |Kun akan hilang dalam | Naga akan hilang dalam | Kirin akan hilang dalam | Suzaku akan hilang dalam","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi",},
        [5] = {1003,200,"2002|2004|2003|2001","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title","Astronomi 1x","Astronomi 10x","Kura Hitam akan hilang dalam | Macan Putih akan hilang dalam |Kun akan hilang dalam | Naga akan hilang dalam ","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi",},
        [6] = {1004,200,"2002|2007|2004|2005|2003|2001|2006","guanxingxuanwu|guanxingnianshou|guanxingbaihu|guanxingqilin|guanxingkun|guanxingxing|guanxingzhuque","moving_guanxing_xuanwu|moving_guanxing_nianshou|moving_guanxing_baihu|moving_guanxing_qilin|moving_guanxing_kun|moving_guanxing|moving_guanxing_zhuque","img_activity_guanxing_title2|img_activity_nianshou_title|img_activity_baihu_title|img_activity_qilin_title|img_activity_shengkun_title|img_activity_guanxing_title|img_activity_zhuque_title","Astronomi 1x","Astronomi 10x","Kura Hitam akan hilang dalam | Beast Nian akan hilang dalam | Macan Putih akan hilang dalam | Kirin akan hilang dalam | Kun akan hilang dalam | Naga akan hilang dalam | Suzaku akan hilang dalam","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi","Jangan berkelahi lagi",},
        [7] = {1401,200,"5010|5011|5009","","812|811|809","txt_xunma_chengma01|txt_xunma_chengma03|txt_xunma_chengma04","Latih Kuda 1x","Latih Kuda 10x","Awan Hitam akan kabur dalam | Naga Api akan kabur dalam | Embun Terbang akan kabur dalam","","","","","","Anggur dituang, beberapa datang dan pergi.","Menunggumu menjualnya","Giok bisa patah tetapi tidak bisa menjadi putih, bambu bisa terbakar tetapi tidak bisa hancur.","Berkelana ribuan mil, jalan kejayaan menggoncangkan dunia.","Masalah kecil begini bukan urusanku!",},
        [8] = {1501,200,"5010|5012|5011|5009","","812|810|811|809","txt_xunma_chengma01|txt_xunma_chengma02|txt_xunma_chengma03|txt_xunma_chengma04","Latih Kuda 1x","Latih Kuda 10x","Awan Hitam akan kabur dalam | Singa Giok akan kabur dalam | Naga Api akan kabur dalam | Embun Terbang akan kabur dalam","","","","","","Anggur dituang, beberapa datang dan pergi.","Menunggumu menjualnya","Giok bisa patah tetapi tidak bisa menjadi putih, bambu bisa terbakar tetapi tidak bisa hancur.","Berkelana ribuan mil, jalan kejayaan menggoncangkan dunia.","Masalah kecil begini bukan urusanku!",},
    }
}

return equipment_active