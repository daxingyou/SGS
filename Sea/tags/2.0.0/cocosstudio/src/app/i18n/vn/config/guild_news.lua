--guild_news

local guild_news = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      news = 2,    --描述-越南语-string 
    
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
    }
}

return guild_news