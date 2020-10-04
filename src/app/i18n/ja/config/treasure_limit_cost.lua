--treasure_limit_cost

local treasure_limit_cost = {
    version =  1,
    -- key
    __key_map = {
      limit_level = 1,    --界限等级-int 
      name_1 = 2,    --材料1名称-string 
      name_2 = 3,    --材料2名称-string 
      name_3 = 4,    --材料3名称-string 
      name_4 = 5,    --材料4名称-string 
      break_name = 6,    --突破消耗名称-string 
    
    },
    -- data
    _data = {
        [1] = {0,"天の巧みな業","開物","春秋","戦国","銀貨",},
        [2] = {1,"天の巧みな業","開物","礼記","周易","銀貨",},
        [3] = {2,"天の巧みな業","開物","春秋","戦国","銀貨",},
    },

    -- index
    __index_limit_level = {
        [0] = 1,
        [1] = 2,
        [2] = 3,
    }
}

return treasure_limit_cost