--historical_hero

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  type = 2,    --类型-int 
  color = 3,    --品质-int 
  name = 4,    --名称-string 
  res_id = 5,    --资源id-int 
  fragment_id = 6,    --对应碎片id-int 
  arm = 7,    --对应武器id-int 
  is_open = 8,    --图鉴是否开启-int 
  data_open = 9,    --图鉴开启天数-int 
  short_description = 10,    --简要描述-string 
  description = 11,    --描述-string 
  is_step = 12,    --是否可突破-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  type = "int",    --类型-2 
  color = "int",    --品质-3 
  name = "string",    --名称-4 
  res_id = "int",    --资源id-5 
  fragment_id = "int",    --对应碎片id-6 
  arm = "int",    --对应武器id-7 
  is_open = "int",    --图鉴是否开启-8 
  data_open = "int",    --图鉴开启天数-9 
  short_description = "string",    --简要描述-10 
  description = "string",    --描述-11 
  is_step = "int",    --是否可突破-12 

}


-- data
local historical_hero = {
    version =  1,
    _data = {
        [1] = {101,1,4,"高渐离",200101,0,101,1,1,"提高护佑武将生命加成","战国末期燕国琴师，是刺秦壮士荆轲的好友，曾在为秦王击筑时行刺，不幸失败告终。",0,},
        [2] = {102,2,4,"阿轲",200102,0,102,1,1,"提高护佑武将伤害加成","刺秦壮士荆轲的妹妹，在荆轲刺秦失败后，立志要为哥哥报仇雪恨，把刺秦作为自己的目标，并继承了哥哥的名字。",0,},
        [3] = {103,3,4,"韩信",200103,0,103,1,1,"提高护佑武将攻击加成","“汉初三杰”、“兵家四圣”之一，西汉开国功臣，功高无二，国士无双，名闻海内，威震天下。被誉为“兵仙”、“神帅”。",0,},
        [4] = {104,4,4,"张良",200104,0,104,1,1,"提高护佑武将伤害减免加成","被誉为“汉初三杰”的杰出谋臣之一，凭借出色的智谋协助刘邦赢得楚汉战争，建立大汉王朝。被评价“运筹帷幄之中，决胜于千里之外。”",0,},
        [5] = {201,1,5,"秦始皇",200201,130001,201,1,180,"降低护佑武将受到的直接伤害","秦始皇嬴政，中国第一位称皇帝的君主。灭六国完成统一大业，书同文，车同轨，统一度量衡，修筑万里长城。叱咤风云，富有传奇色彩。",1,},
        [6] = {202,2,5,"汉武帝",200202,130002,202,1,180,"提高护佑武将的伤害和治疗","汉武帝刘彻，最伟大的皇帝之一。内修文学，外耀武威。加强集权，独尊儒术，改革币制，开疆扩土。雄才大略，巩固后世基业。",1,},
        [7] = {203,3,5,"项羽",200203,130003,203,1,180,"提高护佑武将获得的神兽效果","西楚霸王，力拔山兮气盖世。具并吞八荒之心，叱咤风云之气，勇冠万夫，智超凡俗，战无不胜，攻无不取。",1,},
        [8] = {204,4,5,"虞姬",200204,130004,204,1,180,"提高护佑武将的御甲和清除异常","霸王项羽的宠姬，容颜倾城，才艺并重，舞姿美艳，并有“虞美人”之称",1,},
    }
}

-- index
local __index_id = {
    [101] = 1,
    [102] = 2,
    [103] = 3,
    [104] = 4,
    [201] = 5,
    [202] = 6,
    [203] = 7,
    [204] = 8,

}

-- index mainkey map
local __main_key_map = {
    [1] = 101,
    [2] = 102,
    [3] = 103,
    [4] = 104,
    [5] = 201,
    [6] = 202,
    [7] = 203,
    [8] = 204,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in historical_hero")
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
function historical_hero.length()
    return #historical_hero._data
end

-- 
function historical_hero.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function historical_hero.isVersionValid(v)
    if historical_hero.version then
        if v then
            return historical_hero.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function historical_hero.indexOf(index)
    if index == nil or not historical_hero._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/historical_hero.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/historical_hero.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/historical_hero.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "historical_hero" )
                _isDataExist = historical_hero.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "historical_hero" )
                _isBaseExist = historical_hero.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "historical_hero" )
                _isExist = historical_hero.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "historical_hero" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "historical_hero" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = historical_hero._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "historical_hero" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function historical_hero.get(id)
    
    return historical_hero.indexOf(__index_id[id])
        
end

--
function historical_hero.set(id, key, value)
    local record = historical_hero.get(id)
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
function historical_hero.index()
    return __index_id
end

return historical_hero