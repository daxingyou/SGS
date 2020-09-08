-- 武将突破 觉醒 神兽升星成功通用天赋描述
-- Author: Liangxu
-- i18n ja add lua class
local CommonTalentTitle = class("CommonTalentTitle")
local UIHelper = require("yoka.utils.UIHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

local EXPORTED_METHODS = {
    "setTitle",
    "setTitleColor",
    "setTitleOutLine",
    "setFontSize",
    "setFontName",
    "setFontImageBgSize",
    "setTitleAndAdjustBgSize",
    "setImageBaseSize",
    "setName",
 
}

 
function CommonTalentTitle:ctor()
	self._target = nil
end

function CommonTalentTitle:_init()
	self._textTitle = ccui.Helper:seekNodeByName(self._target, "Text_talent")
    self._imageBase = ccui.Helper:seekNodeByName(self._target, "Image_11")
end

function CommonTalentTitle:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonTalentTitle:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonTalentTitle:setTitleAndAdjustBgSize(title)
	self._textTitle:setString(title)
    local size = self._textTitle:getContentSize()
    local imageBaseSize = self._imageBase:getContentSize()
    self._imageBase:setContentSize(cc.size(size.width + 110, imageBaseSize.height))
end

function CommonTalentTitle:setTitle(title)
	self._textTitle:ignoreContentAdaptWithSize(true)
    self._textTitle:setTextAreaSize(cc.size(377, 0)) 
   -- self._textTitle:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER ) 不用居中显示

	self._textTitle:setString(title)
end

function CommonTalentTitle:setTitleColor(color)
	self._textTitle:setColor(color)
end

function CommonTalentTitle:setTitleOutLine(color)
	self._textTitle:enableOutline(color, 2)
end

function CommonTalentTitle:setFontSize(size)
	self._textTitle:setFontSize(size)
end

function CommonTalentTitle:setFontName(fontName)
	self._textTitle:setFontName(fontName)
end

function CommonTalentTitle:setFontImageBgSize(size)
    self._imageBase:setContentSize(size)
end

function CommonTalentTitle:setImageBaseSize(size)
    self._imageBase:setContentSize(size)
end

 

return CommonTalentTitle
