--daily_dungeon_type

local daily_dungeon_type = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name = 2,    --副本名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"武将EXP",},
        [2] = {2,"銀貨",},
        [3] = {3,"突破丹",},
        [4] = {4,"装備精錬石",},
        [5] = {5,"宝物EXP",},
        [6] = {6,"宝物精錬石",},
        [7] = {7,"神器練磨石",},
        [8] = {8,"神獣EXP",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
    }
}

return daily_dungeon_type