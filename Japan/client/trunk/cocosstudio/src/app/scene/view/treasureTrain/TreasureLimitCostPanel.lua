-- 
-- Author: Liangxu
-- Date: 2018-12-27
-- 宝物界限消耗面板

local PopupBase = require("app.ui.PopupBase")
local TreasureLimitCostPanel = class("TreasureLimitCostPanel", PopupBase)
local CSHelper = require("yoka.utils.CSHelper")
local DataConst = require("app.const.DataConst")
local TreasureDataHelper = require("app.utils.data.TreasureDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local TreasureConst = require("app.const.TreasureConst")
local AudioConst = require("app.const.AudioConst")

function TreasureLimitCostPanel:ctor(costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode)
	self._costKey = costKey
	self._onClick = onClick
	self._onStep = onStep
	self._onStart = onStart
	self._onStop = onStop
	self._limitLevel = limitLevel
	self._fromNode = fromNode

	local resource = {
		file = Path.getCSB("HeroLimitCostPanel", "hero"),
		binding = {
			
		}
	}
    -- i18n ja change CSB
    if Lang.checkUI("ui4") then 
        resource.file = Path.getCSB("HeroLimitCostPanel2", "hero")
    end
	TreasureLimitCostPanel.super.ctor(self, resource, false, true)
end

function TreasureLimitCostPanel:onCreate()
	self:_initData()
	self:_initView()
end

function TreasureLimitCostPanel:_initData()
	self._items = {}
	self._itemIds = {}
end

function TreasureLimitCostPanel:_initView()
	local info = TreasureDataHelper.getLimitCostConfig(self._limitLevel)
	if self._costKey == TreasureConst.TREASURE_LIMIT_COST_KEY_1 then
		local tbPos = {
			[1] = {46, 148},
			[2] = {110, 56},
			[3] = {225, 56},
			[4] = {290, 148},
		}

		-- i8n ja change
		if Lang.checkUI("ui4") then
			tbPos = {
				[1] = {42, 84},
				[2] = {120, 84},
				[3] = {199, 84},
				[4] = {278, 84},
			}
		end

		for i = 1, 4 do
			local item = CSHelper.loadResourceNode(Path.getCSB("CommonMaterialIcon", "common"))
			local itemId = DataConst["ITEM_TREASURE_LEVELUP_MATERIAL_"..i]
			item:setScale(0.8)
			item:updateUI(itemId, handler(self, self._onClickIcon), handler(self, self._onStepClickIcon))
			local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_ITEM, itemId)
			item:setName(param.name)
			item:setCostCountEveryTime(info["consume_"..self._costKey])
			item:setStartCallback(handler(self, self._onStartCallback))
			item:setStopCallback(handler(self, self._onStopCallback))
			item:setIsShift(true)
			item:setPosition(cc.p(tbPos[i][1], tbPos[i][2]))
			self._imageBg:addChild(item)
			table.insert(self._items, item)
			table.insert(self._itemIds, itemId)
		end
	else
		local item = CSHelper.loadResourceNode(Path.getCSB("CommonMaterialIcon", "common"))
		local itemId = info["value_"..self._costKey]
		item:setScale(0.8)
		item:updateUI(itemId, handler(self, self._onClickIcon), handler(self, self._onStepClickIcon))
		local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_ITEM, itemId)
		item:setName(param.name)
		item:setCostCountEveryTime(info["consume_"..self._costKey])
		item:setStartCallback(handler(self, self._onStartCallback))
		item:setStopCallback(handler(self, self._onStopCallback))
		item:setIsShift(true)
		item:setPosition(cc.p(170, 86))
		self._imageBg:addChild(item)
		table.insert(self._items, item)
		table.insert(self._itemIds, itemId)
	end

	self._panelTouch:setScale(3)
	self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
	self._panelTouch:addClickEventListener(handler(self, self._onClickPanel)) --避免0.5秒间隔
end

