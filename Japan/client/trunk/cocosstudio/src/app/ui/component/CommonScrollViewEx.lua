--复用的CellListView，类似于cocos TableView
--目前支持刷新Cell，并滚动到指定cell

local CommonScrollViewEx = class("CommonScrollViewEx")
local scheduler = require("cocos.framework.scheduler")



local EXPORTED_METHODS = {
    "setTemplate",
    "resize",
    "setCallback",
    "setCustomCallback",
	"clearAll",
	"reloadData",
	"setLocation",
	"updateCellList",
	"getItems", --接口兼容
	"getItem",
	"playEnterEffect",
	"getItemByTag",
	"getItemBottomLocation",
	"getStartEndIndex", -----
	"isInVisibleRegion",
	"setLocationByPos",
	"setSpacing",
    "setRemoveChildren",
    "clearCellAnimation",
}

--
function CommonScrollViewEx:ctor()
	self._target = nil
	self._textTitle = nil
	self._btnClose = nil
	self._totalRange = 0
end

--
function CommonScrollViewEx:_init()
	self._spawnCount = 0
	self._cellsUsed  = {} -- cells that are currently in the table
	self._cellsFreed = {} -- free list of cells
	self._dataSource = {}
	self._isUsedCellsDirty = false
	----------------------------------------------------------------
	self._items = {}
	self._spacing = 0--self._target:getItemsMargin() --Item间隔
	local size = self._target:getContentSize()
	self._listViewHeight = size.height
	self._listViewWidth = size.width
	self._direction = self._target:getDirection()
	self._totalRange = size.height
	if self._direction == ccui.ListViewDirection.horizontal then
		self._totalRange = size.width
	end
	self._isInitTouch = false
	self._isRemoveChildren = true
end

--
function CommonScrollViewEx:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
	self._target:setScrollBarEnabled(false)
end

--
function CommonScrollViewEx:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end


function CommonScrollViewEx:setRemoveChildren(isRemove)
	self._isRemoveChildren = isRemove
end

function CommonScrollViewEx:_initTouchEvent( ... )
	if self._isInitTouch == true then
		return
	end
	
	self._target:addTouchEventListener(function(sender, touchType)
		if touchType == ccui.TouchEventType.ended then
			if self._selectedCallback then
				local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
				local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
				if moveOffsetX < 20 and moveOffsetY < 20 then
					local endPosition = self._target:getTouchEndPosition()
					local point = self._target:getInnerContainer():convertToNodeSpace(endPosition)
					local index = self:_indexFromOffset(point)
					if index == -1 then
						return
					end
					local item = self:cellAtIndex(index)
					if item then
						self._selectedCallback(item, item:getIdx() - 1, eventType)
					end
				end
			end
		end
	end)

    self._target:addEventListener(function(sender, eventType)
		if self._scrollEvent then
			self._scrollEvent(sender, eventType)
		end
		if eventType == 9 then--CONTAINER_MOVED
            self:_onUpdate(0)
        end
		if self._eventListener then	
			self._eventListener(sender, eventType)
		end
    end)
	self._isInitTouch = true
end
--
function CommonScrollViewEx:setCallback(update, selected, scrollEvent,eventListener)
	self._updateItemCallback = update
	self._selectedCallback = selected
	self._scrollEvent = scrollEvent
	self._eventListener = eventListener
end

--
function CommonScrollViewEx:setCustomCallback(callback)
	self._customCallback = callback
end

--
function CommonScrollViewEx:setTemplate(template, itemWidth, itemHeight)
	self._template = template
	local widget = template.new()

	local size = widget:getContentSize()
	self._templateWidth = itemWidth or size.width
	self._templateHeight = itemHeight or size.height
	--
	if self._direction == ccui.ListViewDirection.vertical then
		self._bufferZone = self._templateHeight + self._spacing

	elseif self._direction == ccui.ListViewDirection.horizontal then
		self._bufferZone = self._templateWidth + self._spacing
	end
	self._updateTimer = 0
	self._lastContentPos = 0
	--self._target:setScrollBarPositionFromCorner(cc.p(7,7))
end

function CommonScrollViewEx:updateCellList(cellNum)
	--数量相同的刷新
	if self._totalCount == cellNum then
		--位置不影响
		local oldPos = self._target:getInnerContainerPosition()
		self:reloadData()
		self._target:setInnerContainerPosition(oldPos)
		return
	end

	--数量不相同的刷新
	if self._totalCount ~= cellNum then
		self._totalCount = cellNum
	end
	local oldPos = self:_getNewOffset()
	self:reloadData()
	--位置需要调整
	self._target:setInnerContainerPosition(oldPos)
