--historical_hero_map

local historical_hero_map = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --图鉴名称-string 
    
    },
    -- data
    _data = {
        [1] = {1001,"Song Toàn",},
        [2] = {1002,"Võ Lược",},
        [3] = {2001,"Tần Hoàng Hán Vũ",},
    },

    -- index
    __index_id = {
        [1001] = 1,
        [1002] = 2,
        [2001] = 3,
    }
}

return historical_hero_map