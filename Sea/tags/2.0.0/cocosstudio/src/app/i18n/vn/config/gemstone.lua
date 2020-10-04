--gemstone

local gemstone = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      name = 2,    --名称-string 
      bag_description = 3,    --背包描述-string 
      description = 4,    --装备描述-string 
    
    },
    -- data
    _data = {
        [1] = {101,"Đá Lục Tinh-Công","Đá lục, sờ vào rất mát","Đá lục, sờ vào rất mát.",},
        [2] = {102,"Đá Lục Tinh-Thủ","Đá lục, sờ vào rất mát","Đá lục, sờ vào rất mát.",},
        [3] = {103,"Đá Lục Tinh-HP","Đá lục, sờ vào rất mát","Đá lục, sờ vào rất mát.",},
        [4] = {104,"BK Lục Tinh","Nuôi dưỡng Quyển Đá Lục-Sơ, có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Lục-Sơ, nghe nói có sức mạnh cực lớn",},
        [5] = {201,"Đá Lam Tinh-Công","Đá lam, sờ vào rất mát.","Đá lam, sờ vào rất mát.",},
        [6] = {202,"Đá Lam Tinh-Thủ","Đá lam, sờ vào rất mát.","Đá lam, sờ vào rất mát.",},
        [7] = {203,"Đá Lam Tinh-HP","Đá lam, sờ vào rất mát.","Đá lam, sờ vào rất mát.",},
        [8] = {204,"BK Lam Tinh","Nuôi dưỡng Quyển Đá Lam-Sơ, có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Lam-Sơ, nghe nói có sức mạnh cực lớn",},
        [9] = {301,"Đá Hải Lam-Công","Đá lam, sờ vào rất mát.","Đá lam, sờ vào rất mát.",},
        [10] = {302,"Đá Hải Lam-Thủ","Đá lam, sờ vào rất mát.","Đá lam, sờ vào rất mát.",},
        [11] = {303,"Đá Hải Lam-HP","Đá lam, sờ vào rất mát.","Đá lam, sờ vào rất mát.",},
        [12] = {304,"BK Hải Lam","Nuôi dưỡng Quyển Đá Lam-Sơ, có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Lam-Sơ, nghe nói có sức mạnh cực lớn",},
        [13] = {401,"Đá Tử Tinh-Công","Đá Tím cao cấp, sờ vào rất mát.","Đá Tím cao cấp, sờ vào rất mát.",},
        [14] = {402,"Đá Tử Tinh-Thủ","Đá Tím cao cấp, sờ vào rất mát.","Đá Tím cao cấp, sờ vào rất mát.",},
        [15] = {403,"Đá Tử Tinh-HP","Đá Tím cao cấp, sờ vào rất mát.","Đá Tím cao cấp, sờ vào rất mát.",},
        [16] = {404,"BK Tử Tinh","Nuôi dưỡng Quyển Đá Tím-Sơ, có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Tím-Sơ, nghe nói có sức mạnh cực lớn",},
        [17] = {501,"Đá Tử Diệu-Công","Đá Tím cao cấp, sờ vào rất mát.","Đá Tím cao cấp, sờ vào rất mát.",},
        [18] = {502,"Đá Tử Diệu-Thủ","Đá Tím cao cấp, sờ vào rất mát.","Đá Tím cao cấp, sờ vào rất mát.",},
        [19] = {503,"Đá Tử Diệu-HP","Đá Tím cao cấp, sờ vào rất mát.","Đá Tím cao cấp, sờ vào rất mát.",},
        [20] = {504,"BK Tử Diệu","Nuôi dưỡng Quyển Đá Tím-Sơ, có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Tím-Sơ, nghe nói có sức mạnh cực lớn",},
        [21] = {601,"Đá Tinh Không-Công","Đá Tím cao cấp, sờ vào rất mát.","Đá Tím cao cấp, sờ vào rất mát.",},
        [22] = {602,"Đá Tinh Không-Thủ","Đá Tím cao cấp, sờ vào rất mát.","Đá Tím cao cấp, sờ vào rất mát.",},
        [23] = {603,"Đá Tinh Không-HP","Đá Tím cao cấp, sờ vào rất mát.","Đá Tím cao cấp, sờ vào rất mát.",},
        [24] = {604,"BK Tinh Không","Nuôi dưỡng Quyển Đá Tím-Sơ, có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Tím-Sơ, nghe nói có sức mạnh cực lớn",},
        [25] = {701,"Đá Hoàng Tinh-Công","Đá cao cấp màu cam, sờ vào rất mát.","Đá cao cấp màu cam, sờ vào rất mát.",},
        [26] = {702,"Đá Hoàng Tinh-Thủ","Đá cao cấp màu cam, sờ vào rất mát.","Đá cao cấp màu cam, sờ vào rất mát.",},
        [27] = {703,"Đá Hoàng Tinh-HP","Đá cao cấp màu cam, sờ vào rất mát.","Đá cao cấp màu cam, sờ vào rất mát.",},
        [28] = {704,"BK Hoàng Tinh","Nuôi dưỡng Quyển Đá Cam-Sơ, có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Cam-Sơ, nghe nói có sức mạnh cực lớn",},
        [29] = {801,"Đá Long Tinh-Công","Đá cao cấp màu cam, sờ vào rất mát.","Đá cao cấp màu cam, sờ vào rất mát.",},
        [30] = {802,"Đá Long Tinh-Thủ","Đá cao cấp màu cam, sờ vào rất mát.","Đá cao cấp màu cam, sờ vào rất mát.",},
        [31] = {803,"Đá Long Tinh-HP","Đá cao cấp màu cam, sờ vào rất mát.","Đá cao cấp màu cam, sờ vào rất mát.",},
        [32] = {804,"BK Long Tinh","Nuôi dưỡng Quyển Đá Cam-Sơ, có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Cam-Sơ, nghe nói có sức mạnh cực lớn",},
        [33] = {901,"Đá Thái Dương-Công","Đá cao cấp màu cam, sờ vào rất mát.","Đá cao cấp màu cam, sờ vào rất mát.",},
        [34] = {902,"Đá Thái Dương-Thủ","Đá cao cấp màu cam, sờ vào rất mát.","Đá cao cấp màu cam, sờ vào rất mát.",},
        [35] = {903,"Đá Thái Dương-HP","Đá cao cấp màu cam, sờ vào rất mát.","Đá cao cấp màu cam, sờ vào rất mát.",},
        [36] = {904,"BK Thái Dương","Nuôi dưỡng Quyển Đá Cam-Sơ, có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Cam-Sơ, nghe nói có sức mạnh cực lớn",},
        [37] = {1001,"Đá Rực Rỡ-Công","Đá cao cấp màu cam, sờ vào rất mát.","Đá cao cấp màu cam, sờ vào rất mát.",},
        [38] = {1002,"Đá Rực Rỡ-Thủ","Đá cao cấp màu cam, sờ vào rất mát.","Đá cao cấp màu cam, sờ vào rất mát.",},
        [39] = {1003,"Đá Rực Rỡ-HP","Đá cao cấp màu cam, sờ vào rất mát.","Đá cao cấp màu cam, sờ vào rất mát.",},
        [40] = {1004,"BK Rực Rỡ","Nuôi dưỡng Quyển Đá Cam-Sơ, có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Cam-Sơ, nghe nói có sức mạnh cực lớn",},
        [41] = {1101,"Đá Hồng Tinh-Công","Đá cao cấp màu đỏ, sờ vào rất mát.","Đá cao cấp màu đỏ, sờ vào rất mát.",},
        [42] = {1102,"Đá Hồng Tinh-Thủ","Đá cao cấp màu đỏ, sờ vào rất mát.","Đá cao cấp màu đỏ, sờ vào rất mát.",},
        [43] = {1103,"Đá Hồng Tinh-HP","Đá cao cấp màu đỏ, sờ vào rất mát.","Đá cao cấp màu đỏ, sờ vào rất mát.",},
        [44] = {1104,"BK Hồng Tinh","Nuôi dưỡng Quyển Đá Đỏ-Sơ, nghe nói có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Đỏ-Sơ, nghe nói có sức mạnh cực lớn",},
        [45] = {1201,"Đá Xích Diệm-Công","Đá cao cấp màu đỏ, sờ vào rất mát.","Đá cao cấp màu đỏ, sờ vào rất mát.",},
        [46] = {1202,"Đá Xích Diệm-Thủ","Đá cao cấp màu đỏ, sờ vào rất mát.","Đá cao cấp màu đỏ, sờ vào rất mát.",},
        [47] = {1203,"Đá Xích Diệm-HP","Đá cao cấp màu đỏ, sờ vào rất mát.","Đá cao cấp màu đỏ, sờ vào rất mát.",},
        [48] = {1204,"BK Xích Diệm","Nuôi dưỡng Quyển Đá Đỏ-Sơ, nghe nói có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Đỏ-Sơ, nghe nói có sức mạnh cực lớn",},
        [49] = {1301,"Đá Huyết Nguyệt-Công","Đá cao cấp màu đỏ, sờ vào rất mát.","Đá cao cấp màu đỏ, sờ vào rất mát.",},
        [50] = {1302,"Đá Huyết Nguyệt-Thủ","Đá cao cấp màu đỏ, sờ vào rất mát.","Đá cao cấp màu đỏ, sờ vào rất mát.",},
        [51] = {1303,"Đá Huyết Nguyệt-HP","Đá cao cấp màu đỏ, sờ vào rất mát.","Đá cao cấp màu đỏ, sờ vào rất mát.",},
        [52] = {1304,"BK Huyết Nguyệt","Nuôi dưỡng Quyển Đá Đỏ-Sơ, nghe nói có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Đỏ-Sơ, nghe nói có sức mạnh cực lớn",},
        [53] = {1401,"Đá Huy Hoàng-Công","Đá cao cấp màu đỏ, sờ vào rất mát.","Đá cao cấp màu đỏ, sờ vào rất mát.",},
        [54] = {1402,"Đá Huy Hoàng-Thủ","Đá cao cấp màu đỏ, sờ vào rất mát.","Đá cao cấp màu đỏ, sờ vào rất mát.",},
        [55] = {1403,"Đá Huy Hoàng-HP","Đá cao cấp màu đỏ, sờ vào rất mát.","Đá cao cấp màu đỏ, sờ vào rất mát.",},
        [56] = {1404,"BK Huy Hoàng","Nuôi dưỡng Quyển Đá Đỏ-Sơ, nghe nói có sức mạnh cực lớn","Nuôi dưỡng Quyển Đá Đỏ-Sơ, nghe nói có sức mạnh cực lớn",},
    }
}

return gemstone