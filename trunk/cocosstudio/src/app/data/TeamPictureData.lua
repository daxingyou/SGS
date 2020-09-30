local BaseData = require("app.data.BaseData")
local TeamPictureData = class("TeamPictureData", BaseData)

local schema = {}
schema["heroEmakiInfo"] = {"table", {}}
schema["activateHeroEmaki"] = {"table", {}}
schema["levelUpHeroEmaki"] = {"table", {}}
schema["heroEmakiInfoFinal"] = {"table", {}}
TeamPictureData.schema = schema

function TeamPictureData:ctor(properties)
    TeamPictureData.super.ctor(self, properties)

    self._recvHeroEmakiInfo = G_NetworkManager:add(MessageIDConst.ID_S2C_GetHeroEmakiInfo, handler(self, self._s2cGetHeroEmakiInfo))

    self._recvActivateHeroEmakiInfo = G_NetworkManager:add(MessageIDConst.ID_S2C_ActivateHeroEmaki, handler(self, self._s2cActivateHeroEmaki))
    self._recvLevelUpHeroEmakiInfo = G_NetworkManager:add(MessageIDConst.ID_S2C_LevelUpHeroEmaki, handler(self, self._s2cLevelUpHeroEmaki))
end

function TeamPictureData:clear()

    self._recvHeroEmakiInfo:remove()
    self._recvHeroEmakiInfo = nil

    self._recvActivateHeroEmakiInfo:remove()
    self._recvActivateHeroEmakiInfo = nil

    self._recvLevelUpHeroEmakiInfo:remove()
    self._recvLevelUpHeroEmakiInfo = nil
end

function TeamPictureData:reset()
end

function TeamPictureData:c2sGetHeroEmakiInfo()
    G_NetworkManager:send(MessageIDConst.ID_C2S_GetHeroEmakiInfo, {})
end

-- 激活
function TeamPictureData:c2sActivateHeroEmaki(id, limit_level, limit_rtg)
    local message = {
        id = id,
        limit_level = limit_level,
        limit_rtg = limit_rtg
    }
    G_NetworkManager:send(MessageIDConst.ID_C2S_ActivateHeroEmaki, message)
end

-- 升级
function TeamPictureData:c2sLevelUpHeroEmaki(id, limit_level, limit_rtg)
    local message = {
        id = id,
        limit_level = limit_level,
        limit_rtg = limit_rtg
    }
    G_NetworkManager:send(MessageIDConst.ID_C2S_LevelUpHeroEmaki, message)
end

function TeamPictureData:_s2cGetHeroEmakiInfo(id, message)
    if message.ret ~= MessageErrorConst.RET_OK then
		return
    end

    self:setHeroEmakiInfo({})
    self:setHeroEmakiInfoFinal({})
    local heroEmakiInfo = rawget(message, "info") or {}
    self:setHeroEmakiInfo(heroEmakiInfo)
    self:setHeroEmakiInfoFinal(heroEmakiInfo)
    -- print(">>>>> Log _s2cGetHeroEmakiInfo <<<<<", dump(heroEmakiInfo))
    G_SignalManager:dispatch(SignalConst.EVENT_GET_TEAM_INFO_SUCCESS)
    G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE,FunctionConst.FUNC_DRAW_HERO)
    G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE,FunctionConst.FUNC_TEAMPICTURE)
    
end

-- 激活结果
function TeamPictureData:_s2cActivateHeroEmaki(id, message)
    if message.ret ~= MessageErrorConst.RET_OK then
		return
    end
    -- print(">>>>>> Log _s2cActivateHeroEmaki: ", dump(message))
    self:setActivateHeroEmaki(message)

    local msg = {}
    msg.id = message.id
    msg.status = message.status
    table.insert(self:getHeroEmakiInfoFinal(), msg)   

    G_SignalManager:dispatch(SignalConst.EVENT_ACTIVE_HERO_SUCCESS)
    G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE,FunctionConst.FUNC_DRAW_HERO)
    G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE,FunctionConst.FUNC_TEAMPICTURE)
    
end

-- 升级结果
function TeamPictureData:_s2cLevelUpHeroEmaki(id, message)
    if message.ret ~= MessageErrorConst.RET_OK then
		return
    end
    -- print(">>>>>> Log _s2cLevelUpHeroEmaki: ", dump(message))
    self:levelUpHeroEmaki(message)
    G_SignalManager:dispatch(SignalConst.EVENT_LEVELUP_HERO_SUCCESS)
    G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE,FunctionConst.FUNC_DRAW_HERO)
    G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE,FunctionConst.FUNC_TEAMPICTURE)
    
end

function TeamPictureData:getPictureStatusById(id)
    for index, value in ipairs(self:getHeroEmakiInfoFinal()) do
        -- print(">>>>> Log value.id: ", value.id)
        if value.id == id then
            return value.status
        end
    end 
    return 0
end

function TeamPictureData:isHasRedPoint()
    local config = require("app.config.hero_emaki")
    local heroConfig = require("app.config.hero")
    local len = config.length()
	for i = 1, len do
		local value = config.indexOf(i)
        local id = value.id
        local heroInfo = heroConfig.get(id)
        local name = heroInfo.name
        local have = G_UserData:getHandBook():isHeroHave(value.id)
        local status = self:getPictureStatusById(value.id)
        if G_UserData:getHandBook():isHeroHave(value.id) and self:getPictureStatusById(value.id) == 0 then  -- 可激活
            return true
        end
    end
    return false
end

return TeamPictureData