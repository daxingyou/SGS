--tree_buff

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  enable = 2,    --是否启用-int 
  name = 3,    --祝福名称-string 
  type = 4,    --祝福类型-int 
  color_text = 5,    --品质名称-string 
  color = 6,    --品质-int 
  item = 7,    --对应道具-int 
  description = 8,    --祝福描述-string 
  value = 9,    --效果值-int 
  equation = 10,    --前端显示处理算式-string 
  times = 11,    --有效次数/时间s-int 
  appear = 12,    --只出现的星期-string 
  avatar_effect = 13,    --玩家特效-string 
  screen_comment = 14,    --屏幕生效提示-string 
  paomadeng_id = 15,    --跑马灯id-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  enable = "int",    --是否启用-2 
  name = "string",    --祝福名称-3 
  type = "int",    --祝福类型-4 
  color_text = "string",    --品质名称-5 
  color = "int",    --品质-6 
  item = "int",    --对应道具-7 
  description = "string",    --祝福描述-8 
  value = "int",    --效果值-9 
  equation = "string",    --前端显示处理算式-10 
  times = "int",    --有效次数/时间s-11 
  appear = "string",    --只出现的星期-12 
  avatar_effect = "string",    --玩家特效-13 
  screen_comment = "string",    --屏幕生效提示-14 
  paomadeng_id = "int",    --跑马灯id-15 

}


