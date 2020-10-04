--title

local title = {
    -- key
    __key_map = {
      id = 1,    --序号_key-int 
      name = 2,    --名称-string 
      des = 3,    --条件描述-string 
      description = 4,    --详情描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Like!","Đăng nhập đạt 99 ngày","Đăng nhập đạt 99 ngày",},
        [2] = {2,"Thôi Nha!","Đoán đúng 99 lần trong Hoa Dung Đạo sẽ thắng","Đoán đúng 99 lần trong Hoa Dung Đạo sẽ thắng",},
        [3] = {3,"Vui Không?","Nhận 1 món trang bị Đỏ bất kỳ trong Rương Hoàng Kim","Nhận 1 món trang bị Đỏ bất kỳ trong Rương Hoàng Kim",},
        [4] = {4,"Sợ Chưa?","Trong Chiêm Tinh nhận ngay 1 Thần Thú Cam bất kỳ","Trong Chiêm Tinh nhận ngay 1 Thần Thú Cam bất kỳ",},
        [5] = {5,"Giờ Sao?","Trong Tháo Chạy nhận ngay 1 Đồ Đỏ bất kỳ","Trong Tháo Chạy nhận ngay 1 Đồ Đỏ bất kỳ",},
        [6] = {6,"Quá Đã!","Trong Hóa Thân nhận ngay 1 Tam Thanh Vũ ","Trong Hóa Thân nhận ngay 1 Tam Thanh Vũ ",},
        [7] = {7,"Ai Nữa?","Hạng 1 Đấu Hạng khi tổng kết Đấu Trường mỗi ngày","Hạng 1 Đấu Hạng khi tổng kết Đấu Trường mỗi ngày",},
        [8] = {8,"Gom Hết!","Có tất cả Võ Tướng (Không tính Võ Tướng Cam tăng lên Đỏ)","Có tất cả Võ Tướng (Không tính Võ Tướng Cam tăng lên Đỏ)",},
        [9] = {9,"Top 10","Top 10 BXH Lực Chiến mỗi ngày","Top 10 BXH Lực Chiến mỗi ngày",},
        [10] = {10,"Cứ Vui Đi!","Trong Ngân Khoáng Chiến bị diệt 999 lần","Trong Ngân Khoáng Chiến bị diệt 999 lần",},
        [11] = {11,"Ngụy Bá Chủ","Hạng 1 Đấu Phe-Ngụy","Hạng 1 Đấu Phe-Ngụy",},
        [12] = {12,"Thục Bá Chủ","Hạng 1 Đấu Phe-Thục","Hạng 1 Đấu Phe-Thục",},
        [13] = {13,"Ngô Bá Chủ","Hạng 1 Đấu Phe-Ngô","Hạng 1 Đấu Phe-Ngô",},
        [14] = {14,"Quần Hùng Bá Chủ","Hạng 1 Đấu Phe-Quần","Hạng 1 Đấu Phe-Quần",},
        [15] = {15,"May Thế!","Trong Hóa Thân nhận ngay 1 Kinh Hồng Vũ","Trong Hóa Thân nhận ngay 1 Kinh Hồng Vũ",},
        [16] = {16,"Nhỏ Thôi!","Có tất cả Thẻ Biến Hình Cam","Có tất cả Thẻ Biến Hình Cam",},
        [17] = {17,"Lộ Hàng!","Mỗi Thứ 4 Đấu Liên Server Cá Nhân Top 4","Mỗi Thứ 4 Đấu Liên Server Cá Nhân Top 4",},
        [18] = {18,"Hơn Gì Ai?","Diệt đủ 999 người chơi trong Ngân Khoáng Chiến","Diệt đủ 999 người chơi trong Ngân Khoáng Chiến",},
        [19] = {19,"Nhường Đó!","Hạng 2-10 khi tổng kết mùa giải Vương Giả Chiến","Hạng 2-10 khi tổng kết mùa giải Vương Giả Chiến",},
        [20] = {20,"Thiên Hạ Vô Song","Hạng 1 Đấu Cá Nhân Liên Server mỗi thứ 5","Hạng 1 Đấu Cá Nhân Liên Server mỗi thứ 5",},
        [21] = {21,"Tự Biết!","Hạng 1 khi tổng kết mùa giải Vương Giả Chiến","Hạng 1 khi tổng kết mùa giải Vương Giả Chiến",},
        [22] = {22,"Nhà Có Mỏ","Có tất cả Thẻ Biến Hình Đỏ","Có tất cả Thẻ Biến Hình Đỏ",},
        [23] = {23,"Hướng Dẫn Tân Thủ","Hướng Dẫn Tân Thủ","Hướng Dẫn Tân Thủ",},
        [24] = {24,"Chí Tại Bốn Phương","Danh hiệu kỷ niệm","Danh hiệu kỷ niệm",},
        [25] = {25,"Gió Thổi Mây Bay","Danh hiệu hoạt động lễ kỷ niệm,Có hiệu lực 30 ngày","Danh hiệu hoạt động lễ kỷ niệm,Có hiệu lực 30 ngày",},
        [26] = {26,"Khí Thế","Danh hiệu hoạt động lễ kỷ niệm,Có hiệu lực 30 ngày","Danh hiệu hoạt động lễ kỷ niệm,Có hiệu lực 30 ngày",},
        [27] = {27,"Lên Như Diều Gặp Gió","Danh hiệu hoạt động lễ kỷ niệm,Có hiệu lực 30 ngày","Danh hiệu hoạt động lễ kỷ niệm,Có hiệu lực 30 ngày",},
        [28] = {28,"Như Cá Gặp Nước","Danh hiệu hoạt động Kiến Long Tại Điền","Danh hiệu hoạt động Kiến Long Tại Điền",},
        [29] = {29,"Truy Tìm Dấu Vết","Danh hiệu hoạt động Kiến Long Tại Điền","Danh hiệu hoạt động Kiến Long Tại Điền",},
        [30] = {30,"Vất Vả Tìm Kiếm","Danh hiệu hoạt động Kiến Long Tại Điền","Danh hiệu hoạt động Kiến Long Tại Điền",},
        [31] = {1001,"Xuân 2020","Nhận trong sự kiện Xuân 2020","Nhận trong sự kiện Xuân 2020",},
        [32] = {1002,"Như Ý","Nhận trong sự kiện Xuân 2020","Nhận trong sự kiện Xuân 2020",},
        [33] = {1003,"Tân Xuân Đắc Lộc","Nhận trong sự kiện Xuân 2020","Nhận trong sự kiện Xuân 2020",},
        [34] = {1004,"Năm Mới Phát Tài","Nhận trong sự kiện Xuân 2020","Nhận trong sự kiện Xuân 2020",},
        [35] = {1005,"Đại Phú Đại Quý","Nhận trong sự kiện Xuân 2020","Nhận trong sự kiện Xuân 2020",},
        [36] = {8023,"","","",},
        [37] = {8024,"","","",},
        [38] = {8025,"","","",},
        [39] = {8026,"","","",},
        [40] = {8027,"","","",},
    }
}

return title