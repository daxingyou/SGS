--act_silver_box

local act_silver_box = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      box_name = 2,    --宝箱标题-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Quà 10 Lần",},
        [2] = {2,"Quà 20 Lần",},
        [3] = {3,"Quà 30 Lần",},
        [4] = {4,"Quà 40 Lần",},
        [5] = {5,"Quà 50 Lần",},
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

return act_silver_box