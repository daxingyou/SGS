--boss_content

local boss_content = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      text = 2,    --相关文本-英语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"My lord, #number# people in your Legion have taken part in the challenge of Legion BOSS. Legion points ranking is #rank#. Your Legion has obtained #prestige# Legion Fame. The reward has sent to Auction and Mail.",},
        [2] = {2,"My lord, your personal points ranking is #rank# in this Legion BOSS. The reward has been sent to Mail. (Join a legion and you will obtain more reward!)",},
        [3] = {3,"#name1# has taken away #name2#'s #integral# points",},
        [4] = {4,"#name1# was taken away #integral# points by #name2#",},
        [5] = {5,"#name1# has obtained #integral# points from challenging World Boss.",},
        [6] = {6,"#name#has taken away #integral#points from you.",},
        [7] = {7,"You have obtained #integral# points from challenging World Boss.",},
        [8] = {8,"You have grabbed #integral# points from #name#.",},
    }
}

return boss_content