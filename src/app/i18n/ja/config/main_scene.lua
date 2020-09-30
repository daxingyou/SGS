--main_scene

local main_scene = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      description = 2,    --获取途径-string 
      name = 3,    --背景名-string 
      description_1 = 4,    --描述-string 
    
    },
    -- data
    _data = {
        [1] = {2,"チャージで獲得","春","すでに獲得済みの背景は背景交換票に変換される",},
        [2] = {3,"デフォルト","デフォルト","すでに獲得済みの背景は背景交換票に変換される",},
    },

    -- index
    __index_id = {
        [2] = 1,
        [3] = 2,
    }
}

return main_scene