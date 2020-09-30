--tree_info

local tree_info = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --主树名称-string 
      up_text = 3,    --升级提示文本-string 
      up_text_1 = 4,    --升级界面提示文本-string 
      breaktext = 5,    --突破预览文本-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Cây Thần","Lộ Đàn","Đột phá mở: Lộ Đàn","",},
        [2] = {2,"Cây Thần","Linh Chi","Đột phá mở: Linh Chi","",},
        [3] = {3,"Cây Thần","Trúc Lâm","Đột phá mở: Trúc Lâm","",},
        [4] = {4,"Cây Thần","Dao Trì","Sau khi đột phá được cầu phúc 3 lần\nVật trang trí mới: Dao Trì","",},
        [5] = {5,"Cây Thần","Linh Lung","Đột phá mở: Linh Lung"," (Mỗi ngày được Cầu Phúc 3 lần)",},
        [6] = {6,"Cây Thần","Hoa Đăng","Sau khi đột phá được cầu phúc 5 lần\nVật trang trí mới:  Hoa Đăng","(Lv120 có thể vào Tiệm mua Chiêm Tinh Bồn)",},
        [7] = {7,"Cây Thần","",""," (Mỗi ngày được Cầu Phúc 5 lần)",},
        [8] = {8,"Cây Thần","","","",},
        [9] = {9,"Cây Thần","","","",},
        [10] = {10,"Cây Thần","","","",},
        [11] = {11,"Cây Thần","","","",},
        [12] = {12,"Cây Thần","","","",},
        [13] = {13,"Cây Thần","","","",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [10] = 10,
        [11] = 11,
        [12] = 12,
        [13] = 13,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
        [9] = 9,
    }
}

return tree_info