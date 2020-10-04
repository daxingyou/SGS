--play_horse_player

local play_horse_player = {
    -- key
    __key_map = {
      rank = 1,    --名次_key-int 
      text_1 = 2,    --文本1-越南语-string 
      text_2 = 3,    --文本2-越南语-string 
      text_3 = 4,    --文本3-越南语-string 
      text_4 = 5,    --文本4-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Có sức mạnh mới bảo vệ được cái cần bảo vệ!","Nhớ đặt cược vào ta nhé!","Ai thắng? Vào bảng xếp hạng xem thử xem!","Xin lỗi, tất cả mọi người ta đều coi khinh!",},
        [2] = {2,"Thi nào, hôm nay ta chắc chắn giành hạng 1!","Xếp hạng 2 Top 10 lực chiến!","Hạng 2 cũng tốt mà!","Không phải ta muốn làm nhân vật chính mà ta chính là nhân vật chính!",},
        [3] = {3,"Hôm nay chọn ta là chính xác!","Hạng 2 có gì giỏi, ta sẽ vượt qua ngươi!","Thắng thua là chuyện thường ở huyện!","Tuy chịu thua sẽ không có nghĩa là bị diệt nhưng ta thà bị diệt chứ không chịu thua!",},
        [4] = {4,"Chọn ta, chắc chắn sẽ không hối hận!","Top 3 nổi quá, mình hạng 4 phải khiêm tốn một chút!","Ngân Khoáng Chiến không vui, đào hoài mà chẳng được gì!","Cách chơi mới khi nào ra? Đang trông chờ lắm đây!",},
        [5] = {5,"Để ta kể chuyện cười cho nghe nhé!","Mỗi ngày phải tăng một ít lực chiến!","Chim khôn chim đậu cành cao!","Khi đang ngồi và đột nhiên đứng dậy mà nghe tiếng rắc thì chứng tỏ khả năng nghe của bạn bình thường.",},
        [6] = {6,"Ta muốn được tỏa sáng!","Lực chiến hạng 6 là đủ rồi.","Nước có thể đẩy thuyền cũng có thể lật thuyền.","Trên không nghiêm, dưới tất loạn!",},
        [7] = {7,"Các ngươi là người chứ có phải robot đâu!","Ta là người tính khí thất thường, nhưng thích cười!","Sao lúc nào cũng nhớ ai đó vậy nhỉ.","Suốt thời gian thi đấu ta chỉ xem ngươi thôi.",},
        [8] = {8,"Kể chuyện cười gì mà nhạt thế!","Ta không thể thua!","Biết chơi sẽ giỏi, không giỏi không chơi!","Đột phá giới hạn sắp mở, đến lúc đó lực chiến mọi người sẽ tăng nhanh!",},
        [9] = {9,"Đại Kiều hay Điêu Thuyền đẹp?","Vì hạng 9, ngày nào ta cũng phải cố gắng!","Chat có gì vui, chat với người mình thích mới vui.","Nhất Lữ nhị Triệu tam Điển Vi, tứ Quan ngũ Mã lục Trương Phi",},
        [10] = {10,"Có thể vào Top 10 là vui rồi!","Lực chiến hạng 10 là ngon nhất!","Người ngu thích hư danh.","Mọi người chơi thế nào mà lực chiến cao vậy?",},
        [11] = {11,"Nói thua là không chạy hả? Không thử sao biết!","Cho nên... phải thắng trận này!","Cúp thế giới: Có gì hot.","Thời thế tạo anh hùng!",},
        [12] = {12,"Cứ thi đi, thua thì tính sau!","Tuyệt chiêu gây choáng giảm nộ của Ngụy Diên có đất dụng võ rồi!","Ai có thể cho ta biết phe nào ngon nhất!","Ân đền oán trả, lưu danh muôn đời!",},
        [13] = {13,"Nếu ta sửa tên thì các ngươi có nhận ra ta không?","Thời Tam Quốc có thi chạy không?","Nắng chiều bên hiên cửa!","Con người khó mà cãi mệnh trời đã định.",},
        [14] = {14,"Ta muốn thắng!","Bàng Thống bức phá rất giỏi, không ai biết sao?","Tiểu Bá Vương Tôn Sách, chạy nhanh thật!","Rượu ngon mừng gặp mặt, chuyện xưa chuyện nay mãi không ngừng.",},
        [15] = {15,"Mong có thể chiến thắng trận này!","Dùng Từ Thứ để thi chạy thật hay!","Muốn thắng hãy chọn ta!","Vỏ quýt dày có móng tay nhọn.",},
        [16] = {16,"Còn lâu mới bắt đầu, hay để ta kể chuyện cho mọi người nghe nhé!","Ta muốn thành ngôi sao!","Mắng chửi cũng là nghệ thuật!","Chỉ cần tu tâm dưỡng tính để sống an nhiên, cần gì phải mưu cầu danh lợi!",},
        [17] = {17,"Có thể phát 2 cái lì xì cùng lúc không!","Cần thêm vài Cẩm Nang Đỏ là có thể đánh bại tên đó!","Cuối cùng cũng đổi được Cẩm Nang Đỏ!","Bọn oắt con nhát gan mà bày đặt lên mặt hống hách.",},
        [18] = {18,"Con trai phải bao dung, không chấp con gái nhiều chuyện.","Để ta yên tĩnh thi chạy không được sao.","Để ta yên tĩnh chút đã.","Bạn đang làm gì vậy? Câu trả lời chính xác nhất là: Đang trò chuyện với bạn.",},
        [19] = {19,"Đã không duyên phận thì đừng đến với nhau!","Đang thi đấu, không được đùa giỡn!","Ta yêu mọi người, mọi người hãy nhường ta thắng nhé!","Người không biết trọng dụng nhân tài, không hiểu văn thơ, không nghe lời khuyên của trung thần chẳng qua chỉ là hôn quân.",},
        [20] = {20,"Ngoại trừ bản thân, không ai được phép xem thường mình!","Ta là con người, ngươi không phải người!","Yêu tinh cũng muốn thi sao?","Người không hiểu chuyện, không độ lượng với chư hầu chẳng qua cũng chỉ là hạng bất nhân bất nghĩa!",},
        [21] = {21,"Làm sao có thể chiến thắng!","Đại trượng phu không xếp sau người khác!","Chỉ có ngây thơ mới thắng được ta!","Vẫn chưa bắt đầu nữa, chán quá, hay là cùng mắng xem sao!",},
        [22] = {22,"Dù khó khăn cách mấy cũng phải vào top 10!","Chơi game là việc lớn cần làm!","Có vui không nào?","Từ trước đến nay khinh địch thì khó mà thành công.",},
        [23] = {23,"Tự tin bước về phía trước!","Muôn vàn khó khăn cũng có cách giải quyết!","Thật ra ta rất yếu đuối!","Thục quốc làm sao có thể sánh được với Ngụy quốc chứ?",},
        [24] = {24,"Chơi trận gì cũng được, không sao cả!","Đường Thục khó đi... khó đi... học thuộc chưa.","Ai dám cùng ta tranh giành nào!","Chỉ cần gặp được tri kỷ thì có hi sinh vì họ cũng cam lòng.",},
        [25] = {25,"Ta phải trở nên ngày càng cao to, mạnh mẽ!","Dạy đời ai đó chỉ cần nhớ 2 câu: 1. Lần sau trước khi làm việc gì phải suy nghĩ kỹ, 2. Bạn nghĩ nhiều quá rồi.","Bao nhiêu mới là đủ!","Ta chưa bao giờ gặp người vô sỉ như thế.",},
        [26] = {26,"Chỉ cần muốn là được!","Ta đang gom Vàng chuẩn bị mua Cẩm Nang Đỏ!","Hợp rồi tan, tan rồi hợp!","Đã hết đường lui, còn không mau tử chiến?",},
        [27] = {27,"Người muốn giảm cân hàng ngày vẫn ăn, thế sao giảm nổi?","Thấy đường gập ghềnh khó đi, hãy đếm từ 1-999, sẽ qua thôi!","Ăn gì bổ nấy, ăn gì mới bổ não?","Nếu có được Ngọa Long hoặc Phượng Sồ thì xem như có thiên hạ trong tay.",},
        [28] = {28,"Ta quyết giành được hạng 1!","Không thể tiếp tục nữa rồi!","Cảm giác ai đó đang nhìn trộm mình.","Xích Thố vượt vạn dặm, Thanh Long vượt ngũ quan.",},
        [29] = {29,"Hãy biến đau thương thành hành động!","Tiếp tục tìm kiếm!","Khóc không phải tội, tội là sao phải khóc!","Nam tử hán đại trượng phu phải nỗ lực tạo dựng sự nghiệp cho mình.",},
        [30] = {30,"Phong Hỏa Luân của Tư Mã Ý có nhanh cũng không thể vượt qua ta!","Khôn 3 năm dại 1 giờ.","Đại Kiều, Bộ Luyện Sư, Điêu Thuyền đều biết hát đó nha!","Không vào hang cọp sao bắt được cọp con!",},
        [31] = {31,"Ta có tuyệt chiêu chạy nhanh như gió!","Cho dù giàu hay nghèo thì nó cũng không xem ngươi ra gì.","Đô Đốc đẹp trai quá!","Dù có hi sinh cũng không thay lòng, quả là bậc anh hùng hảo hán!",},
        [32] = {32,"Ham vui thì sao có thể thắng!","Có tin ta đánh gãy xương bánh chè của ngươi không!","Thẻ Tiểu Kiều đầy đất, đây là vì sao?","Ước mơ của bản thân chỉ bản thân biết!",},
        [33] = {33,"Không ai chạy nhanh bằng ta trên đường đua!","Nói chuyện cười làm gì, lo bao tử trước đã!","Ta phát hiện một bí mật, Thái Sử Từ dùng chân để giương cung!","Người tính không bằng trời tính.",},
        [34] = {34,"Hạ Hầu Đôn có tuyệt chiêu phản sát thương thì thi chạy cũng không giỏi hơn ta!","Ai mà chẳng sợ mất mặt!","Hai huynh đệ Tôn Quyền, Tôn Sách một người hàng trước một người hàng sau!","Lúc Lưu Bị khó khăn nhất may là có Khổng Minh giúp đỡ!",},
        [35] = {35,"Lúc thi chạy, Tào Nhân sao đẹp trai bằng ta!","Nói bỏ rồi nhưng vẫn tiếp tục!","Lúc may mắn, Lữ Mông có thể làm choáng 6 đối thủ!","Mượn tiền đã khó, trả được hay không còn khó hơn!",},
        [36] = {36,"Chúa công chạy nhanh lên, như thế ta mới có thể giành hạng 1!","Uống nước cũng mập thì sao không uống trà sữa cho lành!","Cam Ninh vác đao bỏ chạy nhìn buồn cười quá!","Nam tử hán đại trượng phu, không có sự nghiệp thì xem như vứt đi?",},
        [37] = {37,"Hứa Chử cầm Lưu Tinh Chùy nặng như thế thì chạy sao nổi!","Bóp ta dày thế thôi, toàn giấy nợ cả đấy!","Tôn Kiên là hảo hán đầu tiên dùng Vô Địch Thuẫn!","Non xanh nước biếc mãi trường tồn.",},
        [38] = {38,"Trương Liêu có giỏi cũng không thể giành hạng 1 như ta!","Ai thích vừa chạy vừa trêu đùa chứ?","Thượng Hương xinh nhất, sát thương cũng rất cao!","Chiến hay thủ, thủ hay hàng, hàng hay chạy, chạy hay quyết tử, tùy cơ ứng biến!",},
        [39] = {39,"Tam Quốc tứ đại mỹ nhân, ta thích Chân Cơ!","Soi gương nhiều vào, lòng mình sẽ sáng như gương!","Lục Tốn phối hợp với Tôn Sách, rất lợi hại đấy!","Mưu sự tại nhân, thành sự tại thiên!",},
        [40] = {40,"Tào Phi sao chạy nhanh bằng ta!","Từng mơ ước cầm kiếm dương danh giang hồ, nhưng vì bận kiếm tiền nên không làm được.","Lỗ Túc cũng có thể choáng và giảm nộ!","Mượn rượu để đáp tạ bạn hiền.",},
        [41] = {41,"Nhạc Tiến chân ngắn, chạy không nhanh!","Đã là hòn đá thì tỉ năm cũng không phát sáng được.","Tả Từ và Gia Cát đều mạnh về khống chế!","Im lặng nhưng vẫn thắng mới là thượng sách.",},
        [42] = {42,"Không ăn cơm thì chạy thế nào!","Cùng học một trường, sao ngươi giỏi thế!","Điêu Thuyền hồi cho Lữ Bố bốn nộ, Tào Tháo thấy chắc sẽ đau lòng lắm!","Thế cuộc như bàn cờ.",},
        [43] = {43,"Triệu Vân chắc chắn chạy rất nhanh!","Ta muốn biến thành A Đẩu!","Hãy thử đánh Đổng Trác của chính tuyến xem, khó lắm đấy!","Gặp đối thủ mạnh cũng không khiếp sợ, quả nhiên là dũng tướng.",},
        [44] = {44,"Lưu Bị cũng không nhanh bằng ta!","Ai nghĩ ra câu chảnh như cờ hó, chắc chưa từng nuôi mèo!","Tướng có truy kích đều mạnh hơn lên, Hoa Hùng cũng thế!","Từ xưa đến nay, có thịnh ắt có suy.",},
        [45] = {45,"Ngọa Long xem bói nói hôm nay ta xếp hạng 1!","Trời có sập cũng đừng mong ta dậy sớm!","Độc thương của Giả Hủ lợi hại thật!","Đã là dũng tướng thì có thể tiến cũng có thể lui.",},
        [46] = {46,"Nguyệt Anh bày cho ta cách để giành hạng 1!","Ai cũng cho rằng mình chạy nhanh nhất!","Công Tôn Toản vừa choáng vừa giảm nộ, rất hiệu quả để vượt ải trong bản đồ!","Mọi việc đã xong, chỉ đợi gió đông!",},
        [47] = {47,"Quan Vũ có giỏi cũng thua ta một bậc!","Trận thi đấu này hãy tìm đến ta!","Trương Giác có thể trầm mặc người khác lại không sợ bị người khác trầm mặc!","Đại trượng phu chỉ sợ không tạo dựng được sự nghiệp thôi.",},
        [48] = {48,"Hoàng Trung tuy già nhưng ý chí vẫn còn, nếu không ai dùng thật đáng tiếc!","May mắn không phải do trời!","Đánh Vu Cát có thể sẽ bị trúng độc đấy!","Người không phụ ta, ta cũng không phụ người.",},
        [49] = {49,"Mã Siêu không cưỡi ngựa thì cũng thường thôi!","Nếu quên rồi thì sao phát hiện ra!","Viên Thiệu phối hợp với Lữ Bố, lợi hại quá!","Không thể vì việc nhỏ mà làm hư việc lớn.",},
        [50] = {50,"Khương Duy đeo Kim Long Nỏ, nhìn thế nào cũng không phải người chỉ huy!","Tình yêu là vĩnh cửu!","Viên Thuật có thể hồi nộ và giảm nộ, rất hợp với Tiểu Kiều!","May mắn vào được top 50 lực chiến! Hi vọng hôm nay có thể đạt hạng 1!",},
    }
}

return play_horse_player