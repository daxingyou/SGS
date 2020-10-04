--head_frame

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  name = 2,    --名称-string 
  limit_level = 3,    --限制等级-int 
  day = 4,    --开服天数-int 
  resource = 5,    --资源-string 
  color = 6,    --品质-int 
  time_type = 7,    --时间类型-int 
  time_value = 8,    --时间类型值-int 
  des = 9,    --条件描述-string 
  moving = 10,    --特效-string 
  is_work = 11,    --是否生效-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  name = "string",    --名称-2 
  limit_level = "int",    --限制等级-3 
  day = "int",    --开服天数-4 
  resource = "string",    --资源-5 
  color = "int",    --品质-6 
  time_type = "int",    --时间类型-7 
  time_value = "int",    --时间类型值-8 
  des = "string",    --条件描述-9 
  moving = "string",    --特效-10 
  is_work = "int",    --是否生效-11 

}


-- data
local head_frame = {
    _data = {
        [1] = {1,"快解锁头像框吧",0,0,"img_head_frame_com001",1,2,0,"","",1,},
        [2] = {2,"情有独钟头像框",0,0,"img_head_frame_com002",2,2,0,"累计签到达到365天获取","",1,},
        [3] = {3,"超群绝伦头像框",0,0,"img_head_frame_com003",2,2,0,"累计参加99次军团boss获取","",1,},
        [4] = {4,"才华横溢头像框",0,0,"img_head_frame_com004",2,2,0,"累计参加50次军团答题获取","",1,},
        [5] = {5,"出类拔萃头像框",0,0,"img_head_frame_com005",2,2,0,"累计参加50次军团试炼获取","",1,},
        [6] = {6,"勇冠三军头像框",0,0,"img_head_frame_com006",2,2,0,"累计参加20次三国战记获取","",1,},
        [7] = {7,"所向披靡头像框",0,0,"img_head_frame_com007",2,2,0,"累计参加20次军团战获取","",1,},
        [8] = {8,"大家风范头像框",0,0,"img_head_frame_vip3",2,2,0,"贵族3专属","",1,},
        [9] = {9,"名门望族头像框",0,0,"img_head_frame_vip7",3,2,0,"贵族7专属","",1,},
        [10] = {10,"侯服玉食头像框",0,0,"img_head_frame_vip12",4,2,0,"贵族12专属","",1,},
        [11] = {11,"佩金带紫头像框",0,0,"",5,2,0,"贵族13专属","effect_vip13touxiang",1,},
        [12] = {12,"玉叶金柯头像框",0,0,"",5,2,0,"贵族14专属","effect_vip14touxiang",1,},
        [13] = {13,"不赀之躯头像框",0,0,"",6,2,0,"贵族15专属","effect_vip15touxiang",1,},
        [14] = {14,"龙血凤髓头像框",0,0,"",7,2,0,"贵族16专属","effect_vip16touxiang",1,},
        [15] = {15,"1周年头像框",0,0,"img_head_frame_com015",3,2,0,"1周年活动限时获取","",1,},
        [16] = {16,"建功立业头像框",0,0,"img_head_frame_1year1",5,2,0,"周年庆活动限时获取","",1,},
        [17] = {17,"丰功伟绩头像框",0,0,"",5,2,0,"周年庆活动限时获取","effect_touxiang_fenzuan",1,},
        [18] = {18,"流芳百世头像框",0,0,"",6,2,0,"周年庆活动限时获取","effect_touxiang_denglong",1,},
        [19] = {19,"结交头像框",0,0,"img_head_frame_golden1",5,2,0,"见龙在田活动限时获取","",1,},
        [20] = {20,"寻隐头像框",0,0,"",5,2,0,"见龙在田活动限时获取","effect_touxiang_xiaolong",1,},
        [21] = {21,"见龙在田头像框",0,0,"img_head_frame_golden3",6,2,0,"见龙在田活动限时获取","effect_touxian_honglong",1,},
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
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [20] = 20,
    [21] = 21,
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
        assert(__key_map[k], "cannot find " .. k .. " in head_frame")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function head_frame.length()
    return #head_frame._data
end

-- 
function head_frame.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function head_frame.indexOf(index)
    if index == nil or not head_frame._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/head_frame.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "head_frame" )
        return setmetatable({_raw = head_frame._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = head_frame._data[index]}, mt)
end

--
function head_frame.get(id)
    
    return head_frame.indexOf(__index_id[id])
        
end

--
function head_frame.set(id, key, value)
    local record = head_frame.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function head_frame.index()
    return __index_id
end

return head_frame