--seven_day_sprint

local seven_day_sprint = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --id-int 
      activity_content_text = 2,    --活动内容文本-string 
      name = 3,    --活动名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"主君各位の辺境開拓を奨励するため、サーバー開放#num#日目に百大軍団を選出してそれぞれ報酬をお送りします。軍団イベントに多く参加するほど、軍団ランキングは高くなります！","百大軍団",},
    },

    -- index
    __index_id = {
        [1] = 1,
    }
}

return seven_day_sprint