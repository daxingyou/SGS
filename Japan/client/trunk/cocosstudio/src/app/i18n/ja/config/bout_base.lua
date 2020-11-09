--bout_base

local bout_base = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --阵法名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"円形陣",},
        [2] = {2,"鋒矢陣",},
        [3] = {3,"天地人陣",},
        [4] = {4,"日月星陣",},
        [5] = {5,"北斗七星陣",},
        [6] = {6,"五行八卦陣",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
    }
}

return bout_base