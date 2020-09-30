--gold_hero_train

local gold_hero_train = {
    version =  1,
    -- key
    __key_map = {
      limit_level = 1,    --养成等级-int 
      name_1 = 2,    --材料1名称-string 
      name_2 = 3,    --材料2名称-string 
      name_3 = 4,    --材料3名称-string 
      name_4 = 5,    --材料4名称-string 
      break_name = 6,    --突破消耗名称-string 
    
    },
    -- data
    _data = {
        [1] = {0,"日  ","治国","修身","斉家","銀貨",},
        [2] = {1,"日  ","治国","修身","斉家","銀貨",},
        [3] = {2,"日  ","治国","修身","斉家","銀貨",},
        [4] = {3,"日  ","治国","修身","斉家","銀貨",},
        [5] = {4,"日  ","治国","修身","斉家","銀貨",},
        [6] = {5,"日  ","治国","修身","斉家","銀貨",},
    },

    -- index
    __index_limit_level = {
        [0] = 1,
        [1] = 2,
        [2] = 3,
        [3] = 4,
        [4] = 5,
        [5] = 6,
    }
}

return gold_hero_train