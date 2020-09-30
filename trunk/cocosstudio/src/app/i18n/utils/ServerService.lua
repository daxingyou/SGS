local ServerService = class("ServerService")

--
function ServerService:ctor(network)
    self:_initSeverI18nData()
    self._networkManager = network
    self._networkManager:addReceive(handler(self, self._onNetReceiveEvent))
end

function ServerService:_getSeverI18nData()
    local data = {}
    local initIndexPath = Path.getLangServerKeyJson(Path.lang_server_init_index)
    assert(Path.isExist(initIndexPath), "Could not read the server init json file with path: "..tostring(initIndexPath))
    local initData = Lang.decodeJsonFile(initIndexPath)
    for i,v in ipairs(initData) do
        local jsonPath = Path.getLangServerKeyJson(v,"")
        -- print("[ServerService] jsonPath:" .. jsonPath)
        if Path.isExist(jsonPath) then
            -- print("[ServerService]  json isExist 1")
            local jsonData = Lang.decodeJsonFile(jsonPath)
            -- dump(jsonData,"jsonData")
            for k,v in pairs(jsonData) do
                data[k] = v
            end  
            -- dump(data,"data")
        end 
    end
    -- dump(data,"[ServerService] data")
    return data
end

function ServerService:_initSeverI18nData()
     Lang.ServerKeyData = self:_getSeverI18nData()
end

-- 检查返回协议
function ServerService:_onNetReceiveEvent(msgId, content)
    -- print("[ServerService] msgId:" .. msgId)
    -- if msgId .. "" == "30008" then
        -- dump(content,msgId)
        --i18n
        self:_arenaNameReplaceI18n(msgId, content)
        self:_onServerTxtFiltering(content)
        self:_dealChannelStr(msgId, content)
    -- end
end

--
function ServerService:_onServerTxtFiltering(content)
    if content == nil or type(content) ~= "table" then
		return 
    end
    local pattern = "_{%w+_%w+_[%w_]+}_"
    for k,v in pairs(content) do
        -- print("[ServerService] k:" .. k)
        -- dump(v,"[ServerService] v:")
        -- print("[ServerService] v type:" .. type(v))
        if type(v) == "table" then
            self:_onServerTxtFiltering(v)
        end
        if type(v) == "string" and string.find(v, pattern)  then   -- "${ _ _ }$"  "${5582_9a_102018}$"
            -- content[k] = Lang.getServerText(v)
            v = self:_onServerTxtReplace(v)
            content[k] = v
            -- print("[ServerService] server Text:" .. content[k])
        end
    end
end

function ServerService:_onServerTxtReplace(strInput)
    if strInput == nil or type(strInput) ~= "string" then
		return strInput
    end
    -- print("[ServerService] server replace str 1:" .. strInput)
    local pattern = "_{%w+_%w+_[%w_]+}_"
    local start, stop = string.find(strInput,pattern)
    -- print ("start: " .. start .. " stop:" .. stop)
    local sum = string.len(strInput)
    local strCost = ""
    -- print ("sum: " .. sum)
    repeat
        if start then
            if strCost == "" then
                strCost = strInput
            end
            local content = strCost

            -- print ("content : " .. content)
            local key = string.sub(content, start, stop)
            local value = Lang.getServerText(key)
            -- print ("key: " .. key)
            -- print ("value: " .. value)
            strInput = string.gsub(strInput, key, value)
            -- print ("strInput: " .. strInput)
            local resum = string.len(content)
            -- print ("stop: " .. stop)
            -- print ("resum: " .. resum)
            if stop < resum  then 
                -- print ("resatrt: " .. resatrt)
                strCost = string.sub(strCost, stop + 1)
            else 
                strCost = ""
            end
            -- print ("strCost : " .. strCost)
        end
        start, stop = string.find(strCost,pattern)
        -- if start then  print ("start: " .. start) end
        -- if stop then  print ("stop: " .. stop) end
    until not start
    -- print("[ServerService] server replace str 2:" .. strInput)
    return strInput
