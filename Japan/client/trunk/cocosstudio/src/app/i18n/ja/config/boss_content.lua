--boss_content

local boss_content = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      text = 2,    --相关文本-string 
    
    },
    -- data
    _data = {
        [1] = {1,"今回の軍団ボス挑戦で、主君の所属軍団は参加人数が#number#人、軍団ポイントランキングで#rank#位に入り、軍団名声#prestige#を獲得しました。報酬はオークション及びメールで支給済みです。",},
        [2] = {2,"今回の軍団ボス挑戦で、主君は個人ポイントランキングの#rank#位となり、報酬がメールで支給されました。(軍団に加入すると、もっと報酬を獲得できますよ！)",},
        [3] = {3,"#name1#が#name2#から#integral#ポイントを奪いました！",},
        [4] = {4,"#name1#が#name2#に#integral#pt奪われました",},
        [5] = {5,"#name1#は軍団ボスに挑戦して#integral#ポイントを獲得",},
        [6] = {6,"#name#に#integral#ポイント奪われました",},
        [7] = {7,"今回の軍団ボス挑戦で#integral#ptを獲得しました",},
        [8] = {8,"#name##integral#pt奪取に成功",},
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
        [8] = 8,
    }
}

return boss_content