-- data
local tree_buff = {
    version =  1,
    _data = {
        [1] = {1,1,"神灯祈禳",1,"上上签",5,801,"扶我起来继续浪。获得先秦皇陵活动时间#value#分钟。(可突破70分钟上限）",300,"parameter/60",0,"1,2,3,4,5,6,7","","神树祝福·#name#生效，先秦皇陵活动时间增加#value#分钟",0,},
        [2] = {2,1,"神机妙算",3,"上签",4,802,"神机妙算，料事如神。军团答题中自动排除#value#个错误选项。",2,"",86400,"2,4,6","","",0,},
        [3] = {3,1,"乐善好施 ",1,"中签",3,803,"慷慨解囊，乐善好施。获得#value#元宝的军团红包，快发给大家吧！",200,"",0,"1,2,3,4,5,6,7","","神树祝福·#name#生效，获得#value#元宝军团红包",0,},
        [4] = {4,1,"丹书铁券",2,"中签",3,804,"御赐免死金牌，恕你无罪。今日全服答题有#times#次答错免死的机会。",0,"",1,"1,3,5,7","sp_08wudi","神树祝福·#name#生效，本次答错免死",1901,},
        [5] = {5,1,"东山再起",2,"中签",3,805,"失败是成功的爸爸！今日军团试炼前#times#次战斗失败不消耗次数。",0,"",3,"1,2,3,4,5,6,7","","神树祝福·#name#生效，本次失败不消耗挑战次数",0,},
        [6] = {6,1,"骏马良驹",2,"中签",3,806,"千里良驹，展其骥足。马跃檀溪到达终点额外获得#value#本伯乐相马经。",2,"",1,"1,2,3,4,5,6,7","","神树祝福·#name#生效，本次到达终点额外获得#value#本伯乐相马经",0,},
        [7] = {7,1,"战功卓著",2,"上签",4,807,"我家门前有两棵枣树。今日军团试炼战斗胜利获得军团贡献增加#value#%。",1000,"parameter/10",3,"1,2,3,4,5,6,7","","神树祝福·#name#生效，本次获得军团贡献增加#value#%",0,},
        [8] = {8,1,"卷土重来",2,"中签",3,808,"重振旗鼓，卷土重来！军团战被击杀可原地复活#times#次。",0,"",3,"2","","神树祝福·#name#生效，本次战死原地复活",1905,},
        [9] = {9,1,"兵贵神速",3,"上签",4,809,"乘胜追击，兵贵神速。军团战攻击冷却时间减少#value#秒。",1,"",86400,"2","","",0,},
        [10] = {10,1,"兵强马壮",3,"上签",4,810,"兵强马壮，所向披靡。军团战中血量增加#value#%。",200,"parameter/10",86400,"2","","",0,},
        [11] = {11,1,"削铁如泥",3,"上上签",5,811,"攻城略地，削铁如泥。军团战中攻击建筑造成伤害增加#value#%。",1000,"parameter/10",86400,"2","","",0,},
        [12] = {12,1,"无中生有",3,"中签",3,812,"妙手空空，无中生有。挑战军团BOSS过程中可额外抢夺#value#次。",2,"",86400,"1,2,3,4,5,6,7","","",0,},
        [13] = {13,1,"顺手牵羊",3,"中签",3,813,"人无外财不富。挑战军团BOSS过程中抢夺获得积分增加#value#%。",1000,"parameter/10",86400,"1,2,3,4,5,6,7","","神树祝福·#name#生效，本次抢夺积分增加#value#%",1902,},
        [14] = {14,1,"金蝉脱壳",3,"中签",3,814,"金蝉神技，全身而退。挑战军团Boss过程中抢夺失败不消耗次数,不进入冷却。",0,"",86400,"1,2,3,4,5,6,7","","神树祝福·#name#生效，本次失败不消耗抢夺次数",0,},
        [15] = {15,1,"万箭齐发",3,"中签",3,815,"万箭齐发，一往无前。三国战纪中对Boss造成伤害增加#value#%。",1000,"parameter/10",86400,"3,5,7","","神树祝福·#name#生效，本次造成伤害增加#value#%",0,},
        [16] = {16,1,"乾坤一掷",3,"上上签",5,816,"高倍走起，别墅靠海。华容道每次可为单个选手投#value#张支持券。",25,"",86400,"1,2,3,4,5,6,7","","",1903,},
        [17] = {17,1,"粮草先行",2,"上签",4,817,"兵马未动，粮草先行。矿战中移动路过前#times#个矿不消耗粮草。",0,"",10,"1,2,3,4,5,6,7","","神树祝福·#name#生效，本次移动消耗降低",0,},
        [18] = {18,1,"五谷丰登",2,"中签",3,818,"五谷丰登，安居乐业。前#times#次购买粮草价格降低#value#%。",500,"parameter/10",10,"1,2,3,4,5,6,7","","神树祝福·#name#生效，本次购买获得优惠",0,},
        [19] = {19,1,"价廉物美",2,"中签",3,819,"物美价廉，童叟无欺。前#times#次购买攻击令价格降低#value#%。",500,"parameter/10",10,"1,2,3,4,5,6,7","","神树祝福·#name#生效，本次购买获得优惠",0,},
        [20] = {20,1,"浴血奋战",3,"上上签",5,820,"浴血奋战，所向无敌。矿战中攻击敌方，额外造成#value#点兵力损失。",1,"",86400,"1,2,3,4,5,6,7","","神树祝福·#name#生效，本次进攻额外造成兵力损失",0,},
        [21] = {21,0,"",3,"大吉签",5,821,"矿战挖矿收益增加#value#%",100,"parameter/10",86400,"1,2,3,4,5,6,7","","",0,},
        [22] = {22,0,"",2,"中吉签",4,822,"今日马跃檀溪到达终点额外获得#value#本伯乐相马经#times#次",5,"",1,"1,2,3,4,5,6,7","","",0,},
        [23] = {23,0,"慧眼识珠",3,"小吉签",3,823,"南蛮入侵中神孟获发现概率增加#value#%",840000,"parameter/10",86400,"1,2,3,4,5,6,7","","",0,},
        [24] = {24,1,"兵无常势",3,"上上签",5,821,"道法自然，变幻无穷。攻击蓄力状态下的跨服BOSS时，获得自适应的#value#%伤害加成。",500,"parameter/10",86400,"1,3,5,7","","神树祝福·#name#生效，本次造成伤害增加#value#%",0,},
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
        assert(key_map[k], "cannot find " .. k .. " in tree_buff")
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
function tree_buff.length()
    return #tree_buff._data
end

-- 
function tree_buff.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function tree_buff.isVersionValid(v)
    if tree_buff.version then
        if v then
            return tree_buff.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function tree_buff.indexOf(index)
    if index == nil or not tree_buff._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/tree_buff.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/tree_buff.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/tree_buff.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "tree_buff" )
                _isDataExist = tree_buff.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "tree_buff" )
                _isBaseExist = tree_buff.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "tree_buff" )
                _isExist = tree_buff.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "tree_buff" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "tree_buff" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = tree_buff._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "tree_buff" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function tree_buff.get(id)
    
    return tree_buff.indexOf(__index_id[id])
        
end

--
function tree_buff.set(id, key, value)
    local record = tree_buff.get(id)
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
function tree_buff.index()
    return __index_id
end

return tree_buff