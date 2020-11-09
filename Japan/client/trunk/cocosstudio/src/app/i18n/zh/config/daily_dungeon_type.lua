--daily_dungeon_type

local daily_dungeon_type = {
    -- key
    __key_map = {
      id = 1,    --编号_key-int 
      name = 2,    --副本名称-简中-string 
      x_position = 3,    --建筑名称X坐标_math-int 
      y_position = 4,    --建筑名称Y坐标_math-int 
    
    },
    -- data
    _data = {
        [1] = {1,"武将经验",0,-100,},
        [2] = {2,"银两",0,-60,},
        [3] = {3,"突破丹",0,-20,},
        [4] = {4,"装备精炼石",0,-100,},
        [5] = {5,"宝物经验",0,-70,},
        [6] = {6,"宝物精炼石",0,-60,},
        [7] = {7,"神兵进阶石",0,-80,},
        [8] = {8,"神兽经验",0,-20,},
    }
}

return daily_dungeon_type