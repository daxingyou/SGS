--equipment

local equipment = {
    -- key
    __key_map = {
      id = 1,    --编号_key-int 
      name = 2,    --装备名称-string 
      description = 3,    --装备描述-string 
      is_work = 4,    --是否生效-int 
    
    },
    -- data
    _data = {
        [1] = {101,"Cổ Đĩnh Đao","Rèn bằng Tinh Thiết thượng đẳng với phương pháp cổ xưa, nặng 38 cân, thường trang bị cho quân tinh nhuệ.",1,},
        [2] = {102,"Hắc Thiết Giáp","Rèn bằng Huyền Thiết thượng đẳng trong 49 ngày, binh khí thường không thể phá.",1,},
        [3] = {103,"Tiêu Dao Cân","Làm bằng vải thượng đẳng ngâm thuốc thanh tâm minh mục, giúp người mặc luôn tỉnh táo.",1,},
        [4] = {104,"Vân Văn Ngoa ","Làm bằng da thú thượng đẳng, thoáng khí hút mồ hôi, có thể mặc trong thời gian dài.",1,},
        [5] = {201,"Hàn Băng Kiếm","Làm bằng hàn thiết, thân kiếm lạnh giá, binh chưa đến hàn khí đã đến, ngự địch trong hơi lạnh.",1,},
        [6] = {202,"Hoàn Tỏa Khải","Làm bằng thép, ghép từ 108 mảnh, phòng thủ tốt và nhẹ.",1,},
        [7] = {203,"Lượng Ngân Khôi","Làm bằng thép, bề mặt phủ bí ngân, bảo vệ đầu, phòng ngự và tấn công đều tốt.",1,},
        [8] = {204,"Điêu Bì Ngoa ","Làm từ da chồn, đông ấm hè mát, hành quân thượng phẩm.",1,},
        [9] = {301,"Kinh Lôi Thương ","Thép tinh luyện, lúc vung ánh lên tia điện, tiếng như sấm sét.",1,},
        [10] = {302,"Ảo Nhật Giáp ","Thép tinh luyện, khiến địch nảy sinh ảo giác, tấn công loạn xạ.",1,},
        [11] = {303,"Lạc Nguyệt Quán ","Làm từ lúc trăng khuyết đến lúc trăng tròn, có sức mạnh mặt trăng.",1,},
        [12] = {304,"Ảo Ảnh Ngoa ","Làm từ dơi, linh hoạt nhẹ nhàng, khi mặc có thể đi trăm dặm một ngày",1,},
        [13] = {305,"Đoạn Hồn Phủ ","Tương truyền rìu này đã diệt hàng ngàn tên địch, khi tấn công, rìu chưa trúng hồn đã lìa, vì vậy mà có tên là Đoạn Hồn.",1,},
        [14] = {306,"Tịch Lịch Khải ","Làm từ bí ngân và lôi điện cửu thiên, thường có ánh điện chớp nhoáng.",1,},
        [15] = {307,"Liệt Diệm Khôi ","Làm từ nham thiết núi lửa và địa hỏa, thường có ánh lửa ẩn hiện.",1,},
        [16] = {308,"Tật Phong Ngoa","Làm từ lông vũ đại bàng, có sức mạnh gió lốc, khi dùng tựa như có gió lốc trợ lực.",1,},
        [17] = {401,"Kỳ Lân Cung ","Thần cung chứa sức mạnh kỳ lân, có sức mạnh ngàn cân mới dùng được.",1,},
        [18] = {402,"Giao Lân Giáp ","Làm từ da giao long, chứa sức mạnh càn khôn bát quái.",1,},
        [19] = {403,"Phượng Linh Khôi ","Đầu khôi có lông phượng, chứa sức mạnh phượng hoàng.",1,},
        [20] = {404,"Hỗn Nguyên Ngoa ","Luyện từ kim cang, vô cùng cứng cáp, chứa sức mạnh hỗn độn.",1,},
        [21] = {405,"Hàn Băng Kiếm ","Làm từ cửu thiên hàn băng, rèn nhiều năm ở nhiệt độ thấp, tương truyền là kiếm Đại Đô Đốc Chu Du thích nhất.",1,},
        [22] = {406,"Xích Vũ Giáp ","Tương truyền là giáp Tả Từ chế tạo cho người thiên mệnh, tinh luyện từ phỉ thúy, nút thắt màu đỏ bằng lông vũ chứa tiên thuật phòng thủ của Tả Từ.",1,},
        [23] = {407,"Mặc Ngọc Quán ","Vật dụng của thế gia đại tộc, chế tạo từ tơ thượng hạng và tô điểm bằng mặc ngọc, rất quý phái.",1,},
        [24] = {408,"Kim Ti Ngoa ","Làm từ gấm tinh xảo và bích ngọc, cao sang quý phái, có khả năng phòng thủ tốt.",1,},
        [25] = {409,"Quân-Thất Thương","Thuộc bộ Phá Quân, mãnh tướng dùng thương này chống được nhiều đợt tấn công của địch.",1,},
        [26] = {410,"Quân-Lang Giáp","Thuộc bộ Phá Quân, hai vai hình tham lang, có uy lực của tham lang.",1,},
        [27] = {411,"Quân-Sư Khôi","Thuộc bộ Phá Quân, làm từ bí ngân quý Tây Lương, hình dạng sư tử, uy lực vô biên.",1,},
        [28] = {412,"Quân-Thiên Ngoa","Thuộc bộ Phá Quân, bên ngoài có mảnh vẫn thiết, bên trong là da trân thú.",1,},
        [29] = {501,"Thần-Long Thương","Thuộc bộ Tứ Thần, chứa hơi thở của Thần Thú Thanh Long.",1,},
        [30] = {502,"Thần-Vũ Giáp","Thuộc bộ Tứ Thần, chứa hơi thở của Thần Thú Huyền Vũ.",1,},
        [31] = {503,"Thần-Hổ Khôi","Thuộc bộ Tứ Thần, chứa hơi thở của Thần Thú Bạch Hổ.",1,},
        [32] = {504,"Thần-Tước Ngoa","Thuộc bộ Tứ Thần, chứa hơi thở của Thần Thú Chu Tước.",1,},
        [33] = {601,"Thao Thiết Kích","Một món trong Bộ Bát Hoang, chứa linh lực ác thú Thao Thiết thượng cổ.",1,},
        [34] = {602,"Cùng Kỳ Khải","Một món trong Bộ Bát Hoang, chứa linh lực ác thú Cùng Kỳ thượng cổ.",1,},
        [35] = {603,"Đào Ngột Quán","Một món trong Bộ Bát Hoang, chứa linh lực ác thú Đào Ngột thượng cổ.",1,},
        [36] = {604,"Hỗn Độn Ngoa","Một món trong Bộ Bát Hoang, chứa linh lực ác thú Hỗn Độn thượng cổ.",1,},
    }
}

return equipment