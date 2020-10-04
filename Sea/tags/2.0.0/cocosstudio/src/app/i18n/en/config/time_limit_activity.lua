--time_limit_activity

local time_limit_activity = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name = 2,    --限时活动名称-string 
      start_des = 3,    --开启描述-string 
      description = 4,    --活动描述-string 
      is_work = 5,    --是否显示-int 
    
    },
    -- data
    _data = {
        [1] = {1,"Legion BOSS","Everyday","Legion BOSS starts at 12:00 and 19:00 everyday. More participants, more rewards.  All the participants will get a share of the profit of Legion Auction.",1,},
        [2] = {2,"Legion Quiz","Everyday","Legion Quiz starts at 18:00 everyday. More participants, more rewards.  All the participants will get a share of the profit of Legion Auction.",1,},
        [3] = {3,"Legion Trial","Everyday","Legion Trial starts at 18:10 and 18:40 everyday. The more Legion Trial Points, the more the rewards. All the participants will get a share of the profit of Legion Auction.",1,},
        [4] = {4,"Three Kingdoms","Every Wed, Fri, Sun","The event opens at 21:00 every Wednesday, Friday and Sunday!",1,},
        [5] = {5,"Faction Campaign","Every Monday, Thursday","Registration starts at 04:00 every Monday and Thursday and event starts at 21:00. More participants, more rewards. All the participants will get a share of the profit of Faction Campaign Auction.",1,},
        [6] = {6,"Huarong Road","Everyday","Huarong Road holds 2 games at 10:00, 14:00, 16:00 and 22:00 everyday. Get rewards if the warrior you support wins the first place.",1,},
        [7] = {7,"Legion War","Every Tue, Sat","Legion War starts at 21:00 every Tuesday and Saturday. Bring it on!",1,},
        [8] = {8,"King's Battle","Everyday","In this fair fight, CP will be ignored and only strategy counts! Enjoy during 11:00-14:00 and 19:00-22:00 everyday!",1,},
        [9] = {9,"Qin's Mausoleum","Everyday","Team up to challenge the Mausoleum 10:00-22:00 everyday and you may get Spring and Autumn and Warring States!",1,},
        [10] = {10,"Faction Campaign","Every Monday","Registration starts at 04:00 every Monday and event starts at 21:00. More participants, more rewards. All participants will get a share of the profit of Faction Campaign Auction and CS INDV Arena Auction.",1,},
        [11] = {11,"Cross-server Legion War","Every Saturday","Legion War starts at 21:00 every Tuesday and Cross-server Legion War starts at 21:00 every Saturday. Legions who have occupied Hulao Pass, Hangu Pass, Jiange and Xiaoyaojin can attend Cross-server Legion War. Other Legions still attend server Legion War.",0,},
        [12] = {12,"CS INDV Arena","Every Thursday","After all the 8 servers of the same group have been opened for 30 days, CS INDV Arena will open every Thursday. More participants, more rewards. All the participants will get a share of the profit of CS INDV Arena Auction.",1,},
        [13] = {13,"Legion Quiz","Every Tue, Thu, Sat","Legion Quiz starts at 18:00 every Tuesday, Thursday and Saturday. More participants, more rewards.  All the participants will get a share of the profit of Legion Auction.",1,},
        [14] = {14,"Global Quiz","Every Mon, Wed, Fri, Sun","Global Quiz starts at 18:00 every Monday, Wednesday and Sunday. More participants, more rewards.  All the participants will get a share of the profit of Legion Auction.",0,},
    }
}

return time_limit_activity