end



function CommonScrollViewEx:_getContainerSize()
	if self._direction ~= ccui.ListViewDirection.horizontal then
		return cc.size(self._listViewWidth,self._templateHeight * self._totalCount + (self._totalCount - 1) * self._spacing)
	else
		return cc.size(self._templateWidth * self._totalCount + (self._totalCount - 1) * self._spacing,self._listViewHeight)
	end
end

function CommonScrollViewEx:_getListSize()
	local size = self:_getContainerSize()
	if self._direction ~= ccui.ListViewDirection.horizontal then
		if size.height < self._listViewHeight then
			size.height = self._listViewHeight
		end
		return size
	else
		if size.width < self._listViewWidth then
			size.width = self._listViewWidth
		end
		return size
	end
end
--旧偏移位置进行最小值修正
function CommonScrollViewEx:_getNewOffset( ... )
	-- body
	--todo  ----------------
	local minScollRange = self._direction ~= ccui.ListViewDirection.horizontal and self._listViewHeight or  self._listViewWidth

	local containerSize = self:_getContainerSize()

	if self._direction ~= ccui.ListViewDirection.horizontal then
		if minScollRange > containerSize.height then
			return  {x = 0,y = 0}--self._target:getInnerContainerPosition()
		end
	else
		if minScollRange > containerSize.width then
			return  {x = 0,y = 0}--self._target:getInnerContainerPosition()
		end
	end
	
	local minY = math.min(0,self._listViewHeight - containerSize.height)
	local minX = math.min(0,self._listViewWidth - containerSize.width)
	local offset = self._target:getInnerContainerPosition()

	if self._direction ~= ccui.ListViewDirection.horizontal then
		if(minY > offset.y)then
			offset.y = minY
		end
	--	offset.y = offset.y
	else
		if(minX > offset.x)then
			offset.x = minX
		end
	end
	return offset
	--self._target:setInnerContainerPosition(offset)
end
--
function CommonScrollViewEx:resize(size)
	--已经初始化过
	if self._totalCount and self._totalCount > 0 then
		self:updateCellList(size)
		return
	end

	--尚未初始化
	self._totalCount = size

	self:reloadData()
	self:_initTouchEvent()
end

--
function CommonScrollViewEx:_respawn()
	if self._direction == ccui.ListViewDirection.vertical then
    	--self._target:jumpToTop()
	elseif self._direction == ccui.ListViewDirection.horizontal then
    	--self._target:jumpToLeft()
	end

end

--


--
function CommonScrollViewEx:getStartEndIndex()
	local startIdx, endIdx = self:_getStartEndIndex()
	return startIdx, endIdx
end

function CommonScrollViewEx:_onUpdate(f)
	self._updateTimer = self._updateTimer + f

	--self._bufferZone = self._templateHeight + self._spacing
	--self._reuseItemOffset = (self._templateHeight + self._spacing) * self._spawnCount
	self._updateTimer = 0
	if self._direction == ccui.ListViewDirection.vertical then
		self:scrollViewDidScroll()
	    self._lastContentPos = self._target:getInnerContainer():getPositionY()
	elseif self._direction == ccui.ListViewDirection.horizontal then
		self:scrollViewDidScroll()

	    self._lastContentPos = self._target:getInnerContainer():getPositionX()
	end
end

function CommonScrollViewEx:clearAll()
end

--根据总数量
--计算每个cell应该所在位置--预先生成
function CommonScrollViewEx:_updateCellPositions()
	local totalCount = self._totalCount

	local tempList = {}
	if totalCount > 0 then
		local currPos = 0
		local cellSize = cc.size(self._templateWidth + self._spacing, self._templateHeight + self._spacing)
		for i =1 , totalCount do
			tempList[i] = currPos
			if self._direction == ccui.ListViewDirection.vertical then
				currPos = currPos + cellSize.height
			elseif self._direction == ccui.ListViewDirection.horizontal then
				currPos = currPos + cellSize.width
			end
		end
		tempList[totalCount+1] = currPos
		--table.sort(tempList, function(a,b) return a < b end)
	end
--	dump(tempList)
	self._cellPosition = tempList
end

