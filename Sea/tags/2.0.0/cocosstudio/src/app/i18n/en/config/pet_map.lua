--pet_map

local pet_map = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --图鉴名称-string 
      show = 3,    --是否显示-int 
      show_day = 4,    --达到开服天数显示-int 
    
    },
    -- data
    _data = {
        [1] = {1,"Spirit Land",1,1,},
        [2] = {2,"Wind and Moon",1,1,},
        [3] = {3,"Water and Fire",1,21,},
        [4] = {4,"Lunar Dance",1,21,},
        [5] = {5,"War Flames",1,21,},
        [6] = {6,"Dragon Fang",1,21,},
        [7] = {7,"Phoenix Singing",1,21,},
        [8] = {8,"Flying Cloud",1,21,},
        [9] = {9,"Thunder Flame",1,10,},
        [10] = {10,"Universe",1,10,},
        [11] = {11,"Moon's Beauty",1,50,},
        [12] = {12,"Lunar Breeze",1,50,},
        [13] = {13,"Red Meteor",1,50,},
        [14] = {14,"Scorching Sun",1,50,},
        [15] = {15,"Breaking Flame",0,999,},
        [16] = {16,"Poyun",0,999,},
        [17] = {17,"Safe Landing",0,999,},
        [18] = {18,"Flame Thunder",0,999,},
    }
}

return pet_map