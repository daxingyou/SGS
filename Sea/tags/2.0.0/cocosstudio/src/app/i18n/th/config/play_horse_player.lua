--play_horse_player

local play_horse_player = {
    -- key
    __key_map = {
      rank = 1,    --名次-int 
      text_1 = 2,    --文本1-泰语-string 
      text_2 = 3,    --文本2-泰语-string 
      text_3 = 4,    --文本3-泰语-string 
      text_4 = 5,    --文本4-泰语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"พลังรบเป็นตัวแทนฝีมือของข้า! ข้าจะปกป้องความรัก ความศรัทธากับครอบครัวตลอดไป!","ข้าอันดับหนึ่งข้าเล่นเป็น! พวกเจ้าเติมเงินเท่าข้าไม่แน่ว่าจะชนะข้าได้!","ใครชนะ? พวกเจ้าไปดูว่าอันดับที่1ชาร์ตพลังรบคือใคร!","ขอโทษที พวกเจ้าทุกคน ข้าไม่เห็นอยู่ในสายตา!",},
        [2] = {2,"มามามา วิ่งแข่งวันนี้ข้าต้องได้อันดับที่1!","10ยอดพลังรบข้าเป็นอันดับที่2! ฮ่าๆๆๆ!","ข้าไม่เหมือนคนอื่น ข้าอันดับสองเก็บตัวมาแต่ไหนแต่ไร!","ไม่ใช่ว่าข้าอยากเป็นตัวเอก ข้าก็คือตัวเอก!",},
        [3] = {3,"เลือกผิดหลายครั้งแล้วสิ! วันนี้เลือกข้ารับรองไม่ผิดหวัง!","อันดับที่2มีความคิดเห็นยังไง ข้าอันดับที่3จะแซงเจ้าแล้ว!","ตระกูลทหารแพ้ชนะเป็นเรื่องปกติ สวมเกราะมาไม่รู้แล้วเริ่มใหม่แค่นั้น","ถึงยอมแพ้ไม่ตาย แต่ข้าตายก็ไม่ยอมแพ้!",},
        [4] = {4,"เลือกข้า รับรองเจ้าไม่ผิดหวังแน่!","สามอันดับแรกดุดันขนาดนี้ ข้าอันดับ1อย่าเสนอหน้านัก","พูดถึงศึกแร่ไม่เห็นสนุกเลย เจ้ายังขุดตั้งนาน!","การเล่นใหม่จะออกมาเมื่อไหร่ คอยดู!",},
        [5] = {5,"คึกคักขนาดนี้ ข้าเล่าเรื่องตลกช่วยสร้างบรรยากาศให้ทุกคนดีไหม","ต้องเพิ่มพลังรบทุกวัน คือท่าทางในการเล่นเกมของข้า!","นกดีต้องรู้จักเลือกกิ่งไม้พำนัก คนเก่งต้องรู้จักเลือกนาย","เมื่อเจ้าก้มลงแล้วลุกขึ้น ได้ยินเสียงเข่าดัง เจ้าต้องระวัง นี่หมายความว่าการฟังเสียงของเจ้าปกติ",},
        [6] = {6,"เจ้าพูดถูกแล้ว! ข้าไม่อยากอยู่เฉยๆไร้ชื่อเสียง!","พลังรบอันดับที่6อย่างข้า รู้สึกว่าตนเองโชคดีสมปรารถนา จุ๊บๆ~","น้ำผยุงเรือได้ ก็ต้มโจ๊กได้","ปณิธานยิ่งใหญ่ ทำงานขยัน; ฮวงโหไหลริน ข้าต้องรวบรวม!",},
        [7] = {7,"พี่ชาย เจ้าไม่ใช่หุ่นยนต์ เจ้ามีเลือดเนื้อ!","คนอย่างข้า นิสัยไม่ดี เอะอะโวยวายและชอบหัวเราะ","ข้าคงกินเกลือมากเกินไป เลยเอาแต่คิดถึงเจ้า","เวลาแข่งขันหนึ่งสนาม ข้าไม่ได้ดูการแข่ง เอาแต่มองเจ้า",},
        [8] = {8,"บางคนพูดเรื่องตลกได้ฝืดมาก","ข้าไม่อยากแพ้ให้กับคนอื่น!","เล่นเป็น เล่นค่ายไหนก็เก่ง; เล่นไม่เป็น เล่นค่ายไหนก็ถูกด่า","จะเปิดทะลวงขีดจำกัดแล้ว ถึงตอนนั้นพลังรบของทุกคนก็จะเพิ่มขึ้น!",},
        [9] = {9,"พวกเจ้าคิดว่าไต้เกี้ยวสวยกว่าหรือว่าเตียวเสี้ยนสวยกว่า?","เพื่อชาร์ตอันดับที่9 ข้าพยายามเพิ่มพลังรบทุกวัน!","พวกเขาต่างบอกว่าข้าชอบคุย ที่จริงข้าแค่อยากคุยกับเจ้าเท่านั้น","หนึ่งลิสองจูสามเตียนอุย สี่กวนห้าม้าหกเตียวหุย",},
        [10] = {10,"ติด1ใน10ยอดพลังรบ ข้าก็ดีใจมากแล้ว!","12345 ทองไม้น้ำไฟดิน พลังรบอันดับ10มั่นใจได้!","คนมีปัญญาทำจริง คนโง่แย่งชื่อเสียงจอมปลอม","พวกเจ้าเล่นยังไง พลังรบสูงขนาดนี้?",},
        [11] = {11,"หรือว่าเจ้าบอกว่าข้าจะแพ้ ข้าก็ไม่วิ่งหรอ? ไม่ลองดูข้าจะยอมรับได้ยังไง!","ดังนั้น ข้าต้อง...ชนะ…การแข่งครั้งนี้ให้ได้!","ถ้วยฟีฟ่ารัสเซีย2018: อาร์เจนติน่าแพ้ได้อันดับที่ี่2","เรื่องราวบนโลกไม่มีจบสิ้น สวรรค์เบื้องบนหนีไม่พ้น",},
        [12] = {12,"ฮึกเหิมเพราะเลือดร้อน ถึงแพ้ก็ไม่เป็นไร!","มึนงงอุยเอี๋ยนลดโกรธของใช้ได้ดี!","ใครบอกข้าที ค่ายไหนเก่งที่สุด?","ไม่สนโทษประหารของตนเอง จนเกิดชื่อเสียงเลืองลือ",},
        [13] = {13,"ถ้าข้าเปลี่ยนชื่อ พวกเจ้ายังจะจำข้าได้ไหม?","ตอนสามก๊กมีแข่งวิ่งไหม?","นอนฟางหญ้าเพียงพอ แสงอาทิตย์ทอดนอกหน้าต่าง","ทุกสิ่งไม่อาจลิขิตด้วยตนเอง จิตใจยากจะสงบ",},
        [14] = {14,"ข้าอยากชนะ!","บังทองทะลวงสิบร้ายกาจมาก พวกเจ้าไม่รู้หรอ?","ป้าอ๋องน้อยซุนเซ็ก ตีแถวหลังร้ายกาจมาก!","จอกเหล้ายินดีได้พบ เรื่องน้อยใหญ่แต่โบราณ เจรจากันด้วยรอยยิ้ม",},
        [15] = {15,"หวังว่าจะชนะการแข่งครั้งนี้ไวไว!","เลี้ยงชีซีใช้เล่นสายหลัก สะใจจริงๆ!","อยากชนะหรอ? เคล็ดลับก็คือ เลือกข้าสิ!","คนเก่งย่อมมีคนเก่งในกำมือ ใช้แผนยังพบคนตอแหลกว่า",},
        [16] = {16,"คอยอีกตั้งนานกว่าจะเริ่มการแข่ง เล่าเรื่องสนุกให้ทุกคนครึกครื้นดีกว่า","ข้าต้องการเป็นฮ่องเต้! ขุนพลแดง ชุดแดงเอาใส่พานมา!","ด่า เป็นเรื่องสนุกอย่างหนึ่งในเกม","คนเดียวใช้ชีวิตอย่างสบาย ใยต้องสนใจชื่อเสียงลาภยศ!",},
        [17] = {17,"มีเศรษฐีแจกอั่งเปา2เท่าไหม!","เอาถุงสีแดงมาเยอะๆ ข้าต้องเอาชนะหมอนั่นได้แน่!","สะสมคริสตัลมาตั้งนาน ในที่สุดก็เปลี่ยนถุงสีแดงได้แล้ว!","บัญฑิตมีการศึกษา จะส่งเสียงเอะอะได้อย่างไร; ร่างกายอ่อนแอ ยากฟังเสียงคำรามเสือดาว",},
        [18] = {18,"ผู้ชายที่อภัยให้กับสตรีที่โกหกถึงเป็นสุภาพบุรุษที่แท้จริง","พวกเจ้าพูดมาก ให้ข้าวิ่งแข่งเงียบๆได้ไหม","ชู่ว์! ให้ข้าคิดถึงนางอย่างเงียบๆเถอะ","เจ้าทำอะไร? คำตอบเดียวที่ถูกต้องคือ: คุยกับเจ้า",},
        [19] = {19,"ทั้งไม่หันกลับมา และไม่ลืม; เมื่อไร้วาสนา ใยต้องสาบาน","การแข่งแบบมีมาตรฐาน ห้ามพูดเหยียดหยามกัน!","ข้ารักพวกคุณทุกคน แต่ว่าวกเจ้าต้องให้ข้าชนะ!","เจ้าไม่รู้คนเก่งคนโง่ คือตาไม่แวววาว; ไม่อ่านกลอนกวี คือปากเป็นใบ้; ไม่รับฟังเสียงภักดี คือหูบอด",},
        [20] = {20,"นอกจากข้าเองแล้ว ข้าไม่อนุญาตให้ใครดูถูกข้า!","ข้าคือคน เจ้าไม่ใช่ข้า ดังนั้นเจ้าไม่ใช่คน","พวกไม้ประดับมาเข้าร่วมการแข่งด้วยหรอ? ค่าลงสนามเก็บได้ไม่น้อยสิ!","ไม่รู้ประวัติศาสตร์ คือร่างกายผุเน่า; ไม่ยอมรับผู้นำ คือท้องผุเน่า; อยากทรยศก่อกบฏ คือหัวใจผุเน่า!",},
        [21] = {21,"ทำยังไงถึงชนะการแข่งขันอย่างงดงาม!","ลูกผู้ชายอยู่ใต้ฟ้าดิน จะยอมอยู่ใต้คนอื่นได้ยังไง!","ที่เอาชนะข้าไม่ใช่ความไร้เดียงสา แต่เป็นอากาศร้อน!","ยังไม่เริ่มอีก น่าเบื่อจัง มาด่าทีมงานเกมกัน!",},
        [22] = {22,"ถึงต้องการความอดทนกับการรอคอย……ข้าก็อยากติด1ใน10ยอดพลังรบ!","เรื่องบ้านเรื่องแผ่นดินเป็นเรื่องเล็ก การเล่นเกมให้สนุกเป็นเรื่องใหญ่!","หัวเสือก็มีความสุขได้!","นับแต่โบราณทหารเอกมักพ่ายแพ้ ประมาทศัตรูจะไม่ชนะ",},
        [23] = {23,"ข้าแค่อยากทำอะไรตามอุดมการณ์ของตนเอง ไม่มีเสียใจ ไม่ว่าตอนนี้หรือในอนาคต! ","ภูเขาสายน้ำไร้ทางไป ดอกไม้กิ่งหลิวเป็นกอง","ชอบบอกว่าปากข้าแข็ง ที่จริงในใจข้าอ่อนโยนมาก","แสงหิ้งห้อยระยิบระยับ จะสู้ดวงจันทร์บนฟ้าได้อย่างไร?",},
        [24] = {24,"ไม่ว่าเจ้าเล่นกระบวนทัพอะไร ลองเล่นดู ก็จะรู้!","ทางจ๊กลำบาก ยากคือยากที่ท่องคัมภีร์","เลือดอาบเกราะทั่วตัว ทั่วตังหยางใครกล้าประลอง!","ม้าพบคนมีวาสนาเจริญ คนโง่ตายเพราะคนใกล้ตัว",},
        [25] = {25,"ข้าจะต้องเก่งยิ่งขึ้น!","สั่งสอนคนคนหนึ่ง ต้องเชี่ยวชาญสองประโยค:  1.คราวหน้าก่อนทำอะไรต้องคิดเยอะๆ  2.เจ้าคิดเยอะเกินไป","เรื่องราวเหนือจากที่คาดไว้ เหลือกินเหลือใช้ไม่พอ!","ข้าไม่เคยเจอคนที่หน้าด้านไร้ยางอายขนาดนี้",},
        [26] = {26,"สวรรค์ช่วยคนที่มีความพยายาม เจ้าต้องการจะสำเร็จ!","ข้าสะสมตำลึงเตรียมเอาถุงสีแดง!","แผ่นดินกว้างใหญ่ แยกนานต้องมีรวม รวมนานต้องแยก","ข้างหน้าไร้ทางไป นายทหารใยไม่ยอมสู้ตาย?",},
        [27] = {27,"คนที่อยากลดความอ้วนกินทุกวัน จะลดสำเร็จหรอ?","พบคนแบกห้ามเดินอ้อม ผ่านมาได้ส่งเสียงโห่ จิตใจยากสงบ นับ1-99","วอลนัตที่ถูกประตูหนีบ ยังบำรุงสมองได้ไหม?","มังกรหลับ หงส์ดรุณสองคนได้หนึ่ง สงบแผ่นดิน",},
        [28] = {28,"ข้าตั้งใจว่าจะเอาที่1มาให้ได้!","ดาดฟ้าเบียดไม่ได้แล้ว น่าเสียดายที่ใจข้าเบียด","ทุกครั้งเปิดหีบสมบัติออกทีวี ก็จะรู้สึกเหมือนมีคนแอบมองข้า","ขี่ม้าเซ็กเธาว์เดินพันลี้ ง้าวมังกรเขียวฝ่าห้าด่าน",},
        [29] = {29,"แอบเศร้าเงียบๆ ไม่สู้ลงมือทันที","หาไม่พบ ถอนหายใจตอนเด็กเกเร คับแค้นใจ ตัวอวบอ้วน","ชายหนุ่มร้องไห้ไม่ใช่ความผิด คนเก่งแค่ไหนก็มีสิทธิเหนื่อย","ลูกผู้ชายเกิดมา ต้องพยายามสร้างผลงานเพื่อแผ่นดิน เป็นแนวหน้า",},
        [30] = {30,"กงล้อลมอัคคีของสุมาอี้ไวแค่ไหน ก็เทียบกับข้าไม่ได้!","ไหนบอกว่าพันปีครั้ง ผลคือ1ชั่วโมงถึงกระเพาะ","พวกเจ้ารู้ไหม ไต้เกี้ยว ปู้ฮูหยิน เตียวเสี้ยนต่างร้องเพลงได้!","คิดจับสัตว์ต้องสละตนเป็นสัตว์ก่อน",},
        [31] = {31,"ซุนฮกมีแผลขับไล่เสือกลืนหมาป่า ข้ามีฝีมือพายุใต้ขา!","แมวเป็นสัตว์แปลก ไม่ว่ายากจนหรือร่ำรวย มันก็ดูถูกเจ้า","แม่ทัพภาคหล่อมาเลย น่าเสียดายที่ไม่ค่อยเข้าร่วมการแข่งขัน!","เป็นตายยึดมั่นอุดมการณ์ ลูกผู้ชายต้องกล้าหาญ!",},
        [32] = {32,"คนที่ดื่มเหล้าเป็นอาจิณ ต้องวิ่งแพ้แน่!","เชื่อไหมข้าจะกระดูดทุบเข่าเจ้าให้แตก!","ทั่วพื้นเต็มไปด้วยการ์ดแปลงร่างเสี่ยวเกี้ยว ทำไมนะ?","ฝันใหญ่ใครตื่นก่อน ชีวิตข้าข้ารู้ดี! ",},
        [33] = {33,"กุยแกมีอินทรีย์โบยบินหมื่นลี้ตัวหนึ่ง แต่ในสนามนี้รับรองวิ่งไม่ไหวเท่าข้า!","พวกเจ้าพูดเรื่องตลก ข้าจะเล่าเรื่องซึ้งให้ฟัง!","ข้าพบความลับอย่างหนึ่ง ไทสูจู้ปล่อยสกิลใช้ขาง้างธนู!","ยอดฝีมือย่อมมีผู้เหนือกว่า ต่อสู้ปัญญาพบเรื่องไม่คาดฝัน",},
        [34] = {34,"ได้ยินว่าดาเมจสะท้อนกลับของแฮหัวตุ้นรุนแรงมาก? แต่ในเรื่องการวิ่งข้าคืออันดับ1!","ในสถานการณ์ทั่วไปคนที่ไม่พอใจทรงผมของตนเอง ไม่ยอมรับเรื่องหน้าตาของตนเองเป็นอันขาด","ซุนกวนซุนเซ็กสองพี่น้อง คนหนึ่งตีแถวหลังคนหนึ่งตีแถวหน้า!","อิจิ๋วกำลังอับจนหนทาง โชคดีลำหยงมีมังกรหลับ!",},
        [35] = {35,"โจหยินคือพวกไม้กระดาน ตอนวิ่งข้าหล่อสุด!","ไหนบอกว่าวันเดียวเลิกไง นึกไม่ถึงว่าข้ามวันข้ามคืน!","ตอนที่ลิบองโชคดีทำให้คนสลบได้ถึง6คน!","ข้ายืมเงินเพื่อนนักเขียนโปรแกรมคนหนึ่ง เขาโอนเงินให้ข้า1024บาท ฝากข้อความ: รวมให้ครบ",},
        [36] = {36,"นายท่านรีบไปเร็ว อย่างนี้ข้าจะได้ชิงอันดับ1มา!","ในเมื่อดื่มน้ำก็อ้วน งั้นทำไมข้าไม่ดื่มโค้กล่ะ?","ท่าทางที่กำเหลงแบกดาบวิ่งตลกมากเลย!","ลูกผู้ชายออกสู่โลกภายนอก สร้างงานใหญ่ไม่ได้ ไม้หญ้าผุเน่า?",},
        [37] = {37,"ลูกตุ้มดาวตกของเคาทูหนัก80ชั่ง เขาต้องวิ่งไม่ไวแน่!","กระเป๋าเงินของข้าตุงๆ ในนั้นมีแต่หนี้","ซุนเกี๋ยนเป็นผู้ชายที่แลกโล่อมตะูในรอบแรก!","ภูเขาไม่แก่ น้ำไหลไม่มีหยุด",},
        [38] = {38,"เตียวเลี้ยวถนัดตะบึงพันลี้ ข้าถนัดวิ่งชิงอันดับ1!","ขาพิการกับสละสาลี่ ใครวิ่งตลกกว่ากัน?","ซุนซ่างเซียงงามที่สุด โจมตีก็ระเบิดแรง!","สู้ได้ต้องสู้ สู้ไม่ได้ตั้งรับ ตั้งรับไม่ได้หนี หนีไม่ได้ยอมแพ้ ยอมแพ้ไม่ได้ยอมตาย!",},
        [39] = {39,"ในสี่สามงามสามก๊ก ข้าชอบเอียนสีที่สุด!","ส่องกระจกบ่อยๆ แล้วเจ้าจะเข้าใจเรื่องราวหลายอย่างเอง","ลกซุนคู่กับซุนเซ็ก ร้ายกาจมาก!","แผนอยู่ที่คน ผลอยู่ที่ฟ้า ฝืนไม่ได้! ",},
        [40] = {40,"โจผีประสานโจมตีโอบเอวเอียนสี เขาต้องวิ่งไม่ไวแน่!","เคยฝันว่าจะใช้กระบี่เดินทางท่องยุทธ์ภพ ภายหลังทำงานยุ่งไม่มีเวลาไป วันวันเล่นเกม","โลซกก็มึนงงลดโกรธได้!","เพลงพิณรู้ความนัย จอกเหล้าขอบคุณสหาย",},
        [41] = {41,"ขาสั้นๆของงักจิ้น วิ่งไม่ทันข้าหรอก!","แค่เป็นก้อนหิน ไปไหนก็ไม่เปล่งประกาย","โจจู๋กับขงเบ้ง ความคุมดีที่สุด!","พูดมากรับประโยชน์ ไม่สู้เงียบๆไร้คำพูด",},
        [42] = {42,"คนคือรถ ข้าวคือน้ำมัน! ไม่กินข้าวจะยิ่งไวได้ยังไง!","การศึกษา9ปีภาคบังคับเหมือนกับ ทำไมเจ้าถึงฉลาดนัก","เตียวเสี้ยนให้ลิโป้คืนสี่พิโรธ โจโฉดูแล้วบาดเจ็บ!","นภาปกคลุม แผ่นดินคล้ายเดินหมาก",},
        [43] = {43,"จูล่งอุ้มอาเต๊าเจ็ดเข้าเจ็ดออกได้ ต้องไวมากแน่!","ข้าอยากเป็นอาเต๊า เค้ามีแพนด้าด้วย!","พวกเจ้าลองไปตีตั๋งโต๊ะสายหลักดู เจ็บปวดเจียนตาย!","ทหารไม่ตระหนกยามค่ำคืน ข่าวลือไม่แตกตื่น",},
        [44] = {44,"เล่าปี่ใช้คุณธรรมกำราบ แต่วิ่งไม่ไวเท่าข้า!","ประดิษฐ์สุนัขมองคนต่ำคนที่พูดประโยคนี้ ต้องไม่เคยพบแมวแน่","มีขุนพลไล่โจมตีเพิ่มแข็งแกร่ง ฮัวหยงก็ใช่!","แต่โบราณมา มีเจริญย่อมมีล่มสลาย มีเฟื่องฟูยอมมีเสื่อมโทรม",},
        [45] = {45,"มังกรหลับชมดาวรู้เหตุการณ์บ้านเมือง วันนี้การแข่งข้าได้อันดับ1!","จักรวาลไม่ระเบิด เตียงก็ขี้เกียจลุก; โลกไม่เกิดใหม่ อย่าให้ข้าตื่นเช้า","ดาเมจพิษกาเซี่ยงระเบิดจริง!","ลูกผู้ชาย ไปได้มาได้ อ่อนได้แข็งได้; รุกได้ถอยได้ เบาได้แรงได้",},
        [46] = {46,"อิงเยี่ยเคยชมว่าข้าเป็นคนฉลาด ทั้งยังบอกวิธีแข่งให้ได้อันดับ1กับข้าด้วย!","ไม่มีใครรู้ว่าใครเป็นเต่า ต่างคิดว่าตัวเองเป็นกระต่ายทั้งนั้น","กองซุนจ้านทั้งมีนทั้งลดโกรธ ผ่านแผนที่ใช้ดี!","ทุกอย่างเตรียมพร้อม ขาดแต่ลมตะวันออก",},
        [47] = {47,"ท่านกวนอูร้ายกาจ ยังวิ่งสู้ข้าไม่ได้!","ทุกครั้งที่ต้องการเลิกล้ม ก็จะคิดว่าตัวเองยังมีหวัง การแข่งนี้โปรดชนะข้าก่อน!","เตียวก๊กทั้งเงียบขรึมคนอื่นได้ ยังไม่กลัวคนอื่นเงียบขรึม!","ลูกผู้ชายมีแต่กลัวไร้ผลงานชื่อเสียง ใยต้องกลัวไร้ภรรยา?",},
        [48] = {48,"ร้อยก้าวทะลุทะลวง คนแก่กล้าหาญ ฮองตงเก่งขนาดนี้กลับไม่มีคนใช้ เขาต้องเสียใจแน่!","ถ้าเรื่องราวไม่เป็นไปตามที่คิด โปรดจำไว้ โชคชะตาอาจมีลิขิตอื่น","เจ้าไปตีอิเกียดสิ อาจจะถูกพิษ!","เจ้าไม่ผิดต่อข้า ข้าก็ไม่ผิดต่อเจ้า",},
        [49] = {49,"ม้าเฉียวไม่ขี่ม้า ต้องวิ่งสู้ข้าไม่ได้!","เจ้าไม่มีวันรู้ว่า เจ้าลืมเรื่องหนึ่งไปตลอดกาล","อ้วนเสี้ยวทะลวง10จับคู่ลิโป้ ร้ายกาจจังเลย!","รู้ผลประโยชน์ส่วนรวม ทิ้งรายละเอียดเล็กๆ คอหลักการสุภาพชน",},
        [50] = {50,"เจ้าดูเกียงอุยถือธนูหน้าไม้มังกรทอง เหมือนกับกรรมการในสนามแข่ง!","นับแต่โบราณความรักห้ามไม่ได้ มักจะกุมอยู่กับหัวใจคน","อ้วนสุดคืนโทสะและลดโกรธ งามสูสีเสี่ยวเกี้ยว!","โชคดีที่ข้ามีพลังรบเบียดติด50อันดับแรก! หวังว่าวันนี้จะได้อันดับ1!",},
    }
}

return play_horse_player