--seven_day_sprint

local seven_day_sprint = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      activity_content_text = 2,    --活动内容文本-string 
      name = 3,    --活动名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Ngày #num# mở máy chủ bình chọn ra Top 100 Quân Đoàn và phát thưởng. Tham gia hoạt động càng nhiều hạng càng cao!","Top 100 QĐ",},
    },

    -- index
    __index_id = {
        [1] = 1,
    }
}

return seven_day_sprint