--mine_district

local mine_district = {
    version =  1,
    -- key
    __key_map = {
      district_id = 1,    --矿区id-int 
      district_name = 2,    --矿区名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"中原鉱区",},
        [2] = {2,"河東鉱区",},
        [3] = {3,"淮南鉱区",},
        [4] = {4,"漢中鉱区",},
        [5] = {5,"朔方鉱区",},
        [6] = {6,"幽燕鉱区",},
        [7] = {7,"江東鉱区",},
        [8] = {8,"南越鉱区",},
        [9] = {9,"巴蜀鉱区",},
        [10] = {10,"西涼鉱区",},
    },

    -- index
    __index_district_id = {
        [1] = 1,
        [10] = 10,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
        [9] = 9,
    }
}

return mine_district