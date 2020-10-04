--hero_limit_cost

local hero_limit_cost = {
    -- key
    __key_map = {
      limit_level = 1,    --界限等级_math-int 
      name_1 = 2,    --材料1名称-简中-string 
      name_2 = 3,    --材料2名称-简中-string 
      name_3 = 4,    --材料3名称-越南语-string 
      name_4 = 5,    --材料4名称-越南语-string 
      break_name = 6,    --突破消耗名称-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {0,"论语","左传","春秋","战国","银两",},
        [2] = {1,"论语","左传","春秋","战国","银两",},
        [3] = {2,"论语","左传","春秋","战国","银两",},
        [4] = {3,"论语","左传","春秋","战国","银两",},
    }
}

return hero_limit_cost