--seven_days_discount

local seven_days_discount = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --物品名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"1 bộ trang bị Lam (4 món)",},
        [2] = {2,"Binh Thư Cam",},
        [3] = {3,"Đá Luyện-Cao x40",},
        [4] = {4,"T.Binh Cam-Chọn+Công trạng+Đá Thần Binh",},
        [5] = {5,"Thần Binh Cam x5",},
        [6] = {6,"Binh Phù Cam",},
        [7] = {7,"Cẩm Nang Quan Vũ",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
    }
}

return seven_days_discount