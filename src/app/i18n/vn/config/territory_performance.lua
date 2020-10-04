--territory_performance

local territory_performance = {
    -- key
    __key_map = {
      id = 1,    --序号-int 
      name = 2,    --城池名称-string 
      directions = 3,    --城池描述-string 
      hero_name = 4,    --守关武将名字-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Từ Châu","  Từ Châu phong cảnh đẹp, địa linh nhân kiệt, văn hóa rượu nổi tiếng thiên hạ, văn nhân nhã sĩ thường đến uống rượu giải trí, qua nhiều đời dày công nghiên cứu, nơi này sản xuất nhiều Đỗ Khang.","Thái Sử Từ",},
        [2] = {2,"Dự Châu","  Dự Châu là trung tâm chính trị, kinh tế, văn hóa, nuôi dưỡng ra nhiều nhân tài quân sự, nơi này sản xuất nhiều đạo cụ EXP Tướng, Tướng Hồn.","Trương Chiêu",},
        [3] = {3,"Kinh Châu","  Kinh Châu địa linh nhân kiệt, từng ra đời nhiều danh tướng quái tài, nơi này sản xuất nhiều Đột Phá Đơn, cũng là nơi binh gia thích tranh giành.","Lưu Biểu",},
        [4] = {4,"Thanh Châu"," Thanh Châu tài nguyên khoáng sản phong phú, công nghệ rèn sắt phát triển, sản suất các loại Đá Tinh Luyện-T.Bị, Tinh Thiết.","Tào Nhân",},
        [5] = {5,"U Châu","  U Châu một phần của Cửu Châu cổ và Thập Tam Thứ Sử, sản xuất nhiều tài nguyên nuôi dưỡng như bảo vật EXP, Đá Tinh Luyện-Bảo.","Lưu Bị",},
        [6] = {6,"Duyện Châu","  Duyện Châu lấy tên từ sông Duyện Thủy, Duyện Thủy còn gọi là Tế Thủy. Khổng Tử, Mạnh Tử đều từng dạy học ở đây, nơi này sản xuất nhiều Đá Thần Binh.","Tào Tháo",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
    }
}

return territory_performance