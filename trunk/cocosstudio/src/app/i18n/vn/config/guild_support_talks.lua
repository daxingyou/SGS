--guild_support_talks

local guild_support_talks = {
    -- key
    __key_map = {
      id = 1,    --说话id-int 
      talks = 2,    --援助看板娘随机说话文本，每次进入界面或者点击立绘头像随机播放文字-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Vẫn chưa ứng cứu quân đoàn sao? Hãy mau đi ứng cứu nào!",},
        [2] = {2,"Mỗi ngày cầu viện có thể nhận 3 Mảnh Tướng Đỏ!",},
        [3] = {3,"Mỗi ngày cầu viện có thể nhận 5 Mảnh Tướng Tím!",},
        [4] = {4,"Mỗi ngày cầu viện có thể nhận 4 Mảnh Tướng Cam!",},
        [5] = {5,"Vẫn chưa hoàn thành ứng cứu sao? Hãy mau đi kêu gọi quân đoàn đi!",},
        [6] = {6,"Mảnh Tướng thừa có thể tặng cho thành viên cùng quân đoàn!",},
        [7] = {7,"Tặng Mảnh Tướng được nhận nhiều cống hiến quân đoàn",},
        [8] = {8,"Hoàn thành 3 lần cầu viện được nhận thưởng đặc biệt!",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
    }
}

return guild_support_talks