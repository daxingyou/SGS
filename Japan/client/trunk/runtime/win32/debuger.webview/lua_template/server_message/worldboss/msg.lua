local noticePair1 = {
    key = "name",
    value =  "哈哈哈3",
}

local noticePair2 = {
     key = "number",
     value =  "15",
    
}
local message = {
    content = {

    [1] = 
    {   sn_type = 2,
        color = 1,
        user = {
            user_id = 1001,
            name = "哈哈哈3",
            officer_level = 8,
            leader = 1,
        },
        content = {
            [1] = noticePair1,
            [2] = noticePair2,
        },
    },
  }
}

G_UserData:getBulletScreen():_s2cBulletNotice(1,message)
