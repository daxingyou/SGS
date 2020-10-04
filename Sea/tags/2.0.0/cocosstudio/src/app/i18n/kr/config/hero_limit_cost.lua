--hero_limit_cost

local hero_limit_cost = {
    -- key
    __key_map = {
      limit_level = 1,    --界限等级_key-int 
      name_1 = 2,    --材料1名称-韩语-string 
      name_2 = 3,    --材料2名称-韩语-string 
      name_3 = 4,    --材料3名称-韩语-string 
      name_4 = 5,    --材料4名称-韩语-string 
      break_name = 6,    --突破消耗名称-韩语-string 
    
    },
    -- data
    _data = {
        [1] = {0,"논어","좌전","춘추","전국","은화",},
        [2] = {1,"논어","좌전","춘추","전국","은화",},
        [3] = {2,"논어","좌전","춘추","전국","은화",},
        [4] = {3,"논어","좌전","춘추","전국","은화",},
    }
}

return hero_limit_cost