--hero_limit_cost

local hero_limit_cost = {
    -- key
    __key_map = {
      limit_level = 1,    --界限等级_key-int 
      name_1 = 2,    --材料1名称-繁体-string 
      name_2 = 3,    --材料2名称-繁体-string 
      name_3 = 4,    --材料3名称-繁体-string 
      name_4 = 5,    --材料4名称-繁体-string 
      break_name = 6,    --突破消耗名称-繁体-string 
    
    },
    -- data
    _data = {
        [1] = {0,"論語","左傳","春秋","戰國","銀兩",},
        [2] = {1,"論語","左傳","春秋","戰國","銀兩",},
        [3] = {2,"論語","左傳","春秋","戰國","銀兩",},
        [4] = {3,"論語","左傳","春秋","戰國","銀兩",},
    }
}

return hero_limit_cost