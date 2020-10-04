-- Author: Panhoa
-- Date:2018-11-23 17:08:18
--

local ViewBase = require("app.ui.ViewBase")
local HistoryHeroTrainBreakLayer = class("HistoryHeroTrainBreakLayer", ViewBase)
local HistoryHeroConst = require("app.const.HistoryHeroConst")
local HistoryHeroDataHelper = require("app.utils.data.HistoryHeroDataHelper")


function HistoryHeroTrainBreakLayer:ctor()
	self._buttonBreak  = nil 
	self._commonItem01 = nil  
	self._commonItem02 = nil 
	self._commonItem03 = nil  
	self._static_historyhero_break_des = nil 
	self._resource     = nil
	self._breakData    = {}
	self._breakId	   = 0

	local resource = {
		file = Path.getCSB("HistoryHeroTrainBreakLayer", "historyhero"),
		binding = {
			_buttonBreak = {
				events = {{event = "touch", method = "_onButtonBreak"}}
			},
		},
	}
	HistoryHeroTrainBreakLayer.super.ctor(self, resource)
end

function HistoryHeroTrainBreakLayer:onCreate()
	self._buttonBreak:setEnabled(false)
	self._buttonBreak:setString(Lang.get("hero_detail_btn_break"))
	self:_initAddView()
end

function HistoryHeroTrainBreakLayer:onEnter()
	self._breakSuccess = G_SignalManager:add(SignalConst.EVENT_HISTORY_HERO_BREAK_THROUGH_SUCCESS, handler(self, self._onBreakSuccess))	   		 -- 突破名将
end

function HistoryHeroTrainBreakLayer:onExit()
	if self._breakSuccess then
		self._breakSuccess:remove()
		self._breakSuccess = nil
	end
end

function HistoryHeroTrainBreakLayer:_onBreakSuccess(id, message)
	if G_UserData:getHistoryHero():getDetailTabType() ~= 3 then
		return
	end

	local unitData = G_UserData:getHistoryHero():getHisoricalHeroValueById(self._breakId)
	if unitData ~= nil then
		self._buttonBreak:setEnabled(unitData:getBreak_through() == 2 and table.nums(unitData:getMaterials()) == 3)
		self:_updateAddBreak(unitData)
	end
end

function HistoryHeroTrainBreakLayer:_onButtonBreak()
	G_UserData:getHistoryHero():c2sStarBreakThrough(self._breakId, 0, nil)
end

function HistoryHeroTrainBreakLayer:setNodeVisible(bVisible)
	self._resource:setVisible(bVisible)
end

function HistoryHeroTrainBreakLayer:_updateIcon(data)
	local count = 0
	if tonumber(data.type_1) > 0 then
		count = (count + 1)
		self["_commonItem01"]:unInitUI()
		self["_commonItem01"]:initUI(data.type_1, data.value_1, data.size_1)
		self["_commonItem01"]:setIconMask(true)
		if self._breakData[1] == nil then
			self._breakData[1] = {
				type  = data.type_1,
				value = data.value_1,
				size  = data.size_1,
			}
		end
	end
	if tonumber(data.type_2) > 0 then
		count = (count + 1)
		self["_commonItem02"]:unInitUI()
		self["_commonItem02"]:initUI(data.type_2, data.value_2, data.size_2)
		self["_commonItem02"]:setIconMask(true)
		if self._breakData[2] == nil then
			self._breakData[2] = {
				type  = data.type_2,
				value = data.value_2,
				size  = data.size_2,
			}
		end
	end
	if tonumber(data.type_3) > 0 then
		count = (count + 1)
		self["_commonItem03"]:unInitUI()
		self["_commonItem03"]:initUI(data.type_3, data.value_3, data.size_3)
		self["_commonItem03"]:setIconMask(true)
		if self._breakData[3] == nil then
			self._breakData[3] = {
				type  = data.type_3,
				value = data.value_3,
				size  = data.size_3,
			}
		end
	end

	local tab = HistoryHeroConst.TYPE_BREAKTHROUGH_POS_1
	if count == 1 then
		tab = HistoryHeroConst.TYPE_BREAKTHROUGH_POS_1
	elseif count == 2 then
		tab = HistoryHeroConst.TYPE_BREAKTHROUGH_POS_2
	elseif count == 3 then
		tab = HistoryHeroConst.TYPE_BREAKTHROUGH_POS_3
	end
	for index = 1, count do
		self["_commonItem0"..index]:setPosition(tab[index])
		self["_commonItem0"..index]:setIconMask(true)
		self["_commonItem0"..index]:setTouchEnabled(false)
		self["_imageAdd"..index]:setPosition(tab[index])
		self["_imageAdd"..index]:setVisible(true)
	end
end

function HistoryHeroTrainBreakLayer:_onClickAdd(sender)
	local curAddIndex = sender:getTag()
	if type(curAddIndex) ~= "number" then
		return
	end

	if self._heroBreakthrough < 2 then
		G_Prompt:showTip(Lang.get("historyhero_awake_first"))
		return
	end

	local function okCallback(itemId)	
		G_UserData:getHistoryHero():c2sStarBreakThrough(self._breakId, sender:getTag(), itemId)
	end
	local HistoryHeroConst = require("app.const.HistoryHeroConst")
	local PopupChooseHistoricalItemView = require("app.scene.view.historyhero.PopupChooseHistoricalItemView").new(
													HistoryHeroConst.TAB_TYPE_BREAK, self._breakData[sender:getTag()], okCallback)
	PopupChooseHistoricalItemView:open()
end

function HistoryHeroTrainBreakLayer:_initAddView()
	for index = 1, 3 do
		local UIActionHelper = require("app.utils.UIActionHelper")
		UIActionHelper.playBlinkEffect(self["_imageAdd"..index])
		self["_imageAdd"..index]:setVisible(false)
		self["_imageAdd"..index]:setTag(index)
		self["_imageAdd"..index]:setSwallowTouches(false)
		self["_imageAdd"..index]:setTouchEnabled(true)
		self["_imageAdd"..index]:addClickEventListenerEx(handler(self, self._onClickAdd))
	end
end

function HistoryHeroTrainBreakLayer:_updateAddBreak(data)
	if data:getBreak_through() == 3 then
		for index = 1, 3 do
			self["_imageAdd"..index]:setVisible(false)
			self["_commonItem0"..index]:setIconMask(false)
		end
		return
	end

	local materialData = data:getMaterials()
	if type(materialData) ~= "table" then return end
	if next(materialData) == nil then
		return
	end

	for index, cfg in ipairs(self._breakData) do
		self["_imageAdd"..index]:setVisible(true)
		self["_commonItem0"..index]:setIconMask(true)
		for k, v in pairs(materialData) do
			if cfg.type == v.type and cfg.value == v.value then
				self["_imageAdd"..index]:setVisible(false)
				self["_commonItem0"..index]:setIconMask(false)
			end
		end	
	end
end

-- @Role 	刷新当前武将信息
function HistoryHeroTrainBreakLayer:updateUI(data)
	self._breakId = data:getId()
	self._heroBreakthrough = data:getBreak_through()

	local heroStepInfo = HistoryHeroDataHelper.getHistoryHeroStepByHeroId(data:getSystem_id(), 2)
	self:_updateIcon(heroStepInfo)

	self._buttonBreak:setEnabled(data:getBreak_through() == 2 and table.nums(data:getMaterials()) == 3)
	self:_updateAddBreak(data)
end



return HistoryHeroTrainBreakLayer