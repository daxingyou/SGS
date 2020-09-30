--official_rank

local official_rank = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --晋升名称-string 
      text_1 = 3,    --主界面提示文本-string 
      text_2 = 4,    --晋升提示文本-string 
    
    },
    -- data
    _data = {
        [1] = {0,"Dân","Bổ sung duyên phận nhân vật: Phòng Thủ-Trung-Tăng Phòng Thủ +70%","Bổ sung duyên phận nhân vật: Phòng Thủ-Trung-Tăng Phòng Thủ +70%",},
        [2] = {1,"Hộ Quân","","",},
        [3] = {2,"Tư Mã","Bổ sung duyên phận nhân vật: Sinh Lực-Hạ-Tăng Sinh Lực +80%","Bổ sung duyên phận nhân vật: Sinh Lực-Hạ-Tăng Sinh Lực +80%",},
        [4] = {3,"Đô Úy","","",},
        [5] = {4,"Hiệu Úy","","",},
        [6] = {5,"Thái Thú","","",},
        [7] = {6,"Thích Sử","Bổ sung duyên phận nhân vật: Tấn Công-Hạ-Tăng Tấn Công +70%","Bổ sung duyên phận nhân vật: Tấn Công-Hạ-Tăng Tấn Công +70%",},
        [8] = {7,"Trung Lang","","",},
        [9] = {8,"Kinh Doãn","","",},
        [10] = {9,"Thượng Thư","","",},
        [11] = {10,"Vệ Tướng ","Bổ sung duyên phận Tướng Vàng cho nhân vật","Bổ sung duyên phận Tướng Vàng cho nhân vật",},
        [12] = {11,"Đô Đốc","","",},
        [13] = {12,"Tướng Soái","","",},
        [14] = {13,"Đại Tư Không","","",},
        [15] = {14,"Đại Tư Đồ","","",},
        [16] = {15,"Đại Tư Mã","","",},
        [17] = {16,"Thái Úy","","",},
    },

    -- index
    __index_id = {
        [0] = 1,
        [1] = 2,
        [10] = 11,
        [11] = 12,
        [12] = 13,
        [13] = 14,
        [14] = 15,
        [15] = 16,
        [16] = 17,
        [2] = 3,
        [3] = 4,
        [4] = 5,
        [5] = 6,
        [6] = 7,
        [7] = 8,
        [8] = 9,
        [9] = 10,
    }
}

return official_rank