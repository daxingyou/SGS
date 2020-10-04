--function_level_th

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  function_id = 1,    --功能id-int 
  name = 2,    --名字-泰语-string 
  script = 3,    --字体-string 
  place = 4,    --位置-string 
  space = 5,    --行间距-string 
  alignment = 6,    --对齐方式-string 

}

-- key type
local __key_type = {
  function_id = "int",    --功能id-1 
  name = "string",    --名字-泰语-2 
  script = "string",    --字体-3 
  place = "string",    --位置-4 
  space = "string",    --行间距-5 
  alignment = "string",    --对齐方式-6 

}


-- data
local function_level_th = {
    _data = {
        [1] = {1,"ยกทัพ","","","","",},
        [2] = {2,"ผจญภัย","80","0,-32","-4","1",},
        [3] = {3,"กระบวนทัพ","80","0,-32","-4","1",},
        [4] = {4,"ขุนพล","","","","",},
        [5] = {5,"กองทัพ","80","0,-32","-4","1",},
        [6] = {6,"กระเป๋า","80","0,-32","-4","1",},
        [7] = {7,"รีไซเคิล","80","0,-32","-4","1",},
        [8] = {8,"ภารกิจ","70","0,-30","-4","1",},
        [9] = {9,"ร้านค้า","80","0,-32","-4","1",},
        [10] = {10,"กิจกรรม","70","0,-30","-4","1",},
        [11] = {11,"รับสมัคร","80","0,-32","-4","1",},
        [12] = {12,"เพิ่มเติม","80","0,-32","-4","1",},
        [13] = {13,"ยศขุนนาง","80","0,-32","-4","1",},
        [14] = {14,"จดหมาย","80","0,-32","-4","1",},
        [15] = {15,"เติมเงิน","70","0,-30","-4","1",},
        [16] = {16,"แพ็คVip","70","0,-30","-4","1",},
        [17] = {17,"อันดับ","80","0,-32","-4","1",},
        [18] = {18,"เช็คชื่อ","","","","",},
        [19] = {19,"โบนัส","70","0,-30","-4","1",},
        [20] = {20,"กิจกรรม7วัน","70","0,-30","-4","1",},
        [21] = {21,"ความสำเร็จ","80","0,-32","-4","1",},
        [22] = {22,"จัดทัพ","","","","",},
        [23] = {23,"ร้านประลอง","80","0,-32","-4","1",},
        [24] = {24,"ร้านอุปกรณ์","80","0,-32","-4","1",},
        [25] = {25,"ร้านค้าขุนพล","80","0,-32","-4","1",},
        [26] = {26,"ร้านสมบัติ","80","0,-32","-4","1",},
        [27] = {27,"สมุดภาพ","80","0,-32","-4","1",},
        [28] = {28,"กระถางสมบัติ","","","","",},
        [29] = {29,"แชท","","","","",},
        [30] = {30,"ร้าน","80","0,-32","-4","1",},
        [31] = {31,"ร้านปลุก","80","0,-32","-4","1",},
        [32] = {32,"ตั้งค่า","80","0,-32","-4","1",},
        [33] = {33,"แทนที่","80","0,-32","-4","1",},
        [34] = {333,"แทนที่","80","0,-32","-4","1",},
        [35] = {34,"แลกแพ็ค","","","","",},
        [36] = {35,"แข็งแกร่ง","80","0,-32","-4","1",},
        [37] = {36,"ร้านกองทัพ","80","0,-32","-4","1",},
        [38] = {37,"แบบสอบถาม","70","0,-30","-4","1",},
        [39] = {38,"งานเลี้ยง","","","","",},
        [40] = {39,"กระเป๋าไอเทมปลุก","","","","",},
        [41] = {40,"แสดงก่อนเปิดฟังก์ชั่น","","","","",},
        [42] = {41,"เพื่อน","80","0,-32","-4","1",},
        [43] = {42,"แกร่งขึ้น","70","0,-30","-4","1",},
        [44] = {43,"จดหมาย","80","0,-32","-4","1",},
        [45] = {44,"คืนโบนัส\nเติมเงิน","70","0,-21","-4","1",},
        [46] = {45,"กิจกรรม","70","0,-30","-4","1",},
        [47] = {49,"สถานการณ์\nฉุกเฉิน","80","0,-22","-4","1",},
        [48] = {50,"ข้ามการต่อสู้","","","","",},
        [49] = {51,"ดันเจี้ยนสายหลัก","","","","",},
        [50] = {52,"กวาดล้างสายหลัก","","","","",},
        [51] = {53,"ดันเจี้ยนมือเอก","","","","",},
        [52] = {54,"ดันเจี้ยนรายวัน","","","","",},
        [53] = {55,"ท้ารบ","","","","",},
        [54] = {56,"ดันเจี้ยนยอดขุนพล","","","","",},
        [55] = {57,"ทดสอบกองทัพ","","","","",},
        [56] = {58,"สร้างกองทัพ","","","","",},
        [57] = {59,"ศึกกองทัพ","70","0,-30","-4","1",},
        [58] = {60,"กองทัพศัตรูบุกรุก","","","","",},
        [59] = {61,"แอ็คทีฟกองทัพ","","","","",},
        [60] = {62,"บริจาคกองทัพ","","","","",},
        [61] = {63,"ช่วยสนับสนุนกองทัพ","","","","",},
        [62] = {64,"ทดสอบกองทัพ","70","0,-30","-4","1",},
        [63] = {65,"ศึกกองทัพ","","","","",},
        [64] = {66,"ตอบคำถามกองทัพ","","","","",},
        [65] = {67,"ศึกสามก๊ก","70","0,-30","-4","1",},
        [66] = {68,"รายงานศึก","80","0,-32","-4","1",},
        [67] = {69,"ท้ารบมือเอก","80","0,-32","-4","1",},
        [68] = {70,"กวาดล้างท้ารบมือเอก","","","","",},
        [69] = {71,"สนามประลอง","","","","",},
        [70] = {72,"กวาดล้างสนามประลอง","","","","",},
        [71] = {73,"พเนจร","80","0,-32","-4","1",},
        [72] = {74,"พเนจรอัตโนมัติ","","","","",},
        [73] = {75,"กวาดล้าง3ดาว","","","","",},
        [74] = {76,"ฝ่าด่านสังหารขุนพล","","","","",},
        [75] = {77,"ลาดตระเวนฐานทัพ","","","","",},
        [76] = {78,"หนานหมาน\nบุกรุก","80","0,-22","-4","1",},
        [77] = {79,"รางวัล","80","0,-32","-4","1",},
        [78] = {80,"ข่าวอาละวาด","80","0,-32","-4","1",},
        [79] = {81,"ช่วยฐานทัพ","80","0,-32","-4","1",},
        [80] = {82,"รางวัล\nลาดตระเวน","80","0,-22","-4","1",},
        [81] = {83,"รางวัล\nอาละวาด","80","0,-22","-4","1",},
        [82] = {84,"อาละวาด\nฐานทัพ","80","0,-22","-4","1",},
        [83] = {85,"ค่ายที่\nแนะนำ","80","0,-22","-4","1",},
        [84] = {86,"แปลงร่าง","80","0,-32","-4","1",},
        [85] = {87,"ตอบคำถาม\nกองทัพ","70","0,-21","-4","1",},
        [86] = {88,"ศึกแร่","80","0,-32","-4","1",},
        [87] = {89,"ร่วมมือสังหาร","70","0,-30","-4","1",},
        [88] = {90,"สายฮัวหยง","70","0,-30","-4","1",},
        [89] = {91,"ถุงแพร","","","","",},
        [90] = {92,"รายงานศึก","80","0,-32","-4","1",},
        [91] = {93,"ตำแหน่งฉัน","80","0,-32","-4","1",},
        [92] = {212,"สิทธิพิเศษ\nศึกแร่","80","0,-22","-4","1",},
        [93] = {94,"การ์ด\nแปลงร่าง","80","0,-22","-4","1",},
        [94] = {95,"สมบูรณ์พูนสุข","","","","",},
        [95] = {96,"แปลงร่างสกิน","","","","",},
        [96] = {97,"ร้านการ์ด\nแปลงร่าง","80","0,-22","-4","1",},
        [97] = {98,"สนับสนุน","80","0,-32","-4","1",},
        [98] = {99,"แก้แค้นศัตรู","80","0,-32","-4","1",},
        [99] = {100,"ร้านชุดแดง","80","0,-32","-4","1",},
        [100] = {101,"อัปเกรดขุนพล","","","","",},
        [101] = {102,"อัปเลเวลขุนพล","","","","",},
        [102] = {103,"อัปเลเวลขุนพลกิน10ชิ้น","","","","",},
        [103] = {104,"ทะลวงขุนพล","","","","",},
        [104] = {105,"ฟ้าลิขิตขุนพล","","","","",},
        [105] = {106,"สกิลขุนพล","","","","",},
        [106] = {107,"ปลุกขุนพล","","","","",},
        [107] = {108,"ทะลวงขีดจำกัด","","","","",},
        [108] = {111,"อุปกรณ์","","","","",},
        [109] = {112,"อัปเกรดอุปกรณ์","","","","",},
        [110] = {113,"อัปเกรดอุปกรณ์5ครั้ง","","","","",},
        [111] = {114,"สกัดอุปกรณ์","","","","",},
        [112] = {115,"ปุ่มสกัดอุปกรณ์","","","","",},
        [113] = {116,"อุปกรณ์อัปเกรดทั้งหมด","","","","",},
        [114] = {117,"ทะลวงขีดจำกัดอุปกรณ์","","","","",},
        [115] = {118,"ฝังอุปกรณ์","","","","",},
        [116] = {121,"สมบัติ","","","","",},
        [117] = {122,"อัปเกรดสมบัติ","","","","",},
        [118] = {123,"สกัดสมบัติ","","","","",},
        [119] = {124,"ทะลวงขีดจำกัดสมบัติ","","","","",},
        [120] = {130,"ขุนพล","80","0,-32","-4","1",},
        [121] = {131,"อุปกรณ์","80","0,-32","-4","1",},
        [122] = {132,"สมบัติ","80","0,-32","-4","1",},
        [123] = {133,"อาจารย์อัปเกรด","","","","",},
        [124] = {134,"ศาสตรา","","","","",},
        [125] = {135,"ศาสตรา","80","0,-32","-4","1",},
        [126] = {136,"ศาสตรา","","","","",},
        [127] = {137,"ศาสตรา","","","","",},
        [128] = {138,"ศาสตรา","","","","",},
        [129] = {150,"อันดับ","80","0,-32","-4","1",},
        [130] = {151,"อันดับ","80","0,-32","-4","1",},
        [131] = {152,"อันดับ","80","0,-32","-4","1",},
        [132] = {153,"อันดับ","80","0,-32","-4","1",},
        [133] = {161,"รายงานศึก","80","0,-32","-4","1",},
        [134] = {162,"ประลอง\nยอดฝีมือ","80","0,-22","-4","1",},
        [135] = {163,"ประลองค่าย","70","0,-30","-4","1",},
        [136] = {164,"ตารางแข่งขัน   ","80","0,-32","-4","1",},
        [137] = {165,"แชมป์ค่าย","70","0,-30","-4","1",},
        [138] = {166,"ปลุก","","","","",},
        [139] = {167,"ดันเจี้ยนรายวัน","","","","",},
        [140] = {168,"ประลองส่วนตัว\nข้ามเซิร์ฟ","70","0,-21","-4","1",},
        [141] = {169,"หนึ่งใน\nใต้หล้า","70","0,-21","-4","1",},
        [142] = {723,"พบมังกร\nในทุ่ง","70","0,-21","-4","1",},
        [143] = {724,"จับรางวัล\nสนุกสนาน","","","","",},
        [144] = {725,"อันดับคะแนนรวม","","","","",},
        [145] = {726,"ร้านขุนพลทอง","80","0,-32","-4","1",},
        [146] = {727,"สมุดภาพ","80","0,-32","-4","1",},
        [147] = {728,"รางวัลแต้ม","80","0,-32","-4","1",},
        [148] = {171,"ตำแหน่งถุงแพรที่1","","","","",},
        [149] = {172,"ตำแหน่งถุงแพรที่2","","","","",},
        [150] = {173,"ตำแหน่งถุงแพรที่3","","","","",},
        [151] = {174,"ตำแหน่งถุงแพรที่4","","","","",},
        [152] = {175,"ตำแหน่งถุงแพรที่5","","","","",},
        [153] = {176,"ตำแหน่งถุงแพรที่6","","","","",},
        [154] = {177,"ตำแหน่งถุงแพรที่7","","","","",},
        [155] = {178,"ตำแหน่งถุงแพรที่8","","","","",},
        [156] = {179,"ตำแหน่งถุงแพรที่9","","","","",},
        [157] = {180,"ตำแหน่งถุงแพรที่10","","","","",},
        [158] = {181,"เปลี่ยนระยะ\nสายตา","80","0,-22","-4","1",},
        [159] = {182,"เปลี่ยนระยะ\nสายตา","80","0,-22","-4","1",},
        [160] = {183,"ศึกกองทัพข้ามเซิร์ฟ","","","","",},
        [161] = {184,"ศึกกองทัพข้ามเซิร์ฟ","","","","",},
        [162] = {198,"ใบรับรอง\nชื่อจริง","70","0,-21","-4","1",},
        [163] = {199,"แพ้หัวซุกหัวซุน","","","","",},
        [164] = {200,"พเนจรต่อเนื่อง","","","","",},
        [165] = {201,"เร่งความเร็วต่อสู้","","","","",},
        [166] = {202,"ต่อสู้ความเร็วx3","","","","",},
        [167] = {203,"ต่อสู้ความเร็วx4","","","","",},
        [168] = {204,"เล่นซ้ำการต่อสู้","","","","",},
        [169] = {205,"สถิติการต่อสู้","","","","",},
        [170] = {206,"ฉายา","","","","",},
        [171] = {207,"ฐานทัพคลิก\nเดียวเก็บเกี่ยว","80","0,-22","-4","1",},
        [172] = {208,"เปลี่ยนแปลงเค้าโครงอินเตอร์เฟซหลัก","","","","",},
        [173] = {209,"คลิกเดียว\nแบ่งปัน","80","0,-22","-4","1",},
        [174] = {210,"คลิกเดียวรับ","80","0,-32","-4","1",},
        [175] = {211,"กรอบรูปโปรไฟล์","","","","",},
        [176] = {301,"ตำแหน่งค่ายที่1","","","","",},
        [177] = {302,"ตำแหน่งค่ายที่2","","","","",},
        [178] = {303,"ตำแหน่งค่ายที่3","","","","",},
        [179] = {304,"ตำแหน่งค่ายที่4","","","","",},
        [180] = {305,"ตำแหน่งค่ายที่5","","","","",},
        [181] = {306,"ตำแหน่งค่ายที่6","","","","",},
        [182] = {310,"ทหาร\nสนัขสนุน","80","0,-22","-4","1",},
        [183] = {311,"ทหารสนับสนุน1","","","","",},
        [184] = {312,"ทหารสนับสนุน2","","","","",},
        [185] = {313,"ทหารสนับสนุน3","","","","",},
        [186] = {314,"ทหารสนับสนุน4","","","","",},
        [187] = {315,"ทหารสนับสนุน5","","","","",},
        [188] = {316,"ทหารสนับสนุน6","","","","",},
        [189] = {317,"ทหารสนับสนุน7","","","","",},
        [190] = {318,"ทหารสนับสนุน8","","","","",},
        [191] = {321,"สมุดขุนพล","","","","",},
        [192] = {330,"อัปเลเวลของวิเศษ","","","","",},
        [193] = {335,"ปลุกของวิเศษ","","","","",},
        [194] = {362,"รีไซเคิลขุนพล","","","","",},
        [195] = {363,"รีไซเคิลอุปกรณ์","","","","",},
        [196] = {364,"รีไซเคิลศาสตรา","","","","",},
        [197] = {365,"เกิดใหม่ขุนพล","","","","",},
        [198] = {366,"อุปกรณ์เกิดใหม่","","","","",},
        [199] = {367,"สมบัติเกิดใหม่","","","","",},
        [200] = {368,"ศาสตราเกิดใหม่","","","","",},
        [201] = {369,"รีไซเคิลสมบัติ","","","","",},
        [202] = {370,"รีไซเคิลอสูรเทพ","","","","",},
        [203] = {371,"อสูรเทพเกิดใหม่","","","","",},
        [204] = {372,"รีไซเคิลอุปกรณ์ม้า","","","","",},
        [205] = {601,"แพ็คเติม\nครั้งแรก","70","0,-21","-4","1",},
        [206] = {602,"แพ็คVip","","","","",},
        [207] = {603,"กำลังเสริม","","","","",},
        [208] = {604,"แพ็ครายสัปดาห์","","","","",},
        [209] = {605,"แพ็คประจำวัน","","","","",},
        [210] = {606,"เงินทุนเปิดเซิร์ฟ","","","","",},
        [211] = {607,"สะสมเติมเงินแจกรางวัล","","","","",},
        [212] = {608,"เช็คชื่อรายวัน","","","","",},
        [213] = {609,"รางวัลเติมเงินทุกคน","","","","",},
        [214] = {610,"เติมเงินครั้งแรก3เท่า","","","","",},
        [215] = {611,"คลังสมบัติสวรรค์?","","","","",},
        [216] = {612,"รหัสเชิญ","","","","",},
        [217] = {613,"การ์ดเดือน","","","","",},
        [218] = {614,"ร้านของชำ","","","","",},
        [219] = {615,"ฉลองเทศกาล","70","0,-30","-4","1",},
        [220] = {616,"ร้านคริสตัล","70","0,-30","-4","1",},
        [221] = {617,"เติมเงินคริสตัล","","","","",},
        [222] = {618,"หาคืน\nทรัพยากร","80","0,-22","-4","1",},
        [223] = {619,"แบ่งปันประจำสัปดาห์","","","","",},
        [224] = {620,"คริสตัลแอ็คทีฟ","","","","",},
        [225] = {621,"ฉลองตวนอู่","70","0,-30","-4","1",},
        [226] = {622,"ฤดูร้อน\nเย็นสบาย","70","0,-21","-4","1",},
        [227] = {623,"ชีซีความรัก","70","0,-30","-4","1",},
        [228] = {624,"พระจันทร์\nเต็มดวง","70","0,-21","-4","1",},
        [229] = {625,"วันชาติ","70","0,-30","-4","1",},
        [230] = {626,"ร้านคริสตัล","70","0,-30","-4","1",},
        [231] = {627,"งานฉลองสุข","70","0,-30","-4","1",},
        [232] = {628,"เทศกาล\nซื้อสินค้า","70","0,-21","-4","1",},
        [233] = {629,"งานฉลอง\nรวมเซิร์ฟ","70","0,-21","-4","1",},
        [234] = {630,"เทศกาล\nซื้อสินค้า","70","0,-21","-4","1",},
        [235] = {631,"เทศกาล\nคริสต์มาส","70","0,-21","-4","1",},
        [236] = {632,"ยินดีต้อนรับ\nวันปีใหม่","70","0,-21","-4","1",},
        [237] = {633,"เทศกาล\nฤดูใบไม้ผลิ","70","0,-21","-4","1",},
        [238] = {634,"หยวนเซียว\nมีความสุข","70","0,-21","-4","1",},
        [239] = {635,"เทพธิดาจุติ","70","0,-30","-4","1",},
        [240] = {636,"เดินเล่น\nเช็งเม้ง","70","0,-21","-4","1",},
        [241] = {637,"วสันต์ปลูก\nคิมหันตเก็บ","70","0,-21","-4","1",},
        [242] = {639,"ฤดูร้อนเย็นๆ","70","0,-30","-4","1",},
        [243] = {640,"วันแห่ง\nรักชีซี","70","0,-21","-4","1",},
        [244] = {641,"งานฉลอง\nเทศกาล","70","0,-21","-4","1",},
        [245] = {642,"เก็บเกี่ยว\nใบไม้ร่วง","70","0,-21","-4","1",},
        [246] = {643,"วันลอย\nกระทอง","70","0,-30","-4","1",},
        [247] = {644,"งานฉลอง\nสิ้นปี","70","0,-21","-4","1",},
        [248] = {645,"สุขสันต์\nวันคริสต์มาส","70","0,-21","-4","1",},
        [249] = {800,"ข้อความกระสุนเกียรติยศ","","","","",},
        [250] = {801,"ระบบข้อความกระสุน","","","","",},
        [251] = {802,"ข้อความกระสุนอั่งเปา","","","","",},
        [252] = {803,"BOSSกองทัพ","70","0,-30","-4","1",},
        [253] = {804,"ลายน้ำวาสนา","","","","",},
        [254] = {805,"ขายเศษขุนพล","","","","",},
        [255] = {806,"หีบปลุก","","","","",},
        [256] = {807,"ชนเผ่าจับขุนพล","","","","",},
        [257] = {808,"ประมูล","70","0,-30","-4","1",},
        [258] = {809,"ประมูลทั้งเซิร์ฟ","","","","",},
        [259] = {810,"ประมูลbossโลก","","","","",},
        [260] = {811,"ถ่ายทอดวรยุทธ์","","","","",},
        [261] = {812,"สังคมOPPO","","","","",},
        [262] = {813,"","","","","",},
        [263] = {814,"ฝนอั่งเปา","80","0,-32","-4","1",},
        [264] = {850,"เปลี่ยนขุนพล","","","","",},
        [265] = {855,"สุสานจิ๋นซี","70","0,-30","-4","1",},
        [266] = {856,"ทีม-ยืนยันยอมรับทีม","","","","",},
        [267] = {857,"ทีม-เชิญเข้าร่วมทีม","","","","",},
        [268] = {858,"ทีม-กล่องข้อมูลทีม","","","","",},
        [269] = {860,"สุสานจิ๋นซี","","","","",},
        [270] = {861,"สุสานจิ๋นซี·1","","","","",},
        [271] = {862,"สุสานจิ๋นซี·2","","","","",},
        [272] = {863,"สุสานจิ๋นซี·3","","","","",},
        [273] = {901,"ทะลวง+2","","","","",},
        [274] = {902,"ทะลวง+3","","","","",},
        [275] = {903,"ทะลวง+4","","","","",},
        [276] = {904,"ทะลวง+5","","","","",},
        [277] = {905,"ทะลวง+6","","","","",},
        [278] = {906,"ทะลวง+7","","","","",},
        [279] = {907,"ทะลวง+8","","","","",},
        [280] = {908,"ทะลวง+9","","","","",},
        [281] = {909,"ทะลวง+10","","","","",},
        [282] = {910,"ทะลวง+11","","","","",},
        [283] = {911,"ทะลวง+12","","","","",},
        [284] = {912,"ทะลวง+13","","","","",},
        [285] = {913,"ทะลวง+14","","","","",},
        [286] = {914,"ทะลวง+15","","","","",},
        [287] = {930,"อสูรเทพ","80","0,-32","-4","1",},
        [288] = {931,"อัปเลเวลอสูรเทพ","","","","",},
        [289] = {932,"อัปเลเวลอสูรเทพ5ครั้ง","","","","",},
        [290] = {933,"อัปดาวอสูรเทพ","","","","",},
        [291] = {934,"สมุดภาพ\nอสูรเทพ","80","0,-22","-4","1",},
        [292] = {935,"ร้านกองทัพ","80","0,-32","-4","1",},
        [293] = {942,"รายชื่ออสูรเทพ","","","","",},
        [294] = {943,"อสูรเทพฉัน","80","0,-32","-4","1",},
        [295] = {944,"โบนัสออกรบ","80","0,-32","-4","1",},
        [296] = {945,"โบนัสสมุดภาพ","","","","",},
        [297] = {946,"เปลี่ยนอสูรเทพ","","","","",},
        [298] = {947,"ร้านอสูรเทพ","80","0,-32","-4","1",},
        [299] = {948,"ต้นไม้เทพ","80","0,-32","-4","1",},
        [300] = {949,"กลับบ้าน","80","0,-32","-4","1",},
        [301] = {950,"ตัวอย่าง\nทะลวง","80","0,-22","-4","1",},
        [302] = {960,"ร้านชมดาว","80","0,-32","-4","1",},
        [303] = {961,"มังกรหลับชมดาว","","","","",},
        [304] = {970,"ตำแหน่งคุ้มครองที่1ของอสูรเทพ","","","","",},
        [305] = {971,"ตำแหน่งคุ้มครองที่2ของอสูรเทพ","","","","",},
        [306] = {972,"ตำแหน่งคุ้มครองที่3ของอสูรเทพ","","","","",},
        [307] = {973,"ตำแหน่งคุ้มครองที่4ของอสูรเทพ","","","","",},
        [308] = {974,"ตำแหน่งคุ้มครองที่5ของอสูรเทพ","","","","",},
        [309] = {975,"ตำแหน่งคุ้มครองที่6ของอสูรเทพ","","","","",},
        [310] = {976,"ตำแหน่งคุ้มครองที่7ของอสูรเทพ","","","","",},
        [311] = {977,"ทะลวงขีดจำกัดอสูรเทพ","","","","",},
        [312] = {988,"รีไซเคิลม้าศึก","","","","",},
        [313] = {989,"ม้าศึกเกิดใหม่","","","","",},
        [314] = {990,"ม้าศึก","80","0,-32","-4","1",},
        [315] = {991,"อัปดาวม้าศึก","","","","",},
        [316] = {992,"รายชื่อม้าศึก","","","","",},
        [317] = {993,"ร้านม้าศึก","80","0,-32","-4","1",},
        [318] = {994,"สมุดภาพ\nม้าศึก","80","0,-22","-4","1",},
        [319] = {995,"ดูม้าตลาดม้า","","","","",},
        [320] = {996,"อุปกรณ์ม้า","","","","",},
        [321] = {997,"ควบม้าข้ามลำธาร","","","","",},
        [322] = {999,"","","","","",},
        [323] = {1000,"เชื่อมต่อOL","70","0,-30","-4","1",},
        [324] = {1001,"สมุดภาพ","80","0,-32","-4","1",},
        [325] = {1002,"บริการ\nลูกค้าVIP","70","0,-21","-4","1",},
        [326] = {1003,"ใบรับรองVIP","70","0,-30","-4","1",},
        [327] = {1004,"สมาชิกกองทัพ","","","","",},
        [328] = {1005,"รางวัลวีแชท","","","","",},
        [329] = {1100,"ศึกราชา","70","0,-30","-4","1",},
        [330] = {1101,"อันดับ","80","0,-32","-4","1",},
        [331] = {1102,"รายงานศึก","80","0,-32","-4","1",},
        [332] = {1103,"รางวัล\nฤดูแข่งขัน","80","0,-22","-4","1",},
        [333] = {1104,"ตั้งค่า\nถุงแพร","80","0,-22","-4","1",},
        [334] = {1105,"การแข่งขันที่ไม่มีความแตกต่าง","","","","",},
        [335] = {1200,"ยอดขุนพลแห่งยุค","","","","",},
        [336] = {1201,"ตำแหน่งค่ายที่1ของขุนพล","","","","",},
        [337] = {1202,"ตำแหน่งค่ายที่2ของขุนพล","","","","",},
        [338] = {1203,"ตำแหน่งค่ายที่3ของขุนพล","","","","",},
        [339] = {1204,"ตำแหน่งค่ายที่4ของขุนพล","","","","",},
        [340] = {1205,"ปลุกพลังจิตขุนพล","","","","",},
        [341] = {1206,"ทะลวงขีดจำกัดขุนพล","","","","",},
        [342] = {1207,"สมุดภาพขุนพล","","","","",},
        [343] = {1208,"รายชื่อขุนพล","","","","",},
        [344] = {1209,"รายการเศษขุนพล","","","","",},
        [345] = {1210,"รายการอาวุธขุนพล","","","","",},
        [346] = {1211,"รายการเศษอาวุธขุนพล","","","","",},
        [347] = {1212,"ขุนพลเกิดใหม่","","","","",},
        [348] = {1301,"ร้านหินดิบ","","","","",},
        [349] = {1302,"กระเป๋าไอเทมหินหยก","","","","",},
        [350] = {1400,"กวนอูฝึกม้า","","","","",},
        [351] = {1401,"ร้านฝึกม้า","","","","",},
        [352] = {1501,"ตอบคำถาม\nทั้งเซิร์ฟ","70","0,-21","-4","1",},
        [353] = {1600,"กิจกรรมเค้ก","70","0,-30","-4","1",},
        [354] = {1601,"ร้านค้า","80","0,-32","-4","1",},
        [355] = {1603,"ได้รับวัสดุ","80","0,-32","-4","1",},
        [356] = {1604,"ตัวอย่างรางวัล  ","80","0,-32","-4","1",},
        [357] = {9991,"เพื่อนเพิ่มเติม","","","","",},
        [358] = {9992,"ผจญภัยเพิ่มเติม","","","","",},
        [359] = {9993,"ของวิเศษเพิ่มเติม","","","","",},
        [360] = {99001,"วัสดุครึ่งราคา หีบสมบัติลึกลับ","","","","",},
        [361] = {99901,"อินเตอร์เฟซด่านรอบที่1","","","","",},
        [362] = {99902,"อินเตอร์เฟซหลัก","","","","",},
        [363] = {99903,"กระบวนทัพตัวละครหลัก","","","","",},
        [364] = {99904,"อินเตอร์เฟซด่านรอบที่2","","","","",},
        [365] = {99905,"อินเตอร์เฟซด่านรอบที่3","","","","",},
        [366] = {99906,"แท็บรางวัลร้านประลอง","","","","",},
        [367] = {30200,"ชุมชน","80","0,-32","-4","1",},
        [368] = {11101,"แพ็คพิเศษ","70","0,-21","-4","1",},
    }
}

