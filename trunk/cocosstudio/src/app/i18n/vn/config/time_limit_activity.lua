--time_limit_activity

local time_limit_activity = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      description = 2,    --活动描述-string 
      name = 3,    --限时活动名称-string 
      start_des = 4,    --开启描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Mỗi ngày 12 giờ, 19 giờ mở. Số người tham gia càng nhiều, thưởng Đấu Giá càng nhiều. Tham gia hoạt động được nhận lợi tức đấu giá.","BOSS","Mỗi ngày",},
        [2] = {2,"Mỗi ngày 18 giờ mở. Số người tham gia càng nhiều, thưởng Đấu Giá càng nhiều. Tham gia hoạt động được nhận lợi tức đấu giá.","Vấn Đáp","Mỗi ngày",},
        [3] = {3,"Mỗi ngày mở từ 18:10 đến 18:40. Điểm càng nhiều, thưởng Đấu Giá càng nhiều. Tham gia hoạt động được nhận lợi tức đấu giá.","Thí Luyện QĐ","Mỗi ngày",},
        [4] = {4,"Tung hoành loạn thế, bá khí ngút trời. Danh tướng Tam Quốc, chiến, chiến! T4, T6, CN hằng tuần vào 21 giờ mở!","Chiến Kỷ","T4, T6, CN",},
        [5] = {5,"Đấu Phe báo danh vào 4:00 mỗi thứ 2 và 5, 21:00 khai chiến. Số người báo danh càng nhiều, thưởng Đấu giá càng nhiều.","Đấu Phe","Mỗi thứ 2, thứ 5",},
        [6] = {6,"10:00, 14:00, 16:00, 22:00 hàng ngày mở 2 trận, mỗi ngày 8 trận, ủng hộ Tướng tham gia thi đấu, Tướng đạt hạng 1 được nhận thưởng!","Hoa Dung Đạo","Mỗi ngày",},
        [7] = {7,"Hào kiệt Tam Quốc tụ họp. Sa trường điểm binh hào khí ngút trời.\nMỗi thứ 3 thứ 7 21:00 mở Quân Đoàn Chiến. Mau vào chiến nào!","QĐoàn Chiến","Mỗi thứ 3 thứ 7",},
        [8] = {8,"Thi đấu công bằng, bỏ qua lực chiến chỉ đấu chiến thuật!\nMỗi ngày 11:00-14:00 và 19:00-22:00 mở.","Vương Giả Chiến","Mỗi ngày",},
        [9] = {9,"Mỗi ngày 10h - 22h, tổ đội vượt Hoàng Lăng có cơ hội nhận Xuân Thu Chiến Quốc!","Hoàng Lăng","Mỗi ngày",},
        [10] = {10,"Báo danh lúc 04:00 T2, khai chiến lúc 21:00. Người chơi báo danh nhận lợi tức đấu giá Đấu Phe, Đấu LSV Cá Nhân Thứ 5.","Đấu Phe","T2 hàng tuần",},
        [11] = {11,"21:00 thứ 7 mở Quân Đoàn Chiến Liên Server. Quân Đoàn Chiếm các thành cấp 2, cấp 3 được tham gia Quân Đoàn Chiến Liên Server","QĐ Chiến LSV","T7 hàng tuần",},
        [12] = {12,"Nhóm gồm 8 server đã mở 30 ngày, T5 hàng tuần mở Đấu LSV Cá Nhân.  Người chơi báo danh được nhận lợi tức đấu giá","Đấu LSV Cá Nhân","T5 hàng tuần",},
        [13] = {13,"Vấn Đáp mở lúc 18:00 thứ 3, 5, 7. Người chơi tham gia đều được nhận lợi tức Đấu Giá QĐ.","Vấn Đáp","T3, 5, 7 hàng tuần",},
        [14] = {14,"Vấn Đáp Toàn Server mở lúc 18:00 thứ 2, 4 ,6, CN hàng tuần. Tham gia sẽ nhận được lợi tức đấu giá","Vấn Đáp Toàn SV","T2, 4, 6, CN hàng tuần",},
        [15] = {15,"Hào kiệt Tam Quốc tụ họp. Sa trường điểm binh hào khí ngút trời.\n21:00 mỗi thứ 3 mở Quân Đoàn Chiến. Mau vào chiến nào!","QĐoàn Chiến","Mỗi T3",},
        [16] = {16,"Xâm Nhập mở vào 22:00 T4, T6, CN. Người chơi đóng góp với Xe Lương QĐ được nhận thưởng. Tấn công Xe Lương QĐ khác nhận thưởng thêm.","Xâm Nhập","T4, T6, CN",},
        [17] = {17,"T2, T3, T5, T7 hàng tuần vào 10:00, 14:00, 16:00, 22:00 mở 2 trận. T4, T6, CN vào 10:00, 14:00, 16:00 mở 2 trận.","Hoa Dung Đạo","Mỗi ngày",},
        [18] = {18,"T3, T5, T7 hàng tuần BOSS 12:00, 19:00 và T2, T4, T6, CN hàng tuần 12:00 mở; Quân Đoàn có số người tham gia càng nhiều, Thưởng Đấu Giá càng nhiều; Tham gia hoạt động đều được nhận lợi tức Đấu Giá Quân Đoàn.","BOSS","Mỗi ngày",},
        [19] = {19,"Nhóm gồm 4 server đã mở 27 ngày, 19:00, Thứ 2, 4, 6 hàng tuần mở BOSS Liên Server. Số thành viên Quân Đoàn tham gia càng đông, nhận càng nhiều thưởng đấu giá. Tham gia hoạt động đều nhận được lợi nhuận đấu giá Quân Đoàn.","BOSS Liên Server","T2, 4, 6, CN hàng tuần",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [10] = 10,
        [11] = 11,
        [12] = 12,
        [13] = 13,
        [14] = 14,
        [15] = 15,
        [16] = 16,
        [17] = 17,
        [18] = 18,
        [19] = 19,
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

return time_limit_activity