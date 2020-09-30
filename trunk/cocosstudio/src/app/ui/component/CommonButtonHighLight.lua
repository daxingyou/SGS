local CommonButton = import(".CommonButton")
local CommonButtonHighLight = class("CommonButtonHighLight", CommonButton)

function CommonButtonHighLight:ctor()
	CommonButtonHighLight.super.ctor(self)
end

function CommonButtonHighLight:setEnabled(e)
	self._button:setEnabled(e)
	self._desc:setColor(e and Colors.BUTTON_ONE_NOTE or Colors.BUTTON_ONE_DISABLE)
	--self._desc:enableOutline(e and Colors.BUTTON_ONE_NOTE_OUTLINE or Colors.BUTTON_ONE_DISABLE_OUTLINE, 2)
end

function CommonButtonHighLight:setEnabled(e)
	self._button:setEnabled(e)
	self._desc:setColor(e and Colors.BUTTON_ONE_NOTE or Colors.BUTTON_ONE_DISABLE)
	--self._desc:enableOutline(e and Colors.BUTTON_ONE_NOTE_OUTLINE or Colors.BUTTON_ONE_DISABLE_OUTLINE, 2)
end

function CommonButtonHighLight:setTextStyle(params)
	if params.color then
		self._desc:setColor(params.color)
	end
	if params.fontName then
		self._desc:setFontName(params.fontName)
	end
	if params.fontSize then
		self._desc:setFontSize(params.fontSize)
	end
	if params.outlineColor ~= nil then
		self._desc:enableOutline(params.outlineColor, params.outlineSize or 2)
   else
		self._desc:disableEffect(cc.LabelEffect.OUTLINE)     
   end
	--self._desc:enableOutline(e and Colors.BUTTON_ONE_NOTE_OUTLINE or Colors.BUTTON_ONE_DISABLE_OUTLINE, 2)
end

return CommonButtonHighLight