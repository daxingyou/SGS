--bout_base

local bout_base = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --阵法名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Viên Hình Trận",},
        [2] = {2,"Phong Thỉ Trận",},
        [3] = {3,"Tam Tài Trận",},
        [4] = {4,"Tinh Thần Trận",},
        [5] = {5,"Bắc Đẩu Trận",},
        [6] = {6,"Ngũ Hành Trận",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
    }
}

return bout_base