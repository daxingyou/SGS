
local PopupBase = require("app.ui.PopupBase")
local PopupBuySceneOne = class("PopupBuySceneOne", PopupBase)
local UIHelper  = require("yoka.utils.UIHelper")

function PopupBuySceneOne:ctor(sceneId, callback)
	self._sceneId = sceneId
	self._callback = callback

	local resource = {
		file = Path.getCSB("PopupBuySceneOne", "main"),
		binding = {
			_btnCancel = {
				events = {{event = "touch", method = "_onClickButtonCancel"}}
			},
			_btnOk = {
				events = {{event = "touch", method = "_onClickButtonBuy"}}
			},
		}
	}
	
	PopupBuySceneOne.super.ctor(self, resource)
end

function PopupBuySceneOne:onCreate()
	-- i18n change lable
	self._popupBG:setTitle(Lang.get("shop_pop_title"))
	self._popupBG:hideBtnBg()
	self._popupBG:hideCloseBtn()
	self._btnCancel:setString(Lang.get("shop_btn_cancel"))
	self._btnOk:setString(Lang.get("common_btn_sure"))
	self._btnCancel:getDesc():setFontName(Path.getFontW8())
	self._btnOk:getDesc():setFontName(Path.getFontW8())
end

function PopupBuySceneOne:onEnter()
	self:_updateView()
end

function PopupBuySceneOne:onExit()
	
end

function PopupBuySceneOne:_updateView()
	local sceneId = self._sceneId
	local mainScene = require("app.config.main_scene")
	local cfg = mainScene.get(sceneId)

	local BattleScene = require("app.config.battle_scene")
	local sceneData = BattleScene.get(cfg.scene_day)
    self._image:loadTexture(Path.getMainSceneIcon(sceneData.icon))
	self._itemName:setString(cfg.name)
	self._itemName:setColor(Colors.getColor(cfg.color))
	self._textDes:setString(Lang.get("buy_scene_desc"))

end

function PopupBuySceneOne:_onClickButtonCancel()
	self:close()
end

function PopupBuySceneOne:_onClickButtonBuy()
	if self._callback then
		self._callback(1)
		self:close()
	end
end

return PopupBuySceneOne