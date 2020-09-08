--act_dinner

local act_dinner = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      chat_before = 2,    --领取前对话-string 
      chat_after = 3,    --领取后对话-string 
      name = 4,    --名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"主君、お腹がすいたでしょう?さあ、召し上がれ～","主君、18時になったらまた来てくださいね～","昼の宴",},
        [2] = {2,"主君、お腹がすいたでしょう?さあ、召し上がれ～","主君、21:00にまた来てくださいね～","夜の宴",},
        [3] = {3,"主君、ググっと1杯やってください！","主君、今夜は行かないんですか?","夜食",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return act_dinner