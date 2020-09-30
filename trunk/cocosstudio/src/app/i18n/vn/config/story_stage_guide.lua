--story_stage_guide

local story_stage_guide = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      text = 2,    --文本-string 
    
    },
    -- data
    _data = {
        [1] = {1001,"Chúa công mau đi chinh chiến nào!",},
        [2] = {2001,"",},
        [3] = {2002,"",},
        [4] = {3001,"",},
        [5] = {3002,"",},
        [6] = {3003,"",},
        [7] = {3004,"",},
        [8] = {3005,"",},
        [9] = {3006,"",},
    },

    -- index
    __index_id = {
        [1001] = 1,
        [2001] = 2,
        [2002] = 3,
        [3001] = 4,
        [3002] = 5,
        [3003] = 6,
        [3004] = 7,
        [3005] = 8,
        [3006] = 9,
    }
}

return story_stage_guide