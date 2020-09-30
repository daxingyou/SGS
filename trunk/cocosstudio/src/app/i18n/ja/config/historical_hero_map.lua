--historical_hero_map

local historical_hero_map = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --图鉴名称-string 
    
    },
    -- data
    _data = {
        [1] = {1001,"琴心剣胆",},
        [2] = {1002,"智勇兼備",},
        [3] = {2001,"始皇帝と武帝",},
    },

    -- index
    __index_id = {
        [1001] = 1,
        [1002] = 2,
        [2001] = 3,
    }
}

return historical_hero_map