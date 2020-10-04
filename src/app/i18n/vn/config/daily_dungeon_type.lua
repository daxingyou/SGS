--daily_dungeon_type

local daily_dungeon_type = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name = 2,    --副本名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"EXP Tướng",},
        [2] = {2,"Bạc",},
        [3] = {3,"Đột Phá Đơn",},
        [4] = {4,"Đá Tinh Luyện-T.Bị",},
        [5] = {5,"EXP Bảo Vật",},
        [6] = {6,"Đá Luyện-Bảo",},
        [7] = {7,"Đá Thần Binh",},
        [8] = {8,"EXP Thần Thú",},
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