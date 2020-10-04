local UIHelper = require("yoka.utils.UIHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local CommonIconBase = import(".CommonIconBase")
local CommonPosterGirlSkinIcon = class("CommonPosterGirlSkinIcon",CommonIconBase)


local EXPORTED_METHODS = {
}


function CommonPosterGirlSkinIcon:ctor()
	CommonPosterGirlSkinIcon.super.ctor(self)
	self._type = TypeConvertHelper.TYPE_POSTER_GIRL_SKIN
end

function CommonPosterGirlSkinIcon:_init()
	CommonPosterGirlSkinIcon.super._init(self)
end

function CommonPosterGirlSkinIcon:bind(target)
	CommonPosterGirlSkinIcon.super.bind(self, target)
	cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonPosterGirlSkinIcon:unbind(target)
	CommonPosterGirlSkinIcon.super.unbind(self, target)
	cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonPosterGirlSkinIcon:updateUI(value, size)
	CommonPosterGirlSkinIcon.super.updateUI(self, value, size)
end



function CommonPosterGirlSkinIcon:_onTouchCallBack(sender,state)
	-----------防止拖动的时候触发点击
	if(state == ccui.TouchEventType.ended)then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
		if moveOffsetX < 20 and moveOffsetY < 20 then
			if self._callback then
				self._callback(sender, self._itemParams)
			end
			if self._itemParams then
				local PopupSkinInfo = require("app.ui.PopupSkinInfo").new(nil,
					function()
						local VipConst = require("app.const.VipConst")
						local WayFuncDataHelper = require("app.utils.data.WayFuncDataHelper")
						WayFuncDataHelper.gotoModuleByFuncId(FunctionConst.FUNC_RECHARGE,{false})
					end
				)
                PopupSkinInfo:updateUI(self._type, self._itemParams.cfg.id)
                PopupSkinInfo:openWithAction()
            end
		end
	end
end



return CommonPosterGirlSkinIcon