-- @Author panhoa
-- @Date 10.9.2018
-- @Role

local PopupBase = require("app.ui.PopupBase")
local PopupSuspendTimeView = class("PopupSuspendTimeView", PopupBase)
local scheduler = require("cocos.framework.scheduler")


function PopupSuspendTimeView:ctor()
    self._commonNodeBk  = nil
    self._btnBack       = nil
    self._textHint      = nil

	local resource = {
		file = Path.getCSB("PopupSuspendTimeView", "seasonSport"),
		binding = {
			_btnBack = {
				events = {{event = "touch", method = "_onBtnBack"}}
			},
		}
	}
    PopupSuspendTimeView.super.ctor(self, resource, false, false)
end

-- @Role    自定信息
-- @Param   strTitle 标题
-- @Param   strContent 内容
-- @Param   strButton  按钮名
function PopupSuspendTimeView:setCustomText(strTitle, strContent, strButton, strContentEnd, offsetY)
    self._commonNodeBk:setTitle(strTitle)
    --i18n
	local fontSize = 22
    if Lang.checkLang(Lang.TH) then
        fontSize = 24
    end
    self._nodeDesc:removeAllChildren()
    local richText = ccui.RichText:createRichTextByFormatString(strContent,
    {defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 22, other ={
        [1] = {fontSize = fontSize}--i18n
    }})
    if Lang.checkChannel(Lang.CHANNEL_SEA) then
        richText:ignoreContentAdaptWithSize(false)
        richText:setContentSize(cc.size(500	,0))
        richText:setVerticalSpace(10)
        -- richText:setWrapMode(1)
        richText:formatText()
        offsetY = 30
    end
    self._nodeDesc:addChild(richText)

    if strContentEnd ~= nil and strContentEnd ~= "" then
        local richText2 = ccui.RichText:createRichTextByFormatString(strContentEnd,
        {defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 22, other ={
            [1] = {fontSize = fontSize}--i18n
        }})
        if Lang.checkChannel(Lang.CHANNEL_SEA) then
            richText:ignoreContentAdaptWithSize(false)
            richText:setContentSize(cc.size(500	,0))
            richText:setVerticalSpace(10)
            -- richText:setWrapMode(1)
            richText:formatText()
            richText2:setAnchorPoint(0,0.5)
            richText2:setPositionX(-250)
        end
        richText2:setPositionY(richText:getPositionY() - 30)
        self._nodeDesc:addChild(richText2)    
    end
    self._nodeDesc:setPositionY(self._oriPositionY - offsetY)
    self._btnBack:setString(strButton)
end

function PopupSuspendTimeView:onCreate()
    self._commonNodeBk:addCloseEventListener(handler(self, self._onCloseBack))
    self._oriPositionY = self._nodeDesc:getPositionY()

    if Lang.checkChannel(Lang.CHANNEL_SEA) then
        self._textHint:removeFromParent()
        self._image_time:getParent():addChild(self._textHint)
        local posX,posY = self._image_time:getPosition()
        self._textHint:setPosition(posX,posY-20)
        self._image_time:setVisible(false)
    end
end

function PopupSuspendTimeView:onEnter()
    local suspendTime = G_UserData:getSeasonSport():getSuspendTime()
    if tonumber(G_ServerTime:getLeftSeconds(suspendTime)) > 0 then
        -- i18n change punc
		if not Lang.checkLang(Lang.CN) then
            self._textHint:setString(G_ServerTime:getLeftSecondsString(suspendTime, "00:00:00"))
		else
            self._textHint:setString(G_ServerTime:getLeftSecondsString(suspendTime, "00：00：00"))
		end
        self._countDownScheduler = scheduler.scheduleGlobal(handler(self, self._update), 0.5)
    end
    self._image_time:setVisible(tonumber(G_ServerTime:getLeftSeconds(suspendTime)) > 0)
    if Lang.checkChannel(Lang.CHANNEL_SEA) then
        self._textHint:setVisible(tonumber(G_ServerTime:getLeftSeconds(suspendTime)) > 0)
        self._image_time:setVisible(false)
    end
end

function PopupSuspendTimeView:onExit()
    if self._countDownScheduler then
        scheduler.unscheduleGlobal(self._countDownScheduler)
    end
	self._countDownScheduler = nil
end

function PopupSuspendTimeView:setCloseCallBack(closeCallBack)
    self._closeCallBack = closeCallBack
end

function PopupSuspendTimeView:setOkCallBack(okCallBack)
    self._okCallBack = okCallBack
end

function PopupSuspendTimeView:_onCloseBack(sender)
    if self._closeCallBack then
        self._closeCallBack()
    end
	self:close()
end

function PopupSuspendTimeView:_onBtnBack(sender)
    if self._closeCallBack then
        self._closeCallBack()
    end

    if self._okCallBack then
        self._okCallBack()
    end
	self:close()
end

-- @Role 	Update
function PopupSuspendTimeView:_update(dt)
    local suspendTime = G_UserData:getSeasonSport():getSuspendTime()
    if tonumber(G_ServerTime:getLeftSeconds(suspendTime)) > 0 then
        -- i18n change punc
		if not Lang.checkLang(Lang.CN) then
            self._textHint:setString(G_ServerTime:getLeftSecondsString(suspendTime, "00:00:00"))
		else
            self._textHint:setString(G_ServerTime:getLeftSecondsString(suspendTime, "00：00：00"))
		end
    else
        if self._closeCallBack then
            self._closeCallBack()
        end
        self:close()
    end
end


return PopupSuspendTimeView
