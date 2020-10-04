--boss_content

local boss_content = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      text = 2,    --相关文本-繁体-string 
    
    },
    -- data
    _data = {
        [1] = {1,"主公, 本次挑戰軍團BOSS, 你所在軍團參與人數#number#人, 軍團積分排名第#rank#名, 獲得軍團聲望#prestige#, 獎勵已發放到拍賣及郵件.",},
        [2] = {2,"主公, 本次挑戰軍團BOSS, 你個人積分排名第#rank#名, 獎勵已發放到郵件(加入軍團可獲得更多獎勵喲!)",},
        [3] = {3,"#name1#成功奪走#name2##integral#積分",},
        [4] = {4,"#name1#被#name2#搶走#integral#積分",},
        [5] = {5,"#name1#挑戰世界Boss獲得#integral#積分",},
        [6] = {6,"被#name#奪走#integral#積分",},
        [7] = {7,"本次挑戰世界Boss獲得#integral#積分",},
        [8] = {8,"成功搶奪#name##integral#積分",},
    }
}

return boss_content