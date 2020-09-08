--skin

local skin = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name = 2,    --皮肤名称-string 
      des = 3,    --条件描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"桃華","デフォルト",},
        [2] = {2,"ロマンメイド","親密度7になると獲得できます",},
        [3] = {3,"バニーガール","親密度10になると獲得できます",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return skin