--horse

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  name = 2,    --装备名称-string 
  color = 3,    --品质-int 
  templet = 4,    --潜力-int 
  res_id = 5,    --资源id-string 
  description = 6,    --装备描述-string 
  fragment_id = 7,    --碎片id-int 
  type = 8,    --泛用性-string 
  hero = 9,    --适用武将-string 
  show_day = 10,    --图鉴显示天数-int 
  moving = 11,    --装备特效-string 
  voice = 12,    --语音-string 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  name = "string",    --装备名称-2 
  color = "int",    --品质-3 
  templet = "int",    --潜力-4 
  res_id = "string",    --资源id-5 
  description = "string",    --装备描述-6 
  fragment_id = "int",    --碎片id-7 
  type = "string",    --泛用性-8 
  hero = "string",    --适用武将-9 
  show_day = "int",    --图鉴显示天数-10 
  moving = "string",    --装备特效-11 
  voice = "string",    --语音-12 

}


-- data
local horse = {
    version =  1,
    _data = {
        [1] = {1,"青骓",3,3,"801","青骓，苍白杂色的骏马，战场上毫无畏惧，迎箭而上迅猛异常。",120001,"所有","999",0,"0","Horse_Blue_win",},
        [2] = {2,"绿耳",3,3,"802","绿耳，青黄色的马，穆王八骏之一，日行千里，不知疲倦。",120002,"所有","999",0,"0","Horse_Blue_win",},
        [3] = {3,"渠黄",3,3,"803","渠黄，如其名全身鹅黄色，穆王八骏之一，一形十影，速度极快。",120003,"所有","999",0,"0","Horse_Blue_win",},
        [4] = {4,"枣骝",3,3,"804","枣骝，全身褐色，肌如钢铁，力气很大，负百斤之重，仍可健步如飞。",120004,"所有","999",0,"0","Horse_Blue_win",},
        [5] = {5,"雪里白",4,4,"805","雪里白，通体雪白，蹄为黑者，踏雪如履平地，马之君子。",120005,"所有","999",0,"effect_zhuangbei_purple_di","Horse_Purple_win",},
        [6] = {6,"飒露紫",4,4,"806","飒露紫，如紫色飞燕，傲骨嶙嶙，气愚三川，威凌八阵。",120006,"所有","999",0,"effect_zhuangbei_purple_di","Horse_Purple_win",},
        [7] = {7,"红玉辇",4,4,"807","红玉辇，体如红玉，吉祥如意，真龙天子之驹。",120007,"所有","999",0,"effect_zhuangbei_purple_di","Horse_Purple_win",},
        [8] = {8,"碧骢驹",4,4,"808","碧骢驹，体呈青白，身形健硕，奔跑似龙行天际，速度快且型美。",120008,"所有","999",0,"effect_zhuangbei_purple_di","Horse_Purple_win",},
        [9] = {9,"飞霜千里",5,5,"809","飞霜千里，身体雪白似冰霜，神秘轻盈，行万里不知疲惫，所过之处如飞霜过境，寒气逼人，让人无法靠近。",120009,"辅助类","103|110|112|117|118|153|204|211|304|315|404|412|417",40,"effect_taozhuang_orange","Horse_Orange_win_01",},
        [10] = {10,"乌云踏雪",5,5,"812","乌云踏雪，通体如黑缎子一般，油光放亮，唯有四个马蹄部位白得赛雪，背长腰短而平直，四肢关节筋腱发育壮实，身覆重甲，从一而终。",120010,"输出类","1|2|3|4|5|11|12|13|14|15|101|107|108|109|111|113|114|150|201|205|206|208|209|213|217|218|250|253|301|306|308|310|316|318|350|403|406|407|410|413|414|416|450|453",999,"effect_taozhuang_orange","Horse_Orange_win_04",},
        [11] = {11,"胭脂火龙",5,5,"811","胭脂火龙，浑身上下，火炭般赤，无半根杂毛，嘶喊咆哮，有腾空入海之状，鬃卷似江波，又如少女发丝般柔软，行速如飞，过川登山，如履平地。",120011,"治疗类","102|152|202|302|402|216",999,"effect_taozhuang_orange","Horse_Orange_win_03",},
        [12] = {12,"夜照玉狮",5,5,"810","夜照玉狮，一色雪白，仅脖子尾巴覆金色毛发，大蹄，宛如雄狮一般，性格暴烈，既能日行千里，亦能跨越天险，出入战场如入无人之境。",120012,"辅助、控制类","103|104|106|110|112|115|116|117|118|150|151|153|203|204|210|211|212|214|219|251|252|304|307|312|315|317|350|351|352|353|401|404|408|409|411|412|415|419|417|451|452",999,"effect_taozhuang_orange","Horse_Orange_win_02",},
        [13] = {15,"奔雷青骢",5,5,"815","万里追电拦路虎，举世无双一奔雷。头带闪电，脚踏幽光，奔跑时如疾雷呼啸而过。通晓人性，耐力持久，助英雄在战场上屡立奇功。",120015,"肉盾类","105|119|207|215|309|314|405|418",999,"effect_taozhuang_orange","Horse_Orange_win_04",},
        [14] = {13,"神·爪黄飞电",6,6,"801","神·爪黄飞电，通体雪白，四蹄为黄，气质高贵非凡，傲气不可一世，与众不同，枭雄帝王之驹。",120013,"所有","999",9999,"effect_taozhuang_red_down|effect_taozhuang_red_up","",},
        [15] = {14,"神·的卢追月",6,6,"801","神·的卢追月，凶悍凌厉，速度之快可及日月，既能穿行水中，又能一越三丈，跃溪跨潭不在话下。",120014,"所有","999",9999,"effect_taozhuang_red_down|effect_taozhuang_red_up","",},
        [16] = {16,"铁血红鬃",5,5,"816","铁衣霜露重，怒马扬红鬃。飞舞的红色鬃毛如火焰，灼烧铁血马蹄踏过之地，焚尽世间一切不平之事。",120016,"纵火类","303|305|311|313|319",999,"effect_taozhuang_orange","Horse_Orange_win_01",},
        [17] = {17,"暗夜紫骍",5,5,"817","鸣笳朱鹭起，叠鼓紫骍豪。她是黑夜中的精灵，从幽暗中吸取生命之光，默默守护着英雄们，披荆斩棘，一路前行。",120017,"所有","999",999,"effect_taozhuang_orange","Horse_Orange_win_02",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 14,
    [14] = 15,
    [15] = 13,
    [16] = 16,
    [17] = 17,
    [2] = 2,
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
    [11] = 11,
    [12] = 12,
    [14] = 13,
    [15] = 14,
    [13] = 15,
    [16] = 16,
    [17] = 17,
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
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in horse")
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
function horse.length()
    return #horse._data
end

-- 
function horse.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function horse.isVersionValid(v)
    if horse.version then
        if v then
            return horse.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function horse.indexOf(index)
    if index == nil or not horse._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/horse.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/horse.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/horse.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "horse" )
                _isDataExist = horse.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "horse" )
                _isBaseExist = horse.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "horse" )
                _isExist = horse.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "horse" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "horse" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = horse._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "horse" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function horse.get(id)
    
    return horse.indexOf(__index_id[id])
        
end

--
function horse.set(id, key, value)
    local record = horse.get(id)
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
function horse.index()
    return __index_id
end

return horse