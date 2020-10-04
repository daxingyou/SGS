--city_timeshow

local city_timeshow = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      start_day = 2,    --一年内开始天数-int 
      end_day = 3,    --一年内结束天数-int 
      scene_day = 4,    --白天场景-int 
      scene_night = 5,    --晚上场景-int 
      background = 6,    --登陆图场景-string 
      load = 7,    --登陆图场景-string 
      effect = 8,    --登陆图场景-string 
      is_move = 9,    --是否可移动-int 
      front_x = 10,    --front_x-int 
      middle_x = 11,    --middle_x-int 
      back_x = 12,    --back_x-int 
      front_y = 13,    --front_y-int 
      middle_y = 14,    --middle_y-int 
      back_y = 15,    --back_y-int 
    
    },
    -- data
    _data = {
        [1] = {1,1,30,118,119,"res/ui3/login/img_loginloading6.jpg","res/ui3/login/img_loginloading6.jpg","moving_denglu6",0,50,30,20,50,30,20,},
        [2] = {2,31,44,121,122,"res/ui3/login/login_bg7.jpg","res/ui3/login/img_loginloading7.jpg","moving_denglu7",0,50,30,20,50,30,20,},
        [3] = {3,45,60,106,104,"res/ui3/login/img_loginloading4.jpg","res/ui3/login/img_loginloading4.jpg","moving_denglu4",0,50,30,20,50,30,20,},
        [4] = {4,61,94,106,104,"res/ui3/login/img_loginloading8.jpg","res/ui3/login/img_loginloading8.jpg","moving_denglu8",0,50,30,20,50,30,20,},
        [5] = {5,95,97,106,104,"res/ui3/login/img_loginloading8.jpg","res/ui3/login/img_loginloading8.jpg","moving_denglu8",0,50,30,20,50,30,20,},
        [6] = {6,98,103,123,124,"res/ui3/login/img_loginloading8.jpg","res/ui3/login/img_loginloading8.jpg","moving_denglu8",0,50,30,20,50,30,20,},
        [7] = {7,104,151,110,111,"res/ui3/login/login_bg12.jpg","res/ui3/login/img_loginloading12.jpg","moving_denglu12",0,50,30,20,50,30,20,},
        [8] = {8,152,181,110,111,"res/ui3/login/login_bg12.jpg","res/ui3/login/img_loginloading12.jpg","moving_denglu12",0,50,30,20,50,30,20,},
        [9] = {9,182,212,110,111,"res/ui3/login/login_bg3.png","res/ui3/login/img_loginloading3.jpg","moving_denglu3",0,50,30,20,50,30,20,},
        [10] = {10,213,243,110,111,"res/ui3/login/login_bg3.png","res/ui3/login/img_loginloading3.jpg","moving_denglu3",0,50,30,20,50,30,20,},
        [11] = {11,244,273,112,113,"res/ui3/login/login_bg3.png","res/ui3/login/img_loginloading3.jpg","moving_denglu3",0,50,30,20,50,30,20,},
        [12] = {12,274,304,112,113,"res/ui3/login/login_bg3.png","res/ui3/login/img_loginloading3.jpg","moving_denglu3",0,50,30,20,50,30,20,},
        [13] = {13,305,340,112,113,"res/ui3/login/img_loginloading5.jpg","res/ui3/login/img_loginloading5.jpg","moving_denglu5",0,50,30,20,50,30,20,},
        [14] = {14,341,350,116,117,"res/ui3/login/img_loginloading5.jpg","res/ui3/login/img_loginloading5.jpg","moving_denglu5",0,50,30,20,50,30,20,},
        [15] = {15,351,356,118,119,"res/ui3/login/img_loginloading5.jpg","res/ui3/login/img_loginloading5.jpg","moving_denglu5",0,50,30,20,50,30,20,},
        [16] = {16,357,366,118,119,"res/ui3/login/img_loginloading6.jpg","res/ui3/login/img_loginloading6.jpg","moving_denglu6",0,50,30,20,50,30,20,},
    }
}

return city_timeshow