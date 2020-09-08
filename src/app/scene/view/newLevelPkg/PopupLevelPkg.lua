local PopupBase = require("app.ui.PopupBase")
local PopupLevelPkg = class("PopupLevelPkg", PopupBase)


function PopupLevelPkg:waitEnterMsg(callBack)
	local function onMsgCallBack()
		callBack()
	end
	local hasUpdate = G_UserData:getActivityLevelGiftPkg():pullData()
	if hasUpdate then
		self._signalLevelGift = G_SignalManager:add(SignalConst.EVENT_WELFARE_LEVEL_GIFT_INFO, onMsgCallBack)
		return _signalLevelGift 
	else
		callBack()
	end
end

function PopupLevelPkg:ctor(condition,conditionValue,callback)
	self._condition = condition
	self._conditionValue = conditionValue
	self._callback = callback
	--csb bind var name
	self._listItem = nil  --ListView
	self._nodeContinue = nil
	self._nodeBubble = nil
	local resource = {
		file = Path.getCSB("PopupLevelPkg", "new_level_pkg"),
	}

	PopupLevelPkg.super.ctor(self, resource)
end

-- Describle：
function PopupLevelPkg:onCreate()
	self:_initListView()

	local text = Lang.get("lang_new_level_pkg_condition_" .. self._condition,{level = self._conditionValue})
	self._nodeBubble:getSubNodeByName("Text"):setString(text)
end


-- Describle：
function PopupLevelPkg:onEnter()
	self._signalLevelGift = G_SignalManager:add(SignalConst.EVENT_WELFARE_LEVEL_GIFT_INFO, handler(self, self._refreshView))
	self._signalLevelGiftAward = G_SignalManager:add(SignalConst.EVENT_WELFARE_LEVEL_GIFT_AWARD, handler(self, self._getAwards))

	self:_refreshView()
end

-- Describle：
function PopupLevelPkg:onExit()
	self._signalLevelGift:remove()
	self._signalLevelGift = nil
	self._signalLevelGiftAward:remove()
	self._signalLevelGiftAward = nil
end

function PopupLevelPkg:_initListView()
	-- body
	local LevelGiftItemCell = require("app.scene.view.newLevelPkg.PopupLevelPkgItemCell")
	self._listViewData = G_UserData:getActivityLevelGiftPkg():getListViewDataByCondition(self._condition,self._conditionValue)
	self._items = {}
	local width = 0
	local height = 0
	--test
	--table.insert(self._listViewData,self._listViewData[1])
	--table.insert(self._listViewData,self._listViewData[1])
	--table.insert(self._listViewData,self._listViewData[1])
	for k, v in pairs(self._listViewData) do
		local item = LevelGiftItemCell.new()
		self._listItem:pushBackCustomItem(item)
		self._items[k] = item
	end

	if #self._listViewData > 3 then
		self._listItem:setContentSize(cc.size(900,368))
		self._listItem:setTouchEnabled(true)
		self._listItem:doLayout()
	else
		self._listItem:adaptWithContainerSize()
		self._listItem:setTouchEnabled(false)
	end
end

function PopupLevelPkg:_refreshView()
	for k, v in pairs(self._listViewData) do
		local item = self._items[k]
		item:updateUI(v)
	end
end

function PopupLevelPkg:onClose()
	if self._callback then
		self._callback()
	end
end


function PopupLevelPkg:_getAwards(message, awards)
	if awards then
		G_Prompt:showAwards(awards)
	end
	--买完东西之后 清理到今天已经点过的的状态
	if not G_UserData:getActivityLevelGiftPkg():canBuy() then
		local ActivityConst = require("app.const.ActivityConst")
		G_UserData:getRedPoint():clearRedPointShowFlag(FunctionConst.FUNC_WELFARE,{actId = ActivityConst.ACT_ID_LEVEL_GIFT_PKG})
	end

end

return PopupLevelPkg
