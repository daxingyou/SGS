--shop_crystal

local shop_crystal = {
    -- key
    __key_map = {
      good_id = 1,    --商品id-int 
      pay_amount = 2,    --条件值_math-int 
      size_2 = 3,    --奖励数量2_math-int 
      is_work = 4,    --开关_math-int 
      description = 5,    --说明-string 
    
    },
    -- data
    _data = {
        [1] = {101,60,60,1,"Hari ini top-up tunggal #num#",},
        [2] = {102,300,300,1,"Hari ini top-up tunggal #num#",},
        [3] = {103,900,900,1,"Minggu ini top-up tunggal #num#",},
        [4] = {104,1,0,1,"Mengikuti event BOSS Legiun pk 12:00",},
        [5] = {105,1,0,1,"Mengikuti event BOSS Legiun pk 19:00",},
        [6] = {106,1,0,1,"Mengikuti Percobaan Legiun",},
        [7] = {107,1,0,1,"Mengikuti event Kuis",},
        [8] = {108,1,0,1,"Mengikuti Jaman Perang Samkok",},
        [9] = {109,1,0,0,"Mengikuti Kompetisi Faksi",},
        [10] = {110,1800,1800,1,"Minggu ini top-up tunggal #num#",},
        [11] = {111,1,0,1,"Mengikuti event Kuis",},
        [12] = {201,60,60,0,"Hari ini top-up tunggal #num#",},
    }
}

return shop_crystal