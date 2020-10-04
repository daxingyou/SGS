--mine_event

local mine_event = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      count_down_title = 2,    --倒计时标题-string 
      count_down_txt = 3,    --倒计时说明-string 
    
    },
    -- data
    _data = {
        [1] = {1,"外縁鉱区開放まで: ","普通鉱区では交戦できません",},
        [2] = {2,"特級鉱山開放まで: ","特級鉱山では敵軍を殲滅して、占拠することができます",},
        [3] = {3,"最上級鉱区の開放まで: ","最上級鉱山の争奪で最大の収益を獲得",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return mine_event