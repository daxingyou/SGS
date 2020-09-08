--boss_info

local boss_info = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Tư Mã Ý",},
        [2] = {2,"Tôn Sách",},
        [3] = {3,"Triệu Vân",},
        [4] = {4,"Tả Từ",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
    }
}

return boss_info