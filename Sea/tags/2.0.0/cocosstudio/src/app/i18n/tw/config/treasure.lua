--treasure

local treasure = {
    -- key
    __key_map = {
      id = 1,    --编号_key-int 
      name = 2,    --宝物名称-繁体-string 
      description = 3,    --宝物描述-繁体-string 
      is_work = 4,    --生效-int 
    
    },
    -- data
    _data = {
        [1] = {101,"吳子","戰國名將吳起著.吳起為孔門弟子, 通曉兵家法家儒家, 和孫子連稱孫吳.",1,},
        [2] = {102,"三略","原稱黃石公三略, 糅合諸子各家的思想, 專論治國用兵戰略的兵書.",1,},
        [3] = {201,"鬼谷子","鬼谷子被譽為千古奇人, 通天徹地, 人不能及, 著有鬼谷子兵書十四篇傳世.",1,},
        [4] = {202,"遁甲術","奇門遁甲為道家不外傳秘術, 奪天地造化之學, 相傳左慈曾習得此術.",1,},
        [5] = {203,"司馬法","相傳為春秋時期姜太公所作, 是現存中國最古老的兵書.",1,},
        [6] = {301,"孫子兵法","最著名的兵書, 春秋時期孫武所著, 博大精深, 被譽為兵學聖典.",1,},
        [7] = {302,"武侯新書","又名將苑, 諸葛亮用兵如神, 此書記錄諸葛軍事思想, 討論為將之道.",1,},
        [8] = {303,"孟德新書","曹操半生戎馬, 在前人的基礎上總結並創新, 成就了這本孟德新書.",1,},
        [9] = {304,"太平要術","相傳張角入山采藥, 遇南華老仙, 授之太平要術, 後創立太平道.",1,},
        [10] = {401,"界·孫子兵法","最著名的兵書, 春秋時期孫武所著, 博大精深, 被譽為兵學聖典.",1,},
        [11] = {402,"界·武侯新書","又名將苑, 諸葛亮用兵如神, 此書記錄諸葛軍事思想, 討論為將之道.",1,},
        [12] = {403,"界·孟德新書","曹操半生戎馬, 在前人的基礎上總結並創新, 成就了這本孟德新書.",1,},
        [13] = {404,"界·太平要術","相傳張角入山采藥, 遇南華老仙, 授之太平要術, 後創立太平道.",1,},
        [14] = {111,"奔牛符","許褚有倒拖牛尾之勇, 故曹操特為他打造此兵符.",1,},
        [15] = {112,"野馬符","白馬將軍公孫瓚的兵符, 易京一役後此兵符不知去向.",1,},
        [16] = {211,"戰狼符","因司馬懿有狼顧之相, 故特製此符, 此符一直陪伴司馬懿, 數次征伐有功.",1,},
        [17] = {212,"疾豹符","兵貴神速, 名將夏侯淵執掌疾豹符, 被稱為疾行的獵豹.",1,},
        [18] = {213,"騰蛇符","法正善奇謀, 執掌騰蛇印, 助劉備進取漢中, 深受劉備信任與倚重.",1,},
        [19] = {311,"青龍符","淮南子卷三記載: 天神之貴者, 莫貴於青龍.青龍印為名將關羽的兵符.",1,},
        [20] = {312,"白虎符","白虎代表西方七宿, 是正義, 勇猛, 威嚴的象徵, 據說西涼馬超曾帶此兵符.",1,},
        [21] = {313,"朱雀符","朱雀乃天之四靈之一, 代表炎帝與南方七宿.周瑜曾擁有兵符, 後不知去向.",1,},
        [22] = {314,"玄武符","玄武乃龜蛇合體, 長生不老, 稱真武大帝.相傳為紅將左慈調遣神兵的兵符.",1,},
        [23] = {411,"界·青龍符","淮南子卷三記載: 天神之貴者, 莫貴於青龍.青龍印為名將關羽的兵符.",1,},
        [24] = {412,"界·白虎符","白虎代表西方七宿, 是正義, 勇猛, 威嚴的象徵, 據說西涼馬超曾帶此兵符.",1,},
        [25] = {413,"界·朱雀符","朱雀乃天之四靈之一, 代表炎帝與南方七宿.周瑜曾擁有兵符, 後不知去向.",1,},
        [26] = {414,"界·玄武符","玄武乃龜蛇合體, 長生不老, 稱真武大帝.相傳為紅將左慈調遣神兵的兵符.",1,},
    }
}

return treasure