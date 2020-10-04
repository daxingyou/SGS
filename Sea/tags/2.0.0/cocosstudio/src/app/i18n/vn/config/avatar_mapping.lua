--avatar_mapping

local avatar_mapping = {
    -- key
    __key_map = {
      id = 1,    --武将id_key-int 
      description = 2,    --神兵+25特性描述-string 
      description_1 = 3,    --神兵+50特性描述-string 
      description_2 = 4,    --神兵+75特性描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [2] = {2,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [3] = {3,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [4] = {4,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [5] = {5,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [6] = {11,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [7] = {12,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [8] = {13,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [9] = {14,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [10] = {15,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [11] = {101,"Thi triển kỹ năng có 40% thêm kỹ năng 1 lần, gây cho toàn thể địch 41% sát thương phép","Nộ ban đầu +1","Nộ ban đầu +1",},
        [12] = {102,"Trị liệu từ kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [13] = {103,"Tỉ lệ bạo kích toàn đội +30%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [14] = {104,"Sau khi thi triển bản thân hồi 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1",},
        [15] = {105,"Khi bị tấn công thường, bản thân hồi 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1",},
        [16] = {106,"Khi tử vong 100% gây choáng tướng địch","Nộ ban đầu +1","Nộ ban đầu +1",},
        [17] = {107,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [18] = {108,"Diệt 1 mục tiêu, hồi 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1",},
        [19] = {109,"Mỗi hiệp bản thân hồi 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1",},
        [20] = {110,"Xác suất bạo kích Tướng ra trận tăng 20%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [21] = {111,"Cứ giảm 1 kỹ năng mục tiêu, sát thương kỹ năng tăng 10%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [22] = {112,"Chuyển 50% ST kỹ năng thành hồi HP cho đồng đội yếu nhất","Nộ ban đầu +1","Nộ ban đầu +1",},
        [23] = {113,"Đánh thường, chuyển 50% ST thành hồi HP cho bản thân","Nộ ban đầu +1","Nộ ban đầu +1",},
        [24] = {114,"Chắn chắn bạo kích ở hiệp đầu","Nộ ban đầu +1","Nộ ban đầu +1",},
        [25] = {115,"Xác suất thi triển kỹ năng kèm hiệu quả Trầm Mặc tăng đến 70%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [26] = {116,"Thi triển kỹ năng có 80% gây Choáng","Nộ ban đầu +1","Nộ ban đầu +1",},
        [27] = {117,"Chuyển 40% ST kỹ năng thành hồi HP cho đồng đội yếu nhất","Nộ ban đầu +1","Nộ ban đầu +1",},
        [28] = {118,"Hộ thuẫn giúp tỉ lệ giảm sát thương đồng đội phải chịu tăng 45%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [29] = {119,"Khi bị tấn công, chuyển 20% ST thành HP hồi cho bản thân","Nộ ban đầu +1","Nộ ban đầu +1",},
        [30] = {150,"Khi tấn công mục tiêu là tướng nữ, tự hồi 2 nộ khí. Khi tấn công mục tiêu là tướng nam thêm 1 lần đánh thường gây sát thương bằng 36% sinh lực tối đa (Đánh thường thêm không hồi nộ khí, không kích hoạt đặc tính của tướng bất kỳ)","Nộ ban đầu +1","Nộ ban đầu +1",},
        [31] = {201,"Diệt mục tiêu, thêm 1 lần công thường (Công thường thêm không hồi nộ khí)","Nộ ban đầu +1","Nộ ban đầu +1",},
        [32] = {202,"Khi bị tấn công, chuyển 18% ST thành HP hồi cho toàn đội","Nộ ban đầu +1","Nộ ban đầu +1",},
        [33] = {203,"Sau khi thi triển khiến mục tiêu giảm 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1",},
        [34] = {204,"Sau khi thi triển toàn đội hồi 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1",},
        [35] = {205,"Diệt 1 mục tiêu, hồi 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1",},
        [36] = {206,"HP bản thân giảm 10%, Công tăng 5%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [37] = {207,"Trị liệu nhận được +50%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [38] = {208,"Diệt mục tiêu, thêm 1 lần công thường (Công thường thêm không hồi nộ khí)","Nộ ban đầu +1","Nộ ban đầu +1",},
        [39] = {209,"Mỗi hiệp bản thân tăng tấn công 8%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [40] = {210,"Thi triển kỹ năng có 65% gây Choáng","Nộ ban đầu +1","Nộ ban đầu +1",},
        [41] = {211,"Toàn đội tăng 20% bạo kích","Nộ ban đầu +1","Nộ ban đầu +1",},
        [42] = {212,"Sau khi thi triển bản thân hồi 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1",},
        [43] = {213,"Diệt 1 mục tiêu, +8% công bản thân","Nộ ban đầu +1","Nộ ban đầu +1",},
        [44] = {214,"Khi tử vong thi triển kỹ năng 1 lần","Nộ ban đầu +1","Nộ ban đầu +1",},
        [45] = {215,"Hộ thuẫn giúp tỉ lệ giảm sát thương bản thân phải chịu tăng 45%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [46] = {216,"Khi tử vong thi triển kỹ năng 1 lần","Nộ ban đầu +1","Nộ ban đầu +1",},
        [47] = {217,"Diệt mục tiêu bản thân hồi 20% sinh lực","Nộ ban đầu +1","Nộ ban đầu +1",},
        [48] = {218,"ST kỹ năng tăng 15%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [49] = {219,"Thi triển kỹ năng có 70% gây Tê Liệt","Nộ ban đầu +1","Nộ ban đầu +1",},
        [50] = {250,"Địch và ta cứ mỗi lần tử vong 1 mục tiêu, sát thương Thủy Kính tăng 10%.","Nộ ban đầu +1","Nộ ban đầu +1",},
        [51] = {301,"Khi tấn công, tỉ lệ bạo kích mục tiêu thiêu đốt tăng thêm 80%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [52] = {302,"Hiệu quả hồi HP cho đồng đội tăng lên 32% dựa trên tấn công của bản thân","Nộ ban đầu +1","Nộ ban đầu +1",},
        [53] = {303,"Khi bị tấn công thường có 80% khiến người tấn công bị bỏng, duy trì 2 lượt","Nộ ban đầu +1","Nộ ban đầu +1",},
        [54] = {304,"Tạo thuẫn hút HP cho 2 tướng có HP ít nhất, duy trì 1 lượt","Nộ ban đầu +1","Nộ ban đầu +1",},
        [55] = {305,"Khi bị tấn công thường có 50% khiến người tấn công bị bỏng, duy trì 2 lượt","Nộ ban đầu +1","Nộ ban đầu +1",},
        [56] = {306,"Sau khi diệt mục tiêu thiêu đốt, bản thân hồi 50% sinh lực","Nộ ban đầu +1","Nộ ban đầu +1",},
        [57] = {307,"Gây 80% Choáng với mục tiêu Thiêu Đốt","Nộ ban đầu +1","Nộ ban đầu +1",},
        [58] = {308,"Công thường gây sát thương thêm cho mục tiêu thiêu đốt tăng 80% ","Nộ ban đầu +1","Nộ ban đầu +1",},
        [59] = {309,"Khi bị mục tiêu thiêu đốt tấn công, sát thương phải chịu giảm 65%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [60] = {310,"Sau khi thi triển thêm 1 lần công thường (Công thường thêm không hồi nộ khí)","Nộ ban đầu +1","Nộ ban đầu +1",},
        [61] = {311,"Thi triển kỹ năng có 96% gây Thiêu Đốt","Nộ ban đầu +1","Nộ ban đầu +1",},
        [62] = {312,"Đánh thường, mục tiêu bị giảm 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1",},
        [63] = {313,"Khi bị tấn công thường có 40% khiến người tấn công bị bỏng, duy trì 2 lượt","Nộ ban đầu +1","Nộ ban đầu +1",},
        [64] = {314,"Hiệu quả trị liệu phải chịu tăng 40%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [65] = {315,"Tỉ lệ hộ thuẫn hút sát thương tấn công bản thân tăng đến 100%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [66] = {316,"Diệt 1 mục tiêu, hồi 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1",},
        [67] = {317,"Gây 80% Choáng với mục tiêu Thiêu Đốt","Nộ ban đầu +1","Nộ ban đầu +1",},
        [68] = {318,"Sát thương kỹ năng gây cho mục tiêu thiêu đốt tăng 80%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [69] = {319,"Khi bị tấn công kỹ năng, 30% gây thiêu đốt cho mục tiêu, duy trì 2 hiệp","Nộ ban đầu +1","Nộ ban đầu +1",},
        [70] = {350,"Khi mục tiêu tấn công là võ tướng nam, gây thêm sát thương bằng 10% sinh lực tối đa. Khi mục tiêu tấn công kỹ năng là võ tướng nữ, hủy hiệu quả khống chế 2 mục tiêu có sinh lực thấp nhất phe mình (Choáng, Tê Liệt, Trầm Mặc).","Nộ ban đầu +1","Nộ ban đầu +1",},
        [71] = {401,"Thi triển kỹ năng có 70% gây Choáng","Nộ ban đầu +1","Nộ ban đầu +1",},
        [72] = {402,"Sinh lực mục tiêu mỗi giảm 10%, trị liệu cho mục tiêu tăng 5%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [73] = {403,"Diệt 1 mục tiêu, hồi 2 nộ","Nộ ban đầu +1","Nộ ban đầu +1",},
        [74] = {404,"Chuyển 50% sát thương kỹ năng thành HP, trị liệu đồng đội có HP thấp nhất","Nộ ban đầu +1","Nộ ban đầu +1",},
        [75] = {405,"Tỉ lệ giảm tất cả sát thương phải chịu của Giảm Thương Thuẫn tăng đến 50%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [76] = {406,"Diệt 1 mục tiêu, hồi 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1",},
        [77] = {407,"Thi triển kỹ năng có 96% gây Trúng Độc","Nộ ban đầu +1","Nộ ban đầu +1",},
        [78] = {408,"Sau khi thi triển bản thân hồi 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1",},
        [79] = {409,"Sau khi thi triển khiến mục tiêu giảm 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1",},
        [80] = {410,"Sau khi thi triển khiến mục tiêu giảm 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1",},
        [81] = {411,"Thi triển kỹ năng có 50% gây Tê Liệt","Nộ ban đầu +1","Nộ ban đầu +1",},
        [82] = {412,"Sau khi thi triển bản thân hồi 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1",},
        [83] = {413,"Chắn chắn bạo kích ở hiệp đầu","Nộ ban đầu +1","Nộ ban đầu +1",},
        [84] = {414,"Diệt 1 mục tiêu, +8% công bản thân","Nộ ban đầu +1","Nộ ban đầu +1",},
        [85] = {415,"Thi triển kỹ năng có 80% gây Choáng","Nộ ban đầu +1","Nộ ban đầu +1",},
        [86] = {416,"ST kỹ năng tăng 15%","Nộ ban đầu +1","Nộ ban đầu +1",},
        [87] = {417,"Đánh thường, hồi 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1",},
        [88] = {418,"Đánh thường, chuyển 50% ST thành hồi HP cho bản thân","Nộ ban đầu +1","Nộ ban đầu +1",},
        [89] = {419,"Thi triển kỹ năng có 80% gây Trầm Mặc","Nộ ban đầu +1","Nộ ban đầu +1",},
        [90] = {450,"Sát thương kỹ năng tăng 36%, sát thương đánh thường tăng 72%","Nộ ban đầu +1","Nộ ban đầu +1",},
    }
}

return avatar_mapping