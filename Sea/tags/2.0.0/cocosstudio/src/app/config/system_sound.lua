--system_sound

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  file_name = 2,    --文件路径-string 
  run_type = 3,    --播放类型1单次2循环-int 
  time = 4,    --音效时长，填0无效，单位为秒，主要用于主城背景音乐-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  file_name = "string",    --文件路径-2 
  run_type = "int",    --播放类型1单次2循环-3 
  time = "int",    --音效时长，填0无效，单位为秒，主要用于主城背景音乐-4 

}


-- data
local system_sound = {
    _data = {
        [1] = {1,"audio/BGM_city.mp3",2,147,},
        [2] = {2,"audio/BGM_pve.mp3",2,0,},
        [3] = {3,"audio/BGM_pvp.mp3",2,0,},
        [4] = {4,"audio/BGM_fight.mp3",2,0,},
        [5] = {5,"audio/BGM_boss.mp3",2,0,},
        [6] = {6,"audio/BGM_outgame.mp3",2,0,},
        [7] = {7,"audio/BGM_horsejump.mp3",2,0,},
        [8] = {8,"audio/BGM_arena.mp3",2,0,},
        [9] = {9,"audio/BGM_login.mp3",2,0,},
        [10] = {10,"audio/BGM_newcity.mp3",2,214,},
        [11] = {11,"audio/ui/30clickpzh1.mp3",1,0,},
        [12] = {12,"audio/ui/Passbutton.mp3",1,0,},
        [13] = {13,"audio/BGM_huangling.mp3",2,0,},
        [14] = {14,"audio/BGM_huangchengfight.mp3",2,0,},
        [15] = {15,"audio/BGM_chengshifight.mp3",2,0,},
        [16] = {16,"audio/BGM_jiangbianfight.mp3",2,0,},
        [17] = {17,"audio/BGM_jiaowaifight.mp3",2,0,},
        [18] = {18,"audio/BGM_yingzhaifight.mp3",2,0,},
        [19] = {101,"audio/fight/Sha.mp3",1,0,},
        [20] = {102,"audio/fight/Fail.mp3",1,0,},
        [21] = {103,"audio/fight/Win.mp3",1,0,},
        [22] = {201,"audio/ui/1nvzhuruchang.mp3",1,0,},
        [23] = {202,"audio/ui/2nanzhuruchang.mp3",1,0,},
        [24] = {203,"audio/ui/3herolv.mp3",1,0,},
        [25] = {204,"audio/ui/4herotp.mp3",1,0,},
        [26] = {205,"audio/ui/5gongxi1.mp3",1,0,},
        [27] = {206,"audio/ui/5gongxi2.mp3",1,0,},
        [28] = {207,"audio/ui/6jiangli.mp3",1,0,},
        [29] = {208,"audio/ui/7shenbinjj.mp3",1,0,},
        [30] = {209,"audio/ui/8equiplv.mp3",1,0,},
        [31] = {210,"audio/ui/9num.mp3",1,0,},
        [32] = {211,"audio/ui/10equipmaster.mp3",1,0,},
        [33] = {212,"audio/ui/11herobook.mp3",1,0,},
        [34] = {213,"audio/ui/12herohs.mp3",1,0,},
        [35] = {214,"audio/ui/13herocs.mp3",1,0,},
        [36] = {215,"audio/ui/14gacha1.mp3",1,0,},
        [37] = {216,"audio/ui/15gacha101.mp3",1,0,},
        [38] = {217,"audio/ui/15gacha102.mp3",1,0,},
        [39] = {218,"audio/ui/16youliz1.mp3",1,0,},
        [40] = {219,"audio/ui/16youliz2.mp3",1,0,},
        [41] = {220,"audio/ui/17youliqy.mp3",1,0,},
        [42] = {223,"audio/ui/20pvps.mp3",1,0,},
        [43] = {224,"audio/ui/21pvpwin.mp3",1,0,},
        [44] = {225,"audio/ui/22pvpnum.mp3",1,0,},
        [45] = {226,"audio/ui/23richangnew.mp3",1,0,},
        [46] = {228,"audio/ui/25jubao.mp3",1,0,},
        [47] = {229,"audio/ui/26saodang.mp3",1,0,},
        [48] = {230,"audio/ui/27nanman.mp3",1,0,},
        [49] = {231,"audio/ui/28zhujuelv.mp3",1,0,},
        [50] = {232,"audio/ui/29guanxianlv.mp3",1,0,},
        [51] = {233,"audio/ui/4lvburuc.mp3",1,0,},
        [52] = {234,"audio/ui/10uiduijue.mp3",1,0,},
        [53] = {235,"audio/ui/11fudaokaiqi.mp3",1,0,},
        [54] = {236,"audio/ui/12shengfuyijue.mp3",1,0,},
        [55] = {237,"audio/ui/13xingongneng.mp3",1,0,},
        [56] = {238,"audio/ui/238zhuanpanhuode.mp3",1,0,},
        [57] = {239,"audio/ui/239zhuanpanyixia.mp3",1,0,},
        [58] = {240,"audio/ui/240hongbaohuode.mp3",1,0,},
        [59] = {241,"audio/ui/241hongbaokaiqi.mp3",1,0,},
        [60] = {242,"audio/ui/242gxqpmati.mp3",2,0,},
        [61] = {243,"audio/ui/243gxqpsheji.mp3",1,0,},
        [62] = {244,"audio/ui/244shenshouzhaomu.mp3",1,0,},
        [63] = {245,"audio/ui/245gaojishi.mp3",1,0,},
        [64] = {246,"audio/ui/246zhuangxian.mp3",1,0,},
        [65] = {247,"audio/ui/247caozaoyin.mp3",2,0,},
        [66] = {248,"audio/ui/248paobu.mp3",2,0,},
        [67] = {249,"audio/ui/249yusaiwin.mp3",1,0,},
        [68] = {250,"audio/ui/250yusailost.mp3",1,0,},
        [69] = {251,"audio/ui/251daojishi.mp3",1,0,},
        [70] = {252,"audio/ui/252matisheng.mp3",2,0,},
        [71] = {253,"audio/ui/253jinbi.mp3",1,0,},
        [72] = {254,"audio/ui/254tiaoyue.mp3",1,0,},
        [73] = {255,"audio/ui/255siwang.mp3",1,0,},
        [74] = {256,"audio/ui/256win.mp3",1,0,},
        [75] = {257,"audio/ui/257jiesuanjiemian.mp3",1,0,},
        [76] = {258,"audio/ui/258shengxing.mp3",1,0,},
        [77] = {259,"audio/ui/259jiangxing.mp3",1,0,},
        [78] = {260,"audio/ui/260duanweiup.mp3",1,0,},
        [79] = {261,"audio/ui/261duanweidowm.mp3",1,0,},
        [80] = {262,"audio/ui/262xiangma.mp3",1,0,},
        [81] = {263,"audio/ui/263login.mp3",1,0,},
        [82] = {264,"audio/ui/264tianchong.mp3",1,0,},
        [83] = {265,"audio/ui/265yingman.mp3",1,0,},
        [84] = {266,"audio/ui/266tupo.mp3",1,0,},
        [85] = {267,"audio/ui/267shibai.mp3",1,0,},
        [86] = {268,"audio/ui/268good.mp3",1,0,},
        [87] = {269,"audio/ui/269chenggong.mp3",1,0,},
        [88] = {270,"audio/BGM_pvpsingle32.mp3",2,0,},
        [89] = {271,"audio/BGM_pvpsinglewinner.mp3",1,0,},
        [90] = {272,"audio/BGM_allanswer.mp3",2,0,},
        [91] = {273,"audio/ui/30right.mp3",1,0,},
        [92] = {274,"audio/ui/31wrong.mp3",1,0,},
        [93] = {275,"audio/fight/fy_1_at_2.mp3",1,0,},
        [94] = {276,"audio/fight/fy_106_at_1.mp3",1,0,},
        [95] = {277,"audio/fight/fy_205_at_1.mp3",1,0,},
        [96] = {278,"audio/ui/32ganning.mp3",1,0,},
        [97] = {279,"audio/ui/33huangyueyin.mp3",1,0,},
        [98] = {280,"audio/ui/34lvbu.mp3",1,0,},
        [99] = {290,"audio/ui/290qinglong.mp3",1,0,},
        [100] = {291,"audio/ui/291xuanwu.mp3",1,0,},
        [101] = {292,"audio/ui/292baihu.mp3",1,0,},
        [102] = {293,"audio/ui/293zhuque.mp3",1,0,},
        [103] = {294,"audio/ui/294golden_open.mp3",1,0,},
        [104] = {295,"audio/ui/295golden_recruit.mp3",1,0,},
        [105] = {296,"audio/BGM_golden_hero.mp3",2,0,},
        [106] = {297,"audio/BGM_cake_main.mp3",2,0,},
        [107] = {298,"audio/ui/cake_egg.mp3",1,0,},
        [108] = {299,"audio/ui/cake_cream.mp3",1,0,},
        [109] = {300,"audio/ui/cake_fruit.mp3",1,0,},
        [110] = {301,"audio/ui/cake_lvup.mp3",1,0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [101] = 19,
    [102] = 20,
    [103] = 21,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [17] = 17,
    [18] = 18,
    [2] = 2,
    [201] = 22,
    [202] = 23,
    [203] = 24,
    [204] = 25,
    [205] = 26,
    [206] = 27,
    [207] = 28,
    [208] = 29,
    [209] = 30,
    [210] = 31,
    [211] = 32,
    [212] = 33,
    [213] = 34,
    [214] = 35,
    [215] = 36,
    [216] = 37,
    [217] = 38,
    [218] = 39,
    [219] = 40,
    [220] = 41,
    [223] = 42,
    [224] = 43,
    [225] = 44,
    [226] = 45,
    [228] = 46,
    [229] = 47,
    [230] = 48,
    [231] = 49,
    [232] = 50,
    [233] = 51,
    [234] = 52,
    [235] = 53,
    [236] = 54,
    [237] = 55,
    [238] = 56,
    [239] = 57,
    [240] = 58,
    [241] = 59,
    [242] = 60,
    [243] = 61,
    [244] = 62,
    [245] = 63,
    [246] = 64,
    [247] = 65,
    [248] = 66,
    [249] = 67,
    [250] = 68,
    [251] = 69,
    [252] = 70,
    [253] = 71,
    [254] = 72,
    [255] = 73,
    [256] = 74,
    [257] = 75,
    [258] = 76,
    [259] = 77,
    [260] = 78,
    [261] = 79,
    [262] = 80,
    [263] = 81,
    [264] = 82,
    [265] = 83,
    [266] = 84,
    [267] = 85,
    [268] = 86,
    [269] = 87,
    [270] = 88,
    [271] = 89,
    [272] = 90,
    [273] = 91,
    [274] = 92,
    [275] = 93,
    [276] = 94,
    [277] = 95,
    [278] = 96,
    [279] = 97,
    [280] = 98,
    [290] = 99,
    [291] = 100,
    [292] = 101,
    [293] = 102,
    [294] = 103,
    [295] = 104,
    [296] = 105,
    [297] = 106,
    [298] = 107,
    [299] = 108,
    [3] = 3,
    [300] = 109,
    [301] = 110,
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
        assert(__key_map[k], "cannot find " .. k .. " in system_sound")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function system_sound.length()
    return #system_sound._data
end

-- 
function system_sound.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function system_sound.indexOf(index)
    if index == nil or not system_sound._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/system_sound.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "system_sound" )
        return setmetatable({_raw = system_sound._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = system_sound._data[index]}, mt)
end

--
function system_sound.get(id)
    
    return system_sound.indexOf(__index_id[id])
        
end

--
function system_sound.set(id, key, value)
    local record = system_sound.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function system_sound.index()
    return __index_id
end

return system_sound