--horse_group

local horse_group = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --图鉴名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Lục Ảnh Dao Thanh",},
        [2] = {2,"Thái Hoàng Trịch Tảo",},
        [3] = {3,"Lộ Tòng Dạ Bạch",},
        [4] = {4,"Bích Nhiễm Hồng Lâm",},
        [5] = {5,"Đình Phi Bạch Tuyết",},
        [6] = {6,"Nhai Sinh Tử Vân",},
        [7] = {7,"Ngọc Chi Hồng Yên",},
        [8] = {8,"Nguyệt Chiếu Bích Ảnh",},
        [9] = {11,"Điện Quang Hỏa Thạch",},
        [10] = {12,"Minh Tinh",},
        [11] = {14,"Hắc Bạch",},
        [12] = {9,"Phất Sương Xuy Tuyết",},
        [13] = {10,"Hồng Lan Dạ Hỏa",},
        [14] = {13,"Hỏa Lôi",},
        [15] = {15,"Khác Biệt",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [10] = 13,
        [11] = 9,
        [12] = 10,
        [13] = 14,
        [14] = 11,
        [15] = 15,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
        [9] = 12,
    }
}

return horse_group