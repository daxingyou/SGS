--guild_news

local guild_news = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      news = 2,    --描述-韩语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"#name#님 군단가입",},
        [2] = {2,"#name#님 군단추방",},
        [3] = {3,"#name#님 군단탈퇴",},
        [4] = {4,"#name#님 새로운 #position#에 임명 ",},
        [5] = {5,"#name#님 #position# 직위해제",},
        [6] = {6,"#name#님 장기간 직무유기로 탄핵",},
        [7] = {7,"#name#님이 열심히 싸워 #stage# 돌파",},
        [8] = {8,"#name#님이 #id# 진행, #prestige#군단명성 상승",},
        [9] = {9,"#name#님이 도움, #prestige#군단명성 상승",},
    }
}

return guild_news