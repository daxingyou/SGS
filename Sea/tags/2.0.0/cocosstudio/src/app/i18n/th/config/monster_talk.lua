--monster_talk

local monster_talk = {
    -- key
    __key_map = {
      id = 1,    --序号-int 
      bubble = 2,    --战斗中说话内容，不要超过25个字-泰语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"ช่วงนี้พี่ใหญ่ได้รับของดีชิ้นหนึ่ง",},
        [2] = {2,"ดูความร้ายกาจของยันต์คำสาปข้าสิ!",},
        [3] = {3,"ฟ้าครามตายแล้ว ฟ้าเหลืองขึ้นแทน!",},
        [4] = {4,"ต่อสู้เริ่มต้นโทสะ2 โจมตีทั่วไปเพิ่มโทสะ2 โทสะ4แต้มก็จะปล่อยสกิลได้ล่ะ",},
        [5] = {5,"พี่กวนอิ๋นผิงคือคนโจมตีหลัก นายท่านต้องเลี้ยงดูนางดีดีล่ะ",},
        [6] = {6,"ยืนอยู่แถวหน้าสุดอันตรายมาก นายท่านส่งข้าไปอยู่แถวหลังได้ไหม?",},
        [7] = {7,"ยืนอยู่แถวหน้าสุดอันตรายมาก นายท่านส่งข้าไปอยู่แถวหลังได้ไหม?",},
        [8] = {8,"อยู่แถวหลังเหมือนจะปลอดภัยหน่อยแล้ว ขอบคุณนายท่าน!",},
        [9] = {9,"อัปเลเวลขุนพลทะลวงแล้วหรือยัง? สวมอุปกรณ์และอัปเกรดหรือยัง?",},
        [10] = {10,"นายท่าน ไม่เลี้ยงดูให้ดี ไม่มีทางเอาชนะเตียวเหยียงได้หรอก!",},
        [11] = {11,"นายท่าน อย่าลืมเลี้ยงดูข้าสิ!",},
        [12] = {12,"นายท่าน อย่าลืมเลี้ยงดูข้าสิ!",},
        [13] = {13,"นายท่าน อย่าลืมเลี้ยงดูข้าสิ!",},
        [14] = {14,"นายท่าน อย่าลืมเลี้ยงดูข้าสิ!",},
        [15] = {15,"นายท่าน อย่าลืมเลี้ยงดูข้าสิ!",},
        [16] = {16,"นายท่าน อย่าลืมเลี้ยงดูข้าสิ!",},
        [17] = {17,"นายท่าน อย่าลืมเลี้ยงดูข้าสิ!",},
        [18] = {18,"นายท่าน อย่าลืมเลี้ยงดูข้าสิ!",},
        [19] = {19,"ปล้น! ส่งตำลึงที่ได้จากสนามประลองมาให้หมด!",},
        [20] = {20,"ไม่เลี้ยงดูขุนพลกับแต่งตัวดีดี สู้ข้าไม่ได้หรอก!",},
        [21] = {21,"ทะลวงขุนพลLv.15+2แล้ว เจ้าถึงมีโอกาสเล็กน้องที่จะชนะข้า",},
        [22] = {22,"ไม่เลี้ยงดูขุนพลกับแต่งตัวดีดี สู้ข้าไม่ได้หรอก!",},
        [23] = {23,"กวาดล้างดันเจี้ยนสายหลักอัปถึงLv.20ถึงชนะข้าได้!",},
        [24] = {24,"กวาดล้างดันเจี้ยนสายหลักอัปถึงLv.23ถึงชนะข้าได้!",},
        [25] = {25,"กวาดล้างดันเจี้ยนสายหลักอัปถึงLv.26ถึงชนะข้าได้!",},
        [26] = {26,"กวาดล้างดันเจี้ยนสายหลักอัปถึงLv.29ถึงชนะข้าได้!",},
        [27] = {27,"ตำลึงที่สนามประลองเยอะจริงๆ ฮ่าๆๆ!",},
        [28] = {28,"ไม่มีตำลึงก็ไปชิงอันดับที่สนามประลอง ตำลึงเยอะมาก!",},
        [29] = {29,"คนอื่นต้องไม่รู้ว่าLv.16สามารถกวาดล้างดันเจี้ยนได้ รีบอัปเลเวลเถอะ ฮ่าๆ",},
        [30] = {31,"ต้องมีแต่ข้าถึงรู้ว่าLv.16สามารถกวาดล้างดันเจี้ยนดาวเต็มได้!",},
        [31] = {32,"ขุนพลอัปถึงLv.25สามารถทะลวง+3 ทะลวง+3สามารถปล่อยสกิลกับประสานโจมตีในรอบแรกได้!",},
        [32] = {33,"กวาดล้างดันเจี้ยนสายหลักสามารถอัปเลเวลตัวเอกได้ย่างรวดเร็ว",},
        [33] = {34,"กวาดล้างดันเจี้ยนสายหลักสามารถอัปเลเวลตัวเอกได้ย่างรวดเร็ว",},
        [34] = {35,"กวาดล้างดันเจี้ยนสายหลักสามารถอัปเลเวลตัวเอกได้ย่างรวดเร็ว",},
        [35] = {36,"กวาดล้างดันเจี้ยนสายหลักสามารถอัปเลเวลตัวเอกได้ย่างรวดเร็ว",},
        [36] = {37,"ได้ยินว่าขุนพลอัปถึงLv.25จะทะลวง+3 ทะลวง+3จะปล่อยสกิลกับประสานโจมตีในรอบแรก!",},
        [37] = {38,"ได้ยินว่าขุนพลอัปถึงLv.25จะทะลวง+3 ทะลวง+3จะปล่อยสกิลกับประสานโจมตีในรอบแรก!",},
        [38] = {39,"นายท่านของข้าเก่งมาก อาศัยการกวาดล้างสายหลักอัปเลเวล!",},
        [39] = {40,"ได้ยินว่าขุนพลอัปถึงLv.25จะทะลวง+3 ทะลวง+3จะปล่อยสกิลกับประสานโจมตีในรอบแรก!",},
        [40] = {41,"ขุนพลส้มเก่งกว่าขุนพลม่วงเยอะเลย!",},
        [41] = {42,"เจ้ารู้ไหมรับสมัครสามารถได้รับขุนพลส้มล่ะ!",},
        [42] = {43,"ท่านไม่มีขุนพลส้ม ชนะข้าไม่ได้หรอก! รีบไปรับสมัครเถอะ!",},
        [43] = {44,"ท่านไม่มีขุนพลส้ม สู้ข้าไม่ได้หรอก!",},
        [44] = {45,"ถ้ารับสมัครขุนพลส้มไม่ได้ เอาชนะข้าไม่ได้หรอก!",},
        [45] = {46,"ถ้าท่านมีขุนพลส้มหลายคน ข้าต้องเอาชนะท่านไม่ได้แน่!",},
        [46] = {47,"แค่ขุนพลม่วง ก็กล้ามาสู้หรอ?",},
        [47] = {48,"ท่านไม่มีขุนพลส้มอื่น สู้ข้าไม่ได้หรอก!",},
        [48] = {49,"ทำไมข้าแฮหัวเอี๋ยนถึงเป็นแค่ขุนพลม่วง!",},
    }
}

return monster_talk