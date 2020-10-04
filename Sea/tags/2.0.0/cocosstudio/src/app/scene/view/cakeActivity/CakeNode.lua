--
-- Author: Liangxu
-- Date: 2019-5-10
-- 蛋糕形象

local CakeNode = class("CakeNode")

function CakeNode:ctor(target)
	self._target = target
	self._imageShow = ccui.Helper:seekNodeByName(self._target, "ImageShow")
	self._nodeEffect = ccui.Helper:seekNodeByName(self._target, "NodeEffect")
end

function CakeNode:updateUI(info)
	local resName = info.cake_pic
	local level = info.lv
	local effectName = "effect_dangao_dangao"..level.."xx"
	self._imageShow:loadTexture(Path.getAnniversaryImg(resName))
	self._nodeEffect:removeAllChildren()
	G_EffectGfxMgr:createPlayGfx(self._nodeEffect, effectName)
end

return CakeNode