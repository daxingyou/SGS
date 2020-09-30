local VipViewBoxNode = class("VipViewBoxNode")

VipViewBoxNode.STATE_NORMAL = 1
VipViewBoxNode.STATE_OPEN = 2
VipViewBoxNode.STATE_EMPTY = 3

function VipViewBoxNode:ctor(target)
	self._target = target

    self._textPoint = nil
    self._imageBox = nil

    self._touchFunc = nil

    self._imageNormal = nil
    self._imageOpen = nil
    self._imageEmpty = nil


    self._state = nil

	self:_init()
end

function VipViewBoxNode:_init()
    self._imageBox = ccui.Helper:seekNodeByName(self._target, "Image_Box")
    self._imageBox:setTouchEnabled(true)
    self._imageBox:addClickEventListenerEx(handler(self, self._onBoxClick), true, nil, 0)
    self._redPoint = ccui.Helper:seekNodeByName(self._target, "RedPoint")
    self._redPoint:setVisible(false)
    self._nodeEffectA = ccui.Helper:seekNodeByName(self._target, "Node_a")
end

function VipViewBoxNode:addTouchFunc(func)
    self._touchFunc = func
end

function VipViewBoxNode:setParam(param)
    self._imageNormal = param.imageClose
    self._imageOpen = param.imageOpen
    self._imageEmpty = param.imageEmpty
    self._imageBox:loadTexture(self._imageNormal)
end

function VipViewBoxNode:_onBoxClick()
    if self._touchFunc then
        self._touchFunc(self)
    end
end

function VipViewBoxNode:setBoxState(state)
    if self._state == state then
        return
    end
    self:showRedPoint(false)
    self._imageBox:ignoreContentAdaptWithSize(true)
    if state == VipViewBoxNode.STATE_NORMAL then
        self._imageBox:loadTexture(self._imageNormal)
    elseif state == VipViewBoxNode.STATE_OPEN then
        self._imageBox:loadTexture(self._imageOpen)
        self:showRedPoint(true)
    elseif state == VipViewBoxNode.STATE_EMPTY then
        self._imageBox:loadTexture(self._imageEmpty)
      
    end
    self._state = state
end

function VipViewBoxNode:getState()
    return self._state
end

function VipViewBoxNode:showRedPoint(s)
    self._redPoint:setVisible(s)
    if s == true then
        self:_playEffectGfx()
    else
        self:_stopEffectGfx()
    end
end

function VipViewBoxNode:_stopEffectGfx()
    self._nodeEffectA:removeAllChildren()
end

--根据funcId 播放特效
function VipViewBoxNode:_playEffectGfx()
    self:_stopEffectGfx()

    G_EffectGfxMgr:createPlayGfx(self._nodeEffectA,"effect_zhaomu_baoxiang")
   
end


return VipViewBoxNode