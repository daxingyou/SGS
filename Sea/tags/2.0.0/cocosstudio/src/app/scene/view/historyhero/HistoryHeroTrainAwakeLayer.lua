
-- Author: conley
-- Date:2018-11-23 17:08:16
-- Describle：

local ViewBase = require("app.ui.ViewBase")
local HistoryHeroTrainAwakeLayer = class("HistoryHeroTrainAwakeLayer", ViewBase)
local HistoryHeroDataHelper = require("app.utils.data.HistoryHeroDataHelper")


function HistoryHeroTrainAwakeLayer:ctor()
	self._buttonAwake 	= nil
	self._nodeItemName  = nil
	self._resource 		= nil
	self._addAeake 		= nil
	self._static_historyhero_awake_des = nil

	self._awakeData		= {}	-- 当前觉醒所需道具
	self._awakeId		= 0		-- 觉醒ID

	local resource = {
		file = Path.getCSB("HistoryHeroTrainAwakeLayer", "historyhero"),
		binding = {
			_buttonAwake = {
				events = {{event = "touch", method = "_onButtonAwake"}}
			},
			_addAeake = {
				events = {{event = "touch", method = "_onaddAeake"}}
			},
		},
	}
	HistoryHeroTrainAwakeLayer.super.ctor(self, resource)
end

function HistoryHeroTrainAwakeLayer:onCreate()
	self._buttonAwake:setString(Lang.get("hero_detail_btn_awake"))
	self._buttonAwake:setEnabled(false)

	local UIActionHelper = require("app.utils.UIActionHelper")
	UIActionHelper.playBlinkEffect(self["_addAeake"])
end

function HistoryHeroTrainAwakeLayer:onEnter()
	self._awakeSuccess = G_SignalManager:add(SignalConst.EVENT_HISTORY_HERO_BREAK_THROUGH_SUCCESS, handler(self, self._onAwakeSuccess))	   		 -- 觉醒装备
end

function HistoryHeroTrainAwakeLayer:onExit()
	if self._awakeSuccess then
		self._awakeSuccess:remove()
		self._awakeSuccess = nil
	end
end

function HistoryHeroTrainAwakeLayer:_onButtonAwake()
	G_UserData:getHistoryHero():c2sStarBreakThrough(self._awakeId ,0, nil)
end

function HistoryHeroTrainAwakeLayer:setNodeVisible(bVisible)
	self._resource:setVisible(bVisible)
end

function HistoryHeroTrainAwakeLayer:_onAwakeSuccess(id, message)
	if G_UserData:getHistoryHero():getDetailTabType() ~= 2 then
		return
	end

	self["_addAeake"]:setVisible(false)
	self["_commonItem01"]:setIconMask(false)
	self["_commonItem01"]:setVisible(true)
	local unitData = G_UserData:getHistoryHero():getHisoricalHeroValueById(self._awakeId)
	if unitData ~= nil then
		self:_updateSquadNum(unitData:getBreak_through() == 1 and next(unitData:getMaterials()) ~= nil)
		self._buttonAwake:setEnabled(unitData:getBreak_through() == 1 and next(unitData:getMaterials()) ~= nil)
		self:_updateAddAwake(unitData)
	end
end

-- @Role 	选择觉醒道具
function HistoryHeroTrainAwakeLayer:_onaddAeake()
	local function okCallback()
		if self._awakeId == 0 then
			logWarn(Lang.get("historyhero_awakeequip_errdesc"))
			return
		end
		G_UserData:getHistoryHero():c2sStarBreakThrough(self._awakeId ,1, nil)
	end
	local HistoryHeroConst = require("app.const.HistoryHeroConst")
	local PopupChooseHistoricalItemView = require("app.scene.view.historyhero.PopupChooseHistoricalItemView").new(
													HistoryHeroConst.TAB_TYPE_AWAKE, self._awakeData, okCallback)
	PopupChooseHistoricalItemView:open()
end

-- @Role 	刷新加号状态
function HistoryHeroTrainAwakeLayer:_updateAddVisible()
	local bCanAwake = false
	local data = G_UserData:getHistoryHero():getWeaponList()
	for key, value in pairs(data) do
		if value:getId() == self._awakeData.value then
			bCanAwake = true
		end
	end
	self["_addAeake"]:setVisible(bCanAwake)
end

-- @Role 	刷新上阵数量
function HistoryHeroTrainAwakeLayer:_updateSquadNum(bSquad)
	local descStr = bSquad and Lang.get("historyhero_awakeenougth_desc", {num1 = self._awakeData.size, num2 = self._awakeData.size}) 
							or Lang.get("historyhero_awakenotenougth_desc", {num1 = 0, num2 = self._awakeData.size})
	self._nodeItemName:removeAllChildren()
	self._nodeItemName:setVisible(not self._isInBanView)


	local richText = ccui.RichText:createRichTextByFormatString(descStr,
				{defaultColor = Colors.BRIGHT_BG_ONE, defaultSize = 22, other ={
					[1] = {fontSize = 22}
				}})
	richText:setPositionX(25)
	richText:setPositionY(2)
	self._nodeItemName:addChild(richText)
end

-- @Role 	武器名
function HistoryHeroTrainAwakeLayer:_updateName(data)
	if tonumber(data.type_1) > 0 then
		self._awakeData.type  = data.type_1
		self._awakeData.value = data.value_1
		self._awakeData.size  = data.size_1

		self["_commonItem01"]:unInitUI()
		self["_commonItem01"]:initUI(data.type_1, data.value_1, data.size_1)
		self["_commonItem01"]:setIconMask(true)
		self["_commonItem01"]:setVisible(true)
		self["_addAeake"]:setVisible(true)
		local paramCfg = self["_commonItem01"]:getItemParams()
		self._textName:setString(paramCfg.name)
		self._textName:setColor(paramCfg.icon_color)

		local targetPosX = (self._textName:getPositionX() + self._textName:getContentSize().width)
		self._nodeItemName:setPositionX(targetPosX)
	end
end

-- @Role 	Icon刷新状态
function HistoryHeroTrainAwakeLayer:_updateIcon(data)
	if type(data) ~= "table" or next(data) == nil then
		return
	end
	if self._awakeData.type == data[1].type and self._awakeData.value == data[1].value then
		self["_addAeake"]:setVisible(false)
		self["_commonItem01"]:setIconMask(false)
		self["_commonItem01"]:setVisible(true)
	end
end

-- @Role 	刷新觉醒按钮
function HistoryHeroTrainAwakeLayer:_updateAddAwake(data)
	if G_UserData:getHistoryHero():getHeroWeaponUnitData(self._awakeData.value) ~= nil then
		self._addAeake:setVisible(data:getBreak_through() == 1)
	else
		self._addAeake:setVisible(false)
	end
end

-- @Role 	刷新当前武将信息
function HistoryHeroTrainAwakeLayer:updateUI(data)
	local heroStepInfo = HistoryHeroDataHelper.getHistoryHeroStepByHeroId(data:getSystem_id(), 1)
	self:_updateName(heroStepInfo)
	self:_updateIcon(data:getMaterials())

	self:_updateSquadNum(data:getBreak_through() == 1 and next(data:getMaterials()) ~= nil)
	self._buttonAwake:setEnabled(data:getBreak_through() == 1 and next(data:getMaterials()) ~= nil)
	self:_updateAddAwake(data)

	self._awakeId = data:getId()
end



return HistoryHeroTrainAwakeLayer