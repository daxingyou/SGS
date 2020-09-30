--mine_district

local mine_district = {
    -- key
    __key_map = {
      district_id = 1,    --矿区id-int 
      district_name = 2,    --矿区名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Khu Khoáng Trung Nguyên",},
        [2] = {2,"Khu Khoáng Hãn Đông",},
        [3] = {3,"Khu Khoáng Hoài Nam",},
        [4] = {4,"Khu Khoáng Hán Trung",},
        [5] = {5,"Khu Khoáng Sóc Phương",},
        [6] = {6,"Khu Khoáng U Yến",},
        [7] = {7,"Khu Khoáng Giang Đông",},
        [8] = {8,"Khu Khoáng Nam Vọng",},
        [9] = {9,"Khu Khoáng Ba Thục",},
        [10] = {10,"Khu Khoáng Tây Lương",},
    },

    -- index
    __index_district_id = {
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

return mine_district