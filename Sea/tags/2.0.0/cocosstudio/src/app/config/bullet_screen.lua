--bullet_screen

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  type = 2,    --类型-int 
  color = 3,    --弹幕品质-int 
  text = 4,    --文本-string 
  way = 5,    --弹幕出现方式-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  type = "int",    --类型-2 
  color = "int",    --弹幕品质-3 
  text = "string",    --文本-4 
  way = "int",    --弹幕出现方式-5 

}


-- data
local bullet_screen = {
    _data = {
        [1] = {1,1,1,"【#name#】输出了#number#点伤害！",0,},
        [2] = {2,1,1,"【#name#】对BOSS造成#number#点伤害！",0,},
        [3] = {3,1,1,"【#name#】挑战BOSS打出#number#点伤害！",0,},
        [4] = {4,1,1,"【#name#】乱战中偷袭BOSS，打出#number#点伤害！",0,},
        [5] = {5,1,1,"【#name#】蹭掉BOSS#number#点血皮伤害！",0,},
        [6] = {6,1,2,"【#name#】乱战中偷袭BOSS，打出#number#点伤害！",0,},
        [7] = {7,1,2,"【#name#】输出了#number#点伤害！",0,},
        [8] = {8,1,2,"【#name#】输出了#number#点伤害！",0,},
        [9] = {9,1,2,"【#name#】对BOSS造成#number#点伤害！",0,},
        [10] = {10,1,2,"【#name#】对BOSS造成#number#点伤害！",0,},
        [11] = {11,1,3,"【#name#】奋力一击，扫中BOSS脚跟，造成#number#点伤害！",0,},
        [12] = {12,1,3,"【#name#】输出了#number#点伤害！求超越！",0,},
        [13] = {13,1,3,"【#name#】输出了#number#点伤害！威力超猛~",0,},
        [14] = {14,1,3,"【#name#】混乱中抬脚踹中BOSS臀部，造成#number#点伤害！",0,},
        [15] = {15,1,3,"【#name#】蓄力一击，对boss造成#number#点伤害！",0,},
        [16] = {16,1,4,"【#name#】挥刀一劈，造成#number#点伤害！BOSS觉得有点痒！",0,},
        [17] = {17,1,4,"【#name#】输出了#number#点伤害！BOSS顿觉菊花一紧！",0,},
        [18] = {18,1,4,"【#name#】狠踹BOSS一脚，对BOSS造成#number#点真实伤害！",0,},
        [19] = {19,1,4,"【#name#】乱战中偷袭BOSS，打出#number#点伤害！",0,},
        [20] = {20,1,4,"【#name#】输出了#number#点伤害！求超越！",0,},
        [21] = {21,1,5,"【#name#】使出浑身解数，对BOSS造成#number#点致命伤害！求超越！",0,},
        [22] = {22,1,5,"【#name#】一枪捅到BOSS菊花！造成雷霆一击！输出#number#点伤害！",0,},
        [23] = {23,1,5,"【#name#】声东击西，背后偷袭BOSS，对其造成#number#点伤害！",0,},
        [24] = {24,1,5,"【#name#】使出连招，对boss造成#number#点伤害！",0,},
        [25] = {25,1,5,"【#name#】输出了#number#点伤害！求超越！",0,},
        [26] = {26,1,6,"【#name#】对BOSS一顿穷追猛打，输出了#number#点伤害！",0,},
        [27] = {27,1,6,"【#name#】对BOSS造成#number#点真实伤害！战力爆棚！",0,},
        [28] = {28,1,6,"【#name#】蓄力已久，亮起武器对BOSS造成#number#点会心伤害！",0,},
        [29] = {29,1,6,"【#name#】直捣黄龙，对BOSS造成#number#点高额伤害！",0,},
        [30] = {30,1,6,"【#name#】输出了#number#点伤害！力压群雄！谁敢争锋！",0,},
        [31] = {31,2,1,"【#name#】输出了#number#点伤害！",0,},
        [32] = {32,2,1,"【#name#】对BOSS造成#number#点伤害！",0,},
        [33] = {33,2,1,"【#name#】挑战BOSS打出#number#点伤害！",0,},
        [34] = {34,2,1,"【#name#】乱战中偷袭BOSS，打出#number#点伤害！",0,},
        [35] = {35,2,1,"【#name#】蹭掉BOSS#number#点血皮伤害！",0,},
        [36] = {36,2,2,"【#name#】乱战中偷袭BOSS，打出#number#点伤害！",0,},
        [37] = {37,2,2,"【#name#】输出了#number#点伤害！",0,},
        [38] = {38,2,2,"【#name#】输出了#number#点伤害！",0,},
        [39] = {39,2,2,"【#name#】对BOSS造成#number#点伤害！",0,},
        [40] = {40,2,2,"【#name#】对BOSS造成#number#点伤害！",0,},
        [41] = {41,2,3,"【#name#】奋力一击，扫中BOSS脚跟，造成#number#点伤害！",0,},
        [42] = {42,2,3,"【#name#】输出了#number#点伤害！求超越！",0,},
        [43] = {43,2,3,"【#name#】输出了#number#点伤害！威力超猛~",0,},
        [44] = {44,2,3,"【#name#】混乱中抬脚踹中BOSS臀部，造成#number#点伤害！",0,},
        [45] = {45,2,3,"【#name#】蓄力一击，对boss造成#number#点伤害！",0,},
        [46] = {46,2,4,"【#name#】挥刀一劈，造成#number#点伤害！BOSS觉得有点痒！",0,},
        [47] = {47,2,4,"【#name#】输出了#number#点伤害！BOSS顿觉菊花一紧！",0,},
        [48] = {48,2,4,"【#name#】狠踹BOSS一脚，对BOSS造成#number#点真实伤害！",0,},
        [49] = {49,2,4,"【#name#】乱战中偷袭BOSS，打出#number#点伤害！",0,},
        [50] = {50,2,4,"【#name#】输出了#number#点伤害！求超越！",0,},
        [51] = {51,2,5,"【#name#】使出浑身解数，对BOSS造成#number#点致命伤害！求超越！",0,},
        [52] = {52,2,5,"【#name#】一枪捅到BOSS菊花！造成雷霆一击！输出#number#点伤害！",0,},
        [53] = {53,2,5,"【#name#】声东击西，背后偷袭BOSS，对其造成#number#点伤害！",0,},
        [54] = {54,2,5,"【#name#】使出连招，对boss造成#number#点伤害！",0,},
        [55] = {55,2,5,"【#name#】输出了#number#点伤害！求超越！",0,},
        [56] = {56,2,6,"【#name#】对BOSS一顿穷追猛打，输出了#number#点伤害！",0,},
        [57] = {57,2,6,"【#name#】对BOSS造成#number#点真实伤害！战力爆棚！",0,},
        [58] = {58,2,6,"【#name#】蓄力已久，亮起武器对BOSS造成#number#点会心伤害！",0,},
        [59] = {59,2,6,"【#name#】直捣黄龙，对BOSS造成#number#点高额伤害！",0,},
        [60] = {60,2,6,"【#name#】输出了#number#点伤害！力压群雄！谁敢争锋！",0,},
        [61] = {101,4,5,"第一滴血！[#guild1#]的[#player1#]完成了本战场的第一次击杀！",0,},
        [62] = {102,4,1,"[#guild1#]的[#player1#]击杀了[#guild2#]的[#player2#]。",0,},
        [63] = {103,4,2,"双杀！[#guild1#]的[#player1#]击杀了[#guild2#]的[#player2#]，正在大杀特杀！",0,},
        [64] = {104,4,3,"三杀！[#guild1#]的[#player1#]击杀了[#guild2#]的[#player2#]，已经无人可挡！",0,},
        [65] = {105,4,3,"四杀！[#guild1#]的[#player1#]击杀了[#guild2#]的[#player2#]，犹如战神附体！",0,},
        [66] = {106,4,3,"五杀！[#guild1#]的[#player1#]击杀了[#guild2#]的[#player2#]，超越神的杀戮！",0,},
        [67] = {107,4,3,"暴走！[#guild#]的[#player#]已累计达成20次击杀，正在暴走中，拜托谁去阻止他吧！",0,},
        [68] = {108,4,5,"【#guild#】军团的#player#刚刚攻破了【#city#】的城门！",0,},
        [69] = {109,4,5,"【#guild#】军团成功夺得了【#city#】的龙柱控制权！",0,},
        [70] = {201,5,5,"恭喜#server##name#获得了#goods#！",1,},
        [71] = {202,5,7,"时来天地皆同力！恭喜#server##name#获得了#goods#！",2,},
        [72] = {203,5,3,"恭喜#server##name#获得了#goods#！",1,},
        [73] = {204,5,4,"恭喜#server##name#获得了#goods#！",1,},
        [74] = {205,5,6,"恭喜#server##name#获得了#goods#！",1,},
        [75] = {206,5,7,"恭喜#server##name#获得了#goods#！",2,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [101] = 61,
    [102] = 62,
    [103] = 63,
    [104] = 64,
    [105] = 65,
    [106] = 66,
    [107] = 67,
    [108] = 68,
    [109] = 69,
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
    [201] = 70,
    [202] = 71,
    [203] = 72,
    [204] = 73,
    [205] = 74,
    [206] = 75,
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
    [30] = 30,
    [31] = 31,
    [32] = 32,
    [33] = 33,
    [34] = 34,
    [35] = 35,
    [36] = 36,
    [37] = 37,
    [38] = 38,
    [39] = 39,
    [4] = 4,
    [40] = 40,
    [41] = 41,
    [42] = 42,
    [43] = 43,
    [44] = 44,
    [45] = 45,
    [46] = 46,
    [47] = 47,
    [48] = 48,
    [49] = 49,
    [5] = 5,
    [50] = 50,
    [51] = 51,
    [52] = 52,
    [53] = 53,
    [54] = 54,
    [55] = 55,
    [56] = 56,
    [57] = 57,
    [58] = 58,
    [59] = 59,
    [6] = 6,
    [60] = 60,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in bullet_screen")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function bullet_screen.length()
    return #bullet_screen._data
end

-- 
function bullet_screen.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function bullet_screen.indexOf(index)
    if index == nil or not bullet_screen._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/bullet_screen.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "bullet_screen" )
        return setmetatable({_raw = bullet_screen._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = bullet_screen._data[index]}, mt)
end

--
function bullet_screen.get(id)
    
    return bullet_screen.indexOf(__index_id[id])
        
end

--
function bullet_screen.set(id, key, value)
    local record = bullet_screen.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function bullet_screen.index()
    return __index_id
end

return bullet_screen