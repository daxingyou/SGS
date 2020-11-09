--弹出界面
--物品信息弹框
--点击物品时，弹出
local PopupBase = require("app.ui.PopupBase")
local PopupSkinInfo = class("PopupSkinInfo", PopupBase)
local Path = require("app.utils.Path")

local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")

local ICON_NORMAL_X = 78.21 -- 正常位置
local DESC_NORMAL_X = 143


function PopupSkinInfo:ctor(title, callback)
	--
	self._title = title or Lang.get("common_title_item_info")
	self._callback = callback
	self._itemId = nil
	self._useNum = 1
	--control init
	self._btnOk = nil --
	self._itemName = nil -- 物品名称
	self._itemDesc = nil -- 物品描述
	self._itemIcon = nil -- CommonItemIcon
	self._itemOwnerDesc = nil --拥有物品
	self._itemOwnerCount = nil --数量
	--
	local resource = {
		file = Path.getCSB("PopupSkinInfo", "common"),
		binding = {
			_btnOk = {
				events = {{event = "touch", method = "onBtnOk"}}
			}
		}
	}
	PopupSkinInfo.super.ctor(self, resource, true)
end

--
function PopupSkinInfo:onCreate()

	-- button
	self._btnOk:setString(Lang.get("item_info_preview"))

	self._commonNodeBk:addCloseEventListener(handler(self, self.onBtnCancel))
	self._commonNodeBk:setTitle(self._title)
	self._commonNodeBk:hideCloseBtn()
end

function PopupSkinInfo:updateUI(itemType, itemId)
	assert(itemId, "PopupSkinInfo's itemId can't be empty!!!")
	self._itemIcon:unInitUI()
	self._itemIcon:initUI(itemType, itemId)
	self._itemIcon:setTouchEnabled(false)
	self._itemIcon:setImageTemplateVisible(false)
	local itemParams = self._itemIcon:getItemParams()

	self._itemName:setString(itemParams.name)
	self._itemName:setColor(itemParams.icon_color)
    
    self._itemIcon:setPositionX(ICON_NORMAL_X)
    self._itemName:setPositionX(DESC_NORMAL_X)
    self._scrollView:setPositionX(DESC_NORMAL_X)

    self._itemOwnerDesc:setVisible(false)
    self._itemOwnerCount:setVisible(false)
	
	self._itemDesc:setString(itemParams.cfg.des)
	local desRender = self._itemDesc:getVirtualRenderer()
	desRender:setWidth(272)
	local scrollViewSize = self._scrollView:getContentSize()
	local desSize = desRender:getContentSize()
	if desSize.height < scrollViewSize.height then
		desSize.height = scrollViewSize.height
		self._scrollView:setTouchEnabled(false)
	else
		self._scrollView:setTouchEnabled(true)
	end
	self._itemDesc:setContentSize(desSize)
	self._scrollView:getInnerContainer():setContentSize(desSize)
	self._scrollView:jumpToTop()

	self._itemId = itemId

	local itemOwnerNum = UserDataHelper.getNumByTypeAndValue(itemType, itemId)
	self:setOwnerCount(itemOwnerNum)

end

function PopupSkinInfo:setOwnerCount(count)
	self._itemOwnerCount:setString("" .. count)
end

function PopupSkinInfo:_onInit()
end

function PopupSkinInfo:onEnter()
end

function PopupSkinInfo:onExit()
end

--
function PopupSkinInfo:onBtnOk()
	local isBreak = nil
	if self._callback then
		isBreak = self._callback(self._itemId)
	end
	if not isBreak then
		self:close()
	end
end

function PopupSkinInfo:onBtnCancel()
	self:close()
end


return PopupSkinInfo
