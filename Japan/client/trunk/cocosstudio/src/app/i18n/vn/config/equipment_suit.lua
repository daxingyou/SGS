--equipment_suit

local equipment_suit = {
    -- key
    __key_map = {
      id = 1,    --套装id-int 
      name = 2,    --套装名称-string 
    
    },
    -- data
    _data = {
        [1] = {1001,"Phá Quân",},
        [2] = {2001,"Tứ Thần",},
        [3] = {3001,"Bát Hoang",},
    },

    -- index
    __index_id = {
        [1001] = 1,
        [2001] = 2,
        [3001] = 3,
    }
}

return equipment_suit