--function_cost

local function_cost = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --功能名称-int 
      name = 2,    --功能名称-string 
    
    },
    -- data
    _data = {
        [1] = {10001,"競技場挑戦回数",},
        [2] = {10002,"軍団の支援回数",},
        [3] = {10003,"武将(金)登用",},
    },

    -- index
    __index_id = {
        [10001] = 1,
        [10002] = 2,
        [10003] = 3,
    }
}

return function_cost