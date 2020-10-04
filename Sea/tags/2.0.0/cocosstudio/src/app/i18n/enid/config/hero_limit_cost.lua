--hero_limit_cost

local hero_limit_cost = {
    -- key
    __key_map = {
      limit_level = 1,    --界限等级_math-int 
      name_1 = 2,    --材料1名称-string 
      name_2 = 3,    --材料2名称-string 
      name_3 = 4,    --材料3名称-string 
      name_4 = 5,    --材料4名称-string 
      break_name = 6,    --突破消耗名称-string 
    
    },
    -- data
    _data = {
        [1] = {0,"Analek Konfusius","Tradisi Zuo","Negara Damai","Negara Perang","Perak",},
        [2] = {1,"Analek Konfusius","Tradisi Zuo","Negara Damai","Negara Perang","Perak",},
        [3] = {2,"Analek Konfusius","Tradisi Zuo","Negara Damai","Negara Perang","Perak",},
        [4] = {3,"Analek Konfusius","Tradisi Zuo","Negara Damai","Negara Perang","Perak",},
    }
}

return hero_limit_cost