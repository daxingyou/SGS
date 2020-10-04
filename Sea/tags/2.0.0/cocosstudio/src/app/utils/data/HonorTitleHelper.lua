-- @Author panhao
-- @Date 7.13.2018
-- @Role TitleCfg

local UserCheck = require("app.utils.logic.UserCheck")
local HonorTitleConst = require("app.const.HonorTitleConst")
local HonorTitleHelper = {}


-- @Role get config of type
function HonorTitleHelper.getConfigByTitleId(titleId)
    -- body
    local HonorTitleConfig = require("app.config.honor_title")
    local curTitleConfig = HonorTitleConfig.get(titleId)
    return curTitleConfig
end

-- @Role enough level and OpenDay
function HonorTitleHelper.enoughLevelAndOpendayByTitleId(titleId)
    -- body
    if titleId <= 0 then
        return false
    end

    local curConfig = HonorTitleHelper.getConfigByTitleId(titleId)
    if UserCheck.enoughLevel(curConfig.limit_level) and UserCheck.enoughOpenDay(curConfig.day) then
        return true
    end
    return false
end

-- @Role get activity's titleImg
function HonorTitleHelper.getTitleImg(id)
    local curConfig = HonorTitleHelper.getConfigByTitleId(id)
    if curConfig and curConfig.resource then
        return Path.getImgTitle(curConfig.resource)
    else
        return Path.getImgTitle(HonorTitleConst.TITLE_PNG[id])
    end
end


return HonorTitleHelper