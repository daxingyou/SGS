local KeyValueUrlRequest = class("KeyValueUrlRequest")
local scheduler = require("cocos.framework.scheduler")
local PrioritySignal = require("yoka.event.PrioritySignal")
local ServerConst = require("app.const.ServerConst")
function KeyValueUrlRequest:ctor(isAllServers)
    self._isAllServers = isAllServers -- 账户参数，全服统一
    self.signal = PrioritySignal.new("KeyValueUrlRequest_get")
    self.signalSet = PrioritySignal.new("KeyValueUrlRequest_set")
end

function KeyValueUrlRequest:clear()
end

function KeyValueUrlRequest:reset()
end

 
function KeyValueUrlRequest:doRequestSetKeyValue(key,value,isShowWaiting)
    local send = function ()
        local url = KEY_VALUE_SET_URL_TEMPLATE
        url = string.gsub(url, "#domain#",KEY_VALUE_URL)
        logWarn("ddd"..G_GameAgent:getTopUserId())
        local uuid =  string.urlencode(G_GameAgent:getTopUserId())
        url = string.gsub(url, "#uuid#", uuid)
        local serverId = tostring(G_GameAgent:getLoginServer():getServer())
        if self._isAllServers then
            serverId = "0"
        end
        url = string.gsub(url, "#server_id#",serverId)
        url = string.gsub(url, "#field#",key)
        url = string.gsub(url, "#field_value#",tostring(value))
        local a = key .. ","..value.."#"..ServerConst.SECRET_KEY_LIST[1]
        local content = md5.sum(a)
        url = string.gsub(url, "#sign#",  tostring(content))
    
        local xhr = cc.XMLHttpRequest:new()
        xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
        xhr:open("POST", url)

		
        local function onReadyStateChange()
            if isShowWaiting then
                G_WaitingMask:showWaiting(false)
            end
            local e = "fail"
            local param = nil
            print("KeyValueUrlRequest:doRequestSetKeyValue url = ", url)
            print("readyState"..xhr.readyState)
            if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
                print("result"..xhr.response)
                local response = json.decode(xhr.response)
                dump(response)
                if response and tonumber(response.ret)== 1 then
                    e = eventName or "success"
                    param = response
                end
            else  
                local msgInfo = require("app.config.net_msg_error").get(2000005)
                if msgInfo.error_msg then
                    G_Prompt:showTip(msgInfo.error_msg)
                    
                end    
            end
            xhr:unregisterScriptHandler()
            self.signalSet:dispatch(e,param)
        end
        
        xhr.timeout = 5000
        xhr:registerScriptHandler(onReadyStateChange)
        xhr:send()
    end
    if isShowWaiting then
        G_WaitingMask:showWaiting(true)
    end
    send()
end
 
function KeyValueUrlRequest:doRequestGetKeyValue(key,isShowWaiting)
    local send = function ()
        logWarn("ddd"..string.urlencode(G_GameAgent:getTopUserId()))
        local url = KEY_VALUE_GET_URL_TEMPLATE
        url = string.gsub(url, "#domain#",KEY_VALUE_URL)
        local uuid =  string.urlencode(G_GameAgent:getTopUserId())
        url = string.gsub(url, "#uuid#", uuid)
        local serverId = tostring(G_GameAgent:getLoginServer():getServer())
        if self._isAllServers then
            serverId = "0"
        end
        url = string.gsub(url, "#server_id#",serverId)
        url = string.gsub(url, "#field#",key)
        local a = key .."#"..ServerConst.SECRET_KEY_LIST[1]
        local content = md5.sum(a)
        url = string.gsub(url, "#sign#",  tostring(content))
    
        local xhr = cc.XMLHttpRequest:new()
        xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
        xhr:open("POST", url)

		
        local function onReadyStateChange()
            if isShowWaiting then
                G_WaitingMask:showWaiting(false)
            end
            local e = "fail"
            local param = nil
            print("KeyValueUrlRequest:doRequestGetKeyValue url = ", url)
            print("readyState"..xhr.readyState)
            if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
                print("result"..xhr.response)
                local response = json.decode(xhr.response)
                if response and tonumber(response.ret)== 1 then
                    
                    e = eventName or "success"
                    param = response
                end
            else 
                local msgInfo = require("app.config.net_msg_error").get(2000005)
                if msgInfo.error_msg then
                    G_Prompt:showTip(msgInfo.error_msg)

                end
            end
            xhr:unregisterScriptHandler()
            self.signal:dispatch(e,param)
        end
 
        xhr.timeout = 5000
        xhr:registerScriptHandler(onReadyStateChange)
        xhr:send()
    end
    if isShowWaiting then
        G_WaitingMask:showWaiting(true)
    end
    send()
end


return KeyValueUrlRequest