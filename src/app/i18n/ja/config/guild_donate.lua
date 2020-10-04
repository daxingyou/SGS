--guild_donate

local guild_donate = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --序号-int 
      name = 2,    --捐献名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"礼宗廟",},
        [2] = {2,"地の神を祀る",},
        [3] = {3,"祭天神",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return guild_donate