local PopupCommonLimitCost = require("app.ui.PopupCommonLimitCost")
local PetLimitCostPanel = class("PetLimitCostPanel", PopupCommonLimitCost)
local LimitCostConst = require("app.const.LimitCostConst")

function PetLimitCostPanel:ctor(costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode)
    PetLimitCostPanel.super.ctor(self, costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode)
end

function PetLimitCostPanel:_initView()
    local PetTrainHelper = require("app.scene.view.petTrain.PetTrainHelper")
    local costInfo = PetTrainHelper.getCurLimitCostInfo()
    self:_createMaterialIcon(
        costInfo["value_" .. self._costKey],
        costInfo["consume_" .. self._costKey],
        costInfo["type_" .. self._costKey]
    )
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

return PetLimitCostPanel
