local PopupBase = require("app.ui.PopupBase")
local PopupSmallRechargeMenuTips = class("PopupSmallRechargeMenuTips", PopupBase)

function PopupSmallRechargeMenuTips:ctor(fromNode)
	self._fromNode = fromNode
	local resource = {
		file = Path.getCSB("PopupSmallRechargeMenuTips", "smallrecharge"),
		binding = {
			
		}
	}
	PopupSmallRechargeMenuTips.super.ctor(self, resource, false, true)
end

function PopupSmallRechargeMenuTips:onCreate()
	self._imageArrow:loadTexture(Path.getSmallRechargeRes("arrow"))
	self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
	self._panelTouch:setSwallowTouches(false)
	self._panelTouch:addClickEventListener(handler(self, self._onClick)) --避免0.5秒间隔
end

function PopupSmallRechargeMenuTips:onEnter()
	self._signalCustomActInfo = G_SignalManager:add(SignalConst.EVENT_CUSTOM_ACTIVITY_INFO, handler(self, self._initListView))
	self._signalCustomActUpdate = G_SignalManager:add(SignalConst.EVENT_CUSTOM_ACTIVITY_UPDATE, handler(self, self._initListView))

    self:_initListView()
    self:_updatePos()
end

function PopupSmallRechargeMenuTips:onExit()
	self._signalCustomActInfo:remove()
	self._signalCustomActInfo = nil
	self._signalCustomActUpdate:remove()
	self._signalCustomActUpdate = nil

	G_ServiceManager:DeleteOneAlarmClock("PopupSmallRechargeMenuTips")
end

function PopupSmallRechargeMenuTips:_initListView()
    -- body
    self._listItem:removeAllChildren()
    local PopupSmallRechargeMenuTipsItemCell = require("app.scene.view.smallrecharge.PopupSmallRechargeMenuTipsItemCell")
    local UserDataHelper = require("app.utils.UserDataHelper")
    local iconData = UserDataHelper.getSmallAmountRechargeMainIconData()
	self._listViewData = iconData.list
	self._items = {}
	--table.insert(self._listViewData,self._listViewData[1])
	--table.insert(self._listViewData,self._listViewData[1])

	for k, v in pairs(self._listViewData) do
        local item = PopupSmallRechargeMenuTipsItemCell.new()
        item:updateUI(v)
		self._listItem:pushBackCustomItem(item)
		self._items[k] = item
	end

	logWarn("jjjjjjjjjjjjjjjj"..#self._listViewData)
	local height = 100
	if #self._listViewData > 3 then
		--self._listItem:setContentSize(cc.size(74,174))
		--self._listItem:setTouchEnabled(true)
		--self._listItem:doLayout()
		local cellHeight = 68
		height = cellHeight * 3.5  + 12 
	else
		local cellHeight = 68
		height = cellHeight * #self._listViewData  + 12 
	end
	

	local size = self._panel:getContentSize()
	self._panel:setContentSize(cc.size(size.width,height+12))
	
	self._listItem:setContentSize(cc.size(size.width,height))
	
    if #self._listViewData <= 1 then
        self:close()
    else
        local data = self._listViewData[1]
		local time = data.endTime
		local curTime = G_ServerTime:getTime()
		if curTime < time then 
			print(curTime.." PopupSmallRechargeMenuTips time "..time)
			G_ServiceManager:registerOneAlarmClock(
				"PopupSmallRechargeMenuTips",
				time,
				function()
					print("PopupSmallRechargeMenuTips time out ")
					self:_initListView()
				end
			)
		end
		
    end
end


--重写opne&close接口，避免黑底层多层时的混乱现象
function PopupSmallRechargeMenuTips:open()
	local scene = G_SceneManager:getRunningScene()
	scene:addChildToPopup(self)
end

function PopupSmallRechargeMenuTips:close()
	self:onClose()
	self.signal:dispatch("close")
	self:removeFromParent()
end

function PopupSmallRechargeMenuTips:_updatePos()
	--确定位置
	local nodePos = self._fromNode:convertToWorldSpace(cc.p(0,0))
	local posX = nodePos.x + 40
	local posY = nodePos.y 
	local dstPos = self:convertToNodeSpace(cc.p(posX, posY))
	self._imageArrow:setPosition(dstPos)
end

function PopupSmallRechargeMenuTips:_onClick()
	self:close()
end

return PopupSmallRechargeMenuTips