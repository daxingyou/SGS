--vip_voice_library

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --语音库id-int 
  voice1 = 2,    --语音1-string 
  length = 3,    --语音长度-int 
  skin_id = 4,    --皮肤id-int 
  skin_action = 5,    --动作-string 

}

-- key type
local __key_type = {
  id = "int",    --语音库id-1 
  voice1 = "string",    --语音1-2 
  length = "int",    --语音长度-3 
  skin_id = "int",    --皮肤id-4 
  skin_action = "string",    --动作-5 

}


-- data
local vip_voice_library = {
    version =  1,
    _data = {
        [1] = {1,"KANBAN_Voice2",4000,0,"huanying",},
        [2] = {2,"KANBAN_Voice3",3700,0,"huanying",},
        [3] = {3,"KANBAN_Voice4",4100,0,"huanying",},
        [4] = {4,"KANBAN_Voice5",5900,0,"zhuyi",},
        [5] = {5,"KANBAN_Voice6",8000,0,"liaotoufa",},
        [6] = {6,"KANBAN_Voice1",11200,0,"huanying",},
        [7] = {7,"KANBAN_Voice13",1200,0,"bixin2",},
        [8] = {8,"KANBAN_Voice14",3400,0,"bixin",},
        [9] = {9,"KANBAN_Voice15",1900,0,"bixin2",},
        [10] = {10,"KANBAN_Voice16",6200,0,"bixin",},
        [11] = {11,"KANBAN_Voice17",7000,0,"bixin2",},
        [12] = {12,"KANBAN_Voice18",7500,0,"zhuyi",},
        [13] = {13,"KANBAN_Voice19",2000,0,"deyi",},
        [14] = {14,"KANBAN_Voice20",1600,0,"liaotoufa",},
        [15] = {15,"KANBAN_Voice21",3000,0,"deyi",},
        [16] = {16,"KANBAN_Voice22",2800,0,"zhuyi",},
        [17] = {17,"KANBAN_Voice23",3300,0,"liaotoufa",},
        [18] = {18,"KANBAN_Voice24",1900,0,"liaotoufa",},
        [19] = {19,"KANBAN_Voice25",10300,0,"huanying",},
        [20] = {20,"KANBAN_Voice26",1700,0,"haixiu",},
        [21] = {21,"KANBAN_Voice27",2000,0,"huanying",},
        [22] = {22,"KANBAN_Voice28",4300,0,"deyi",},
        [23] = {23,"KANBAN_Voice29",4800,0,"zayan",},
        [24] = {24,"KANBAN_Voice69",800,0,"zayan",},
        [25] = {25,"KANBAN_Voice70",900,0,"liaotoufa",},
        [26] = {26,"KANBAN_Voice71",600,0,"deyi",},
        [27] = {27,"KANBAN_Voice72",1000,0,"deyi",},
        [28] = {28,"KANBAN_Voice73",800,0,"zhuyi",},
        [29] = {29,"KANBAN_Voice74",1600,0,"xuemao",},
        [30] = {30,"KANBAN_Voice75",1100,0,"deyi",},
        [31] = {31,"KANBAN_Voice76",1100,0,"xuemao",},
        [32] = {32,"KANBAN_Voice77",1400,0,"xuemao",},
        [33] = {33,"KANBAN_Voice30",3000,0,"zayan",},
        [34] = {34,"KANBAN_Voice31",3700,0,"haixiu",},
        [35] = {35,"KANBAN_Voice32",3900,0,"haixiu",},
        [36] = {36,"KANBAN_Voice33",4200,0,"bixin2",},
        [37] = {37,"KANBAN_Voice34",4000,0,"xuemao",},
        [38] = {38,"KANBAN_Voice35",4100,0,"bixin",},
        [39] = {39,"KANBAN_Voice36",2900,0,"haixiu",},
        [40] = {40,"KANBAN_Voice37",3000,0,"haixiu",},
        [41] = {41,"KANBAN_Voice38",8000,0,"bixin2",},
        [42] = {42,"KANBAN_Voice39",9800,0,"huanying",},
        [43] = {43,"KANBAN_Voice40",6600,0,"haixiu",},
        [44] = {44,"KANBAN_Voice41",13100,0,"haixiu",},
        [45] = {45,"KANBAN_Voice9",6600,3,"deyi",},
        [46] = {46,"KANBAN_Voice8",5300,3,"liaotoufa",},
        [47] = {47,"KANBAN_Voice53",7200,3,"zayan",},
        [48] = {48,"KANBAN_Voice54",8300,3,"deyi",},
        [49] = {49,"KANBAN_Voice61",6500,3,"liaotoufa",},
        [50] = {50,"KANBAN_Voice10",5100,3,"bixin",},
        [51] = {51,"KANBAN_Voice11",5300,3,"bixin2",},
        [52] = {52,"KANBAN_Voice65",9800,3,"deyi",},
        [53] = {53,"KANBAN_Voice7",5200,0,"huanying",},
        [54] = {54,"",0,0,"zayan",},
        [55] = {55,"KANBAN_Voice42",8600,0,"bixin2",},
        [56] = {56,"",0,0,"haixiu",},
        [57] = {57,"KANBAN_Voice43",3800,0,"huanying",},
        [58] = {58,"KANBAN_Voice44",5600,0,"haixiu",},
        [59] = {59,"KANBAN_Voice45",7200,0,"huanying",},
        [60] = {60,"KANBAN_Voice46",10400,0,"bixin2",},
        [61] = {61,"KANBAN_Voice47",5400,0,"zhuyi",},
        [62] = {62,"KANBAN_Voice48",5500,0,"liaotoufa",},
        [63] = {63,"KANBAN_Voice49",5700,0,"zhuyi",},
        [64] = {64,"KANBAN_Voice50",5100,0,"zhuyi",},
        [65] = {65,"KANBAN_Voice51",14100,0,"zhuyi",},
        [66] = {66,"KANBAN_Voice52",8200,0,"haixiu",},
        [67] = {67,"KANBAN_Voice55",6000,0,"deyi",},
        [68] = {68,"KANBAN_Voice56",10600,0,"deyi",},
        [69] = {69,"KANBAN_Voice57",9000,0,"deyi",},
        [70] = {70,"KANBAN_Voice58",5900,0,"liaotoufa",},
        [71] = {71,"KANBAN_Voice59",7700,0,"deyi",},
        [72] = {72,"KANBAN_Voice60",4800,0,"xuemao",},
        [73] = {73,"KANBAN_Voice62",10000,0,"bixin",},
        [74] = {74,"KANBAN_Voice12",6400,0,"bixin2",},
        [75] = {75,"KANBAN_Voice63",6800,0,"huanying",},
        [76] = {76,"KANBAN_Voice64",7200,0,"huanying",},
        [77] = {77,"KANBAN_Voice66",8200,0,"huanying",},
        [78] = {78,"KANBAN_Voice67",4300,0,"liaotoufa",},
        [79] = {79,"KANBAN_Voice68",4100,0,"zhuyi",},
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
    [49] = 49,
    [5] = 5,
    [50] = 50,
    [51] = 51,
    [52] = 52,
    [53] = 53,
    [54] = 54,
    [55] = 55,
    [56] = 56,
    [57] = 57,
    [58] = 58,
    [59] = 59,
    [6] = 6,
    [60] = 60,
    [61] = 61,
    [62] = 62,
    [63] = 63,
    [64] = 64,
    [65] = 65,
    [66] = 66,
    [67] = 67,
    [68] = 68,
    [69] = 69,
    [7] = 7,
    [70] = 70,
    [71] = 71,
    [72] = 72,
    [73] = 73,
    [74] = 74,
    [75] = 75,
    [76] = 76,
    [77] = 77,
    [78] = 78,
    [79] = 79,
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
    [49] = 49,
    [5] = 5,
    [50] = 50,
    [51] = 51,
    [52] = 52,
    [53] = 53,
    [54] = 54,
    [55] = 55,
    [56] = 56,
    [57] = 57,
    [58] = 58,
    [59] = 59,
    [6] = 6,
    [60] = 60,
    [61] = 61,
    [62] = 62,
    [63] = 63,
    [64] = 64,
    [65] = 65,
    [66] = 66,
    [67] = 67,
    [68] = 68,
    [69] = 69,
    [7] = 7,
    [70] = 70,
    [71] = 71,
    [72] = 72,
    [73] = 73,
    [74] = 74,
    [75] = 75,
    [76] = 76,
    [77] = 77,
    [78] = 78,
    [79] = 79,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in vip_voice_library")
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
function vip_voice_library.length()
    return #vip_voice_library._data
end

-- 
function vip_voice_library.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function vip_voice_library.isVersionValid(v)
    if vip_voice_library.version then
        if v then
            return vip_voice_library.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function vip_voice_library.indexOf(index)
    if index == nil or not vip_voice_library._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/vip_voice_library.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/vip_voice_library.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/vip_voice_library.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "vip_voice_library" )
                _isDataExist = vip_voice_library.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "vip_voice_library" )
                _isBaseExist = vip_voice_library.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "vip_voice_library" )
                _isExist = vip_voice_library.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "vip_voice_library" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "vip_voice_library" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = vip_voice_library._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "vip_voice_library" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function vip_voice_library.get(id)
    
    return vip_voice_library.indexOf(__index_id[id])
        
end

--
function vip_voice_library.set(id, key, value)
    local record = vip_voice_library.get(id)
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
function vip_voice_library.index()
    return __index_id
end

return vip_voice_library