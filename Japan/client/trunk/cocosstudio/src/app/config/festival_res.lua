--festival_res

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --排序id-int 
  res_type = 2,    --类型-int 
  res_name = 3,    --资源名称-string 
  icon = 4,    --function_id-int 
  front_eft = 5,    --前层特效（最前面）-string 
  back_eft = 6,    --远景特效（远景前，中景后）-string 
  if_blind = 7,    --底部ui是否带窗帘（1-带，2-不带）-int 
  res_id = 8,    --资源1-界面内标题/说明背景-string 
  res_id_2 = 9,    --资源2-界面周边背景/说明标题衬底-string 
  res_id_3 = 10,    --资源3-大底框-string 
  res_id_4 = 11,    --资源4-按钮-string 
  color_1 = 12,    --说明标题色-string 
  color_2 = 13,    --说明文本色-string 
  color_3 = 14,    --说明文本特殊色-string 
  color_4 = 15,    --警告文本色-string 
  color_4_1 = 16,    --警告文本描边色-string 
  color_5 = 17,    --按钮上的字色-string 
  res_zoom = 18,    --缩小比例-int 

}

-- key type
local __key_type = {
  id = "int",    --排序id-1 
  res_type = "int",    --类型-2 
  res_name = "string",    --资源名称-3 
  icon = "int",    --function_id-4 
  front_eft = "string",    --前层特效（最前面）-5 
  back_eft = "string",    --远景特效（远景前，中景后）-6 
  if_blind = "int",    --底部ui是否带窗帘（1-带，2-不带）-7 
  res_id = "string",    --资源1-界面内标题/说明背景-8 
  res_id_2 = "string",    --资源2-界面周边背景/说明标题衬底-9 
  res_id_3 = "string",    --资源3-大底框-10 
  res_id_4 = "string",    --资源4-按钮-11 
  color_1 = "string",    --说明标题色-12 
  color_2 = "string",    --说明文本色-13 
  color_3 = "string",    --说明文本特殊色-14 
  color_4 = "string",    --警告文本色-15 
  color_4_1 = "string",    --警告文本描边色-16 
  color_5 = "string",    --按钮上的字色-17 
  res_zoom = "int",    --缩小比例-18 

}


