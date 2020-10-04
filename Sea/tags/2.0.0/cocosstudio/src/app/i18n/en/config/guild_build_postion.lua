--guild_build_postion

local guild_build_postion = {
    -- key
    __key_map = {
      id = 1,    --建筑id-int 
      name = 2,    --建筑名称-英语-string 
      name_postion_x = 3,    --标题X坐标-int 
      name_postion_y = 4,    --标题Y坐标-int 
    
    },
    -- data
    _data = {
        [1] = {1,"Legion Hall",1280,720,},
        [2] = {2,"Legion Support",670,506,},
        [3] = {3,"Legion Shop",970,680,},
        [4] = {4,"Pavilion ",1038,807,},
        [5] = {5,"Legion BOSS",1000,510,},
        [6] = {6,"Legion Contribution ",1300,484,},
        [7] = {7,"Depot",1144,361,},
        [8] = {8,"Legion Trial",508,652,},
        [9] = {9,"East City Gate",1436,431,},
        [10] = {10,"Legion War",1750,435,},
    }
}

return guild_build_postion