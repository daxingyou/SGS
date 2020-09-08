--sgs_linkage_2

local sgs_linkage_2 = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      mission_description = 2,    --说明-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Lv#num#になりました",},
        [2] = {2,"Lv#num#になりました",},
        [3] = {3,"Lv#num#になりました",},
        [4] = {4,"任意のチャージ",},
        [5] = {5,"チャージ累計#num#元",},
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

return sgs_linkage_2