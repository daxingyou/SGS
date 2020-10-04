--daily_dungeon_type

local daily_dungeon_type = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      x_position = 2,    --建筑名称X坐标_math-int 
      y_position = 3,    --建筑名称Y坐标_math-int 
      name = 4,    --副本名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,0,-100,"EXP Hero",},
        [2] = {2,0,-60,"Perak",},
        [3] = {3,0,-20,"Pil Terobosan",},
        [4] = {4,0,-100,"Batu Pemurnian Gear",},
        [5] = {5,0,-70,"EXP Harta",},
        [6] = {6,0,-60,"Batu Pemurnian Harta",},
        [7] = {7,0,-80,"Batu Advance Artefak",},
        [8] = {8,0,-20,"EXP Pet",},
    }
}

return daily_dungeon_type