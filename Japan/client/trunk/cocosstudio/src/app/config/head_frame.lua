--head_frame

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

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
  priority = 12,    --优先级-int 

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
  priority = "int",    --优先级-12 

}


-- data
local head_frame = {
    version =  1,
    _data = {
        [1] = {1,"快解锁头像框吧",0,0,"img_head_frame_com001",1,2,0,"","",1,255,},
        [2] = {2,"春天的嫩芽",0,0,"img_head_frame_com002",2,2,0,"累计签到达到2天获取","",1,254,},
        [3] = {3,"霸气咆哮",0,0,"img_head_frame_com003",2,2,0,"累计参加20次军团boss获取","effect_touxiangkuang_feilong",1,252,},
        [4] = {4,"百鬼夜行",0,0,"img_head_frame_com004",2,2,0,"累计参加15次军团答题获取","effect_touxiangkuang_mianju",1,252,},
        [5] = {5,"鲜血契约",0,0,"img_head_frame_com005",2,2,0,"累计参加20次军团试炼获取","effect_touxiangkuang_kuijia",1,252,},
        [6] = {6,"阿修罗",0,0,"img_head_frame_com006",2,2,0,"累计参加10次三国战记获取","effect_touxiangkuang_huoyankuang",1,252,},
        [7] = {7,"刀刃即心脏",0,0,"img_head_frame_com007",2,2,0,"累计参加10次军团战获取","effect_touxiangkuang_dadao",1,252,},
        [8] = {8,"红叶与黄月",0,0,"img_head_frame_vip3",2,2,0,"贵族3专属","effect_touxiangkuang_yuetu",1,251,},
        [9] = {9,"苍天鲤路",0,0,"img_head_frame_vip6",3,2,0,"贵族6专属","effect_touxiangkuang_yuhuanshui",1,250,},
        [10] = {10,"我的女神",0,0,"img_head_frame_vip9",4,2,0,"贵族9专属","effect_touxiangkuang_shengshe",1,249,},
        [11] = {11,"佩金带紫头像框",0,0,"",5,2,0,"贵族13专属","effect_vip13touxiang",0,100,},
        [12] = {12,"玉叶金柯头像框",0,0,"",5,2,0,"贵族14专属","effect_vip14touxiang",0,100,},
        [13] = {13,"不赀之躯头像框",0,0,"",6,2,0,"贵族15专属","effect_vip15touxiang",0,100,},
        [14] = {14,"龙血凤髓头像框",0,0,"",7,2,0,"贵族16专属","effect_vip16touxiang",0,100,},
        [15] = {15,"1周年头像框",0,0,"img_head_frame_com015",3,2,0,"1周年活动限时获取","",0,100,},
        [16] = {16,"建功立业头像框",0,0,"img_head_frame_1year1",5,2,0,"周年庆活动限时获取","",0,100,},
        [17] = {17,"丰功伟绩头像框",0,0,"",5,2,0,"周年庆活动限时获取","effect_touxiang_fenzuan",0,100,},
        [18] = {18,"流芳百世头像框",0,0,"",6,2,0,"周年庆活动限时获取","effect_touxiang_denglong",0,100,},
        [19] = {19,"结交头像框",0,0,"img_head_frame_golden1",5,2,0,"见龙在田活动限时获取","",0,100,},
        [20] = {20,"寻隐头像框",0,0,"",5,2,0,"见龙在田活动限时获取","effect_touxiang_xiaolong",0,100,},
        [21] = {21,"见龙在田头像框",0,0,"img_head_frame_golden3",6,2,0,"见龙在田活动限时获取","effect_touxian_honglong",0,100,},
        [22] = {22,"文期酒会头像框",0,0,"img_head_frame_1banquet1",5,2,0,"饕餮盛宴活动限时获取","",0,100,},
        [23] = {23,"诗酒风流头像框",0,0,"",5,2,0,"饕餮盛宴活动限时获取","effect_touxiang_jiubei",0,100,},
        [24] = {24,"对酒当歌头像框",0,0,"",6,2,0,"饕餮盛宴活动限时获取","effect_touxiang_jiubeiduipeng",0,100,},
        [25] = {25,"七夕头像框",0,0,"img_head_frame_f0707",3,2,0,"七夕活动限时获取","",0,100,},
        [26] = {26,"中秋头像框",0,0,"img_head_frame_f0815",3,1,30,"中秋活动限时获取","",0,100,},
        [27] = {27,"庆典头像框",0,0,"img_head_frame_f1001",3,1,30,"节日庆典限时获取","",0,100,},
        [28] = {28,"五福临门头像框",0,0,"img_head_frame_2banquet1",5,2,0,"饕餮盛宴活动限时获取","effect_touxiang_shunian",0,100,},
        [29] = {29,"福星高照头像框",0,0,"img_head_frame_2banquet2",6,2,0,"饕餮盛宴活动限时获取","effect_touxiang_wushi",0,100,},
        [30] = {1000,"白银之彩",0,0,"img_head_frame_com002_1",2,2,0,"累计签到达到7天获取","",1,253,},
        [31] = {1001,"夏天的气息",0,0,"img_head_frame_yaoqing",2,2,0,"邀请的好友1名战力达到500万","",1,252,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [1000] = 30,
    [1001] = 31,
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
    [22] = 22,
    [23] = 23,
    [24] = 24,
    [25] = 25,
    [26] = 26,
    [27] = 27,
    [28] = 28,
    [29] = 29,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [10] = 10,
    [30] = 1000,
    [31] = 1001,
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
    [22] = 22,
    [23] = 23,
    [24] = 24,
    [25] = 25,
    [26] = 26,
    [27] = 27,
    [28] = 28,
    [29] = 29,
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
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in head_frame")
        if _lang ~= "cn" and _isDataExist  and t._data_key_map[k] then
            return t._data[t._data_key_map[k]]
        end
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[key_map[k]]
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
function head_frame.isVersionValid(v)
    if head_frame.version then
        if v then
            return head_frame.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function head_frame.indexOf(index)
    if index == nil or not head_frame._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/head_frame.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/head_frame.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/head_frame.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "head_frame" )
                _isDataExist = head_frame.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "head_frame" )
                _isBaseExist = head_frame.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "head_frame" )
                _isExist = head_frame.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "head_frame" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "head_frame" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = head_frame._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "head_frame" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function head_frame.get(id)
    
    return head_frame.indexOf(__index_id[id])
        
end

--
function head_frame.set(id, key, value)
    local record = head_frame.get(id)
    if record then
        if _lang ~= "cn" and _isDataExist then
            local keyIndex =  record._data_key_map[key]
            if keyIndex then
                record._data[keyIndex] = value
                return
            end
        end
        if _lang ~= "cn" and _isExist then
            local keyIndex =  record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
                return
            end
        end
        local keyIndex = record._raw_key_map[key]
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