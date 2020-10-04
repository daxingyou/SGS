--boss_content

local boss_content = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      text = 2,    --相关文本-简中-string 
    
    },
    -- data
    _data = {
        [1] = {1,"主公, 本次挑战军团BOSS, 你所在军团参与人数#number#人, 军团积分排名第#rank#名, 获得军团声望#prestige#, 奖励已发放到拍卖及邮件.",},
        [2] = {2,"主公, 本次挑战军团BOSS, 你个人积分排名第#rank#名, 奖励已发放到邮件(加入军团可获得更多奖励哟!)",},
        [3] = {3,"#name1#成功夺走#name2##integral#积分",},
        [4] = {4,"#name1#被#name2#抢走#integral#积分",},
        [5] = {5,"#name1#挑战世界Boss获得#integral#积分",},
        [6] = {6,"被#name#夺走#integral#积分",},
        [7] = {7,"本次挑战世界Boss获得#integral#积分",},
        [8] = {8,"成功抢夺#name##integral#积分",},
    }
}

return boss_content