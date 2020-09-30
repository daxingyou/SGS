--equipment_suit

local equipment_suit = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --套装id-int 
      name = 2,    --套装名称-string 
    
    },
    -- data
    _data = {
        [1] = {1001,"破軍装備セット",},
        [2] = {2001,"四神装備セット",},
        [3] = {3001,"八極装備セット",},
    },

    -- index
    __index_id = {
        [1001] = 1,
        [2001] = 2,
        [3001] = 3,
    }
}

return equipment_suit