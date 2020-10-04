local CommonMainMenu = class("CommonMainMenu")
local UIHelper = require("yoka.utils.UIHelper")

local EXPORTED_METHODS = {
    "addClickEventListenerEx",
    "setString",
    "showRedPoint",
    "setEnabled",
	"setButtonTag",
    "setWidth",
	"getButton",
	"updateUI",
	"flipButton",
	"setIconAndString",
	"loadCustomIcon",
    "openCountDown",
    "stopCountDown",
    "addCustomLabel",
    "removeCustomLabel",
    "moveLetterToRight",
    "playBtnMoving",
	"stopBtnMoving",
    "playFuncGfx",
    "stopFuncGfx",
	"addCountText",
	"setCountTextVisible",
    "getFuncId",
    "setTouchEnabled",
    "showImageTip"
}

function CommonMainMenu:ctor()
	self._target = nil
	self._button = nil
	self._desc = nil
    self._redPoint = nil
end

function CommonMainMenu:_init()
	self._button = ccui.Helper:seekNodeByName(self._target, "Button")
    self._nodeEffectA = ccui.Helper:seekNodeByName(self._target,"Node_a")
    self._nodeEffectB = ccui.Helper:seekNodeByName(self._target,"Node_b")
	self._desc = ccui.Helper:seekNodeByName(self._target, "Text")
	self._redPoint = ccui.Helper:seekNodeByName(self._target, "RedPoint")
	self._textImage = ccui.Helper:seekNodeByName(self._target, "TextImage")
	self._textImage:setVisible(false)
	self:setEnabled(true)
    -- i18n change lable
    self:_swapImageByI18n()
end

function CommonMainMenu:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonMainMenu:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonMainMenu:playBtnMoving()
    local funcInfo = require("app.config.function_level").get(self._funcId)
    assert(funcInfo, "Invalid function_level can not find funcId "..self._funcId)
    if funcInfo.effect_s ~= "" then
        self._button:stopAllActions()
        self._button:setPosition(cc.p(0, 0))
        self._button:setScale(1)
		self:stopBtnMoving()
        self._buttonMoving = G_EffectGfxMgr:applySingleGfx(self._button, funcInfo.effect_s)
    end
end

function CommonMainMenu:stopBtnMoving()
	if self._buttonMoving then
		self._buttonMoving:stop()
		self._buttonMoving = nil
	end
end

function CommonMainMenu:getFuncId( ... )
    -- body
    return self._funcId
end
--
function CommonMainMenu:updateUI(functionId, customIcon)
	local funcInfo = require("app.config.function_level").get(functionId)
	assert(funcInfo, "Invalid function_level can not find funcId "..functionId)
	self._desc:setString(funcInfo.name)
    local iconPath
    if not customIcon then
        iconPath = Path.getCommonIcon("main",funcInfo.icon)
    else
        iconPath = customIcon
    end
    -- assert(functionId ~= FunctionConst.FUNC_GUILD_SERVER_ANSWER, "sxxpppp " .. functionId .. " " .. iconPath)

	self._button:loadTextureNormal(iconPath)
	self._button:ignoreContentAdaptWithSize(true)
    --按钮名称，引导用处
    self._button:setName("commonMain"..functionId)
    self._button:setTag(functionId)

	if funcInfo.icon_txt and funcInfo.icon_txt ~= "" then
		local iconTextPath = Path.getTextMain(funcInfo.icon_txt)

        if not Lang.checkLang(Lang.CN) then
            local UIHelper  = require("yoka.utils.UIHelper")
            local FunctionLevel = require( "app.i18n.".. Lang.lang  .. ".function_level_1" )
            local langInfo = FunctionLevel.get(functionId)
            assert(langInfo, "Invalid function_level_1 can not find funcId "..functionId)
            local posArr = string.split(langInfo.place,",")
            logWarn("-------------xx  functionId "..functionId)
            UIHelper.setLabelStyle( self._textImage,{
                style = "icon_txt_"..(langInfo.script == "" and 1 or langInfo.script),
                text = langInfo.name,
            })
            if posArr and #posArr == 2 then
                --logWarn(tostring(posArr[1]).."  jxxxxxx "..tostring(tonumber(posArr[2])))
                self._textImage:setPosition(tonumber(posArr[1]), tonumber(posArr[2]))
              
            end
            if langInfo.alignment ~= "" then
                self._textImage:setTextHorizontalAlignment( tonumber(langInfo.alignment) )
            end
             if langInfo.space ~= "" then
                self._textImage:getVirtualRenderer():setLineSpacing(tonumber(langInfo.space) )
            end
            
            
        else
            self._textImage:loadTexture(iconTextPath)
		    self._textImage:ignoreContentAdaptWithSize(true)
	    end

		self._textImage:setVisible(true)
		self._desc:setVisible(false)
	else
		self._textImage:setVisible(false)
		self._desc:setVisible(true)
	end

    self._funcId = functionId
	self._redPoint:setVisible(false)

    self:playFuncGfx()
