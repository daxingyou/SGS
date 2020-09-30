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
        [1] = {1,"ご主君様、お腹がすいたでしょう?さあ、召し上がれ～","ご主君様、18時になったらまた来てくださいね～","昼の宴",},
        [2] = {2,"ご主君様、お腹がすいたでしょう?さあ、召し上がれ～","ご主君様、21:00にまた来てくださいね～","夜の宴",},
        [3] = {3,"ご主君様、ググっと1杯やってください！","ご主君様、今夜は行かないんよね?","夜食",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return act_dinner