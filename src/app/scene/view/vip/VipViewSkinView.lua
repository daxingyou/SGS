local TextHelper = require("app.utils.TextHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local ViewBase = require("app.ui.ViewBase")
local VipViewSkinView = class("VipViewSkinView", ViewBase)

function VipViewSkinView:ctor()
	self._selectIndex = nil
	self._itemList = {}
    local resource = {
		file = Path.getCSB("VipViewSkinView", "vip"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonEquip = {
				events = {{event = "touch", method = "_onButtonEquip"}}
			}
		}
    }
    VipViewSkinView.super.ctor(self,resource)
end

function VipViewSkinView:onCreate()
	self._buttonEquip:setString(Lang.get("vip_skin_equip_button"))
	self._textConditionTitle:setString(Lang.get("vip_skin_condition_1"))
	self._textCondition:setString(Lang.get("vip_skin_condition_2"))
	self:_initListView()
end

function VipViewSkinView:onEnter()
	self._signalPosterGirlSkinInfoGet = G_SignalManager:add(SignalConst.EVENT_POSTER_GIRL_SKIN_INFO_GET, 
		handler(self, self._onEventPosterGirlSkinInfoGet))
	self._signalPosterGirlSkinUpdate = G_SignalManager:add(SignalConst.EVENT_POSTER_GIRL_SKIN_UPDATE, 
		handler(self, self._onEventPosterGirlSkinInfoGet))
	self._signalPosterGirlChangeSkinSuccess = G_SignalManager:add(SignalConst.EVENT_POSTER_GIRL_CHANGE_SKIN_SUCCESS, 
		handler(self, self._onEventPosterGirlChangeSkinSuccess))

	self:_refreshView()
end


function VipViewSkinView:onExit()
	self._signalPosterGirlSkinInfoGet:remove()
	self._signalPosterGirlSkinInfoGet = nil
	self._signalPosterGirlSkinUpdate:remove()
	self._signalPosterGirlSkinUpdate = nil
	self._signalPosterGirlChangeSkinSuccess:remove()
	self._signalPosterGirlChangeSkinSuccess = nil
end

function VipViewSkinView:_onEventPosterGirlSkinInfoGet()
	self:_refreshView()
end

function VipViewSkinView:_onEventPosterGirlChangeSkinSuccess()
	self:_refreshView()
end

function VipViewSkinView:_refreshView()
	local oldSelectSkinId = nil
	if self._selectIndex then
		oldSelectSkinId = self._itemList[self._selectIndex]
	end
	local index = nil
	self._itemList = UserDataHelper.getShowPosterList()
	if oldSelectSkinId then
		index = self:_getIndexBySkinId(oldSelectSkinId)
	end
	if not index then
		index = self:_getEquipIndex() or 1
	end
	
	self._selectIndex = index
	self:_refreshListView()
	self:_refreshSelectPosterGirlInfo(self._itemList[self._selectIndex])

	if not self._listItemSource:isInVisibleRegion(
		self._selectIndex) then
		self._listItemSource:setLocation(self._selectIndex)
	end
	
end

function VipViewSkinView:_getIndexBySkinId(id)
	for k,v in ipairs(self._itemList) do
        if v.id == id then
            return k
        end
    end
    return nil
end

function VipViewSkinView:_getEquipIndex()
	for k,v in ipairs(self._itemList) do
		local isEquip = UserDataHelper.isEquipPosterGirl(v.id)
        if isEquip then
            return k
        end
    end
    return nil
end

function VipViewSkinView:_initListView()
	-- body
	self._listItemSource = ccui.Helper:seekNodeByName(self,"ListItemSource")
	cc.bind(self._listItemSource,"CommonScrollViewEx")
	local VipViewSkinViewItemCell = require("app.scene.view.vip.VipViewSkinViewItemCell")
    self._listItemSource:setTemplate(VipViewSkinViewItemCell)
	self._listItemSource:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	self._listItemSource:setCustomCallback(handler(self, self._onItemTouch))
end


function VipViewSkinView:_getItemByIndex(index)
	print("ggggggggggg"..index)
	local items = self._listItemSource:getItems()
	for k,v in ipairs(items) do
		print("ssssssssss"..v:getIdx())
		if v:getIdx() == index then
			return v
		end
	end
end

function VipViewSkinView:_onItemUpdate(item, index)
	item:updateUI(self._itemList[index+1],self._selectIndex)
end

function VipViewSkinView:_onItemSelected(item, index)
	logWarn("VipViewSkinView:_onItemSelected "..index)
	if self._selectIndex == index + 1 then
		return
	end
	
	local oldSelectIndex = self._selectIndex
	self._selectIndex  = index + 1

	local data = self._itemList[ index + 1]
	self:_refreshSelectPosterGirlInfo(data)
	--self:_refreshListView()

	local oldItem = self:_getItemByIndex(oldSelectIndex)
	local newItem = self:_getItemByIndex(self._selectIndex)
	if oldItem then
		oldItem:setSelect(false)
	end
	if newItem then
		newItem:setSelect(true)
	end
end

function VipViewSkinView:_onItemTouch(index, shopItemData)
end

function VipViewSkinView:_refreshListView()
	local lineCount = math.ceil(#self._itemList)
	self._listItemSource:clearAll()
    self._listItemSource:resize(lineCount)
end

function VipViewSkinView:_onButtonEquip()
	local config = self._itemList[self._selectIndex]
	G_UserData:getPosterGirl():c2sSetPosterGirlSkin(config.id)

	local PosterGirlVoiceConst = require("app.const.PosterGirlVoiceConst")
	G_SignalManager:dispatch(SignalConst.EVENT_POSTER_GIRL_VOICE_UPDATE,PosterGirlVoiceConst.TRIGGER_POS_VIP_CHANGE_CLOTHES)
end

function VipViewSkinView:_refreshSelectPosterGirlInfo(config)
	self._textCondition:setString(config.des)
	local has = UserDataHelper.isHasPosterGirl(config.id)
	local isEquip = UserDataHelper.isEquipPosterGirl(config.id)
	if has then
		self._textConditionTitle:setVisible(false)
		self._textCondition:setVisible(false)
	else
		self._textConditionTitle:setVisible(true)
		self._textCondition:setVisible(true)
	end
	if isEquip then
		self._buttonEquip:setString(Lang.get("vip_skin_button_equiped"))
		self._buttonEquip:setEnabled(false)
	elseif has then
		self._buttonEquip:setString(Lang.get("vip_skin_button_equip"))
		self._buttonEquip:setEnabled(true)
	else
		self._buttonEquip:setString(Lang.get("vip_skin_button_equip"))
		self._buttonEquip:setEnabled(false)
	end
end

return VipViewSkinView