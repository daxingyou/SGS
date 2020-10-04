--territory_performance

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  name = 2,    --城池名称-string 
  pre_id = 3,    --前置城池-int 
  monster_team_id = 4,    --守关怪物组-int 
  attack_lv = 5,    --攻打等级-int 
  clearance_reward_type1 = 6,    --通关奖励类型1-int 
  clearance_reward_value1 = 7,    --通关奖励类型值1-int 
  clearance_reward_size1 = 8,    --通关奖励数量1-int 
  clearance_reward_type2 = 9,    --通关奖励类型2-int 
  clearance_reward_value2 = 10,    --通关奖励类型值2-int 
  clearance_reward_size2 = 11,    --通关奖励数量2-int 
  clearance_reward_type3 = 12,    --通关奖励类型3-int 
  clearance_reward_value3 = 13,    --通关奖励类型值3-int 
  clearance_reward_size3 = 14,    --通关奖励数量3-int 
  drop_type1 = 15,    --显示掉落道具类型1-int 
  drop_value1 = 16,    --显示掉落道具类型值1-int 
  drop_type2 = 17,    --显示掉落道具类型2-int 
  drop_value2 = 18,    --显示掉落道具类型值2-int 
  drop_type3 = 19,    --显示掉落道具类型3-int 
  drop_value3 = 20,    --显示掉落道具类型值3-int 
  drop_type4 = 21,    --显示掉落道具类型4-int 
  drop_value4 = 22,    --显示掉落道具类型值4-int 
  drop_type5 = 23,    --显示掉落道具类型5-int 
  drop_value5 = 24,    --显示掉落道具类型值5-int 
  help_sign = 25,    --求助标志-string 
  harvest_icon = 26,    --收获图标-string 
  hero_id = 27,    --守关武将-int 
  hero_name = 28,    --守关武将名字-string 
  hero_quality = 29,    --守关武将品质-int 
  hero_bubble_id = 30,    --守关武将对话-int 
  fight_value = 31,    --战力显示-int 
  patrol_hero_bubble = 32,    --巡逻武将对话-int 
  start_hero_bubble = 33,    --开始巡逻武将对话-int 
  patrol_over_bubble = 34,    --巡逻结束武将对话-int 
  directions = 35,    --城池描述-string 
  pic = 36,    --城池图-string 
  island_eff = 37,    --城池特效-string 
  npc_value = 38,    --城池NPCid-string 
  npc1_emote_value = 39,    --npc1泡泡-string 
  npc2_emote_value = 40,    --npc2泡泡-string 
  npc1_riot_bubble = 41,    --npc1暴动泡泡-string 
  npc2_riot_bubble = 42,    --npc2暴动泡泡-string 
  back_reward_type1 = 43,    --资源找回奖励类型1-int 
  back_reward_value1 = 44,    --资源找回奖励类型值1-int 
  back_reward_size1 = 45,    --资源找回奖励类型数量1-int 
  back_reward_type2 = 46,    --资源找回奖励类型2-int 
  back_reward_value2 = 47,    --资源找回奖励类型值2-int 
  back_reward_size2 = 48,    --资源找回奖励类型数量2-int 
  back_reward_type3 = 49,    --资源找回奖励类型3-int 
  back_reward_value3 = 50,    --资源找回奖励类型值3-int 
  back_reward_size3 = 51,    --资源找回奖励类型数量3-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  name = "string",    --城池名称-2 
  pre_id = "int",    --前置城池-3 
  monster_team_id = "int",    --守关怪物组-4 
  attack_lv = "int",    --攻打等级-5 
  clearance_reward_type1 = "int",    --通关奖励类型1-6 
  clearance_reward_value1 = "int",    --通关奖励类型值1-7 
  clearance_reward_size1 = "int",    --通关奖励数量1-8 
  clearance_reward_type2 = "int",    --通关奖励类型2-9 
  clearance_reward_value2 = "int",    --通关奖励类型值2-10 
  clearance_reward_size2 = "int",    --通关奖励数量2-11 
  clearance_reward_type3 = "int",    --通关奖励类型3-12 
  clearance_reward_value3 = "int",    --通关奖励类型值3-13 
  clearance_reward_size3 = "int",    --通关奖励数量3-14 
  drop_type1 = "int",    --显示掉落道具类型1-15 
  drop_value1 = "int",    --显示掉落道具类型值1-16 
  drop_type2 = "int",    --显示掉落道具类型2-17 
  drop_value2 = "int",    --显示掉落道具类型值2-18 
  drop_type3 = "int",    --显示掉落道具类型3-19 
  drop_value3 = "int",    --显示掉落道具类型值3-20 
  drop_type4 = "int",    --显示掉落道具类型4-21 
  drop_value4 = "int",    --显示掉落道具类型值4-22 
  drop_type5 = "int",    --显示掉落道具类型5-23 
  drop_value5 = "int",    --显示掉落道具类型值5-24 
  help_sign = "string",    --求助标志-25 
  harvest_icon = "string",    --收获图标-26 
  hero_id = "int",    --守关武将-27 
  hero_name = "string",    --守关武将名字-28 
  hero_quality = "int",    --守关武将品质-29 
  hero_bubble_id = "int",    --守关武将对话-30 
  fight_value = "int",    --战力显示-31 
  patrol_hero_bubble = "int",    --巡逻武将对话-32 
  start_hero_bubble = "int",    --开始巡逻武将对话-33 
  patrol_over_bubble = "int",    --巡逻结束武将对话-34 
  directions = "string",    --城池描述-35 
  pic = "string",    --城池图-36 
  island_eff = "string",    --城池特效-37 
  npc_value = "string",    --城池NPCid-38 
  npc1_emote_value = "string",    --npc1泡泡-39 
  npc2_emote_value = "string",    --npc2泡泡-40 
  npc1_riot_bubble = "string",    --npc1暴动泡泡-41 
  npc2_riot_bubble = "string",    --npc2暴动泡泡-42 
  back_reward_type1 = "int",    --资源找回奖励类型1-43 
  back_reward_value1 = "int",    --资源找回奖励类型值1-44 
  back_reward_size1 = "int",    --资源找回奖励类型数量1-45 
  back_reward_type2 = "int",    --资源找回奖励类型2-46 
  back_reward_value2 = "int",    --资源找回奖励类型值2-47 
  back_reward_size2 = "int",    --资源找回奖励类型数量2-48 
  back_reward_type3 = "int",    --资源找回奖励类型3-49 
  back_reward_value3 = "int",    --资源找回奖励类型值3-50 
  back_reward_size3 = "int",    --资源找回奖励类型数量3-51 

}


