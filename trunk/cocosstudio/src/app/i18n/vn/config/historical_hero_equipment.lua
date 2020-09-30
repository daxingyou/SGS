--historical_hero_equipment

local historical_hero_equipment = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name = 2,    --名称-string 
      short_description = 3,    --装备短描述-string 
      long_description = 4,    --装备详细描述-string 
    
    },
    -- data
    _data = {
        [1] = {101,"Hiệu Chung Cầm","Trang bị của Cao Tiệm Ly, giúp tăng sinh lực","Vũ khí của Cao Tiệm Ly, giúp tướng được bảo hộ tăng thêm 5% sinh lực",},
        [2] = {102,"Kinh Long Nhẫn","Trang bị của Kinh Kha, giúp tăng sát thương","Vũ khí của Kinh Kha, giúp tướng được bảo hộ tăng thêm 5% sát thương",},
        [3] = {103,"Hàn Ngân Thương","Trang bị của Hàn Tín, giúp tăng tấn công","Vũ khí của Hàn Tín, giúp tướng được bảo hộ tăng thêm 5% tấn công",},
        [4] = {104,"Lăng Hư Bút","Trang bị của Trương Lương, giúp tăng miễn thương","Vũ khí của Trương Lương, giúp tướng được bảo hộ tăng thêm 5% miễn thương",},
        [5] = {201,"Định Tần Kiếm","Trang bị của Tần Thủy Hoàng, giúp giảm ST trực tiếp","Vũ khí của Tần Thủy Hoàng, khi tướng được bảo hộ bị tướng khác tấn công, giảm thêm 9% ST trực tiếp phải chịu, xác suất bị trúng các hiệu quả bất lợi giảm 12% (Tê Liệt, Choáng, Câm Lặng, Thiêu Đốt, Trúng Độc, Suy Yếu, Áp Chế, Mắt Xích, Đánh Bay)",},
        [6] = {202,"Bát Phục Kiếm","Trang bị của Hán Vũ Đế, giúp tăng sát thương","Vũ khí của Hán Vũ Đế, giúp tướng được bảo hộ tăng thêm 9% sát thương và trị liệu, 24% sát thương bạo kích",},
        [7] = {203,"Bá Vương Thương","Trang bị dành cho Hạng Vũ, tăng hiệu quả Thần Thú phe ta","Vũ khí Hạng Vũ, tướng được bảo hộ nhận hiệu quả có lợi của Thanh Long, Chu Tước, Huyền Vũ, hiệu quả tăng thêm 25% (Không tăng thêm nộ)",},
        [8] = {204,"Hàm Quang Tỳ Bà","Trang bị dành cho Ngu Cơ, bảo vệ Võ Tướng xóa bất thường","Khi Tướng được bảo hộ chịu sát thương trực tiếp, 100% xóa 1 trạng thái Thiêu Đốt hoặc Trúng Độc",},
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

return historical_hero_equipment