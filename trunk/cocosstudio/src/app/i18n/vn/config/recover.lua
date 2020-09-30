--recover

local recover = {
    -- key
    __key_map = {
      id = 1,    --数值ID-int 
      name = 2,    --数值名称-string 
    
    },
    -- data
    _data = {
        [1] = {3,"Thể Lực",},
        [2] = {4,"Tinh Lực",},
        [3] = {11,"Vây quét",},
        [4] = {12,"Khiêu chiến",},
        [5] = {22,"Lương Thảo",},
        [6] = {23,"Số lần tấn công",},
        [7] = {34,"Số lần di chuyển",},
    },

    -- index
    __index_id = {
        [11] = 3,
        [12] = 4,
        [22] = 5,
        [23] = 6,
        [3] = 1,
        [34] = 7,
        [4] = 2,
    }
}

return recover