--创建并更新Template
function CommonScrollViewEx:tableCellAtIndex(index)
	local widget = self:dequeueCell()
	if widget == nil then
		widget = self._template.new()
		self._target:getInnerContainer():addChild(widget)
		--logWarn("widget = self._template.new()")
	end
	widget:setVisible(true)
	widget:setCustomCallback(self._customCallback)
	self:_setIndexForCell(index, widget)

	if self._updateItemCallback then
	    self._updateItemCallback(widget, index-1)
	end

	return widget
end

function CommonScrollViewEx:_updateContentSize()
	-- 计算滚动范围
	local innerContainerSize = self._target:getInnerContainerSize()
	if self._direction == ccui.ListViewDirection.vertical then
		self._totalRange = self._templateHeight * self._totalCount + (self._totalCount - 1) * self._spacing

		if self._totalRange < self._listViewHeight then
			self._totalRange = self._listViewHeight
		end
		innerContainerSize.height = self._totalRange
	elseif self._direction == ccui.ListViewDirection.horizontal then
		self._totalRange = self._templateWidth * self._totalCount + (self._totalCount - 1) * self._spacing

		if self._totalRange < self._listViewWidth then
			self._totalRange = self._listViewWidth
		end
		innerContainerSize.width = self._totalRange
	end

	--self._target:forceDoLayout()
	self._target:setInnerContainerSize(innerContainerSize)
end

--根据偏移量，得到cellIndex
function CommonScrollViewEx:_indexFromOffset(offset)
	local index = nil
	local maxIdx =  self._totalCount


	if self._direction ==  ccui.ListViewDirection.vertical then
		offset.y = self._totalRange - offset.y
	elseif self._direction == ccui.ListViewDirection.horizontal then
		offset.x = offset.x
	end

    

	local function indexFromOffset(offsetPos)

		local low = 1
		local high = self._totalCount

		local search = offsetPos.y or 0
		if self._direction == ccui.ListViewDirection.horizontal then
			search = offsetPos.x or 0
		end

		--二分查找法
		while high >= low do
			local index = math.floor( low + (high -low) / 2 )
			local cellStart = self._cellPosition[index]
			local cellEnd   = self._cellPosition[index + 1]
			if search >= cellStart and search <= cellEnd then
				return index
			elseif search < cellStart then
				high = index - 1
			else
				low = index + 1
			end
		end
		if low <= 1 then
			return 1
		end

		return -1
	end
	index = indexFromOffset(offset)
	if index ~= -1 then
		index = math.max(1, index)
		if index > maxIdx then
			index = -1
		end
	end
	return index
end

--ITEM左下角相对容器的位置
function CommonScrollViewEx:_offsetFromIndex(index)
	local function offsetFromIndex(index)
		local offset = cc.p(0,0)
		--dump(self._cellPosition)
		offset = cc.p( 0, self._cellPosition[index] )
		if self._direction == ccui.ListViewDirection.horizontal then
			offset = cc.p(  self._cellPosition[index], 0 )
		end
		return offset
	end
	local offsetPos = offsetFromIndex(index)


	if self._direction ==  ccui.ListViewDirection.vertical then
		offsetPos.y = self._totalRange - offsetPos.y - self._templateHeight 
	elseif self._direction == ccui.ListViewDirection.horizontal then
		offsetPos.x =  offsetPos.x 
	end

	return offsetPos
end

--刷新当前listView
function CommonScrollViewEx:reloadData( ... )
	-- body
	if self._isRemoveChildren then
		self._target:removeAllChildren()
		self._cellsFreed = {}
		self._indices = {}
		self._cellsUsed = {}
		self._isUsedCellsDirty = false
	else
        --logWarn("---------------- isRemoveChildren ")
		self:_releaseAllCells() 
	end

	self._target:setTouchEnabled(true)
	

    self:_updateCellPositions()
    self:_updateContentSize()


    if  self._totalCount > 0 then
    	self:scrollViewDidScroll()
    end
end


function CommonScrollViewEx:_releaseAllCells()
	for i, usedCell in ipairs(self._cellsUsed) do
		usedCell:reset()
		usedCell:setVisible(false)
		table.insert(self._cellsFreed, usedCell)
	end

  	self._indices = {}
    self._cellsUsed = {}
	self._isUsedCellsDirty = false
end

