
local PopupBase = require("app.ui.PopupBase")
local PopupBuySceneConfirm = class("PopupBuySceneConfirm", PopupBase)
local UIHelper  = require("yoka.utils.UIHelper")

function PopupBuySceneConfirm:ctor(sceneId, callback)
	self._sceneId = sceneId
	self._callback = callback

	local resource = {
		file = Path.getCSB("PopupBuySceneConfirm", "main"),
		binding = {
			_buttonCancel = {
				events = {{event = "touch", method = "_onClickButtonCancel"}}
			},
			_buttonBuy = {
				events = {{event = "touch", method = "_onClickButtonBuy"}}
			},
		}
	}
	
	PopupBuySceneConfirm.super.ctor(self, resource)
end

function PopupBuySceneConfirm:onCreate()
	-- i18n change lable
	self._selectIndex = 1
	self._popupBg:setTitle(Lang.get("shop_pop_title"))
	self._popupBg:hideBtnBg()
	self._checkBox1:addEventListener(handler(self, self._onCheckBoxClicked1))
	self._checkBox2:addEventListener(handler(self, self._onCheckBoxClicked2))
	self._checkBox1:setSwallowTouches(false)
	self._checkBox2:setSwallowTouches(false)
	self._buttonCancel:setString(Lang.get("shop_btn_cancel"))
	self._buttonBuy:setString(Lang.get("common_btn_sure"))
	self._buttonCancel:getDesc():setFontName(Path.getFontW8())
	self._buttonBuy:getDesc():setFontName(Path.getFontW8())
end

function PopupBuySceneConfirm:onEnter()
	self:_updateView()
	self:_updateCheckBox()
end

function PopupBuySceneConfirm:onExit()
	
end

function PopupBuySceneConfirm:_updateView()
	local sceneId = self._sceneId
	local mainScene = require("app.config.main_scene")
	local cfg = mainScene.get(sceneId)

	local BattleScene = require("app.config.battle_scene")
	local sceneData = BattleScene.get(cfg.scene_day)
    self._image:loadTexture(Path.getMainSceneIcon(sceneData.icon))
	self._textName:setString(cfg.name)
	self._textName:setColor(Colors.getColor(cfg.color))
	self._textDes:setString(Lang.get("buy_scene_desc"))

	for i = 1, 2 do
		local costType = "type"
		local costValue = "value"
		local costSize = "size"
		local panel = "Panel_27"
		if i == 2 then
			costType = "type_1"
			costValue = "value_1"
			costSize = "size_1"
			panel = "Panel_27_0"
		end
		local panelNode = UIHelper.seekNodeByName(self, panel)

		if cfg[costType] ~= 0 then
			panelNode:setVisible(true)
			self["_nodeCost"..i]:setTextCountSize(20)
			self["_nodeCost"..i]:setResNameFontSize(20)
			self["_nodeCost"..i]:updateUI(cfg[costType], cfg[costValue], cfg[costSize])
			self["_nodeCost"..i]:showResName(true, Lang.get("shop_avatar_cost_title"))
		else
			panelNode:setVisible(false)
		end
	end
end

function PopupBuySceneConfirm:_onClickButtonCancel()
	self:close()
end

function PopupBuySceneConfirm:_onClickButtonBuy()
	if self._callback then
		self._callback(self._selectIndex)
		self:close()
	end
end

function PopupBuySceneConfirm:_onCheckBoxClicked1()
	self._selectIndex = 1
	self:_updateCheckBox()
end

function PopupBuySceneConfirm:_onCheckBoxClicked2()
	self._selectIndex = 2
	self:_updateCheckBox()
end

function PopupBuySceneConfirm:_updateCheckBox()
	self._checkBox1:setSelected(self._selectIndex == 1)
	self._checkBox2:setSelected(self._selectIndex == 2)
end

return PopupBuySceneConfirm