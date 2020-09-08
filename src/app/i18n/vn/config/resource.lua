--resource

local resource = {
    -- key
    __key_map = {
      id = 1,    --资源id-int 
      name = 2,    --资源名称-string 
      description = 3,    --道具描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"NB","Có thể chiêu mộ Danh Tướng và mua đạo cụ.",},
        [2] = {2,"Bạc","Có thể dùng để cường hóa trang bị, đột phá tướng.",},
        [3] = {3,"Thể Lực","Khiêu chiến chính tuyến, tinh anh, phó bản Danh Tướng cần tốn thể lực.",},
        [4] = {4,"Tinh Lực","Tài nguyên cần tốn khi Du Ngoạn.",},
        [5] = {5,"EXP","Khiêu chiến phó bản chính tuyến, Du Ngoạn và tiến hành mạo hiểm đều nhận EXP.",},
        [6] = {6,"EXP VIP","Tăng cấp VIP có thể mở khóa thêm tính năng VIP.",},
        [7] = {7,"Uy Danh","Có thể đổi Mảnh Tướng và Đột Phá Đơn trong Tiệm Đấu Trường.",},
        [8] = {8,"Công Trạng","Có thể đổi Thần Binh và Đá Thần Binh trong Tiệm Thần Binh.",},
        [9] = {9,"Tướng Hồn","Có thể đổi Tướng, Đột Phá Đơn, Bạc và Đỗ Khang trong Tiệm Thần Tướng.",},
        [10] = {10,"Tinh Thiết","Có thể đổi trang bị và Đá Tinh Luyện-T.Bị trong Tiệm Trang Bị.",},
        [11] = {11,"Dị Tộc Lệnh","Số lần tốn khi tấn công Dị Tộc",},
        [12] = {12,"Khiêu chiến","Số lần khiêu chiến Leo Tháp, Leo Tháp sẽ nhận nhiều trang bị.",},
        [13] = {13,"Cống Hiến Q.Đ","Có thể đổi Tướng hoặc đạo cụ giá trị trong Tiệm Quân Đoàn.",},
        [14] = {14,"Thần Hồn","Có thể đổi đạo cụ cần khi thức tỉnh trong Tiệm Thức Tỉnh.",},
        [15] = {15,"Thần Binh Hồn","Thu hồi Thần Binh có thể nhận, có thể đổi Thần Binh và Đá Thần Binh ở Tiệm Thần Binh",},
        [16] = {16,"Mức nạp","Dùng sẽ nhận mức nạp trong hoạt động tích lũy nạp, nạp một lần",},
        [17] = {17,"Hồn Bảo Vật","Có thể đổi bảo vật và đá tăng bậc bảo vật trong Tiệm Bảo Vật.",},
        [18] = {18,"Danh Vọng","Tích lũy danh vọng có thể tăng cấp Quân Đoàn.",},
        [19] = {19,"Thú Hồn","Có thể đổi Thần Thú hoặc tài nguyên liên quan Thần Thú trong Tiệm Thần Thú.",},
        [20] = {20,"Thủy Tinh","Tài nguyên cao cấp có thể nhận khi nạp, dùng trong Tiệm Thủy Tinh.",},
        [21] = {21,"Điểm nạp","Nạp nhận điểm thưởng, đổi nhiều phần thưởng trong Tiệm Thủy Tinh.",},
        [22] = {22,"Lương Thảo","Trong Ngân Khoáng Chiến di chuyển cần tốn lương thảo.",},
        [23] = {23,"Công Kích Lệnh","Trong Ngân Khoáng Chiến mỗi lần tấn công tốn 1 lần tấn công.",},
        [24] = {24,"Mảnh Biến Thân","Trong hoạt động Tạo Hình Hóa Thân có thể đổi Thẻ Biến Hình trong Tiệm Thẻ Biến Hình.",},
        [25] = {25,"Số lần truy kích","Truy Kích Tào Tháo trong hoạt động Cắt Râu Vứt Áo nhận nhiều thưởng.",},
        [26] = {26,"Số Chiêm Tinh","Chiêm tinh trong hoạt động Ngọa Long Chiêm Tinh nhận nhiều thưởng.",},
        [27] = {27,"Mức nạp riêng","Dùng sẽ nhận mức nạp riêng trong hoạt động tích lũy nạp, nạp một lần.",},
        [28] = {28,"Mã Hồn","Có thể đổi Chiến Mã trong Tiệm Chiến Mã",},
        [29] = {29,"Đao Tệ","Có thể đổi Đồ Đỏ và Cẩm Nang Đỏ trong Tiệm VIP.",},
        [30] = {30,"Hồn Ngọc","Dùng đổi Đá Thô trong Tiệm Đá.",},
        [31] = {31,"Công trạng","Dùng đổi tài nguyên quý hiếm trong Tiệm Đại Tiệc.",},
        [32] = {32,"Hồn Bàn Li Long","Dùng đổi tài nguyên quý hiếm trong Tiệm Kiến Long Tại Điền.",},
        [33] = {33,"Ngọc Bích","Có thể mua đạo cụ hiếm.",},
        [34] = {34,"Lệnh Di Chuyển","Di chuyển trong Ngân Khoáng Chiến Liên Server cần tốn Lệnh Di Chuyển.",},
        [35] = {35,"Xu Chân Võ","Thưởng Dự Đoán Chân Vũ Chiến Thần, dùng đổi tài nguyên hiếm trong Tiệm Chân Vũ Chiến Thần.",},
        [36] = {36,"Xu Dự Đoán","Tài nguyên tiêu hao dự đoán Chân Vũ Chiến Thần, tuyển thủ ủng hộ giành thắng lợi có thể nhận nhiều phần thưởng",},
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
        [20] = 20,
        [21] = 21,
        [22] = 22,
        [23] = 23,
        [24] = 24,
        [25] = 25,
        [26] = 26,
        [27] = 27,
        [28] = 28,
        [29] = 29,
        [3] = 3,
        [30] = 30,
        [31] = 31,
        [32] = 32,
        [33] = 33,
        [34] = 34,
        [35] = 35,
        [36] = 36,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
        [9] = 9,
    }
}

return resource