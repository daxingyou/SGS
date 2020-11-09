--fight_silkbag

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  area = 2,    --所属赛区id-int 
  title = 3,    --锦囊组标题-string 
  desc = 4,    --描述-string 
  silkbag1 = 5,    --锦囊1-int 
  silkbag2 = 6,    --锦囊2-int 
  silkbag3 = 7,    --锦囊3-int 
  silkbag4 = 8,    --锦囊4-int 
  silkbag5 = 9,    --锦囊5-int 
  silkbag6 = 10,    --锦囊6-int 
  silkbag7 = 11,    --锦囊7-int 
  silkbag8 = 12,    --锦囊8-int 
  silkbag9 = 13,    --锦囊9-int 
  silkbag10 = 14,    --锦囊10-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  area = "int",    --所属赛区id-2 
  title = "string",    --锦囊组标题-3 
  desc = "string",    --描述-4 
  silkbag1 = "int",    --锦囊1-5 
  silkbag2 = "int",    --锦囊2-6 
  silkbag3 = "int",    --锦囊3-7 
  silkbag4 = "int",    --锦囊4-8 
  silkbag5 = "int",    --锦囊5-9 
  silkbag6 = "int",    --锦囊6-10 
  silkbag7 = "int",    --锦囊7-11 
  silkbag8 = "int",    --锦囊8-12 
  silkbag9 = "int",    --锦囊9-13 
  silkbag10 = "int",    --锦囊10-14 

}


-- data
local fight_silkbag = {
    version =  1,
    _data = {
        [1] = {11,1,"纵火","兼顾高灼烧概率和封无敌",1315,1314,1309,1205,0,0,0,0,0,0,},
        [2] = {12,1,"单体输出","自带导航，精准打击",1319,1318,1308,1205,0,0,0,0,0,0,},
        [3] = {13,1,"群体输出","保证高伤害与一定的保命能力",1314,1310,1220,1205,0,0,0,0,0,0,},
        [4] = {14,1,"纵排控制","提升纵排减怒和眩晕效果",1314,1302,1209,1205,0,0,0,0,0,0,},
        [5] = {15,1,"单体控制","提升单体减怒和眩晕效果",1310,1308,1209,1204,0,0,0,0,0,0,},
        [6] = {16,1,"治疗","充足的治疗量，一口奶满",1314,1313,1310,1202,0,0,0,0,0,0,},
        [7] = {17,1,"辅助通用","四平八稳，保证生存",1314,1310,1308,1205,0,0,0,0,0,0,},
        [8] = {18,1,"万毒归宗","兼顾高中毒概率和封疗",1314,1304,1208,1205,0,0,0,0,0,0,},
        [9] = {21,2,"纵火","保证最高的灼烧概率，最大化灼烧的附加效果",0,0,0,1314,1310,0,1303,1203,0,0,},
        [10] = {22,2,"单体输出","极致的伤害，精准的刺杀",0,0,0,0,1318,1314,1308,1205,0,0,},
        [11] = {23,2,"群体输出","爆炸伤害，又肉又有输出",0,0,0,0,1314,1310,1220,1205,0,0,},
        [12] = {24,2,"前后纵输出","打桃园必备，进一步提升伤害",0,0,0,0,1314,1310,1220,1205,0,0,},
        [13] = {25,2,"纵排控制","提升纵排减怒和眩晕效果",0,0,0,1314,1308,1302,1209,1205,0,0,},
        [14] = {26,2,"单体控制","提升单体减怒和眩晕效果",0,0,0,0,1310,1308,1209,1204,0,0,},
        [15] = {27,2,"治疗","又能奶又能苟，只要不被秒就能奶回来",0,0,0,0,1314,1313,1310,1202,0,0,},
        [16] = {28,2,"辅助通用","所有武将都能用，反正先肉起来",0,0,0,0,1314,1310,1308,1205,0,0,},
        [17] = {29,2,"万毒归宗","保证中毒效果的同时极大提高生存率",0,0,0,1314,1305,1304,1208,1205,0,0,},
        [18] = {31,3,"纵火","保证最高的灼烧概率，最大化灼烧的附加效果",0,0,0,0,0,1314,1310,1309,1303,1203,},
        [19] = {32,3,"单体输出","极致的伤害，精准的刺杀",0,0,0,0,0,0,1314,1310,1308,1205,},
        [20] = {33,3,"群体输出","爆炸伤害，又肉又有输出",0,0,0,0,0,1314,1311,1310,1220,1205,},
        [21] = {34,3,"前后纵输出","打桃园必备，进一步提升伤害与续航",0,0,0,0,0,1314,1311,1310,1220,1205,},
        [22] = {35,3,"纵排控制","提升纵排减怒和眩晕效果",0,0,0,0,0,1314,1308,1302,1209,1205,},
        [23] = {36,3,"单体控制","提升单体减怒和眩晕效果",0,0,0,0,1314,1311,1310,1308,1209,1204,},
        [24] = {37,3,"治疗","奶量进一步提升的基础上再加减伤盾，打不死",0,0,0,0,1314,1313,1310,1226,1205,1202,},
        [25] = {38,3,"辅助通用","所有武将都能用，终极保命",0,0,0,0,1314,1310,1308,1221,1219,1205,},
        [26] = {39,3,"万毒归宗","究极的毒伤，丰富的中毒效果",0,0,0,1314,0,1304,1225,1211,1208,1205,},
    }
}

-- index
local __index_id = {
    [11] = 1,
    [12] = 2,
    [13] = 3,
    [14] = 4,
    [15] = 5,
    [16] = 6,
    [17] = 7,
    [18] = 8,
    [21] = 9,
    [22] = 10,
    [23] = 11,
    [24] = 12,
    [25] = 13,
    [26] = 14,
    [27] = 15,
    [28] = 16,
    [29] = 17,
    [31] = 18,
    [32] = 19,
    [33] = 20,
    [34] = 21,
    [35] = 22,
    [36] = 23,
    [37] = 24,
    [38] = 25,
    [39] = 26,

}

-- index mainkey map
local __main_key_map = {
    [1] = 11,
    [2] = 12,
    [3] = 13,
    [4] = 14,
    [5] = 15,
    [6] = 16,
    [7] = 17,
    [8] = 18,
    [9] = 21,
    [10] = 22,
    [11] = 23,
    [12] = 24,
    [13] = 25,
    [14] = 26,
    [15] = 27,
    [16] = 28,
    [17] = 29,
    [18] = 31,
    [19] = 32,
    [20] = 33,
    [21] = 34,
    [22] = 35,
    [23] = 36,
    [24] = 37,
    [25] = 38,
    [26] = 39,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in fight_silkbag")
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
function fight_silkbag.length()
    return #fight_silkbag._data
end

-- 
function fight_silkbag.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function fight_silkbag.isVersionValid(v)
    if fight_silkbag.version then
        if v then
            return fight_silkbag.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function fight_silkbag.indexOf(index)
    if index == nil or not fight_silkbag._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/fight_silkbag.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/fight_silkbag.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/fight_silkbag.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "fight_silkbag" )
                _isDataExist = fight_silkbag.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "fight_silkbag" )
                _isBaseExist = fight_silkbag.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "fight_silkbag" )
                _isExist = fight_silkbag.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "fight_silkbag" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "fight_silkbag" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = fight_silkbag._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "fight_silkbag" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function fight_silkbag.get(id)
    
    return fight_silkbag.indexOf(__index_id[id])
        
end

--
function fight_silkbag.set(id, key, value)
    local record = fight_silkbag.get(id)
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
function fight_silkbag.index()
    return __index_id
end

return fight_silkbag