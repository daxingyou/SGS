--act_dinner

local act_dinner = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      name = 2,    --名称-韩语-string 
      chat_before = 3,    --领取前对话-韩语-string 
      chat_after = 4,    --领取后对话-韩语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"점심","시장 하시지요? 맛있게 드세요~","저녁 18:00에 다시 봐요~",},
        [2] = {2,"저녁","시장 하시지요? 맛있게 드세요~","저녁 21:00에 다시 봐요~",},
        [3] = {3,"야식","이 잔을 단번에 들이켜주세요!","오늘 계속 함께 해주세요~",},
    }
}

return act_dinner