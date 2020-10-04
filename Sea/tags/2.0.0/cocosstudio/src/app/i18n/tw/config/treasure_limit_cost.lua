--treasure_limit_cost

local treasure_limit_cost = {
    -- key
    __key_map = {
      limit_level = 1,    --界限等级_key-int 
      name_1 = 2,    --材料1名称-string 
      name_2 = 3,    --材料2名称-string 
      name_3 = 4,    --材料3名称-string 
      name_4 = 5,    --材料4名称-string 
      break_name = 6,    --突破消耗名称-string 
    
    },
    -- data
    _data = {
        [1] = {0,"天工","開物","春秋","戰國","銀兩",},
        [2] = {1,"天工","開物","春秋","戰國","銀兩",},
    }
}

return treasure_limit_cost