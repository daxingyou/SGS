local PopupCommonLimitCost = require("app.ui.PopupCommonLimitCost")
local PetLimitCostPanel = class("PetLimitCostPanel", PopupCommonLimitCost)
local LimitCostConst = require("app.const.LimitCostConst")
local DataConst = require("app.const.DataConst")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

function PetLimitCostPanel:ctor(costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode)
    PetLimitCostPanel.super.ctor(self, costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode)
end

function PetLimitCostPanel:_initView()
    local PetTrainHelper = require("app.scene.view.petTrain.PetTrainHelper")
    local info = PetTrainHelper.getCurLimitCostInfo()
    if self._costKey == LimitCostConst.LIMIT_COST_KEY_1 then
		local tbPos = {
			[1] = {42, 84},
			[2] = {120, 84},
			[3] = {199, 84},
			[4] = {278, 84},
		}
 
		for i = 1, 4 do
			local item =
				self:_createMaterialIcon(
				DataConst["ITEM_PET_LEVELUP_MATERIAL_" .. i],
				info["consume_" .. self._costKey],
				TypeConvertHelper.TYPE_ITEM
			)
			item:setPosition(cc.p(tbPos[i][1], tbPos[i][2]))
		end
	else
		self:_createMaterialIcon(
			info["value_" .. self._costKey],
			info["consume_" .. self._costKey],
			TypeConvertHelper.TYPE_ITEM
		)
	end
	self._panelTouch:setScale(3)
	self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
    self._panelTouch:addClickEventListener(handler(self, self._onClickPanel)) --避免0.5秒间隔
end

function PetLimitCostPanel:fitterItemCount(item)
    local type = item:getType()
    local value = item:getItemId()
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local PetTrainHelper = require("app.scene.view.petTrain.PetTrainHelper")
    if type == TypeConvertHelper.TYPE_PET then
        item:updateCount(PetTrainHelper.getCanConsumePetNums(value))
    else
        item:updateCount()
    end
end

 
function PetLimitCostPanel:onEnter()
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
	end
end
 
function PetLimitCostPanel:adjustI18n() 
	-- 修改字号
	for i=1, #self._items do
		ccui.Helper:seekNodeByName(self._items[i], "TextValue"):setFontSize(ccui.Helper:seekNodeByName(self._items[i], "TextValue"):getFontSize() + 1)
	end

	-- --多机型适配位置
	-- local scene = G_SceneManager:getTopScene()   
	-- local view = scene:getSceneView() 
	-- local _listView = ccui.Helper:seekNodeByName(view, "_listView")  
	-- local newWorldPos = _listView:getParent():convertToWorldSpace(cc.p(_listView:getPositionX(), _listView:getPositionY()))
	-- newWorldPos = self._imageBg:getParent():convertToNodeSpace(cc.p(newWorldPos.x - 326 - 4, newWorldPos.y - 5)) 
	-- self._imageBg:setPosition(newWorldPos)

	if self._items == 1 then
		return
	end

	for i=1, #self._items do
		local strName = self._items[i]:getChildByName("TextValue"):getString() 

		self._items[i]:getChildByName("TextValue"):getVirtualRenderer():setMaxLineWidth(18*4)  --第二种方法
		self._items[i]:getChildByName("TextValue"):setString(strName)
		self._items[i]:getChildByName("TextValue"):setPositionY(-53 - 2)
		self._items[i]:getChildByName("TextValue"):getVirtualRenderer():setLineSpacing(-1) 
	end 
end

return PetLimitCostPanel
