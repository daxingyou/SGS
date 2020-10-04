--time_limit_activity

local time_limit_activity = {
    -- key
    __key_map = {
      id = 1,    --编号_key-int 
      name = 2,    --限时活动名称-string 
      start_des = 3,    --开启描述-string 
      description = 4,    --活动描述-string 
      is_work = 5,    --是否显示-int 
    
    },
    -- data
    _data = {
        [1] = {1,"BOSS","Mỗi ngày","Mỗi ngày 12 giờ, 19 giờ mở. Số người tham gia càng nhiều, thưởng Đấu Giá càng nhiều. Tham gia hoạt động được nhận lợi tức đấu giá.",1,},
        [2] = {2,"Vấn Đáp","Mỗi ngày","Mỗi ngày 18 giờ mở. Số người tham gia càng nhiều, thưởng Đấu Giá càng nhiều. Tham gia hoạt động được nhận lợi tức đấu giá.",1,},
        [3] = {3,"Thí Luyện QĐ","Mỗi ngày","Mỗi ngày mở từ 18:10 đến 18:40. Điểm càng nhiều, thưởng Đấu Giá càng nhiều. Tham gia hoạt động được nhận lợi tức đấu giá.",1,},
        [4] = {4,"Chiến Kỷ","T4, T6, CN","Tung hoành loạn thế, bá khí ngút trời. Danh tướng Tam Quốc, chiến, chiến! T4, T6, CN hằng tuần vào 21 giờ mở!",1,},
        [5] = {5,"Đấu Phe","Mỗi thứ 2, thứ 5","Đấu Phe báo danh vào 4:00 mỗi thứ 2 và 5, 21:00 khai chiến. Số người báo danh càng nhiều, thưởng Đấu giá càng nhiều.",1,},
        [6] = {6,"Hoa Dung Đạo","Mỗi ngày","10:00, 14:00, 16:00, 22:00 hàng ngày mở 2 trận, mỗi ngày 8 trận, ủng hộ Tướng tham gia thi đấu, Tướng đạt hạng 1 được nhận thưởng!",1,},
        [7] = {7,"QĐoàn Chiến","Mỗi thứ 3 thứ 7","Hào kiệt Tam Quốc tụ họp. Sa trường điểm binh hào khí ngút trời.\nMỗi thứ 3 thứ 7 21:00 mở Quân Đoàn Chiến. Mau vào chiến nào!",1,},
        [8] = {8,"Vương Giả Chiến","Mỗi ngày","Thi đấu công bằng, bỏ qua lực chiến chỉ đấu chiến thuật!\nMỗi ngày 11:00-14:00 và 19:00-22:00 mở.",1,},
        [9] = {9,"Hoàng Lăng","Mỗi ngày","Mỗi ngày 10h - 22h, tổ đội vượt Hoàng Lăng có cơ hội nhận Xuân Thu Chiến Quốc!",1,},
        [10] = {10,"Đấu Phe","T2 hàng tuần","Báo danh lúc 04:00 T2, khai chiến lúc 21:00. Người chơi báo danh nhận lợi tức đấu giá Đấu Phe, Đấu LSV Cá Nhân Thứ 5.",1,},
        [11] = {11,"QĐoàn Chiến LSV","T7 hàng tuần","21h T3/T7 mở QĐ Chiến SV/LSV\nQĐ chiếm Hổ Lao/Hàm Cốc/Kiếm Các/Tiêu Dao được tham chiến LSV\nQĐ khác được tham chiến SV.",1,},
        [12] = {12,"Đấu LSV Cá Nhân","T5 hàng tuần","Nhóm gồm 8 server đã mở 30 ngày, T5 hàng tuần mở Đấu LSV Cá Nhân.  Người chơi báo danh được nhận lợi tức đấu giá",1,},
        [13] = {13,"Vấn Đáp","T3, 5, 7 hàng tuần","Vấn Đáp mở lúc 18:00 thứ 3, 5, 7. Người tham gia được nhận lợi tức Đấu Giá QĐ.",1,},
        [14] = {14,"Vấn Đáp Toàn SV","T2, 4, 6, CN hàng tuần","Vấn Đáp Toàn Server mở lúc 18:00 thứ 2, 4, 6 hàng tuần. Người chơi tham gia đều được nhận lợi tức Đấu Giá Quân Đoàn.",1,},
    }
}

return time_limit_activity