--shop_crystal

local shop_crystal = {
    -- key
    __key_map = {
      good_id = 1,    --商品id-int 
      description = 2,    --说明-string 
      pay_amount = 3,    --条件值_math-int 
      size_2 = 4,    --奖励数量2_math-int 
      is_work = 5,    --开关_math-int 
    
    },
    -- data
    _data = {
        [1] = {101,"Top up #num# Ingots in one order today",60,60,1,},
        [2] = {102,"Top up #num# Ingots in one order today",300,300,1,},
        [3] = {103,"Top up #num# Ingots in one order this week",900,900,1,},
        [4] = {104,"Attend Legion BOSS at 12:00",1,0,1,},
        [5] = {105,"Attend Legion BOSS at 19:00",1,0,1,},
        [6] = {106,"Attend Legion Trial",1,0,1,},
        [7] = {107,"Attend Legion Quiz",1,0,1,},
        [8] = {108,"Attend Three Kingdoms",1,0,1,},
        [9] = {109,"Attend Faction Campaign",1,0,0,},
        [10] = {110,"Top up #num# Ingots in one order this week",1800,1800,1,},
        [11] = {111,"Attend event Quiz",1,0,1,},
        [12] = {201,"Top up #num# Ingots in one order today",60,60,0,},
    }
}

return shop_crystal