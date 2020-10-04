--equip_stage

local equip_stage = {
    -- key
    __key_map = {
      id = 1,    --关卡id_key-int 
      name = 2,    --关卡名-越南语-string 
      talk = 3,    --副本对话-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Ải 1 Nhạc Tiến","Ta sẽ vượt tường thành, lập công đầu!",},
        [2] = {2,"Ải 2 Tào Nhân","Vững vàng, kiên cố!",},
        [3] = {3,"Ải 3 Hạ Hầu Đôn","Ăn miếng trả miếng!",},
        [4] = {4,"Ải 4 Chúc Dung","Hãy nếm mùi lợi hại của phi đao của ta!",},
        [5] = {5,"Ải 5 Trương Phi","Trương Phi ở đây!!! ",},
        [6] = {6,"Ải 6 Quan Vũ","Ta thấy ngươi đến để nộp mạng.",},
        [7] = {7,"Ải 7 Lăng Thống","Sát thương kẻ địch ngoài ngàn dặm!",},
        [8] = {8,"Ải 8 Tôn Quyền","Để ta suy nghĩ!",},
        [9] = {9,"Ải 9 Thái Sử Từ","Hãy giúp ta!",},
        [10] = {10,"Ải 10 Nhan Lương","Ta là thượng tướng Nhan Lương!",},
        [11] = {11,"Ải 11 Công Tôn Toản","Các tướng nghe lệnh, xếp đội hình, ngăn địch!",},
        [12] = {12,"Ải 12 Giả Hủ","Thần tiên khó cứu, thần tiên khó cứu!",},
        [13] = {13,"Ải 13 Điển Vi","Ta sẽ lấy mạng ngươi trong vòng 3 bước!",},
        [14] = {14,"Ải 14 Hứa Chử","Ai dám đấu với ta 300 lượt!",},
        [15] = {15,"Ải 15 Tào Tháo","Người đâu, hộ giá!",},
        [16] = {16,"Ải 16 Hoàng Trung","Thiện Xạ!",},
        [17] = {17,"Ải 17 Mã Siêu","Toàn quân tấn công!",},
        [18] = {18,"Ải 18 Triệu Vân","Ta là Triệu Tử Long!",},
        [19] = {19,"Ải 19 Cam Ninh","Tiếp chiêu đi.",},
        [20] = {20,"Ải 20 Lữ Mông","Giữ cho rừng còn xanh, chẳng lo thiếu củi đốt!",},
        [21] = {21,"Ải 21 Tôn Sách","Ta là Tiểu Bá Vương Tôn Bá Phù.",},
        [22] = {22,"Ải 22 Hoa Hùng","Mùi rượu nồng nặc thật!",},
        [23] = {23,"Ải 23 Đổng Trác","Mỹ nhân! Cho ta thơm cái nào!",},
        [24] = {24,"Ải 24 Lữ Bố","Không ai được ngăn cản ta!",},
        [25] = {25,"Ải 25 Trương Hợp","Binh vô thường thế, thủy vô thường hình.",},
        [26] = {26,"Ải 26 Trương Liêu","Hừ~Không ngờ đúng không!",},
        [27] = {27,"Ải 27 Tư Mã Ý","Đi rồi cũng có ngày về!",},
        [28] = {28,"Ải 28 Ngụy Diên","Ta sợ ngươi à?",},
        [29] = {29,"Ải 29 Khương Duy","Ngươi đó, có dám đấu với ta không?",},
        [30] = {30,"Ải 30 Gia Cát Lượng","Nhìn thiên tượng đêm nay, biết đại sự của thiên hạ.",},
        [31] = {31,"Ải 31 Thượng Hương","Hắn khỏe ta cũng khỏe.",},
        [32] = {32,"Ải 32 Tôn Kiên","Linh hồn ta sẽ bảo vệ cơ nghiệp của con ta.",},
        [33] = {33,"Ải 33 Chu Du","Ngươi nhìn cho rõ đây!",},
        [34] = {34,"Ải 34 Viên Thuật","Ngọc tỷ trong tay, thiên hạ là của ta!",},
        [35] = {35,"Ải 35 Viên Thiệu","Cung Thủ, chuẩn bị bắn tên!",},
        [36] = {36,"Ải 36 Tả Từ","Hừ, người phàm mắt thịt, làm sao thấy được sự biến ảo của tiên nhân?",},
        [37] = {37,"Ải 37 Chân Cơ","Lăng ba vi bộ, la vát sinh trần.",},
        [38] = {38,"Ải 38 Tào Phi","Tội chết được miễn, tội sống khó tha!",},
        [39] = {39,"Ải 39 Quách Gia","Khụ, khụ!",},
        [40] = {40,"Ải 40 Từ Thứ","Suỵt! Nói nhiều sẽ sai nhiều.",},
        [41] = {41,"Ải 41 Bàng Thống","Diệt một ảnh hưởng trăm!",},
        [42] = {42,"Ải 42 Lưu Bị","Tướng Thục đâu rồi!",},
        [43] = {43,"Ải 43 Lỗ Túc","Lấy đi lấy đi, đừng khách sáo với ca ca!",},
        [44] = {44,"Ải 44 Lục Tốn","Người cũ không đi người mới không đến.",},
        [45] = {45,"Ải 45 Đại Kiều","Hãy nghỉ ngơi.",},
        [46] = {46,"Ải 46 Vu Cát","Ngươi tin không?",},
        [47] = {47,"Ải 47 Trương Giác","Dùng chân khí của ta để hợp trời đất lại!",},
        [48] = {48,"Ải 48 Điêu Thuyền","Phu quân, chàng phải phân xử cho thiếp!",},
        [49] = {49,"Ải 49 Điển Vi","Ta sẽ lấy mạng ngươi trong vòng 3 bước!",},
        [50] = {50,"Ải 50 Trương Liêu","Hừ~Không ngờ đúng không!",},
        [51] = {51,"Ải 51 Tào Tháo","Người đâu, hộ giá!",},
        [52] = {52,"Ải 52 Mã Siêu","Toàn quân tấn công!",},
        [53] = {53,"Ải 53 Khương Duy","Ngươi đó, có dám đấu với ta không?",},
        [54] = {54,"Ải 54 Triệu Vân","Ta là Triệu Tử Long!",},
        [55] = {55,"Ải 55 Lữ Mông","Giữ cho rừng còn xanh, chẳng lo thiếu củi đốt!",},
        [56] = {56,"Ải 56 Tôn Kiên","Linh hồn ta sẽ bảo vệ cơ nghiệp của con ta.",},
        [57] = {57,"Ải 57 Tôn Sách","Ta là Tiểu Bá Vương Tôn Bá Phù.",},
        [58] = {58,"Ải 58 Đổng Trác","Mỹ nhân! Cho ta thơm cái nào!",},
        [59] = {59,"Ải 59 Viên Thiệu","Cung Thủ, chuẩn bị bắn tên!",},
        [60] = {60,"Ải 60 Lữ Bố","Không ai được ngăn cản ta!",},
        [61] = {61,"Ải 61 Hạ Hầu Đôn","Ăn miếng trả miếng!",},
        [62] = {62,"Ải 62 Trương Hợp","Binh vô thường thế, thủy vô thường hình.",},
        [63] = {63,"Ải 63 Tư Mã Ý","Đi rồi cũng có ngày về!",},
        [64] = {64,"Ải 64 Quan Vũ","Ta thấy ngươi đến để nộp mạng.",},
        [65] = {65,"Ải 65 Ngụy Diên","Ta sợ ngươi à?",},
        [66] = {66,"Ải 66 Gia Cát Lượng","Nhìn thiên tượng đêm nay, biết đại sự của thiên hạ.",},
        [67] = {67,"Ải 67 Thái Sử Từ","Hãy giúp ta!",},
        [68] = {68,"Ải 68 Thượng Hương","Hắn khỏe ta cũng khỏe.",},
        [69] = {69,"Ải 69 Chu Du","Ngươi nhìn cho rõ đây!",},
        [70] = {70,"Ải 70 Giả Hủ","Thần tiên khó cứu, thần tiên khó cứu!",},
        [71] = {71,"Ải 71 Viên Thuật","Ngọc tỷ trong tay, thiên hạ là của ta!",},
        [72] = {72,"Ải 72 Tả Từ","Hừ, người phàm mắt thịt, làm sao thấy được sự biến ảo của tiên nhân?",},
        [73] = {73,"Ải 73 Tào Nhân","Vững vàng, kiên cố!",},
        [74] = {74,"Ải 74 Trương Liêu","Hừ~Không ngờ đúng không!",},
        [75] = {75,"Ải 75 Tào Tháo","Người đâu, hộ giá!",},
        [76] = {76,"Ải 76 Trương Phi","Trương Phi ở đây!!! ",},
        [77] = {77,"Ải 77 Hoàng Trung","Thiện Xạ!",},
        [78] = {78,"Ải 78 Triệu Vân","Ta là Triệu Tử Long!",},
        [79] = {79,"Ải 79 Tôn Quyền","Để ta suy nghĩ!",},
        [80] = {80,"Ải 80 Tôn Kiên","Linh hồn ta sẽ bảo vệ cơ nghiệp của con ta.",},
        [81] = {81,"Ải 81 Tôn Sách","Ta là Tiểu Bá Vương Tôn Bá Phù.",},
        [82] = {82,"Ải 82 Công Tôn Toản","Các tướng nghe lệnh, xếp đội hình, ngăn địch!",},
        [83] = {83,"Ải 83 Viên Thiệu","Cung Thủ, chuẩn bị bắn tên!",},
        [84] = {84,"Ải 84 Lữ Bố","Không ai được ngăn cản ta!",},
        [85] = {85,"Ải 85 Hứa Chử","Ai dám đấu với ta 300 lượt!",},
        [86] = {86,"Ải 86 Tào Phi","Tội chết được miễn, tội sống khó tha!",},
        [87] = {87,"Ải 87 Quách Gia","Khụ, khụ!",},
        [88] = {88,"Ải 88 Mã Siêu","Toàn quân tấn công!",},
        [89] = {89,"Ải 89 Bàng Thống","Diệt một ảnh hưởng trăm!",},
        [90] = {90,"Ải 90 Lưu Bị","Tướng Thục đâu rồi!",},
        [91] = {91,"Ải 91 Lữ Mông","Giữ cho rừng còn xanh, chẳng lo thiếu củi đốt!",},
        [92] = {92,"Ải 92 Lục Tốn","Người cũ không đi người mới không đến.",},
        [93] = {93,"Ải 93 Đại Kiều","Hãy nghỉ ngơi.",},
        [94] = {94,"Ải 94 Đổng Trác","Mỹ nhân! Cho ta thơm cái nào!",},
        [95] = {95,"Ải 95 Trương Giác","Dùng chân khí của ta để hợp trời đất lại!",},
        [96] = {96,"Ải 96 Điêu Thuyền","Phu quân, chàng phải phân xử cho thiếp!",},
        [97] = {97,"Ải 97 Chân Cơ","Lăng ba vi bộ, la vát sinh trần.",},
        [98] = {98,"Ải 98 Trương Hợp","Binh vô thường thế, thủy vô thường hình.",},
        [99] = {99,"Ải 99 Điển Vi","Ta sẽ lấy mạng ngươi trong vòng 3 bước!",},
        [100] = {100,"Ải 100 Hoàng Trung","Thiện Xạ!",},
        [101] = {101,"Ải 101 Thản Khắc Trận","Có chúng ta đây, đừng hòng qua được chỗ này!",},
        [102] = {102,"Ải 102 Truy Kích Trận","Ngươi, có nghe đến truy kích chưa?",},
        [103] = {103,"Ải 103 Huyền Vựng Trận","Xem ngươi có tỉnh lại được không.",},
        [104] = {104,"Ải 104 Phản Thương Trận","Ăn đòn đau nhất, trở nên gan lì nhất!",},
        [105] = {105,"Ải 105 Hấp Huyết Trận","Dĩ chiến dưỡng chiến mới được lâu dài.",},
        [106] = {106,"Ải 106 Vĩnh Động Trận","Kỹ năng, chúng ta là vô hạn.",},
        [107] = {107,"Ải 107 Trầm Mặc Trận","Im lặng là sự chống đối không lời.",},
        [108] = {108,"Ải 108 Bạo Lực Trận","Hồi 1, chúng ta là mạnh nhất.",},
        [109] = {109,"Ải 109 Giảm Nộ Trận","Ngươi giữ được nộ khí, kể cũng lợi hại thật.",},
        [110] = {110,"Ải 110 Ma Tê Trận","Tiến công? Không tồn tại.",},
        [111] = {111,"Ải 111 Độc Nãi Trận","Đánh ngươi không hề hấn gì, ta hành hạ ngươi.",},
        [112] = {112,"Ải 112 Lục Nãi Trận","Ngươi ra tay đủ chưa?",},
        [113] = {113,"Ải 113 Hậu Bài Trận","Phía sau ngươi đủ vững chưa?",},
        [114] = {114,"Ải 114 Mỹ Nữ Trận","Anh hùng khó qua ải mỹ nhân.",},
        [115] = {115,"Ải 115 Cung Thủ Trận","Chúng ta đều là Thần Xạ.",},
        [116] = {116,"Ải 116 Mưu Sĩ Trận","Khua môi múa mép, giành thiên hạ.",},
        [117] = {117,"Ải 117 Toàn Thể Trận","Tấn công đơn, không tồn tại.",},
        [118] = {118,"Ải 118 Ngũ Hổ Trận","Chúng ta là, ngũ hổ thượng tướng!",},
        [119] = {119,"Ải 119 Mãnh Tướng Trận","Ngũ hổ thượng tướng gì chứ, chỉ bốc phét thôi.",},
        [120] = {120,"Ải 120 Đô Đốc Trận","Nếu nói lợi hại thì Tứ Đại Đô Đốc chúng ta mới lợi hại.",},
        [121] = {121,"Ải 121 Miểu Sát Trận","Hãy chờ đến khi ta có 10 điểm nộ khí!",},
        [122] = {122,"Ải 122 Quang Hoàn Trận","Chúng ta nghiêm túc đấy.",},
        [123] = {123,"Ải 123 Tung Hỏa Trận","Phóng hỏa chẳng phải là khả năng đặc biệt của Khổng Minh sao?",},
        [124] = {124,"Ải 124 Bính Từ Trận","Đánh mãi đánh mãi thì ngươi sẽ tiêu đời.",},
        [125] = {125,"Ải 125 Phong Hỏa Trận","Bá nghiệp của Ngụy Võ, sẽ do trẫm kế thừa!",},
        [126] = {126,"Ải 126 Phổ Công Trận","Ta tuy già, nhưng không bao giờ thừa nhận mình già!",},
        [127] = {127,"Ải 127 Bộc Viêm Trận","Chỉ cần ta còn thì ngươi đừng hòng bước qua biên cảnh nửa bước!",},
        [128] = {128,"Ải 128 Vô Địch Trận","Chỉ huy ba quân, làm sao không biết ứng biến được!",},
        [129] = {129,"Ải 129 Liên Nhân Trận","Loạn thế thanh quân trắc, huy sư phục giang sơn.",},
        [130] = {130,"Ải 130 Miễn Thương Trận","Trận hình của địch đã loạn, theo ta~",},
        [131] = {131,"Ải 131 Hoa Dung Đạo","Quan Vân Trường, năm xưa ta không bạc đãi ngươi!",},
        [132] = {132,"Ải 132 Tiên Phong Đạo Cốt","Tướng quân bại dưới tay ai vậy, ha ha ha!",},
        [133] = {133,"Ải 133 Nghiêm Phòng Cứ Thủ","Muốn đột phá trận địa của ta? Về luyện thêm 100 năm nữa đi!",},
        [134] = {134,"Ải 134 Diệu Bất Khả Ngôn","Không nói cũng hiểu nhau!",},
        [135] = {135,"Ải 135 Khiêm Khiêm Quân Tử","Người cũ không đi người mới không đến.",},
        [136] = {136,"Ải 136 Si Mị Võng Lượng","Diệt hay bị diệt là tùy ở bản thân, hừ ha ha ha.",},
        [137] = {137,"Ải 137 Tuân Lệnh Lưu Hương","Mượn tay ngươi quyết đấu với hắn!",},
        [138] = {138,"Ải 138 Cân Quắc Tu Mi","Khổng Minh tiên sinh, lần này, ngài còn bày kế qua được ta không?",},
        [139] = {139,"Ải 139 Giang Dương Đại Đạo","20 năm sau, lại là một trang hảo hán.",},
        [140] = {140,"Ải 140 Tứ Thế Tam Công"," Hào kiệt loạn thế, thật có khí khái khai thiên tịch địa.",},
        [141] = {141,"Ải 141 Hổ Lao Quan","Chưa từng thấy ai bắt nạt người như vậy, 3 người đánh 1 người!",},
        [142] = {142,"Ải 142 Trường Bản Pha","Tặc tướng đừng đi, có dám đấu với ta không?",},
        [143] = {143,"Ải 143 Tiểu Bá Vương","Phụ thân trên trời, phù hộ Giang Đông; Công Cẩn ở cạnh, trí định thiên hạ.",},
        [144] = {144,"Ải 144 Y Giả Nhân Tâm","Đừng lo, có lão phu đây",},
        [145] = {145,"Ải 145 Đồng Quan Chiến","Ai dám đấu với ta 300 lượt!",},
        [146] = {146,"Ải 146 Dạ Quan Tinh Tượng","Thời đại nhân đức này, ta sẽ liều mình bảo vệ!",},
        [147] = {147,"Ải 147 Quần Hùng Trục Lộc","Phu quân, sức khỏe quan trọng~",},
        [148] = {148,"Ải 148 Hà Bắc Bạch Mã","Thất phu, con Bạch Mã này sẽ trở thành cơn ác mộng của ngươi!",},
        [149] = {149,"Ải 149 Trạch Quân Nhi Thị","Hành quân đánh trận, phải tùy cơ ứng biến!",},
        [150] = {150,"Ải 150 Tam Quốc Anh Hùng","Cổn cổn Trường Giang đông thệ thủy, lãng hoa đào tận anh hùng.",},
    }
}

return equip_stage