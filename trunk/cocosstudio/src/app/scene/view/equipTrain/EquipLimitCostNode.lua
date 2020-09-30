local CommonLimitCostNode = require("app.ui.component.CommonLimitCostNode")
local EquipLimitCostNode = class("EquipLimitCostNode", CommonLimitCostNode)
local LimitCostConst = require("app.const.LimitCostConst")
local EquipTrainHelper = require("app.scene.view.equipTrain.EquipTrainHelper")

function EquipLimitCostNode:ctor(target, costKey, callback, limitUpType)
    EquipLimitCostNode.super.ctor(self, target, costKey, callback, limitUpType)
end

function EquipLimitCostNode:changeImageName()
    local resIds = EquipTrainHelper.getLimitUpCostNameResIds()
    -- i18n change lable
    if Lang.checkLang(Lang.CN) then
        self._imageName:loadTexture(Path.getTextLimit(resIds[self._costKey]))
    else
        self._imageName:setString(
            Lang.getImgText(resIds[self._costKey])
        )
    end
end

function EquipLimitCostNode:_check()
    self._isShowCount = true
end

function EquipLimitCostNode:playSMoving()
    local smoving = LimitCostConst.RES_NAME[self._costKey].smoving[1]
    if self._costKey == LimitCostConst.LIMIT_COST_KEY_2 then
        smoving = "smoving_tujiehuansanjiao"
    end
    G_EffectGfxMgr:applySingleGfx(
        self._target,
        smoving,
        function()
            self._target:setVisible(false)
        end
    )
end

function EquipLimitCostNode:_calPercent(limitLevel, curCount)
    local info = EquipTrainHelper.getLimitUpCostInfo()
    local size = info["size_" .. self._costKey] or 0
    local percent = math.floor(curCount / size * 100)
    return math.min(percent, 100), size
end

function EquipLimitCostNode:setImageFront(id)
    self._imageFront:loadTexture(Path.getLimitImg(id))
end

function EquipLimitCostNode:setPositionY(y)
    self._initPos.y = y
end

function EquipLimitCostNode:adjustScaleAndPos()
    self["_costNode"..key]._buttonAdd:setScale(0.7)  -- +号缩放

    self["_costNode"..key]._imageName:setAnchorPoint(cc.p(0.5, 0.5))  
    self["_costNode"..key]._imageName:setPosition(cc.p(0, -47))
    self["_costNode"..key]._textPercent:setAnchorPoint(cc.p(0.5, 0.5))
    self["_costNode"..key]._textPercent:setPosition(cc.p(0, -72))

    self["_costNode"..key]._textPercent:setFontSize(18)
    self["_costNode"..key]._textPercent:setColor(Colors.BRIGHT_BG_ONE)
    self["_costNode"..key]._textPercent:disableEffect(cc.LabelEffect.OUTLINE)
    if not Lang.checkLang(Lang.CN) then
        self["_costNode"..key]._imageName:setFontSize(18)
        self["_costNode"..key]._imageName:setColor(Colors.NORMAL_BG_ONE) 
        self["_costNode"..key]._imageName:disableEffect(cc.LabelEffect.OUTLINE)
    end
    self["_costNode"..key]._nodeFull:getParent():setScale(0.9) 	-- 这个node缩放90%
end


return EquipLimitCostNode
