--title

local title = {
    -- key
    __key_map = {
      id = 1,    --序号_key-int 
      name = 2,    --名称-string 
      des = 3,    --条件描述-string 
      description = 4,    --详情描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"จอมคลั่ง","ล็อคอินสะสมถึง 99 วัน","ล็อคอินสะสมถึง 99 วัน",},
        [2] = {2,"เก่งได้อีก","ผู้เล่นได้ชนะที่ทายถูกสะ สม 99 ครั้งในเส้นฮัวหยง","ผู้เล่นได้ชนะที่ทายถูกสะ สม 99 ครั้งในเส้นฮัวหยง",},
        [3] = {3,"ฟินฝุดๆ","ได้รับอุปกรณ์แดงใด 1 ชิ้น ในหีบทองคำ","ได้รับอุปกรณ์แดงใด 1 ชิ้น ในหีบทองคำ",},
        [4] = {4,"เจ้าสำราญ","ได้รับชุดแดงใด 1 ชิ้น ในกิจกรรมตัดหนวดหนีไป","ได้รับชุดแดงใด 1 ชิ้น ในกิจกรรมตัดหนวดหนีไป",},
        [5] = {5,"จอมยุทธ์ชุดแดง","ได้รับชุดแดงใดก็ได้ 1 ชิ้นในกิจกรรมตัดหนวดหนีตาย","ได้รับชุดแดงใดก็ได้ 1 ชิ้นในกิจกรรมแพ้หัวซุกหัวซุน",},
        [6] = {6,"จอมอลัง","ได้รับปีกจำแลงไตรวิสุทธิ์1ชิ้นในกิจกรรมแปลงร่างสกิน","ได้รับปีกจำแลงไตรวิสุทธิ์1ชิ้นในกิจกรรมแปลงร่างสกิน",},
        [7] = {7,"ผู้กล้าสุดแกร่ง","อันดับ1สนามประลองรายวัน","อันดับ1สนามประลองรายวัน",},
        [8] = {8,"ผู้ทรงอำนาจ","มีขุนพลทั้งหมด(ไม่รวม ส้มอัปแดง)","มีขุนพลทั้งหมด(ไม่รวม ส้มอัปแดง)",},
        [9] = {9,"10ยอดพลังรบ","ชาร์ตอันดับ","ชาร์ตอันดับ",},
        [10] = {10,"พร้อมลุย","ถูกสังหาร 999 ครั้งในศึกแร่","ถูกสังหาร 999 ครั้งในศึกแร่",},
        [11] = {11,"ผู้นำวุยก๊ก","แชมป์วุยก๊กประลองค่าย","แชมป์วุยก๊กประลองค่าย",},
        [12] = {12,"ผู้นำจ๊กก๊ก","แชมป์จ๊กก๊กประลองค่าย","แชมป์จ๊กก๊กประลองค่าย",},
        [13] = {13,"ผู้นำง่อก๊ก","แชมป์ง่อก๊กประลองค่าย","แชมป์ง่อก๊กประลองค่าย",},
        [14] = {14,"ผู้นำกลุ่มก๊ก","แชมป์วีรบุรุษประลองค่าย","แชมป์วีรบุรุษประลองค่าย",},
        [15] = {15,"หมาน้อยโชคดี","ได้รับปีกจำแลงอรชร1ชิ้นในกิจกรรมแปลงร่างสกิน","ได้รับปีกจำแลงอรชร1ชิ้นในกิจกรรมแปลงร่างสกิน",},
        [16] = {16,"ผู้ครองสรรพสิ่ง","มีการ์ดแปลงร่างทั้งหมด","มีการ์ดแปลงร่างทั้งหมด",},
        [17] = {17,"ยอดฝีมือ","4คนสุดท้ายประลองส่วนตัวข้ามเซิร์ฟแต่ละสัปดาห์4","4คนสุดท้ายประลองส่วนตัวข้ามเซิร์ฟแต่ละสัปดาห์4",},
        [18] = {18,"เจ๋งเกินใคร","สังหารผู้เล่นสะสม999คนในศึกแร่","สังหารผู้เล่นสะสม999คนในศึกแร่",},
        [19] = {19,"ผู้คนต่างสยบ","จัดชาร์ตอันดับ 2-10 เมื่อจบฤดูแข่งขันศึกราชา","จัดชาร์ตอันดับ 2-10 เมื่อจบฤดูแข่งขันศึกราชา",},
        [20] = {20,"หนึ่งในใต้หล้า","แชมป์ประลองส่วนตัวข้ามเซิร์ฟแต่ละสัปดาห์4","แชมป์ประลองส่วนตัวข้ามเซิร์ฟแต่ละสัปดาห์4",},
        [21] = {21,"ทั่วหล้าคำนับ","จัดชาร์ตอันดับ1เมื่อจบฤดูแข่งขันศึกราชา","จัดชาร์ตอันดับ1เมื่อจบฤดูแข่งขันศึกราชา",},
        [22] = {22,"ผู้มั่งมี","มีการ์ดแปลงร่างสีแดงทั้งหมด","มีการ์ดแปลงร่างสีแดงทั้งหมด",},
        [23] = {23,"ผู้แนะนำมือใหม่","ผู้แนะนำมือใหม่เกม","ผู้แนะนำมือใหม่เกม",},
        [24] = {24,"ปณิธานทั่วทิศ","ฉายาจำกัดเฉพาะระลึก 100 สัปดาห์บอร์ดเกม","ฉายาจำกัดเฉพาะระลึก 100 สัปดาห์บอร์ดเกม",},
        [25] = {25,"ลมพายุพัดโหม","ฉายาจำกัดเฉพาะกิจกรรมเค้ก มีผล 30 วัน","ฉายาจำกัดเฉพาะกิจกรรมเค้ก มีผล 30 วัน",},
        [26] = {26,"พลังล้ำเลิศ","ฉายาจำกัดเฉพาะกิจกรรมเค้ก มีผล 30 วัน","ฉายาจำกัดเฉพาะกิจกรรมเค้ก มีผล 30 วัน",},
        [27] = {27,"ฝ่าฟันหมื่นลี้","ฉายาจำกัดเฉพาะกิจกรรมเค้ก มีผล 30 วัน","ฉายาจำกัดเฉพาะกิจกรรมเค้ก มีผล 30 วัน",},
        [28] = {28,"พายุเทียมฟ้า","ฉายาเฉพาะกิจกรรมพบมังกรในทุ่ง","ฉายาเฉพาะกิจกรรมพบมังกรในทุ่ง",},
        [29] = {29,"มังกรซ่อนเล็บ","ฉายาเฉพาะกิจกรรมพบมังกรในทุ่ง","ฉายาเฉพาะกิจกรรมพบมังกรในทุ่ง",},
        [30] = {30,"เหนือเหล่าปวงชน","ฉายาเฉพาะกิจกรรมพบมังกรในทุ่ง","ฉายาเฉพาะกิจกรรมพบมังกรในทุ่ง",},
        [31] = {1001,"ปีใหม่2020","ช่วงกิจกรรมปีใหม่2020 ล็อคอิน1วัน","ช่วงกิจกรรมปีใหม่2020 ล็อคอิน1วัน",},
        [32] = {1002,"สมปรารถนา","ช่วงกิจกรรมปีใหม่2020 ถึงLv.20ขึ้นไป","ช่วงกิจกรรมปีใหม่2020 ถึงLv.20ขึ้นไป",},
        [33] = {1003,"สุขสันต์ตรุษจีน","ช่วงกิจกรรมปีใหม่2020 ถึงLv.40ขึ้นไป","ช่วงกิจกรรมปีใหม่2020 ถึงLv.40ขึ้นไป",},
        [34] = {1004,"ร่ำรวยตรุษจีน","ช่วงกิจกรรมปีใหม่2020 สุ่มเติมเงินตามใจชอบ","ช่วงกิจกรรมปีใหม่2020 สุ่มเติมเงินตามใจชอบ",},
        [35] = {1005,"ร่ำรวยรุ่งเรือง","ช่วงกิจกรรมปีใหม่2020 ช่วงกิจกรรม เติมสะสม5000K","ช่วงกิจกรรมปีใหม่2020 ช่วงกิจกรรม เติมสะสม5000K",},
        [36] = {8023,"ดาวแห่งสมาคม","运营活动获得","運營活動獲得",},
        [37] = {8024,"แสงแห่งวุยก๊ก","运营活动获得","運營活動獲得",},
        [38] = {8025,"แสงแห่งจ๊กก๊ก","运营活动获得","運營活動獲得",},
        [39] = {8026,"แสงแห่งง่อก๊ก","运营活动获得","運營活動獲得",},
        [40] = {8027,"แสงแห่งกลุ่มก๊ก","运营活动获得","運營活動獲得",},
        [41] = {8028,"金色传说","运营活动获得","运营活动获得",},
        [42] = {8029,"天才小画师","运营活动获得","运营活动获得",},
        [43] = {9013,"นักแปล","ช่วยเหลือผู้พัฒนาเพื่อการแปลเกมและแก้ไขการแปล","ช่วยเหลือผู้พัฒนาเพื่อการแปลเกมและแก้ไขการแปล",},
    }
}

return title