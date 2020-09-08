--act_silver_box

local act_silver_box = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      box_name = 2,    --宝箱标题-string 
    
    },
    -- data
    _data = {
        [1] = {1,"10回ギフト",},
        [2] = {2,"20回ギフト",},
        [3] = {3,"30回ギフト",},
        [4] = {4,"40回ギフト",},
        [5] = {5,"50回ギフト",},
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