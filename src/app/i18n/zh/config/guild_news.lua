--guild_news

local guild_news = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      news = 2,    --描述-简中-string 
    
    },
    -- data
    _data = {
        [1] = {1,"#name#加入了军团.",},
        [2] = {2,"#name#被踢出了军团.",},
        [3] = {3,"#name#退出了军团.",},
        [4] = {4,"#name#被任命为新的#position#, 大家为其欢呼.",},
        [5] = {5,"#name#被解除了#position#的职位.",},
        [6] = {6,"#name#由于长时间的不作为, 终于被弹劾了.",},
        [7] = {7,"#name#奋勇作战, 终于通关了#stage#, 大家快去抢宝库.",},
        [8] = {8,"#name#慷慨解囊, 进行#id#, 为军团增加了#prestige#声望.",},
        [9] = {9,"#name#完成了军团求援任务, 为军团增加了#prestige#声望.",},
    }
}

return guild_news