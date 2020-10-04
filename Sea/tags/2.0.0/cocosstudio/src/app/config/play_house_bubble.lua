--play_house_bubble

-- key
local __key_map = {
  rank = 1,    --名次-int 
  bubble_time = 2,    --说话时间低-string 
  probability = 3,    --说话概率-string 
  text_1 = 4,    --文本1-string 
  text_2 = 5,    --文本2-string 
  text_3 = 6,    --文本3-string 
  text_4 = 7,    --文本4-string 
  text_5 = 8,    --文本5-string 

}

-- data
local play_house_bubble = {
    _data = {
        [1] = {1,"1,30|31,60|61,90","800|800|800","第一名临时文本1","第一名临时文本2","第一名临时文本3","第一名临时文本4","第一名临时文本5",},
        [2] = {2,"1,30|31,60|61,90","800|800|800","第二名临时文本1","第二名临时文本2","第二名临时文本3","第二名临时文本4","第二名临时文本5",},
        [3] = {3,"1,30|31,60|61,90","800|800|800","第三名临时文本1","第三名临时文本2","第三名临时文本3","第三名临时文本4","第三名临时文本5",},
        [4] = {4,"1,30|31,60|61,90","800|800|800","第四名临时文本1","第四名临时文本2","第四名临时文本3","第四名临时文本4","第四名临时文本5",},
        [5] = {5,"1,30|31,60|61,90","800|800|800","第五名临时文本1","第五名临时文本2","第五名临时文本3","第五名临时文本4","第五名临时文本5",},
    }
}

-- index
local __index_rank = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in play_house_bubble")
        return t._raw[__key_map[k]]
    end
}

-- 
function play_house_bubble.length()
    return #play_house_bubble._data
end

-- 
function play_house_bubble.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function play_house_bubble.indexOf(index)
    if index == nil or not play_house_bubble._data[index] then
        return nil
    end

    return setmetatable({_raw = play_house_bubble._data[index]}, mt)
end

--
function play_house_bubble.get(rank)
    
    return play_house_bubble.indexOf(__index_rank[rank])
        
end

--
function play_house_bubble.set(rank, key, value)
    local record = play_house_bubble.get(rank)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function play_house_bubble.index()
    return __index_rank
end

return play_house_bubble