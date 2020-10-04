--shop_crystal

local shop_crystal = {
    -- key
    __key_map = {
      good_id = 1,    --商品id_key-int 
      description = 2,    --说明-越南语-string 
      pay_amount = 3,    --条件值_math-int 
      size_2 = 4,    --奖励数量2_math-int 
      is_work = 5,    --开关_math-int 
    
    },
    -- data
    _data = {
        [1] = {101,"Hôm nay nạp đơn #num# VND",20000,80,1,},
        [2] = {102,"Hôm nay nạp đơn #num# VND",109000,436,1,},
        [3] = {103,"Tuần này nạp đơn #num# VND",299000,1196,1,},
        [4] = {104,"Tham gia BOSS Quân Đoàn 12 giờ",1,0,1,},
        [5] = {105,"Tham gia BOSS Quân Đoàn 19 giờ",1,0,1,},
        [6] = {106,"Tham gia Thí Luyện Quân Đoàn",1,0,1,},
        [7] = {107,"Tham gia Vấn Đáp",1,0,1,},
        [8] = {108,"Tham gia Tam Quốc Chiến Kỷ",1,0,1,},
        [9] = {109,"Tham gia Đấu Phe",1,0,0,},
        [10] = {110,"Tuần này nạp đơn #num# VND",599000,2396,1,},
        [11] = {111,"Tham gia Vấn Đáp",1,0,1,},
        [12] = {201,"Hôm nay nạp đơn #num# VND",22000,80,1,},
    }
}

return shop_crystal