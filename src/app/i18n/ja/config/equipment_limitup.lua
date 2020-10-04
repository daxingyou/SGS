--equipment_limitup

local equipment_limitup = {
    version =  1,
    -- key
    __key_map = {
      limitup_templet_id = 1,    --模板id-int 
      resource_name_2 = 2,    --材料2名称-string 
      resource_name_1 = 3,    --材料1名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"戦国","春秋",},
        [2] = {2,"周易","礼記",},
    },

    -- index
    __index_limitup_templet_id = {
        [1] = 1,
        [2] = 2,
    }
}

return equipment_limitup