--avatar_mapping

local avatar_mapping = {
    -- key
    __key_map = {
      id = 1,    --武将id-int 
      description = 2,    --神兵+25特性描述-string 
      description_1 = 3,    --神兵+50特性描述-string 
      description_2 = 4,    --神兵+75特性描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [2] = {2,"สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [3] = {3,"สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [4] = {4,"สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [5] = {5,"สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [6] = {11,"สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [7] = {12,"สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [8] = {13,"สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [9] = {14,"สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [10] = {15,"สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [11] = {101,"ร่ายสกิลมีโอกาส40%เพิ่มเติมสกิล1ครั้ง สร้างดาเมจเวทมนตร์41%ใส่ฝ่ายศัตรูทั้งหมด(สกิลที่เพิ่มเติมจะไม่มีสเตตัสพิเศษ)","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [12] = {102,"สกิลสร้างการรักษาเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [13] = {103,"ขุนพลออกทัพทั้งหมดมีโอกาสคริเพิ่ม30%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [14] = {104,"หลังจากร่ายสกิล จะฟื้นฟูโทสะของตนเอง1แต้มเป็นพิเศษ","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [15] = {105,"เมื่อถูกดาเมจโจมตีทั่วไป จะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [16] = {106,"เมื่อตายมีโอกาส100%มึนงงสังหารขุนพลฝ่ายศัตรูของตนเอง","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [17] = {107,"สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [18] = {108,"หลังจากสังหารเป้าหมาย จะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [19] = {109,"แต่ละรอบจะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [20] = {110,"ขุนพลออกทัพทั้งหมดมีโอกาสคริเพิ่ม20%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [21] = {111,"เป้าหมายสกิลลดทุกๆ1คน ดาเมจสกิลเพิ่มขึ้น10%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [22] = {112,"ดาเมจสกิล50%แปลงเป็นHP รักษาเพื่อนร่วมทีมฝ่ายเราที่มีHPต่ำสุด","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [23] = {113,"ดาเมจโจมตีทั่วไป50%แปลงเป็นรักษา รักษาตนเอง","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [24] = {114,"ออกรบรอบที่1สร้างดาเมจเกิดคริแน่นอน","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [25] = {115,"โอกาสร่ายสกิลเสริมเอฟเฟกต์เงียบขรึมเพิ่มถึง70%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [26] = {116,"โอกาสร่ายสกิลเสริมเอฟเฟกต์มึนงงเพิ่มถึง80%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [27] = {117,"ดาเมจสกิล40%แปลงเป็นHP รักษาเพื่อนร่วมทีมฝ่ายเราที่มีHPต่ำสุด","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [28] = {118,"โล่ลดเปอร์เซ็นต์การถูกดาเมจของเพื่อนร่วมทีมเพิ่มถึง45%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [29] = {119,"ถูกดาเมจสกิล20%แปลงเป็นHP รักษาตนเอง","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [30] = {150,"เมื่อเป้าหมายโจมตีสกิลเป็นขุนพลเพศหญิง ตนเองฟื้นฟูโทสะ2แต้ม เมื่อเป้าหมายโจมตีสกิลเป็นขุนพลเพศชายจะเพิ่มเติมโจมตีทั่วไปที่สร้างHPสูงสุด36% 1ครั้ง(โจมตีทั่วไปที่เพิ่มเติมจะไม่ฟื้นฟูโทสะ ไม่กระตุ้นสเตตัสพิเศษขุนพลใดๆ)","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [31] = {201,"หลังจากสังหารเป้าหมาย เพิ่มเติมโจมตีทั่วไป1ครั้ง(โจมตีทั่วไปที่เพิ่มเติมจะไม่ฟื้นฟูโทสะ)","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [32] = {202,"ถูกดาเมจ18%แปลงเป็นHP รักษาเป้าหมายทั้งหมดของฝ่ายเรา","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [33] = {203,"หลังจากร่ายสกิล ลดโทสะของเป้าหมาย1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [34] = {204,"หลังจากร่ายสกิล ฟื้นฟูโทสะของเพื่อนร่วมทีมทั้งหมด1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [35] = {205,"หลังจากสังหารเป้าหมาย จะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [36] = {206,"HPของตนเองลดลง10% โจมตีเพิ่ม5%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [37] = {207,"ได้รับการรักษาเพิ่ม50%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [38] = {208,"หลังจากสังหารเป้าหมาย เพิ่มเติมโจมตีทั่วไป1ครั้ง(โจมตีทั่วไปที่เพิ่มเติมจะไม่ฟื้นฟูโทสะ)","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [39] = {209,"แต่ละรอบตนเองโจมตีเพิ่ม8%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [40] = {210,"โอกาสร่ายสกิลเสริมเอฟเฟกต์มึนงงเพิ่มถึง65%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [41] = {211,"ขุนพลออกทัพทั้งหมดมีโอกาสคริเพิ่ม20%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [42] = {212,"หลังจากร่ายสกิล จะฟื้นฟูโทสะของตนเอง1แต้มเป็นพิเศษ","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [43] = {213,"สังหารเป้าหมาย1คน การโจมตีของตนเองเพิ่ม8%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [44] = {214,"ร่ายสกิล1ครั้งเมื่อตาย","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [45] = {215,"โล่ลดเปอร์เซ็นต์ถูกดาเมจของตนเองเพิ่มถึง45%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [46] = {216,"ร่ายสกิล1ครั้งเมื่อตาย","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [47] = {217,"สังหารเป้าหมายฟื้นฟูHPของตนเอง20%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [48] = {218,"สกิลสร้างดาเมจเพิ่ม15%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [49] = {219,"โอกาสร่ายสกิลเสริมเอฟเฟกต์เหน็บชาเพิ่มถึง70%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [50] = {250,"ศัตรูและเรา ทุกครั้งที่ฆ่าเป้าหมาย1คน ดาเมจของสุ่ยจิ้งเพิ่ม10%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [51] = {301,"เมื่อโจมตี โอกาสคริใส่เป้าหมายเผาไหม้เพิ่ม80%เป็นพิเศษ","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [52] = {302,"หลังจากร่ายสกิล เสริมเอฟเฟกต์รักษาต่อเนื่องให้เพื่อนร่วมทีมเพิ่มถึง32%ของพลังโจมตีของไต้เกี้ยว","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [53] = {303,"เมื่อถูกโจมตีทั่วไป มีโอกาส80%ทำให้ผู้โจมตีถูกเผาไหม้ ต่อเนื่อง2รอบ","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [54] = {304,"หลังจากร่ายสกิล เสริมโล่อมตะูดูดเลือดให้เพื่อนร่วมทีม2คนที่มีเลือดน้อยที่สุด ต่อเนื่อง1รอบ","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [55] = {305,"เมื่อถูกโจมตีทั่วไป มีโอกาส50%ทำให้ผู้โจมตีถูกเผาไหม้ ต่อเนื่อง2รอบ","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [56] = {306,"หลังจากสังหารเป้าหมายเผาไหม้ ฟื้นฟูHPของตนเอง50%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [57] = {307,"เมื่อร่ายสกิล ถ้าเป้าหมายอยู่ในสถานะเผาไหม้ เสริมอัตรามึนงงเพิ่มถึง80%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [58] = {308,"โจมตีทั่วไปสร้างดาเมจใส่เป้าหมายเผาไหม้เพิ่ม80%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [59] = {309,"เมื่อถูกศัตรูสถานะเผาไหม้โจมตี ถูกดาเมจลดลง65%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [60] = {310,"หลังจากร่ายสกิล เพิ่มเติมโจมตีทั่วไป1ครั้ง(โจมตีทั่วไปที่เพิ่มเติมจะไม่ฟื้นฟูโทสะ)","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [61] = {311,"ร่ายสกิลเสริมอัตราเผาไหม้เพิ่มถึง96%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [62] = {312,"หลังจากร่ายโจมตีทั่วไป ลดโทสะของเป้าหมายเป็นพิเศษ1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [63] = {313,"เมื่อถูกโจมตีทั่วไป มีโอกาส40%ทำให้ผู้โจมตีถูกเผาไหม้ ต่อเนื่อง2รอบ","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [64] = {314,"ได้รับเอฟเฟกต์รักษาเพิ่ม40%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [65] = {315,"โล่ดูดซับเปอร์เซ็นต์ดาเมจโจมตีของตนเองเพิ่มถึง100%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [66] = {316,"หลังจากสังหารเป้าหมาย จะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [67] = {317,"เมื่อร่ายสกิล ถ้าเป้าหมายอยู่ในสถานะเผาไหม้ เสริมอัตรามึนงงเพิ่มถึง80%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [68] = {318,"สกิลดาเมจใส่เป้าหมายเผาไหม้เพิ่ม80%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [69] = {319,"เมื่อถูกสกิลโจมตี มีโอกาส30%ทำให้ผู้โจมตีถูกเผาไหม้ ต่อเนื่อง2รอบ","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [70] = {350,"เมื่อเป้าหมายโจมตีสกิลเป็นขุนพลเพศชาย จะสร้างดาเมจHPสูงสุด10%เป็นพิเศษ เมื่อเป้าหมายโจมตีสกิลเป็นขุนพลเพศหญิง จะกำจัดเอฟเฟกต์ควบคุม(มึนงง เหน็บชา เงียบขรึม)บนเป้าหมาย2คนที่มีเลือดต่ำสุดของฝ่ายเรา","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [71] = {401,"โอกาสร่ายสกิลเสริมเอฟเฟกต์มึนงงเพิ่มถึง70%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [72] = {402,"เลือดของเป้าหมายทุกครั้งที่ลดลง10% จะสร้างการรักษาให้เป้าหมายเพิ่ม5%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [73] = {403,"หลังจากสังหารเป้าหมาย ฟื้นฟูโทสะของตนเอง2แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [74] = {404,"ดาเมจสกิล50%เปลี่ยนเป็นHP รักษาเพื่อนร่วมทีมที่มีHPน้อยที่สุดของฝ่ายเรา","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [75] = {405,"โล่ลดดาเมจลดเปอร์เซ็นต์การถูกดาเมจทั้งหมดเพิ่มถึง50%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [76] = {406,"หลังจากสังหารเป้าหมาย จะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [77] = {407,"โอกาสร่ายสกิลเสริมเอฟเฟกต์ถูกพิษเพิ่มถึง96%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [78] = {408,"หลังจากร่ายสกิล จะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [79] = {409,"หลังจากร่ายสกิล ลดโทสะของเป้าหมาย1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [80] = {410,"หลังจากร่ายสกิล ลดโทสะของเป้าหมาย1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [81] = {411,"โอกาสร่ายสกิลเสริมเอฟเฟกต์เหน็บชาเพิ่มถึง50%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [82] = {412,"Skill Damage increases by 25% .","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [83] = {413,"ออกรบรอบที่1สร้างดาเมจเกิดคริแน่นอน","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [84] = {414,"สังหารเป้าหมาย1คน การโจมตีของตนเองเพิ่ม8%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [85] = {415,"โอกาสร่ายสกิลเสริมเอฟเฟกต์มึนงงเพิ่มถึง80%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [86] = {416,"สกิลสร้างดาเมจเพิ่ม15%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [87] = {417,"หลังจากร่ายโจมตีทั่วไปจะฟื้นฟูโทสะของตนเอง1แต้มเป็นพิเศษ","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [88] = {418,"ดาเมจโจมตีทั่วไป50%แปลงเป็นHP รักษาตนเอง","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [89] = {419,"โอกาสร่ายสกิลเสริมเอฟเฟกต์เงียบขรึมเพิ่มถึง80%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [90] = {450,"ดาเมจสกิลเพิ่ม36% ดาเมจโจมตีทั่วไปเพิ่ม72%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
    }
}

return avatar_mapping