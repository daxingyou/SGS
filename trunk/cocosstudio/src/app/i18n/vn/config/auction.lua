--auction

local auction = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --子叶签-string 
    
    },
    -- data
    _data = {
        [1] = {101,"BOSS",},
        [2] = {102,"Vấn Đáp",},
        [3] = {103,"Thí Luyện QĐ",},
        [4] = {104,"Chiến Kỷ",},
        [5] = {105,"QĐoàn Chiến",},
        [6] = {201,"Toàn máy chủ",},
        [7] = {301,"Đấu Phe",},
        [8] = {401,"Giao Dịch",},
        [9] = {501,"Hành Thương Thần Bí",},
        [10] = {601,"Đấu LSV Cá Nhân",},
        [11] = {106,"QĐ Chiến LSV",},
        [12] = {107,"BOSS Liên Server",},
    },

    -- index
    __index_id = {
        [101] = 1,
        [102] = 2,
        [103] = 3,
        [104] = 4,
        [105] = 5,
        [106] = 11,
        [107] = 12,
        [201] = 6,
        [301] = 7,
        [401] = 8,
        [501] = 9,
        [601] = 10,
    }
}

return auction