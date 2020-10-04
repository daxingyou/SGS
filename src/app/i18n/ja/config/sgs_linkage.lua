--sgs_linkage

local sgs_linkage = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --账号-int 
      mission_description = 2,    --说明-string 
      reward_name = 3,    --奖励名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Lv#num#になりました","銀貨",},
        [2] = {2,"Lv#num#になりました","練磨丹",},
        [3] = {3,"Lv#num#になりました","雁羽の鎧",},
        [4] = {4,"初チャージ完了。","ハッピービーン",},
        [5] = {5,"チャージ累計#num#元","召喚令",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
    }
}

return sgs_linkage