--notification

local notification = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      time_txt = 2,    --标题-越南语-string 
      chat_before = 3,    --文本-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Tiệc Trưa đã bắt đầu","Các vị Chúa công, Tiệc Trưa đã bắt đầu, hãy mau đến dự tiệc để bổ sung thể lực!",},
        [2] = {2,"Tiệc Tối đã bắt đầu","Các vị Chúa công, Tiệc Tối đã bắt đầu, hãy mau đến dự tiệc để bổ sung thể lực!",},
        [3] = {3,"Tiệc Đêm đã bắt đầu","Các vị Chúa công, Tiệc Đêm đã bắt đầu, hãy mau đến dự tiệc để bổ sung thể lực!",},
        [4] = {4,"BOSS Quân Đoàn xuất hiện","BOSS Quân Đoàn 5 phút sau xuất hiện, chúa công hãy đến khiêu chiến, đánh bại BOSS có thể tham gia đấu giá và chia lợi nhuận!",},
        [5] = {5,"BOSS Quân Đoàn xuất hiện","BOSS Quân Đoàn 5 phút sau xuất hiện, chúa công hãy đến khiêu chiến, đánh bại BOSS có thể tham gia đấu giá và chia lợi nhuận!",},
        [6] = {6,"none","none",},
        [7] = {7,"Tam Quốc Chiến Kỷ khai chiến","Tam Quốc Chiến Kỷ 5 phút nữa khai chiến, khiêu chiến và đánh bại BOSS được tham gia đấu giá và chia lãi!",},
        [8] = {8,"Đấu Phe khai chiến","Đấu Phe 5 phút nữa khai chiến, ai là vua phe, hãy đến quyết đấu nào!",},
        [9] = {9,"Quân Đoàn Chiến sắp diễn ra","Quân Đoàn Chiến 5 phút nữa khai chiến!",},
    }
}

return notification