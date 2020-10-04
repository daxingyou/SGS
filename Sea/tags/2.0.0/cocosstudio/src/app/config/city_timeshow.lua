--city_timeshow

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
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

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  start_day = "int",    --一年内开始天数-2 
  end_day = "int",    --一年内结束天数-3 
  scene_day = "int",    --白天场景-4 
  scene_night = "int",    --晚上场景-5 
  background = "string",    --登陆图场景-6 
  load = "string",    --登陆图场景-7 
  effect = "string",    --登陆图场景-8 
  is_move = "int",    --是否可移动-9 
  front_x = "int",    --front_x-10 
  middle_x = "int",    --middle_x-11 
  back_x = "int",    --back_x-12 
  front_y = "int",    --front_y-13 
  middle_y = "int",    --middle_y-14 
  back_y = "int",    --back_y-15 

}


-- data
local city_timeshow = {
    _data = {
        [1] = {1,1,31,116,117,"res/ui3/login/img_loginloading6.jpg","res/ui3/login/img_loginloading6.jpg","moving_denglu6",0,50,30,20,50,30,20,},
        [2] = {2,32,58,121,122,"res/ui3/login/login_bg7.jpg","res/ui3/login/img_loginloading7.jpg","moving_denglu7",0,50,30,20,50,30,20,},
        [3] = {3,59,90,123,124,"res/ui3/login/img_loginloading8.jpg","res/ui3/login/img_loginloading8.jpg","moving_denglu8",0,50,30,20,50,30,20,},
        [4] = {4,91,94,123,124,"res/ui3/login/login_bg9.jpg","res/ui3/login/img_loginloading9.jpg","moving_denglu9",0,50,30,20,50,30,20,},
        [5] = {5,95,97,123,124,"res/ui3/login/login_bg9.jpg","res/ui3/login/img_loginloading9.jpg","moving_denglu9_2",0,50,30,20,50,30,20,},
        [6] = {6,98,120,123,124,"res/ui3/login/login_bg9.jpg","res/ui3/login/img_loginloading9.jpg","moving_denglu9",0,50,30,20,50,30,20,},
        [7] = {7,121,156,106,104,"res/ui3/login/login_bg10.jpg","res/ui3/login/img_loginloading10.jpg","moving_denglu10",0,50,30,20,50,30,20,},
        [8] = {8,157,181,106,104,"res/ui3/login/login_bg10.jpg","res/ui3/login/img_loginloading10.jpg","moving_denglu10",0,50,30,20,50,30,20,},
        [9] = {9,182,212,106,104,"res/ui3/login/login_bg10.jpg","res/ui3/login/img_loginloading10.jpg","moving_denglu10",0,50,30,20,50,30,20,},
        [10] = {10,213,243,110,111,"res/ui3/login/login_bg3.png","res/ui3/login/img_loginloading3.jpg","moving_denglu3",0,50,30,20,50,30,20,},
        [11] = {11,244,273,112,113,"res/ui3/login/login_bg3.png","res/ui3/login/img_loginloading3.jpg","moving_denglu3",0,50,30,20,50,30,20,},
        [12] = {12,274,304,112,113,"res/ui3/login/login_bg3.png","res/ui3/login/img_loginloading3.jpg","moving_denglu3",0,50,30,20,50,30,20,},
        [13] = {13,305,340,112,113,"res/ui3/login/img_loginloading5.jpg","res/ui3/login/img_loginloading5.jpg","moving_denglu5",0,50,30,20,50,30,20,},
        [14] = {14,341,350,116,117,"res/ui3/login/img_loginloading5.jpg","res/ui3/login/img_loginloading5.jpg","moving_denglu5",0,50,30,20,50,30,20,},
        [15] = {15,351,356,118,119,"res/ui3/login/img_loginloading5.jpg","res/ui3/login/img_loginloading5.jpg","moving_denglu5",0,50,30,20,50,30,20,},
        [16] = {16,357,366,118,119,"res/ui3/login/img_loginloading6.jpg","res/ui3/login/img_loginloading6.jpg","moving_denglu6",0,50,30,20,50,30,20,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in city_timeshow")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function city_timeshow.length()
    return #city_timeshow._data
end

-- 
function city_timeshow.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function city_timeshow.indexOf(index)
    if index == nil or not city_timeshow._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/city_timeshow.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "city_timeshow" )
        return setmetatable({_raw = city_timeshow._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = city_timeshow._data[index]}, mt)
end

--
function city_timeshow.get(id)
    
    return city_timeshow.indexOf(__index_id[id])
        
end

--
function city_timeshow.set(id, key, value)
    local record = city_timeshow.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function city_timeshow.index()
    return __index_id
end

return city_timeshow