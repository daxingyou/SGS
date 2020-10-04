--pet

local pet = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      name = 2,    --名称-越南语-string 
      description = 3,    --宠物描述-越南语-string 
      description1 = 4,    --show宠物描述1-越南语-string 
      description2 = 5,    --show宠物描述2-越南语-string 
      skill_name = 6,    --show宠物技能名称-越南语-string 
      skill_description = 7,    --show宠物技能描述-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Gấu Trúc","Gấu Trúc, còn gọi Thực Thiết Thú, Gấu Trúc cha uy lực dũng mãnh, Gấu Trúc con rất thông minh, cả hai kết hợp, bách chiến bách thắng","Gấu Trúc cha sức mạnh to lớn, Gấu Trúc con dễ thương vô cùng","Cha con kết hợp, bách thắng","[Gào Thét]","Gây sát thương cho 1 kẻ địch",},
        [2] = {2,"Linh Lộc","Linh Lộc, linh thú trong thiên hạ, sừng của nó là  sự kết tinh của linh khí trong thiên hạ, khi linh khí tỏa ra có thể khiến cải tử hồi sinh.","Linh vật sinh giữa trời đất","Sừng Hươu là kết tinh của linh khí đất trời","[Hoa Phồn Diệp Mậu]","Trị liệu đồng đội có HP thấp nhất",},
        [3] = {3,"Liệt Hỏa Hồ","Liệt Hỏa Hồ, truyền thuyết nói rằng có ba đuôi, móng vuốt rực lửa, vô cùng hung hãn, nhưng ân oán rõ ràng, có thù báo thù, có ân báo ân.","Tam Vĩ, Tứ Trảo kèm lửa","Ân Oán, có thù báo thù, có ân báo ân","[Hỏa Hồ Quyển Vĩ]","Gây sát thương cho kẻ địch hàng sau",},
        [4] = {4,"Tử Thanh Loan","Tử Thanh Loan, màu lông đẹp. Người xưa cho rằng đỏ tượng trưng cho Phụng, xanh tượng trưng cho Loan. Tương truyền Thanh Loan là tượng trưng cho tình yêu, khi hót sẽ mang lại vận đào hoa cho người có lòng thành.","Màu lông tuyệt sắc","Tương truyền là tượng trưng của tình yêu","[Phong Quyển Tàn Vân]","Gây sát thương cho hàng trước địch",},
        [5] = {5,"Bạch Hổ","Bạch Hổ, một trong Tứ Thần Thú, toàn thân màu trắng như tuyết, có sức mạnh như sấm chớp.","Trắng trong suốt","Có thể điều khiển Lôi Điện Lực","[Diệu Nhật Bôn Lôi]","Trước chiến giảm nộ, trong chiến giảm nộ tiếp",},
        [6] = {6,"Thanh Long","Thanh Long, Thủ Lĩnh Tứ Thần Thú, từ xưa đã tượng trưng cho sự may mắn.","Thủ Lĩnh Tứ Thần Thú","Tự cổ chính là tượng trưng của may mắn","[Thanh Long Nộ]","Hồi phục nộ khí thành viên phe ta",},
        [7] = {7,"Chu Tước","Chu Tước, vua của loài chim, một trong Tứ Thần Thú. Tuy đẹp nhưng rất hung hãn, tượng trưng cho sự cát tường.","Vật có thể đốt","Có thể dẫn linh hồn lên trời","[Phần Thiên]","Gây sát thương cho tất cả mục tiêu bị thiêu đốt của phe địch",},
        [8] = {8,"Huyền Vũ","Huyền Vũ, một trong Tứ Thần Thú, là linh vật kết hợp giữa rắn và rùa, từ xưa đã tượng trưng cho sự bất tử. Huyền Vũ, vốn là Thủy Thần, mang đến sự sống cho vạn vật.","Linh vật kết hợp rùa và rắn","Tượng trưng Trường Sinh","[Huyền Vũ Chi Hựu]","Thêm Hộ Thuẫn cho thành viên phe ta",},
        [9] = {9,"Thánh Côn","Côn trong Trang Tử-Tiêu Dao Du có ghi: Bắc Minh có một loài cá, có tên là Côn. Côn có dáng vẻ to lớn ngoài sức tưởng tượng. Trong Trang Tử Nội Thiên Chú có ghi: Bắc Minh tức Bì Hải, một nơi xa xôi, người đời ít ai biết đến. Trong biển có loài Côn.","Bắc Minh có cá, tên gọi là Côn","Cá Côn to lớn vô cùng","[Vân Mộng Tiêu Dao]","Xóa trạng thái Choáng của thành viên phe ta",},
        [10] = {10,"Hỏa Kỳ Lân","Hỏa Kỳ Lân, cùng với Phụng Quy Long hợp thành tứ linh.","Thiên Niên Thần Linh","Hiểu Biết","[Thiên Mệnh Lựa Chọn]","Gây sát thương bằng 50% sinh lực tối đa cho mục tiêu ngẫu nhiên của phe địch",},
        [11] = {11,"Lân Hoa","Tương truyền mỗi khi hết năm sẽ xuất hiện thú nhỏ, mắt như chuông đồng, tới lui như gió, kim thân sặc sỡ, oai phong lẫm liệt. Hoạt bát hiếu động như trẻ nhỏ, rất thích ồn ào.","Kim thân sặc sỡ, oai phong lẫm liệt","Hoạt bát hiếu động như trẻ nhỏ","[Thiên Giáng]","Mục tiêu có sinh lực dưới mức nhất định sẽ bị diệt",},
        [12] = {12,"Bạch Trạch","Tương truyền mỗi khi hết năm sẽ xuất hiện thú nhỏ, mắt như chuông đồng, tới lui như gió, kim thân sặc sỡ, oai phong lẫm liệt. Hoạt bát hiếu động như trẻ nhỏ, rất thích ồn ào.","Kim thân sặc sỡ, oai phong lẫm liệt","Hoạt bát hiếu động như trẻ nhỏ","[Thiên Giáng]","Mục tiêu có sinh lực dưới mức nhất định sẽ bị diệt",},
        [13] = {106,"Thanh Long","Thanh Long, Thủ Lĩnh Tứ Thần Thú, từ xưa đã tượng trưng cho sự may mắn.","Thủ Lĩnh Tứ Thần Thú","Tự cổ chính là tượng trưng của may mắn","[Thanh Long Nộ]","Hồi phục nộ khí thành viên phe ta",},
    }
}

return pet