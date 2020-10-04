--treasure_limit_cost

local treasure_limit_cost = {
    -- key
    __key_map = {
      limit_level = 1,    --界限等级-int 
      name_1 = 2,    --材料1名称-string 
      name_2 = 3,    --材料2名称-string 
      name_3 = 4,    --材料3名称-string 
      name_4 = 5,    --材料4称-string 
      break_name = 6,    --突破消耗名称-string 
    
    },
    -- data
    _data = {
        [1] = {0,"Exploitation ","The Works of Nature","Spring and Autumn","Warring States","Silver",},
        [2] = {1,"Exploitation ","The Works of Nature","Spring and Autumn","Warring States","Silver",},
    }
}

return treasure_limit_cost