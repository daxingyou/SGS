--act_dinner

local act_dinner = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      name = 2,    --名称-简中-string 
      chat_before = 3,    --领取前对话-简中-string 
      chat_after = 4,    --领取后对话-中文-string 
    
    },
    -- data
    _data = {
        [1] = {1,"午宴","主公饿了吧?来吃个饱～","主公记得晚上18:00再来哦～",},
        [2] = {2,"晚宴","主公饿了吧?来吃个饱～","主公记得晚上21:00再来哦～",},
        [3] = {3,"夜宵","请主公满饮此杯!","主公今晚不走了吧?",},
    }
}

return act_dinner