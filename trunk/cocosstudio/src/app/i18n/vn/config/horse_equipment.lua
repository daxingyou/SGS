--horse_equipment

local horse_equipment = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name = 2,    --装备名称-string 
      description = 3,    --装备描述-string 
    
    },
    -- data
    _data = {
        [1] = {101,"Bạch Ngọc Yên","Yên ngựa làm bằng ngọc, rất quý.",},
        [2] = {102,"Tử Kim Đăng","Bàn đạp khảm ngọc quý.",},
        [3] = {103,"Dây Cương Bạc","Dây cương làm bằng chất liệu quý hiếm.",},
        [4] = {201,"Bích Giao Yên","Nghe nói ẩn chứa linh hồn giao long, giúp chủ nhân chiến đấu.",},
        [5] = {202,"Thương Lang Đăng","Bàn đạp có linh hồn sói chúc phúc, bảo vệ chủ nhân.",},
        [6] = {203,"Đằng Xà Cương","Dây cương còn vương sức sống của đằng xà, rất khó tìm.",},
    },

    -- index
    __index_id = {
        [101] = 1,
        [102] = 2,
        [103] = 3,
        [201] = 4,
        [202] = 5,
        [203] = 6,
    }
}

return horse_equipment