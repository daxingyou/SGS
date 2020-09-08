--main_scene

local main_scene = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      description = 2,    --获取途径-string 
      name = 3,    --背景名-string 
    
    },
    -- data
    _data = {
        [1] = {2,"チャージで獲得","春",},
        [2] = {3,"デフォルト","デフォルト",},
    },

    -- index
    __index_id = {
        [2] = 1,
        [3] = 2,
    }
}

return main_scene