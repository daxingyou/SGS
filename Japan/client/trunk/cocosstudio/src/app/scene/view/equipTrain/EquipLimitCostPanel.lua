local PopupCommonLimitCost = require("app.ui.PopupCommonLimitCost")
local EquipLimitCostPanel = class("EquipLimitCostPanel", PopupCommonLimitCost)
local HeroConst = require("app.const.HeroConst")
local DataConst = require("app.const.DataConst")
local HeroDataHelper = require("app.utils.data.HeroDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local LimitCostConst = require("app.const.LimitCostConst")
local EquipTrainHelper = require("app.scene.view.equipTrain.EquipTrainHelper")

function EquipLimitCostPanel:ctor(costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode, limitUpType)
    EquipLimitCostPanel.super.ctor(self, costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode, limitUpType)
end

function EquipLimitCostPanel:_initView()
    local info = EquipTrainHelper.getLimitUpCostInfo()
    if self._costKey == LimitCostConst.LIMIT_COST_KEY_1 then
        local tbPos = {
            [1] = {46, 148},
            [2] = {110, 56},
            [3] = {225, 56},
            [4] = {290, 148}
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
            local item =
                self:_createMaterialIcon(
                DataConst["ITEM_REFINE_STONE_" .. i],
                info["consume_" .. self._costKey],
                TypeConvertHelper.TYPE_ITEM
            )
            item:setPosition(cc.p(tbPos[i][1], tbPos[i][2]))
        end
    else
        local itemType = TypeConvertHelper.TYPE_ITEM
        if self._costKey == LimitCostConst.LIMIT_COST_KEY_2 then
            itemType = TypeConvertHelper.TYPE_EQUIPMENT
        end
        local item =
            self:_createMaterialIcon(info["value_" .. self._costKey], info["consume_" .. self._costKey], itemType)
        if itemType == TypeConvertHelper.TYPE_EQUIPMENT then
            local Equipment = require("app.config.equipment")
            local config = Equipment.get(info["value_" .. self._costKey])
            item:setNameColor(Colors.getColor(config.color))
            item:showNameBg(true)
        end
    end
    self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
    -- self._panelTouch:setSwallowTouches(false)
    self._panelTouch:setScale(3)
    self._panelTouch:addClickEventListener(handler(self, self._onClickPanel)) --避免0.5秒间隔
end

-- i18n ja func
function EquipLimitCostPanel:onEnter()
	if not Lang.checkUI("ui4") then   
		return
    end
    
    local num = #self._items
    local width = self._items[1]:getChildByName("PanelTouch"):getBoundingBox().width*0.8

    width = 10 + num*(width + 15) - 2
    if #self._items == 1 then   		-- 仅一个材料，背景框要适配描述字
        width = 210
        self._items[1]:setPosition(cc.p(width*0.5, 86))
    end
    self._imageBg:setContentSize(cc.size(width, 140))
    self._imageBg:getChildren()[1]:setPositionX(width/2)
    --self:adjustI18n()

    -- --多机型适配位置
	-- local scene = G_SceneManager:getTopScene()   
	-- local view = scene:getSceneView()
	-- local _listView = ccui.Helper:seekNodeByName(view, "_listView")  
	-- local newWorldPos = _listView:getParent():convertToWorldSpace(cc.p(_listView:getPositionX(), _listView:getPositionY()))
	-- newWorldPos = self._imageBg:getParent():convertToNodeSpace(cc.p(newWorldPos.x - 326 - 4, newWorldPos.y - 5)) 
	-- self._imageBg:setPosition(newWorldPos)
end

return EquipLimitCostPanel
