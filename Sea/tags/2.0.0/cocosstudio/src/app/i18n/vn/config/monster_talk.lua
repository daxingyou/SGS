--monster_talk

local monster_talk = {
    -- key
    __key_map = {
      id = 1,    --序号_key-int 
      bubble = 2,    --战斗中说话内容，不要超过25个字-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Đại ca gần đây được một bảo vật.",},
        [2] = {2,"Hãy xem phù chú của ta đây!",},
        [3] = {3,"Trời xanh đã mất, trời vàng lên thay!",},
        [4] = {4,"Chiến đấu ban đầu 2 nộ, đánh thường cộng 2 nộ, 4 điểm nộ được dùng kỹ năng.",},
        [5] = {5,"Quan Ngân Bình đánh chính, chúa công phải bồi dưỡng thật tốt.",},
        [6] = {6,"Ở hàng trước rất nguy hiểm, chúa công đưa ta ra hàng sau được không?",},
        [7] = {7,"Ở hàng trước rất nguy hiểm, chúa công đưa ta ra hàng sau được không?",},
        [8] = {8,"Ở hàng sau an toàn hơn, đa tạ chúa công!",},
        [9] = {9,"Tướng tăng cấp đột phá chưa? Đã mặc trang bị và đã cường hóa chưa?",},
        [10] = {10,"Chúa công không bồi dưỡng là không thể thắng Trương Nhượng!",},
        [11] = {11,"Chúa công hãy nhớ bồi dưỡng ta!",},
        [12] = {12,"Chúa công hãy nhớ bồi dưỡng ta!",},
        [13] = {13,"Chúa công hãy nhớ bồi dưỡng ta!",},
        [14] = {14,"Chúa công hãy nhớ bồi dưỡng ta!",},
        [15] = {15,"Chúa công hãy nhớ bồi dưỡng ta!",},
        [16] = {16,"Chúa công hãy nhớ bồi dưỡng ta!",},
        [17] = {17,"Chúa công hãy nhớ bồi dưỡng ta!",},
        [18] = {18,"Chúa công hãy nhớ bồi dưỡng ta!",},
        [19] = {19,"Cướp! Mau giao NB có được ở Đấu Trường ra đây!",},
        [20] = {20,"Không bồi dưỡng Tướng và trang bị, không thể đánh thắng ta!",},
        [21] = {21,"Tướng Lv15 đột phá +2, mới có khả năng thắng ta.",},
        [22] = {22,"Không bồi dưỡng Tướng và trang bị, không thể đánh thắng ta!",},
        [23] = {23,"Càn quét phó bản chính tuyến đến Lv20 mới có thể đánh bại ta!",},
        [24] = {24,"Càn quét phó bản chính tuyến đến Lv23 mới có thể đánh bại ta!",},
        [25] = {25,"Càn quét phó bản chính tuyến đến Lv26 mới có thể đánh bại ta!",},
        [26] = {26,"Càn quét phó bản chính tuyến đến Lv29 mới có thể đánh bại ta!",},
        [27] = {27,"NB của Đấu Trường thật nhiều, ha ha ha!",},
        [28] = {28,"Không có NB hãy đến Đấu Trường chiến đấu, ở đó rất nhiều NB!",},
        [29] = {29,"Lv16 có thể càn quét phó bản, tăng cấp nhanh nhé, ha ha!",},
        [30] = {31,"Chắc chỉ có ta mới biết Lv16 có thể càn quét phó bản đầy sao!",},
        [31] = {32,"Tướng Lv25 có thể đột phá +3, đột phá xong có thể thi triển kỹ năng và hợp kích ở lượt đầu!",},
        [32] = {33,"Càn quét phó bản chính tuyến nhanh chóng tăng cấp nhân vật",},
        [33] = {34,"Càn quét phó bản chính tuyến nhanh chóng tăng cấp nhân vật",},
        [34] = {35,"Càn quét phó bản chính tuyến nhanh chóng tăng cấp nhân vật",},
        [35] = {36,"Càn quét phó bản chính tuyến nhanh chóng tăng cấp nhân vật",},
        [36] = {37,"Tướng Lv25 có thể đột phá +3, đột phá xong có thể thi triển kỹ năng và hợp kích ở lượt đầu!",},
        [37] = {38,"Tướng Lv25 có thể đột phá +3, đột phá xong có thể thi triển kỹ năng và hợp kích ở lượt đầu!",},
        [38] = {39,"Chúa công rất lợi hại, nhờ càn quét chính tuyến mà tăng cấp!",},
        [39] = {40,"Tướng Lv25 có thể đột phá +3, đột phá xong có thể thi triển kỹ năng và hợp kích ở lượt đầu!",},
        [40] = {41,"Tướng Cam lợi hại hơn Tướng Tím!",},
        [41] = {42,"Chiêu mộ có thể nhận Tướng Cam!",},
        [42] = {43,"Ngươi không có Tướng Cam, sao đánh lại ta! Hãy đi chiêu mộ đi!",},
        [43] = {44,"Ngươi không có Tướng Cam, sao đánh lại ta! Hãy đi chiêu mộ đi!",},
        [44] = {45,"Nếu không có chiêu mộ được Tướng Cam, ngươi sẽ đánh không lại ta!",},
        [45] = {46,"Nếu ngươi có vài Tướng Cam, ta đương nhiên đánh không lại ngươi!",},
        [46] = {47,"Chỉ có Tướng Tím mà cũng dám đến đây?",},
        [47] = {48,"Ngươi không có nhiều Tướng Cam, sao đánh lại ta!",},
        [48] = {49,"Tại sao Hạ Hầu Uyên ta lại là Tướng Tím?",},
    }
}

return monster_talk