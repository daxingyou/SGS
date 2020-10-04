--pet_limit

local pet_limit = {
    version =  1,
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
        [1] = {1,"治国","修身","一家団結","一家団結","銀貨",},
    },

    -- index
    __index_limit_id = {
        [1] = 1,
    }
}

return pet_limit