--guild_news

local guild_news = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      news = 2,    --描述-英语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"#name# joined the Legion.",},
        [2] = {2,"#name# is kicked out of the Legion.",},
        [3] = {3,"#name# withdrew from the Legion.",},
        [4] = {4,"#name# is appointed to be the new #position#. Applause.",},
        [5] = {5,"#name# is fired as #position#.",},
        [6] = {6,"#name# is finally impeached after a long period of nonfeasance.",},
        [7] = {7,"#name# battled bravely and finally cleared #stage#. Go rob Treasury.",},
        [8] = {8,"#name# generously lent a helping hand, carried out #id# and increased Legion Fame by #prestige#.",},
        [9] = {9,"#name# completed Legion Request for Help and increased Legion Fame by #prestige#.",},
    }
}

return guild_news