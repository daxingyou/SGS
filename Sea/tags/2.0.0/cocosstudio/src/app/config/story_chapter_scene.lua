--story_chapter_scene

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --地图id-int 
  background = 2,    --背景图-string 
  front_front = 3,    --前层前景-string 
  front_back = 4,    --前层后景-string 
  mid_front = 5,    --中层前景-string 
  mid_back = 6,    --中层后景-string 
  back_front = 7,    --后层前景-string 
  differ_front_value = 8,    --前中景像素差值-int 
  differ_value = 9,    --中后景像素差值-int 

}

-- key type
local __key_type = {
  id = "int",    --地图id-1 
  background = "string",    --背景图-2 
  front_front = "string",    --前层前景-3 
  front_back = "string",    --前层后景-4 
  mid_front = "string",    --中层前景-5 
  mid_back = "string",    --中层后景-6 
  back_front = "string",    --后层前景-7 
  differ_front_value = "int",    --前中景像素差值-8 
  differ_value = "int",    --中后景像素差值-9 

}


-- data
local story_chapter_scene = {
    _data = {
        [1] = {1,"wall","moving_scene01_front","","moving_scene01_qizi","moving_scene01_middle","moving_scene01_back",0,400,},
        [2] = {2,"yellow","moving_scene02_front","","moving_scene02_middle","","moving_scene02_back",400,400,},
        [3] = {3,"palace","","","moving_huanggong_middle","","",0,400,},
        [4] = {4,"pavilion","moving_fengyiting_front","","moving_fengyiting_middle","","moving_fengyiting_back",0,0,},
        [5] = {5,"gate","moving_gongchengmenguanqia_front","","moving_gongchengmenguanqia_middle","","",0,400,},
        [6] = {6,"hulao","moving_hulaoguan_front","","moving_hulaoguan_middle","","moving_hulaoguan_back",0,400,},
        [7] = {7,"luoyang","","","moving_luoyang_middle","","moving_luoyang_back",0,0,},
        [8] = {8,"nanman","moving_nanman_front","","moving_nanman_middle","","moving_nanman_back",0,400,},
        [9] = {9,"taoyuan","moving_taoyuanguanqia_front","","moving_taoyuanguanqia_middle","","moving_taoyuanguanqia_back",0,0,},
        [10] = {10,"xuchang","moving_xuchangguanqia_front","","moving_xuchangguanqia_middle","","",0,0,},
        [11] = {11,"xiangyang","moving_xiangyangguanqia_front","","moving_xiangyangguanqia_middle","","moving_xiangyangguanqia_back",0,0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
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
        assert(__key_map[k], "cannot find " .. k .. " in story_chapter_scene")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function story_chapter_scene.length()
    return #story_chapter_scene._data
end

-- 
function story_chapter_scene.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function story_chapter_scene.indexOf(index)
    if index == nil or not story_chapter_scene._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/story_chapter_scene.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "story_chapter_scene" )
        return setmetatable({_raw = story_chapter_scene._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = story_chapter_scene._data[index]}, mt)
end

--
function story_chapter_scene.get(id)
    
    return story_chapter_scene.indexOf(__index_id[id])
        
end

--
function story_chapter_scene.set(id, key, value)
    local record = story_chapter_scene.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function story_chapter_scene.index()
    return __index_id
end

return story_chapter_scene