-- i18n ja lua 养成系统侧边栏按钮
local CommonButton = import(".CommonButton")
local CommonButtonSwitchLevel6 = class("CommonButtonSwitchLevel6", CommonButton)



CommonButtonSwitchLevel6.EXPORTED_METHODS = {
    "addClickEventListenerEx",
	"addTouchEventListenerEx",
    "setString",
    "showRedPoint",
    "setEnabled",
	"setButtonTag",
    "setWidth",
    "setSwallowTouches",
    "switchToHightLight",
    "switchToNormal",
    "reverseUI",
    "enableHighLightStyle",
	"addClickEventListenerExDelay",
}

function CommonButtonSwitchLevel6:ctor()
    CommonButtonSwitchLevel6.super.ctor(self)
    self._highLight = true
    self._highLightImg = {normal = "img_com_zryq2",down = nil,disable =  nil}
    self._normalImg = {normal = "img_com_zryq1",down = nil,disable =  nil}
end

function CommonButtonSwitchLevel6:_init()
    CommonButtonSwitchLevel6.super._init(self)
 --   self:switchToHightLight()
end

function CommonButtonSwitchLevel6:_switchBtnImg(highLight)
    

    if highLight then
        self:loadTexture(Path.getTextTeam(self._highLightImg.normal),
           self._highLightImg.down and  Path.getTextTeam(self._highLightImg.down) ,self._highLightImg.disable and Path.getTextTeam(self._highLightImg.disable))

           local _style = Colors.getStyle("team_btnSecelt_6") 
           self._desc:setColor(_style.color)   
           self._desc:enableOutline(_style.outlineColor, _style.outlineSize)   
    else
        self:loadTexture(Path.getTextTeam(self._normalImg.normal),
            self._normalImg.down and Path.getTextTeam(self._normalImg.down),self._normalImg.disable and Path.getTextTeam(self._normalImg.disable))

        local _style = Colors.getStyle("team_btnUnSecelt_6") 
        self._desc:setColor(_style.color)
        self._desc:disableEffect(cc.LabelEffect.OUTLINE)
        --self._desc:enableOutline(Colors.BUTTON_ONE_NOTE_OUTLINE, 2)
    end
end

-- i18n ja好像用不上这个
function CommonButtonSwitchLevel6:setEnabled(e)
    self._button:setEnabled(e)
    if self._highLight then
        -- local _style = Colors.getStyle("team_btnSecelt_6", "TextStyle") 
        -- self._desc:setColor(_style.color)   
        -- self._desc:enableOutline(_style.outlineColor, _style.outlineSize)   
    else
      --  self._desc:setColor(e and Colors.BUTTON_ONE_NORMAL or Colors.BUTTON_ONE_DISABLE)
    --   local _style = Colors.getStyle("team_btnUnSecelt_6", "TextStyle") 
    --   self._desc:setColor(_style.color)
        --self._desc:enableOutline(e and Colors.BUTTON_ONE_NOTE_OUTLINE or Colors.BUTTON_ONE_DISABLE_OUTLINE, 2)
    end
end

function CommonButtonSwitchLevel6:enableHighLightStyle(hightLight)
   self._highLight = hightLight
   self:_switchBtnImg(self._highLight)

   local enable = self._button:isEnabled()
   self:setEnabled(enable)
   self._button:setZoomScale(0)     --self._button:setPressedActionEnabled(false)
end

function CommonButtonSwitchLevel6:reverseUI()
    self:enableHighLightStyle(not self._highLight)
end

function CommonButtonSwitchLevel6:switchToHightLight()
    self:enableHighLightStyle(true)
end

function CommonButtonSwitchLevel6:switchToNormal()
    self:enableHighLightStyle(false)
end


return CommonButtonSwitchLevel6
