--guild_news

local guild_news = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      news = 2,    --描述-繁体-string 
    
    },
    -- data
    _data = {
        [1] = {1,"#name#加入了軍團.",},
        [2] = {2,"#name#被踢出了軍團.",},
        [3] = {3,"#name#退出了軍團.",},
        [4] = {4,"#name#被任命為新的#position#, 大家為其歡呼.",},
        [5] = {5,"#name#被解除了#position#的職位.",},
        [6] = {6,"#name#由於長時間的不作為, 終於被彈劾了.",},
        [7] = {7,"#name#奮勇作戰, 終於通關了#stage#, 大家快去搶寶庫.",},
        [8] = {8,"#name#慷慨解囊, 進行#id#, 為軍團增加了#prestige#聲望.",},
        [9] = {9,"#name#完成了軍團求援任務, 為軍團增加了#prestige#聲望.",},
    }
}

return guild_news