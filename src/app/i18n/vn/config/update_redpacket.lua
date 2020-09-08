--update_redpacket

local update_redpacket = {
    -- key
    __key_map = {
      id = 1,    --红包id-int 
      name = 2,    --红包名称-string 
    
    },
    -- data
    _data = {
        [1] = {99,"Lì Xì Vui",},
        [2] = {1,"Giá chót Tướng Đỏ",},
        [3] = {2,"Giá chót Mảnh T.Đỏ",},
        [4] = {3,"Giá chót T.Binh Đỏ",},
        [5] = {4,"Giá chót T.Binh Đỏ Vạn Năng",},
        [6] = {5,"Giá chót Xuân Thu",},
        [7] = {6,"Giá chót Chiến Quốc",},
        [8] = {7,"Giá chót Cẩm Nang Đỏ",},
        [9] = {8,"Giá chót C.N Cam",},
        [10] = {9,"Giá chót Hiền Lệnh",},
        [11] = {10,"Giá chót Thiện Lệnh",},
    },

    -- index
    __index_id = {
        [1] = 2,
        [10] = 11,
        [2] = 3,
        [3] = 4,
        [4] = 5,
        [5] = 6,
        [6] = 7,
        [7] = 8,
        [8] = 9,
        [9] = 10,
        [99] = 1,
    }
}

return update_redpacket