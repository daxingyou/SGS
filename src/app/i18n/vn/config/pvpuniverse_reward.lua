--pvpuniverse_reward

local pvpuniverse_reward = {
    -- key
    __key_map = {
      id = 1,    --奖励id-int 
      txt = 2,    --说明-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Thưởng Top 32",},
        [2] = {2,"Thưởng Top 24",},
        [3] = {3,"Thưởng Top 16",},
        [4] = {4,"Thưởng Top 8",},
        [5] = {5,"Thưởng Top 4",},
        [6] = {6,"Thưởng Hạng 2",},
        [7] = {7,"Thưởng Hạng 1",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
    }
}

return pvpuniverse_reward