-- data
local festival_res = {
    version =  1,
    _data = {
        [1] = {1,1,"欢庆佳节-夏季通用",639,"huodongxiaji","",0,"res/ui3/happyholiday/img_holiay_changshuangshengxia_txt01.png","ui3/happyholiday/xiari_di.jpg","ui3/happyholiday/img_holiay_changshuangshengxia_board01.png","ui3/happyholiday/happyholiday_an.png","","","","0x8fb0dc","","0xd7efff",1000,},
        [2] = {2,3,"说明-夏季通用",0,"","",0,"ui3/happyholiday/happyholiday_yuanxiao_bg02.jpg","ui3/happyholiday/img_holiay_changshuangshengxia_txtbg01.png","","","0xe76b52","0xb66511","0x2f9f07","","","",1000,},
        [3] = {3,1,"欢庆佳节-通用",627,"huodong_guoqing","huodongguoqing_back",0,"res/ui3/happyholiday/img_holiay_guoqing_txt01.png","ui3/happyholiday/img_holiay_guoqing_bg01.jpg","ui3/happyholiday/img_holiay_guoqing_board01.png","ui3/happyholiday/happyholiday_an.png","","","","0x8fb0dc","","0xd7efff",1000,},
        [4] = {4,3,"说明-通用",0,"","",0,"ui3/happyholiday/happyholiday_yuanxiao_bg02.jpg","ui3/happyholiday/img_holiay_changshuangshengxia_txtbg01.png","","","0xe76b52","0xb66511","0x2f9f07","","","",1000,},
        [5] = {5,1,"欢庆佳节-七夕新版",640,"huodong_qixiwugui","",0,"res/ui3/happyholiday/qixi_biaotou.png","ui3/happyholiday/qixi_bg.jpg","ui3/happyholiday/qixi_kuang.png","ui3/happyholiday/qixi_button.png","","","","0xefc0ff","","0xf5dbff",1000,},
        [6] = {6,3,"说明-七夕新版",0,"","",0,"ui3/happyholiday/happyholiday_yuanxiao_bg02.jpg","ui3/happyholiday/diban_wenben03.png","","","0xe76b52","0xb66511","0x2f9f07","","","",1000,},
        [7] = {7,4,"宣传-七夕新版",0,"","",0,"res/ui3/happyholiday/qixi.jpg","","","","","","","","","",1000,},
        [8] = {8,1,"欢庆佳节-合服",629,"huodong_guoqing","huodongguoqing_back",0,"res/ui3/happyholiday/img_holiay_guoqing_txt02.png","res/ui3/happyholiday/img_holiay_guoqing_bg01.jpg","res/ui3/happyholiday/img_holiay_guoqing_board01.png","ui3/happyholiday/happyholiday_an.png","","","","0x8fb0dc","","0xd7efff",1000,},
        [9] = {9,3,"说明-合服",0,"","",0,"ui3/happyholiday/happyholiday_yuanxiao_bg02.jpg","res/ui3/happyholiday/img_holiay_changshuangshengxia_txtbg01.png","","","0xe76b52","0xb66511","0x2f9f07","","","",1000,},
        [10] = {10,4,"宣传-国庆",0,"","",0,"res/ui3/happyholiday/guoqing.jpg","","","","","","","","","",1000,},
        [11] = {11,1,"欢庆佳节-秋季通用",642,"huodongqiuri_front","huodongqiuri_back",0,"res/ui3/happyholiday/img_holiay_qiurihuodong_title01.png","ui3/happyholiday/img_holiay_qiurihuodong_bg01.png","ui3/happyholiday/img_holiay_qiurihuodong_board01.png","ui3/happyholiday/happyholiday_an.png","","","","0x8fb0dc","","0xd7efff",1000,},
        [12] = {12,3,"说明-秋季通用",0,"","",0,"","ui3/happyholiday/img_holiay_changshuangshengxia_txtbg01.png","","","0xe76b52","0xb66511","0x2f9f07","","","",1000,},
        [13] = {13,1,"欢庆佳节-双11狂欢",643,"huodongshuangshiyi_front","huodongshuangshiyi_back",0,"res/ui3/happyholiday/img_holiay_shuangshiyi_txt01.png","ui3/happyholiday/img_shuangshiyi.jpg","ui3/happyholiday/img_holiay_shuangshiyi_board01.png","ui3/happyholiday/anniu_shuangshiyi01.png","","","","0x8fb0dc","","0xffdcbf",1000,},
        [14] = {14,3,"说明-双11狂欢",0,"","",0,"","ui3/happyholiday/img_holiay_changshuangshengxia_txtbg01.png","","","0xe76b52","0xb66511","0x2f9f07","","","",1000,},
        [15] = {15,1,"欢庆佳节-年终盛典",644,"huodongshuangshiyi_front","huodongshuangshiyi_back",0,"res/ui3/happyholiday/img_holiay_nianzhonshengdian_txt01.png","ui3/happyholiday/img_shuangshiyi.jpg","ui3/happyholiday/img_holiay_shuangshiyi_board01.png","ui3/happyholiday/anniu_shuangshiyi01.png","","","","0xdfc8c1","0x854f45","0xffdcbf",1000,},
        [16] = {16,3,"说明-年终盛典",0,"","",0,"","ui3/happyholiday/img_holiay_changshuangshengxia_txtbg01.png","","","0xe76b52","0xb66511","0x2f9f07","","","",1000,},
        [17] = {17,1,"欢庆佳节-快乐圣诞",645,"shengdanjie_ui_front","shengdanjie_ui_back",0,"res/ui3/happyholiday/img_holiay_shengdanjie_txt01.png","ui3/happyholiday/img_shengdanjie.jpg","ui3/happyholiday/img_holiay_shengdanjie_board01.png","ui3/happyholiday/anniu_shengdanjie01.png","","","","0xeef6f9","0x56adcc","0xffc5a6",1000,},
        [18] = {18,3,"说明-快乐圣诞",0,"","",0,"ui3/happyholiday/happyholiday_yuanxiao_bg02.jpg","ui3/happyholiday/img_holiay_changshuangshengxia_txtbg01.png","","","0xe76b52","0xb66511","0x2f9f07","","","",1000,},
        [19] = {19,1,"欢庆佳节-喜迎新春-废弃",633,"xiyingxinchun_ui","xiyingxinchun_back",0,"res/ui3/happyholiday/img_holiay_chunjie_title01.png","ui3/happyholiday/chunjie_bg.jpg","ui3/happyholiday/img_holiay_chunjie_board01.png","ui3/happyholiday/anniu_chunjie02.png","","","","0xeef6f9","0x991d21","0xffc5a6",1000,},
        [20] = {20,3,"说明-喜迎新春",0,"","",0,"","ui3/happyholiday/img_holiay_changshuangshengxia_txtbg01.png","","","0xe76b52","0xb66511","0x2f9f07","","","",1000,},
        [21] = {53,1,"欢庆佳节-和煦阳春",647,"huodong_chunjihuodong","",0,"ui3/happyholiday/img_holiay_hexuyangchun_txt01.png","ui3/happyholiday/img_hexuyangchun.jpg","ui3/happyholiday/img_holiay_hexuyangchun_board01.png","ui3/happyholiday/anniu_chunjie02.png","","","","0xffffff","0x991d21","0xffd460",1000,},
        [22] = {54,3,"说明-和煦阳春",0,"","",0,"","ui3/happyholiday/img_holiay_changshuangshengxia_txtbg01.png","","","0xe76b52","0xb66511","0x2f9f07","","","",1000,},
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
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [53] = 21,
    [54] = 22,
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
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [21] = 53,
    [22] = 54,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in festival_res")
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
function festival_res.length()
    return #festival_res._data
end

-- 
function festival_res.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function festival_res.isVersionValid(v)
    if festival_res.version then
        if v then
            return festival_res.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function festival_res.indexOf(index)
    if index == nil or not festival_res._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/festival_res.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/festival_res.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/festival_res.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "festival_res" )
                _isDataExist = festival_res.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "festival_res" )
                _isBaseExist = festival_res.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "festival_res" )
                _isExist = festival_res.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "festival_res" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "festival_res" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = festival_res._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "festival_res" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function festival_res.get(id)
    
    return festival_res.indexOf(__index_id[id])
        
end

--
function festival_res.set(id, key, value)
    local record = festival_res.get(id)
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
function festival_res.index()
    return __index_id
end

return festival_res