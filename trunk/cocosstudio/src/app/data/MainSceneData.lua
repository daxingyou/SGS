--场景数据
local BaseData = require("app.data.BaseData")
local MainSceneData = class("MainSceneData", BaseData)
local TitleInfo = require("app.config.title")
local HonorTitleItemData = require("app.data.HonorTitleItemData")
local PopupHonorTitleHelper = require("app.scene.view.playerDetail.PopupHonorTitleHelper")

local schema = {}

MainSceneData.schema = schema
schema["sceneId"] 	= {"number", 0}		--当前设置的场景id main_scene
schema["sceneList"] = {"table", {}}		--当前拥有的场景id列表

function MainSceneData:ctor(properties)
	MainSceneData.super.ctor(self, properties)
	self._listenerMainSceneInfo =
		G_NetworkManager:add(MessageIDConst.ID_S2C_MainSceneInfo, handler(self, self._s2cMainSceneInfo)) -- 进游戏获得场景数据
	self._listenerMainScene =
		G_NetworkManager:add(MessageIDConst.ID_S2C_MainScene, handler(self, self._s2cMainScene)) -- 设置场景
	self._listenerBuyMainScene =
		G_NetworkManager:add(MessageIDConst.ID_S2C_BuyMainScene, handler(self, self._s2cBuyMainScene)) -- 购买场景
end

function MainSceneData:clear()
	self._listenerMainSceneInfo:remove()
	self._listenerMainSceneInfo = nil
	self._listenerMainScene:remove()
	self._listenerMainScene = nil
	self._listenerBuyMainScene:remove()
	self._listenerBuyMainScene = nil
end

function MainSceneData:reset()
end

-- 设置场景
function MainSceneData:c2sMainScene(id)
	G_NetworkManager:send(MessageIDConst.ID_C2S_MainScene, { id = id})
end

-- 购买场景
function MainSceneData:c2sBuyMainScene(id,buyType)
	G_NetworkManager:send(MessageIDConst.ID_C2S_BuyMainScene, {id = id,type = buyType})
end

--[[
message S2C_MainSceneInfo {
	required uint32 id = 1;
	repeated uint32 sceneId = 2;
}
]]
function MainSceneData:_s2cMainSceneInfo(id, message)
	local id = rawget(message, "id")
	self:setSceneId(id)

	local sceneId = rawget(message, "sceneId")
	if sceneId == nil then
		return
	end
	self:setSceneList(sceneId)
end

--[[
message S2C_MainScene {
  required uint32 ret = 1;
}
]]
function MainSceneData:_s2cMainScene(id, message)
	if message.ret ~= MessageErrorConst.RET_OK then
		return
	end
end

--[[
message S2C_BuyMainScene {
  required uint32 ret = 1;
}
]]
function MainSceneData:_s2cBuyMainScene(id, message)
	if message.ret ~= MessageErrorConst.RET_OK then
		return
	end
	G_SignalManager:dispatch(SignalConst.EVENT_BUY_MAIN_SCENE)
end

function MainSceneData:updateData( message )
	local id = rawget(message, "id")
	self:setSceneId(id)

	local sceneId = rawget(message, "sceneid")
	if sceneId == nil then
		return
	end
	self:setSceneList(sceneId)
end

return MainSceneData
