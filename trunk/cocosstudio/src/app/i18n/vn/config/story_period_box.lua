--story_period_box

local story_period_box = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      title = 2,    --阶段标题-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Vượt ải hồi 3 nhận",},
        [2] = {2,"Vượt ải hồi 6 nhận",},
        [3] = {3,"Vượt ải hồi 8 nhận",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return story_period_box