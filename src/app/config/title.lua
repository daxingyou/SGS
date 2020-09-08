--title

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  limit_level = 2,    --限制等级-int 
  day = 3,    --开服天数-int 
  time_type = 4,    --时间类型-int 
  time_value = 5,    --时间类型值-int 
  name = 6,    --名称-string 
  colour = 7,    --称号品质-string 
  color = 8,    --称号品质1-string 
  resource = 9,    --资源-string 
  des = 10,    --条件描述-string 
  moving = 11,    --特效-string 
  offset_x = 12,    --左右偏移-int 
  offset_y = 13,    --上下偏移-int 
  description = 14,    --详情描述-string 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  limit_level = "int",    --限制等级-2 
  day = "int",    --开服天数-3 
  time_type = "int",    --时间类型-4 
  time_value = "int",    --时间类型值-5 
  name = "string",    --名称-6 
  colour = "string",    --称号品质-7 
  color = "string",    --称号品质1-8 
  resource = "string",    --资源-9 
  des = "string",    --条件描述-10 
  moving = "string",    --特效-11 
  offset_x = "int",    --左右偏移-12 
  offset_y = "int",    --上下偏移-13 
  description = "string",    --详情描述-14 

}


-- data
local title = {
    version =  1,
    _data = {
        [1] = {1,1,0,2,0,"为游戏打Call","3","3","img_title_01","累计登录达到99天","",-10,8,"累计登录达到99天",},
        [2] = {2,30,0,2,0,"最后亿次","3","3","img_title_02","在华容道累计猜对99次获胜玩家","",-10,8,"在华容道累计猜对99次获胜玩家",},
        [3] = {3,30,0,1,7,"开不开心","4","4","img_title_03","在黄金宝箱中获得任意1件红色装备","",-10,8,"在黄金宝箱中获得任意1件红色装备",},
        [4] = {4,1,0,1,7,"惊不惊喜","4","4","img_title_04","在卧龙观星活动中直接获得任意1只橙色神兽","",-10,8,"在卧龙观星活动中直接获得任意1只橙色神兽",},
        [5] = {5,1,0,1,7,"意不意外","4","4","img_title_05","在割须弃袍活动中直接获得任意1件红装","",-10,8,"在割须弃袍活动中直接获得任意1件红装",},
        [6] = {6,1,0,1,7,"刺不刺激","4","4","img_title_06","在身外化身活动中直接获得1枚三清化形羽","",-10,8,"在身外化身活动中直接获得1枚三清化形羽",},
        [7] = {7,14,0,1,1,"还有谁？","4","4","img_title_07","在每日竞技场结算时排名竞技场第1","",-10,8,"在每日竞技场结算时排名竞技场第1",},
        [8] = {8,1,0,2,0,"我全都要","4","4","img_title_08","拥有所有武将（不包括橙升红、红升金武将）","",-10,8,"拥有所有武将（不包括橙升红、红升金武将）",},
        [9] = {9,14,0,1,1,"十大战力","4","4","img_title_09","每日战力排行榜前10","",-10,8,"每日战力排行榜前10",},
        [10] = {10,30,0,2,0,"来呀，快活呀","4","4","img_title_10","在矿战被击杀999次","",-10,8,"在矿战被击杀999次",},
        [11] = {11,50,0,1,7,"魏国霸主","4","4","img_title_11","阵营竞技魏国冠军","",-10,8,"阵营竞技魏国冠军",},
        [12] = {12,50,0,1,7,"蜀国霸主","4","4","img_title_12","阵营竞技蜀国冠军","",-10,8,"阵营竞技蜀国冠军",},
        [13] = {13,50,0,1,7,"吴国霸主","4","4","img_title_13","阵营竞技吴国冠军","",-10,8,"阵营竞技吴国冠军",},
        [14] = {14,50,0,1,7,"群雄霸主","4","4","img_title_14","阵营竞技群雄冠军","",-10,8,"阵营竞技群雄冠军",},
        [15] = {15,1,0,1,7,"狗托","4","4","img_title_15","在身外化身活动中直接获得1枚惊鸿化形羽","",-10,8,"在身外化身活动中直接获得1枚惊鸿化形羽",},
        [16] = {16,1,0,2,0,"先定一个小目标","5","5","img_title_16","拥有全部橙色变身卡","",-10,8,"拥有全部橙色变身卡",},
        [17] = {17,50,0,1,7,"C位出道","5","5","img_title_17","每周4跨服个人竞技4强","",-10,8,"每周4跨服个人竞技4强",},
        [18] = {18,30,0,2,0,"同九年汝何秀","5","5","img_title_18","累计在矿战中击杀999个玩家","",-10,8,"累计在矿战中击杀999个玩家",},
        [19] = {19,60,0,1,30,"一人之下","5","5","img_title_19","王者之战赛季结算时在排行榜排名第2-10","",-10,8,"王者之战赛季结算时在排行榜排名第2-10",},
        [20] = {20,30,0,1,7,"天下无双","6","6","img_title_20","每周4跨服个人竞技冠军","effect_touxian_tianxiawushuang",-10,8,"每周4跨服个人竞技冠军",},
        [21] = {21,60,0,1,30,"不是我针对谁","6","6","img_title_21","王者之战赛季结算时在排行榜排名第1","effect_touxian_zhenduishui",-10,8,"王者之战赛季结算时在排行榜排名第1",},
        [22] = {22,1,0,2,0,"家里有矿","6","6","img_title_22","拥有所有红色变身卡","effect_touxian_jialiyoukuang",-10,8,"拥有所有红色变身卡",},
        [23] = {23,1,0,2,0,"新手指导员","2","2","img_title03","游戏官方新手指导员","",-10,8,"游戏官方新手指导员",},
        [24] = {24,1,0,1,14,"志在四方","4","4","img_title_23","桌游志100期纪念专属限定称号","",-10,8,"桌游志100期纪念专属限定称号",},
        [25] = {25,1,0,1,30,"大风起兮云飞扬","5","5","img_title_25","周年庆活动专属限定称号","",-10,8,"周年庆活动专属限定称号",},
        [26] = {26,1,0,1,30,"气吞山河","5","5","img_title_26","周年庆活动专属限定称号","",-10,8,"周年庆活动专属限定称号",},
        [27] = {27,1,0,1,30,"扶摇直上九万里","6","6","img_title_27","周年庆活动专属限定称号","effect_touxian_fuyao",-10,8,"周年庆活动专属限定称号",},
        [28] = {28,1,0,2,0,"风云际会","5","5","img_title_28","见龙在田活动专属称号","",-10,8,"见龙在田活动专属称号",},
        [29] = {29,1,0,2,0,"龙寻隐踪","5","5","img_title_29","见龙在田活动专属称号","",-10,8,"见龙在田活动专属称号",},
        [30] = {30,1,0,2,0,"众里寻他千百度","6","6","img_title_30","见龙在田活动专属称号","effect_touxian_zhongli",-10,8,"见龙在田活动专属称号",},
        [31] = {31,1,0,1,2,"智冠天下","5","5","img_title_31","全服答题个人积分第1","",-10,8,"全服答题个人积分第1",},
        [32] = {32,70,0,2,0,"摸金校尉","3","3","img_title_32","累计在先秦皇陵中获得99本春秋或战国","",-10,8,"累计在先秦皇陵中获得999本春秋或战国",},
        [33] = {33,70,0,2,0,"发丘中郎将","4","4","img_title_33","累计在先秦皇陵中停留60小时","",-10,8,"累计在先秦皇陵中停留",},
        [34] = {34,70,0,2,0,"横扫六合","5","5","img_title_34","累计在先秦皇陵中击杀999个小队","",-10,8,"累计在先秦皇陵中击杀999个小队",},
        [35] = {35,1,0,1,30,"推杯换盏","5","5","img_title_35","饕餮盛宴活动专属限定称号，有效期30天","",-10,8,"饕餮盛宴活动专属限定称号，有效期30天",},
        [36] = {36,1,0,1,30,"将进酒杯莫停","5","5","img_title_36","饕餮盛宴活动专属限定称号，有效期30天","",-10,8,"饕餮盛宴活动专属限定称号，有效期30天",},
        [37] = {37,1,0,1,30,"对酒当歌人生几何","6","6","img_title_37","饕餮盛宴活动专属限定称号，有效期30天","effect_touxian_duijiudangerensjh",-10,8,"饕餮盛宴活动专属限定称号，有效期30天",},
        [38] = {38,1,0,1,7,"过不过瘾","4","4","img_title_38","在关公驯马活动中直接获得任意1匹橙色战马","",-10,8,"在关公驯马活动中直接获得任意1匹橙色战马",},
        [39] = {39,1,0,1,7,"激不激动","4","4","img_title_39","在相马中相中1个千里良驹哨","",-10,8,"在相马中相中1个千里良驹哨",},
        [40] = {40,1,0,1,7,"666","5","5","img_title_40","在见龙在田活动中直接招募到任意1名金将","",-10,8,"在见龙在田活动中招募到任意1名金将整将",},
        [41] = {41,1,0,1,7,"嘿嘿嘿","5","5","img_title_41","在见龙在田活动中任意一轮欢乐抽奖中奖","",-10,8,"在见龙在田活动中任意一轮欢乐抽奖中奖",},
        [42] = {42,1,0,1,7,"王中王","5","5","img_title_42","跨服军团战军团积分第一名","",-10,8,"跨服军团战军团积分第一名",},
        [43] = {43,1,0,1,7,"弟中弟","4","4","img_title_43","跨服军团战军团积分垫底","",-10,8,"跨服军团战军团积分垫底",},
        [44] = {44,1,0,1,7,"生子当如孙仲谋","5","5","img_title_44","跨服军团战个人击杀前三名","",-10,8,"跨服军团战个人击杀前三名",},
        [45] = {45,1,0,1,7,"在下孙仲谋","4","4","img_title_45","跨服军团战个人死亡次数前三名","",-10,8,"跨服军团战个人死亡次数最后三名",},
        [46] = {46,1,0,1,30,"仗剑挟酒","5","5","img_title_46","饕餮盛宴活动专属限定称号，有效期30天","",-10,8,"饕餮盛宴活动专属限定称号，有效期30天",},
        [47] = {47,1,0,1,30,"诗酒趁年华","5","5","img_title_47","饕餮盛宴活动专属限定称号，有效期30天","",-10,8,"饕餮盛宴活动专属限定称号，有效期30天",},
        [48] = {48,1,0,1,30,"众人皆醉我独醒","6","6","img_title_48","饕餮盛宴活动专属限定称号，有效期30天","effect_touxian_keep",-10,8,"饕餮盛宴活动专属限定称号，有效期30天",},
        [49] = {49,1,0,1,30,"鲤鱼跃龙门","5","5","img_title_51","饕餮盛宴活动专属限定称号，有效期30天","effect_chenghao_yuelongmen",-10,8,"饕餮盛宴活动专属限定称号，有效期30天",},
        [50] = {50,1,0,1,30,"吉祥如意福满堂","6","6","img_title_52","饕餮盛宴活动专属限定称号，有效期30天","effect_chenghao_jixiangruyi",-10,8,"饕餮盛宴活动专属限定称号，有效期30天",},
        [51] = {1001,1,0,2,0,"新年2020","5","5","img_title_1001","2020新年活动期间，登录1天","",-10,8,"2020新年活动期间，登录1天",},
        [52] = {1002,1,0,2,0,"如意","5","5","img_title_1002","2020新年活动期间，达到20级以上","",-10,8,"2020新年活动期间，达到20级以上",},
        [53] = {1003,1,0,2,0,"新春快乐","5","5","img_title_1003","2020新年活动期间，达到40级以上","",-10,8,"2020新年活动期间，达到40级以上",},
        [54] = {1004,1,0,2,0,"新年发财","5","5","img_title_1004","2020新年活动期间，随机充值任意金额","",-10,8,"2020新年活动期间，随机充值任意金额",},
        [55] = {1005,1,0,2,0,"大富大贵","5","5","img_title_1005","2020新年活动期间，活动期间，累充500w","",-10,8,"2020新年活动期间，活动期间，累充500w",},
        [56] = {1006,1,0,2,0,"传奇","5","5","img_title_1006","Danh hiệu tri ân người chơi VIP","",-10,8,"Danh hiệu tri ân người chơi VIP",},
        [57] = {1007,1,0,2,0,"战神","5","5","img_title_1007","Danh hiệu kỷ niệm","",-10,8,"Danh hiệu kỷ niệm",},
        [58] = {1008,1,0,2,0,"第一名","5","5","img_title_1008","Dành cho người chơi đạt top 1 sự kiện đua top","",-10,8,"Dành cho người chơi đạt top 1 sự kiện đua top",},
        [59] = {1009,1,0,2,0,"平天下","5","5","img_title_1009","Danh hiệu tri ân người chơi VIP","",-10,8,"Danh hiệu tri ân người chơi VIP",},
        [60] = {1010,1,0,2,0,"定江山","5","5","img_title_1010","Danh hiệu tri ân người chơi VIP","",-10,8,"Danh hiệu tri ân người chơi VIP",},
        [61] = {1011,1,0,2,0,"霸主","5","5","img_title_1011","Danh hiệu tri ân người chơi VIP","",-10,8,"Danh hiệu tri ân người chơi VIP",},
        [62] = {1012,1,0,2,0,"IDOL Anh Kin","5","5","img_title_1012","Danh hiệu nhận được từ sự kiện Idol Của Tôi","",-10,8,"Danh hiệu nhận được từ sự kiện Idol Của Tôi",},
        [63] = {1013,1,0,2,0,"IDOL Billy","5","5","img_title_1013","Danh hiệu nhận được từ sự kiện Idol Của Tôi","",-10,8,"Danh hiệu nhận được từ sự kiện Idol Của Tôi",},
        [64] = {1014,1,0,2,0,"IDOL Bet888","5","5","img_title_1014","Danh hiệu nhận được từ sự kiện Idol Của Tôi","",-10,8,"Danh hiệu nhận được từ sự kiện Idol Của Tôi",},
        [65] = {1015,1,0,2,0,"IDOL Wukong","5","5","img_title_1015","Danh hiệu nhận được từ sự kiện Idol Của Tôi","",-10,8,"Danh hiệu nhận được từ sự kiện Idol Của Tôi",},
        [66] = {1016,1,0,2,0,"IDOL Bố Già","5","5","img_title_1016","Danh hiệu nhận được từ sự kiện Idol Của Tôi","",-10,8,"Danh hiệu nhận được từ sự kiện Idol Của Tôi",},
        [67] = {8023,1,0,1,30,"社团之星","4","4","img_title8023","运营活动获得","",-10,8,"运营活动获得",},
        [68] = {8024,1,0,1,15,"魏国之光","4","4","img_title8024","运营活动获得","",-10,8,"运营活动获得",},
        [69] = {8025,1,0,1,15,"蜀国之光","4","4","img_title8025","运营活动获得","",-10,8,"运营活动获得",},
        [70] = {8026,1,0,1,15,"吴国之光","4","4","img_title8026","运营活动获得","",-10,8,"运营活动获得",},
        [71] = {8027,1,0,1,15,"群雄之光","4","4","img_title8027","运营活动获得","",-10,8,"运营活动获得",},
        [72] = {8028,1,0,1,15,"金色传说","5","5","img_title8028","运营活动获得","",-10,8,"运营活动获得",},
        [73] = {8029,1,0,2,0,"天才小画师","4","4","img_title8029","运营活动获得","",-10,8,"运营活动获得",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [1001] = 51,
    [1002] = 52,
    [1003] = 53,
    [1004] = 54,
    [1005] = 55,
    [1006] = 56,
    [1007] = 57,
    [1008] = 58,
    [1009] = 59,
    [1010] = 60,
    [1011] = 61,
    [1012] = 62,
    [1013] = 63,
    [1014] = 64,
    [1015] = 65,
    [1016] = 66,
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
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [8023] = 67,
    [8024] = 68,
    [8025] = 69,
    [8026] = 70,
    [8027] = 71,
    [8028] = 72,
    [8029] = 73,
    [9] = 9,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [10] = 10,
    [51] = 1001,
    [52] = 1002,
    [53] = 1003,
    [54] = 1004,
    [55] = 1005,
    [56] = 1006,
    [57] = 1007,
    [58] = 1008,
    [59] = 1009,
    [60] = 1010,
    [61] = 1011,
    [62] = 1012,
    [63] = 1013,
    [64] = 1014,
    [65] = 1015,
    [66] = 1016,
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
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [67] = 8023,
    [68] = 8024,
    [69] = 8025,
    [70] = 8026,
    [71] = 8027,
    [72] = 8028,
    [73] = 8029,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in title")
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
function title.length()
    return #title._data
end

-- 
function title.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function title.isVersionValid(v)
    if title.version then
        if v then
            return title.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function title.indexOf(index)
    if index == nil or not title._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/title.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/title.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/title.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "title" )
                _isDataExist = title.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "title" )
                _isBaseExist = title.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "title" )
                _isExist = title.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "title" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "title" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = title._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "title" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function title.get(id)
    
    return title.indexOf(__index_id[id])
        
end

--
function title.set(id, key, value)
    local record = title.get(id)
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
function title.index()
    return __index_id
end

return title