--guild_build_postion

local guild_build_postion = {
    -- key
    __key_map = {
      id = 1,    --建筑id-int 
      name = 2,    --建筑名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Quân Đoàn Đại Điện",},
        [2] = {2,"Cứu Viện",},
        [3] = {3,"Quân Đoàn",},
        [4] = {4,"Đình Tử",},
        [5] = {5,"BOSS",},
        [6] = {6,"Góp Q.Đ",},
        [7] = {7,"Quân Nhu Sở",},
        [8] = {8,"Thí Luyện QĐ",},
        [9] = {9,"Đông Thành Môn",},
        [10] = {10,"QĐoàn Chiến",},
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

return guild_build_postion