function CommonScrollViewEx:_getStartEndIndex( ... )
	-- body
	local countOfItems = self._totalCount
	local startIdx = 0
	local endIdx= 0
	local offset = self._target:getInnerContainerPosition() -- 滚动条起始位置都是从最大高度的负数开始

	offset.y = offset.y * -1
	offset.x = offset.x * -1

	if self._direction ==  ccui.ListViewDirection.vertical then
		offset.y = offset.y + self._listViewHeight
	elseif self._direction == ccui.ListViewDirection.horizontal then
		offset.x = offset.x 
	end

	

	local templateRange = self._templateHeight *2
	startIdx = self:_indexFromOffset(cc.p(offset.x, offset.y)) --根据offset得到起始index
	if startIdx == -1 then
		startIdx = countOfItems
	end

	
	if self._direction ==  ccui.ListViewDirection.vertical then
		offset.y = offset.y - self._listViewHeight
	elseif self._direction == ccui.ListViewDirection.horizontal then
		offset.x = offset.x + self._listViewWidth
	end

	endIdx = self:_indexFromOffset(cc.p(offset.x, offset.y))
	if endIdx == -1 then
		endIdx = countOfItems
	end
	return startIdx, endIdx
end


function CommonScrollViewEx:playEnterEffect( endCallBack )
	if self._target:isTouchEnabled() == false then
		return
	end
	
	local movingName= "smoving_shangdian_icon"
	local movingFrameTime = 8 * 0.025 --8帧
	local interval = 0.06
	local startIdx, endIdx = self:_getStartEndIndex()
	self._target:setTouchEnabled(false)
	self._target:stopAllActions()
	--self._target:setVisible(false)

	local function createCallFunc(curIndex)
		local function effectFinishCallback(eventName)
		end
		local callFunc = cc.CallFunc:create(function()
			local cellItem = self:cellAtIndex(curIndex)	
			if cellItem then
				cellItem:setVisible(true)
				--self._target:setVisible(true)
				G_EffectGfxMgr:applySingleGfx(cellItem, movingName, effectFinishCallback)
			end
		end)
		return callFunc
	end

	local totalDelayTime = 0
	for i = startIdx, endIdx do
		local cell = self:cellAtIndex(i)
		if cell then
			cell:setCascadeOpacityEnabled(true)
			cell:setVisible(false)
			cell:stopAllActions()
			cell:unscheduleUpdate()
			local offsetPos = self:_offsetFromIndex(i)
		    cell:setPosition(offsetPos)
			totalDelayTime = interval * (i - startIdx)
			local delayAction = cc.DelayTime:create(totalDelayTime)
			local action = cc.Sequence:create(delayAction, createCallFunc(i))
			cell:runAction(action)
		end
	end
	
	--动画结束后回调
	local delayAction = cc.DelayTime:create(totalDelayTime + movingFrameTime)
	local targetAction = cc.Sequence:create(delayAction, cc.CallFunc:create(function( ... )
		if self._target then
			self._target:setTouchEnabled(true)
		end
		if endCallBack then
			endCallBack()
		end
	end))
	self._target:runAction(targetAction)
end

