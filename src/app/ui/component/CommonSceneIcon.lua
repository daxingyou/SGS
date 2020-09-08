local CommonIconBase = import(".CommonIconBase")
local CommonSceneIcon = class("CommonSceneIcon",CommonIconBase)

local ComponentIconHelper = require("app.ui.component.ComponentIconHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UIHelper  = require("yoka.utils.UIHelper")

local EXPORTED_METHODS = {
    "setCallback",
    "updateIcon",
}

function CommonSceneIcon:ctor()
    CommonSceneIcon.super.ctor(self)
    self._type = TypeConvertHelper.TYPE_MAIN_SCENE
end

function CommonSceneIcon:_init()
    CommonSceneIcon.super._init(self)

    self._panelItemContent:setContentSize(cc.size(134,100))
end

function CommonSceneIcon:bind(target)
    CommonSceneIcon.super.bind(self, target)
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonSceneIcon:unbind(target)
    CommonSceneIcon.super.unbind(self, target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonSceneIcon:setCallback( callback )
    CommonSceneIcon.super.setCallback(self, callback)
end

-- --重写refreshToEmpty
function CommonSceneIcon:refreshToEmpty(useUnknow)

end

--根据传入参数，创建并，更新UI
function CommonSceneIcon:updateUI(value)
    local itemParams = TypeConvertHelper.convert(self._type, value, nil, nil, nil)
    self._itemParams = itemParams
    local scale = 0.65
    self._imageIcon:setScale(scale)
    self._imageBg:setScale(scale)
    self._imageIcon:loadTexture(itemParams.icon)
end

function CommonSceneIcon:_onTouchCallBack(sender, state)
    -----------防止拖动的时候触发点击
    if (state == ccui.TouchEventType.ended) then
        local moveOffsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
        local moveOffsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
        if moveOffsetX < 20 and moveOffsetY < 20 then
            if self._callback then
                self._callback(self._target, self._itemParams)
            end
            if self._itemParams then
                local PopupItemInfo = require("app.ui.PopupItemInfo").new()
                PopupItemInfo:updateUI(self._type, self._itemParams.cfg.id)
                PopupItemInfo:openWithAction()
            end
        end
    end
end

function CommonSceneIcon:setIconMask()
end

function CommonSceneIcon:setIconSelect(showSelect)
    CommonSceneIcon.super.setIconSelect(self, showSelect)
    self._imageSelect:setPositionX(self:getPanelSize().width/2)
end

function CommonSceneIcon:setName(name)
    CommonSceneIcon.super.setName(self, name)
    self._labelItemName:setPositionX(self:getPanelSize().width/2)
end

return CommonSceneIcon
