--guild_war_city

local guild_war_city = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --城池id-int 
      name = 2,    --城池名字-string 
    
    },
    -- data
    _data = {
        [1] = {1,"虎牢関",},
        [2] = {2,"函谷関",},
        [3] = {3,"剣閣",},
        [4] = {4,"逍遥津",},
        [5] = {5,"雁門関",},
        [6] = {6,"山海関",},
        [7] = {7,"陽平関",},
        [8] = {8,"七星関",},
        [9] = {9,"夷陵",},
        [10] = {10,"江陵",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [10] = 10,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
        [9] = 9,
    }
}

return guild_war_city