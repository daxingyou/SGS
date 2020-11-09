--guild_news

local guild_news = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      news = 2,    --描述-string 
    
    },
    -- data
    _data = {
        [1] = {1," #name#が軍団に加入しました。",},
        [2] = {2," #name# が軍団から除名されました。",},
        [3] = {3," #name#が軍団を脱退しました。",},
        [4] = {4," #name#が#position#に任命されました。",},
        [5] = {5," #name#が#position#から外されました。",},
        [6] = {6," #name#が弾劾されました。",},
        [7] = {7," #name#が#stage#をクリアしました。",},
        [8] = {8," #name#が#id#を行い、軍団が#prestige#の名声を獲得しました。",},
        [9] = {9," #name#が軍団支援を完成し、軍団が#prestige#の名声を獲得しました。",},
        [10] = {10," #name# が #graincar# に献納しました、#graincar#が#num#の経験値を獲得しました。",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [10] = 10,
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

return guild_news