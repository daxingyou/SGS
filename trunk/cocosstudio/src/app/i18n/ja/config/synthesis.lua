--synthesis

local synthesis = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --编号-int 
      des = 2,    --合成类型文本-string 
    
    },
    -- data
    _data = {
        [1] = {1,0,},
        [2] = {2,0,},
        [3] = {3,0,},
        [4] = {4,0,},
        [5] = {5,0,},
        [6] = {6,0,},
        [7] = {7,0,},
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

return synthesis