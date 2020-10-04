local function swapBlackImg(source)
    local image = cc.Sprite:create(Path.get("bg_black_frame","background","ui3"))
    local sourceParent = source:getParent()
    source:setVisible(false)
    image:setLocalZOrder( source:getLocalZOrder() )
    image:setName(source:getName())
    sourceParent:removeChild(source)
    sourceParent:addChild(image)
    return image
end

if not Lang.checkLang(Lang.CN) then
	local height = G_ResolutionManager:getDesignHeight()
	local topImg = swapBlackImg(G_TopLevelNode._drawNodeTop)
	topImg:setFlippedY(true)
	topImg:setAnchorPoint(0.5,0)
	topImg:setPosition(display.cx,height)
	G_TopLevelNode._drawNodeTop = topImg

	local bottomImg = swapBlackImg(G_TopLevelNode._drawNodeBottom)
	bottomImg:setAnchorPoint(0.5,1)
	bottomImg:setPosition(display.cx,0)
	G_TopLevelNode._drawNodeBottom = bottomImg
end
