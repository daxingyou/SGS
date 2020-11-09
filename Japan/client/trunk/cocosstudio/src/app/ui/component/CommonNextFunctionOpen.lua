-- Author: nieming
-- Date:2018-01-11 18:31:44
-- Describle：

local CommonNextFunctionOpen = class("CommonNextFunctionOpen")

local EXPORTED_METHODS = {
	"updateUI"
}

function CommonNextFunctionOpen:ctor()
	self._target = nil
end


-- i18n change text fnt
function CommonNextFunctionOpen:onLangHandle()
	local UIHelper = require("yoka.utils.UIHelper")
	local TypeConst = require("app.i18n.utils.TypeConst")
	self._functionImageName = UIHelper.swap(self._functionImageName,{text="",fontName=Path.getImgFont("newopen"),fontSize=23,offsetY=-6,typeConst="BMFlabel",h_align=cc.TEXT_ALIGNMENT_CENTER})
end	

function CommonNextFunctionOpen:_init()

	self._btnFunction = ccui.Helper:seekNodeByName(self._target, "BtnFunction")
	self._btnBg = ccui.Helper:seekNodeByName(self._target, "BtnBg")
	self._functionImageName = ccui.Helper:seekNodeByName(self._target, "FunctionImageName")

	self._functionImageName:ignoreContentAdaptWithSize(true)
	self._btnFunction:addClickEventListenerEx(handler(self, self._onBtnFunction))
	self._btnBg:addClickEventListenerEx(handler(self, self._onBtnFunction))

	if not Lang.checkLang(Lang.CN) then self:onLangHandle() end

	self:updateUI()
end

function CommonNextFunctionOpen:bind(target)
	self._target = target
	self:_init()
	cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonNextFunctionOpen:unbind(target)
	cc.unsetmethods(target, EXPORTED_METHODS)
end


function CommonNextFunctionOpen:_onBtnFunction()
	-- body
	if self._nextFunctionInfo then
		local popupNextFunction = require("app.ui.PopupNextFunction").new(self._nextFunctionInfo)
		popupNextFunction:openWithAction()
	end
end


function CommonNextFunctionOpen:updateUI()
	local isFunctionOpen = require("app.utils.logic.FunctionCheck").funcIsShow(FunctionConst.FUNC_NEXT_FUNCTION_SHOW)
	if not isFunctionOpen then
		self._target:setVisible(false)
		return
	end

	self._nextFunctionInfo = G_UserData:getNextFunctionOpen():getNextFunctionOpenInfo()
	if self._nextFunctionInfo then
		self._target:setVisible(true)
		self._btnFunction:loadTextureNormal(Path.getCommonIcon("main",self._nextFunctionInfo.icon))
		self._btnFunction:ignoreContentAdaptWithSize(true)
		-- i18n change text fnt
		if not Lang.checkLang(Lang.CN) then
			-- local
			local name = self._nextFunctionInfo.name
			local level = self._nextFunctionInfo.level
			local text = Lang.getImgText("text_next_open",{name=name,level=level}) 
			self._functionImageName:setString(text)
		else
			self._functionImageName:loadTexture(Path.getNextFunctionOpen(self._nextFunctionInfo.nameImage))
		end
		-- self._functionName:setString(self._nextFunctionInfo.name)
		-- self._functionOpenLevel:setString(Lang.get("common_text_open_function", {level = self._nextFunctionInfo.level}))
	else
		self._target:setVisible(false)
	end
end

return CommonNextFunctionOpen
