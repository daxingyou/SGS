--tree_info

local tree_info = {
    version =  1,
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
        [1] = {1,"神樹","願いの泉","突破で開放される新装飾: 願いの泉","",},
        [2] = {2,"神樹","万年の茸","突破で開放される新装飾: 万年の茸","",},
        [3] = {3,"神樹","翠竹林","突破で開放される新装飾: 翠竹林","",},
        [4] = {4,"神樹","幻の瑶池","突破後、1日3回まで神樹祈祷が可能\n突破で開放される新装飾: 幻の瑶池","",},
        [5] = {5,"神樹","珠玉の塔","突破で開放される新装飾: 珠玉の塔","(1日3回まで祈祷可)",},
        [6] = {6,"神樹","九華灯","突破後、1日5回まで神樹祈祷が可能\n突破で開放される新装飾: 九華灯","(臥龍の占星盤はLv120になると商店で購入可能)",},
        [7] = {7,"神樹","","","(1日5回まで祈祷可)",},
        [8] = {8,"神樹","","","",},
        [9] = {9,"神樹","","","",},
        [10] = {10,"神樹","","","",},
        [11] = {11,"神樹","","","",},
        [12] = {12,"神樹","","","",},
        [13] = {13,"神樹","","","",},
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