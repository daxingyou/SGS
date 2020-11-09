local ViewBase = require("app.ui.ViewBase")
local TeamPictureShareLayer = class("TeamPictureScrollView", ViewBase)

function TeamPictureShareLayer:ctor(parent)
    self._parent = parent
    local resource = {
		size = G_ResolutionManager:getDesignSize(),
		file = Path.getCSB("TeamPictureShareLayer", "teamPictureScroll"),
		binding = {
            _btnClose = {
				events = {{event = "touch", method = "_onBtnClose"}}
			},
		},
	}
	TeamPictureShareLayer.super.ctor(self, resource)
end

function TeamPictureShareLayer:onCreate()
    self:setColor(cc.c4b(0, 0, 0, 255 * 0.8))

    self._layerColor = cc.LayerColor:create(cc.c4b(0, 0, 0, 255 * 0.5))
	self._layerColor:setAnchorPoint(0, 0)
	self._layerColor:setPosition(0, 0)
	self._panelBase:addChild(self._layerColor)
	self._layerColor:setTouchEnabled(false)
    
    -- self._panelBase:setSwallowTouches(true)
    self._panelTwitter:addClickEventListenerEx(handler(self,self._onShareTwitter))
    self._panelDownload:addClickEventListenerEx(handler(self,self._onDownload))
end

function TeamPictureShareLayer:_onShareTwitter()
    -- body
end

function TeamPictureShareLayer:_onDownload()
    self:_onSaveImage("shot.png")
end

function TeamPictureShareLayer:_onSaveImage(fileName, rect)
    if self._parent._rt then
        local texture = self._parent._rt:getSprite():getTexture()
        local sprite = cc.Sprite:createWithTexture(texture)
        sprite:setAnchorPoint(0, 0)
        sprite:setFlippedY(true)

        local label1 = cc.Label:createWithSystemFont("", "Arial", 50)
        label1:setString(G_UserData:getBase():getName())
        label1:setColor(cc.c3b(255, 0, 0))
        label1:setPosition(400, 40)
        sprite:addChild(label1)

        local width = self._parent._scroll:getInnerContainerSize().width
        local height = self._parent._scroll:getInnerContainerSize().height
        -- local rt = cc.RenderTexture:create(width, height, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888, 0x88F0)
        -- local rt = cc.RenderTexture:create(width, height, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)
        local rt = cc.RenderTexture:create(width, height)
        rt:beginWithClear(0, 0, 0, 0)
        sprite:visit()
        rt:endToLua()

        local ret = rt:saveToFile(fileName, cc.IMAGE_FORMAT_PNG, true)
        if ret then
            print("save ok")
            G_Prompt:showTip("图片保存成功")
            -- self:_release()
        else
            print("not ok")
            -- self:_release()
        end
    end
end

function TeamPictureShareLayer:_release()
    if self._parent._rt and not tolua.isnull(self._parent._rt) then
        self._parent._rt:release()
    end 
end

function TeamPictureShareLayer:_onBtnClose()
    self:_release()
    self._parent:_showShare(true)
    self:removeFromParent(true)
end


return TeamPictureShareLayer