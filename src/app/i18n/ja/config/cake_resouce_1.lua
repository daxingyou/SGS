--cake_resouce_1

local cake_resouce_1 = {
    version =  1,
    -- key
    __key_map = {
      type = 1,    --活动类型-int 
      icon_word = 2,    --活动icon文字-string 
      gain_icon_word = 3,    --获取材料icon文字-string 
    
    },
    -- data
    _data = {
        [1] = {1,"饗宴の宴","クリーム獲得",},
        [2] = {2,"饗宴の宴","薄切り牛肉入手",},
        [3] = {3,"饗宴の宴","牛肉獲得",},
        [4] = {4,"饗宴の宴","生財の計",},
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