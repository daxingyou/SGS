--cake_resouce

local cake_resouce = {
    -- key
    __key_map = {
      type = 1,    --活动类型-int 
      type_name = 2,    --盛宴吃的啥-string 
      cake_name1 = 3,    --页签一名称-string 
      cake_name2 = 4,    --页签二名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Bánh Kem","Nhận Trứng","Nhận Bơ",},
        [2] = {2,"Lẩu","Nhận Nấm","Nhận Gầu Bò",},
        [3] = {3,"Đồ Nướng","Nhận Rau Cải","Nhận Thịt Bò",},
        [4] = {4,"Cơm Giao Thừa","Phúc Quý Phú Túc","Làm Giàu Không Khó",},
    },

    -- index
    __index_type = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
    }
}

return cake_resouce