function TreasureLimitCostPanel:onEnter()
	self._signalTreasureLimitLvPutRes = G_SignalManager:add(SignalConst.EVENT_TREASURE_LIMIT_LV_PUT_RES, handler(self, self._onTreasureLimitLvPutRes))

	-- i18n ja pos 确定位置
	if Lang.checkUI("ui4") then   
		local num = #self._items
		local width = self._items[1]:getChildByName("PanelTouch"):getBoundingBox().width*0.8

		width = 10 + num*(width + 15) - 2
		if #self._items == 1 then   		-- 仅一个材料，背景框要适配描述字
			width = 210
		 	self._items[1]:setPosition(cc.p(width*0.5, 86))
		end
		self._imageBg:setContentSize(cc.size(width, 140))
		self._imageBg:getChildren()[1]:setPositionX(width/2)
		self:adjustI18n()
		return
	end

	--确定位置
	local nodePos = self._fromNode:convertToWorldSpaceAR(cc.p(0,0))
	local dstPos = self:convertToNodeSpace(cc.p(nodePos.x, nodePos.y))
	self._imageBg:setPosition(dstPos)
end

function TreasureLimitCostPanel:onExit()
	self._signalTreasureLimitLvPutRes:remove()
	self._signalTreasureLimitLvPutRes = nil
end

function TreasureLimitCostPanel:updateUI()
	for i, item in ipairs(self._items) do
		item:updateCount()
	end
end

function TreasureLimitCostPanel:_onClickIcon(materials)
	if self._onClick then
		G_AudioManager:playSoundWithId(AudioConst.SOUND_LIMIT_TIANCHONG)
		self._onClick(self._costKey, materials)
	end
end

function TreasureLimitCostPanel:_onStepClickIcon(itemId, itemValue, costCountEveryTime)
	if self._onStep then
		G_AudioManager:playSoundWithId(AudioConst.SOUND_LIMIT_TIANCHONG)
		local continue, realCostCount, isDo = self._onStep(self._costKey, itemId, itemValue, costCountEveryTime)
		return continue, realCostCount, isDo
	end
end

function TreasureLimitCostPanel:_onStartCallback(itemId, count)
	if self._onStart then
		self._onStart(self._costKey, itemId, count)
	end
end

function TreasureLimitCostPanel:_onStopCallback()
	if self._onStop then
		self._onStop()
	end
end

function TreasureLimitCostPanel:_onClickPanel()
	self:close()
end

function TreasureLimitCostPanel:_onTreasureLimitLvPutRes(eventName, idx)
	if self.updateUI then
		self:updateUI()
	end
end

function TreasureLimitCostPanel:findNodeWithItemId(itemId)
	for i, id in ipairs(self._itemIds) do
		if id == itemId then
			return self._items[i]
		end
	end
	return nil
end

function TreasureLimitCostPanel:getCostKey()
	return self._costKey
end

-- i18n ja change line
function TreasureLimitCostPanel:adjustI18n()
	--多机型适配位置
	local scene = G_SceneManager:getTopScene()   
	local view = scene:getSceneView()
	local _listView = ccui.Helper:seekNodeByName(view, "_listView")  
	local newWorldPos = _listView:getParent():convertToWorldSpace(cc.p(_listView:getPositionX(), _listView:getPositionY()))
	newWorldPos = self._imageBg:getParent():convertToNodeSpace(cc.p(newWorldPos.x - 326 - 4, newWorldPos.y - 5)) 
	self._imageBg:setPosition(newWorldPos)

	if #self._items == 1 then
		return
	end
	
	for i=1, #self._items do
		local strName = self._items[i]:getChildByName("TextValue"):getString()  -- 杜康酒超框 特殊处理

		self._items[i]:getChildByName("TextValue"):getVirtualRenderer():setMaxLineWidth(18*4)  --第二种方法
		self._items[i]:getChildByName("TextValue"):setString(strName)
		self._items[i]:getChildByName("TextValue"):setPositionY(-53 - 2)
		self._items[i]:getChildByName("TextValue"):getVirtualRenderer():setLineSpacing(-7) 
	end 
end

return TreasureLimitCostPanel