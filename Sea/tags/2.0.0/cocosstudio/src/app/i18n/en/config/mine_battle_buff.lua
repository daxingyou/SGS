--mine_battle_buff

local mine_battle_buff = {
    -- key
    __key_map = {
      buff_id = 1,    --id-int 
      buff_name = 2,    --类型名称-越南语-string 
      buff_txt = 3,    --类型描述-英语-string 
    
    },
    -- data
    _data = {
        [1] = {101,"Fatigue","Fatigue Point reaches 50. Damage reduces by 5% during the battle.",},
        [2] = {102,"Fatigue","Fatigue Point reaches 55. Damage reduces by 10% during the battle.",},
        [3] = {103,"Fatigue","Fatigue Point reaches 60. Damage reduces by 15% during the battle.",},
        [4] = {104,"Fatigue","Fatigue Point reaches 65. Damage reduces by 20% during the battle.",},
        [5] = {105,"Fatigue","Fatigue Point reaches 70. Damage reduces by 25% during the battle.",},
        [6] = {106,"Fatigue","Fatigue Point reaches 75. Damage reduces by 30% during the battle.",},
        [7] = {107,"Fatigue","Fatigue Point reaches 80. Damage reduces by 35% during the battle.",},
        [8] = {108,"Fatigue","Fatigue Point reaches 85. Damage reduces by 40% during the battle.",},
        [9] = {109,"Fatigue","Fatigue Point reaches 90. Damage reduces by 45% during the battle.",},
        [10] = {110,"Fatigue","Fatigue Point reaches 100. Damage reduces by 50% during the battle.",},
        [11] = {200,"Occupy","If Legion monopolizes the Mine, Damage received during the battle reduces by 10%",},
    }
}

return mine_battle_buff