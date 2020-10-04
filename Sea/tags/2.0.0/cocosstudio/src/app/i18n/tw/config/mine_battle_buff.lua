--mine_battle_buff

local mine_battle_buff = {
    -- key
    __key_map = {
      buff_id = 1,    --id_key-int 
      buff_name = 2,    --类型名称-繁体-string 
      buff_txt = 3,    --类型描述-繁体-string 
    
    },
    -- data
    _data = {
        [1] = {101,"疲勞","疲勞值50, 戰鬥中傷害降低5%",},
        [2] = {102,"疲勞","疲勞值55, 戰鬥中傷害降低10%",},
        [3] = {103,"疲勞","疲勞值60, 戰鬥中傷害降低15%",},
        [4] = {104,"疲勞","疲勞值65, 戰鬥中傷害降低20%",},
        [5] = {105,"疲勞","疲勞值70, 戰鬥中傷害降低25%",},
        [6] = {106,"疲勞","疲勞值75, 戰鬥中傷害降低30%",},
        [7] = {107,"疲勞","疲勞值80, 戰鬥中傷害降低35%",},
        [8] = {108,"疲勞","疲勞值85, 戰鬥中傷害降低40%",},
        [9] = {109,"疲勞","疲勞值90, 戰鬥中傷害降低45%",},
        [10] = {110,"疲勞","疲勞值100, 戰鬥中傷害降低50%",},
        [11] = {200,"疲勞","所在軍團獨佔當前礦區, 戰鬥中受到的傷害降低10%",},
    }
}

return mine_battle_buff