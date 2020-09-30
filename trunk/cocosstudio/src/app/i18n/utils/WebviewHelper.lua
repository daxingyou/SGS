local WebviewHelper = {}

local http_header = "http://"
local https_header = "https://"
local local_header = "local://"

local cut_1 = "&"
local cut_2 = "="
-- local://?extension=213&game_system_id=33
-- for k,v in ipairs(cList) do
--     if k ==  #kList then
--         map[v] = value
--         break
--     end
--     if not map[v] then
--         map[v] = {}
--     end
--     map = map[v]
-- end

-- local function WebviewHelper.getParams(url,header,cut)
--     print("WebviewHelper.getParams url=" .. url .. " header=" ..header )
--     if not url then return nil end
--     local params = {}
-- 	local cList = {...}

--     local httpInfos = string.split(url,header)
--     if httpInfos and #httpInfos > 1 then
--         local infoStr = httpInfos[2]
--         print("WebviewHelper.getParams infoStr=" .. infoStr )
--         local Infos = string.split(infoStr,cut)
--         if Infos and #Infos > 1 and  cList and #cList > 1 then
--             for key, value in pairs(Infos) do
--                 local objs = string.split(value,cList[1])
--                 params[objs[1]] = objs[2]
--                 print("WebviewHelper.getParams key=" .. objs[1] .. " value=" .. objs[2] )
--             end
--         end

--     end
--     dump(params,"WebviewHelper.getParams params")
--     return params
-- end


function WebviewHelper.isLocalUrl(url)
    if string.find(url,local_header) then
        return true
    else
        return false
    end
end

function WebviewHelper.isHttpUrl(url)
    if string.find(url,http_header) or string.find(url,https_header) then
        return true
    else
        return false
    end
end

function WebviewHelper.getLocalParams(url)
    if not url then return nil end
    local params = {}
    local header = local_header.."?"
    local httpInfos = string.split(url,header)
    if httpInfos and #httpInfos > 1 then
        local infoStr = httpInfos[2]
        print("WebviewHelper.getLocalParams infoStr=" .. infoStr )
        local Infos = string.split(infoStr,cut_1)
        if Infos and #Infos > 1 then
            for key, value in pairs(Infos) do
                local objs = string.split(value,cut_2)
                params[objs[1]] = objs[2]
                print("WebviewHelper.getLocalParams key=" .. objs[1] .. " value=" .. objs[2] )
            end
        end
    end
    dump(params,"WebviewHelper.getLocalParams params")
    return params
	-- return WebviewHelper.getParams(url,local_header.."?",cut_1，cut_2)
end


return WebviewHelper
