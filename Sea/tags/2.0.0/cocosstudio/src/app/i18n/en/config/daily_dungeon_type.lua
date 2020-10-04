--daily_dungeon_type

local daily_dungeon_type = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name = 2,    --副本名称-英语-string 
      x_position = 3,    --建筑名称X坐标_math-int 
      y_position = 4,    --建筑名称Y坐标_math-int 
    
    },
    -- data
    _data = {
        [1] = {1,"Warrior EXP",0,-100,},
        [2] = {2,"Silver",0,-60,},
        [3] = {3,"Breakthrough Pill",0,-20,},
        [4] = {4,"Gear Refine Stone",0,-100,},
        [5] = {5,"Treasure EXP",0,-70,},
        [6] = {6,"Treasure Refinement Stone",0,-60,},
        [7] = {7,"Artifact Advancement Stone",0,-80,},
        [8] = {8,"Pet EXP",0,-20,},
    }
}

return daily_dungeon_type