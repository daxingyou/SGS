--tree_buff

local tree_buff = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      screen_comment = 2,    --屏幕生效提示-string 
      description = 3,    --祝福描述-string 
      name = 4,    --祝福名称-string 
      color_text = 5,    --品质名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Chúc Phúc #name#: Thời gian Hoàng Lăng tăng #value# phút.","Thời gian Hoàng Lăng tăng #value# phút . (Có thể vượt hơn 70 phút)","Cầu Nguyện","Xăm T.Thượng",},
        [2] = {2,"","Tự động bỏ #value# lựa chọn sai trong Vấn Đáp.","Thần Diệu","Xăm Thượng",},
        [3] = {3,"Chúc Phúc #name#: Nhận được Lì Xì trị giá #value# Nguyên Bảo.","Nhận được Lì Xì trị giá #value# Nguyên Bảo, mau phát ngay nào!","Thiện Tâm","Xăm Trung",},
        [4] = {4,"Chúc Phúc #name#: Trả lời sai không bị loại.","Vấn Đáp Toàn Máy Chủ #times# lần đáp sai không bị loại.","Công Danh","Xăm Trung",},
        [5] = {5,"Chúc Phúc #name#: Chiến bại không trừ lượt.","Thí Luyện QĐ #times# lần bại trận đầu tiên không trừ lượt.","Tái Khởi","Xăm Trung",},
        [6] = {6,"Chúc Phúc #name#: Về đích nhận thêm #value# Tướng Mã Kinh.","Mã Dược Đàn Khê về đích nhận thêm #value# Tướng Mã Kinh.","Ngựa Tốt","Xăm Trung",},
        [7] = {7,"Chúc Phúc #name#: Nhận thêm #value#% Cống Hiến.","Chiến thắng Thí Luyện QĐ nhận thêm #value#% Cống Hiến.","Hiển Hách","Xăm Thượng",},
        [8] = {8,"Chúc Phúc #name#: Tử trận được hồi sinh tại chỗ.","Quân Đoàn Chiến bị đánh bại hồi sinh tại chỗ #times# lần.","Trở Lại","Xăm Trung",},
        [9] = {9,"","Thời gian chờ Quân Đoàn Chiến giảm #value# giây.","Thần Tốc","Xăm Thượng",},
        [10] = {10,"","Quân Đoàn Chiến tăng #value#% sinh lực.","Hùng Dũng","Xăm Thượng",},
        [11] = {11,"","Quân Đoàn Chiến tấn công kiến trúc gây thêm #value#% sát thương.","Sắc Bén","Xăm T.Thượng",},
        [12] = {12,"","Khiêu Chiến BOSS được tranh đoạt thêm #value# lần.","Sản Sinh","Xăm Trung",},
        [13] = {13,"Chúc Phúc #name#: Tranh đoạt nhận thêm #value#% điểm.","Khiêu Chiến BOSS khi tranh đoạt nhận thêm #value#% điểm.","Tiện Tay","Xăm Trung",},
        [14] = {14,"Chúc Phúc #name#: Tranh đoạt thất bại không trừ lượt.","Khiêu Chiến BOSS tranh đoạt thất bại không trừ lượt, không cần chờ.","Thoát Xác","Xăm Trung",},
        [15] = {15,"Chúc Phúc #name#: Gây thêm #value#% sát thương.","Tam Quốc Chiến Kỷ gây thêm cho BOSS #value#% sát thương.","Tề Xạ","Xăm Trung",},
        [16] = {16,"","Hoa Dung Đạo có thể đặt #value# Phiếu Chi Trả cho 1 tuyển thủ.","Dốc Túi","Xăm T.Thượng",},
        [17] = {17,"Chúc Phúc #name#: Giảm hao tổn khi di chuyển.","Ngân Khoáng Chiến qua #times# mỏ đầu tiên không tốn Lương Thảo.","Sẵn Sàng","Xăm Thượng",},
        [18] = {18,"Chúc Phúc #name#: Mua đạo cụ sẽ được ưu đãi.","Mua Lương Thảo, #times# lần đầu được giảm giá #value#%.","Bội Thu","Xăm Trung",},
        [19] = {19,"Chúc Phúc #name#: Mua đạo cụ sẽ được ưu đãi.","Mua Công Kích Lệnh, #times# lần đầu được giảm giá #value#%.","Món Hời","Xăm Trung",},
        [20] = {20,"Chúc Phúc #name#: Tấn công gây tổn thất thêm Lính.","Ngân Khoáng Chiến tấn công gây tổn thất thêm #value# Lính địch.","Cuồng Chiến","Xăm T.Thượng",},
        [21] = {21,"","Ngân Khoáng Chiến đào mỏ nhận thêm #value#%","","Xăm Đại Cát",},
        [22] = {22,"","Mã Dược Đàn Khê về đích nhận thêm #value# Tướng Mã Kinh #times# lần","","Xăm Trung Cát",},
        [23] = {23,"","Dị Tộc Xâm Lược tăng #value#% phát hiện Thần-Mạnh Hoạch","Tuệ Nhãn","Xăm Tiểu Cát",},
        [24] = {24,"Chúc Phúc #name#: Gây thêm #value#% sát thương.","Đạo pháp tự nhiên, biến hóa khôn lường. Khi tấn công BOSS Liên Server ở trạng thái Tụ Lực, nhận #value#% Buff ST tự thích ứng.","Linh Động","Xăm T.Thượng",},
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
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
        [9] = 9,
    }
}

return tree_buff