-- index
local __index_function_id = {
    [1] = 1,
    [10] = 10,
    [100] = 99,
    [1000] = 323,
    [1001] = 324,
    [1002] = 325,
    [1003] = 326,
    [1004] = 327,
    [1005] = 328,
    [101] = 100,
    [102] = 101,
    [103] = 102,
    [104] = 103,
    [105] = 104,
    [106] = 105,
    [107] = 106,
    [108] = 107,
    [11] = 11,
    [1100] = 329,
    [1101] = 330,
    [1102] = 331,
    [1103] = 332,
    [1104] = 333,
    [1105] = 334,
    [111] = 108,
    [11101] = 368,
    [112] = 109,
    [113] = 110,
    [114] = 111,
    [115] = 112,
    [116] = 113,
    [117] = 114,
    [118] = 115,
    [12] = 12,
    [1200] = 335,
    [1201] = 336,
    [1202] = 337,
    [1203] = 338,
    [1204] = 339,
    [1205] = 340,
    [1206] = 341,
    [1207] = 342,
    [1208] = 343,
    [1209] = 344,
    [121] = 116,
    [1210] = 345,
    [1211] = 346,
    [1212] = 347,
    [122] = 117,
    [123] = 118,
    [124] = 119,
    [13] = 13,
    [130] = 120,
    [1301] = 348,
    [1302] = 349,
    [131] = 121,
    [132] = 122,
    [133] = 123,
    [134] = 124,
    [135] = 125,
    [136] = 126,
    [137] = 127,
    [138] = 128,
    [14] = 14,
    [1400] = 350,
    [1401] = 351,
    [15] = 15,
    [150] = 129,
    [1501] = 352,
    [151] = 130,
    [152] = 131,
    [153] = 132,
    [16] = 16,
    [1600] = 353,
    [1601] = 354,
    [1603] = 355,
    [1604] = 356,
    [161] = 133,
    [162] = 134,
    [163] = 135,
    [164] = 136,
    [165] = 137,
    [166] = 138,
    [167] = 139,
    [168] = 140,
    [169] = 141,
    [17] = 17,
    [171] = 148,
    [172] = 149,
    [173] = 150,
    [174] = 151,
    [175] = 152,
    [176] = 153,
    [177] = 154,
    [178] = 155,
    [179] = 156,
    [18] = 18,
    [180] = 157,
    [181] = 158,
    [182] = 159,
    [183] = 160,
    [184] = 161,
    [19] = 19,
    [198] = 162,
    [199] = 163,
    [2] = 2,
    [20] = 20,
    [200] = 164,
    [201] = 165,
    [202] = 166,
    [203] = 167,
    [204] = 168,
    [205] = 169,
    [206] = 170,
    [207] = 171,
    [208] = 172,
    [209] = 173,
    [21] = 21,
    [210] = 174,
    [211] = 175,
    [212] = 92,
    [22] = 22,
    [23] = 23,
    [24] = 24,
    [25] = 25,
    [26] = 26,
    [27] = 27,
    [28] = 28,
    [29] = 29,
    [3] = 3,
    [30] = 30,
    [301] = 176,
    [302] = 177,
    [30200] = 367,
    [303] = 178,
    [304] = 179,
    [305] = 180,
    [306] = 181,
    [31] = 31,
    [310] = 182,
    [311] = 183,
    [312] = 184,
    [313] = 185,
    [314] = 186,
    [315] = 187,
    [316] = 188,
    [317] = 189,
    [318] = 190,
    [32] = 32,
    [321] = 191,
    [33] = 33,
    [330] = 192,
    [333] = 34,
    [335] = 193,
    [34] = 35,
    [35] = 36,
    [36] = 37,
    [362] = 194,
    [363] = 195,
    [364] = 196,
    [365] = 197,
    [366] = 198,
    [367] = 199,
    [368] = 200,
    [369] = 201,
    [37] = 38,
    [370] = 202,
    [371] = 203,
    [372] = 204,
    [38] = 39,
    [39] = 40,
    [4] = 4,
    [40] = 41,
    [41] = 42,
    [42] = 43,
    [43] = 44,
    [44] = 45,
    [45] = 46,
    [49] = 47,
    [5] = 5,
    [50] = 48,
    [51] = 49,
    [52] = 50,
    [53] = 51,
    [54] = 52,
    [55] = 53,
    [56] = 54,
    [57] = 55,
    [58] = 56,
    [59] = 57,
    [6] = 6,
    [60] = 58,
    [601] = 205,
    [602] = 206,
    [603] = 207,
    [604] = 208,
    [605] = 209,
    [606] = 210,
    [607] = 211,
    [608] = 212,
    [609] = 213,
    [61] = 59,
    [610] = 214,
    [611] = 215,
    [612] = 216,
    [613] = 217,
    [614] = 218,
    [615] = 219,
    [616] = 220,
    [617] = 221,
    [618] = 222,
    [619] = 223,
    [62] = 60,
    [620] = 224,
    [621] = 225,
    [622] = 226,
    [623] = 227,
    [624] = 228,
    [625] = 229,
    [626] = 230,
    [627] = 231,
    [628] = 232,
    [629] = 233,
    [63] = 61,
    [630] = 234,
    [631] = 235,
    [632] = 236,
    [633] = 237,
    [634] = 238,
    [635] = 239,
    [636] = 240,
    [637] = 241,
    [639] = 242,
    [64] = 62,
    [640] = 243,
    [641] = 244,
    [642] = 245,
    [643] = 246,
    [644] = 247,
    [645] = 248,
    [65] = 63,
    [66] = 64,
    [67] = 65,
    [68] = 66,
    [69] = 67,
    [7] = 7,
    [70] = 68,
    [71] = 69,
    [72] = 70,
    [723] = 142,
    [724] = 143,
    [725] = 144,
    [726] = 145,
    [727] = 146,
    [728] = 147,
    [73] = 71,
    [74] = 72,
    [75] = 73,
    [76] = 74,
    [77] = 75,
    [78] = 76,
    [79] = 77,
    [8] = 8,
    [80] = 78,
    [800] = 249,
    [801] = 250,
    [802] = 251,
    [803] = 252,
    [804] = 253,
    [805] = 254,
    [806] = 255,
    [807] = 256,
    [808] = 257,
    [809] = 258,
    [81] = 79,
    [810] = 259,
    [811] = 260,
    [812] = 261,
    [813] = 262,
    [814] = 263,
    [82] = 80,
    [83] = 81,
    [84] = 82,
    [85] = 83,
    [850] = 264,
    [855] = 265,
    [856] = 266,
    [857] = 267,
    [858] = 268,
    [86] = 84,
    [860] = 269,
    [861] = 270,
    [862] = 271,
    [863] = 272,
    [87] = 85,
    [88] = 86,
    [89] = 87,
    [9] = 9,
    [90] = 88,
    [901] = 273,
    [902] = 274,
    [903] = 275,
    [904] = 276,
    [905] = 277,
    [906] = 278,
    [907] = 279,
    [908] = 280,
    [909] = 281,
    [91] = 89,
    [910] = 282,
    [911] = 283,
    [912] = 284,
    [913] = 285,
    [914] = 286,
    [92] = 90,
    [93] = 91,
    [930] = 287,
    [931] = 288,
    [932] = 289,
    [933] = 290,
    [934] = 291,
    [935] = 292,
    [94] = 93,
    [942] = 293,
    [943] = 294,
    [944] = 295,
    [945] = 296,
    [946] = 297,
    [947] = 298,
    [948] = 299,
    [949] = 300,
    [95] = 94,
    [950] = 301,
    [96] = 95,
    [960] = 302,
    [961] = 303,
    [97] = 96,
    [970] = 304,
    [971] = 305,
    [972] = 306,
    [973] = 307,
    [974] = 308,
    [975] = 309,
    [976] = 310,
    [977] = 311,
    [98] = 97,
    [988] = 312,
    [989] = 313,
    [99] = 98,
    [990] = 314,
    [99001] = 360,
    [991] = 315,
    [992] = 316,
    [993] = 317,
    [994] = 318,
    [995] = 319,
    [996] = 320,
    [997] = 321,
    [999] = 322,
    [99901] = 361,
    [99902] = 362,
    [99903] = 363,
    [99904] = 364,
    [99905] = 365,
    [99906] = 366,
    [9991] = 357,
    [9992] = 358,
    [9993] = 359,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in function_level_th")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function function_level_th.length()
    return #function_level_th._data
end

-- 
function function_level_th.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function function_level_th.indexOf(index)
    if index == nil or not function_level_th._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/function_level_th.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "function_level_th" )
        return setmetatable({_raw = function_level_th._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = function_level_th._data[index]}, mt)
end

--
function function_level_th.get(function_id)
    
    return function_level_th.indexOf(__index_function_id[function_id])
        
end

--
function function_level_th.set(function_id, key, value)
    local record = function_level_th.get(function_id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function function_level_th.index()
    return __index_function_id
end

return function_level_th