--jade

local jade = {
    -- key
    __key_map = {
      id = 1,    --玉石id_key-int 
      name = 2,    --玉石名称-string 
      profile = 3,    --玉石短描述-string 
      description = 4,    --玉石详情-string 
      bag_description = 5,    --背包玉石描述-string 
      button_txt = 6,    --按钮文字-string 
    
    },
    -- data
    _data = {
        [1] = {1101,"TL Quang - Công","Tấn công +5000","Tấn công +5000 (Nhân vật cứ tăng 1 cấp tấn công tăng thêm +100)","Tấn công +5000","Khảm",},
        [2] = {1102,"TL Quang - Liệu","Tăng trị liệu +8%","Tăng trị liệu +8% (Hiệu lực với tướng loại trị liệu)","Tăng trị liệu +8%","Khảm",},
        [3] = {1103,"TL Quang - Bạo","Tỉ lệ bạo kích +12%","Tỉ lệ bạo kích +12%","Tỉ lệ bạo kích +12%","Khảm",},
        [4] = {1104,"HV Quang - Vật","Vật phòng +2500","Vật phòng +2500 (Nhân vật cứ tăng 1 cấp vật phòng tăng thêm +50)","Vật phòng +2500","Khảm",},
        [5] = {1105,"HV Quang - Dũ","Tỉ lệ nhận trị liệu +8%","Tỉ lệ nhận trị liệu +8% (Hiệu lực với tướng loại trị liệu)","Tỉ lệ nhận trị liệu +8%","Khảm",},
        [6] = {1106,"HV Quang - Kháng","Tỉ lệ kháng bạo +12%","Tỉ lệ kháng bạo +12%","Tỉ lệ kháng bạo +12%","Khảm",},
        [7] = {1107,"BH Quang - Pháp","Pháp phòng +2500","Pháp phòng +2500 (Nhân vật cứ tăng 1 cấp vật phòng tăng thêm +50)","Pháp phòng +2500","Khảm",},
        [8] = {1108,"BH Quang - Dũ","Tỉ lệ nhận trị liệu +8%","Tỉ lệ nhận trị liệu +8% (Hiệu lực với tướng loại trị liệu)","Tỉ lệ nhận trị liệu +8%","Khảm",},
        [9] = {1109,"BH Quang - Thiểm","Tỉ lệ né tránh +12%","Tỉ lệ né tránh +12%","Tỉ lệ né tránh +12%","Khảm",},
        [10] = {1110,"CT Quang - Huyết","Sinh lực +37500","Sinh lực +37500 (Nhân vật cứ tăng 1 cấp sinh lực tăng thêm +750)","Sinh lực +37500","Khảm",},
        [11] = {1111,"CT Quang - Liệu","Tăng trị liệu +8%","Tăng trị liệu +8% (Hiệu lực với tướng loại trị liệu)","Tăng trị liệu +8%","Khảm",},
        [12] = {1112,"CT Quang - Mệnh","Tỉ lệ chính xác +12%","Tỉ lệ chính xác +12%","Tỉ lệ chính xác +12%","Khảm",},
        [13] = {1201,"TL Hoa - Công","Công Tăng +12%","Công Tăng +12%","Công Tăng +12%","Khảm",},
        [14] = {1202,"TL Hoa - Liệu","Tăng trị liệu +12%","Tăng trị liệu +12% (Hiệu lực với tướng loại trị liệu)","Tăng trị liệu +12%","Khảm",},
        [15] = {1203,"TL Hoa - Bạo","Tỉ lệ bạo kích +22%","Tỉ lệ bạo kích +22%","Tỉ lệ bạo kích +22%","Khảm",},
        [16] = {1204,"HV Hoa - Vật","Tăng vật phòng +12%","Tăng vật phòng +12%","Tăng vật phòng +12%","Khảm",},
        [17] = {1205,"HV Hoa - Dũ","Tỉ lệ nhận trị liệu +12%","Tỉ lệ nhận trị liệu +12% (Hiệu lực với tướng loại trị liệu)","Tỉ lệ nhận trị liệu +12%","Khảm",},
        [18] = {1206,"HV Hoa - Kháng","Tỉ lệ kháng bạo +22%","Tỉ lệ kháng bạo +22%","Tỉ lệ kháng bạo +22%","Khảm",},
        [19] = {1207,"BH Hoa - Pháp","Tăng pháp phòng +12%","Tăng pháp phòng +12%","Tăng pháp phòng +12%","Khảm",},
        [20] = {1208,"BH Hoa - Dũ","Tỉ lệ nhận trị liệu +12%","Tỉ lệ nhận trị liệu +12% (Hiệu lực với tướng loại trị liệu)","Tỉ lệ nhận trị liệu +12%","Khảm",},
        [21] = {1209,"BH Hoa - Thiểm","Tỉ lệ né tránh +22%","Tỉ lệ né tránh +22%","Tỉ lệ né tránh +22%","Khảm",},
        [22] = {1210,"CT Hoa - Huyết","Tăng HP +12%","Tăng HP +12%","Tăng HP +12%","Khảm",},
        [23] = {1211,"CT Hoa - Liệu","Tăng trị liệu +12%","Tăng trị liệu +12% (Hiệu lực với tướng loại trị liệu)","Tăng trị liệu +12%","Khảm",},
        [24] = {1212,"CT Hoa - Mệnh","Tỉ lệ chính xác +22%","Tỉ lệ chính xác +22%","Tỉ lệ chính xác +22%","Khảm",},
        [25] = {1301,"TL Diệu - Thương","Buff ST +18%","Buff ST +18%","Buff ST +18%","Khảm",},
        [26] = {1302,"TL Diệu - Liệu","Tăng trị liệu +18%","Tăng trị liệu +18% (Hiệu lực với tướng loại trị liệu)","Tăng trị liệu +18%","Khảm",},
        [27] = {1303,"TL Diệu - Bạo","Tỉ lệ bạo kích +32%","Tỉ lệ bạo kích +32%","Tỉ lệ bạo kích +32%","Khảm",},
        [28] = {1304,"TL Diệu - Khắc","Tăng ST PVP +18%","Tăng ST PVP +18%","Tăng ST PVP +18%","Khảm",},
        [29] = {1305,"HV Diệu - Hộ","Giảm ST +18%","Giảm ST +18%","Giảm ST +18%","Khảm",},
        [30] = {1306,"HV Diệu - Dũ","Tỉ lệ nhận trị liệu +18%","Tỉ lệ nhận trị liệu +18% (Hiệu lực với tướng loại trị liệu)","Tỉ lệ nhận trị liệu +18%","Khảm",},
        [31] = {1307,"HV Diệu - Kháng","Tỉ lệ kháng bạo +32%","Tỉ lệ kháng bạo +32%","Tỉ lệ kháng bạo +32%","Khảm",},
        [32] = {1308,"HV Diệu - Nhẫn","Giảm ST PVP +18%","Giảm ST PVP +18%","Giảm ST PVP +18%","Khảm",},
        [33] = {1309,"BH Diệu - Hộ","Giảm ST +18%","Giảm ST +18%","Giảm ST +18%","Khảm",},
        [34] = {1310,"BH Diệu - Dũ","Tỉ lệ nhận trị liệu +18%","Tỉ lệ nhận trị liệu +18% (Hiệu lực với tướng loại trị liệu)","Tỉ lệ nhận trị liệu +18%","Khảm",},
        [35] = {1311,"BH Diệu - Thiểm","Tỉ lệ né tránh +32%","Tỉ lệ né tránh +32%","Tỉ lệ né tránh +32%","Khảm",},
        [36] = {1312,"BH Diệu - Nhẫn","Giảm ST PVP +18%","Giảm ST PVP +18%","Giảm ST PVP +18%","Khảm",},
        [37] = {1313,"CT Diệu - Thương","Buff ST +18%","Buff ST +18%","Buff ST +18%","Khảm",},
        [38] = {1314,"CT Diệu - Liệu","Tăng trị liệu +18%","Tăng trị liệu +18% (Hiệu lực với tướng loại trị liệu)","Tăng trị liệu +18%","Khảm",},
        [39] = {1315,"CT Diệu - Mệnh","Tỉ lệ chính xác +32%","Tỉ lệ chính xác +32%","Tỉ lệ chính xác +32%","Khảm",},
        [40] = {1316,"CT Diệu - Khắc","Tăng ST PVP +18%","Tăng ST PVP +18%","Tăng ST PVP +18%","Khảm",},
        [41] = {2101,"TL Hồn - Sát Ý","Gây thêm ST lên mục tiêu bị khống chế","Khi tấn công mục tiêu đang bị khống chế (Choáng, Trầm Mặc, Tê Liệt) sẽ tăng 15% ST.","Gây thêm ST lên mục tiêu bị khống chế","Khảm",},
        [42] = {2102,"TL Hồn - Thị Huyết","Tấn công kỹ năng gây thêm sát thương","Khi tấn công lần lượt 1/2/3/4/6 mục tiêu, khiến mục tiêu chịu thêm sát thương bằng 15%/7.5%/5%/3.75%/2.5% HP tối đa","Tấn công kỹ năng gây thêm sát thương","Khảm",},
        [43] = {2103,"TL Hồn - Đồng Tâm","Tăng sát thương hoặc trị liệu","Khi tấn công, tăng ST hoặc trị liệu bản thân gây ra (Cứ mỗi tướng ra trận cùng phe với bản thân, ST hoặc trị liệu +3.75%)","Tăng sát thương hoặc trị liệu","Khảm",},
        [44] = {2104,"TL Hồn - Như Ý","Diệt địch sẽ xóa trạng thái bất lợi","Sau khi diệt mục tiêu sẽ xóa tất cả hiệu quả bất thường mục tiêu thi triển lên Tướng phe ta (Thiêu Đốt, Trúng Độc, Choáng, Trầm Mặc, Tê Liệt)","Diệt địch sẽ xóa trạng thái bất lợi","Khảm",},
        [45] = {2105,"HV Kim - Hấp Tinh","Bắt đầu lượt nhận được hộ thuẫn","Trước khi chiến đấu, nhận một thuẫn hút sát thương trực tiếp bằng 30% HP tối đa, duy trì 1 lượt","Bắt đầu lượt nhận được hộ thuẫn","Khảm",},
        [46] = {2106,"HV Kim - Ngân Sương","Hành động nhận hộ thuẫn hấp thu ST","Sau khi hành động, bản thân nhận 1 hộ thuẫn hấp thu sát thương bằng 15% HP tối đa, duy trì 1 lượt (Mỗi lượt 1 lần)","Hành động nhận hộ thuẫn hấp thu ST","Khảm",},
        [47] = {2107,"HV Kim - Đồng Trạch","Tử vong sẽ tạo hộ thuẫn vô địch","Khi tử vong, giúp đồng đội HP thấp nhất nhận 1 thuẫn vô địch, duy trì 1 lượt (Tương đương hộ thuẫn Trương Hợp đột phá 5)","Tử vong sẽ tạo hộ thuẫn vô địch","Khảm",},
        [48] = {2108,"HV Kim - Hóa Thương","Chịu sát thương lớn sẽ được giảm ST","Khi chịu sát thương tướng, nếu sát thương cao hơn 50% sinh lực tối đa bản thân sẽ giảm 30% sát thương lần này","Chịu sát thương lớn sẽ được giảm ST","Khảm",},
        [49] = {2109,"BH Nộ - Hồi Quang","Hết lượt sẽ hồi điểm nộ khí","Sau khi bản thân hành động, hồi 1 nộ khí (Chỉ kích hoạt 1 lần trong lượt của bản thân)","Hết lượt sẽ hồi điểm nộ khí","Khảm",},
        [50] = {2110,"BH Nộ - Linh Sương","Đồng đội dùng KN có xác suất hồi nộ","Sau khi đồng đội thi triển kỹ năng, 20% hồi 1 nộ cho bản thân","Đồng đội dùng KN có xác suất hồi nộ","Khảm",},
        [51] = {2111,"BH Nộ - Hóa Cực","Xong lượt có xác suất hồi nộ khí","Khi tổng lượt kết thúc, nếu bản thân dưới 4 nộ sẽ có 35% hồi nộ đến 4","Xong lượt có xác suất hồi nộ khí","Khảm",},
        [52] = {2112,"BH Nộ - Phản Cẩm","Thi triển có xác suất hồi nộ khí","Sau khi thi triển kỹ năng có 25% nhận 50% nộ khí lần này đã tốn, tối đa 4 điểm","Thi triển có xác suất hồi nộ khí","Khảm",},
        [53] = {2113,"CT Tức - Bồi Nguyên","Dùng kỹ năng tăng kháng khống chế","Sau khi thi triển kỹ năng, có 50% giúp xác suất bị khống chế (Choáng, Trầm Mặc, Tê Liệt) của đồng đội giảm 35%, duy trì 1 lượt","Dùng kỹ năng tăng kháng khống chế","Khảm",},
        [54] = {2114,"CT Tức - Cố Bản","Bản thân hồi điểm nộ khí sẽ hồi SL","Trong lượt bản thân, vừa hồi nộ vừa hồi HP bằng 15% HP tối đa","Bản thân hồi điểm nộ khí sẽ hồi SL","Khảm",},
        [55] = {2115,"CT Tức - Ngưng Thần","Chưa hành động sẽ nhận thuẫn miễn KC","Khi lượt bản thân kết thúc, nếu lượt này không chủ động hành động, nhận 1 hộ thuẫn miễn khống chế (Choáng, Trầm Mặc, Tê Liệt), duy trì 1 lượt","Chưa hành động sẽ nhận thuẫn miễn KC","Khảm",},
        [56] = {2116,"CT Tức - Thanh Tâm","Mỗi lượt có xác suất xóa trạng thái xấu","Trước khi bắt đầu lượt, có 25% xóa hiệu quả bất lợi của bản thân (Thiêu Đốt, Trúng Độc, Choáng, Trầm Mặc, Tê Liệt)","Mỗi lượt có xác suất xóa trạng thái xấu","Khảm",},
    }
}

return jade