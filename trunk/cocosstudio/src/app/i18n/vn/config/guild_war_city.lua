--guild_war_city

local guild_war_city = {
    -- key
    __key_map = {
      id = 1,    --城池id-int 
      name = 2,    --城池名字-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Hổ Lao Quan",},
        [2] = {2,"Hàm Cốc Quan",},
        [3] = {3,"Kiếm Các",},
        [4] = {4,"Tiêu Dao Tân",},
        [5] = {5,"Nhạn Môn Quan",},
        [6] = {6,"Sơn Hải Quan",},
        [7] = {7,"Dương Bình Quan",},
        [8] = {8,"Thất Tinh Quan",},
        [9] = {9,"Di Lăng",},
        [10] = {10,"Giang Lăng",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [10] = 10,
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

return guild_war_city