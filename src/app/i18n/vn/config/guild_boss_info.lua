--guild_boss_info

local guild_boss_info = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      city_name = 2,    --城池名称-string 
      name = 3,    --名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Duyện Châu","Hoa Hùng",},
        [2] = {2,"Từ Châu","Công Tôn Toản",},
        [3] = {3,"Tây Thành","Bàng Thống",},
        [4] = {4,"Nhai Đình","Từ Thứ",},
        [5] = {5,"Hạ Khẩu","Cam Ninh",},
        [6] = {6,"Tam Giang Khẩu","Lữ Mông",},
        [7] = {7,"Thương Đình","Tào Nhân",},
        [8] = {8,"Ô Sào","Trương Hợp",},
        [9] = {9,"","Tào Tháo",},
        [10] = {10,"","Gia Cát Lượng",},
        [11] = {11,"","Chu Du",},
        [12] = {12,"","Lữ Bố",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [10] = 10,
        [11] = 11,
        [12] = 12,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
        [9] = 9,
    }
}

return guild_boss_info