end

function CommonMainMenu:stopFuncGfx( ... )
    -- body
     self._nodeEffectA:removeAllChildren()
     self._nodeEffectB:removeAllChildren()
end
--根据funcId 播放特效
function CommonMainMenu:playFuncGfx()
    local funcInfo = require("app.config.function_level").get(self._funcId)
	assert(funcInfo, "Invalid function_level can not find funcId "..self._funcId)

    local function procNodeOffset(funcInfo)
        if funcInfo.xy_1 ~= "" then
            local vector = string.split(funcInfo.xy_1, "|")
            if #vector == 2 then
                local pos = cc.p( tonumber(vector[1]), tonumber(vector[2]) )
                self._nodeEffectA:setPosition(pos)
            end
        end
        if funcInfo.xy_2 ~= "" then
            local vector = string.split(funcInfo.xy_2, "|")
            if #vector == 2 then
                local pos =  cc.p( tonumber(vector[1]), tonumber(vector[2]) )
                self._nodeEffectB:setPosition(pos)
            end
        end
    end

    if funcInfo.effect_a ~= "" then
        self._nodeEffectA:removeAllChildren()
        G_EffectGfxMgr:createPlayGfx(self._nodeEffectA,funcInfo.effect_a)
    end

    if funcInfo.effect_b ~= "" then
        self._nodeEffectB:removeAllChildren()
        G_EffectGfxMgr:createPlayGfx(self._nodeEffectB,funcInfo.effect_b)
    end

    procNodeOffset(funcInfo)
end

function CommonMainMenu:setIconAndString(icon, string)
	self._desc:setString(string)
	local iconPath = Path.getCommonIcon("main", icon)
	self._button:loadTextureNormal(iconPath)
	self._button:ignoreContentAdaptWithSize(true)
	self._redPoint:setVisible(false)
end
-- 替换自定义图标
function CommonMainMenu:loadCustomIcon(iconPath)
	self._button:loadTextureNormal(iconPath)
	self._button:ignoreContentAdaptWithSize(true)
end

--
function CommonMainMenu:addClickEventListenerEx(callback)
	self._button:addClickEventListenerEx(callback, true, nil, 0)
end

--
function CommonMainMenu:setString(s)
	self._desc:setString(s)
end
--
function CommonMainMenu:showRedPoint(v)
    if v then
        self:showImageTip(false, "")
    end
	self._redPoint:setVisible(v)
end

function CommonMainMenu:showImageTip(show, texture)
    if self._redPoint:isVisible() then
        show = false
    end
    if show then
        local imgTip = self._target:getChildByName("image_tip")
        if not imgTip then
            local UIHelper = require("yoka.utils.UIHelper")
            imgTip = UIHelper.createImage({texture = texture})
            imgTip:setName("image_tip")
            self._target:addChild(imgTip)
            imgTip:setPosition(30, 30)
        end
        imgTip:setVisible(true)
    else
        local imgTip = self._target:getChildByName("image_tip")
        if imgTip then
            imgTip:setVisible(false)
        end
    end
end

--
function CommonMainMenu:setEnabled(e)
	self._button:setEnabled(e)
	self._desc:setColor(e and Colors.COLOR_POPUP_SPECIAL_NOTE or Colors.COLOR_BUTTON_LITTLE_GRAY)
	self._desc:enableOutline(e and Colors.COLOR_SCENE_OUTLINE or Colors.COLOR_BUTTON_LITTLE_GRAY_OUTLINE, 2)
end

function CommonMainMenu:setWidth(width)
	local height = self._button:getContentSize().height
	self._button:setContentSize(width, height)
end

function CommonMainMenu:setButtonTag(tag)
	self._button:setTag(tag)
end

function CommonMainMenu:getButton()
	return self._button
end

function CommonMainMenu:flipButton(needFlip)
	needFlip = needFlip or false
	local scaleX = math.abs( self._button:getScaleX() )
	if needFlip then
		self._button:setScaleX(-scaleX)
	else
		self._button:setScaleX(scaleX)
	end
end

