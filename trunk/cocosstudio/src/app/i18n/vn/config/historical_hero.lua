--historical_hero

local historical_hero = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      description = 2,    --描述-string 
      short_description = 3,    --简要描述-string 
      name = 4,    --名称-string 
    
    },
    -- data
    _data = {
        [1] = {101,"Cầm Sư nước Yên cuối thời Chiến Quốc, bạn thân của Kinh Kha. Từng hành thích Tần Thủy Hoàng, thất bại.","Tướng được bảo hộ tăng sinh lực","Cao Tiệm Ly",},
        [2] = {102,"Em gái của Kinh Kha. Sau khi Kinh Kha thích sát Tần Thủy Hoàng thất bại, cô quyết tiếp nối ý nguyện và lấy tên của người anh.","Tướng được bảo hộ tăng sát thương","Kinh Kha",},
        [3] = {103,"Khai quốc công thần nhà Tây Hán, công lao to lớn, được phong Quốc Sĩ, uy chấn thiên hạ. Đời sau xưng tụng là Binh Tiên, Thần Soái.","Tướng được bảo hộ tăng tấn công","Hàn Tín",},
        [4] = {104,"Mưu thần kiệt xuất đầu thời Tây Hán, từng hiến kế giúp Lưu Bang đánh bại Hạng Vũ, được đánh giá là Ngồi trong lều bày mưu lược, quyết thắng trận chiến ngàn dặm.","Tướng được bảo hộ tăng giảm sát thương","Trương Lương",},
        [5] = {201,"Tần Thủy Hoàng Doanh Chính, vị vua đầu tiên tự xưng là Hoàng Đế. Ông hoàn thành bá nghiệp, thống nhất thiên hạ, thống nhất chữ viết, thống nhất đo lường, xây Vạn Lý Trường Thành.","Tướng được bảo hộ giảm ST trực tiếp","Tần Thủy Hoàng",},
        [6] = {202,"Hán Vũ Đế Lưu Triệt, một hoàng đế vĩ đại. Ông không những văn võ song toàn, còn thúc đẩy nhiều cải cách xã hội, chính thức xác lập Con Đường Tơ Lụa nối liền văn minh đông tây.","Tướng được bảo hộ tăng sát thương và trị liệu","Hán Vũ Đế",},
        [7] = {203,"Tây Sở Bá Vương, sức mạnh cái thế. Có lòng thôn tính bát hoang, chí khí rung chuyển đất trời, tài trí siêu phàm, đánh đâu thắng đó.","Tướng được bảo hộ tăng hiệu quả Thần Thú","Hạng Vũ",},
        [8] = {204,"Sủng cơ của Hạng Vũ, dung nhan khuynh thành, rất có tài nghệ, được mệnh danh là Ngu Mỹ Nhân","Tướng được bảo hộ tăng Ngự Giáp và xóa hiệu quả bất lợi","Ngu Cơ",},
    },

    -- index
    __index_id = {
        [101] = 1,
        [102] = 2,
        [103] = 3,
        [104] = 4,
        [201] = 5,
        [202] = 6,
        [203] = 7,
        [204] = 8,
    }
}

return historical_hero