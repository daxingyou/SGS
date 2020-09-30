local ViewBase = require("app.ui.ViewBase")
local UpdateView = class("UpdateView", ViewBase)

-- i18n ja change CSB
local UpdateViewBulletinCell = require("app.scene.view.login.UpdateViewBulletinCell")
local IMAGE_LIST = {"Load_bg","Load_bg2","Load_bg3"}
local CREATE_NODE_NUM = 3
local ACTION_TIME = 0.25
local STAR_TIME = 15
-- end

function UpdateView:ctor()
	local resource = {
		file = Path.getCSB("UpdateView", "login"),
        size = G_ResolutionManager:getDesignSize()
	}

	-- i18n ja change CSB
	if Lang.checkUI("ui4") then

		self._layerColor = cc.LayerColor:create(cc.c4b(0, 0, 0, 255*0.8))
		self._layerColor:setAnchorPoint(0.5,0.5)
		local size = G_ResolutionManager:getDesignSize()
		self._layerColor:setPosition(cc.p(size[1]*0.5,size[2]*0.5))
		self._layerColor:setIgnoreAnchorPointForPosition(false)
		self:addChild(self._layerColor)

		resource.file = Path.getCSB("UpdateViewNew", "login")
		self._bulletParentNode = nil
		self._nodeIndicator = nil
		self._cellHead = nil
		self._currPage = 0
		self._isAction = false
	end
	
	UpdateView.super.ctor(self, resource)
end

function UpdateView:onCreate()
	self._lasttime = 0
	self._times = 0
	self._speed = "0"
	self._version = "unknown"
	self._loadingBar:setPercent(0)
	self._totalSize = 0
	self._loadingLabel:setString("")

	-- i18n ja change CSB
	if Lang.checkUI("ui4") then
		self:_initNewUI()
		self:_delayDoAction()
		
	end
end

function UpdateView:setPercent(percent)
	self._loadingBar:setPercent(percent)

	--local cur = string.format("%.2f", self._totalSize * percent / 100)
	--local max = string.format("%.2f", self._totalSize)
	if self._lasttime == 0 then self._lasttime = timer:gets()-1 end
	local t = math.ceil(timer:gets() - self._lasttime)
	if t > self._times then
		self._times = t
		self._speed = string.format("%.2fMB/s", self._totalSize * percent / 100 / self._times)
	end


	self._loadingLabel:setString(Lang.get("login_update_download", 
	{
		max = string.format("%.2f", self._totalSize), 
		speed = self._speed, 
		version = self._version
	}))

	
end

function UpdateView:setTotalSize(size)
	self._totalSize = size
end

function UpdateView:setProgressString(txt)
	self._loadingLabel:setString(txt)
end

function UpdateView:setProgressPercent(percent)
	self._loadingBar:setPercent(percent)
end

--
function UpdateView:showView(version)
	self._version = version or "unknown"
	self:setVisible(true)
end

--
function UpdateView:hideView()
	self:setVisible(false)
end

--i18n ja change CSB
function UpdateView:_initNewUI()


	self._nodeIndicator:refreshPageData(nil,#IMAGE_LIST,0,10)
	self:_createBulletinCells()
	self:_setCurrPage(1)
end


--i18n ja change CSB
function UpdateView:_createBulletinCells()
	local firstCellInfo = nil
	local lastCellInfo = nil
	for index = 1,CREATE_NODE_NUM,1 do
		local cell = UpdateViewBulletinCell.new()
		cell:setCascadeOpacityEnabled(true)
		cell:setCustomCallback(handler(self,self._onClickItemCell))
		cell:setAnchorPoint(cc.p(0.5,0.5))
		self._bulletParentNode:addChild(cell)
		local cellInfo = {node = cell,left = nil,right = nil,data = nil}
		if lastCellInfo then
			cellInfo.left = lastCellInfo
			lastCellInfo.right = cellInfo
		end
		if lastCellInfo == nil then
			firstCellInfo = cellInfo
		end
		lastCellInfo = cellInfo
	end
	if firstCellInfo then
		firstCellInfo.left = lastCellInfo
	end
	if lastCellInfo then
		lastCellInfo.right = firstCellInfo
	end
	self._cellHead = firstCellInfo
end




--index从1开始
function UpdateView:_setCurrPage(index)
	if self._currPage == index then
		return 
	end
	self._currPage = index
	self._nodeIndicator:setPageViewIndex(index-1)--从0开始

	
	local clearInfo = self._cellHead
	repeat
		clearInfo.data = nil
		clearInfo = clearInfo.right
	until(clearInfo == self._cellHead)


	local moveRightCursor = self._cellHead
	while moveRightCursor and moveRightCursor.data == nil do
		moveRightCursor.data = index 
		if moveRightCursor.node:getIdx() ~= index then
			moveRightCursor.node:setIdx(index)
			moveRightCursor.node:update(Path.getLoadUI(IMAGE_LIST[index]))
		end
		moveRightCursor.node:setPositionX(0)
		moveRightCursor.node:setOpacity(self._currPage == index and 255 or 0)   
	
		moveRightCursor = moveRightCursor.right
		index = self:_nextIndex(index)
	end
end

function UpdateView:_nextIndex(index)
	if index < #IMAGE_LIST then
		return index + 1
	else
		return 1
	end
end

function UpdateView:_getCellByIndex(index)
	local startCell = self._cellHead
	while startCell do
		if startCell.data == index  then
			return startCell
		end
		startCell = startCell.right
	end
	return nil
end

--i18n ja change CSB
function UpdateView:_delayDoAction()
	local stayAction = cc.DelayTime:create(STAR_TIME )
	self._bulletParentNode:runAction(
		cc.Sequence:create(
			stayAction,
			cc.CallFunc:create(function()
				self:_startAutoRoll()
			end)
		)
	)
end

--i18n ja change CSB
function UpdateView:_onClickItemCell(tag,index)
	--立即切换图片
	if self._isAction == true then
		return
	end

	self:_cancelAction()
	self:_startAutoRoll()
end

--i18n ja change CSB
function UpdateView:_cancelAction()
	self._bulletParentNode:stopAllActions()
end

function UpdateView:_onRollComplete()
	self:_delayDoAction()
end

--i18n ja change CSB
function UpdateView:_startAutoRoll()
	self._isAction = true
	local cell = self:_getCellByIndex(self._currPage)
	local fadeAction = cc.FadeTo:create(ACTION_TIME,0)
	cell.node:runAction(fadeAction)

	local delayAction = cc.DelayTime:create(ACTION_TIME)
	local action2 = cc.FadeIn:create(ACTION_TIME)
	local stayAction = cc.DelayTime:create(STAR_TIME)
	cell.right.node:runAction(
		cc.Sequence:create(
			delayAction,
			cc.CallFunc:create(function()
				cell.right.node:setOpacity(255*0.2)
			end),
			action2,
			cc.CallFunc:create(function()
				self._isAction = false
				local index = self:_nextIndex(self._currPage)
				self._nodeIndicator:setPageViewIndex(index-1)--从0开始
				self._cellHead = cell.right--优化，避免刷新Cell
				self:_setCurrPage(self:_nextIndex(self._currPage))
				self:_onRollComplete()
			end)
		)
	)

end


return UpdateView