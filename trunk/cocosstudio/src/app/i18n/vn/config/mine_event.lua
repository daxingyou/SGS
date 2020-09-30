--mine_event

local mine_event = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      count_down_title = 2,    --倒计时标题-string 
      count_down_txt = 3,    --倒计时说明-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Mỏ Khoáng-Thường: ","Mỏ Khoáng-Thường không thể chiến đấu",},
        [2] = {2,"Mỏ Khoáng-Cao: ","Mỏ Khoáng-Cao có thể chiến đấu, chiếm Mỏ Khoáng",},
        [3] = {3,"Mỏ Khoáng-Siêu: ","Chiếm Mỏ Khoáng-Siêu nhận lợi ích cao nhất",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return mine_event