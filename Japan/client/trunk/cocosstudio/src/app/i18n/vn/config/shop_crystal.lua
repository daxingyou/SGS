--shop_crystal

local shop_crystal = {
    -- key
    __key_map = {
      good_id = 1,    --商品id-int 
      description = 2,    --说明-string 
    
    },
    -- data
    _data = {
        [1] = {101,"Hôm nay nạp đơn #num# VND",},
        [2] = {102,"Hôm nay nạp đơn #num# VND",},
        [3] = {103,"Tuần này nạp đơn #num# VND",},
        [4] = {104,"Tham gia BOSS Quân Đoàn 12 giờ",},
        [5] = {105,"Tham gia BOSS Quân Đoàn 19 giờ",},
        [6] = {106,"Tham gia Thí Luyện Quân Đoàn",},
        [7] = {107,"Tham gia Vấn Đáp",},
        [8] = {108,"Tham gia Tam Quốc Chiến Kỷ",},
        [9] = {109,"Tham gia Đấu Phe",},
        [10] = {110,"Tuần này nạp đơn #num# VND",},
        [11] = {111,"Tham gia Vấn Đáp",},
        [12] = {201,"Hôm nay nạp đơn #num# VND",},
    },

    -- index
    __index_good_id = {
        [101] = 1,
        [102] = 2,
        [103] = 3,
        [104] = 4,
        [105] = 5,
        [106] = 6,
        [107] = 7,
        [108] = 8,
        [109] = 9,
        [110] = 10,
        [111] = 11,
        [201] = 12,
    }
}

return shop_crystal