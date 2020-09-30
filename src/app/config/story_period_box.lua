--story_period_box

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  title = 2,    --阶段标题-string 
  chapter = 3,    --领取条件-int 
  type = 4,    --奖励类型-int 
  value = 5,    --奖励类型值-int 
  size = 6,    --奖励数量-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  title = "string",    --阶段标题-2 
  chapter = "int",    --领取条件-3 
  type = "int",    --奖励类型-4 
  value = "int",    --奖励类型值-5 
  size = "int",    --奖励数量-6 

}


-- data
local story_period_box = {
    version =  1,
    _data = {
        [1] = {1,"通关第3回领取",3,5,1,500,},
        [2] = {2,"通关第6回领取",6,5,1,800,},
        [3] = {3,"通关第8回领取",8,6,112,1,},
        [4] = {4,"通关第10回领取",10,6,7,2,},
        [5] = {5,"通关第14回领取",14,6,7,2,},
        [6] = {6,"通关第16回领取",16,6,7,2,},
        [7] = {7,"通关第18回领取",18,6,7,2,},
        [8] = {8,"通关第20回领取",20,6,7,5,},
        [9] = {9,"通关第22回领取",22,6,7,2,},
        [10] = {10,"通关第24回领取",24,6,7,2,},
        [11] = {11,"通关第26回领取",26,6,7,2,},
        [12] = {12,"通关第28回领取",28,6,7,2,},
        [13] = {13,"通关第30回领取",30,6,7,5,},
        [14] = {14,"通关第32回领取",32,6,7,2,},
        [15] = {15,"通关第34回领取",34,6,7,2,},
        [16] = {16,"通关第36回领取",36,6,7,2,},
        [17] = {17,"通关第38回领取",38,6,7,2,},
        [18] = {18,"通关第40回领取",40,6,7,5,},
        [19] = {19,"通关第42回领取",42,6,7,2,},
        [20] = {20,"通关第44回领取",44,6,7,2,},
        [21] = {21,"通关第46回领取",46,6,7,2,},
        [22] = {22,"通关第48回领取",48,6,7,2,},
        [23] = {23,"通关第50回领取",50,6,7,5,},
        [24] = {24,"通关第52回领取",52,6,7,5,},
        [25] = {25,"通关第54回领取",54,6,7,5,},
        [26] = {26,"通关第56回领取",56,6,7,5,},
        [27] = {27,"通关第58回领取",58,6,7,5,},
        [28] = {28,"通关第60回领取",60,6,7,10,},
        [29] = {29,"通关第62回领取",62,6,7,5,},
        [30] = {30,"通关第64回领取",64,6,7,5,},
        [31] = {31,"通关第66回领取",66,6,7,5,},
        [32] = {32,"通关第68回领取",68,6,7,5,},
        [33] = {33,"通关第70回领取",70,6,7,10,},
        [34] = {34,"通关第72回领取",72,6,7,5,},
        [35] = {35,"通关第74回领取",74,6,7,5,},
        [36] = {36,"通关第76回领取",76,6,7,5,},
        [37] = {37,"通关第78回领取",78,6,7,5,},
        [38] = {38,"通关第80回领取",80,6,7,10,},
        [39] = {39,"通关第82回领取",82,6,7,5,},
        [40] = {40,"通关第84回领取",84,6,7,5,},
        [41] = {41,"通关第86回领取",86,6,7,5,},
        [42] = {42,"通关第88回领取",88,6,7,5,},
        [43] = {43,"通关第90回领取",90,6,7,10,},
        [44] = {44,"通关第92回领取",92,6,7,5,},
        [45] = {45,"通关第94回领取",94,6,7,5,},
        [46] = {46,"通关第96回领取",96,6,7,5,},
        [47] = {47,"通关第98回领取",98,6,7,5,},
        [48] = {48,"通关第100回领取",100,6,7,10,},
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
        assert(key_map[k], "cannot find " .. k .. " in story_period_box")
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
function story_period_box.length()
    return #story_period_box._data
end

-- 
function story_period_box.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function story_period_box.isVersionValid(v)
    if story_period_box.version then
        if v then
            return story_period_box.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function story_period_box.indexOf(index)
    if index == nil or not story_period_box._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/story_period_box.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/story_period_box.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/story_period_box.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "story_period_box" )
                _isDataExist = story_period_box.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "story_period_box" )
                _isBaseExist = story_period_box.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "story_period_box" )
                _isExist = story_period_box.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "story_period_box" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "story_period_box" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = story_period_box._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "story_period_box" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function story_period_box.get(id)
    
    return story_period_box.indexOf(__index_id[id])
        
end

--
function story_period_box.set(id, key, value)
    local record = story_period_box.get(id)
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
function story_period_box.index()
    return __index_id
end

return story_period_box