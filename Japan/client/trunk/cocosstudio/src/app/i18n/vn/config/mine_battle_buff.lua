--mine_battle_buff

local mine_battle_buff = {
    -- key
    __key_map = {
      buff_id = 1,    --id-int 
      buff_name = 2,    --类型名称-string 
      buff_txt = 3,    --类型描述-string 
    
    },
    -- data
    _data = {
        [1] = {101,"Mệt Mỏi","Điểm mệt mỏi 50, khi chiến đấu sát thương giảm 5%",},
        [2] = {102,"Mệt Mỏi","Điểm mệt mỏi 55, khi chiến đấu sát thương giảm 10%",},
        [3] = {103,"Mệt Mỏi","Điểm mệt mỏi 60, khi chiến đấu sát thương giảm 15%",},
        [4] = {104,"Mệt Mỏi","Điểm mệt mỏi 65, khi chiến đấu sát thương giảm 20%",},
        [5] = {105,"Mệt Mỏi","Điểm mệt mỏi 70, khi chiến đấu sát thương giảm 25%",},
        [6] = {106,"Mệt Mỏi","Điểm mệt mỏi 75, khi chiến đấu sát thương giảm 30%",},
        [7] = {107,"Mệt Mỏi","Điểm mệt mỏi 80, khi chiến đấu sát thương giảm 35%",},
        [8] = {108,"Mệt Mỏi","Điểm mệt mỏi 85, khi chiến đấu sát thương giảm 40%",},
        [9] = {109,"Mệt Mỏi","Điểm mệt mỏi 90, khi chiến đấu sát thương giảm 45%",},
        [10] = {110,"Mệt Mỏi","Điểm mệt mỏi 100, khi chiến đấu sát thương giảm 50%",},
        [11] = {200,"Bá Chiếm","Quân Đoàn đang chiếm Mỏ Khoáng, sát thương trong chiến đấu giảm 10%",},
    },

    -- index
    __index_buff_id = {
        [101] = 1,
        [102] = 2,
        [103] = 3,
        [104] = 4,
        [105] = 5,
        [106] = 6,
        [107] = 7,
        [108] = 8,
        [109] = 9,
        [110] = 10,
        [200] = 11,
    }
}

return mine_battle_buff