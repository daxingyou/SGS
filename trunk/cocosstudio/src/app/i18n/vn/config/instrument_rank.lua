--instrument_rank

local instrument_rank = {
    -- key
    __key_map = {
      rank_id = 1,    --id-int 
      name_2 = 2,    --材料2名称-string 
      name_1 = 3,    --材料1名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Chiến Quốc","Xuân Thu",},
        [2] = {1,"Chu Dịch","Lễ Ký",},
        [3] = {1,"Chiến Quốc","Xuân Thu",},
        [4] = {2,"Chu Dịch","Lễ Ký",},
        [5] = {2,"Chiến Quốc","Xuân Thu",},
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