function CommonScrollViewEx:scrollViewDidScroll()
	local countOfItems = self._totalCount
    if 0 == countOfItems then
        return
    end

    if self._isUsedCellsDirty then
        self._isUsedCellsDirty = false
		table.sort(self._cellsUsed, function(cell1, cell2)
				return cell1:getIdx() < cell2:getIdx()
		end)
    end

	local startIdx = 0
	local endIdx= 0
	local idx = 0
	local maxIdx =math.max(countOfItems, 0)

    local offset = self._target:getInnerContainerPosition() -- 滚动条起始位置都是从最大高度的负数开始

	offset.y = offset.y * -1
	offset.x = offset.x * -1

	if self._direction ==  ccui.ListViewDirection.vertical then
		offset.y = offset.y + self._listViewHeight
	elseif self._direction == ccui.ListViewDirection.horizontal then
		offset.x = offset.x 
	end

	
	
	startIdx = self:_indexFromOffset(cc.p(offset.x, offset.y)) --根据offset得到起始index
	if startIdx == -1 then
		startIdx = countOfItems
	end

	if self._direction ==  ccui.ListViewDirection.vertical then
		offset.y = offset.y - self._listViewHeight
	elseif self._direction == ccui.ListViewDirection.horizontal then
		offset.x = offset.x + self._listViewWidth
	end

	

	endIdx = self:_indexFromOffset(cc.p(offset.x, offset.y))
	if endIdx == -1 then
		endIdx = countOfItems
	end

	--logWarn(string.format( "InnerPosY[%d] maxIdx[%d] startIdx[%d] endIdx[%d]", offset.y, maxIdx, startIdx, endIdx))

	local function procCellUsedBegin( ... )
		if #self._cellsUsed ==0 then
			return
		end
		local cell = self._cellsUsed[1]
		if cell == nil then
			return
		end

		local idx = cell:getIdx()
		while idx < startIdx do
			--logWarn(string.format( "removeStarIndex idx[%d]",idx))
			self:_moveCellOutOfSight(cell)
			if #self._cellsUsed > 0 then
				cell = self._cellsUsed[1]
				idx = cell:getIdx()
			else
				break
			end
		end
	end

	local function procCellUsedEnd( ... )
		if #self._cellsUsed == 0 then
			return
		end
		local cell = self._cellsUsed[#self._cellsUsed]
		if cell == nil then
			return
		end
		local idx = cell:getIdx()
		while idx <= maxIdx and idx > endIdx do
			--logWarn(string.format( "removeEndIndex idx[%d]",idx))
			self:_moveCellOutOfSight(cell)
			if #self._cellsUsed > 0 then
				cell = self._cellsUsed[#self._cellsUsed]
				idx = cell:getIdx()
			else
				break
			end
		end
	end

	procCellUsedBegin()
	procCellUsedEnd()


	for i = startIdx, endIdx do
		if self._indices[i] == nil then
			self:updateCellAtIndex(i)
		end
	end

	--self._target:getInnerContainer():forceDoLayout()
	--_tableViewDelegate:scrollViewDidScroll()
end

function CommonScrollViewEx:updateCellAtIndex(idx)
    if idx == -1 then
        return
	end
	--logWarn("CommonScrollViewEx:updateCellAtIndex ::: "..idx)
    local countOfItems = self._totalCount
    if 0 == countOfItems and idx > countOfItems then
       return
	end

    local cellWidget = self:cellAtIndex(idx)
    if cellWidget then
        self:_moveCellOutOfSight(cellWidget)
    end

	--创建并更新
    local cellWidget = self:tableCellAtIndex( idx )

    self:_addCellIfNecessary(cellWidget)
end

function CommonScrollViewEx:cellAtIndex(idx)
	if self._indices[idx] ~= nil then
		for i, cell in ipairs(self._cellsUsed) do
			if cell:getIdx() == idx then
				return cell
			end
		end
	end
	return nil
end

-- @Role    Reconstruction cell's clearAnimation(Before using
function CommonScrollViewEx:clearCellAnimation()
    if self._cellsUsed then
        for i, cell in ipairs(self._cellsUsed) do
			cell:clearAnimation()
		end
	end
	return nil
end

function CommonScrollViewEx:_moveCellOutOfSight(cell)
	--cell:retain()
    table.insert( self._cellsFreed, cell)

	for i, usedCell in ipairs(self._cellsUsed) do
		if usedCell:getIdx() == cell:getIdx() then
			table.remove(self._cellsUsed, i)
			break
		end
	end
	--logWarn(string.format( "_moveCellOutOfSight idx [%d]",cell:getIdx() ))
    self._isUsedCellsDirty = true
	self._indices[cell:getIdx()] = nil
    cell:reset()

    --if cell:getParent() == self._target:getInnerContainer() then
	cell:setVisible(false)
    --end
end


function CommonScrollViewEx:_setIndexForCell(index, cell)
    cell:setAnchorPoint(cc.p(0, 0))
	local offsetPos = self:_offsetFromIndex(index)
	--dump(offsetPos)
    cell:setPosition(offsetPos)
    cell:setIdx(index)
	cell:setTag(index-1)

end

function CommonScrollViewEx:_addCellIfNecessary(cell)

    table.insert(self._cellsUsed, cell)
 	self._indices[cell:getIdx()] = true
    self._isUsedCellsDirty = true

	cell:setVisible(true)
	--dump(self._indices)
end

function CommonScrollViewEx:dequeueCell()
    local cell = nil
    if #self._cellsFreed == 0 then
        cell = nil
    else
        cell =  self._cellsFreed[1]
		--logWarn("CommonScrollViewEx:dequeueCell 拿出老的复用")
        table.remove(self._cellsFreed, 1)
    end


    return cell
end


function CommonScrollViewEx:setLocation(index,customOffset)
	customOffset = customOffset or 0
	self._target:stopAutoScroll()--定位位置，这时候不能处于滚动状态

	local offset = self:_offsetFromIndex(index)
	--dump(offset)
	local listSize = self:_getListSize()
	if self._direction ==  ccui.ListViewDirection.vertical then
		offset.y = offset.y - (self._listViewHeight -self._templateHeight)
		offset.y = offset.y * -1
		offset.y = offset.y - customOffset
		local minY = self._listViewHeight - listSize.height
		offset.y = math.max(offset.y,minY)
		offset.y = math.min(offset.y,0)
	elseif self._direction == ccui.ListViewDirection.horizontal then
		offset.x = offset.x * -1
		offset.x = offset.x - customOffset
		local minX = self._listViewWidth - listSize.width
		offset.x = math.max(offset.x,minX)
		offset.x = math.min(offset.x,0)
	end
	self._target:setInnerContainerPosition( offset )
    self:scrollViewDidScroll()
end

function CommonScrollViewEx:setLocationByPos(pos)
	self._target:stopAutoScroll()--定位位置，这时候不能处于滚动状态
	local listSize = self:_getListSize()
	if self._direction ==  ccui.ListViewDirection.vertical then
		local minY = self._listViewHeight - listSize.height
		pos.y = math.max(pos.y,minY)
		pos.y = math.min(pos.y,0)
	else
		local minX = self._listViewWidth - listSize.width
		pos.x = math.max(pos.x,minX)
		pos.x = math.min(pos.x,0)
	end

	self._target:setInnerContainerPosition( pos )
	self:scrollViewDidScroll()
end

--只适配垂直滚动，反馈Item底部位置
function CommonScrollViewEx:getItemBottomLocation(index)
	local offset = self:_offsetFromIndex(index)
	if self._direction ==  ccui.ListViewDirection.vertical then
		return offset.y
	else
		return offset.x
	end
	
end

--只适配垂直滚动
function CommonScrollViewEx:isInVisibleRegion(index)

	if self._direction ==  ccui.ListViewDirection.vertical then
		local offset = self:_offsetFromIndex(index)
		local buttomPos = offset.y
		local topPos = buttomPos + self._templateHeight

		local visibleMinPos = -self._target:getInnerContainer():getPositionY()
		local visibleMaxPos = visibleMinPos +  self._listViewHeight
		logWarn("PopupMailReward  isInVisibleRegion ??? "..tostring(buttomPos))
		logWarn("PopupMailReward  isInVisibleRegion ??? "..tostring(topPos))
		logWarn("PopupMailReward  isInVisibleRegion ??? "..tostring(visibleMinPos))
		logWarn("PopupMailReward  isInVisibleRegion ??? "..tostring(visibleMaxPos))
		if buttomPos >= visibleMinPos and topPos <= visibleMaxPos then
			return true
		end
		return false
	else
		local offset = self:_offsetFromIndex(index)
		local buttomPos = offset.x
		local topPos = buttomPos + self._templateWidth

		local visibleMinPos = -self._target:getInnerContainer():getPositionX()
		local visibleMaxPos = visibleMinPos +  self._listViewWidth
		logWarn("PopupMailReward  isInVisibleRegion ??? "..tostring(buttomPos))
		logWarn("PopupMailReward  isInVisibleRegion ??? "..tostring(topPos))
		logWarn("PopupMailReward  isInVisibleRegion ??? "..tostring(visibleMinPos))
		logWarn("PopupMailReward  isInVisibleRegion ??? "..tostring(visibleMaxPos))
		if buttomPos >= visibleMinPos and topPos <= visibleMaxPos then
			return true
		end
		return false
	end


	
end

function CommonScrollViewEx:_getItemPositionYInView(item)
	local worldPos = item:getParent():convertToWorldSpaceAR(cc.p(item:getPosition()))
    local viewPos = self._target:convertToNodeSpaceAR(cc.p(worldPos))
    return viewPos.y
end

--
function CommonScrollViewEx:_getItemPositionXInView(item)
	local worldPos = item:getParent():convertToWorldSpaceAR(cc.p(item:getPosition()))
    local viewPos = self._target:convertToNodeSpaceAR(cc.p(worldPos))
    return viewPos.x
end


function CommonScrollViewEx:getItems( ... )
	return self._target:getChildren()
end

function CommonScrollViewEx:getItem( index )
	-- body
	index = index + 1
	local childList = self._target:getChildren()
	return childList[index]
end

function CommonScrollViewEx:getItemByTag(index)
	--[[
	local items = self:getItems()
	local itemCellNode = nil
	for k,v in ipairs(items) do
		if v:getTag()  ==  index then
			itemCellNode = v
		end
	end
	return itemCellNode
]]
	if not index then
		return nil
	end
	return self:cellAtIndex(index+1)
end

function CommonScrollViewEx:setSpacing(spacing )
	self._spacing = spacing
end


return CommonScrollViewEx
