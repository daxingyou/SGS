
local UTF8 = require("app.utils.UTF8")
local CommonGuildFlag = class("CommonGuildFlag")

local GuildFlagConfig = require("app.config.guild_true_flag")

local EXPORTED_METHODS = {
    "updateUI",
    "setGlobalZOrder",
}

function CommonGuildFlag:ctor()
	self._target = nil
    self._textGuildNames = {}
end

function CommonGuildFlag:_init()
	self._imageFlag = ccui.Helper:seekNodeByName(self._target, "ImageFlag")
    self._textGuildName = ccui.Helper:seekNodeByName(self._target, "TextGuildName")
    self._imageFlag:ignoreContentAdaptWithSize(true)
    if not self._textGuildName then
        for i = 1,2,1 do
            self._textGuildNames[i] =  ccui.Helper:seekNodeByName(self._target, "TextGuildName"..i)
        end
    end
    --i18n
    self:_dealByI18n()
end

function CommonGuildFlag:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonGuildFlag:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonGuildFlag:updateUI(index,name)
    local configInfo = GuildFlagConfig.get(index)
    self._flagConfigInfo = configInfo

    if configInfo then
        local colorArray = string.split(configInfo.text_color, ",")
        local outlineColorArray = string.split(configInfo.outline_color, ",")
        local nameColor = cc.c3b(tonumber(colorArray[1]), tonumber(colorArray[2]), tonumber(colorArray[3]))
        local outlineColor = cc.c3b(tonumber(outlineColorArray[1]), tonumber(outlineColorArray[2]), tonumber(outlineColorArray[3]))

        if self._textGuildName then
	 		--i18n
	        if Lang.checkUI("ui4") then
	            self._textGuildName:setString(name)
	        elseif not Lang.checkLang(Lang.CN) then
	            self._textGuildName:setString(UTF8.utf8sub(name, 1, 6))  
			else
	            self._textGuildName:setString(UTF8.utf8sub(name, 1, 2))
			end
            --UI4 处理
            if  Lang.checkUI("ui4") then  
                self._textGuildName:setFontSize(32)
                self._textGuildName:disableEffect(cc.LabelEffect.OUTLINE)
            else
                self._textGuildName:setColor(nameColor)
                self._textGuildName:enableOutline(outlineColor)
            end
        else
				  --i18n
	        if Lang.checkUI("ui4") then
	            self._textGuildNames[1]:setString(name)
	        elseif Lang.checkLang(Lang.CN) then
	            for i = 1,2,1 do
	                self._textGuildNames[i]:setString(UTF8.utf8sub(name, i, i))
	                self._textGuildNames[i]:setColor(nameColor)
	                self._textGuildNames[i]:enableOutline(outlineColor)
	            end
	        else
	            for i = 1,2,1 do
	                self._textGuildNames[i]:setString(UTF8.utf8sub(name, i, i))
	                self._textGuildNames[i]:setColor(nameColor)
	                self._textGuildNames[i]:enableOutline(outlineColor)
	            end
			end
        end

        --self._imageFlag:loadTexture(Path.getGuildRes(configInfo.origin_res))
        self._imageFlag:loadTexture(self:getImagePath())
    end
end

function CommonGuildFlag:getImagePath()
    local path = ""
    
    if self._flagConfigInfo then
        path = Path.getGuildRes(self._flagConfigInfo.origin_res)
    end

    return path
end

function CommonGuildFlag:setGlobalZOrder(order)
    -- body
    self._imageFlag:setGlobalZOrder(order)
    self._textGuildName:setGlobalZOrder(order)
end
--i18n
function CommonGuildFlag:_dealByI18n()
    if Lang.checkUI("ui4") then
        if self._textGuildName then
            self._textGuildName:setTextAreaSize(cc.size(100,41))
            self._textGuildName:getVirtualRenderer():setLineSpacing(10)
		    self._textGuildName:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
        else
            self._textGuildNames[1]:setTextAreaSize(cc.size(60,24))
            self._textGuildNames[1]:getVirtualRenderer():setLineSpacing(10)
            self._textGuildNames[1]:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
            self._textGuildNames[1]:setFontSize(20)
            self._textGuildNames[1]:setPositionY(3)
            self._textGuildNames[2]:setVisible(false)
        end
    end
end

return CommonGuildFlag