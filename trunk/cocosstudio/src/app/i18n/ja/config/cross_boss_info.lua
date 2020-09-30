--cross_boss_info

local cross_boss_info = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"司馬昭",},
        [2] = {2,"水鏡",},
        [3] = {3,"周姫",},
        [4] = {4,"南華",},
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