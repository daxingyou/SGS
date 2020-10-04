--
-- Author: Liangxu
-- Date: 2018-8-7
-- 武将界限消耗面板

local PopupCommonLimitCost = require("app.ui.PopupCommonLimitCost")
local HeroLimitCostPanel = class("HeroLimitCostPanel", PopupCommonLimitCost)
local CSHelper = require("yoka.utils.CSHelper")
local HeroConst = require("app.const.HeroConst")
local DataConst = require("app.const.DataConst")
local HeroDataHelper = require("app.utils.data.HeroDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local LimitCostConst = require("app.const.LimitCostConst")
local EquipTrainHelper = require("app.scene.view.equipTrain.EquipTrainHelper")

function HeroLimitCostPanel:ctor(costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode, otherInfo)
	self._baseId = otherInfo.baseId
	self._limitRed = otherInfo.limitRed
	HeroLimitCostPanel.super.ctor(self, costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode)
end

function HeroLimitCostPanel:_initView()
	local info = HeroDataHelper.getHeroLimitCostConfig(self._limitLevel, self._limitRed)
	
	local tbPos = {}
	tbPos[1] = {
		[1] = {170, 53},
	}
	tbPos[2] = {
		[1] = {110, 56},
		[2] = {225, 56},
	}
	tbPos[3] = {
		[1] = {80, 85},
		[2] = {170, 53},
		[3] = {260, 85},
	}
	tbPos[4] = {
		[1] = {46, 148},
		[2] = {110, 56},
		[3] = {225, 56},
		[4] = {290, 148}
	}

	-- i8n ja change
	if Lang.checkUI("ui4") then
		tbPos[2] = {
			[1] = {82 + 5, -220},         
			[2] = {3 + 5, -220},
		}

		tbPos[4] = {
			[1] = {82 + 5, -220},
			[2] = {3 + 5, -220},
			[3] = {-76 + 5, -220},
			[4] = {-156 + 5, -220},
		}
	end


	if self._costKey == LimitCostConst.LIMIT_COST_KEY_1 then
		for i = 1, 4 do
			local item =
				self:_createMaterialIcon(
				DataConst["ITEM_HERO_LEVELUP_MATERIAL_" .. i],
				info["consume_" .. self._costKey],
				TypeConvertHelper.TYPE_ITEM
			)
			item:setPosition(cc.p(tbPos[4][i][1], tbPos[4][i][2]))
		end
	else
		local configKey = HeroDataHelper.getLimitCostConfigKey(self._costKey)
		local type = info[configKey.type]
		local value = info[configKey.value]
		local consume = info[configKey.consume]

		if type==99 then
			if value==1 then
				local id = self._baseId
				self:_createMaterialIcon( 				-- 自己的武将胚子
					id,
					consume,
					TypeConvertHelper.TYPE_HERO
				)
			else
				local id = self._baseId
				local list = HeroDataHelper.getSameCountryHeroes(id, 7) 	-- 同阵营金将
				local num = #list
				for i=1,num do
					local item =
						self:_createMaterialIcon(
							list[i],
							consume,
							TypeConvertHelper.TYPE_HERO
					)
					item:setPosition(cc.p(tbPos[num][i][1], tbPos[num][i][2]))
				end
			end
		else
			self:_createMaterialIcon(
				value,
				consume,
				TypeConvertHelper.TYPE_ITEM
			)
		end
	end

	self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
	-- self._panelTouch:setSwallowTouches(false)
	self._panelTouch:addClickEventListener(handler(self, self._onClickPanel)) --避免0.5秒间隔
end

function HeroLimitCostPanel:onEnter()
	self._signalHeroLimitLvPutRes =
		G_SignalManager:add(SignalConst.EVENT_HERO_LIMIT_LV_PUT_RES, handler(self, self._onHeroLimitLvPutRes))

	-- i18n ja pos 确定位置
	if Lang.checkUI("ui4") then   
		local num = #self._items
		local width = self._items[1]:getChildByName("PanelTouch"):getBoundingBox().width*0.8

		width = 10 + num*(width + 15) - 2
		if #self._items == 1 then   		-- 仅一个材料，背景框要适配描述字
			width = 210
			self._items[1]:setPositionX(25)
		end
		self._imageBg:setContentSize(cc.size(width, 140))
		self._imageBg:getChildren()[1]:setPositionX(width/2)
		self:adjustI18n()
		return
	end

	--确定位置
	local nodePos = self._fromNode:convertToWorldSpaceAR(cc.p(0, 0))
	local dstPos = self:convertToNodeSpace(cc.p(nodePos.x, nodePos.y))
	self._imageBg:setPosition(dstPos)
end

function HeroLimitCostPanel:onExit()
	self._signalHeroLimitLvPutRes:remove()
	self._signalHeroLimitLvPutRes = nil
end

function HeroLimitCostPanel:_onHeroLimitLvPutRes(eventName, costKey)
	if self.updateUI then
		self:updateUI()
	end
end

function HeroLimitCostPanel:turnDown()
	local list = {}
	table.insert(list, self)
	for _,item in pairs(self._items) do
		table.insert(list, item)
	end
	local node = ccui.Helper:seekNodeByName(self, "TextTip")
	table.insert(list, node)
	for i,v in ipairs(list) do
		v:setScaleY(-v:getScaleY())
	end
end

-- i18n ja change line
function HeroLimitCostPanel:adjustI18n()
	-- 策劃需求 字号调大
	for i=1, #self._items do
		ccui.Helper:seekNodeByName(self._items[i], "TextValue"):setFontSize(ccui.Helper:seekNodeByName(self._items[i], "TextValue"):getFontSize() + 1)
	end

	if #self._items == 1 then
		return
	end
	
	for i=1, #self._items do
		local strName = self._items[i]:getChildByName("TextValue"):getString()  -- 杜康酒超框 特殊处理

		self._items[i]:getChildByName("TextValue"):getVirtualRenderer():setMaxLineWidth(18*4)  --第二种方法
		self._items[i]:getChildByName("TextValue"):setString(strName)
		self._items[i]:getChildByName("TextValue"):setPositionY(-53 - 2)
		self._items[i]:getChildByName("TextValue"):getVirtualRenderer():setLineSpacing(-1) 
	end 
end

return HeroLimitCostPanel
