--pvpuniverse_reward

local pvpuniverse_reward = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --奖励id-int 
      txt = 2,    --说明-string 
    
    },
    -- data
    _data = {
        [1] = {1,"32強報酬",},
        [2] = {2,"ベスト24報酬",},
        [3] = {3,"ベスト16報酬",},
        [4] = {4,"ベスト8報酬",},
        [5] = {5,"ベスト4報酬",},
        [6] = {6,"準優勝報酬",},
        [7] = {7,"優勝者報酬",},
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