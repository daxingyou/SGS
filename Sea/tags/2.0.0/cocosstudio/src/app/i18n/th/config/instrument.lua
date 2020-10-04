--instrument

local instrument = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --名称-string 
      instrument_description = 3,    --神兵描述-string 
      hero = 4,    --相关武将-string 
      description = 5,    --神兵+25特性描述-string 
      description_1 = 6,    --神兵+50特性描述-string 
      description_2 = 7,    --神兵+75特性描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"ทวนฟ้า","หอกยาวเหล็กนิลที่ฝังอัญมณีดีมังกรหนักแน่นซ่อนพลังสวรรค์ร้าวไว้","ตัวเอกชาย","สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [2] = {2,"ดาบหมิงหง","ว่าดันว่าเป็นดาบที่หลอมเพื่อจักรพรรดิเหลืองหรูหราอลังกายดาบเหมือนใบไม้ร่วงตัดเหล็กเหมือนดิน","ตัวเอกหญิง","สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [3] = {101,"คทาหัวนกฮูก","คทาหัวอินทรีย์ดาบคมเหมือนน้ำค้างแสงหนาวเหน็บในช่วงที่ขนอินทรีย์สะลัดไอเย็นแผ่ซ่านแม้แต่ผียังขยาด","สุมาอี้","ร่ายสกิลมีโอกาส40%เพิ่มเติมสกิล1ครั้งสร้างดาเมจเวทมนตร์41%ใส่ฝ่ายศัตรูทั้งหมด(สกิลที่เพิ่มเติมจะไม่มีสเตตัสพิเศษ)","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [4] = {102,"ขลุ่ยหยกเขียว","บุรุษไร้ที่ติหยกงามไร้ตำหนิขลุ่ยหยกของซุนฮกลำโปร่งมันเงากระทบแสงเป็นภายในมีกลยุทธ์แฝงอยู่ภายใน","ซุนฮก","สกิลสร้างการรักษาเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [5] = {103,"กระบี่โจโฉ","กระบี่พกที่จักรพรรดิวุยโจโฉถือกระบี่ดูหรูหรายาวแปดฟุตตัวมีดกว้างโจโฉใช้ออกรบรวบรวมแผ่นดินผลงานนับไม่ถ้วน","โจโฉ","ขุนพลออกทัพทั้งหมดมีโอกาสคริเพิ่ม30%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [6] = {104,"พัดพันทัพ","ถือพัดมองบนที่สูงหมื่นล้านกองทัพอยู่ตรงหน้ากุยแกวางแผนรัดกุมปัญญาไร้เทียมทานช่วยโจโฉยึดแผ่นดินได้ครึ่งหนึ่ง","กุยแก","หลังจากร่ายสกิลจะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [7] = {105,"ดาบอสูรดุเดือด","ดาบอสูรที่ดุดันคมดาบแหลมคมแดงทั้งตัวถือดาบนี้ในสนามรบดาบคลั่งกระหายเลือดยิ่งรบยิ่งกล้าหาญ","แฮหัวตุ้น","เมื่อถูกดาเมจโจมตีทั่วไปจะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [8] = {106,"โล่หัวสิงโต","อาวุธรถถังโจป้องกันแน่นหนาชื่อรถถังไม่ได้ตั้งไว้ล้อเล่น","โจหยิน","เมื่อตายมีโอกาส100%มึนงงสังหารขุนพลฝ่ายศัตรูของตนเอง","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [9] = {107,"ง้าวสองมือ","เตียนอุยง้าวคู่หนัก80ชั่งหนักแน่นดั่งไท้ซานหนึ่งต้านสิบล่าพยัคฆ์กล้าหาญไร้เทียมทาน","เตียนอุย","สกิลสร้างดาเมจเพิ่ม25%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [10] = {108,"ค้อนดาวตก","ลูกตุ้มดาวตกนี้ไม่ธรรมดาเต็มไปด้วยหนามป้องกันแน่นหนาเสียงมีกำลังอยู่ในกองทัพแค่โบกสะบัดก็ทำร้ายคนได้","เคาทู","หลังจากสังหารเป้าหมายจะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [11] = {109,"เคียวทลายฟ้า","ดาบตะขอเกี่ยวด้ามยาวด้างหนึ่งเป็นดาบอีกด้านเป็นหอกออกทัพใช้ฆ่าศัตรูอย่างคล่องแคล่วแทงได้ฟันได้เกี่ยวได้ทำให้ทหารศัตรูป้องกันไม่ทัน","เตียวเลี้ยว","แต่ละรอบจะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [12] = {110,"กรงเล็กเจาะ","สองกรงเล็บหกแทงโหดเหี้ยมมากทำลายหัวกระโหลกคว้าโอกาสจับจุดอ่อนศัตรูเข้าใกล้ศัตรูจะเอาชีวิตเขาได้ในพริบตา","เตียวคับ","ขุนพลออกทัพทั้งหมดมีโอกาสคริเพิ่ม20%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [13] = {111,"กรงเล็บจิต","ดูดไอความมืดมากมายวิญญาณที่ไร้กฏไร้ลำดับไร้ตราจื้อฮวานคำรามไสหัวออกมา!ข้าถามเจ้ากลัวหรือไม่!!!","โจผี","เป้าหมายสกิลลดทุกๆ1คนดาเมจสกิลเพิ่มขึ้น10%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [14] = {112,"แส้เอียนสี","ในแส้นี้มีกลไกบนผิวมามีขุยสะบัดออกเป็นเปียได้สามารถปิดเพื่อแทงได้อยากรูกอยากรับหรือรัดหรือแทงพลิกแพลงตามใจชอบเหมือนเทพระบำหรืองูออกจากถ้ำทำให้ตาพราว","เอียนสี","ดาเมจสกิล50%แปลงเป็นHPรักษาเพื่อนร่วมทีมฝ่ายเราที่มีHPต่ำสุด","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [15] = {113,"กระบี่หมุน","ตอนที่งักจิ้นเป็นหนุ่มเคยพเนจรไปเมืองตะวันตกเรียนวรยุทธ์กับเมื่อเรียนจบราชครูจักรทองมอบอาวุธนี้ให้แก่งักจิ้น","งักจิ้น","ดาเมจโจมตีทั่วไป50%แปลงเป็นรักษารักษาตนเอง","","",},
        [16] = {114,"ขวานยาวคม","ซิหลงรักเกราะหัวฟ้าของเขามากเพื่อให้เข้ากับมันจึงควานหาขวานนี้มาจ่ายเงินก้อนโตเพราะมันเข้าคู่กับเกราะหัวของเขาสีขาวประกาย","ซิหลง","ออกรบรอบที่1สร้างดาเมจเกิดคริแน่นอน","","",},
        [17] = {115,"ไม้ตีช้าง","โจฉองชั่งช้างมีทั้งหมด3ขั้นตอนขั้นแรกเอาช้างวางบนตาชั่งขั้นที่สองเริ่มชั่งขั้นที่สามเริ่มบอกตัวเลขถ้ามีคนไม่เชื่อก็บอกกับเขาว่างั้นเจ้ามาลองชั่งดู","โจฉอง","โอกาสร่ายสกิลเสริมเอฟเฟกต์เงียบขรึมเพิ่มถึง70%","","",},
        [18] = {116,"เชือกมัวเร","โจสิดเขียนว่า:ต้มถั่วเผาเถาเป็นเชื้อไฟเสียงถั่วในหม้อร้องร่ำไห้ถั่วเถาเกิดจากหนึ่งสายใยไฉนเร่งเร้าเผาผลาญกันจนใจโจสิดที่เจ้าถูกใจคือภรรยาของพี่ชายเจ้านะ","โจสิด","โอกาสร่ายสกิลเสริมเอฟเฟกต์มึนงงเพิ่มถึง80%","","",},
        [19] = {117,"ธนูเสือดาว","ธนูนี้มองข้ามไม่ได้เป็นอาวุธเหมาะมือในการล่าเสือลูกธนูสามารถยิงทะลุปากเสือชีตาร์ยิ่งเมื่อบวกับความไวทำให้ลูกธนูที่ยิงออกมาเหมือนสายฟ้าล่าเสือชีตาร์ได้","แฮหัวเอี๋ยน","ดาเมจสกิล40%แปลงเป็นHPรักษาเพื่อนร่วมทีมฝ่ายเราที่มีHPต่ำสุด","","",},
        [20] = {118,"กระบี่ไร้ใจ","เตียวซุนฮัวติดตามสุมาอี้มาทั้งชีวิตไม่เคยไม่ทอดทิ้งถึงเหมือนไร้ใจแต่กลับมีใจที่ลำบากคือความคิดถึงดาบนี้คือดาบแม่ลูกเมื่อเผชิญหน้ากับศัตรูพลิกแพลงพิสดารทำให้ป้องกันไม่ทัน","เตียวซุนฮัว","โล่ลดเปอร์เซ็นต์การถูกดาเมจของเพื่อนร่วมทีมเพิ่มถึง45%","","",},
        [21] = {119,"ดาบสลาตัน","กระบี่ที่ไวปานสายฟ้าผ้าคลุมที่ไวปานสายฟ้าบุคลิกที่สง่าปานสายฟ้า~","อิกิ๋ม","ถูกดาเมจสกิล20%แปลงเป็นHPรักษาตนเอง","","",},
        [22] = {201,"ทวนเทพ","บารมีเทพดั่งมังกรจงรักภักดีทวนนี้เมื่อแทงออกไปจะเกิดมังกรเงินตัวหนึ่งบนท้องฟ้าเหาะเหินบนอากาศทำให้ศัตรูถูกฉีกเป็นชิ้นๆ","จูล่ง","หลังจากสังหารเป้าหมายเพิ่มเติมโจมตีทั่วไป1ครั้ง(โจมตีทั่วไปที่เพิ่มเติมจะไม่ฟื้นฟูโทสะ)","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [23] = {202,"กระบี่คู่ผัวเมีย","กระบี่คู่ผัวเมียหนึ่งเขียวหนึ่งม่วงว่ากันว่าหนึ่งคือร่างจำแลงมังกรเขียวหนึ่งคือร่างจำแลงมังกรม่วงผู้ที่ถือเป็นผู้นำยิ่งใหญ่สองกระบี่รวมเป็นหนึ่งกระบี่ยักษ์ดึงดูดพลังฟ้าดินถ่ายทอดคุณธรรม","เล่าปี่","ถูกดาเมจ18%แปลงเป็นHPรักษาเป้าหมายทั้งหมดของฝ่ายเรา","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [24] = {203,"พัดเจ็ดดาว","แกนพัดทำจากหยกขาวหน้าพัดทำจากปีกอินทรีย์แต้มเจ็ดดาวฝังปากั้วเมื่อโบกสะบัดเหมือนมังกรหลับสะบัดหางเรียกลมเรียกฝนได้และยังกำหนดแผ่นดินได้","จูกัดเหลียง","หลังจากร่ายสกิลลดโทสะของเป้าหมาย1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [25] = {204,"โคยนต์","หัวคดตัวเหลี่ยมหนึ่งขาสี่เท้า;เมื่อก้มหัวลิ้นส่งถึงท้องบรรจุของได้เยอะแต่เดินทางได้น้อยวัวมีสองล้อรูปร่างคนหกฟุต","อุยซี","หลังจากร่ายสกิลฟื้นฟูโทสะของเพื่อนร่วมทีมทั้งหมด1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [26] = {205,"ดาบมูนมังกร","ง้าวที่กวนอูรักมากว่ากันว่าด้ามง้าวเป็นร่างจำแลงของมังกรเขียวตัวดาบเหมือนเสี้ยวจันทร์คมมากตัดหัวศัตรูในสนามรบได้อย่างง่ายดาย","กวนอู","หลังจากสังหารเป้าหมายจะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [27] = {206,"ทวนอสรพิษ","เมื่อสาบานที่สวนท้อได้รับเงินช่วยเหลือจากพ่อค้าจงชาน500ชั่งตัวเหล็กหนัก1พันชั่งสร้างเป็นทวนด้ามยาวแปดจั้งเพราะตัวดาบพันด้วยงูจึงมีอีกชื่อว่าทวนอสรพิษ","เตียวหุย","HPของตนเองลดลง10%โจมตีเพิ่ม5%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [28] = {207,"ทวนหัวเสือ","มารดาของม้าเฉียวเป็นสตรีเผ่าเซียงดังนั้นทวนนี้จึงหลอมด้วยวิธีลับของชาวเซียงหนัก80ชั่งหัวทวนเป็นแกนกระดูกสันหลังเมื่อฆ่าศัตรูเหมือนเกิดมังกรเหลืองสามารถทำลายอวัยวะภายในของศัตรูให้แหลกได้","ม้าเฉียว","ได้รับการรักษาเพิ่ม50%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [29] = {208,"ธนูไฟแรง","ธนูนี้ของฮองตงแปลกมากเป็นดาบได้เป็นธนูได้สามารถฆ่าศัตรูในระยะประชิดและยิงในระยะไกลขุนพลวุยก๊กแฮหัวเอี๋ยนตายใต้ธนูนี้","ฮองตง","หลังจากสังหารเป้าหมายเพิ่มเติมโจมตีทั่วไป1ครั้ง(โจมตีทั่วไปที่เพิ่มเติมจะไม่ฟื้นฟูโทสะ)","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [30] = {209,"ธนูมังกรทอง","จูกัดเหลียงประดิษฐ์หน้าไม้ขงเบ้งและสร้างคันธนูด้วยตนเองภายหลังถ่ายทอดให้เกียงอุยตัวหน้าไม้ซ่อนลูกธนูได้หลายดอกยิงอย่างต่อเนื่องได้อานุภาพรุนแรง","เกียงอุย","แต่ละรอบตนเองโจมตีเพิ่ม8%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [31] = {210,"เคียวบ้าเลือด","ด้ามหลอมจากทองมีหยดเลือดบนดาบดาบเคียวกระหายเลือดปรากฏศัตรูต้องเลือดอาบสนามรบแน่นอน","อุยเอี๋ยน","โอกาสร่ายสกิลเสริมเอฟเฟกต์มึนงงเพิ่มถึง65%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [32] = {211,"คทาเวทย์หงส์","ตอนที่บังทองลงจากเขาซินแสกระจกเงาเคยมอบคทาเวทย์หงส์กำชับให้เขาสนับสนุนนายดีภายหลังบังทองใช้คทานี้ช่วยเล่าปี่ตั้งตนเป็นจักรพรรดิ","บังทอง","ขุนพลออกทัพทั้งหมดมีโอกาสคริเพิ่ม20%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [33] = {212,"กระบี่ไร้เงา","ตอนเด็กชีซีเป็นจอมยุทธ์เร่ร่อนในยุทธ์ภพภายหลังกลับใจมาศึกษาตำรามีกวีเต็มหัวแต่ก็กลัวคนวิจารณ์จึงได้นำกระบี่ซ่อนไว้ในพัดพกติดตัวตลอดเมื่อศัตรูไม่ระวังจะถูกปลิดชีพในทันที","ชีซี","หลังจากร่ายสกิลจะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [34] = {213,"กระบองสั่นดิน","เลือกไม้โบราณนับร้อยปีจากเขาซีหนานเอาแกนข้างในมาทำเป็นกระบองนี้คนทั่วไปแบกไม่ขึ้นมีแต่จอมพลังอย่างเบ้งเฮ็กถึงใช้ได้","เบ้งเฮ็ก","สังหารเป้าหมาย1คนการโจมตีของตนเองเพิ่ม8%","","",},
        [35] = {214,"ง้าวยอดเมฆา","จกหยงเติบโตบนเทือกเขาถนัดใช้ไม้ในป่ามาทำง้าวยาวง้าวนี้คมมากแม่นยำทำให้นายพรานกับศัตรูหนีไม่รอด","จกหยง","ร่ายสกิล1ครั้งเมื่อตาย","","",},
        [36] = {215,"ไผ่เขียววิถีจ๊ก","แพนด้ากลิ้งชอบกินไผ่ดังนั้นอาเต๊าน้อยใช้ไผ่ทำเป็นกระบี่เล็กๆเลยถูกเล่าปี่ต่อว่ายกใหญ่","อาเต๊า","โล่ลดเปอร์เซ็นต์ถูกดาเมจของตนเองเพิ่มถึง45%","","",},
        [37] = {216,"บัวเขียว","เรียนกับอาจารย์ฮัวโต๋และได้รับคำชี้แนะจากโจจู๋ด้ามเล็กๆเหมือนบัวเขียวน่ารักมีโอกาสรอดสูงปกป้องนายท่านออกจากทัพอย่างสบาย","เตียวซี","ร่ายสกิล1ครั้งเมื่อตาย","","",},
        [38] = {217,"ดาบยาวจันทร์","ดาบยาวเสี้ยวจันทร์ที่กวนอูสร้างด้วยมือแสงเขียวเสี้ยวจันทร์แสงเป็นประกาย","กวนอิ๋นผิง","สังหารเป้าหมายฟื้นฟูHPของตนเอง20%","","",},
        [39] = {218,"ดาบเกล็ดมังกร","ว่ากันว่ากวนอิ๋นผิงใช้วัสดุที่เหลือจากการทำดาบยาวเสี้ยวจันทร์มาสร้างช่วยไม่ได้ใครใช้ให้พวกเราเป็นลูกของเทพนักรบล่ะ","กวนเป๋ง","สกิลสร้างดาเมจเพิ่ม15%","","",},
        [40] = {219,"คทาเวทย์อสรพิษ","คทาที่ทำจากกระดานงูทองสามตัวว่ากันว่าแค่มองแว๊บเดียวก็จะถูกหวดเจ้งสะกดจิตได้ขยับไม่ได้","หวดเจ้ง","โอกาสร่ายสกิลเสริมเอฟเฟกต์เหน็บชาเพิ่มถึง70%","","",},
        [41] = {301,"เหล็กท่อนเทพ","กระบองคู่ของซุนเซ็กหลอมขึ้นจากศาสตราวุธโบราณภายในซ่อนกลไว้เปลี่ยนเป็นหมัดได้พลิกแพลงพิสดารแสดงให้เห็นถึงความสง่างามของป้าอ๋องน้อยซุนเซ็ก","ซุนเซ็ก","เมื่อโจมตีโอกาสคริใส่เป้าหมายเผาไหม้เพิ่ม80%เป็นพิเศษ","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [42] = {302,"ร่มบงกช","แกนร่มทำจากไผ่เขียวใช้ดอกบัวสวรรค์เป็นตัวร่มด้ามร่มทำจากไม้บนไท้ซานร่วมนี้มีพลังซ่อนอยู่พลังเต็มเปี่ยมอ้อนแอ่นอรชรทำให้จิตใจเบิกบาน","ไต้เกี้ยว","หลังจากร่ายสกิลเสริมเอฟเฟกต์รักษาต่อเนื่องให้เพื่อนร่วมทีมเพิ่มถึง32%ของพลังโจมตีของไต้เกี้ยว","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [43] = {303,"ดาบคลั่งตูตู","มีพกติดตัวของแม่ทัพภาคไม่ธรรมดาอยู่แล้วมีดนี้ตัวเหมือนหยกวาววับยาวแปดฟุตกว่าเชื่อมโยงใจกับเจ้าของเมื่อออกจากฝักสั่งทหารนับพันนับหมื่นเป็นแม่ทัพภาคที่สง่างาม","จิวยี่","เมื่อถูกโจมตีทั่วไปมีโอกาส80%ทำให้ผู้โจมตีถูกเผาไหม้ต่อเนื่อง2รอบ","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [44] = {304,"พัดคู่ดาว","แกนพัดทำจากทองหน้าพัดทำจากไหมมีความหรูหราซ่อนอยู่เหมือนเจ้านายของมันที่มีความอรชรโจมตีคล่องแคล่วงดงามไร้เทียมทาน","เสี่ยวเกี้ยว","ปล่อยสกิลแล้วทำให้ขุนพลฝ่ายเราที่เลือดน้อยสุด2คนพ่วงโล่ดูดเลือดอมตะ1อันต่อเนื่อง1กระบวนท่า","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [45] = {305,"ธนูตะวันตก","ว่ากันว่าธนูนี้เป็นธนูที่ฮั่นอู่ตี้ประทานให้ฮั่นชวี่ปิ้งภายหลังอยู่ในมือชาวบ้านบิดาไทสูจู้พบโดยบังเอิญไทสูจู้ใช้ธนูด้ามนี้ฝึกยิงมาตั้งแต่เด็กมีครั้งหนึ่งเผลอทำธนูตกใส่กองไฟทำให้ลุกไหม้ไทสูจู้จึงถูกบิดาตีนึกไม่ถึงว่าธนูนี้กลับไม่เป็นไรนับแต่นั้นธนูนี้ก็มีพลังเปลวไฟซ่อนอยู่ยิงแล้วทำให้คนเผาไหม้บิดาไทสูจู้ดีใจมากกล่าวว่าลูกข้าอนาคตต้องยิ่งใหญ่แน่แล้วก็หัวเราะสามทีตายด้วยความดีใจเมื่อไทสูจู้โตขึ้นก็เป็นคนกล้าหาญไม่ธรรมดายิงธนูเข้าเป้าทุกดอกกลายเป็นแม่ทัพใหญ่แห่งง่อก๊ก","ไทสูจู้","เมื่อถูกโจมตีทั่วไปมีโอกาส50%ทำให้ผู้โจมตีถูกเผาไหม้ต่อเนื่อง2รอบ","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [46] = {306,"กระบี่ชิงหมิง","ซุนกวนตั้งตนเป็นจักรพรรดิแล้วหลอมกระบี่หกด้ามด้วยตนเองหนึ่งไป๋หงสองจื่อเตี้ยนสามปี้เสียสี่หลิวซิงห้าชิงหมิงหกไป๋หลี่ภายหลังซุนกวนชอบกระบี่ชิงหมิงด้ามนี้ด้ามเดียว","ซุนกวน","หลังจากสังหารเป้าหมายเผาไหม้ฟื้นฟูHPของตนเอง50%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [47] = {307,"ตะขอดับฟ้า","ตอนที่ลิบองชุดขาวข้ามแม่น้ำใช้สมออันนี้ปลอมตัวเป็นชาวบ้านกับพ่อค้าถือโอกาสตียามของเกงจิ๋วสลบนำทหารเข้าบุกเมืองเกงจิ๋ว","ลิบอง","เมื่อร่ายสกิลถ้าเป้าหมายอยู่ในสถานะเผาไหม้เสริมอัตรามึนงงเพิ่มถึง80%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [48] = {308,"ดาบหางทอง","ดาบที่จอมยุทธ์พเนจรใบแพรกำเหลงพกติดตัวดูหรูหรามากแกสลักลายทองเผยให้เห็นถึงชุดที่ดูเท่ห์มีบารมีมีขนหงส์กระดิ่งทองเป็นสัญลักษณ์ของกำเหลง","กำเหลง","โจมตีทั่วไปสร้างดาเมจใส่เป้าหมายเผาไหม้เพิ่ม80%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [49] = {309,"โล่เปลวเดือด","โบราณว่ามีเมฆสิงเทียนระบำโล่ปณิธานองอาจโดยโล่ที่หมายถึงคือโล่ของซุนเกี๋ยนโล่เปลวเดือดของซุนเกี๋ยนหนักมากด้านหน้าหัวสัตว์เหมือนเสือลงจากเขาไฟคุกรุ่นภายหลังทำให้ศัตรูเผาไหม้ได้","ซุนเกี๋ยน","เมื่อถูกศัตรูสถานะเผาไหม้โจมตีถูกดาเมจลดลง65%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [50] = {310,"กงจักรอสูร","ซุนซ่างเซียงชอบเล่นดาบรำทวนตั้งแต่เด็กซุนเกี๋ยนจึงทำห่วงดาบคู่นี้ให้ลูกสาวสุดที่รักตอนโบกเหมือนจันทร์เพ็ญบนท้องฟ้าทั้งสวยทั้งคมผ่าศัตรูอย่างง่ายดาย","ซุนซ่างเซียง","หลังจากร่ายสกิลเพิ่มเติมโจมตีทั่วไป1ครั้ง(โจมตีทั่วไปที่เพิ่มเติมจะไม่ฟื้นฟูโทสะ)","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [51] = {311,"ดาบจันทร์","ลกซุนที่เป็นคนอ่อนน้อมอดทนตอนที่โบกสะบัดอาวุธนี้เกิดแสงประกายท่านจะเห็นแต่หน้ายิ้มอ่อนๆของเขาท่ามกลางแสงดาบเปลวไฟเผาฟ้าถ้าไม่ระวังจะกลายเป็นตอตะโก","ลกซุน","ร่ายสกิลเสริมอัตราเผาไหม้เพิ่มถึง96%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [52] = {312,"ชามสมบัติ","ท่านโลซกที่ใจบุญ เป็นมหาเศรษฐีรวยที่สุดในยุคสามก๊ก เริ่มตั้งรากฐานจากความยากจน เพราะชามสมบัติที่เทพโชคลาภทำตกไว้และเขาเก็บได้ ทำให้มีสมบัติไม่จบไม่สิ้น","โลซก","ปล่อยโจมตีทั่วไปแล้วลดโทสะเป้าหมาย1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [53] = {313,"กระบองสุญตา","สัญลักษณ์แรกเปิดฟ้าดินมันคือเกียรติยศที่ไม่มีวันสาบสูญของข้า;แค่เพราะอยู่บนเขาฮวากว่อเบื่อๆเลยขอลงมาโลกมนุษย์กระบองวิเศษแปลงร่างเป็นกระบองสุญตาต่อสู้ไม่มีพักเหนื่องอาบเลือดทั้งตัว;เผาไหม้ร้อนแรงทั้งตัวมีแต่ความกล้าหาญ","เล่งทอง","เมื่อถูกโจมตีทั่วไปมีโอกาส40%ทำให้ผู้โจมตีถูกเผาไหม้ต่อเนื่อง2รอบ","","",},
        [54] = {314,"แส้ตัดทะเล","ว่ากันว่าตอนที่จิวยี่ตีอุยกายใช้แส้ตัดทะเลของอุยกายตีจนอุยกายเนื้อแตกนอนติดเตียงจนโจโฉเชื่อในแผนยอมเจ็บตัว","อุยกาย","ได้รับเอฟเฟกต์รักษาเพิ่ม40%","","",},
        [55] = {315,"ป้ายหยกทอง","กลัวป้ายหยกทองในมือข้าไหมเห็นความร้ายกาจของปากพ่นไฟของข้าไหม","เตียวเจียว","โล่ดูดซับเปอร์เซ็นต์ดาเมจโจมตีของตนเองเพิ่มถึง100%","","",},
        [56] = {316,"ดาบดื้อรั้น","ดาบเหมือนสีจันทร์เหล็กเหมือนดาวตกตัวแกะสลักลายมังกรโบกสะบัดหวังแต่ทำลายศัตรูศัตรูไม่ตายดาบไม่หยุดภักดีต่อนายมาก","จิวท่าย","หลังจากสังหารเป้าหมายจะฟื้นฟูโทสะของตนเอง1แต้ม","","",},
        [57] = {317,"พิณอิสระ","ภูเขาสูงสายน้ำไหลดักซุ่มสิบทิศสราญรมย์วิญญาณว่างเสียงพิณไม่หยุดไพเราะเสนาะหูดีดทำร้ายศัตรู","ปู้ฮูหยิน","เมื่อร่ายสกิลถ้าเป้าหมายอยู่ในสถานะเผาไหม้เสริมอัตรามึนงงเพิ่มถึง80%","","",},
        [58] = {318,"ธนูสะท้านฟ้า","ใช้งาช้างเป็นแกนอัญมณีฝังธนูสะท้านฟ้ายิงออกเด็ดหัวศัตรูเหมือนล้วงของในกระเป๋า","ฮันต๋ง","สกิลดาเมจใส่เป้าหมายเผาไหม้เพิ่ม80%","","",},
        [59] = {319,"โคมเมฆมงคล","โคมที่ทำจากทองสืบทอดกรรมวิธีมาแต่โบราณหรูหราอลังการแถมยังซ่อนพลังเผาไหม้ไว้ด้วย","จูกัดกิ๋น","เมื่อถูกสกิลโจมตีมีโอกาส30%ทำให้ผู้โจมตีถูกเผาไหม้ต่อเนื่อง2รอบ","","",},
        [60] = {401,"แส้ไท้ซู","แส้นักพรตที่สืบทอดมาแต่โบราณดูเหมือนธรรมดาจริงๆแล้วไม่ธรรมดานิ่งเหมือนใต้ทะเลลึกขยับเหมือนเหินหาวควบคุมกระบี่เซียนดั่งมังกรน้ำทำให้เกิดเกล็ดน้ำแข็ง","โจจู๋","โอกาสร่ายสกิลเสริมเอฟเฟกต์มึนงงเพิ่มถึง70%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [61] = {402,"คทาเทียนซู","คทาที่ฮัวโต๋เพื่อนโจจู๋เด็ดกิ่งท้อมาทำใช้เป็นไม้เท้าผยุงขึ้นเขาเก็บยาได้แถมยังเอามาเป็นกระสัยยาเพิ่มเลือดได้","ฮัวโต๋","เลือดของเป้าหมายทุกครั้งที่ลดลง10%จะสร้างการรักษาให้เป้าหมายเพิ่ม5%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [62] = {403,"ง้าวกรีดนภา","ดาบสองง่ามสามหนักร้อยชั่งใช้วิธีถ่วงทำได้ทั้งชนฟันแทงผ่า;ใช้วิธีในสามารถตลบเกี่ยวตอกพลิกแทง;ใช้วิธีต้านสามารถพุ่งเลือกฟาดลิโป้ใช้ง้าวนี้ในสนามรบสร้างชื่อเสียงไร้เทียมทาน","ลิโป้","หลังจากสังหารเป้าหมายฟื้นฟูโทสะของตนเอง2แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [63] = {404,"เซียนงาม","ดอกบัวที่ซ่อนไอฟ้าดินเอาไว้ท่าทางไม่ธรรมดาเกิดในโคลนตกงามเหนือสิ่งใด","เตียวเสี้ยน","ดาเมจสกิล50%เปลี่ยนเป็นHPรักษาเพื่อนร่วมทีมที่มีHPน้อยที่สุดของฝ่ายเรา","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [64] = {405,"ตะขออ๋องมาร","ไฟเผาลกเอี๋ยงเอากระโหลกของคนที่แข็งแกร่งที่สุดมาใช้ดาบเจ็ดดาบลับทำเป็นตะขออ๋องมารนี้ตะของนี้ปรากฏต้องเกิดเลือด!","ตั๋งโต๊ะ","โล่ลดดาเมจลดเปอร์เซ็นต์การถูกดาเมจทั้งหมดเพิ่มถึง50%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [65] = {406,"ขวานผ่าฟ้า","ด้ามขวานที่ทำจากไม้เสเหลียงใช้ตัวดาบทำจากเหล็กนิลของเลียงจิ๋วตัวเป็นสีม่วงเข้มฝังอัญมณีหยกเขียวผู้ถือมีความสง่างามแต่ถ้าพบมังกรเขียวจะตายอนาถ","ฮัวหยง","หลังจากสังหารเป้าหมายจะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [66] = {407,"พู่กันยมบาล","ถ้าข้าให้เจ้าอยู่ไม่เกินยามสามใครกล้าให้เจ้าอยู่ถึงยามห้าพู่กันในมือกาเซี่ยงซ่อนด้วยน้ำพิษทำให้ศัตรูตายด้วยพิษอย่างง่ายดาย","กาเซี่ยง","โอกาสร่ายสกิลเสริมเอฟเฟกต์ถูกพิษเพิ่มถึง96%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [67] = {408,"ทวนเมฆบิน","กองซุนจ้านนำทหารสามพันตีเลียวไสอูหวนหัวหน้าอูหวนนำทหารมาขอสวามิภักดิ์กองซุนจ้านและมอบทวนนี้ชื่อว่าทวนเมฆบิน","กองซุนจ้าน","หลังจากร่ายสกิลจะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [68] = {409,"คทาเขาแพะ","คทาหัวแพะทำจากทองในนั้นซ่อนพลังสายฟ้าได้เมื่อใช้งานฟ้าดินปั่นป่วนเหมือนจะถล่ม","เตียวก๊ก","หลังจากร่ายสกิลลดโทสะของเป้าหมาย1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [69] = {410,"หุ่นพิษ","หุ่นเชิดทำจากไม้ที่อิเกียดใช้ในท้องว่างซ่อนน้ำพิษแค่หยดเดียวก็ทำให้ตายได้","อิเกียด","หลังจากร่ายสกิลลดโทสะของเป้าหมาย1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [70] = {411,"กระบี่อหังการ","ตระกูลอ้วนแห่งยีหลำคือตระกูลสามพระยาสี่รุ่นในตำหนักเต็มไปด้วยสมบัติดระบี่ด้ามนี้คมมากเหมาะกับวีรบุรุษที่มีใจทำเพื่อแผ่นดินดังนั้นจึงมอบให้อ้วนเสี้ยว","อ้วนเสี้ยว","โอกาสร่ายสกิลเสริมเอฟเฟกต์เหน็บชาเพิ่มถึง50%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [71] = {412,"ตราแผ่นดิน","หลี่ซือเสนาบดีฉินรับบัญชาจักรพรรดิจิ๋นซีทำจากหยกเหอซื่อปี้เป็นหลักฐานสืบทอดตำแหน่งจักรพรรดิขนาดสี่เหลี่ยม4นิ้วมีมังกรห้าตัวโอรสสวรรค์ตัวจริงได้รับตรานี้จะได้ครองแผ่นดิน;ถ้าไม่ใช่โอรสสวรรค์ตัวจริงต้องตายอย่างอนาถ","อ้วนสุด","หลังจากร่ายสกิลจะฟื้นฟูโทสะของตนเอง1แต้ม","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [72] = {413,"ดาบผ่าฟ้า","ดาบผ่าอากาศยาวมากยากขนาดไหขนาดที่เป็นอันดับ1ในอาวุธสั้น","งันเหลียง","ออกรบรอบที่1สร้างดาเมจเกิดคริแน่นอน","","",},
        [73] = {414,"ค้อนตีภูผา","อายุคือดาบเล่มหนึ่งผ่าภูผาคือค้อนของตัวด้วง","บุนทิว","สังหารเป้าหมาย1คนการโจมตีของตนเองเพิ่ม8%","","",},
        [74] = {415,"พิณเศร้า","ในฐานะอาวุธของสาวงามชื่อดังพิณนี้เป็นของดังจากเมืองตะวันตกหัวม้าตัวเหลี่ยมสายพิณคู่ซัวบุ้นกี๋ดีดเกิดเสียงกังวานแต่ดีดเบาๆเหมือนเสียงโหยหวน","ซัวบุ้นกี๋","โอกาสร่ายสกิลเสริมเอฟเฟกต์มึนงงเพิ่มถึง80%","","",},
        [75] = {416,"กระบี่บ่อ","กระบี่โบราญชื่อดังผ่านมรสุมมามากมายไม่ว่าเป็นเจ้านายดีหรือกังฉินโฉดแน่จริงก็ฆ่า;ไม่แน่จริงก็ด่าข้าขอเป็นกระบี่แค่นั้น","ตันก๋ง","สกิลสร้างดาเมจเพิ่ม15%","","",},
        [76] = {417,"ม้าไม้ไผ่","เพราะตอนเด็กสละสาลีให้ลูกหนึ่งม้าไม้ไผ่เล็กๆจึงกลายเป็นอาวุธของขงหยงส่วนที่ว่าเขาเป็นทายาทของขงจื้อหรือขุนนางปลายยุคฮั่นไม่มีใครรู้","ขงหยง","หลังจากร่ายโจมตีทั่วไปจะฟื้นฟูโทสะของตนเอง1แต้มเป็นพิเศษ","","",},
        [77] = {418,"ง้าวกรีดนภาเล็ก","แค่ดูชื่อของอาวุธก็รู้ฐานะของเจ้านายแล้ว","หลี่หลิงจวี","ดาเมจโจมตีทั่วไป50%แปลงเป็นHPรักษาตนเอง","","",},
        [78] = {419,"กระไกร","กรรไกรนี้ลอยอยู่กลางอากาศใช้พลังตัดที่ไม่มีใครต้านได้รีบจับกางเกงในของท่านไว้เร็ว","เตียวเหยียง","โอกาสร่ายสกิลเสริมเอฟเฟกต์เงียบขรึมเพิ่มถึง80%","","",},
        [79] = {150,"ดาบฆ่านรก","ดาบที่สร้างจากพลังนรกภูมิว่ากันว่ามีวิญญาณฝังอยู่ใช้วิญญาณขับไล่วิญญาณ","จื่อซ่าง","ปล่อยสกิลโจมตีขุนพลเพศหญิงแล้วฟื้นฟูโทสะของตนเอง2แต้มปล่อยสกิลโจมตีเพศชายเพิ่มการสร้างโจมตีทั่วไปด้วยดาเมจMax.HP36%อีก1ครั้ง","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [80] = {250,"พิณวารีนภา","มีนามเหมือนลำธารไพเราะรวมวิญญาณทั่วหล้าพลังถาโถมภูเขาสูงสายน้ำไหลรวมเป็นหนึ่งกับวิญญาณธรรมชาติ","สุ่ยจิ้ง","บนสนามรบทุกครั้งที่มีคนตาย1คนดาเมจเพิ่ม10%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [81] = {350,"ดาบหงส์","ว่ากันว่าดวงจิตของหงส์รวมอยู่ในกระบี่เมื่อบัวแดงเบ่งบานอาบไฟแล้วเกิดใหม่","พระสนมโซว","ปล่อยสกิลโจมตีขุนพลเพศชายสร้างดาเมจMax.HPเพิ่มอีก10%ปล่อยสกิลโจมตีขุนพลเพศหญิงจะกำจัดเอฟเฟกต์ควบคุมให้กับผู้เล่นที่เลือดต่ำสุดฝ่ายเรา2คนได้รับ","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
        [82] = {450,"คทาล่าจิต","คทาพืชทองที่รวมพลังไม่มีจำกัดว่ากันว่าผู้ครอบครองจะมีพลังสูงส่งยืดอายุขัยจากแก่กลับเป็นเด็ก","หนานหัว","ดาเมจสกิลเพิ่ม36%ดาเมจโจมตีทั่วไปเพิ่ม72%","โทสะเบื้องต้น+1","โทสะเบื้องต้น+1",},
    }
}

return instrument