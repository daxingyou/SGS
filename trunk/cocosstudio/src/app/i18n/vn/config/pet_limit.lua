--pet_limit

local pet_limit = {
    -- key
    __key_map = {
      limit_id = 1,    --界限ID-int 
      name_1 = 2,    --材料1名称-string 
      name_2 = 3,    --材料2名称-string 
      name_3 = 4,    --材料3名称-string 
      name_4 = 5,    --材料4名称-string 
      break_name = 6,    --突破消耗名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Trị Quốc","Tu Thân","Tề Gia","Tề Gia","Bạc",},
    },

    -- index
    __index_limit_id = {
        [1] = 1,
    }
}

return pet_limit