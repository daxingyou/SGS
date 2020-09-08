--guild_purview

local guild_purview = {
    -- key
    __key_map = {
      id = 1,    --职位-int 
      name = 2,    --职称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Đ.Trưởng",},
        [2] = {2,"Đoàn Phó",},
        [3] = {3,"Trưởng Lão",},
        [4] = {4,"Thành Viên",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
    }
}

return guild_purview