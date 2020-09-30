--guild_donate

local guild_donate = {
    -- key
    __key_map = {
      id = 1,    --序号-int 
      name = 2,    --捐献名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Lễ Tông Miếu",},
        [2] = {2,"Tế Địa Chi",},
        [3] = {3,"Tế Thiên Thần",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return guild_donate