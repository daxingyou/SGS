--hero_limit_cost

local hero_limit_cost = {
    -- key
    __key_map = {
      limit_level = 1,    --界限等级_math-int 
      name_1 = 2,    --材料1名称-英语-string 
      name_2 = 3,    --材料2名称-英语-string 
      name_3 = 4,    --材料3名称-越南语-string 
      name_4 = 5,    --材料4名称-越南语-string 
      break_name = 6,    --突破消耗名称-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {0,"The Analects","The Zuo Tradition","Spring and Autumn","Warring States","Silver",},
        [2] = {1,"The Analects","The Zuo Tradition","Spring and Autumn","Warring States","Silver",},
        [3] = {2,"The Analects","The Zuo Tradition","Spring and Autumn","Warring States","Silver",},
        [4] = {3,"The Analects","The Zuo Tradition","Spring and Autumn","Warring States","Silver",},
    }
}

return hero_limit_cost