--horse

local horse = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name = 2,    --装备名称-string 
      description = 3,    --装备描述-string 
      type = 4,    --泛用性-string 
      show_day = 5,    --图鉴显示天数-int 
      hero = 6,    --适用武将_math-string 
    
    },
    -- data
    _data = {
        [1] = {1,"ม้าชิงจุย","ม้าชิงจุย ม้างามสีขาวนวล อยู่ในสนามรบโดยไม่กลัวใคร มีความไวระดับที่หลบธนูได้","ทั้งหมด",0,"999",},
        [2] = {2,"ม้าหูเขียว","ม้าหูเขียว ม้าสีขาว หนึ่งในแปดยอดอาชา เดินทางพันลี้ ไม่มีเหนื่อย","ทั้งหมด",0,"999",},
        [3] = {3,"ม้าชูหวาง","ม้าชูหวาง สีเหลืองทั้งตัวเหมือนชื่อ หนึ่งในแปดยอดอาชา หนึ่งร่างสิบเงา ไวมาก","ทั้งหมด",0,"999",},
        [4] = {4,"ม้าเจาหลิว","ม้าเจาหลิว ตัวสีน้ำตาล กล้ามแข็งเหมือนเหล็ก กำลังดีมาก แบกของหนักร้อยชั่งได้ เดินเหมือนบิน","ทั้งหมด",0,"999",},
        [5] = {5,"ม้าหิมะขาว","ม้าหิมะขาว ตัวสีขาวหิมะ กีบเท้าสีดำ เหนียบหิมะเหมือนเหยียบพื้นราบ สุภาพบุรุษแห่งอาชา","ทั้งหมด",0,"999",},
        [6] = {6,"ม้าซ่าลู่ซื่อ","ม้าซ่าลู่ซื่อ เหมือนนางแอ่นสีม่วง ยิ่งใหญ่ทระนง ผงาดสามลำธาร บารมีแปดทิศ","ทั้งหมด",0,"999",},
        [7] = {7,"ม้าหงอวี้เหนี่ยน","ม้าหงอวี้เหนี่ยน ตัวเหมือนหยกแดง ม้าโอรสมังแรกแท้ เป็นมงคลสมปรารถนา","ทั้งหมด",0,"999",},
        [8] = {8,"ม้าปี้ชง","ม้าปี้ชง ตัวเป็นสีขาวคราม รูปร่างกำยำ วิ่งคล้ายมังกร ความไวยอดเยี่ยม","ทั้งหมด",0,"999",},
        [9] = {9,"ม้าพันลี้","ม้าพันลี้ ร่างกายเหมือนหิมะน้ำแข็ง เบาหวิวลึกลับ เดินทางหมื่นลี้ไม่มีเหนื่อย ที่ที่ไปเหมือนบินข้ามเกล็ดน้ำแข็ง ความเย็นแผ่ซ่าน ทำให้คนไม่กล้าเข้าใกล้","ประเภทสนับสนุน",40,"103|110|112|117|118|204|211|304|315|404|412|417",},
        [10] = {10,"ม้าเมฆดำ","ม้าเมฆดำ ตัวดำเงาวาว มีเพียงกีบเท้าที่เป็นขาว หลังตรงเรียบสั้น ขาทั้ง่มีกำลังดี สวมเกราะหนัก ไปจนตาย","ประเภทโจมตี",40,"1|2|3|4|5|11|12|13|14|15|101|107|108|109|111|113|114|201|205|206|208|209|213|217|218|301|306|308|310|316|318|3|403|406|407|410|413|414|416",},
        [11] = {11,"ม้ามังกรไฟ","ม้ามังกรไฟ ทั้งตัวเป็นแดงเพลิง ไม่มีขนอื่นแซมเลย เยงคำรามดังกังวาน มีลักษณะเหินฟ้าลงทะเล ขนคล้ายเกลียวคลื่น นุ่มเหมือนผมสาวน้อย วิ่งไวเหมือนบิน ขึ้นเขาลงห้วย เหมือนเหยียบพื้นราบ","ประเภทรักษา",40,"102|202|302|402|216",},
        [12] = {12,"ม้ายู่ซือ","ม้ายู่ซือ ขาวเหมือนหิมะ มีแค่ที่คอกับหางที่มีทอง ขาใหญ่ เหมือนราชห์ นิสัยขี้โมโห เดินทางได้วันละพันลี้ กระโดดข้ามหุบเหวได้ เข้าออกสนามรบเหมือนดินแดนไร้คน","ประเภทสนับสนุนควบคุม",40,"103|106|110|112|115|116|117|118|203|204|210|211|212|214|219|304|307|312|315|317|401|404|408|409|411|412|415|419|417",},
        [13] = {15,"ม้าสายฟ้า","อาชาพยัคฆ์สายฟ้าไล่ล่าหมื่นลี้ ผงาดไร้เทียมทาน บนตัวมีสายฟ้า กีบขามีแสง ตอนวิ่งเหมือนมีเสียงสายฟ้าคำราม รู้นิสัยมนุษย์ มีความอดทนสูง ช่วยสร้างผลงานในสนามรบหลายครั้ง","ประเภทแทงค์",999,"105|119|207|215|309|314|405|418",},
        [14] = {13,"เทพ·ม้าเจ่าหวง","เทพ·ม้าเจ่าหวง ตัวเป็นขาวหิมะ ่กีบเท้าเป็นเหลือง ท่าทางงามสง่า ไม่เหมือนใคร เป็นยอดอาชาในฝูงม้า","ทั้งหมด",9999,"999",},
        [15] = {14,"เทพ·ม้าเต็กเลา","เทพ·ม้าเต็กเลา นิสัยดุร้าย มีความไวเป็นเลิศ สามารถทะลุน้ำได้ กระโดดทีสามฟุต ข้ามลำธารได้อย่างสบาย","ทั้งหมด",9999,"999",},
    }
}

return horse