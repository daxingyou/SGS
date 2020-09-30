--first_pay

local first_pay = {
    -- key
    __key_map = {
      id = 1,    --编号_key-int 
      charge = 2,    --充值额度_math-int 
    
    },
    -- data
    _data = {
        [1] = {1,20000,},
        [2] = {2,299000,},
        [3] = {3,899000,},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return first_pay