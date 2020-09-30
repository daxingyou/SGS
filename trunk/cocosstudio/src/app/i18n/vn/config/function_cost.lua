--function_cost

local function_cost = {
    -- key
    __key_map = {
      id = 1,    --功能名称-int 
      name = 2,    --功能名称-string 
    
    },
    -- data
    _data = {
        [1] = {10001,"Lần khiêu chiến Đấu Trường",},
        [2] = {10002,"Số lần Quân Đoàn Cứu Viện",},
        [3] = {10003,"Chiêu mộ Tướng Vàng",},
    },

    -- index
    __index_id = {
        [10001] = 1,
        [10002] = 2,
        [10003] = 3,
    }
}

return function_cost