-- data
local territory_performance = {
    version =  1,
    _data = {
        [1] = {1,"徐州",0,5100101,1,5,1,300,6,63,20,6,1,2,6,63,5,9,5,2,5,1,0,0,"0","0",305,"太史慈",5,1101,100000,1001,1013,1007,"    徐州作为华东的门户城市，此处环境优美，人杰地灵，其酒文化文明天下，文人雅士常爱在此饮酒作乐，经过历代先人苦心酿造研制，此地盛产杜康。","img_mline_enter01","moving_fudaochengqiang","419|419","1201|1202","1203|1204","1205|1206","1207|1208",5,9,200,6,63,24,0,0,0,},
        [2] = {2,"豫州",1,5100102,1,5,1,500,6,73,20,6,1,2,6,73,5,9,5,2,5,1,0,0,"0","0",315,"张昭",5,1102,250000,1002,1013,1008,"    豫州是华夏文明的发源地，长期位于中国的政治经济和文化中心，孕育出了大批军事人才，此处盛产武将经验道具，将魂等。","fudaoluoyang","moving_fudaoluoyang","419|419","1201|1202","1203|1204","1205|1206","1207|1208",5,9,200,6,73,24,0,0,0,},
        [3] = {3,"荆州",2,5100103,1,5,1,1000,6,3,400,6,1,2,6,3,5,9,5,2,5,1,0,0,"0","0",423,"刘表",5,1103,600000,1003,1013,1009,"    荆州其城名因地处荆山之南而得，此处人杰地灵，出过很多名将怪才，因此地盛产突破丹，同时也是兵家必争之地。","img_mline_enter03","moving_fudaohuanggong","419|419","1201|1202","1203|1204","1205|1206","1207|1208",5,9,200,6,3,200,0,0,0,},
        [4] = {4,"青州",3,5100104,55,5,1,1000,6,13,20,6,1,2,6,13,5,9,5,2,5,1,0,0,"0","0",106,"曹仁",5,1104,2000000,1004,1013,1010,"  “东方属木，木色为青”，故名“青州”。此地矿产资源丰富，铸铁工艺发达，盛产各种装备精炼石、精铁等。","img_mline_enter04","moving_fudaotingyuan","419|419","1201|1202","1203|1204","1205|1206","1207|1208",5,9,200,6,13,12,0,0,0,},
        [5] = {5,"幽州",4,5100105,60,5,1,1000,6,10,100,6,1,2,6,10,5,9,5,2,5,1,0,0,"0","0",202,"刘备",5,1105,5000000,1005,1013,1011,"  《春秋元命包》云：“箕星散为幽州，分为燕国。”言北方太阴，故以幽冥为号。幽州是古九州及汉十三刺史部之一；此地盛产经验宝物，宝物精炼石等宝物养成资源。","fudaodongcheng","moving_fudaodongcheng","419|419","1201|1202","1203|1204","1205|1206","1207|1208",5,9,200,6,10,100,0,0,0,},
        [6] = {6,"兖州",5,5100106,65,5,1,1000,6,19,200,6,1,2,6,19,5,9,5,2,5,1,0,0,"0","0",103,"曹操",5,1106,20000000,1006,1013,1012,"    兖州的这个“兖”字，来源于兖水。兖水又称济水，“兖”字有端信的含义，孔子、孟子等均曾在此讲学，此处盛产神兵进阶石。","fudaojiangjunfu","moving_fudaojiangjunfu","419|419","1201|1202","1203|1204","1205|1206","1207|1208",5,9,200,6,19,300,0,0,0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in territory_performance")
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
function territory_performance.length()
    return #territory_performance._data
end

-- 
function territory_performance.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function territory_performance.isVersionValid(v)
    if territory_performance.version then
        if v then
            return territory_performance.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function territory_performance.indexOf(index)
    if index == nil or not territory_performance._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/territory_performance.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/territory_performance.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/territory_performance.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "territory_performance" )
                _isDataExist = territory_performance.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "territory_performance" )
                _isBaseExist = territory_performance.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "territory_performance" )
                _isExist = territory_performance.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "territory_performance" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "territory_performance" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = territory_performance._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "territory_performance" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function territory_performance.get(id)
    
    return territory_performance.indexOf(__index_id[id])
        
end

--
function territory_performance.set(id, key, value)
    local record = territory_performance.get(id)
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
function territory_performance.index()
    return __index_id
end

return territory_performance