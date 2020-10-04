--
-- Author: Liangxu
-- Date: 2019-4-29
-- 蛋糕活动赠送推送

local CakeGivePushNode = class("CakeGivePushNode")
local CakeActivityConst = require("app.const.CakeActivityConst")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local SchedulerHelper = require ("app.utils.SchedulerHelper")
local CakeActivityDataHelper = require("app.utils.data.CakeActivityDataHelper")

local RES_INFO = {
	[CakeActivityConst.MATERIAL_TYPE_1] = {
		bgRes = "img_special_03",
		outlineColor = cc.c4b(0x6a, 0x78, 0xff, 0xff),
		effect = "effect_dangao_jidan",
	},
	[CakeActivityConst.MATERIAL_TYPE_2] = {
		bgRes = "img_special_04",
		outlineColor = cc.c4b(0xde, 0x2a, 0xff, 0xff),
		effect = "effect_dangao_naiyou",
	},
	[CakeActivityConst.MATERIAL_TYPE_3] = {
		bgRes = "img_special_05",
		outlineColor = cc.c4b(0xff, 0xba, 0x00, 0xff),
		effect = "effect_dangao_shuiguo",
	},
}

function CakeGivePushNode:ctor(target, index, onReset, onDoGive)
	self._target = target
	self._index = index
	self._onReset = onReset
	self._onDoGive = onDoGive --实际发出协议的回调
	self._isPlaying = false --此节点是否在出现状态
	self._data = nil
	self._itemId = 0
	self._showCount = 0 --用于显示的数量
	self._realCount = 0 --用于发协议的实际数量
	self._schedulerCheck = nil
	self._schedulerSend = nil
	self._posY = self._target:getPositionY()

	self._imageBg = ccui.Helper:seekNodeByName(self._target, "ImageBg")
	self._imageBg:ignoreContentAdaptWithSize(true)
	self._textName = ccui.Helper:seekNodeByName(self._target, "TextName")
	self._textDesc = ccui.Helper:seekNodeByName(self._target, "TextDesc")
	self._textCount = ccui.Helper:seekNodeByName(self._target, "TextCount")
	self._nodeEffect = ccui.Helper:seekNodeByName(self._target, "NodeEffect")
end

function CakeGivePushNode:onExit()
	self:_removeCheckSchedule()
	self:_removeSendSchedule()
	self:forceReset()
end

function CakeGivePushNode:_updateUI(data)
	local serverName = CakeActivityDataHelper.formatServerName(data:getContentDesWithKey("sname"))
	local name = data:getContentDesWithKey("uname")
	self._itemId = tonumber(data:getContentDesWithKey("itemid1"))
	self._showCount = tonumber(data:getContentDesWithKey("itemnum"))
	self._realCount = tonumber(data:getContentDesWithKey("itemnum"))
	local type = CakeActivityConst.getMaterialTypeWithId(self._itemId)
	local info = RES_INFO[type]
	self._imageBg:loadTexture(Path.getAnniversaryImg(info.bgRes))
	local itemParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_ITEM, self._itemId)
	local effectName = info.effect
	self._nodeEffect:removeAllChildren()
	G_EffectGfxMgr:createPlayGfx(self._nodeEffect, effectName)
	self._textName:setString(serverName.." "..name)
	self._textDesc:setString(Lang.get("cake_activity_give_item_des", {name = itemParam.name}))
	self._textCount:enableOutline(info.outlineColor, 1)
	self._textCount:setString("x"..self._showCount)
end

function CakeGivePushNode:addCount(count)
	self._showCount = self._showCount+count
	self._realCount = self._realCount+count
	self._textCount:setString("x"..self._showCount)
	self._textCount:doScaleAnimation()
	
    self:_checkUpdateCount()
    self:_checkSend()
end

function CakeGivePushNode:playStart(data)
	self._isPlaying = true
	self._data = data
	self:_updateUI(data)
	local moveTo = cc.MoveTo:create(0.2, cc.p(260, self._posY))
	local easeBounceOut = cc.EaseBounceOut:create(moveTo)
	self._target:runAction(easeBounceOut)
	self:_checkUpdateCount()
	self:_checkSend()
end

function CakeGivePushNode:_removeCheckSchedule()
	if self._schedulerCheck ~= nil then
        SchedulerHelper.cancelSchedule(self._schedulerCheck)
        self._schedulerCheck = nil
    end
end

function CakeGivePushNode:_checkUpdateCount()
	self:_removeCheckSchedule()
	self._schedulerCheck = SchedulerHelper.newScheduleOnce(function()
		self:_playEnd()
	end, 3.0) --3秒钟后此节点消失
end

function CakeGivePushNode:_removeSendSchedule()
	if self._schedulerSend ~= nil then
        SchedulerHelper.cancelSchedule(self._schedulerSend)
        self._schedulerSend = nil
    end
end

function CakeGivePushNode:_checkSend()
	self:_removeSendSchedule()
	self._schedulerSend = SchedulerHelper.newScheduleOnce(function()
		self:_sendMatrical()
	end, 0.5) --0.5秒后发消息
end

function CakeGivePushNode:_playEnd()
	if self._onReset then
		self._onReset()
	end
	self:_reset()
end

function CakeGivePushNode:_sendMatrical()
	local item = nil
	if self._data and self._data:isFake() then
		item = {id = self._itemId, num = self._realCount}
	end
	if self._onDoGive then
		self._onDoGive(item)
	end
	self._realCount = 0
end

function CakeGivePushNode:_reset()
	self._target:setPositionX(0)
	self._target:setOpacity(255)
	self._isPlaying = false
	self._data = nil
end

function CakeGivePushNode:isEmpty()
	return not self._isPlaying --没处于播放状态，表示空了
end

--存的是否假数据
function CakeGivePushNode:isFake()
	if self._data and self._data:isFake() then
		return true
	else
		return false
	end
end

--根据数据对比，判断是否是一样的，用于更新次数
function CakeGivePushNode:isSameNode(data)
	if self._data then
		if self._data:getNotice_id() == CakeActivityConst.NOTICE_TYPE_COMMON --只可能是普通通知样式
			and self._data:getNotice_id() == data:getNotice_id()
			and self._data:getContentDesWithKey("sname") == data:getContentDesWithKey("sname")
			and self._data:getContentDesWithKey("itemid1") == data:getContentDesWithKey("itemid1")
			and self._data:getContentDesWithKey("uol") == data:getContentDesWithKey("uol")
			and self._data:getContentDesWithKey("sgname") == data:getContentDesWithKey("sgname")
			and self._data:getContentDesWithKey("uname") == data:getContentDesWithKey("uname")
			and self._data:getContentDesWithKey("tgname") == data:getContentDesWithKey("tgname")
		then
			return true	
		end
	end
	return false
end

--强制结束
function CakeGivePushNode:forceReset()
	if self._realCount > 0 then
		self:_sendMatrical()
	end
	self:_reset()
end

return CakeGivePushNode