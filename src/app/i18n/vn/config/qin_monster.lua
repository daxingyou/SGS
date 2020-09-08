--qin_monster

local qin_monster = {
    -- key
    __key_map = {
      id = 1,    --boss序号-int 
      big_name = 2,    --精英怪物名称-string 
      small_name = 3,    --普通怪物名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Hoàng Lăng Mộng Yểm","Tiên Tần Giáp Sĩ",},
        [2] = {2,"Hoàng Lăng Mộng Yểm","Tiên Tần Giáp Sĩ",},
        [3] = {3,"Hoàng Lăng Mộng Yểm","Tiên Tần Giáp Sĩ",},
        [4] = {4,"Hoàng Lăng Mộng Yểm","Tiên Tần Đồ Binh",},
        [5] = {5,"Hoàng Lăng Mộng Yểm","Tiên Tần Đồ Binh",},
        [6] = {6,"Hoàng Lăng Mộng Yểm","Tiên Tần Đồ Binh",},
        [7] = {7,"Hoàng Lăng Mộng Yểm","Tiên Tần Xa Binh",},
        [8] = {8,"Hoàng Lăng Mộng Yểm","Tiên Tần Xa Binh",},
        [9] = {9,"Hoàng Lăng Mộng Yểm","Tiên Tần Xa Binh",},
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
        [9] = 9,
    }
}

return qin_monster