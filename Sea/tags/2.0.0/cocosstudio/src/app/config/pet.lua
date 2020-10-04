--pet

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  name = 2,    --名称-string 
  color = 3,    --品质-int 
  res_id = 4,    --资源id-int 
  description = 5,    --宠物描述-string 
  description1 = 6,    --show宠物描述1-string 
  description2 = 7,    --show宠物描述2-string 
  skill_name = 8,    --show宠物技能名称-string 
  skill_description = 9,    --show宠物技能描述-string 
  star_max = 10,    --星级上限-int 
  moving = 11,    --神兽特效-string 
  combat_base = 12,    --基础属性假战力-int 
  atk_base = 13,    --初始攻击-int 
  pdef_base = 14,    --初始物防-int 
  mdef_base = 15,    --初始魔防-int 
  hp_base = 16,    --初始生命-int 
  atk_grow = 17,    --成长攻击-int 
  pdef_grow = 18,    --成长物防-int 
  mdef_grow = 19,    --成长魔防-int 
  hp_grow = 20,    --成长生命-int 
  potential_after = 21,    --界限突破后id-int 
  potential_before = 22,    --界限突破前id-int 
  hit_base = 23,    --初始命中-int 
  crit_base = 24,    --初始暴击-int 
  blessing_rate = 25,    --护佑千分比-int 
  soul = 26,    --分解兽魂-int 
  coin = 27,    --出售银两-int 
  fragment_id = 28,    --碎片id-int 
  voice = 29,    --语音-string 
  is_fight = 30,    --无差别竞技里是否可用-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  name = "string",    --名称-2 
  color = "int",    --品质-3 
  res_id = "int",    --资源id-4 
  description = "string",    --宠物描述-5 
  description1 = "string",    --show宠物描述1-6 
  description2 = "string",    --show宠物描述2-7 
  skill_name = "string",    --show宠物技能名称-8 
  skill_description = "string",    --show宠物技能描述-9 
  star_max = "int",    --星级上限-10 
  moving = "string",    --神兽特效-11 
  combat_base = "int",    --基础属性假战力-12 
  atk_base = "int",    --初始攻击-13 
  pdef_base = "int",    --初始物防-14 
  mdef_base = "int",    --初始魔防-15 
  hp_base = "int",    --初始生命-16 
  atk_grow = "int",    --成长攻击-17 
  pdef_grow = "int",    --成长物防-18 
  mdef_grow = "int",    --成长魔防-19 
  hp_grow = "int",    --成长生命-20 
  potential_after = "int",    --界限突破后id-21 
  potential_before = "int",    --界限突破前id-22 
  hit_base = "int",    --初始命中-23 
  crit_base = "int",    --初始暴击-24 
  blessing_rate = "int",    --护佑千分比-25 
  soul = "int",    --分解兽魂-26 
  coin = "int",    --出售银两-27 
  fragment_id = "int",    --碎片id-28 
  voice = "string",    --语音-29 
  is_fight = "int",    --无差别竞技里是否可用-30 

}


