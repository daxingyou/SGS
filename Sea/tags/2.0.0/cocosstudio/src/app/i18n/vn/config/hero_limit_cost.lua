--hero_limit_cost

local hero_limit_cost = {
    -- key
    __key_map = {
      limit_level = 1,    --界限等级_key-int 
      name_1 = 2,    --材料1名称-越南语-string 
      name_2 = 3,    --材料2名称-越南语-string 
      name_3 = 4,    --材料3名称-越南语-string 
      name_4 = 5,    --材料4名称-越南语-string 
      break_name = 6,    --突破消耗名称-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {0,"Luận Ngữ","Tả Truyện","Xuân Thu","Chiến Quốc","Bạc",},
        [2] = {1,"Luận Ngữ","Tả Truyện","Xuân Thu","Chiến Quốc","Bạc",},
        [3] = {2,"Luận Ngữ","Tả Truyện","Xuân Thu","Chiến Quốc","Bạc",},
        [4] = {3,"Luận Ngữ","Tả Truyện","Xuân Thu","Chiến Quốc","Bạc",},
    }
}

return hero_limit_cost