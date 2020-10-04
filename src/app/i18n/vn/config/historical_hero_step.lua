--historical_hero_step

local historical_hero_step = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      description = 2,    --技能描述-string 
    
    },
    -- data
    _data = {
        [1] = {101,"Tướng được bảo hộ tăng thêm 5% HP",},
        [2] = {101,"Tướng được bảo hộ tăng thêm 5% HP",},
        [3] = {102,"Tướng được bảo hộ tăng thêm 5% sát thương",},
        [4] = {102,"Tướng được bảo hộ tăng thêm 5% sát thương",},
        [5] = {103,"Tướng được bảo hộ tăng thêm 5% tấn công",},
        [6] = {103,"Tướng được bảo hộ tăng thêm 5% tấn công",},
        [7] = {104,"Tướng được bảo hộ tăng thêm 5% Giảm ST",},
        [8] = {104,"Tướng được bảo hộ tăng thêm 5% Giảm ST",},
        [9] = {201,"Khi tướng được bảo hộ bị tướng khác tấn công, giảm thêm 9% ST trực tiếp phải chịu, xác suất bị trúng các hiệu quả bất lợi giảm 12% (Tê Liệt, Choáng, Câm Lặng, Thiêu Đốt, Trúng Độc, Suy Yếu, Áp Chế, Mắt Xích, Đánh Bay)",},
        [10] = {201,"Xác suất Tướng được bảo hộ bị trúng các hiệu quả bất lợi giảm thêm 24% (Tê Liệt, Choáng, Câm Lặng, Thiêu Đốt, Trúng Độc, Suy Yếu, Áp Chế, Mắt Xích, Đánh Bay)",},
        [11] = {201,"Xác suất Tướng được bảo hộ bị trúng các hiệu quả bất lợi giảm thêm 24% (Tê Liệt, Choáng, Câm Lặng, Thiêu Đốt, Trúng Độc, Suy Yếu, Áp Chế, Mắt Xích, Đánh Bay)",},
        [12] = {202,"Tướng được bảo hộ tăng thêm 9% hiệu quả sát thương và trị liệu, tăng thêm 24% ST bạo kích",},
        [13] = {202,"Tướng được bảo hộ tăng thêm 24% ST bạo kích",},
        [14] = {202,"Tướng được bảo hộ tăng thêm 24% ST bạo kích",},
        [15] = {203,"Tướng được bảo hộ nhận hiệu quả có lợi của Thanh Long, Chu Tước, Huyền Vũ, hiệu quả tăng thêm 25% (Không tăng thêm nộ)",},
        [16] = {203,"Tướng được bảo hộộ nhận hiệu quả có lợi của Thanh Long, Chu Tước, Huyền Vũ, hiệu quả tăng thêm 25% (Tăng thêm 1 nộ)",},
        [17] = {203,"Tướng được bảo hộộ nhận hiệu quả có lợi của Thanh Long, Chu Tước, Huyền Vũ, hiệu quả tăng thêm 25% (Tăng thêm 1 nộ)",},
        [18] = {204,"Khi Tướng được bảo hộ chịu sát thương trực tiếp, 100% xóa 1 trạng thái Thiêu Đốt hoặc Trúng Độc",},
        [19] = {204,"Khi Tướng được bảo hộ chịu sát thương trực tiếp, có 50% xóa 1 trạng thái Áp Chế hoặc Suy Yếu",},
        [20] = {204,"Khi Tướng được bảo hộ chịu sát thương trực tiếp, có 50% xóa 1 trạng thái Áp Chế hoặc Suy Yếu",},
    },

    -- index
    __index_id_step = {
        ["101_1"] = 1,
        ["101_2"] = 2,
        ["102_1"] = 3,
        ["102_2"] = 4,
        ["103_1"] = 5,
        ["103_2"] = 6,
        ["104_1"] = 7,
        ["104_2"] = 8,
        ["201_1"] = 9,
        ["201_2"] = 10,
        ["201_3"] = 11,
        ["202_1"] = 12,
        ["202_2"] = 13,
        ["202_3"] = 14,
        ["203_1"] = 15,
        ["203_2"] = 16,
        ["203_3"] = 17,
        ["204_1"] = 18,
        ["204_2"] = 19,
        ["204_3"] = 20,
    }
}

return historical_hero_step