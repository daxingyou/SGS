
local UserDataHelper = require("app.utils.UserDataHelper")
local ActivitySubView = require("app.scene.view.activity.ActivitySubView")
local VipViewGiftPkg = class("VipViewGiftPkg", ActivitySubView)

function VipViewGiftPkg:ctor()
	--csb bind var name
	self._listView = nil  --ListView
	local resource = {
        file = Path.getCSB("VipViewGiftPkg", "vip"),
        binding = {
		}
	}
	VipViewGiftPkg.super.ctor(self, resource)
end

-- Describle：
function VipViewGiftPkg:onCreate()
    local VipGiftPkgItemCell = require("app.scene.view.vip.VipGiftPkgItemCell")
    self._listItemSource:setTemplate(VipGiftPkgItemCell)
    self._listItemSource:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	self._listItemSource:setCustomCallback(handler(self, self._onItemTouch))
	self._listItemSource:setSpacing(0)

	cc.bind(self._buttonPrivilege,"CommonButtonHighLight")
	self._buttonPrivilege:setString(Lang.get("vip_privilege_btn"))
	self._buttonPrivilege:addClickEventListenerEx(handler(self,self._onBtnPrivilege))
end

-- Describle：
function VipViewGiftPkg:onEnter()
    self._signalVipGetVipGiftItems = G_SignalManager:add(SignalConst.EVENT_VIP_GET_VIP_GIFT_ITEMS, handler(self, self._onEventGetVipGift))
	self._signalVipExpChange = G_SignalManager:add(SignalConst.EVENT_VIP_EXP_CHANGE, handler(self, self._onEventVipExpChange ))
    self:_updateList()
	self:_updateListPos()
	self:_refreshSkinInfo()
end

-- Describle：
function VipViewGiftPkg:onExit()
	self._signalVipGetVipGiftItems:remove()
	self._signalVipGetVipGiftItems = nil

	self._signalVipExpChange:remove()
	self._signalVipExpChange = nil
end

function VipViewGiftPkg:_onClickSkin()
	
end

function VipViewGiftPkg:_onBtnPrivilege()
    G_SceneManager:showDialog("app.scene.view.vip.PopupPrivilegeView")
end

function VipViewGiftPkg:_onEventGetVipGift(id, message)
	--显示奖励
	local awards = rawget(message, "reward") or {}
	if Lang.checkUI("ui4") then
		local awardsNew,skinAwards = G_UserData:getMails():processAwardsByI18n(awards)
		dump(skinAwards,"lkmskinAwards")
		local UIPopupHelper = require("app.utils.UIPopupHelper")
		UIPopupHelper.popupAwardsBackgroundSkin(function()
			if #awardsNew > 0 then
				local PopupGetRewards = require("app.ui.PopupGetRewards").new()
				PopupGetRewards:showRewards(awardsNew)
			end
		end,skinAwards)
	else
		local PopupGetRewards = require("app.ui.PopupGetRewards").new()
		PopupGetRewards:showRewards(awards)
	end
	 
    self:_updateList()
end

function VipViewGiftPkg:_onEventVipExpChange(id, message)
	print("VipViewGiftPkg ...vip exchange ")
	self:_updateList()
	self:_refreshSkinInfo()
end

-- Describle：
function VipViewGiftPkg:enterModule()
end

function VipViewGiftPkg:_onItemUpdate(item, index)
	if self._listData[index + 1] then
		item:updateUI(self._listData[index + 1] )
	end
end

function VipViewGiftPkg:_onItemSelected(item, index)
end

function VipViewGiftPkg:_onItemTouch(lineIndex,index)
	local vipItemData = self._listData[index + 1]
	if not vipItemData then
		return
	end
	
	local vipLevel = vipItemData:getId()
	local playerVipLevel = G_UserData:getVip():getLevel()
	if playerVipLevel < vipLevel then	
		local WayFuncDataHelper = require("app.utils.data.WayFuncDataHelper")
		local VipConst = require("app.const.VipConst")
        WayFuncDataHelper.gotoModuleByFuncId(FunctionConst.FUNC_RECHARGE)    
		return
	end

    local config = vipItemData:getInfo()
	local LogicCheckHelper = require("app.utils.LogicCheckHelper")
	local success,popFunc = LogicCheckHelper.enoughCash(config.price)
	if success == true then
        G_NetworkManager:send(MessageIDConst.ID_C2S_GetVipReward, {
		    vip_level = vipItemData:getId(),
	    })
	elseif popFunc then
		popFunc()			
	end
end

function VipViewGiftPkg:_updateList()
	self._listData = UserDataHelper.getVipGiftPkgList() 
	self._listItemSource:clearAll()
	self._listItemSource:resize(#self._listData)
end

function VipViewGiftPkg:_updateListPos()
	local index = UserDataHelper.findFirstCanReceiveGiftPkgIndex(self._listData)
	if not index then
		index = UserDataHelper.findFirstUnReceiveGiftPkgIndex(self._listData)
	end
	if not index then
		index = #self._listData
	end
	self._listItemSource:setLocation(index)
end

function VipViewGiftPkg:_refreshSkinInfo()
	local skinInfo = UserDataHelper.getNextSkinInfo()
	if skinInfo then
	
		
		self._imageVipLv:setVisible(true)
		local TypeConvertHelper = require("app.utils.TypeConvertHelper")
		local itemParams = TypeConvertHelper.convert(skinInfo.type,skinInfo.value,skinInfo.size)
		self._imageGirl:setVisible(true)
		self._imageGirl:ignoreContentAdaptWithSize(true)
		self._imageGirl:loadTexture(itemParams.nameImg)
		self._imageVipLv:loadTexture(Path.getVip2("LV "..skinInfo.level))
		if skinInfo.value == 3 then
			self._imageGirl:setPositionX(292)
		end
	else
		self._textLv:setVisible(false)
		self._imageVipLv:setVisible(false)
	end
end




return VipViewGiftPkg
