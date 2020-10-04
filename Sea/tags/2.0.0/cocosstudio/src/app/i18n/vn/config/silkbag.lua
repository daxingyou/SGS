--silkbag

local silkbag = {
    -- key
    __key_map = {
      id = 1,    --锦囊id_key-int 
      name = 2,    --锦囊名称-string 
      profile = 3,    --锦囊短描述-string 
      description = 4,    --锦囊详情-string 
      bag_description = 5,    --背包锦囊描述-string 
      button_txt = 6,    --按钮文字-string 
      show_day = 7,    --图鉴显示天数-int 
    
    },
    -- data
    _data = {
        [1] = {1101,"Cẩm Nang Ngân Bình","Tấn công +1000","Tấn công +1000 (Cứ tăng 1 cấp thêm +40)","Tấn công +1000 (Mỗi cấp +40)","Dùng thử",0,},
        [2] = {1102,"Cẩm Nang Tinh Thái","HP +7500","HP +7500 (Cứ tăng 1 cấp thêm +300)","Sinh lực +7500 (Mỗi cấp +300)","Dùng thử",0,},
        [3] = {1103,"C.N Chu Thái","Phòng thủ +500","Phòng thủ +500 (Cứ tăng 1 cấp thêm +20)","Phòng thủ +500 (Mỗi cấp +20)","Dùng thử",0,},
        [4] = {1104,"C.N Lữ Linh Thư ","Tỉ lệ bạo kích +8%","Tỉ lệ bạo kích +8%","Tỉ lệ bạo kích +8%","Dùng thử",0,},
        [5] = {1105,"C.N Hoàng Cái","Kháng bạo +8%","Kháng bạo +8%","Kháng bạo +8%","Dùng thử",0,},
        [6] = {1106,"C.N Trương Nhượng","ST +5%","ST +5%","ST +5%","Dùng thử",0,},
        [7] = {1107,"C.N Thái Văn Cơ","Giảm ST +5%","Giảm ST +5%","Giảm ST +5%","Dùng thử",0,},
        [8] = {1108,"C.N Vu Cấm","ST bạo kích +5%","ST bạo kích +5%","ST bạo kích +5%","Dùng thử",0,},
        [9] = {1202,"C.N Lưu Bị","Thi triển kỹ năng tăng trị liệu","Tướng trị liệu thi triển kỹ năng, tướng có HP thấp nhất phe ta tăng thêm 55% hiệu quả trị liệu.","Thi triển kỹ năng trị liệu tăng","Dùng thử",0,},
        [10] = {1203,"C.N Lục Tốn","Tỉ lệ Thiêu Đốt tăng","Mục tiêu tấn công càng ít, tỉ lệ Thiêu Đốt càng cao, tăng tối đa 60% tỉ lệ Thiêu Đốt mục tiêu.","Tỉ lệ Thiêu Đốt tăng","Dùng thử",0,},
        [11] = {1204,"C.N Công Tôn Toản","Tấn công mục tiêu đơn giảm 1 nộ khí","Khi tấn công mục tiêu đơn giảm 1 nộ khí mục tiêu.","Giảm nộ của mục tiêu bị  tấn công","Dùng thử",0,},
        [12] = {1205,"Cẩm Nang Quan Vũ","Ban đầu tăng 1 nộ khí","Nộ khí ban đầu tăng 1 điểm.","Ban đầu tăng 1 điểm nộ khí","Dùng thử",0,},
        [13] = {1207,"C.N Mã Siêu","Tăng hiệu quả giảm ST Hộ Thuẫn","Mục tiêu bảo vệ càng ít, hiệu quả giảm thương càng cao, tối đa giảm 36%. (Chỉ hiệu quả với Tướng có hộ thuẫn giảm ST)","Tăng hiệu quả giảm ST Hộ Thuẫn","Dùng thử",0,},
        [14] = {1208,"C.N Giả Hủ","Tỉ lệ Trúng Độc tăng","Mục tiêu tấn công kỹ năng càng ít, tỉ lệ Trúng Độc càng cao, tối đa tăng 60% tỉ lệ Trúng Độc.","Tỉ lệ Trúng Độc tăng","Dùng thử",0,},
        [15] = {1209,"C.N Từ Thứ","Tỉ lệ choáng tăng","Mục tiêu tấn công càng ít, tỉ lệ Choáng càng cao, tối đa tăng 48% tỉ lệ Choáng. (Chỉ hiệu quả với Tướng có hiệu quả Choáng)","Tỉ lệ Choáng tăng","Dùng thử",0,},
        [16] = {1211,"C.N Vu Cát","ST trúng độc tăng","Tấn công mục tiêu càng ít, sát thương trúng độc kỹ năng gây ra tăng càng cao, tối đa tăng 60% sát thương trúng độc cho 1 mục tiêu.","ST trúng độc tăng","Dùng thử",0,},
        [17] = {1212,"C.N Tiểu Kiều","Tỉ lệ tê liệt tăng","Mục tiêu tấn công càng ít, tỉ lệ Tê Liệt càng cao, tối đa tăng 72% tỉ lệ Tê Liệt đối với 1 mục tiêu. (Chỉ hiệu quả với Tướng có hiệu quả Tê Liệt)","Tỉ lệ tê liệt tăng","Dùng thử",0,},
        [18] = {1213,"C.N Quách Gia","Tỉ lệ Trầm Mặc tăng","Mục tiêu tấn công càng ít, tỉ lệ Trầm Mặc càng cao, tối đa tăng 72% tỉ lệ Trầm Mặc đối với 1 mục tiêu. (Chỉ hiệu quả với Tướng có hiệu quả Trầm Mặc)","Tỉ lệ Trầm Mặc tăng","Dùng thử",0,},
        [19] = {1214,"C.N Hạ Hầu Đôn","Tăng tỉ lệ phản đòn","Phản đòn tăng 30%. (Chỉ hiệu quả với Tướng có hiệu quả phản đòn)","Tăng tỉ lệ phản đòn","Dùng thử",0,},
        [20] = {1215,"C.N Trương Phi","Tấn công +3000","Tấn công +3000 (Cứ tăng 1 cấp thêm +120)","Tấn công +3000 (Mỗi cấp +120)","Dùng thử",0,},
        [21] = {1216,"C.N Bàng Thống","HP +22500","HP +22500 (Cứ tăng 1 cấp thêm +900)","Sinh lực +22500 (Mỗi cấp +900)","Dùng thử",0,},
        [22] = {1217,"C.N Tôn Kiên","Phòng thủ +1500","Phòng thủ +1500 (Cứ tăng 1 cấp thêm +60)","Phòng thủ +1500 (Mỗi cấp +60)","Dùng thử",0,},
        [23] = {1218,"C.N Viên Thuật","Tỉ lệ bạo kích +20%","Tỉ lệ bạo kích +20%","Tỉ lệ bạo kích +20%","Dùng thử",0,},
        [24] = {1219,"C.N Nguyệt Anh","Kháng bạo +20%","Kháng bạo +20%","Kháng bạo +20%","Dùng thử",0,},
        [25] = {1220,"C.N Điển Vi","ST +12%","ST +12%","ST +12%","Dùng thử",0,},
        [26] = {1221,"C.N Đổng Trác","Giảm ST +12%","Giảm ST +12%","Giảm ST +12%","Dùng thử",0,},
        [27] = {1222,"C.N Thượng Hương","ST bạo kích +12%","ST bạo kích +12%","ST bạo kích +12%","Dùng thử",0,},
        [28] = {1223,"C.N Hứa Chử","Diệt mục tiêu, bản thân hồi 1 Nộ khí","Diệt mục tiêu, bản thân hồi 1 Nộ khí.","Diệt mục tiêu, bản thân hồi 1 Nộ khí","Dùng thử",0,},
        [29] = {1224,"C.N Chân Cơ","ST kỹ năng chuyển hóa thành tỉ lệ trị liệu","Tỉ lệ chuyển ST kỹ năng thành HP hồi cho đồng đội yếu nhất tăng 18%.","ST kỹ năng chuyển hóa thành tỉ lệ trị liệu","Dùng thử",7,},
        [30] = {1225,"C.N Hoa Đà","ST Trúng Độc hồi phục HP bản thân","Chuyển 10% ST Trúng Độc gây ra thành hồi HP cho bản thân.","Gây ST Trúng Độc hồi HP cho bản thân","Dùng thử",7,},
        [31] = {1226,"C.N Đại Kiều","Tăng hiệu quả trị liệu và kèm hộ thuẫn giảm ST","Hiệu quả hồi HP tăng 25%, kèm thuẫn giảm 12% ST kỹ năng, duy trì 1 lượt","Tăng hiệu quả trị liệu kèm Hộ Thuẫn","Dùng thử",7,},
        [32] = {1227,"C.N Điêu Thuyền","Giảm tỉ lệ bản thân bị khống chế","Tỉ lệ trúng Khống Chế (Tê Liệt, Trầm Mặc, Choáng) giảm 35%.","Giảm tỉ lệ bản thân bị khống chế","Dùng thử",7,},
        [33] = {1301,"C.N Triệu Vân","Đánh thường chắc chắn bạo kích","Đánh thường chắc chắn bạo kích. (Bao gồm tướng trị liệu)","Đánh thường chắc chắn bạo kích","Dùng thử",7,},
        [34] = {1303,"C.N Chu Du","Tăng số lượt duy trì Thiêu Đốt","Trạng thái Thiêu đốt chủ động gây ra kéo dài thêm 1 lượt.","Trạng thái Thiêu Đốt tăng thêm 1 lượt","Dùng thử",7,},
        [35] = {1304,"C.N Tả Từ","Trúng Độc kèm cấm trị liệu","Trúng Độc kèm cấm trị liệu, Võ Tướng bị trúng độc không được trị liệu.","Trúng Độc kèm cấm trị liệu","Dùng thử",7,},
        [36] = {1308,"C.N Tào Tháo","Xóa hiệu quả vô địch của tướng địch","Mục tiêu tấn công càng ít, tỉ lệ xóa trạng thái vô địch tướng địch càng cao, tối đa tăng 100% tỉ lệ xóa vô địch đối với 1 mục tiêu.","Xóa hiệu quả vô địch của tướng địch","Dùng thử",7,},
        [37] = {1302,"C.N Tào Nhân-Thần","Tấn công mục tiêu hàng dọc giảm 1 nộ khí","Tấn công hàng dọc, giảm thêm 1 nộ của mục tiêu. (Hiệu quả với Tướng có hiệu quả giam nộ hàng dọc)","Tấn công hàng dọc, mục tiêu giảm 1 nộ","Dùng thử",7,},
        [38] = {1309,"C.N Lục Tốn-Thần","Tướng bị Thiêu Đốt khóa vô địch","Tướng bị Thiêu Đốt không thể nhận hiệu quả vô địch và Thuẫn Hút HP.","Cấm hiệu quả với tướng bị thiêu đốt","Dùng thử",7,},
        [39] = {1310,"C.N Nguyệt Anh-Thần","Lượt đầu miễn khống chế","Lượt đầu miễn dịch Choáng, Trầm Mặc, Tê Liệt","Lượt đầu miễn Khống Chế","Dùng thử",7,},
        [40] = {1311,"C.N Hoa Đà-Thần","ST kỹ năng chuyển hóa thành trị liệu","Chuyển 18% ST kỹ năng thành hồi HP cho bản thân","Chuyển ST kỹ năng thành hồi HP","Dùng thử",7,},
        [41] = {1312,"C.N Tư Mã Ý","Tốn tất cả Nộ khí tăng ST kỹ năng","Khi nộ khí tướng thấp hơn 7, không thi triển kỹ năng; Thi triển kỹ năng tốn tất cả nộ khí hiện tại, vượt quá 4 nộ khí, mỗi tốn thêm 1 sẽ tăng 15% ST kỹ năng.","Tốn tất cả Nộ khí tăng ST kỹ năng","Dùng thử",7,},
        [42] = {1305,"C.N Giả Hủ-Thần","Tăng số lượt duy trì Trúng Độc","Trạng thái trúng độc do kỹ năng gây ra kéo dài 1 lượt.","Trạng thái Trúng Độc tăng thêm 1 lượt","Dùng thử",7,},
        [43] = {1313,"C.N Tuân Úc-Thần","Thi triển kỹ năng tăng trị liệu","Khi tướng trị liệu thi triển kỹ năng, hồi HP cho 3 đồng đội yếu nhất và tăng thêm 32% tấn công cho tướng trị liệu.","Thi triển kỹ năng tăng trị liệu","Dùng thử",7,},
        [44] = {1314,"C.N Kết Nghĩa","Chia sẻ ST phải nhận","ST phải chịu giảm 12% và ST không gây chí mạng của bản thân được chia đều cho bản thân và 2 Tướng có HP cao nhất. (Tướng ở trạng thái vô địch cũng chịu ST)","Chia sẻ ST phải nhận","Dùng thử",7,},
        [45] = {1315,"C.N Thái Sử Từ-Thần","Tăng xác suất Thiêu Đốt","Mục tiêu tấn công càng ít, tỉ lệ Thiêu Đốt càng cao, tối đa tăng 96% tỉ lệ Thiêu Đốt đối với 1 mục tiêu.","Tăng xác suất Thiêu Đốt","Dùng thử",7,},
        [46] = {1316,"C.N Tử Khâm","Hết lượt hồi phục 1 nộ khí cho Tướng mang Du Du","Tướng sau mỗi lượt ra tay lần đầu, tướng mang C.N Du Du nhận thêm 1 nộ khí. (Mỗi bộ Trận Hình giới hạn 1 tướng nam mang)","Hết lượt hồi phục 1 nộ khí cho Tướng mang Du Du","Dùng thử",21,},
        [47] = {1317,"C.N Du Du","Hết lượt hồi phục 1 nộ khí cho Tướng mang Tử Khâm","Tướng sau mỗi lượt ra tay lần đầu, Tướng mang C.N Tử Khâm nhận thêm 1 điểm nộ khí. (Mỗi bộ Trận Hình giới hạn 1 Tướng Nữ mang)","Hết lượt hồi phục 1 nộ khí cho Tướng mang Tử Khâm","Dùng thử",21,},
        [48] = {1318,"C.N Đơn Kỵ","Tấn công tướng HP thấp nhất phe địch","Tất cả tấn công của Tướng ST đơn ưu tiên tấn công Tướng địch có HP thấp nhất.","Tấn công tướng HP thấp nhất phe địch","Dùng thử",21,},
        [49] = {1319,"C.N Nhất Kỵ","Diệt mục tiêu, tăng 1 lần kỹ năng","Tướng ST đơn diệt mục tiêu, tăng 1 lần kỹ năng gây 175% ST vật lý. (Kỹ năng thêm không tốn nộ, không kèm hiệu ứng)","Diệt mục tiêu, tăng 1 lần kỹ năng","Dùng thử",21,},
        [50] = {1401,"C.N Thất Sát","Giảm tỉ lệ chia sát thương gây ra","Giảm 50% hiệu quả chia sẻ sát thương ( nếu có ) của tướng địch. VD: tướng địch mang CN Kết Nghĩa sẽ bị giảm hiệu quả chia sẻ sát thương","Sát thương mà võ tướng ở hàng dọc, hàng trước của phe ta gây cho kẻ địch nếu chia ra thì tỷ lệ chia ra giảm 50%","Dùng thử",21,},
        [51] = {1402,"C.N Tham Lang","Diệt mục tiêu nhận Nộ khí","Dùng kỹ năng diệt mục tiêu, nhận được tất cả điểm nộ khí còn lại của mục tiêu (Tăng cho võ tướng sát thương)","Khi diệt mục tiêu phe địch, nhận tất cả Nộ khí mà mục tiêu còn (Võ tướng sát thương đeo)","Dùng thử",21,},
        [52] = {1403,"C.N TT-Quan Vũ ","Nộ ban đầu tăng 2 điểm","Nộ ban đầu tăng 2 điểm","Nộ ban đầu tăng 2 điểm","Dùng thử",21,},
        [53] = {1404,"C.N Quyết Chiến","Mỗi lượt chịu sát thương có giới hạn","Mỗi lượt phải chịu sát thương bằng 50% HP tối đa (Sát thương do tướng gây ra)","Mỗi lượt chịu sát thương có giới hạn","Dùng thử",999,},
        [54] = {1405,"C.N Hiệp Lực","Hấp thu sát thương võ tướng phe ta","Khi tướng cùng phe bị tướng địch sát thương, 50% sát thương này sẽ chuyển cho tướng đeo Cẩm Nang này (Không thể kích hoạt đặc tính, không miễn dịch vô địch)","Hấp thu sát thương võ tướng phe ta","Dùng thử",999,},
    }
}

return silkbag