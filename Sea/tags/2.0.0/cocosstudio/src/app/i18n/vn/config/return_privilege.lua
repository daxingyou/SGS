--return_privilege

local return_privilege = {
    -- key
    __key_map = {
      id = 1,    --编号_key-int 
      privilege_txt = 2,    --特权说明-string 
      button_txt = 3,    --按钮文字-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Thiếp lập lại Phó Bản Ngày","Thiếp lập lại|Chiến đấu",},
        [2] = {2,"Thiết lập lại Leo Tháp","Thiếp lập lại|Chiến đấu",},
        [3] = {3,"Khiêu chiến Phó Bản Chính Tuyến nhận thưởng x2","Chiến đấu",},
        [4] = {4,"Khiêu chiến Phó Bản Tinh Anh nhận thưởng x2","Chiến đấu",},
        [5] = {5,"Khiêu chiến Phó Bản Danh Tướng nhận thưởng x2","Chiến đấu",},
        [6] = {6,"Du Ngoạn rơi EXP bảo vật và Bạc x2","Du Ngoạn",},
        [7] = {7,"Quân Đoàn Tế Lễ và Danh Vọng Ngày x2","Quân Đoàn",},
        [8] = {8,"Điểm Danh Ngày nhận thưởng x2","Nhận",},
        [9] = {9,"Ngũ Cốc Phong Đăng nhận thưởng x2","Nhận",},
        [10] = {10,"Nhiệm Vụ Ngày nhận thưởng x2","Nhận",},
        [11] = {11,"Thiếp lập lại Phó Bản Ngày","Thiếp lập lại|Chiến đấu",},
        [12] = {12,"Thiết lập lại Leo Tháp","Thiếp lập lại|Chiến đấu",},
        [13] = {13,"Khiêu chiến Phó Bản Chính Tuyến nhận thưởng x2","Chiến đấu",},
        [14] = {14,"Khiêu chiến Phó Bản Tinh Anh nhận thưởng x2","Chiến đấu",},
        [15] = {15,"Khiêu chiến Phó Bản Danh Tướng nhận thưởng x2","Chiến đấu",},
        [16] = {16,"Du Ngoạn rơi EXP bảo vật và Bạc x2","Du Ngoạn",},
        [17] = {17,"Quân Đoàn Tế Lễ và Danh Vọng Ngày x2","Quân Đoàn",},
        [18] = {18,"Điểm Danh Ngày nhận thưởng x2","Nhận",},
        [19] = {19,"Ngũ Cốc Phong Đăng nhận thưởng x2","Nhận",},
        [20] = {20,"Nhiệm Vụ Ngày nhận thưởng x2","Nhận",},
        [21] = {21,"Thiếp lập lại Phó Bản Ngày","Thiếp lập lại|Chiến đấu",},
        [22] = {22,"Thiết lập lại Leo Tháp","Thiếp lập lại|Chiến đấu",},
        [23] = {23,"Khiêu chiến Phó Bản Chính Tuyến nhận thưởng x2","Chiến đấu",},
        [24] = {24,"Khiêu chiến Phó Bản Tinh Anh nhận thưởng x2","Chiến đấu",},
        [25] = {25,"Khiêu chiến Phó Bản Danh Tướng nhận thưởng x2","Chiến đấu",},
        [26] = {26,"Du Ngoạn rơi EXP bảo vật và Bạc x2","Du Ngoạn",},
        [27] = {27,"Quân Đoàn Tế Lễ và Danh Vọng Ngày x2","Quân Đoàn",},
        [28] = {28,"Điểm Danh Ngày nhận thưởng x2","Nhận",},
        [29] = {29,"Ngũ Cốc Phong Đăng nhận thưởng x2","Nhận",},
        [30] = {30,"Nhiệm Vụ Ngày nhận thưởng x2","Nhận",},
        [31] = {31,"Thiếp lập lại Phó Bản Ngày","Thiếp lập lại|Chiến đấu",},
        [32] = {32,"Thiết lập lại Leo Tháp","Thiếp lập lại|Chiến đấu",},
        [33] = {33,"Khiêu chiến Phó Bản Chính Tuyến nhận thưởng x2","Chiến đấu",},
        [34] = {34,"Khiêu chiến Phó Bản Tinh Anh nhận thưởng x2","Chiến đấu",},
        [35] = {35,"Khiêu chiến Phó Bản Danh Tướng nhận thưởng x2","Chiến đấu",},
        [36] = {36,"Du Ngoạn rơi EXP bảo vật và Bạc x2","Du Ngoạn",},
        [37] = {37,"Quân Đoàn Tế Lễ và Danh Vọng Ngày x2","Quân Đoàn",},
        [38] = {38,"Điểm Danh Ngày nhận thưởng x2","Nhận",},
        [39] = {39,"Ngũ Cốc Phong Đăng nhận thưởng x2","Nhận",},
        [40] = {40,"Nhiệm Vụ Ngày nhận thưởng x2","Nhận",},
        [41] = {41,"Thiếp lập lại Phó Bản Ngày","Thiếp lập lại|Chiến đấu",},
        [42] = {42,"Thiết lập lại Leo Tháp","Thiếp lập lại|Chiến đấu",},
        [43] = {43,"Khiêu chiến Phó Bản Chính Tuyến nhận thưởng x2","Chiến đấu",},
        [44] = {44,"Khiêu chiến Phó Bản Tinh Anh nhận thưởng x2","Chiến đấu",},
        [45] = {45,"Khiêu chiến Phó Bản Danh Tướng nhận thưởng x2","Chiến đấu",},
        [46] = {46,"Du Ngoạn rơi EXP bảo vật và Bạc x2","Du Ngoạn",},
        [47] = {47,"Quân Đoàn Tế Lễ và Danh Vọng Ngày x2","Quân Đoàn",},
        [48] = {48,"Điểm Danh Ngày nhận thưởng x2","Nhận",},
        [49] = {49,"Ngũ Cốc Phong Đăng nhận thưởng x2","Nhận",},
        [50] = {50,"Nhiệm Vụ Ngày nhận thưởng x2","Nhận",},
        [51] = {51,"Thiếp lập lại Phó Bản Ngày","Thiếp lập lại|Chiến đấu",},
        [52] = {52,"Thiết lập lại Leo Tháp","Thiếp lập lại|Chiến đấu",},
        [53] = {53,"Khiêu chiến Phó Bản Chính Tuyến nhận thưởng x2","Chiến đấu",},
        [54] = {54,"Khiêu chiến Phó Bản Tinh Anh nhận thưởng x2","Chiến đấu",},
        [55] = {55,"Khiêu chiến Phó Bản Danh Tướng nhận thưởng x2","Chiến đấu",},
        [56] = {56,"Du Ngoạn rơi EXP bảo vật và Bạc x2","Du Ngoạn",},
        [57] = {57,"Quân Đoàn Tế Lễ và Danh Vọng Ngày x2","Quân Đoàn",},
        [58] = {58,"Điểm Danh Ngày nhận thưởng x2","Nhận",},
        [59] = {59,"Ngũ Cốc Phong Đăng nhận thưởng x2","Nhận",},
        [60] = {60,"Nhiệm Vụ Ngày nhận thưởng x2","Nhận",},
    }
}

return return_privilege