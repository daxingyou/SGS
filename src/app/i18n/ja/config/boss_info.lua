--boss_info

local boss_info = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"軍師・司馬懿",},
        [2] = {2,"小覇王・孫策",},
        [3] = {3,"常山の趙雲",},
        [4] = {4,"玄天左慈",},
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