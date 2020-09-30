--act_dinner

local act_dinner = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      chat_before = 2,    --领取前对话-string 
      chat_after = 3,    --领取后对话-string 
      name = 4,    --名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Chúa công đói rồi sao? Ăn đi","Hãy quay lại vào 18:00","Tiệc Trưa",},
        [2] = {2,"Chúa công đói rồi sao? Ăn đi","Hãy quay lại vào 21:00","Tiệc Tối",},
        [3] = {3,"Mời chúa công uống cạn ly này!","Đêm nay chúa công không đi sao?","Tiệc Đêm",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return act_dinner