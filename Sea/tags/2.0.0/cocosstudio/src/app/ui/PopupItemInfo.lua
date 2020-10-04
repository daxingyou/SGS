--弹出界面
--物品信息弹框
--点击物品时，弹出
local PopupBase = require("app.ui.PopupBase")
local PopupItemInfo = class("PopupItemInfo", PopupBase)
local Path = require("app.utils.Path")

local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")

local ICON_NORMAL_X = 78.21 -- 正常位置
local ICON_TITLE_X = 55 -- 称号位置

local DESC_NORMAL_X = 143
local DESC_TITLE_X = 163

function PopupItemInfo:ctor(title, callback )
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
		file = Path.getCSB("PopupItemInfo", "common"),
		binding = {
			_btnOk = {
				events = {{event = "touch", method = "onBtnOk"}}
			}
		}
	}
	PopupItemInfo.super.ctor(self, resource, true)
end

--
function PopupItemInfo:onCreate()
	--i18n
	self:_createInfoByI18n()
	-- button
	self._btnOk:setString(Lang.get("common_btn_sure"))

	self._commonNodeBk:addCloseEventListener(handler(self, self.onBtnCancel))
	self._commonNodeBk:setTitle(self._title)
	self._commonNodeBk:hideCloseBtn()
end

function PopupItemInfo:updateUI(itemType, itemId)
	assert(itemId, "PopupItemInfo's itemId can't be empty!!!")
	self._itemIcon:unInitUI()
	self._itemIcon:initUI(itemType, itemId)
	self._itemIcon:setTouchEnabled(false)
	self._itemIcon:setImageTemplateVisible(true)
	local itemParams = self._itemIcon:getItemParams()
	--dump(itemParams)
	self._itemName:setString(itemParams.name)
	self._itemName:setColor(itemParams.icon_color)
	
	if itemParams.cfg.color == 7 then    -- 金色物品加描边
		self._itemName:enableOutline(itemParams.icon_color_outline, 2)
	end
    
	if itemType == TypeConvertHelper.TYPE_TITLE then
		self._itemIcon:setImageTemplateVisible(false)
		self._itemIcon:setPositionX(ICON_TITLE_X)
		self._itemName:setPositionX(DESC_TITLE_X)
		self._itemDesc:setPositionX(DESC_TITLE_X)
		self._itemOwnerDesc:setVisible(false)
		self._itemOwnerCount:setVisible(false)
	else
		self._itemIcon:setImageTemplateVisible(true)
		self._itemIcon:setPositionX(ICON_NORMAL_X)
		self._itemName:setPositionX(DESC_NORMAL_X)
		self._itemDesc:setPositionX(DESC_NORMAL_X)
		self._itemOwnerDesc:setVisible(true)
		self._itemOwnerCount:setVisible(true)
	end
	self._itemDesc:setString(itemParams.cfg.description)

	self._itemId = itemId

	local itemOwnerNum = UserDataHelper.getNumByTypeAndValue(itemType, itemId)
	self:setOwnerCount(itemOwnerNum)
		-- i18n pos 
	self:_dealPosByI18n()
	--i18n
	self:_updateInfoByI18n(itemType)
end

function PopupItemInfo:setOwnerCount(count)
	self._itemOwnerCount:setString("" .. count)
end

function PopupItemInfo:_onInit()
end

function PopupItemInfo:onEnter()
end

function PopupItemInfo:onExit()
end

--
function PopupItemInfo:onBtnOk()
	local isBreak = nil
	if self._callback then
		isBreak = self._callback(self._itemId)
	end
	if not isBreak then
		self:close()
	end
end

function PopupItemInfo:onBtnCancel()
	self:close()
end

-- 特例 处理神秘奖励
function PopupItemInfo:setSecretUI()
	self._itemIcon:loadIcon(Path.getActivityRes("secretIcon"))
	self._itemOwnerDesc:setVisible(false)
	self._itemOwnerCount:setVisible(false)
	self._itemName:setString(Lang.get("lang_activity_beta_appointment_secret"))
	self._itemDesc:setString(Lang.get("lang_activity_beta_appointment_secret_info"))
end



-- i18n pos lable
function PopupItemInfo:_dealPosByI18n()

	if not Lang.checkLang(Lang.CN) then

		if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
			local UIHelper  = require("yoka.utils.UIHelper")
			local size = self._itemDesc:getContentSize()
			self._itemDesc:setTextAreaSize(cc.size(size.width + 70, size.height))
			
			self._itemOwnerDesc:setAnchorPoint(cc.p(1,0.5))
			self._itemOwnerCount:setAnchorPoint(cc.p(1,0.5))

		-- 	self._itemOwnerDesc:setPositionX(self._itemOwnerDesc:getPositionX()+20)
		-- 	self._itemOwnerCount:setPositionX(
		-- 	self._itemOwnerDesc:getPositionX()+self._itemOwnerDesc:getContentSize().width
		-- )
			local posY = self._itemOwnerDesc:getPositionY() + 42
			
			local posCountX = self._itemOwnerCount:getPositionX() + 120
			self._itemOwnerCount:setPositionX(posCountX)

			local posDescX = self._itemOwnerCount:getPositionX() - self._itemOwnerCount:getContentSize().width
			self._itemOwnerDesc:setPositionX(posDescX)

			self._itemOwnerDesc:setPositionY(posY)
			self._itemOwnerCount:setPositionY(posY-1)


			return
		end
		local UIHelper  = require("yoka.utils.UIHelper")
		local size = self._itemDesc:getContentSize()
        self._itemDesc:setTextAreaSize(cc.size(size.width + 70, size.height))

		self._itemOwnerDesc:setPositionX(self._itemOwnerDesc:getPositionX()+20)
		self._itemOwnerCount:setPositionX(
			self._itemOwnerDesc:getPositionX()+self._itemOwnerDesc:getContentSize().width
		)
	end
	
end

--i18n
function PopupItemInfo:_createInfoByI18n()
	if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
		self._itemDesc:setVisible(false)
		local listView = ccui.ListView:create()
		listView:setScrollBarEnabled(false)
		listView:setSwallowTouches(false)
		listView:setAnchorPoint(cc.p(0, 1))
		listView:setPosition(cc.p(DESC_NORMAL_X, 100))
		listView:setDirection(ccui.ScrollViewDir.vertical)
		listView:setContentSize(cc.size(340,90))
		local UIHelper  = require("yoka.utils.UIHelper")
		local panel = UIHelper.seekNodeByName(self,"Panel_1")
		panel:addChild(listView)
		self._listView = listView
    end
end

--i18n
function PopupItemInfo:_updateInfoByI18n(itemType)
	if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
		local posX = DESC_NORMAL_X
		if itemType == TypeConvertHelper.TYPE_TITLE then
			posX = DESC_TITLE_X
		end
		self._listView:setPositionX(posX)
		self._listView:removeAllChildren()
		local UIHelper  = require("yoka.utils.UIHelper")
		local desc = UIHelper.createLabel({
			text = self._itemDesc:getString(),
			color = cc.c3b(0x71, 0x43, 0x06),
			size = 22,
			anchorPoint = cc.p(0,1)
		})

		local render = desc:getVirtualRenderer()
		render:setMaxLineWidth(340)
		local size = render:getContentSize()
		local widget = ccui.Widget:create()
		local widgetSize = cc.size(size.width, size.height)
		widget:setContentSize(widgetSize)
		desc:setPosition(0,size.height)
		widget:addChild(desc)
		self._listView:pushBackCustomItem(widget)
		self._listView:doLayout()
	end
end


return PopupItemInfo
