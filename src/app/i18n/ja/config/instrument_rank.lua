--instrument_rank

local instrument_rank = {
    version =  1,
    -- key
    __key_map = {
      rank_id = 1,    --id-int 
      name_2 = 2,    --材料2名称-string 
      name_1 = 3,    --材料1名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"戦国","春秋",},
        [2] = {1,"周易","礼記",},
        [3] = {1,"戦国","春秋",},
        [4] = {2,"周易","礼記",},
        [5] = {2,"戦国","春秋",},
    },

    -- index
    __index_rank_id_instrument_id = {
        ["1_0"] = 1,
        ["1_1"] = 2,
        ["1_2"] = 3,
        ["2_0"] = 4,
        ["2_1"] = 5,
    }
}

return instrument_rank