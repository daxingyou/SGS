--notification

local notification = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      time_txt = 2,    --标题-英语-string 
      chat_before = 3,    --文本-英语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Lunch begins","Dear lords, Lunch has begun. Go participate in Lunch and replenish plenty of Stamina!",},
        [2] = {2,"Dinner begins","Dear lords, Dinner has begun. Go participate in Lunch and replenish plenty of Stamina!",},
        [3] = {3,"Supper begins","Dear lords, Supper has begun. Go participate in Lunch and replenish plenty of Stamina!",},
        [4] = {4,"Legion BOSS appears","Legion BOSS will appear in 5 minutes. Challenge the Boss and kill it can participate in Auction and dividend!",},
        [5] = {5,"Legion BOSS appears","Legion BOSS will appear in 5 minutes. Challenge the Boss and kill it can participate in Auction and dividend!",},
        [6] = {6,"每日早上礼物","各位主公, 快点登陆领取您的早上礼物吧~~~",},
        [7] = {7,"Three Kingdoms battle begins","Three Kingdoms will begin in 5 minutes. Challenge the Boss and kill it can participate in Auction and dividend!",},
        [8] = {8,"Faction Campaign battle begins","Faction Campaign will begin in 5 minutes. Who will be the king of faction. Go compete for the throne!",},
        [9] = {9,"Legion War is on the verge","Legion War will begin in 5 minutes. It's time to occupy the city and be the best Legion!",},
    }
}

return notification