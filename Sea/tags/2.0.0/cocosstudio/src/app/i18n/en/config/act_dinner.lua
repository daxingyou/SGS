--act_dinner

local act_dinner = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --名称-英语-string 
      chat_before = 3,    --领取前对话-英语-string 
      chat_after = 4,    --领取后对话-英语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Lunch","My lord, are you hungry? Come and have a feast!","My lord, please remember to come back at 18:00!",},
        [2] = {2,"Dinner","My lord, are you hungry? Come and have a feast!","My lord, please remember to come back at 21:00!",},
        [3] = {3,"Supper","My lord, please empty the full drink!","My lord, you are staying tonight, right?",},
    }
}

return act_dinner