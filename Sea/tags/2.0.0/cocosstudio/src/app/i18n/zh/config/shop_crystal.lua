--shop_crystal

local shop_crystal = {
    -- key
    __key_map = {
      good_id = 1,    --商品id-int 
      description = 2,    --说明-越南语-string 
      pay_amount = 3,    --条件值_math-int 
      size_2 = 4,    --奖励数量2_math-int 
      is_work = 5,    --开关_math-int 
    
    },
    -- data
    _data = {
        [1] = {101,"今日单笔充值#num#元宝",60,60,1,},
        [2] = {102,"今日单笔充值#num#元宝",300,300,1,},
        [3] = {103,"本周单笔充值#num#元宝",900,900,1,},
        [4] = {104,"参加12点的军团BOSS",1,0,1,},
        [5] = {105,"参加19点的军团BOSS",1,0,1,},
        [6] = {106,"参加军团试炼",1,0,1,},
        [7] = {107,"参加军团答题",1,0,1,},
        [8] = {108,"参加三国战记",1,0,1,},
        [9] = {109,"参加阵营竞技",1,0,0,},
        [10] = {110,"本周单笔充值#num#元宝",1800,1800,1,},
        [11] = {111,"参加答题活动",1,0,1,},
        [12] = {201,"今日单笔充值#num#元宝",60,60,0,},
    }
}

return shop_crystal