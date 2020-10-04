local HeroGoldLevelNode = class("HeroGoldLevelNode")

function HeroGoldLevelNode:ctor(target)
    self._target = target
    self:_init()
end

function HeroGoldLevelNode:_init()
    self._image1 = ccui.Helper:seekNodeByName(self._target, "Effect1")
    self._image2 = ccui.Helper:seekNodeByName(self._target, "Effect2")
    self._image3 = ccui.Helper:seekNodeByName(self._target, "Effect3")
    self._image4 = ccui.Helper:seekNodeByName(self._target, "Effect4")
    self._image5 = ccui.Helper:seekNodeByName(self._target, "Effect5")
end

function HeroGoldLevelNode:setCount(count)
    -- i18n ja change icon 太极 
    if Lang.checkUI("ui4") then 
        for i = 1, 5 do
            self["_image" .. i]:removeAllChildren()
            self["_image" .. i]:setVisible(true)
            local path = ""
            if i <= count then
                path = Path.getTextTeam("img_niepan_l")
            else
                path = Path.getTextTeam("img_niepan_a")
            end
            local image = ccui.ImageView:create()
            image:loadTexture(path)   
            image:setPosition(cc.p(0, 0))
            self["_image" .. i]:addChild(image)
        end
        return
    end

    for i = 1, 5 do
        if i <= count then
            self["_image" .. i]:setVisible(true)
            self["_image" .. i]:removeAllChildren()
            G_EffectGfxMgr:createPlayMovingGfx(self["_image" .. i], "moving_jinjiangyangcheng_bagua", nil, nil)
        else
            self["_image" .. i]:setVisible(false)
        end
    end
end

return HeroGoldLevelNode
