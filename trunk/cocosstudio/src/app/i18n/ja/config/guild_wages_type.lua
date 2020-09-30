--guild_wages_type

local guild_wages_type = {
    version =  1,
    -- key
    __key_map = {
      type = 1,    --类型-int 
      name = 2,    --任务名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"三国戦記",},
        [2] = {2,"軍団献納",},
        [3] = {3,"軍団ボス",},
        [4] = {4,"クイズイベント",},
        [5] = {5,"軍団の試練",},
        [6] = {6,"軍団の支援",},
    },

    -- index
    __index_type = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
    }
}

return guild_wages_type