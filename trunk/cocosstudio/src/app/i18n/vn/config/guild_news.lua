--guild_news

local guild_news = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      news = 2,    --描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"#name# đã gia nhập quân đoàn.",},
        [2] = {2,"#name# đã bị trục xuất khỏi quân đoàn.",},
        [3] = {3,"#name# đã thoát quân đoàn",},
        [4] = {4,"#name# được bổ nhiệm thành #position# mới.",},
        [5] = {5,"#name# đã bị bãi chức #position#.",},
        [6] = {6,"#name# đã lâu không làm gì cả, đã bị tố cáo.",},
        [7] = {7,"#name# đã vượt ải #stage#, mọi người mau đến đoạt kho báu nào.",},
        [8] = {8,"#name# đã tiến hành #id#, tăng #prestige# danh vọng cho quân đoàn.",},
        [9] = {9,"#name# đã hoàn thành nhiệm vụ ứng cứu quân đoàn, tăng #prestige# danh vọng cho quân đoàn.",},
        [10] = {10,"#name# đóng đóng góp cho #graincar#, giúp #graincar# tăng #num# EXP.",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [10] = 10,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
        [9] = 9,
    }
}

return guild_news