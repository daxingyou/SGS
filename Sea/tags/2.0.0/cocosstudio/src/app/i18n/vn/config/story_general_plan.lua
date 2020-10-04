--story_general_plan

local story_general_plan = {
    -- key
    __key_map = {
      id = 1,    --锦囊关id_key-int 
      name = 2,    --锦囊名称-越南语-string 
      des = 3,    --帐篷事件描述-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Danh Tướng Chiến","Đổng Trác, tự Trọng Dĩnh, là một tướng quân phiệt và quyền thần nhà Đông Hán. Sau này trúng mỹ nhân kế của Vương Doãn và bị Lữ Bố trảm sát",},
        [2] = {2,"Danh Tướng Chiến","Tôn Sách, một trong những người lập ra nhà Đông Ngô đầu tiên. Sau khi Viên Thuật xưng đế đã trở mặt với Viên Thuật và thống nhất Giang Đông.",},
        [3] = {3,"Danh Tướng Chiến","Triệu Vân, tự là Tử Long, người vùng Thường Sơn, một trong Ngũ Hổ Thượng Tướng của Thục Hán",},
        [4] = {4,"Danh Tướng Chiến","Trương Phi là danh tướng nhà Thục Hán, cùng Lưu Bị và Quan Vũ kết bái huynh đệ ở vườn đào, là người dũng mãnh phi phàm, tính nóng như lửa",},
        [5] = {5,"Danh Tướng Chiến","Chu Du, tên tự Công Cẩn, đương thời gọi Chu Lang, là danh tướng và khai quốc công thần của nước Đông Ngô.",},
        [6] = {6,"Danh Tướng Chiến","Gia Cát Lượng, tự Khổng Minh, hiệu Ngọa Long tiên sinh, quân sự kiệt xuất của nước Thục",},
        [7] = {7,"Danh Tướng Chiến","Tào Tháo, tự Mạnh Đức, tên lúc nhỏ là A Man, là nhà chính trị, quân sự kiệt xuất cuối thời Đông Hán trong lịch sử Trung Quốc.",},
        [8] = {8,"Danh Tướng Chiến","Tả Từ, tự Nguyên Phóng, đạo sĩ nổi tiếng thời Đông Hán, tinh thông kỳ môn độn giáp, có thể sai khiến quỷ thần, sau lên núi luyện linh đơn",},
        [9] = {9,"Danh Tướng Chiến","Lữ Bố tự là Phụng Tiên, mãnh tướng số một tam quốc, cưỡi Xích Thố, tay cầm Phương Thiên Kích, được ca tụng là chiến thần!",},
        [10] = {10,"Danh Tướng Chiến","Điêu Thuyền, một trong tứ đại mỹ nhân, nghĩa nữ của Vương Doãn, để đền ơn nghĩa phụ đã hiến thân hoàn thành liên hoàn kế diệt Đổng Trác",},
        [11] = {11,"Danh Tướng Chiến","Trương Liêu, tự là Văn Viễn, một trong Ngũ Hổ Tướng của Tào Ngụy, từng tham gia nhiều trận đánh lớn và nổi tiếng nhất qua trận Hợp Phì",},
        [12] = {12,"Danh Tướng Chiến","Tôn Kiên, tên tự là Văn Đài, là người đặt nền móng xây dựng nước Đông Ngô. Từng tham gia chiến dịch thảo phạt Hoàng Cân và Đổng Trác.",},
        [13] = {13,"Danh Tướng Chiến","Đại Kiều là vợ của Tôn Sách, một trong những mỹ nhân thời kỳ Tam Quốc. Cùng em gái Tiểu Kiều được thiên hạ ca tụng là Giang Đông Nhị Kiều.",},
        [14] = {14,"Danh Tướng Chiến","Điển Vi, võ tướng của Tào Tháo, sức mạnh vô địch, sở trường sử dụng song kích, lúc Trương Tú làm loạn đã hy sinh thân mình để cứu Tào Tháo",},
        [15] = {15,"Danh Tướng Chiến","Tiểu Kiều, vợ Chu Du, mỹ nhân nổi tiếng Tam Quốc, cùng chị gái Đại Kiều được thiên hạ ca tụng là Giang Đông Nhị Kiều.",},
        [16] = {16,"Danh Tướng Chiến","Nhạc Tiến, tự Văn Khiêm, là một võ tướng dưới quyền Tào Tháo cuối thời Đông Hán trong lịch sử Trung Quốc",},
        [17] = {17,"Danh Tướng Chiến","Lữ Linh Thư, tương truyền là con gái Lữ Bố và Điêu Thuyền",},
        [18] = {18,"Danh Tướng Chiến","Cam Ninh, tự là Hưng Bá, mãnh tướng Giang Đông, theo Chu Du lập công lớn trong trận Xích Bích, đánh bại quân của Tào Tháo",},
        [19] = {19,"Danh Tướng Chiến","Tào Nhân, biểu tự Tử Hiếu, là danh tướng của Tào Ngụy, một trong 8 Hổ Kỵ, sở trường phòng thủ, theo Tào Tháo chinh chiến nhiều năm",},
        [20] = {20,"Danh Tướng Chiến","Chu Thái tự là Ấu Bình, võ tướng quan trọng của Đông Ngô, công thần khai quốc nước Đông Ngô, nhiều lần bảo vệ Tôn Quyền",},
        [21] = {21,"Danh Tướng Chiến","Chân Cơ, mỹ nữ nổi tiếng thời Tam Quốc, phu nhân của Nguỵ Văn Đế Tào Phi, nhưng tương truyền từng yêu Tào Thực",},
        [22] = {22,"Danh Tướng Chiến","Nguyệt Anh, con gái của danh sĩ Hoàng Thừa Ngạn, vợ của Gia Cát Lượng. Tương truyền bà có trí tuệ hơn người, cùng chồng phát minh ra Mộc Ngưu Lưu Mã",},
        [23] = {23,"Danh Tướng Chiến","Quan Bình, con của Quan Vũ, tướng Thục Hán, theo Quan Vũ chinh chiến, tài nghệ hơn người, lập nhiều chiến công.",},
        [24] = {24,"Danh Tướng Chiến","Hàn Đương tự Nghĩa Công, giỏi cung tiễn, kỵ thuật. Làm quan 3 đời cho Tôn Kiên, Tôn Sách, Tôn Quyền, có công lớn trong bá nghiệp Giang Đông.",},
        [25] = {25,"Danh Tướng Chiến","Lữ Mông, tên tự là Tử Minh, được xưng tụng là Lã Hổ Uy, là danh tướng cuối thời Đông Há, chiến tích nổi tiếng nhất là hạ Quan Vũ, lấy Kinh Châu",},
        [26] = {26,"Danh Tướng Chiến","Lục Tốn, biểu tự Bá Ngôn, từng giữ chức Đại Đô Đốc Đông Ngô, nổi tiếng sau trận Di Lăng tiêu diệt vạn đại quân Thục của Lưu Bị",},
        [27] = {27,"Danh Tướng Chiến","Tư Mã Ý, tự Trọng Đạt. Là người thông minh, uyên bác. Mưu sĩ, chính trị gia Ngụy quốc. Là người đặt nền móng đầu tiên cho triều đại Tây Tấn.",},
        [28] = {28,"Danh Tướng Chiến","Quan Vũ, tự Vân Trường. Người đứng đầu Ngũ Hổ Tướng. Là vị tướng anh dũng và rất mực trung thành.",},
        [29] = {29,"Danh Tướng Chiến","Hạ Hầu Đôn, tự Nguyên Nhượng, danh tướng Tào Ngụy. Là một vị tướng thanh liêm, hết lòng vì binh sĩ của mình.",},
        [30] = {30,"Danh Tướng Chiến","Tôn Kiên, tự Vân Đài, hậu duệ của Tôn Vũ, tướng cuối đời Đông Hán. Là người cương nghị, dung mạo bất phàm, dũng tướng của Giang Đông.",},
        [31] = {31,"Danh Tướng Chiến","Tào Phi, con thứ của Tào Tháo. Là chính trị gia, nhà văn nổi tiếng. Từ nhỏ văn võ song toàn, tinh thông học thuyết Bách Gia.",},
        [32] = {32,"Danh Tướng Chiến","Từ Thứ, vốn là mưu sĩ dưới trướng Lưu Bị. Sau theo Tào Tháo. Là người nổi tiếng với điển tích thân ở Tào Ngụy nhưng tâm ở Thục Hán.",},
        [33] = {33,"Danh Tướng Chiến","Tôn Quyền, tự Trọng Mưu, con trai của Tôn Kiên. Người đánh bại Tào Tháo trong trận Xích Bích",},
        [34] = {34,"Danh Tướng Chiến","Giả Hủ, tự Văn Hòa, người Lương Châu, nguyên là tướng của Đổng Trác, sau trở thành mưu sĩ quan trọng của Tào Ngụy.",},
        [35] = {35,"Danh Tướng Chiến","Quách Gia, tự Phụng Hiếu, là mưu sĩ trọng yếu của Tào Tháo, đáng tiếc ông mất sớm khiến Tào Tháo vô cùng thương tiếc.",},
        [36] = {36,"Danh Tướng Chiến","Bàng Thống, tự Sĩ Nguyên, hiệu Phượng Sồ, mưu sĩ quan trọng của Lưu Bị, tài trí sánh ngang với Gia Cát Lượng",},
        [37] = {37,"Danh Tướng Chiến","Con gái Tôn Kiên và là em gái của Tôn Sách và Tôn Quyền, sau lấy Lưu Bị làm phu quân",},
        [38] = {38,"Danh Tướng Chiến","Trương Giác là thủ lĩnh cuộc khởi nghĩa Khăn Vàng, hay còn gọi là quân Khăn Vàng vào cuối thời kỳ nhà Đông Hán.",},
        [39] = {39,"Danh Tướng Chiến","Trương Hợp, tự Tuấn Nghệ, một trong Ngũ Hổ Tướng của Tào Ngụy. Từng theo Viên Thiệu, trong Quan Độ Chiến hàng Tào Tháo",},
        [40] = {40,"Danh Tướng Chiến","Mạnh Hoạch, thủ lĩnh của các bộ lạc ở phía nam đất Thục, dũng mãnh kiên cường.",},
    }
}

return story_general_plan