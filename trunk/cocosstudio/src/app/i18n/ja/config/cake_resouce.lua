--cake_resouce

local cake_resouce = {
    version =  1,
    -- key
    __key_map = {
      type = 1,    --活动类型-int 
      type_name = 2,    --盛宴吃的啥-string 
      cake_name1 = 3,    --页签一名称-string 
      cake_name2 = 4,    --页签二名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"ケーキ","卵入手","クリーム入手",},
        [2] = {2,"火鍋","椎茸入手","薄切り牛肉入手",},
        [3] = {3,"焼肉","野菜入手","牛肉入手",},
        [4] = {4,"おせち","富に満ちる","生財の計",},
    },

    -- index
    __index_type = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
    }
}

return cake_resouce