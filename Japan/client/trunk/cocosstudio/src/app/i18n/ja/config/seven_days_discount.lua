--seven_days_discount

local seven_days_discount = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --物品名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"装備(青)一式(4点)",},
        [2] = {2,"兵法書指定箱(ｵﾚﾝｼﾞ)",},
        [3] = {3,"特級精錬石x40",},
        [4] = {4,"神器(ｵﾚﾝｼﾞ)(任意選択)+勲功+神器練磨石",},
        [5] = {5,"万能神器(ｵﾚﾝｼﾞ)x5",},
        [6] = {6,"兵符指定箱(ｵﾚﾝｼﾞ)",},
        [7] = {7,"錦袋[関羽]",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
    }
}

return seven_days_discount