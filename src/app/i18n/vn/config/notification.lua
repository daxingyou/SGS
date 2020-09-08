--notification

local notification = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      chat_before = 2,    --文本-string 
      time_txt = 3,    --标题-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Các vị Chúa công, Tiệc Trưa đã bắt đầu, hãy mau đến dự tiệc để bổ sung thể lực!","Tiệc Trưa đã bắt đầu",},
        [2] = {2,"Các vị Chúa công, Tiệc Tối đã bắt đầu, hãy mau đến dự tiệc để bổ sung thể lực!","Tiệc Tối đã bắt đầu",},
        [3] = {3,"Các vị Chúa công, Tiệc Đêm đã bắt đầu, hãy mau đến dự tiệc để bổ sung thể lực!","Tiệc Đêm đã bắt đầu",},
        [4] = {4,"BOSS Quân Đoàn 5 phút sau xuất hiện, chúa công hãy đến khiêu chiến, đánh bại BOSS có thể tham gia đấu giá và chia lợi nhuận!","BOSS Quân Đoàn xuất hiện",},
        [5] = {5,"BOSS Quân Đoàn 5 phút sau xuất hiện, chúa công hãy đến khiêu chiến, đánh bại BOSS có thể tham gia đấu giá và chia lợi nhuận!","BOSS Quân Đoàn xuất hiện",},
        [6] = {6,"各位主公，快点登陆领取您的早上礼物吧~~~","每日早上礼物",},
        [7] = {7,"Tam Quốc Chiến Kỷ 5 phút nữa khai chiến, khiêu chiến và đánh bại BOSS được tham gia đấu giá và chia lãi!","Tam Quốc Chiến Kỷ khai chiến",},
        [8] = {8,"Đấu Phe 5 phút nữa khai chiến, ai là vua phe, hãy đến quyết đấu nào!","Đấu Phe khai chiến",},
        [9] = {9,"Quân Đoàn Chiến 5 phút nữa khai chiến!","Quân Đoàn Chiến sắp diễn ra",},
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
        [9] = 9,
    }
}

return notification