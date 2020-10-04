--team_target

local team_target = {
    version =  1,
    -- key
    __key_map = {
      target = 1,    --具体目标-int 
      name = 2,    --名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"始皇帝陵・上",},
        [2] = {2,"始皇帝陵・中",},
        [3] = {3,"始皇帝陵・下",},
    },

    -- index
    __index_target = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return team_target