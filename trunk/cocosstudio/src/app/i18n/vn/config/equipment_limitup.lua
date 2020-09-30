--equipment_limitup

local equipment_limitup = {
    -- key
    __key_map = {
      limitup_templet_id = 1,    --模板id-int 
      resource_name_2 = 2,    --材料2名称-string 
      resource_name_1 = 3,    --材料1名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Chiến Quốc","Xuân Thu",},
        [2] = {2,"Chu Dịch","Lễ Ký",},
    },

    -- index
    __index_limitup_templet_id = {
        [1] = 1,
        [2] = 2,
    }
}

return equipment_limitup