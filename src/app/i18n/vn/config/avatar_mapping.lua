--avatar_mapping

local avatar_mapping = {
    -- key
    __key_map = {
      id = 1,    --武将id-int 
      description = 2,    --神兵+25特性描述-string 
      description_1 = 3,    --神兵+50特性描述-string 
      description_2 = 4,    --神兵+75特性描述-string 
      description_3 = 5,    --神兵+100特性描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [2] = {2,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [3] = {3,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [4] = {4,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [5] = {5,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [6] = {6,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [7] = {11,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [8] = {12,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [9] = {13,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [10] = {14,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [11] = {15,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [12] = {16,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [13] = {101,"Thi triển kỹ năng có 40% thêm kỹ năng 1 lần, gây cho toàn thể địch 41% sát thương phép","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [14] = {102,"Trị liệu từ kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [15] = {103,"Tỉ lệ bạo kích toàn đội +30%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [16] = {104,"Sau khi thi triển bản thân hồi 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [17] = {105,"Bị tấn công thường sát thương trực tiếp, bản thân hồi 1 nộ ","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [18] = {106,"Khi tử vong 100% choáng diệt tướng địch của mình","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [19] = {107,"ST kỹ năng tăng 25%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [20] = {108,"Diệt 1 mục tiêu, hồi 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [21] = {109,"Mỗi lượt bản thân hồi 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [22] = {110,"Xác suất bạo kích Tướng ra trận tăng 20%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [23] = {111,"Cứ giảm 1 kỹ năng mục tiêu, sát thương kỹ năng tăng 10%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [24] = {112,"Chuyển 50% sát thương trực tiếp từ kỹ năng thành HP, trị liệu cho đồng đội sinh lực thấp nhất.","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [25] = {113,"Chuyển 50% sát thương trực tiếp từ tấn công thường thành trị liệu cho bản thân","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [26] = {114,"Chắn chắn bạo kích ở hiệp đầu","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [27] = {115,"Xác suất thi triển kỹ năng kèm hiệu quả Trầm Mặc tăng đến 70%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [28] = {116,"Thi triển kỹ năng có 80% gây choáng","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [29] = {117,"Chuyển 40% sát thương trực tiếp từ kỹ năng thành HP, trị liệu cho đồng đội sinh lực thấp nhất.","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [30] = {118,"Hộ thuẫn giúp tỉ lệ giảm sát thương đồng đội phải chịu tăng 45%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [31] = {119,"Chuyển 20% sát thương trực tiếp phải chịu thành trị liệu cho bản thân.","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [32] = {150,"Khi tấn công mục tiêu là tướng nữ, tự hồi 2 nộ khí. Khi tấn công mục tiêu là tướng nam thêm 1 lần đánh thường gây sát thương bằng 36% sinh lực tối đa (Đánh thường thêm không hồi nộ khí, không kích hoạt đặc tính của tướng bất kỳ)","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [33] = {151,"Nếu tướng địch bị Suy Yếu khiến dùng kỹ năng thất bại, Vương Dị sẽ hồi 2 nộ.","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [34] = {152,"Sau khi dùng kỹ năng, bản thân hồi 2 nộ khí, sau khi sát thương gián tiếp diệt mục tiêu, hồi thêm 2 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [35] = {153,"Khi võ tướng Ngụy phe ta tấn công địch trong trạng thái Tỏa Nhuệ, Chu Bất Nghi bản thân hồi 1 nộ khí, mỗi lượt tối đa hồi 4 điểm","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [36] = {201,"Diệt mục tiêu, thêm 1 lần công thường (Công thường thêm không hồi nộ khí)","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [37] = {202,"Khi chịu sát thương trực tiếp, chuyển 18% sát thương thành hiệu quả Trị Liệu cho bản thân và phe ta","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [38] = {203,"Sau khi thi triển khiến mục tiêu giảm 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [39] = {204,"Sau khi thi triển toàn đội hồi 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [40] = {205,"Diệt 1 mục tiêu, hồi 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [41] = {206,"HP bản thân giảm 10%, Công tăng 5%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [42] = {207,"Trị liệu nhận được +50%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [43] = {208,"Diệt mục tiêu, thêm 1 lần công thường (Công thường thêm không hồi nộ khí)","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [44] = {209,"Mỗi hiệp bản thân tăng tấn công 8%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [45] = {210,"Thi triển kỹ năng có 65% gây choáng","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [46] = {211,"Toàn đội tăng 20% bạo kích","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [47] = {212,"Sau khi thi triển bản thân hồi 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [48] = {213,"Diệt 1 mục tiêu, +8% công bản thân","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [49] = {214,"Khi tử vong thi triển kỹ năng 1 lần","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [50] = {215,"Tỉ lệ giảm sát thương trực tiếp của Hộ Thuẫn tăng đến 45%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [51] = {216,"Khi tử vong thi triển kỹ năng 1 lần","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [52] = {217,"Khi sát thương trực tiếp hạ được mục tiêu, bản thân hồi 20% sinh lực","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [53] = {218,"ST kỹ năng tăng 15%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [54] = {219,"Thi triển kỹ năng có 70% gây Tê Liệt","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [55] = {250,"Địch và ta cứ mỗi lần tử vong 1 mục tiêu, sát thương Thủy Kính tăng 10%.","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [56] = {251,"Mỗi lượt bản thân hồi 1 nộ. Khi bị hiệu quả Choáng, Đánh Bay, Áp Chế, Trúng Độc, Thiêu Đốt, có thể dùng 2 nộ xóa 1 lần hiệu quả này.","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [57] = {252,"Sau khi dùng kỹ năng, bản thân hồi 1 nộ khí. Nếu ở trạng thái Ngự Giáp trước khi thi triển kỹ năng, hồi thêm 2 nộ khí.","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [58] = {253,"Sau khi thi triển sẽ hồi nội khí, mỗi tầng trạng thái Thọ Thương đều có thể hồi thêm 1 nộ khí cho bản thân (Tối đa hồi thêm 4 nộ khí)","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [59] = {301,"Khi tấn công, tỉ lệ bạo kích mục tiêu thiêu đốt tăng thêm 80%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [60] = {302,"Hiệu quả hồi HP cho đồng đội tăng lên 32% dựa trên tấn công của bản thân","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [61] = {303,"Khi bị tấn công thường có 80% khiến người tấn công bị bỏng, duy trì 2 lượt","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [62] = {304,"Tạo thuẫn hút HP cho 2 tướng có HP ít nhất, duy trì 1 lượt","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [63] = {305,"Khi bị tấn công thường có 50% khiến người tấn công bị bỏng, duy trì 2 lượt","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [64] = {306,"Khi sát thương trực tiếp hạ được mục tiêu bị Thiêu Đốt, bản thân hồi 50% sinh lực","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [65] = {307,"Khi thi triển kỹ năng, nếu mục tiêu đang trong trạng thái thiêu đốt thì xác suất bị choáng sẽ tăng 80%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [66] = {308,"Công thường gây sát thương thêm cho mục tiêu thiêu đốt tăng 80% ","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [67] = {309,"Khi bị kẻ địch ở trạng thái Thiêu Đốt tấn công, giảm 65% sát thương trực tiếp phải chịu","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [68] = {310,"Sau khi thi triển thêm 1 lần công thường (Công thường thêm không hồi nộ khí)","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [69] = {311,"Thi triển kỹ năng có 96% gây Thiêu Đốt","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [70] = {312,"Đánh thường, mục tiêu bị giảm 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [71] = {313,"Khi bị tấn công thường có 40% khiến người tấn công bị bỏng, duy trì 2 lượt","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [72] = {314,"Hiệu quả trị liệu phải chịu tăng 40%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [73] = {315,"Tỉ lệ hộ hấp thu sát thương trực tiếp của Hộ Thuẫn tăng đến 100%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [74] = {316,"Diệt 1 mục tiêu, hồi 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [75] = {317,"Khi thi triển kỹ năng, nếu mục tiêu đang trong trạng thái thiêu đốt thì xác suất bị choáng sẽ tăng 80%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [76] = {318,"Sát thương kỹ năng gây cho mục tiêu thiêu đốt tăng 80%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [77] = {319,"Khi bị tấn công kỹ năng, 30% gây thiêu đốt cho mục tiêu, duy trì 2 hiệp","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [78] = {350,"Khi mục tiêu tấn công là võ tướng nam, gây thêm sát thương bằng 10% sinh lực tối đa. Khi mục tiêu tấn công kỹ năng là võ tướng nữ, hủy hiệu quả khống chế 2 mục tiêu có sinh lực thấp nhất phe mình (Choáng, Tê Liệt, Câm Lặng).","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [79] = {351,"Sau khi dùng kỹ năng, tăng 20% Ngự Giáp cho tướng phe ta, mỗi lượt bản thân hồi 2 nộ.","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [80] = {352,"Cứ kích hoạt 1 lần Phản Đòn, bản thân hồi 1 nộ, mỗi lượt tối đa không quá 4 điểm","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [81] = {353,"Khi chịu sát thương trực tiếp từ mục tiêu Thiêu Đốt, có xác suất kèm trạng thái Ẩm Độc cho người tấn công, duy trì 1 lượt (Mỗi 1 Võ Tướng Ngô ra trận khác đều có thể cung cấp 18% xác suất)","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [82] = {401,"Thi triển kỹ năng có 70% gây choáng","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [83] = {402,"Sinh lực mục tiêu mỗi giảm 10%, trị liệu cho mục tiêu tăng 5%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [84] = {403,"Khi sát thương trực tiếp hạ được mục tiêu, bản thân hồi 2 nộ","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [85] = {404,"Chuyển 50% sát thương trực tiếp từ kỹ năng thành HP, trị liệu cho đồng đội sinh lực thấp nhất.","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [86] = {405,"Tỉ lệ giảm sát thương trực tiếp phải chịu của Giảm Thương Thuẫn tăng đến 50%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [87] = {406,"Diệt 1 mục tiêu, hồi 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [88] = {407,"Thi triển kỹ năng có 96% gây Trúng Độc","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [89] = {408,"Sau khi thi triển bản thân hồi 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [90] = {409,"Sau khi thi triển khiến mục tiêu giảm 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [91] = {410,"Sau khi thi triển khiến mục tiêu giảm 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [92] = {411,"Thi triển kỹ năng có 50% gây Tê Liệt","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [93] = {412,"Sau khi thi triển bản thân hồi 1 nộ khí","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [94] = {413,"Chắn chắn bạo kích ở hiệp đầu","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [95] = {414,"Diệt 1 mục tiêu, +8% công bản thân","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [96] = {415,"Thi triển kỹ năng có 80% gây choáng","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [97] = {416,"ST kỹ năng tăng 15%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [98] = {417,"Đánh thường, hồi 1 nộ","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [99] = {418,"Chuyển 50% sát thương trực tiếp từ tấn công thường thành sinh lực cho bản thân","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [100] = {419,"Thi triển kỹ năng có 80% gây Trầm Mặc","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [101] = {450,"Sát thương kỹ năng tăng 36%, sát thương đánh thường tăng 72%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [102] = {451,"Dùng kỹ năng sẽ bỏ qua hiệu quả Vô Địch, bản thân hồi 2 nộ","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [103] = {452,"Bị Động: Khi có mặt Mộc Lộc Vương, tất cả Võ Tướng Quần Hùng phe ta khi chịu sát thương Võ Tướng trực tiếp, nếu sát thương này lớn hơn 30% HP tối đa của bản thân, sát thương này sẽ giảm 50%","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
        [104] = {453,"Sát thương trực tiếp kỹ năng gây ra lớn hơn HP còn lại của địch, sát thương dư ra chuyển hóa 50% thành sát thương gián tiếp, tấn công mục tiêu Mắt Xích, Áp Chế HP ít nhất khác.","Nộ ban đầu +1","Nộ ban đầu +1","Đầu trận tăng Ngự Giáp bằng 18% sinh lực tối đa",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [101] = 13,
        [102] = 14,
        [103] = 15,
        [104] = 16,
        [105] = 17,
        [106] = 18,
        [107] = 19,
        [108] = 20,
        [109] = 21,
        [11] = 7,
        [110] = 22,
        [111] = 23,
        [112] = 24,
        [113] = 25,
        [114] = 26,
        [115] = 27,
        [116] = 28,
        [117] = 29,
        [118] = 30,
        [119] = 31,
        [12] = 8,
        [13] = 9,
        [14] = 10,
        [15] = 11,
        [150] = 32,
        [151] = 33,
        [152] = 34,
        [153] = 35,
        [16] = 12,
        [2] = 2,
        [201] = 36,
        [202] = 37,
        [203] = 38,
        [204] = 39,
        [205] = 40,
        [206] = 41,
        [207] = 42,
        [208] = 43,
        [209] = 44,
        [210] = 45,
        [211] = 46,
        [212] = 47,
        [213] = 48,
        [214] = 49,
        [215] = 50,
        [216] = 51,
        [217] = 52,
        [218] = 53,
        [219] = 54,
        [250] = 55,
        [251] = 56,
        [252] = 57,
        [253] = 58,
        [3] = 3,
        [301] = 59,
        [302] = 60,
        [303] = 61,
        [304] = 62,
        [305] = 63,
        [306] = 64,
        [307] = 65,
        [308] = 66,
        [309] = 67,
        [310] = 68,
        [311] = 69,
        [312] = 70,
        [313] = 71,
        [314] = 72,
        [315] = 73,
        [316] = 74,
        [317] = 75,
        [318] = 76,
        [319] = 77,
        [350] = 78,
        [351] = 79,
        [352] = 80,
        [353] = 81,
        [4] = 4,
        [401] = 82,
        [402] = 83,
        [403] = 84,
        [404] = 85,
        [405] = 86,
        [406] = 87,
        [407] = 88,
        [408] = 89,
        [409] = 90,
        [410] = 91,
        [411] = 92,
        [412] = 93,
        [413] = 94,
        [414] = 95,
        [415] = 96,
        [416] = 97,
        [417] = 98,
        [418] = 99,
        [419] = 100,
        [450] = 101,
        [451] = 102,
        [452] = 103,
        [453] = 104,
        [5] = 5,
        [6] = 6,
    }
}

return avatar_mapping