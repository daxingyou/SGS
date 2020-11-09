--guild_purview

local guild_purview = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --职位-int 
      name = 2,    --职称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"軍団長",},
        [2] = {2,"副団長",},
        [3] = {3,"長老",},
        [4] = {4,"団員",},
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