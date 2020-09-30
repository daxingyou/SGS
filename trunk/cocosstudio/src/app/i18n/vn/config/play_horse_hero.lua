--play_horse_hero

local play_horse_hero = {
    -- key
    __key_map = {
      id = 1,    --序号-int 
      text_3 = 2,    --文本3-string 
      text_4 = 3,    --文本4-string 
      text_1 = 4,    --文本1-string 
      text_2 = 5,    --文本2-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Nhà Tư Mã sao có thể thua chứ!","Ai dám chạy trước ta, cây trượng của ta sẽ cho hắn biết tay.","Luyện võ có thể khống chế hổ báo, luyện trí mới có thể đoạt thiên hạ! Chân dài thì có thể thắng trong cuộc chạy đua.","Đêm qua ta xem thiên tượng bói một quẻ, hôm nay ta nhất định sẽ giành được hạng 1.",},
        [2] = {2,"Ta cầm chùy sắt còn có thể chạy thắng các ngươi, có tin không?","Ta môt tay cũng có thể kéo trâu đi trăm bước, chạy đua chẳng là gì với ta.","Đừng chê ta mập, ta lăn nhanh lắm!","Chưa bao giờ thấy người mập chạy nhanh à? Lát nữa cho ngươi mở mang tầm mắt.",},
        [3] = {3,"Ta rất giỏi tận dụng địa hình, ta đã nắm rõ hết địa hình đường đua.","Vì Cuộc thi này mà ta mua rất nhiều trang phục mới.","Hãy xem người đàn ông đẹp nhất, bước đi linh động nhất.","Ta có Vô Địch Thuẫn, đừng hòng kéo áo ta.",},
        [4] = {4,"Ta chân dài thế này, ngươi nghĩ ta chạy chậm sao?","Là đàn ông thì hãy để ta chạy trước hai trượng.","Ta là con gái, mọi người khi thi đấu hãy nương tay nhé!","Kẻ nào dám chạy nhanh hơn ta, hãy xem dây thừng của ta.",},
        [5] = {5,"Ta từ nhỏ đã bon chen trong chợ, sức chân rất mạnh.","Nói cho ngươi biết, Vu Cấm chưa khi nào chạy thắng ta.","Đừng chê ta nhỏ nhắn, ta chạy giỏi lắm.","Trong Ngũ Hổ Tướng, ta chạy nhanh nhất.",},
        [6] = {6,"Cha rất thương yêu ta, ta sao có thể khiến cha mất mặt.","Hôm qua ta và ca ca Tào Phi tập chạy, ta không thua gì ca ca.","Ai giỏi hơn ai, cứ so tài là biết ngay.","Chạy bộ có lợi cho sức khỏe.",},
        [7] = {7,"Bách phu nhân tuy còn trẻ nhưng không thể sánh với ta!","Không bao giờ hối hận.","Bảo Tư Mã Ý ra đây ngay, hôm nay ta phải giành được hạng 1!","Thắng cuộc thi này, để Tư Mã Ý mở mang tầm mắt!",},
        [8] = {8,"Đợi lát nữa sẽ cho các ngươi thấy tốc độ đáng sợ của ta.","Nhạc Tiến dám nói ta chạy thua hắn, ta sẽ cho hắn biết tay.","Nếu chiến thắng mai này hãy dùng danh hiệu Tật Phong Hành Giả.","Đừng nghe Lạc Tiến, trong Ngũ Hổ Tướng, ta là chạy nhanh nhất.",},
        [9] = {9,"Lâu quá không ra tay, đao của ta sắp rỉ sét rồi!","Chạy đua xong, ta sẽ xin đi thích sát!","Ta là thích khách, tốc độ của ta là nhanh nhất!","Giành được hạng 1, lấy được tiền thưởng, ta sẽ đi mua trang bị mới!",},
        [10] = {10,"Biết tự tìm niềm vui, mới biết hương vị cuộc đời.","Thi đấu có gì vui chứ, thi xong nhớ đến tìm ta nhé.","Mạnh Đức có đển xem ta thi đấu không?","Thiếp đây không khỏe, không giỏi chạy đua.",},
        [11] = {11,"Ta ôm thêm một người, cũng có thể chạy nhanh hơn các ngươi.","Ta sẽ giành hạng 1!","Luận về tốc độ, ta là nhanh nhất!","Mọi người hãy nhớ, ta thường được mọi người tôn là Thường Thắng Tướng Quân.",},
        [12] = {12,"Ôn Tửu Trảm Hoa Hùng chẳng là gì, ta sẽ giành hạng 1.","Ta chính là người cưỡi ngựa Xích Thố, ngươi nghĩ ta sẽ chạy chậm sao?","Vốn là thủ lĩnh Ngũ Hổ Thượng Tướng, Võ Thánh, không giành được hạng 1 thì thật là mất mặt.","Trước vì phạm tội chạy trốn đến U Châu Trác Quận, chính là vì chạy nhanh.",},
        [13] = {13,"Ai nói đồ phu không thể đoạt hạng 1, hôm nay sẽ cho các ngươi mở mang tầm mắt.","Trương Dực Đức ta hôm nay quyết giành hạng 1!","Ta thét lên một tiếng là có thể hạ gục các ngươi.","Đợi ta uống xong một vò rượu mạnh sẽ chạy đua với các ngươi.",},
        [14] = {14,"Nói thật, trong Ngũ Hổ Thượng Tướng, ta là chạy nhanh nhất.","Ta họ Mã, ngươi phải biết là ta chắc chắn chạy nhanh như ngựa.","Từ nhỏ đã là nam tử hán, cưỡi tuấn mã bôn tẩu khắp nơi.","Hoàng Trung đến rồi sao, mau dùng kỹ năng Hợp Thể bắn ta ra ngoài!",},
        [15] = {15,"Đừng nhắc đến Thất Cầm Mạnh Hoạch trước mặt ta, bảo Khổng Minh ra đây thi chạy với ta.","Luận mưu lược có lẽ ta không lợi hại bằng mưu sĩ, nhưng chạy đua thì chưa chắc!","Trong tộc, ta là chạy nhanh nhất.","Kẻ nào dám coi thường bọn ta? Giỏi thì ra đây so tài!",},
        [16] = {16,"Từ nhỏ ta đã săn bắt trong rừng, thân thủ linh hoạt vô cùng.","Bảo Khổng Minh ra đây, ta phải báo thù cho phu quân.","Đuôi của ta quyến rũ chứ?","Tuy là con gái, nhưng ta chạy không thua kém gì các ngươi.",},
        [17] = {17,"Nhân đức trị thiên hạ, thi đấu quan trọng là tham gia cho vui.","Mau bắt đầu đi nào, sau khi kết thúc ta còn phải ôm Gấu Trúc nữa.","Cứ đánh nhau thật vô vị, chạy đua thú vị hơn.","Ta quăng Gấu Trúc qua trước, có coi là thắng không?",},
        [18] = {18,"Nhiều người thi đấu thế này, ta hơi sợ.","Nhiều người vậy, coi chừng cảm nắng!","Người đến xem thi đấu thật là nhiều, mắc cỡ quá!","Chúa công, Tinh Thái sẽ giành hạng 1 cho người.",},
        [19] = {19,"Rồi sẽ có một ngày, ta sẽ vượt mặt cha, bắt đầu từ việc giành hạng 1 trong ngày hôm nay nào!","Hôm nay ta sẽ giành hạng 1 về cho cha!","Quan Tam Tiểu Thư ta không thua gì ai.","Quan Ngân Bình ta xinh đẹp, thông minh, võ nghệ cao cường, lần này sẽ giành hạng 1 cho cha.",},
        [20] = {20,"Vẫn chưa bắt đầu sao?","Ta sẽ giành hạng 1 để chứng tỏ bản thân!","Ta từ nhỏ đã tinh thông kỵ xạ, chạy nhanh cũng không thể làm khó được ta!","Chúa công, ta sẽ giành hạng 1 về cho người.",},
        [21] = {21,"Tôn Bá Phù ta hôm nay nhất định phải đoạt hạng 1!","Con cháu Giang Đông, hãy xem đây!","Ta là Giang Đông Tiểu Bá Vương, Tôn Bá Phù!","Con cháu Giang Đông nào biết sợ ai!",},
        [22] = {22,"Thắng cuộc thi này sẽ thua cả cuộc đời, các ngươi dám thắng ta không?","Đợi tí nữa hãy xem giúp ta, khi chạy ta có đẹp không!","Nắng vậy, ta đen mất! Cũng may là có Liên Hoa Tản bảo vệ ta!","Bá Phù đâu rồi? Sao nói là đến cổ vũ cho ta?",},
        [23] = {23,"Hi hi, Tinh Hoa Phiến chắc chắn có thể giúp ta giành được quán quân","Thắng thua không quan trọng, vui là được.","Hừ, đừng xem thường con gái!","Công Cẩ nói, thắng thua không quan trọng, miễn sao vui là được!",},
        [24] = {24,"Với ta, các ngươi chẳng là gì cả!","Cam Hưng Bá ta quyết giành lấy hạng 1!","Đây chính là địa bàn của Cam Ninh ta!","Địa bàn của ta, ta chắc chắn sẽ giành hạng 1!",},
        [25] = {25,"Dù ca ca có ra thi đấu, ta cũng quyết không nhường!","Nếu ta chạy nhanh quá, liệu Huyền Đức có đuổi kịp ta không?","Hiên ngang khí thế, không kém mày râu!","Chinh chiến sa trường còn chẳng sợ gì, sao phải sợ đường đua nhỏ bé này.",},
        [26] = {26,"Ai nói ta tuổi trẻ ngông cuồng, ta sẽ giành hạng 1 cho hắn xem!","Ha ha, hôm nay ta quyết giành hạng 1!","Có thể tấu nhạc nhỏ tiếng hơn không, lỗ tai ta sắp nổ luôn rồi!","Cho ta một áng mây, ta sẽ chạy mười vạn tam ngàn dặm cho ngươi xem.",},
        [27] = {27,"Quân tử lạc tư, vạn bang chi bình.","Tiểu muội muội là chỉ, chàng là kim, kim chỉ bên nhau mãi không rời.","Lòng thiếp nhớ chàng, tựa ánh trăng thâu!","Tiểu muội muội ca hát chàng gảy đàn, cuộc đời hãy trân trọng thanh xuân.",},
        [28] = {28,"Kẻ nào chơi ta, mau nói ra?","Các ngươi xem giúp ta, đây có phải là cuộc thi dành cho người khuyết tật không?","Lại bắt cả người mù như ta phải chạy sao?","Lỡ chạy vào đường đua của người khác thì sao?",},
        [29] = {29,"Tộc Gia Cát ta chỉ toàn nhân tài!","Không muốn giành hạng 1 thì tham gia thi đấu làm gì.","Cầm lồng đèn chạy, đẹp không?","Trọng Mưu dám nói ta như con lừa, các ngươi thấy sao?",},
        [30] = {30,"Các ngươi dù có cưỡi ngựa cũng không thể thắng được ta!","Cả thiên hạ này là của Lữ Bố ta, huống chi đường đua nhỏ bé này!","Điêu Thuyền đâu rồi? Xích Thố đâu?","Chiến thần Lữ Bố ta dù không cưỡi ngựa, cũng có thể thắng các ngươi.",},
        [31] = {31,"Thiếp rất nhớ Phụng Tiên.","Dù thắng hay thua, Phụng Tiên vẫn sẽ yêu ta!","Thiếp sẽ làm hết sức mình, để không phụ lòng Lữ Bố.","Ai chào mừng ta ở vạch đích?",},
        [32] = {32,"Ai dám chạy trước ta, ta sẽ diệt người đó!","Người Lương Châu chưa từng biết thua là gì!","Ha ha, chọn bổn thái sư là lựa chọn đúng đắn đấy.","Đợi giành được hạng 1, bổn thái sư sẽ mời ngươi uống rượu!",},
        [33] = {33,"Tiểu Khôi Lỗi đầy độc dịch, đến gần bọn ta coi chừng mất mạng!","Đạo pháp huyền cơ, thi đấu nhẹ nhàng.","Lát nữa ai dám đến gần ta, ta sẽ hạ độc thủ với hắn!","Các ngươi đến thi đấu, còn Vu Cát ta đến dạo chơi!",},
        [34] = {34,"Ai giành hạng 1 sẽ được phong tước thưởng đất!","Thiên Tàn Thoái của ta chạy rất nhanh!","Ai dám giành ngọc tỷ của ta? Ai dám thắng ta?","Ta là đích tử của Viên gia, hôm nay ta chắc chắn sẽ đạt hạng 1!",},
        [35] = {35,"Nghe tiến nhạc quen thuộc này, ta lại nhớ lúc còn nhỏ.","Đời người ngắn ngủi, hãy vui vẻ tham gia thi đấu nào.","Hôm nay liệu có giành được hạng 1 không?","Thiếp có thể gảy đàn, làm thơ, người muốn thiếp ra trận thật sao?",},
        [36] = {36,"Ta có thể chạy thắng Lữ Bố, ngươi tin không?","Ai giành được hạng 1, ta sẽ phò trợ người đó!","Chỉ cần Phụng Tiên không có ở đây, ta chắc chắn sẽ giành được hạng 1!","Nếu hôm nay có thể chạy thắng, thì bá nghiệp mới có hi vọng!",},
        [37] = {37,"Sau Danh Môn, chắc chắn đoạt hạng 1!","A Đẩu đâu rồi? Đợi ta chạy xong, ta sẽ chơi với Gấu Trúc của hắn.","Ta cưỡi Trúc Mã, ai chạy nhanh hơn ta!","Đến đây nào, tặng ngươi trái lê, ngươi nhường ta nhé?",},
        [38] = {38,"Cha đã hứa, chạy thắng ta sẽ không phải lấy con trai của Viên Thuật!","Đợi ta giành được hạng 1, ta sẽ tặng giải thưởng này cho cha!","Cha ta là chiến thần Lữ Bố! Vì vậy ta không thể thua được!","Ta chỉ muốn ra trận diệt địch! Tham gia thi đấu đúng là vô vị!",},
        [39] = {39,"Hà Tiến muốn diệt ta, ta phải chạy nhanh lên!","Đổng Trác sắp vào kinh, mọi người mau chạy!","Có muốn nếm thử mùi vị tuyệt tử tuyệt tôn?","Hừ, ngươi không giành được chiến thắng thì biết tay ta!",},
        [40] = {40,"Dáng vẻ như ta đây, vừa nhìn đã biết sẽ đạt hạng 1!","Ta chắc chắn sẽ đoạt hạng 1!","Đợi lát nữa ai dám chạy trước ta, chùy của ta sẽ không tha cho người đó!","Khụ khụ, các ngươi chắc chắn sẽ không thể thắng ta!",},
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
        [37] = 37,
        [38] = 38,
        [39] = 39,
        [4] = 4,
        [40] = 40,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
        [9] = 9,
    }
}

return play_horse_hero