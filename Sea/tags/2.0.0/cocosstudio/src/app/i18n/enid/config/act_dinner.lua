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
        [1] = {1,"Tuan lapar? Ayo makan dulu~","Tuan, ingatlah datang lagi pk 18:00 malam~","Lunch",},
        [2] = {2,"Tuan lapar? Ayo makan dulu~","Tuan, ingatlah datang lagi pk 21:00 malam~","Dinner",},
        [3] = {3,"Silahkan dinikmati hidangannya!","Tuan jangan pergi yah malam ini?","Supper",},
    }
}

return act_dinner