--horse_star

local horse_star = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name = 2,    --装备名称-string 
      skill = 3,    --技能描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Thanh Truy","[Thanh Truy] Tấn công +1%",},
        [2] = {1,"Phong-Thanh Truy","[Phong-Thanh Truy] Tấn công +2%",},
        [3] = {1,"Nhật-Thanh Truy","[Nhật-Thanh Truy] Tấn công +3%",},
        [4] = {2,"Lục Nhĩ","[Lục Nhĩ] Phòng thủ +1%",},
        [5] = {2,"Phong-Lục Nhĩ","[Phong-Lục Nhĩ] Phòng thủ +2%",},
        [6] = {2,"Nhật-Lục Nhĩ","[Nhật-Lục Nhĩ] Phòng thủ +3%",},
        [7] = {3,"Cừ Hoàng","[Cừ Hoàng] HP +1%",},
        [8] = {3,"Phong-Cừ Hoàng","[Phong-Cừ Hoàng] HP +2%",},
        [9] = {3,"Nhật-Cừ Hoàng","[Nhật-Cừ Hoàng] HP +3%",},
        [10] = {4,"Tảo Lưu","[Tảo Lưu] Bạo kích +1%",},
        [11] = {4,"Phong-Tảo Lưu","[Phong-Tảo Lưu] Bạo kích +2%",},
        [12] = {4,"Nhật-Tảo Lưu","[Nhật-Tảo Lưu] Bạo kích +3%",},
        [13] = {5,"Tuyết Bạch","[Tuyết Bạch] ST +3%",},
        [14] = {5,"Phong-Tuyết Bạch","[Phong-Tuyết Bạch] ST +6%",},
        [15] = {5,"Nhật-Tuyết Bạch","[Nhật-Tuyết Bạch] ST +9%",},
        [16] = {6,"Táp Lộ Tử","[Táp Lộ Tử] Giảm ST +3%",},
        [17] = {6,"Phong-Táp Lộ Tử","[Phong-Táp Lộ Tử] Giảm ST +6%",},
        [18] = {6,"Nhật-Táp Lộ Tử","[Nhật-Táp Lộ Tử] Giảm ST +9%",},
        [19] = {7,"Hồng Ngọc Liên","[Hồng Liên] HP +3%",},
        [20] = {7,"Phong-Hồng Liên","[Truy-Hồng Liên] HP +6%",},
        [21] = {7,"Nhật-Hồng Liên","[Nhật-Hồng Liên] HP +9%",},
        [22] = {8,"Bích Câu","[Bích Câu] Bạo kích +3%",},
        [23] = {8,"Phong-Bích Câu","[Phong-Bích Câu] Bạo kích +6%",},
        [24] = {8,"Nhật-Bích Câu","[Nhật-Bích Câu] Bạo kích +9%",},
        [25] = {9,"Phi Sương","[Phi Sương] Chuyển 20% sát thương gây ra cho phe địch thành trị liệu cho tướng sinh lực thấp nhất phe ta.",},
        [26] = {9,"Phong-Phi Sương","[Phong-Phi Sương] Chuyển 30% sát thương trực tiếp gây cho phe địch thành trị liệu cho đồng đội sinh lực thấp nhất, hồi thêm 10% sinh lực tối đa cho mục tiêu.",},
        [27] = {9,"Nhật-Phi Sương","[Nhật-Phi Sương] Chuyển 30% sát thương trực tiếp gây cho phe địch thành trị liệu cho đồng đội sinh lực thấp nhất, hồi thêm 30% sinh lực tối đa cho mục tiêu.",},
        [28] = {10,"Ô Vân","[Ô Vân] Tăng 16% sát thương.",},
        [29] = {10,"Phong-Ô Vân","[Phong-Ô Vân] Tăng 25% sát thương, nếu sát thương trực tiếp diệt được mục tiêu, 50% hồi 1 nộ.",},
        [30] = {10,"Nhật-Ô Vân","[Nhật-Ô Vân] Tăng 25% sát thương, nếu sát thương trực tiếp diệt được mục tiêu, sẽ hồi 1 nộ, lượt sau hồi nộ sẽ hồi thêm 1 điểm",},
        [31] = {11,"Hỏa Long","[Hỏa Long] Hiệu quả trị liệu tăng 10% đối với mục tiêu bị cấm trị liệu, giúp mục tiêu thêm 1 hộ thuẫn hút sát thương liên tục trong 1 lượt, hút sát thương bằng 40% lượng trị liệu",},
        [32] = {11,"Phong-Hỏa Long","[Phong-Hỏa Long] Hiệu quả trị liệu tăng 18% đối với mục tiêu bị cấm trị liệu, giúp mục tiêu thêm 1 hộ thuẫn hút sát thương liên tục trong 1 lượt, hút sát thương bằng 70% lượng trị liệu",},
        [33] = {11,"Nhật-Hỏa Long","[Nhật-Hỏa Long] Hiệu quả trị liệu tăng 25% đối với mục tiêu bị cấm trị liệu, giúp mục tiêu thêm 1 hộ thuẫn hút sát thương liên tục trong 1 lượt, hút sát thương bằng 100% lượng trị liệu",},
        [34] = {12,"Chiếu Dạ","[Chiếu Dạ] Khi chiến đấu mỗi lượt bị giảm tối đa 2 nộ khí",},
        [35] = {12,"Truy Phong-Chiếu Dạ","[Truy Phong-Chiếu Dạ] Trước khi chiến đấu bị giảm tối đa 1 nộ khí, Khi chiến đấu mỗi lượt bị giảm tối đa 2 nộ khí",},
        [36] = {12,"Trục Nhật-Chiếu Dạ","[Trục Nhật-Chiếu Dạ] Trước khi chiến đấu bị giảm tối đa 1 nộ khí, Khi chiến đấu mỗi lượt bị giảm tối đa 1 nộ khí",},
        [37] = {15,"Bôn Lôi","[Bôn Lôi] HP tối đa tăng 15%. Trong chiến đấu lần đầu chịu ST chí mạng sẽ không tử vong và hồi HP bằng 20% HP tối đa",},
        [38] = {15,"Truy Phong-Bôn Lôi","[Truy Phong-Bôn Lôi] HP tối đa tăng 30%. Trong chiến đấu lần đầu chịu ST chí mạng sẽ không tử vong và hồi HP bằng 40% HP tối đa, bản thân hồi 2 nộ.",},
        [39] = {15,"Trục Nhật-Bôn Lôi","[Trục Nhật-Bôn Lôi] HP tối đa tăng 45%. Trong chiến đấu lần đầu chịu ST chí mạng sẽ không tử vong và hồi HP bằng 60% HP tối đa, bản thân hồi 4 nộ.",},
        [40] = {13,"Trảo Hoàng","[Trảo Hoàng] Vui lòng chờ",},
        [41] = {13,"Nguyệt-Trảo Hoàng","[Nguyệt-Trảo Hoàng] Vui lòng chờ",},
        [42] = {13,"Thiên-Trảo Hoàng","[Thiên-Trảo Hoàng] Vui lòng chờ",},
        [43] = {14,"Đích Lô","[Đích Lô] Vui lòng chờ",},
        [44] = {14,"Nguyệt-Đích Lô","[Nguyệt-Đích Lô] Vui lòng chờ",},
        [45] = {14,"Thiên-Đích Lô","[Thiên-Đích Lô] Vui lòng chờ",},
        [46] = {16,"Huyết Tông","[Huyết Tông] Tăng 15% sinh lực tối đa. Khi dùng kỹ năng, nếu mục tiêu đang bị Thiêu Đốt, kỹ năng lần này sẽ sát thương thêm 4% sinh lực tối đa của mục tiêu.",},
        [47] = {16,"Phong-Huyết Tông","[Phong-Huyết Tông] Tăng 30% sinh lực tối đa. Khi dùng kỹ năng, nếu mục tiêu đang bị Thiêu Đốt, kỹ năng lần này sẽ sát thương thêm 6% sinh lực tối đa của mục tiêu.",},
        [48] = {16,"Nhật-Huyết Tông","[Nhật-Huyết Tông] Tăng 45% sinh lực tối đa. Khi dùng kỹ năng, nếu mục tiêu đang bị Thiêu Đốt, kỹ năng lần này sẽ sát thương thêm 8% sinh lực tối đa của mục tiêu.",},
        [49] = {17,"Tử Tinh","[Tử Tinh] Trước khi bắt đầu mỗi lượt, mỗi tướng cùng phe còn tồn tại, giúp Hộ Thuẫn tướng đang cưỡi tăng hấp thu sát thương trực tiếp bằng 8% sinh lực tối đa, duy trì 1 lượt.",},
        [50] = {17,"Phong-Tử Tinh","[Phong-Tử Tinh] Trước khi bắt đầu mỗi lượt, mỗi tướng cùng phe còn tồn tại, giúp Hộ Thuẫn tướng đang cưỡi tăng hấp thu sát thương trực tiếp bằng 16% sinh lực tối đa, duy trì 1 lượt.",},
        [51] = {17,"Nhật-Tử Tinh","[Nhật-Tử Tinh] Trước khi bắt đầu mỗi lượt, mỗi tướng cùng phe còn tồn tại, giúp Hộ Thuẫn tướng đang cưỡi tăng hấp thu sát thương trực tiếp bằng 24% sinh lực tối đa, duy trì 1 lượt.",},
    },

    -- index
    __index_id_star = {
        ["10_1"] = 28,
        ["10_2"] = 29,
        ["10_3"] = 30,
        ["11_1"] = 31,
        ["11_2"] = 32,
        ["11_3"] = 33,
        ["12_1"] = 34,
        ["12_2"] = 35,
        ["12_3"] = 36,
        ["13_1"] = 40,
        ["13_2"] = 41,
        ["13_3"] = 42,
        ["14_1"] = 43,
        ["14_2"] = 44,
        ["14_3"] = 45,
        ["15_1"] = 37,
        ["15_2"] = 38,
        ["15_3"] = 39,
        ["16_1"] = 46,
        ["16_2"] = 47,
        ["16_3"] = 48,
        ["17_1"] = 49,
        ["17_2"] = 50,
        ["17_3"] = 51,
        ["1_1"] = 1,
        ["1_2"] = 2,
        ["1_3"] = 3,
        ["2_1"] = 4,
        ["2_2"] = 5,
        ["2_3"] = 6,
        ["3_1"] = 7,
        ["3_2"] = 8,
        ["3_3"] = 9,
        ["4_1"] = 10,
        ["4_2"] = 11,
        ["4_3"] = 12,
        ["5_1"] = 13,
        ["5_2"] = 14,
        ["5_3"] = 15,
        ["6_1"] = 16,
        ["6_2"] = 17,
        ["6_3"] = 18,
        ["7_1"] = 19,
        ["7_2"] = 20,
        ["7_3"] = 21,
        ["8_1"] = 22,
        ["8_2"] = 23,
        ["8_3"] = 24,
        ["9_1"] = 25,
        ["9_2"] = 26,
        ["9_3"] = 27,
    }
}

return horse_star