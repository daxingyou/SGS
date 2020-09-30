
local ListViewCellBase = require("app.ui.ListViewCellBase")
local MainUIHelper = require("app.scene.view.main.MainUIHelper")
local PopupBuySceneConfirm = require("app.scene.view.main.PopupBuySceneConfirm")
local PopupBuySceneOne = require("app.scene.view.main.PopupBuySceneOne")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserCheck = require("app.utils.logic.UserCheck")
local SwitchSceneNode = class("SwitchSceneNode", ListViewCellBase)

function SwitchSceneNode:ctor()
	local resource = {
		file = Path.getCSB("SwitchSceneNode", "main"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onPanelTouch"}}
			},
			_btnBuy = {
                events = {{event = "touch", method = "_onClickBuy"}}
			}
		}
	}

	SwitchSceneNode.super.ctor(self, resource)
end

function SwitchSceneNode:onCreate()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
	self._panelTouch:setSwallowTouches(false)
	self._btnBuy:setString(Lang.get("lang_month_card_buy"))
end

function SwitchSceneNode:onEnter()

end

function SwitchSceneNode:onExit()
	
end

function SwitchSceneNode:updateIcon(data,selectId,onClick,dayNight)
    self._data = data
	self._onClick = onClick
	local cfg = data.config
	self:switchIcon(dayNight)
    self._nameLabel:setString(cfg.name)
	self:setSelected(selectId == cfg.id)
	
	self._imageDark:setVisible(false)
	self._descLabel:setVisible(false)
	if not data.isHas then
		self._imageDark:setVisible(true)
		self._descLabel:setVisible(true)
		self._descLabel:setString(cfg.description)
	end
end

function SwitchSceneNode:switchIcon(dayNight)
	local cfg = self._data.config
	local showSceneId = MainUIHelper.getShowSceneByMainSceneId(cfg.id,dayNight)
	local BattleScene = require("app.config.battle_scene")
	local sceneData = BattleScene.get(showSceneId)
    self._imageIcon:loadTexture(Path.getMainSceneIcon(sceneData.icon))
end

function SwitchSceneNode:_onPanelTouch(sender, state)
	local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
	local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
	if offsetX < 20 and offsetY < 20  then
		if self._onClick then
			self._onClick(self._data)
		end
	end
end

function SwitchSceneNode:setSelected(selected)
	self._imageSelected:setVisible(selected)
	self._btnBuy:setVisible(false)
	if selected then
		if not self._data.isHas then
			if self._data.config.type ~= 0 then
				self._btnBuy:setVisible(true)
			end
		end
	end
end

function SwitchSceneNode:_onClickBuy()
	local cfg = self._data.config

	local callBackFunction = function(selectIndex)
		local costType = "type"
		local costValue = "value"
		local costSize = "size"
		local buyType = 0
		if selectIndex == 2 then
			costType = "type_1"
			costValue = "value_1"
			costSize = "size_1"
			buyType = 1
		end
		if UserCheck.enoughValue(cfg[costType], cfg[costValue], cfg[costSize], true) == false then
			return
		end
		G_UserData:getMainScene():c2sBuyMainScene(cfg.id,buyType)
	end

	if cfg.type_1 == 0 then
		local popupBuySceneOne = PopupBuySceneOne.new(cfg.id,callBackFunction)
		popupBuySceneOne:openWithAction()
	else
		local popupBuySceneConfirm = PopupBuySceneConfirm.new(cfg.id,callBackFunction)
		popupBuySceneConfirm:openWithAction()
	end
end

return SwitchSceneNode