end

--
function ServerService:reset()
    -- print("[ServerService] reset")
end

-- 清理队列
function ServerService:clear()
    -- self:reset()
end

--i18n 解析机器人名字 ，地方id|姓id|名id|性别 ，英泰地区竞技场机器人姓名颠倒
function ServerService:_arenaNameReplaceI18n(msgId, content)
    local replaceName = function (content)
        content = content or ""
        local list = string.split(content,"|")
        if #list == 4 then
            local Name1Place = require("app.config.name1_place")
            local Name2Surname = require("app.config.name2_surname")
            local Name3Name = require("app.config.name3_name")
            local placeName = Name1Place.get(checkint(list[1]))
            local surName = Name2Surname.get(checkint(list[2]))
            local name = Name3Name.get(checkint(list[3]))
            local sex = checkint(list[4])
            local result = ""
            if surName and name and (sex == 1 or sex == 2) then
                if placeName then
                    result = placeName.place
                end
                if sex == 1 then
                    result = result .. surName.surname .. name.name_boy
                else
                    result = result .. surName.surname .. name.name_girl
                end
                return result
            end
        end
    end

    if msgId == MessageIDConst.ID_S2C_GetArenaInfo then
        local list = rawget(content, "to_challenge_list") or {}
        for i=1,#list do
            list[i].name = replaceName(list[i].name) or list[i].name
        end
    elseif msgId == MessageIDConst.ID_S2C_GetNormalBattleReport then
        local report = rawget(content, "report")
        if report then
            report.defense_name = replaceName(report.defense_name) or report.defense_name
        end
    elseif msgId == MessageIDConst.ID_S2C_CommonGetReport then
        local report = rawget(content, "arena_reports") or {}
        for i=1,#report do
            report[i].name = replaceName(report[i].name) or report[i].name
        end
    elseif msgId == MessageIDConst.ID_S2C_GetArenaTopTenReport then
        local report = rawget(content, "report") or {}
        for i=1,#report do
            report[i].defense.user.name = replaceName(report[i].defense.user.name) or report[i].defense.user.name
        end
    end
end


function ServerService:_replaceFieldContent(content,filterFieldName)
    if content == nil or type(content) ~= "table" then
        return 
    end
    for k,v in pairs(content) do
        if type(v) == "table" then
            self:_replaceFieldContent(v,filterFieldName)
        end
        if type(v) == "string" and filterFieldName[k] then  
            --logWarn(k .." xxxxxxx "..v)
            content[k] = Lang.getLangTxtFromChannel(v) 
            --logWarn(k .." okokokok "..content[k])
        end
    end
end


function ServerService:_dealChannelStr(msgId,content)
    if msgId == MessageIDConst.ID_S2C_RollNotice then
        local RollNoticeConst = require("app.const.RollNoticeConst")
        if RollNoticeConst.NOTICE_TYPE_GM == content.notice_type then
            content.msg = Lang.getLangTxtFromChannel(content.msg) 
        end
    end
    if msgId == MessageIDConst.ID_S2C_UpdateCustomActivity or 
        msgId == MessageIDConst.ID_S2C_GetCustomActivityInfo then
        local filterFieldName = {quest_des=true,title=true,sub_title=true,desc=true,detail = true}
        Lang.replaceFieldContent(content,filterFieldName) 
    end
    if msgId == MessageIDConst.ID_S2C_BulletNotice or 
       msgId == MessageIDConst.ID_S2C_UpdateRankCakeAndNotice or 
       msgId == MessageIDConst.ID_S2C_AddGuildCakeExp or 
       msgId == MessageIDConst.ID_S2C_EnterCakeActivity then
        local filterFieldName = {value=true}
        Lang.replaceFieldContent(content,filterFieldName) 
    end
    local filterFieldName = {server_name=true,real_server_name=true,sname = true,svr_name = true,sender_server_name = true}
    self:_replaceFieldContent(content,filterFieldName)

end

return ServerService
