--graincar

local graincar = {
    -- key
    __key_map = {
      id = 1,    --序号-int 
      name = 2,    --粮车名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Xe Lương",},
        [2] = {2,"Mộc Ngưu ",},
        [3] = {3,"Lưu Mã",},
        [4] = {4,"Linh Xảo Tê",},
        [5] = {5,"Vô Cực Tượng",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
    }
}

return graincar