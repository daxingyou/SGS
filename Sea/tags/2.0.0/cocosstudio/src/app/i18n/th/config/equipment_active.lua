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
        [1] = {1,200,"1001","","","","ไล่โจมตี1ครั้ง","ไล่โจมตี10ครั้ง","","วีรบุรุษอย่าตีข้า!ฮือๆๆ~~~","วีรบุรุษออมมือต่อสู้ข้ามีของดีให้!","เจ็บจัง!เจ็บจัง!ให้เจ้า!","มาสิตามข้ามามาสิมาสิมาสิ","อย่าตีนะเอาอุปกรณ์ให้!","บอกว่าเสื้อคลุมของข้าเปลี่ยนเป็นชุดแดงได้นั่นต้องเป็นแผนของซุนกวนเล่าปี่แน่!","หึ!ถ้าเจ้าตามข้าทันชุดแดงประเคนให้กับมือ","เจ้าคือขุนพลอย่าทรยศราชสำนักเพราะชุดแดงไม่กี่ชิ้น!","สิ่งใดแก้กลุ้มมีแต่ชุดแดง!","ถ้าแผ่นดินนี้ไม่มีข้าไม่รู้ว่าจะมีชุดแดงซักกี่คน",},
        [2] = {2,200,"1002","","","","ไล่โจมตี1ครั้ง","ไล่โจมตี10ครั้ง","","วีรบุรุษอย่าตีข้า!ฮือๆๆ~~~","วีรบุรุษออมมือต่อสู้ข้ามีของดีให้!","เจ็บจัง!เจ็บจัง!ให้เจ้า!","มาสิตามข้ามามาสิมาสิมาสิ","อย่าตีนะเอาอุปกรณ์ให้!","บอกว่าเสื้อคลุมของข้าเปลี่ยนเป็นชุดแดงได้นั่นต้องเป็นแผนของซุนกวนเล่าปี่แน่!","หึ!ถ้าเจ้าตามข้าทันชุดแดงประเคนให้กับมือ","เจ้าคือขุนพลอย่าทรยศราชสำนักเพราะชุดแดงไม่กี่ชิ้น!","สิ่งใดแก้กลุ้มมีแต่ชุดแดง!","ถ้าแผ่นดินนี้ไม่มีข้าไม่รู้ว่าจะมีชุดแดงซักกี่คน",},
        [3] = {1001,200,"2002|2004|2003|2001","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title","ชมดาว1ครั้ง","ชมดาว10ครั้ง","นับเวลาถอยหลังเต่าดำหายไป|นับเวลาถอยหลังพยัคฆ์ขาวหายไป|นับเวลาถอยหลังเทพคุนหายไป|นับเวลาถอยหลังมังกรเขียวหายไป","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี",},
        [4] = {1002,200,"2002|2004|2003|2001|2005|2006","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing|guanxingqilin|guanxingzhuque","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing|moving_guanxing_qilin|moving_guanxing_zhuque","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title|img_activity_qilin_title|img_activity_zhuque_title","ชมดาว1ครั้ง","ชมดาว10ครั้ง","นับเวลาถอยหลังเต่าดำหายไป|นับเวลาถอยหลังพยัคฆ์ขาวหายไป|นับเวลาถอยหลังเทพคุนหายไป|นับเวลาถอยหลังมังกรเขียวหายไป|นับเวลาถอยหลังกิเลนหายไป|นับเวลาถอยหลังหงส์ไฟหายไป","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี",},
        [5] = {1003,200,"2002|2004|2003|2001","guanxingxuanwu|guanxingbaihu|guanxingkun|guanxingxing","moving_guanxing_xuanwu|moving_guanxing_baihu|moving_guanxing_kun|moving_guanxing","img_activity_guanxing_title2|img_activity_baihu_title|img_activity_shengkun_title|img_activity_guanxing_title","ชมดาว1ครั้ง","ชมดาว10ครั้ง","นับเวลาถอยหลังเต่าดำหายไป|นับเวลาถอยหลังพยัคฆ์ขาวหายไป|นับเวลาถอยหลังเทพคุนหายไป|นับเวลาถอยหลังมังกรเขียวหายไป","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี",},
        [6] = {1004,200,"2002|2007|2004|2005|2003|2001|2006","guanxingxuanwu|guanxingnianshou|guanxingbaihu|guanxingqilin|guanxingkun|guanxingxing|guanxingzhuque","moving_guanxing_xuanwu|moving_guanxing_nianshou|moving_guanxing_baihu|moving_guanxing_qilin|moving_guanxing_kun|moving_guanxing|moving_guanxing_zhuque","img_activity_guanxing_title2|img_activity_nianshou_title|img_activity_baihu_title|img_activity_qilin_title|img_activity_shengkun_title|img_activity_guanxing_title|img_activity_zhuque_title","ชมดาว1ครั้ง","ชมดาว10ครั้ง","นับเวลาถอยหลังเต่าดำหายไป|นับเวลาถอยหลังสัตว์เหนียนหายไป|นับเวลาถอยหลังพยัคฆ์ขาวหายไป|นับเวลาถอยหลังกิเลนหายไป|นับเวลาถอยหลังเทพคุนหายไป|นับเวลาถอยหลังมังกรเขียวหายไป|นับเวลาถอยหลังหงส์ไฟหายไป","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี","กั้นตี",},
        [7] = {1401,200,"5010|5011|5009","","812|811|809","txt_xunma_chengma01|txt_xunma_chengma03|txt_xunma_chengma04","ฝึกม้า1ครั้ง","ฝึกม้า10ครั้ง","นับเวลาถอยหลังม้าเมฆดำจากไป|นับเวลาถอยหลังม้ามังกรไฟจากไป|นับเวลาถอยหลังม้าพันลี้จากไป","","","","","","สะบัดทีสั่นสะท้านอยากไปก็ไป","ดูพวกเจ้ายกหัวมาประเคน","หยกแตกได้แต่เปลี่ยนเป็นขาวไม่ได้ไผ่เผาได้แต่ทำลายข้อไม่ได้","ขี่ม้าเดินทางพันลี้ห้าด่านฆ่าขุนพลสั่นสะเทือนแผ่นดิน","เรื่องนี้เล็กน้อยขวางข้าคนแซ่กวนไม่ได้หรอก!",},
        [8] = {1501,200,"5010|5012|5011|5009","","812|810|811|809","txt_xunma_chengma01|txt_xunma_chengma02|txt_xunma_chengma03|txt_xunma_chengma04","ฝึกม้า1ครั้ง","ฝึกม้า10ครั้ง","นับเวลาถอยหลังม้าเมฆดำจากไป|นับเวลาถอยหลังม้ายู่ซือจากไป|นับเวลาถอยหลังม้ามังกรไฟจากไป|นับเวลาถอยหลังม้าพันลี้จากไป","","","","","","สะบัดทีสั่นสะท้านอยากไปก็ไป","ดูพวกเจ้ายกหัวมาประเคน","หยกแตกได้แต่เปลี่ยนเป็นขาวไม่ได้ไผ่เผาได้แต่ทำลายข้อไม่ได้","ขี่ม้าเดินทางพันลี้ห้าด่านฆ่าขุนพลสั่นสะเทือนแผ่นดิน","เรื่องนี้เล็กน้อยขวางข้าคนแซ่กวนไม่ได้หรอก!",},
    }
}

return equipment_active