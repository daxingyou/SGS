--story_period_box

local story_period_box = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      title = 2,    --阶段标题-string 
    
    },
    -- data
    _data = {
        [1] = {1,"第3回クリアで受領",},
        [2] = {2,"第6回クリアで受領",},
        [3] = {3,"第8回クリアで受領",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return story_period_box