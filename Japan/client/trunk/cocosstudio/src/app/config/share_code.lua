--share_code

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序列-int 
  channel = 2,    --渠道名-string 
  package = 3,    --包名-string 
  QR_code = 4,    --二维码文件名-string 

}

-- key type
local __key_type = {
  id = "int",    --序列-1 
  channel = "string",    --渠道名-2 
  package = "string",    --包名-3 
  QR_code = "string",    --二维码文件名-4 

}


-- data
local share_code = {
    version =  1,
    _data = {
        [1] = {1,"游卡","default","qr_yoka_default",},
        [2] = {2,"黑马101","default","qr_101_default",},
        [3] = {3,"黑马101","com.tencent.tmgp.gzyx.tdsg","qr_101_guozi",},
        [4] = {4,"黑马101","com.tencent.tmgp.yueke.tdsg","qr_101_guozi",},
        [5] = {5,"黑马101","com.tencent.tmgp.tdsghhflb","qr_101_guozi",},
        [6] = {6,"黑马101","com.tencent.tmgp.tdsgssj","qr_101_guozi",},
        [7] = {7,"黑马101","com.guoziyx.zhsg","qr_101_guozi",},
        [8] = {8,"黑马101","com.guoziyx.jssg","qr_101_guozi",},
        [9] = {9,"黑马101","com.guoziyx.sgmjz","qr_101_guozi",},
        [10] = {10,"黑马101","com.guoziyx.htjw","qr_101_guozi",},
        [11] = {11,"黑马101","com.guoziyx.mjtx","qr_101_guozi",},
        [12] = {12,"黑马101","com.guoziyx.kpsgz","qr_101_guozi",},
        [13] = {13,"黑马101","com.guoziyx.tdsg","qr_101_guozi",},
        [14] = {14,"黑马101","com.guoziyx.htbyw","qr_101_guozi",},
        [15] = {15,"黑马101","com.guoziyx.gssg","qr_101_guozi",},
        [16] = {16,"黑马101","com.guoziyx.lhj","qr_101_guozi",},
        [17] = {17,"黑马101","com.guoziyx.sgsww","qr_101_guozi",},
        [18] = {18,"黑马101","com.tencent.tmgp.yjsg2","qr_101_bawuhou",},
        [19] = {19,"黑马101","com.sgs.sgnxjqb","qr_101_bawuhou",},
        [20] = {20,"黑马101","com.bw.bjtx.xiwan","qr_101_bawuhou",},
        [21] = {21,"黑马101","com.bw.yjsglg.xiwan","qr_101_bawuhou",},
        [22] = {22,"黑马101","com.bw.yjsgvc.xiwan","qr_101_bawuhou",},
        [23] = {23,"黑马101","com.bw.jjsgz.xiwan","qr_101_bawuhou",},
        [24] = {24,"黑马101","com.bw.lssgz.xiwan","qr_101_bawuhou",},
        [25] = {25,"黑马101","com.tencent.tmgp.bwahjy2","qr_101_bawuhou",},
        [26] = {26,"黑马101","com.tencent.tmgp.bwmjsgxw2","qr_101_bawuhou",},
        [27] = {27,"黑马101","com.bw.mjsgz.xiwan","qr_101_bawuhou",},
        [28] = {28,"黑马101","com.tencent.tmgp.xwyjssj","qr_101_bawuhou",},
        [29] = {29,"黑马101","com.tencent.tmgp.yjmj","qr_101_bawuhou",},
        [30] = {30,"黑马101","com.tencent.tmgp.yjsgxxz","qr_101_bawuhou",},
        [31] = {31,"黑马101","com.tencent.tmgp.yjsgsjz","qr_101_bawuhou",},
        [32] = {32,"黑马101","com.tencent.tmgp.yjsg4","qr_101_bawuhou",},
        [33] = {33,"黑马101","com.tencent.tmgp.yjsgsnsj","qr_101_bawuhou",},
        [34] = {34,"黑马101","com.tencent.tmgp.yjsgjpmj","qr_101_bawuhou",},
        [35] = {35,"黑马101","com.tencent.tmgp.yjsgqyz","qr_101_bawuhou",},
        [36] = {36,"黑马103","default","qr_103_default",},
        [37] = {37,"黑马105","default","qr_105_default",},
        [38] = {38,"6kw","default","qr_6kw_default",},
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
        assert(key_map[k], "cannot find " .. k .. " in share_code")
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
function share_code.length()
    return #share_code._data
end

-- 
function share_code.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function share_code.isVersionValid(v)
    if share_code.version then
        if v then
            return share_code.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function share_code.indexOf(index)
    if index == nil or not share_code._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/share_code.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/share_code.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/share_code.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "share_code" )
                _isDataExist = share_code.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "share_code" )
                _isBaseExist = share_code.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "share_code" )
                _isExist = share_code.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "share_code" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "share_code" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = share_code._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "share_code" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function share_code.get(id)
    
    return share_code.indexOf(__index_id[id])
        
end

--
function share_code.set(id, key, value)
    local record = share_code.get(id)
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
function share_code.index()
    return __index_id
end

return share_code