-- data
local pet = {
    _data = {
        [1] = {1,"熊猫",3,701,"熊猫，又称食铁兽，熊猫爸爸凶猛有力，熊猫宝宝聪明呆萌，父子组合，所向披靡","熊猫爸爸凶猛有力，熊猫宝宝聪明呆萌","父子组合，所向披靡","[破胆咆哮]","对敌方单体造成伤害",5,"0",600000,10000,5000,5000,75000,300,150,150,2250,0,0,1000,0,0,2250,0,100001,"pet_701_idle2",0,},
        [2] = {2,"灵鹿",3,702,"灵鹿，生长在天地间的神奇灵物，鹿角为天地灵气凝结而成，灵气绽放时可助人起死回生。","生长在天地间的神奇灵物","鹿角为天地灵气凝结而成","[花繁叶茂]","治疗己方生命最少的队友",5,"0",600000,10000,5000,5000,75000,300,150,150,2250,0,0,1000,0,0,2250,0,100002,"pet_702_idle2",0,},
        [3] = {3,"烈火狐",4,704,"烈火狐，传说此狐三尾，四爪带火，凶戾高傲，但恩怨分明，有仇报仇，有恩报恩。","三尾，四爪带火","恩怨分明，有仇报仇，有恩报恩","[火狐卷尾]","对敌方后排造成伤害",5,"0",720000,12000,6000,6000,90000,350,175,175,2625,0,0,1000,0,0,4800,0,100003,"pet_704_idle2",0,},
        [4] = {4,"紫青鸾",4,703,"紫青鸾，羽色华丽，紫中带青。古人视赤色为凤，青色为鸾。传说青鸾为爱情的象征，唱歌时会给心诚之人带来桃花运。","羽色华丽，紫中带青","传说是爱情的象征","[风卷残云]","对敌方前排造成伤害",5,"0",720000,12000,6000,6000,90000,350,175,175,2625,0,0,1000,0,0,4800,0,100004,"0",0,},
        [5] = {5,"雷霆白虎",5,706,"雷霆白虎，四神兽之一，通体雪白，紫光流溢，可御使雷电之力。","通体雪白，紫光流溢","可御使雷电之力","[曜日奔雷]","战前减怒，战中再减怒",5,"effect_taozhuang_orange",1200000,20000,10000,10000,150000,400,200,200,3000,0,0,1000,0,0,24000,0,100005,"pet_706_idle2",1,},
        [6] = {6,"沧海青龙",5,705,"沧海青龙，四神兽之首，自古就是祥瑞的象征。东方青龙，角亢之精，吐云郁炁，啖雷发声，飞翔八极，周游四冥，来立吾左。","四神兽之首","自古就是祥瑞的象征","[青龙之怒]","恢复我方成员怒气",5,"effect_taozhuang_orange",1200000,20000,10000,10000,150000,400,200,200,3000,106,0,1000,0,0,24000,0,100006,"pet_705_idle2",1,},
        [7] = {7,"赤炎朱雀",5,707,"赤炎朱雀，百鸟之王，四大神兽中的颜值担当。主火，唯美而暴力，自歌自舞，预示着吉祥安宁，蓬勃腾达。","能继燃灼烧之物","能接引灵魂上升于天","[业炎焚天]","对敌方全体被灼烧目标造成伤害",5,"effect_taozhuang_orange",1200000,20000,10000,10000,150000,400,200,200,3000,0,0,1000,0,0,24000,0,100007,"pet_707_idle2",1,},
        [8] = {8,"裂天玄武",5,708,"裂天玄武，四神兽之一，龟、蛇组成的灵物，自古就是长生不老的象征。玄武者，北方壬癸水黑汞也，能柔能刚，非铅非锡非众石之类，水乃河东神水，生乎天地之先，至药不可暂舍，能养育万物。","龟蛇组合成的灵物","长生不老的象征","[玄武之佑]","给我方成员附加护盾",5,"effect_taozhuang_orange",1200000,20000,10000,10000,150000,400,200,200,3000,0,0,1000,0,0,24000,0,100008,"pet_708_idle2",1,},
        [9] = {9,"北冥圣鲲",5,709,"鲲出自《庄子·逍遥游》：“北冥有鱼，其名为鲲。鲲之大，不知其几千里也。”明代德清《庄子内篇注》云：“北冥即北海，以旷远非世人所见之地，以喻玄冥大道。海中之鲲，以喻大道体中养成大圣之胚胎，喻如大鲲，非北海之大不能养成也。”","北冥有鱼，其名为鲲","鲲之大，不知其几千里也","[云梦逍遥]","清除我方成员眩晕状态",5,"effect_taozhuang_orange",1200000,20000,10000,10000,150000,400,200,200,3000,0,0,1000,0,0,24000,0,100009,"0",1,},
        [10] = {10,"雷火麒麟",5,710,"雷火麒麟，与凤龟龙谓之四灵，游必泽土，祥而后处，不履生虫，不践生草，王者有出，辨善恶通天理。","千年祥瑞神灵","辨善恶通天理","[天命抉择]","对敌方随机目标造成生命上限50%的伤害",5,"effect_taozhuang_orange",1200000,20000,10000,10000,150000,400,200,200,3000,0,0,1000,0,0,24000,0,100010,"pet_710_idle2",1,},
        [11] = {11,"麟华年兽",5,711,"传说中每逢岁末时出没在人间的幼年凶兽，眼若铜铃，来去如风，金身流彩，威风凛凛；性如幼童般活泼好动，十分喜爱热闹。","金身流彩，威风凛凛","性如幼童般活泼好动","[燎竹天降]","血量低于一定值的目标会被斩杀",5,"effect_taozhuang_orange",1200000,20000,10000,10000,150000,400,200,200,3000,0,0,1000,0,0,24000,0,100011,"pet_711_idle2",1,},
        [12] = {12,"天瑞白泽",5,712,"象征着祥瑞的白泽，通人语，通万物之情，晓天下万物状貌，是令人逢凶化吉的吉祥之兽。","晓天下万物状貌","逢凶化吉","[幽雨流光]","回合开始前放逐敌方目标",5,"effect_taozhuang_orange",1200000,20000,10000,10000,150000,400,200,200,3000,0,0,1000,0,0,24000,0,100012,"pet_712_idle2",1,},
        [13] = {106,"神·青龙",6,705,"沧海青龙，四神兽之首，自古就是祥瑞的象征。东方青龙，角亢之精，吐云郁炁，啖雷发声，飞翔八极，周游四冥，来立吾左。","四神兽之首","自古就是祥瑞的象征","[青龙之怒]","恢复我方成员怒气",5,"effect_taozhuang_orange",1200000,20000,10000,10000,150000,400,200,200,3000,0,6,1000,0,0,24000,0,100006,"pet_705_idle2",0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [106] = 13,
    [11] = 11,
    [12] = 12,
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
        assert(__key_map[k], "cannot find " .. k .. " in pet")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function pet.length()
    return #pet._data
end

-- 
function pet.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function pet.indexOf(index)
    if index == nil or not pet._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/pet.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "pet" )
        return setmetatable({_raw = pet._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = pet._data[index]}, mt)
end

--
function pet.get(id)
    
    return pet.indexOf(__index_id[id])
        
end

--
function pet.set(id, key, value)
    local record = pet.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function pet.index()
    return __index_id
end

return pet