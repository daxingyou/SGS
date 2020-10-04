
-- Author: conley
-- Date:2018-11-23 17:08:15
-- Rebuilt By Panhoa
local ViewBase = require("app.ui.ViewBase")
local HistoryHeroPosItemCell = class("HistoryHeroPosItemCell", ViewBase)
local TeamConst = require("app.const.TeamConst")
local HistoryHeroDataHelper = require("app.utils.data.HistoryHeroDataHelper")


function HistoryHeroPosItemCell:ctor(index, clickCallBack)
	self._commonHeroIcon = nil  
	self._imageSelected  = nil  	
	self._nodeAdd 		 = nil  		
	self._nodeLock 		 = nil  		
	self._textPos 		 = nil
	self._callBackData	 = {}
	
	self._index = index
	self._clickCallBack = clickCallBack

	local resource = {
		file = Path.getCSB("HistoryHeroPosItemCell", "historyhero"),
	}
	HistoryHeroPosItemCell.super.ctor(self, resource)
end

function HistoryHeroPosItemCell:onCreate()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
	self:_updateBaseView(false)

	local UIActionHelper = require("app.utils.UIActionHelper")
	UIActionHelper.playBlinkEffect(self._imageAdd)
end

function HistoryHeroPosItemCell:onEnter()
	self:updateUI(self._index)
end

function HistoryHeroPosItemCell:onExit()
end

-- @Export 		Update Selected
function HistoryHeroPosItemCell:updateSelectedVisible(bVisible)
	self["_imageSelected"]:setVisible(bVisible)
end

function HistoryHeroPosItemCell:_updateBaseView(bVisible)
	self._resourceNode:setVisible(bVisible)
end

-- @Role    Add Icon 
function HistoryHeroPosItemCell:_onAddTouch(sender, state)
    if state == ccui.TouchEventType.ended or not state then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
        --if moveOffsetX < 20 and moveOffsetY < 20 then
			if self._clickCallBack then
				self._clickCallBack(self._callBackData)
			end
		--end
	end
end

-- @Role 	Update Icon
function HistoryHeroPosItemCell:updateHeroIcon(value)
	self["_commonHeroIcon"]:updateUI(value)
	self["_nodeAdd"]:setVisible(false)
end

-- @Role	UpdateUI
function HistoryHeroPosItemCell:updateUI(index)
	local function updateIcon(state)
		if state == TeamConst.STATE_HERO then
			local historyHeroIds = G_UserData:getHistoryHero():getHistoryHeroIds()
			if historyHeroIds and rawget(historyHeroIds, index) ~= nil then
				local value = G_UserData:getHistoryHero():getHisoricalHeroBaseIdById(historyHeroIds[index])
				if value == nil then
					return
				end
				self._callBackData.heroId = value
				local TypeConvertHelper = require("app.utils.TypeConvertHelper")
				self["_commonHeroIcon"]:initUI(TypeConvertHelper.TYPE_HISTORY_HERO, value)
				self["_commonHeroIcon"]:setIconMask(false)
				self["_commonHeroIcon"]:setTouchEnabled(false)
			end
		end
	end

	self:_updateBaseView(true)
	self["_textPos"]:setString(Lang.get("historyhero_squad_"..index))
	self["_commonHeroIcon"]:unInitUI()
	
	local state = HistoryHeroDataHelper.getHistoryHeroStateWithPos(index)
	self["_nodeLock"]:setVisible(state == TeamConst.STATE_LOCK)
	self["_nodeAdd"]:setVisible(state == TeamConst.STATE_OPEN)

	self._callBackData.index = index
	self._callBackData.state = state
	self._callBackData.heroId = 0
	
	self["_panelTouch"]:setVisible(state < TeamConst.STATE_LOCK)
	self["_panelTouch"]:setTag(index)
	self["_panelTouch"]:setEnabled(true)
	self["_panelTouch"]:setSwallowTouches(false)
	self["_panelTouch"]:setTouchEnabled(true)
	self["_panelTouch"]:addClickEventListenerEx(handler(self, self._onAddTouch))
	updateIcon(state)
end


return HistoryHeroPosItemCell