--cross_boss_info

local cross_boss_info = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Tử Thượng",},
        [2] = {2,"Thủy Kính",},
        [3] = {3,"Chu Cơ",},
        [4] = {4,"Nam Hoa",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
    }
}

return cross_boss_info