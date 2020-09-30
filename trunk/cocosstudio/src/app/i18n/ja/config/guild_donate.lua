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
        [2] = {2,"地神祭祀",},
        [3] = {3,"天神祭祀",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return guild_donate