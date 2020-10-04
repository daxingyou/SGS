--play_horse_hero

local play_horse_hero = {
    -- key
    __key_map = {
      id = 1,    --序号_key-int 
      text_1 = 2,    --文本1-越南语-string 
      text_2 = 3,    --文本2-越南语-string 
      text_3 = 4,    --文本3-越南语-string 
      text_4 = 5,    --文本4-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Luyện võ có thể khống chế hổ báo, luyện trí mới có thể đoạt thiên hạ! Chân dài thì có thể thắng trong cuộc chạy đua.","Đêm qua ta xem thiên tượng bói một quẻ, hôm nay ta nhất định sẽ giành được hạng 1.","Nhà Tư Mã sao có thể thua chứ!","Ai dám chạy trước ta, cây trượng của ta sẽ cho hắn biết tay.",},
        [2] = {2,"Đừng chê ta mập, ta lăn nhanh lắm!","Chưa bao giờ thấy người mập chạy nhanh à? Lát nữa cho ngươi mở mang tầm mắt.","Ta cầm chùy sắt còn có thể chạy thắng các ngươi, có tin không?","Ta môt tay cũng có thể kéo trâu đi trăm bước, chạy đua chẳng là gì với ta.",},
        [3] = {3,"Hãy xem người đàn ông đẹp nhất, bước đi linh động nhất.","Ta có Vô Địch Thuẫn, đừng hòng kéo áo ta.","Ta rất giỏi tận dụng địa hình, ta đã nắm rõ hết địa hình đường đua.","Vì Cuộc thi này mà ta mua rất nhiều trang phục mới.",},
        [4] = {4,"Ta là con gái, mọi người khi thi đấu hãy nương tay nhé!","Kẻ nào dám chạy nhanh hơn ta, hãy xem dây thừng của ta.","Ta chân dài thế này, ngươi nghĩ ta chạy chậm sao?","Là đàn ông thì hãy để ta chạy trước hai trượng.",},
        [5] = {5,"Đừng chê ta nhỏ nhắn, ta chạy giỏi lắm.","Trong Ngũ Hổ Tướng, ta chạy nhanh nhất.","Ta từ nhỏ đã bon chen trong chợ, sức chân rất mạnh.","Nói cho ngươi biết, Vu Cấm chưa khi nào chạy thắng ta.",},
        [6] = {6,"Ai giỏi hơn ai, cứ so tài là biết ngay.","Chạy bộ có lợi cho sức khỏe.","Cha rất thương yêu ta, ta sao có thể khiến cha mất mặt.","Hôm qua ta và ca ca Tào Phi tập chạy, ta không thua gì ca ca.",},
        [7] = {7,"Bảo Tư Mã Ý ra đây ngay, hôm nay ta phải giành được hạng 1!","Thắng cuộc thi này, để Tư Mã Ý mở mang tầm mắt!","Bách phu nhân tuy còn trẻ nhưng không thể sánh với ta!","Không bao giờ hối hận.",},
        [8] = {8,"Nếu chiến thắng mai này hãy dùng danh hiệu Tật Phong Hành Giả.","Đừng nghe Lạc Tiến, trong Ngũ Hổ Tướng, ta là chạy nhanh nhất.","Đợi lát nữa sẽ cho các ngươi thấy tốc độ đáng sợ của ta.","Nhạc Tiến dám nói ta chạy thua hắn, ta sẽ cho hắn biết tay.",},
        [9] = {9,"Ta là thích khách, tốc độ của ta là nhanh nhất!","Giành được hạng 1, lấy được tiền thưởng, ta sẽ đi mua trang bị mới!","Lâu quá không ra tay, đao của ta sắp rỉ sét rồi!","Chạy đua xong, ta sẽ xin đi thích sát!",},
        [10] = {10,"Mạnh Đức có đển xem ta thi đấu không?","Thiếp đây không khỏe, không giỏi chạy đua.","Biết tự tìm niềm vui, mới biết hương vị cuộc đời.","Thi đấu có gì vui chứ, thi xong nhớ đến tìm ta nhé.",},
        [11] = {11,"Luận về tốc độ, ta là nhanh nhất!","Mọi người hãy nhớ, ta thường được mọi người tôn là Thường Thắng Tướng Quân.","Ta ôm thêm một người, cũng có thể chạy nhanh hơn các ngươi.","Ta sẽ giành hạng 1!",},
        [12] = {12,"Vốn là thủ lĩnh Ngũ Hổ Thượng Tướng, Võ Thánh, không giành được hạng 1 thì thật là mất mặt.","Trước vì phạm tội chạy trốn đến U Châu Trác Quận, chính là vì chạy nhanh.","Ôn Tửu Trảm Hoa Hùng chẳng là gì, ta sẽ giành hạng 1.","Ta chính là người cưỡi ngựa Xích Thố, ngươi nghĩ ta sẽ chạy chậm sao?",},
        [13] = {13,"Ta thét lên một tiếng là có thể hạ gục các ngươi.","Đợi ta uống xong một vò rượu mạnh sẽ chạy đua với các ngươi.","Ai nói đồ phu không thể đoạt hạng 1, hôm nay sẽ cho các ngươi mở mang tầm mắt.","Trương Dực Đức ta hôm nay quyết giành hạng 1!",},
        [14] = {14,"Từ nhỏ đã là nam tử hán, cưỡi tuấn mã bôn tẩu khắp nơi.","Hoàng Trung đến rồi sao, mau dùng kỹ năng Hợp Thể bắn ta ra ngoài!","Nói thật, trong Ngũ Hổ Thượng Tướng, ta là chạy nhanh nhất.","Ta họ Mã, ngươi phải biết là ta chắc chắn chạy nhanh như ngựa.",},
        [15] = {15,"Trong tộc, ta là chạy nhanh nhất.","Kẻ nào dám coi thường bọn ta? Giỏi thì ra đây so tài!","Đừng nhắc đến Thất Cầm Mạnh Hoạch trước mặt ta, bảo Khổng Minh ra đây thi chạy với ta.","Luận mưu lược có lẽ ta không lợi hại bằng mưu sĩ, nhưng chạy đua thì chưa chắc!",},
        [16] = {16,"Đuôi của ta quyến rũ chứ?","Tuy là con gái, nhưng ta chạy không thua kém gì các ngươi.","Từ nhỏ ta đã săn bắt trong rừng, thân thủ linh hoạt vô cùng.","Bảo Khổng Minh ra đây, ta phải báo thù cho phu quân.",},
        [17] = {17,"Cứ đánh nhau thật vô vị, chạy đua thú vị hơn.","Ta quăng Gấu Trúc qua trước, có coi là thắng không?","Nhân đức trị thiên hạ, thi đấu quan trọng là tham gia cho vui.","Mau bắt đầu đi nào, sau khi kết thúc ta còn phải ôm Gấu Trúc nữa.",},
        [18] = {18,"Người đến xem thi đấu thật là nhiều, mắc cỡ quá!","Chúa công, Tinh Thái sẽ giành hạng 1 cho người.","Nhiều người thi đấu thế này, ta hơi sợ.","Nhiều người vậy, coi chừng cảm nắng!",},
        [19] = {19,"Quan Tam Tiểu Thư ta không thua gì ai.","Quan Ngân Bình ta xinh đẹp, thông minh, võ nghệ cao cường, lần này sẽ giành hạng 1 cho cha.","Rồi sẽ có một ngày, ta sẽ vượt mặt cha, bắt đầu từ việc giành hạng 1 trong ngày hôm nay nào!","Hôm nay ta sẽ giành hạng 1 về cho cha!",},
        [20] = {20,"Ta từ nhỏ đã tinh thông kỵ xạ, chạy nhanh cũng không thể làm khó được ta!","Chúa công, ta sẽ giành hạng 1 về cho người.","Vẫn chưa bắt đầu sao?","Ta sẽ giành hạng 1 để chứng tỏ bản thân!",},
        [21] = {21,"Ta là Giang Đông Tiểu Bá Vương, Tôn Bá Phù!","Con cháu Giang Đông nào biết sợ ai!","Tôn Bá Phù ta hôm nay nhất định phải đoạt hạng 1!","Con cháu Giang Đông, hãy xem đây!",},
        [22] = {22,"Nắng vậy, ta đen mất! Cũng may là có Liên Hoa Tản bảo vệ ta!","Bá Phù đâu rồi? Sao nói là đến cổ vũ cho ta?","Thắng cuộc thi này sẽ thua cả cuộc đời, các ngươi dám thắng ta không?","Đợi tí nữa hãy xem giúp ta, khi chạy ta có đẹp không!",},
        [23] = {23,"Hừ, đừng xem thường con gái!","Công Cẩ nói, thắng thua không quan trọng, miễn sao vui là được!","Hi hi, Tinh Hoa Phiến chắc chắn có thể giúp ta giành được quán quân","Thắng thua không quan trọng, vui là được.",},
        [24] = {24,"Đây chính là địa bàn của Cam Ninh ta!","Địa bàn của ta, ta chắc chắn sẽ giành hạng 1!","Với ta, các ngươi chẳng là gì cả!","Cam Hưng Bá ta quyết giành lấy hạng 1!",},
        [25] = {25,"Hiên ngang khí thế, không kém mày râu!","Chinh chiến sa trường còn chẳng sợ gì, sao phải sợ đường đua nhỏ bé này.","Dù ca ca có ra thi đấu, ta cũng quyết không nhường!","Nếu ta chạy nhanh quá, liệu Huyền Đức có đuổi kịp ta không?",},
        [26] = {26,"Có thể tấu nhạc nhỏ tiếng hơn không, lỗ tai ta sắp nổ luôn rồi!","Cho ta một áng mây, ta sẽ chạy mười vạn tam ngàn dặm cho ngươi xem.","Ai nói ta tuổi trẻ ngông cuồng, ta sẽ giành hạng 1 cho hắn xem!","Ha ha, hôm nay ta quyết giành hạng 1!",},
        [27] = {27,"Lòng thiếp nhớ chàng, tựa ánh trăng thâu!","Tiểu muội muội ca hát chàng gảy đàn, cuộc đời hãy trân trọng thanh xuân.","Quân tử lạc tư, vạn bang chi bình.","Tiểu muội muội là chỉ, chàng là kim, kim chỉ bên nhau mãi không rời.",},
        [28] = {28,"Lại bắt cả người mù như ta phải chạy sao?","Lỡ chạy vào đường đua của người khác thì sao?","Kẻ nào chơi ta, mau nói ra?","Các ngươi xem giúp ta, đây có phải là cuộc thi dành cho người khuyết tật không?",},
        [29] = {29,"Cầm lồng đèn chạy, đẹp không?","Trọng Mưu dám nói ta như con lừa, các ngươi thấy sao?","Tộc Gia Cát ta chỉ toàn nhân tài!","Không muốn giành hạng 1 thì tham gia thi đấu làm gì.",},
        [30] = {30,"Điêu Thuyền đâu rồi? Xích Thố đâu?","Chiến thần Lữ Bố ta dù không cưỡi ngựa, cũng có thể thắng các ngươi.","Các ngươi dù có cưỡi ngựa cũng không thể thắng được ta!","Cả thiên hạ này là của Lữ Bố ta, huống chi đường đua nhỏ bé này!",},
        [31] = {31,"Thiếp sẽ làm hết sức mình, để không phụ lòng Lữ Bố.","Ai chào mừng ta ở vạch đích?","Thiếp rất nhớ Phụng Tiên.","Dù thắng hay thua, Phụng Tiên vẫn sẽ yêu ta!",},
        [32] = {32,"Ha ha, chọn bổn thái sư là lựa chọn đúng đắn đấy.","Đợi giành được hạng 1, bổn thái sư sẽ mời ngươi uống rượu!","Ai dám chạy trước ta, ta sẽ diệt người đó!","Người Lương Châu chưa từng biết thua là gì!",},
        [33] = {33,"Lát nữa ai dám đến gần ta, ta sẽ hạ độc thủ với hắn!","Các ngươi đến thi đấu, còn Vu Cát ta đến dạo chơi!","Tiểu Khôi Lỗi đầy độc dịch, đến gần bọn ta coi chừng mất mạng!","Đạo pháp huyền cơ, thi đấu nhẹ nhàng.",},
        [34] = {34,"Ai dám giành ngọc tỷ của ta? Ai dám thắng ta?","Ta là đích tử của Viên gia, hôm nay ta chắc chắn sẽ đạt hạng 1!","Ai giành hạng 1 sẽ được phong tước thưởng đất!","Thiên Tàn Thoái của ta chạy rất nhanh!",},
        [35] = {35,"Hôm nay liệu có giành được hạng 1 không?","Thiếp có thể gảy đàn, làm thơ, người muốn thiếp ra trận thật sao?","Nghe tiến nhạc quen thuộc này, ta lại nhớ lúc còn nhỏ.","Đời người ngắn ngủi, hãy vui vẻ tham gia thi đấu nào.",},
        [36] = {36,"Chỉ cần Phụng Tiên không có ở đây, ta chắc chắn sẽ giành được hạng 1!","Nếu hôm nay có thể chạy thắng, thì bá nghiệp mới có hi vọng!","Ta có thể chạy thắng Lữ Bố, ngươi tin không?","Ai giành được hạng 1, ta sẽ phò trợ người đó!",},
        [37] = {37,"Ta cưỡi Trúc Mã, ai chạy nhanh hơn ta!","Đến đây nào, tặng ngươi trái lê, ngươi nhường ta nhé?","Sau Danh Môn, chắc chắn đoạt hạng 1!","A Đẩu đâu rồi? Đợi ta chạy xong, ta sẽ chơi với Gấu Trúc của hắn.",},
        [38] = {38,"Cha ta là chiến thần Lữ Bố! Vì vậy ta không thể thua được!","Ta chỉ muốn ra trận diệt địch! Tham gia thi đấu đúng là vô vị!","Cha đã hứa, chạy thắng ta sẽ không phải lấy con trai của Viên Thuật!","Đợi ta giành được hạng 1, ta sẽ tặng giải thưởng này cho cha!",},
        [39] = {39,"Có muốn nếm thử mùi vị tuyệt tử tuyệt tôn?","Hừ, ngươi không giành được chiến thắng thì biết tay ta!","Hà Tiến muốn diệt ta, ta phải chạy nhanh lên!","Đổng Trác sắp vào kinh, mọi người mau chạy!",},
        [40] = {40,"Đợi lát nữa ai dám chạy trước ta, chùy của ta sẽ không tha cho người đó!","Khụ khụ, các ngươi chắc chắn sẽ không thể thắng ta!","Dáng vẻ như ta đây, vừa nhìn đã biết sẽ đạt hạng 1!","Ta chắc chắn sẽ đoạt hạng 1!",},
    }
}

return play_horse_hero