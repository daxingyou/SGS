--act_dinner

local act_dinner = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      name = 2,    --名称-繁体-string 
      chat_before = 3,    --领取前对话-繁体-string 
      chat_after = 4,    --领取后对话-繁体-string 
    
    },
    -- data
    _data = {
        [1] = {1,"午宴","主公餓了吧?來吃個飽~","主公記得晚上18:00再來哦～",},
        [2] = {2,"晚宴","主公餓了吧?來吃個飽~","主公記得晚上21:00再來哦～",},
        [3] = {3,"夜宵","請主公滿飲此杯!","主公今晚不走了吧?",},
    }
}

return act_dinner