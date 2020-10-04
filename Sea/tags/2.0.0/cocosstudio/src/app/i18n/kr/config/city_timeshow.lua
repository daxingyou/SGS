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
    
    },
    -- data
    _data = {
        [1] = {1,1,31,116,117,"res/ui3/login/img_loginloading6.jpg","res/ui3/login/img_loginloading6.jpg","moving_denglu6",},
        [2] = {2,32,58,121,122,"res/ui3/login/login_bg7.jpg","res/ui3/login/img_loginloading7.jpg","moving_denglu7",},
        [3] = {3,59,90,123,124,"res/ui3/login/img_loginloading8.jpg","res/ui3/login/img_loginloading8.jpg","moving_denglu8",},
        [4] = {4,91,94,123,124,"res/ui3/login/login_bg9.jpg","res/ui3/login/img_loginloading9.jpg","moving_denglu9",},
        [5] = {5,95,97,123,124,"res/ui3/login/login_bg9.jpg","res/ui3/login/img_loginloading9.jpg","moving_denglu9_2",},
        [6] = {6,98,120,123,124,"res/ui3/login/login_bg9.jpg","res/ui3/login/img_loginloading9.jpg","moving_denglu9",},
        [7] = {7,121,156,106,104,"res/ui3/login/login_bg10.jpg","res/ui3/login/img_loginloading10.jpg","moving_denglu10",},
        [8] = {8,157,181,106,104,"res/ui3/login/login_bg10.jpg","res/ui3/login/img_loginloading10.jpg","moving_denglu10",},
        [9] = {9,182,212,106,104,"res/ui3/login/login_bg10.jpg","res/ui3/login/img_loginloading10.jpg","moving_denglu10",},
        [10] = {10,213,243,110,111,"res/ui3/login/login_bg3.png","res/ui3/login/img_loginloading3.jpg","moving_denglu3",},
        [11] = {11,244,273,112,113,"res/ui3/login/login_bg3.png","res/ui3/login/img_loginloading3.jpg","moving_denglu3",},
        [12] = {12,274,304,112,113,"res/ui3/login/login_bg3.png","res/ui3/login/img_loginloading3.jpg","moving_denglu3",},
        [13] = {13,305,340,112,113,"res/ui3/login/img_loginloading5.jpg","res/ui3/login/img_loginloading5.jpg","moving_denglu5",},
        [14] = {14,341,350,116,117,"res/ui3/login/img_loginloading5.jpg","res/ui3/login/img_loginloading5.jpg","moving_denglu5",},
        [15] = {15,351,356,118,119,"res/ui3/login/img_loginloading5.jpg","res/ui3/login/img_loginloading5.jpg","moving_denglu5",},
        [16] = {16,357,366,118,119,"res/ui3/login/img_loginloading6.jpg","res/ui3/login/img_loginloading6.jpg","moving_denglu6",},
    }
}

return city_timeshow