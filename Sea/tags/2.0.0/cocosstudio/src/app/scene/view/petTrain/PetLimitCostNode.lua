local CommonLimitCostNode = require("app.ui.component.CommonLimitCostNode")
local PetLimitCostNode = class("PetLimitCostNode", CommonLimitCostNode)
local LimitCostConst = require("app.const.LimitCostConst")

local RES_CONST = {
    [LimitCostConst.LIMIT_COST_KEY_1] = {
        imageButtom = "img_limit_03",
        imageFront = "img_limit_03b",
        effectBg = "effect_tujiepurple",
        imageName = "txt_limit_03",
        ripple = "purple",
        effectFull = "effect_tujie_mannengliangpurple",
        moving = "moving_tujieballpurple",
        effectReceive = "effect_tujiedianjipurple"
    },
    [LimitCostConst.LIMIT_COST_KEY_2] = {
        imageButtom = "img_limit_04",
        imageFront = "img_limit_04b",
        effectBg = "effect_tujieorange",
        imageName = "txt_limit_04",
        ripple = "orange",
        effectFull = "effect_tujie_mannengliangorange",
        moving = "moving_tujieballorange",
        effectReceive = "effect_tujiedianjiorange"
    }
}

function PetLimitCostNode:ctor(target, costKey, callback)
    PetLimitCostNode.super.ctor(self, target, costKey, callback)
end

function PetLimitCostNode:changeImageName()
    self._imageName:loadTexture(Path.getTextLimit(RES_CONST[self._costKey].imageName))
end

function PetLimitCostNode:_check()
    self._isShowCount = true
end

function PetLimitCostNode:initImageFront()
    self:_initImageFront(RES_CONST[self._costKey].imageButtom, RES_CONST[self._costKey].imageFront)
end

function PetLimitCostNode:initEffectBg()
    self:_initEffectBg(RES_CONST[self._costKey].effectBg)
end

function PetLimitCostNode:initRipple()
    self:_initRipple(RES_CONST[self._costKey].ripple)
end

function PetLimitCostNode:getFullEffectName()
    return RES_CONST[self._costKey].effectFull
end

function PetLimitCostNode:getMoving()
    return RES_CONST[self._costKey].moving
end

function PetLimitCostNode:getEffectReceiveName()
    return RES_CONST[self._costKey].effectReceive
end

function PetLimitCostNode:_calPercent(limitLevel, curCount)
    if self._costKey == LimitCostConst.LIMIT_COST_KEY_1 then
        return 100, 1
    end
    local PetTrainHelper = require("app.scene.view.petTrain.PetTrainHelper")
    local costInfo = PetTrainHelper.getCurLimitCostInfo()
    local size = costInfo["size_" .. self._costKey]
    local percent = math.floor(curCount / size * 100)
    return math.min(percent, 100), PetTrainHelper.getLimitCostItemMaxNums()
end

return PetLimitCostNode
