--cake_resouce_1

local cake_resouce_1 = {
    -- key
    __key_map = {
      type = 1,    --活动类型_key-int 
      icon_word = 2,    --活动icon文字-string 
      icon_word_script = 3,    --字体-string 
      icon_word_place = 4,    --位置-string 
      icon_word_space = 5,    --行间距-string 
      icon_word_alignment = 6,    --对齐方式-string 
      gain_icon_word = 7,    --获取材料icon文字-string 
      gain_icon_word_script = 8,    --字体-string 
      gain_icon_word_place = 9,    --位置-string 
      gain_icon_word_space = 10,    --行间距-string 
      gain_icon_word_alignment = 11,    --对齐方式-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Đại\nTiệc","2","30,0","","","Nhận\nBơ","3","0,-28","-7","1",},
        [2] = {2,"Đại\nTiệc","2","30,0","","","Nhận\nGầu Bò","3","0,-28","-7","1",},
        [3] = {3,"Đại\nTiệc","2","30,0","","","Nhận\nThịt Bò","3","0,-28","-7","1",},
        [4] = {4,"Đại\nTiệc","2","30,0","","","","3","0,-28","-7","1",},
    },

    -- index
    __index_type = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
    }
}

return cake_resouce_1