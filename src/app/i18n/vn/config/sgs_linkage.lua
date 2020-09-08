--sgs_linkage

local sgs_linkage = {
    -- key
    __key_map = {
      id = 1,    --账号-int 
      mission_description = 2,    --说明-string 
      reward_name = 3,    --奖励名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Nhân vật tăng đến Lv#num#","Bạc",},
        [2] = {2,"Nhân vật tăng đến Lv#num#","Tăng Bậc Đơn",},
        [3] = {3,"Nhân vật tăng đến Lv#num#","Nhạn Linh Giáp",},
        [4] = {4,"Hoàn thành nạp lần đầu","Đậu Vui Vẻ",},
        [5] = {5,"Tích lũy nạp #num# VND","Chiêu Mộ Lệnh",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
    }
}

return sgs_linkage