function CommonMainMenu:removeCustomLabel()
    if self._customLabel then
        self._customLabel:removeSelf()
        self._customLabel = nil
    end
end

function CommonMainMenu:addCustomLabel(str, fontSize, pos, color, outlineColor)
    if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
        pos.y = pos.y - 18
    end
    self:removeCustomLabel()
    self._customLabel = self:_createLabelHelp(str, fontSize, pos, color, outlineColor)
    self._target:addChild(self._customLabel)
    self:_scaleFontSize(self._customLabel)
    
end

function CommonMainMenu:_createLabelHelp(str, fontSize, pos, color, outlineColor)
    return UIHelper.createLabel(
        {
            text = str,
            fontSize = fontSize,
            color = color,
            outlineColor = outlineColor,
            position = pos
        }
    )
end

--开启倒计时 使用action 实现定时器
function CommonMainMenu:openCountDown(endTime, endCallback, isShowDay)
    local currTime = G_ServerTime:getTime()
    if currTime >= endTime then
        if endCallback then
            endCallback(self)
        end
        return
    end

    self:stopCountDown()
    self._countDownEndTime = endTime
    local strInitTime = G_ServerTime:getLeftSecondsString(self._countDownEndTime, "00:00:00")
    if isShowDay then --要显示天数
        strInitTime = G_ServerTime:getLeftDHMSFormatEx(self._countDownEndTime)
    end
    
    if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
        self._leftTimeLabel =
            self:_createLabelHelp(
            strInitTime,
            18,
            cc.p(0, -50),
            Colors.WHITE,
            Colors.strokeBlack
        )
    else
        self._leftTimeLabel =
            self:_createLabelHelp(
            strInitTime,
            18,
            cc.p(0, -30),
            Colors.WHITE,
            Colors.strokeBlack
        )
    end

    self._target:addChild(self._leftTimeLabel)
    --缩小字号
    self:_scaleFontSize(self._leftTimeLabel)
    local delay = cc.DelayTime:create(0.5)
    local sequence =
        cc.Sequence:create(
        delay,
        cc.CallFunc:create(
            function()
        if not self._leftTimeLabel then
            return
        end
        local currTime = G_ServerTime:getTime()
        if currTime <= self._countDownEndTime then
                    local strTime = G_ServerTime:getLeftSecondsString(self._countDownEndTime, "00:00:00")
                    if isShowDay then --要显示天数
                        strTime = G_ServerTime:getLeftDHMSFormatEx(self._countDownEndTime)
                    end
                    self._leftTimeLabel:setString(strTime)
        else
            self:stopCountDown()
            if endCallback then
                endCallback(self)
            end
        end
            end
        )
    )

    local action = cc.RepeatForever:create(sequence)
    self._leftTimeLabel:runAction(action)
end

function CommonMainMenu:stopCountDown()
    if self._leftTimeLabel then
        self._leftTimeLabel:removeSelf()
        self._leftTimeLabel = nil
    end
end

function CommonMainMenu:moveLetterToRight()
    if not Lang.checkLang(Lang.CN) then
    else
        self._textImage:setPositionX(8)
    end
   
    self._redPoint:setPositionX(49)
end


function CommonMainMenu:addCountText(count)
	if not count then
		return
	end
	if not self._countText then
		local bgImage = UIHelper.createImage({texture = Path.getCommonImage("img_redpoint02")})
		self._target:addChild(bgImage)
		local posx,  posy= self._redPoint:getPosition()
		bgImage:setPosition(cc.p(posx, posy))
		local size = bgImage:getContentSize()
		self._countTextBg = bgImage
        self._countText = self:_createLabelHelp(count, 20, cc.p(size.width/2, size.height/2), Colors.DARK_BG_ONE)
        if not Lang.checkLang(Lang.CN)  then
            self._countText:setFontSize(18)
        end
		bgImage:addChild(self._countText)
	else
		self._countText:setString(count)
	end
end

function CommonMainMenu:setCountTextVisible(trueOrFalse)
	if self._countTextBg then
		self._countTextBg:setVisible(trueOrFalse)
	end
end

-- i18n change lable
function CommonMainMenu:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._textImage =  UIHelper.swapWithLabel(self._textImage,{
			 style = "icon_txt_1",
        })
        self._textImage:setVisible(false)
	end
end

-- i18n change lable
function CommonMainMenu:_scaleFontSize(text)
    if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.ZH) or Lang.checkLang(Lang.TH) or Lang.checkLang(Lang.ENID) then
        text:setFontSize(16)
    end
end

return CommonMainMenu
