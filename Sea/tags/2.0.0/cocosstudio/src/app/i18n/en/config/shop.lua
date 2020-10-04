--shop

local shop = {
    -- key
    __key_map = {
      shop_id = 1,    --商店ID-int 
      shop_name = 2,    --商店名称-string 
      tab_name1 = 3,    --页签名称-string 
      tab_name2 = 4,    --页签名称-string 
      tab_name3 = 5,    --页签名称-string 
      tab_name4 = 6,    --页签名称-string 
      tab_name5 = 7,    --页签名称-string 
      price4_type = 8,    --商店代币类型4-int 
      price4_value = 9,    --代币4-int 
    
    },
    -- data
    _data = {
        [1] = {1,"Shop","Item","Goods","","","",0,0,},
        [2] = {2,"Gear","Item","Epic\nGear","Legendary\nGear","Reward","",0,0,},
        [3] = {3,"Artifact","Item","","","","",0,0,},
        [4] = {4,"Arena","Item","Warrior","Reward","","",0,0,},
        [5] = {5,"Legion","Item","Wei","Shu","Wu","Han",0,0,},
        [6] = {6,"Warrior","Warrior","","","","",0,0,},
        [7] = {7,"Treasure","Item","Epic\nTreasure","Legendary\nTreasure","","",0,0,},
        [8] = {8,"Awakening","Item","","","","",0,0,},
        [9] = {9,"Daily Offer","","","","","",0,0,},
        [10] = {10,"Weekly Offer","","","","","",0,0,},
        [11] = {11,"Pet","","","","","",0,0,},
        [12] = {12,"Supplies 50% Off","","","","","",0,0,},
        [13] = {13,"Avatar Shop","Wei","Shu","Wu","Han","",6,147,},
        [14] = {14,"Set Shop","","","","","",0,0,},
        [15] = {15,"Pet","Item","","","","",0,0,},
        [16] = {16,"Awakening","Item","Rare","Epic","Legendary","Divine",0,0,},
        [17] = {17,"Stargazing Shop","","","","","",0,0,},
        [18] = {18,"War\x01Horse","War\x01Horse","Harness","","","",0,0,},
        [19] = {19,"King Shop","","","","","",0,0,},
        [20] = {20,"Rough Stone","Rough Stone","","","","",0,0,},
        [21] = {21,"Horse Training Shop","","","","","",0,0,},
        [22] = {22,"Anniversary Shop","1st\x01Day","2nd\x01Day","3rd\x01Day","Ingot","",0,0,},
        [23] = {24,"Ultimate Warrior Shop","Ultimate\nWarrior","Purchase\nLimit","Resources","","",0,0,},
    }
}

return shop