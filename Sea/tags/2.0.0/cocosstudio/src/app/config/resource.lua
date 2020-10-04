--resource

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --资源id-int 
  name = 2,    --资源名称-string 
  color = 3,    --品质-int 
  res_id = 4,    --美术资源-int 
  drop_group = 5,    --掉落分组-int 
  description = 6,    --道具描述-string 
  is_recover = 7,    --是否恢复-int 

}

-- key type
local __key_type = {
  id = "int",    --资源id-1 
  name = "string",    --资源名称-2 
  color = "int",    --品质-3 
  res_id = "int",    --美术资源-4 
  drop_group = "int",    --掉落分组-5 
  description = "string",    --道具描述-6 
  is_recover = "int",    --是否恢复-7 

}


-- data
local resource = {
    _data = {
        [1] = {1,"元宝",5,1,3,"建功立业必不可少，可招募名将和购买道具。",0,},
        [2] = {2,"银两",3,2,3,"硬通货，装备强化、武将突破等等都能用到。",0,},
        [3] = {3,"体力",4,3,3,"挑战主线、精英、名将副本时需要消耗体力。",1,},
        [4] = {4,"精力",4,4,3,"游历时需要消耗的重要资源。",1,},
        [5] = {5,"经验",4,5,3,"挑战主线副本、游历和进行冒险都能获得经验。",0,},
        [6] = {6,"贵族经验",5,6,3,"提高VIP等级可以解锁更多VIP功能。",0,},
        [7] = {7,"威望",4,7,3,"可在竞技场商店兑换武将碎片或突破丹。",0,},
        [8] = {8,"功勋",4,8,3,"可在神兵商店兑换神兵和神兵进阶石。",0,},
        [9] = {9,"将魂",4,9,1,"可在神将商店兑换武将、突破丹、银两和杜康。",0,},
        [10] = {10,"精铁",4,10,2,"可在装备商店兑换装备和装备精炼石。",0,},
        [11] = {11,"南蛮令",4,11,0,"攻击南蛮消耗的次数",1,},
        [12] = {12,"挑战次数",4,11,0,"过关斩将的挑战次数，过关斩将可获得大量装备。",1,},
        [13] = {13,"军团贡献",4,13,0,"可在军团商店兑换武将或高价值道具。",0,},
        [14] = {14,"神魂",4,14,0,"可在觉醒商店兑换觉醒时消耗的道具。",0,},
        [15] = {15,"神兵之魂",4,10,0,"回收神兵可以获得，可以在神兵商店兑换神兵和神兵进阶石",0,},
        [16] = {16,"充值额度",5,10,0,"使用可以获得累计充值、单笔充值活动中的充值额度。",0,},
        [17] = {17,"宝物之魂",4,17,0,"可在宝物商店兑换宝物和宝物进阶石。",0,},
        [18] = {18,"军团声望",4,18,0,"累积军团声望可提升军团等级。",0,},
        [19] = {19,"兽魂",4,19,0,"可在神兽商店兑换神兽或神兽相关的资源。",0,},
        [20] = {20,"水晶",5,20,0,"充值可以获得的高级资源，在水晶商店中使用。",0,},
        [21] = {21,"充值积分",5,21,0,"充值获得充值积分，在水晶商店获得大量奖励。",0,},
        [22] = {22,"粮草",4,22,0,"在矿战中移动需要消耗粮草。",1,},
        [23] = {23,"攻击令",4,23,0,"在矿战中每次攻击消耗1次攻击次数。",1,},
        [24] = {24,"变身碎片",4,24,0,"可在身外化身活动期间在变身卡商店兑换变身卡。",0,},
        [25] = {25,"追击次数",4,25,0,"可在割须弃袍活动期间追击曹操获得各种奖励。",0,},
        [26] = {26,"观星次数",4,26,0,"可在卧龙观星活动期间观星获得各种奖励。",0,},
        [27] = {27,"专属充值额度",5,10,0,"使用可以获得累计充值、单笔充值活动中的专属充值额度。",0,},
        [28] = {28,"马魂",4,28,0,"可在战马商店中兑换战马",0,},
        [29] = {29,"刀币",4,29,0,"可在王者商店中兑换红装及红色锦囊。",0,},
        [30] = {30,"玉魂",4,30,0,"可在原石商店中兑换原石。",0,},
        [31] = {31,"功绩",4,31,0,"可在周年庆商店中兑换珍稀资源。",0,},
        [32] = {32,"蟠螭龙之魂",5,32,0,"可在见龙在田活动商店中兑换珍稀资源。",0,},
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
        assert(__key_map[k], "cannot find " .. k .. " in resource")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function resource.length()
    return #resource._data
end

-- 
function resource.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function resource.indexOf(index)
    if index == nil or not resource._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/resource.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "resource" )
        return setmetatable({_raw = resource._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = resource._data[index]}, mt)
end

--
function resource.get(id)
    
    return resource.indexOf(__index_id[id])
        
end

--
function resource.set(id, key, value)
    local record = resource.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function resource.index()
    return __index_id
end

return resource