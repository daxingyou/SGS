local PopupBase = require("app.ui.PopupBase")
local PopupLevelPkgMenuTips = class("PopupLevelPkgMenuTips", PopupBase)

function PopupLevelPkgMenuTips:ctor(fromNode)
	self._fromNode = fromNode
	local resource = {
		file = Path.getCSB("PopupLevelPkgMenuTips", "new_level_pkg"),
		binding = {
			
		}
	}
	PopupLevelPkgMenuTips.super.ctor(self, resource, false, true)
end

function PopupLevelPkgMenuTips:onCreate()
	self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
	self._panelTouch:setSwallowTouches(false)
	self._panelTouch:addClickEventListener(handler(self, self._onClick)) --避免0.5秒间隔
end

function PopupLevelPkgMenuTips:onEnter()
    self._signalLevelGift = G_SignalManager:add(SignalConst.EVENT_WELFARE_LEVEL_GIFT_INFO, handler(self, self._initListView))
    self:_initListView()
    self:_updatePos()
end

function PopupLevelPkgMenuTips:onExit()
    self._signalLevelGift:remove()
	self._signalLevelGift = nil

	G_ServiceManager:DeleteOneAlarmClock("PopupLevelPkgMenuTips")
end

function PopupLevelPkgMenuTips:_initListView()
    -- body
    self._listItem:removeAllChildren()
    local PopupLevelPkgMenuTipsItemCell = require("app.scene.view.newLevelPkg.PopupLevelPkgMenuTipsItemCell")
    local UserDataHelper = require("app.utils.UserDataHelper")
    local iconData = UserDataHelper.getNewLevelPkgMainIconData()
	self._listViewData = iconData.list
	self._items = {}
	--table.insert(self._listViewData,self._listViewData[1])
	--table.insert(self._listViewData,self._listViewData[1])

	for k, v in pairs(self._listViewData) do
        local item = PopupLevelPkgMenuTipsItemCell.new()
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
			print(curTime.." PopupLevelPkgMenuTips time "..time)
			G_ServiceManager:registerOneAlarmClock(
				"PopupLevelPkgMenuTips",
				time,
				function()
					print("PopupLevelPkgMenuTips time out ")
					self:_initListView()
				end
			)
		else
			--超时还能显示，肯定是审核状态
		end
		
    end
end

function PopupLevelPkgMenuTips:_onEventWelfareLevelGiftInfo(event,newAddUnitList)    
    if #newAddUnitList < 0 then
        return
    end
    self:_initListView()
end


--重写opne&close接口，避免黑底层多层时的混乱现象
function PopupLevelPkgMenuTips:open()
	local scene = G_SceneManager:getRunningScene()
	scene:addChildToPopup(self)
end

function PopupLevelPkgMenuTips:close()
	self:onClose()
	self.signal:dispatch("close")
	self:removeFromParent()
end

function PopupLevelPkgMenuTips:_updatePos()
	--确定位置
	local nodePos = self._fromNode:convertToWorldSpace(cc.p(0,0))
	local posX = nodePos.x + 40
	local posY = nodePos.y 
	local dstPos = self:convertToNodeSpace(cc.p(posX, posY))
	self._imageArrow:setPosition(dstPos)
end

function PopupLevelPkgMenuTips:_onClick()
	self:close()
end

return PopupLevelPkgMenuTips