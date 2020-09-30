--graincar

local graincar = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --序号-int 
      name = 2,    --粮车名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"兵糧輸送車",},
        [2] = {2,"木牛",},
        [3] = {3,"流馬",},
        [4] = {4,"霊巧犀",},
        [5] = {5,"無極象",},
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

return graincar