--act_dinner

local act_dinner = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      name = 2,    --名称-越南语-string 
      chat_before = 3,    --领取前对话-越南语-string 
      chat_after = 4,    --领取后对话-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Tiệc Trưa","Chúa công đói rồi sao? Ăn đi","Hãy quay lại vào 18:00",},
        [2] = {2,"Tiệc Tối","Chúa công đói rồi sao? Ăn đi","Hãy quay lại vào 21:00",},
        [3] = {3,"Tiệc Đêm","Mời chúa công uống cạn ly này!","Đêm nay chúa công không đi sao?",},
    }
}

return act_dinner