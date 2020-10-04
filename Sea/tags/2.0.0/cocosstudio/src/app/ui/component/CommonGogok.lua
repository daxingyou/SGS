--
-- Author: Liangxu
-- Date: 2018-8-9
-- 通用勾玉

local CommonGogok = class("CommonGogok")

local EXPORTED_METHODS = {
    "setCount",
}

function CommonGogok:ctor()
	self._target = nil
end

function CommonGogok:_init()
	self._image1 = ccui.Helper:seekNodeByName(self._target, "Image1")
	self._image2 = ccui.Helper:seekNodeByName(self._target, "Image2")
	self._image3 = ccui.Helper:seekNodeByName(self._target, "Image3")
end

function CommonGogok:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonGogok:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonGogok:setCount(count)
	for i = 1, 3 do
		if i <= count then
			self["_image"..i]:loadTexture(Path.getLimitImg("img_limit_05"))
		else
			self["_image"..i]:loadTexture(Path.getLimitImg("img_limit_05b"))
		end
	end
end

return CommonGogok