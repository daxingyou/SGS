--hero_limit_cost

local hero_limit_cost = {
    -- key
    __key_map = {
      limit_level = 1,    --界限等级_math-int 
      name_6 = 2,    --材料6名称-string 
      name_1 = 3,    --材料1名称-string 
      name_2 = 4,    --材料2名称-string 
      name_3 = 5,    --材料3名称-string 
      name_4 = 6,    --材料4名称-string 
      break_name = 7,    --突破消耗名称-string 
      special_name = 8,    --特殊材料名称-string 
    
    },
    -- data
    _data = {
        [1] = {0,"","Luận Ngữ","Tả Truyện","Xuân Thu","Chiến Quốc","Bạc","",},
        [2] = {1,"","Luận Ngữ","Tả Truyện","Xuân Thu","Chiến Quốc","Bạc","",},
        [3] = {2,"","Luận Ngữ","Tả Truyện","Xuân Thu","Chiến Quốc","Bạc","",},
        [4] = {3,"","Luận Ngữ","Tả Truyện","Xuân Thu","Chiến Quốc","Bạc","",},
        [5] = {0,"Địa Sát","Luận Ngữ","Tả Truyện","Lễ Ký","Chu Dịch","Bạc","Thiên Canh",},
        [6] = {1,"Địa Sát","Luận Ngữ","Tả Truyện","Lễ Ký","Chu Dịch","Bạc","Thiên Canh",},
        [7] = {2,"Địa Sát","Luận Ngữ","Tả Truyện","Lễ Ký","Chu Dịch","Bạc","Thiên Canh",},
        [8] = {3,"Địa Sát","Luận Ngữ","Tả Truyện","Lễ Ký","Chu Dịch","Bạc","Thiên Canh",},
        [9] = {4,"Địa Sát","Luận Ngữ","Tả Truyện","Lễ Ký","Chu Dịch","Bạc","Thiên Canh",},
        [10] = {0,"Địa Sát","Luận Ngữ","Tả Truyện","Lễ Ký","Chu Dịch","Bạc","Thiên Canh",},
        [11] = {1,"Địa Sát","Luận Ngữ","Tả Truyện","Lễ Ký","Chu Dịch","Bạc","Thiên Canh",},
        [12] = {2,"Địa Sát","Luận Ngữ","Tả Truyện","Lễ Ký","Chu Dịch","Bạc","Thiên Canh",},
        [13] = {3,"Địa Sát","Luận Ngữ","Tả Truyện","Lễ Ký","Chu Dịch","Bạc","Thiên Canh",},
        [14] = {4,"Địa Sát","Luận Ngữ","Tả Truyện","Lễ Ký","Chu Dịch","Bạc","Thiên Canh",},
    },

    -- index
    __index_limit_level_limit_level_red = {
        ["0_0"] = 1,
        ["0_1"] = 5,
        ["0_2"] = 10,
        ["1_0"] = 2,
        ["1_1"] = 6,
        ["1_2"] = 11,
        ["2_0"] = 3,
        ["2_1"] = 7,
        ["2_2"] = 12,
        ["3_0"] = 4,
        ["3_1"] = 8,
        ["3_2"] = 13,
        ["4_1"] = 9,
        ["4_2"] = 14,
    }
}

return hero_limit_cost