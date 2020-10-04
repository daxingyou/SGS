
local PopupBase = require("app.ui.PopupBase")
local PopupCommentGuideEx = class("PopupCommentGuideEx", PopupBase)

function PopupCommentGuideEx:ctor()
	local resource = {
		file = Path.getCSB("PopupCommentGuide", "common"),
		binding = {
            _buttonCancel = {
                events = {{event = "touch", method = "_onClickBtnCancel"}}
            },
			_buttonOk = {
				events = {{event = "touch", method = "_onClickBtnOk"}}
			},
		},
	}
	PopupCommentGuideEx.super.ctor(self, resource,false)
end

-- Describle：
function PopupCommentGuideEx:onCreate()

    self._buttonCancel:setString(Lang.get("comment_guide_button_cancel"))
	self._buttonOk:setString(Lang.get("comment_guide_button_ok"))

	local posY = 70
	local height = 33
	if Lang.checkLang(Lang.TW) then
		posY = 120
		height = 5
	elseif Lang.checkLang(Lang.EN) then
		posY = 90
	end
    local richtext = ccui.RichText:createWithContent(
        Lang.getImgText("popup_comment_content")
    )
    richtext:setAnchorPoint(cc.p(0,1))
    richtext:setPosition(-34,posY)
	richtext:ignoreContentAdaptWithSize(false)
	richtext:setVerticalSpace(height)
	richtext:setContentSize(cc.size(420	,0))
	richtext:formatText()
	self._resourceNode:addChild(richtext)
	self._Text_4 = ccui.Helper:seekNodeByName(self, "Text_4")
    self._Text_4:setVisible(false)
    self._Text_4_0 = ccui.Helper:seekNodeByName(self, "Text_4_0")
    self._Text_4_0:setVisible(false)
    self._Text_4_1 = ccui.Helper:seekNodeByName(self, "Text_4_1")
    self._Text_4_1:setVisible(false)
    -- self._Text_4_1:setString(Lang.getImgText("popup_comment_once"))
    -- self._Text_4_1:setColor(cc.c3b(224,75,10))
    -- self._Text_4_1:setFontSize(14)
    -- self._Text_4_1:setPosition(34,-123)

	self:showAwardItem()

end

-- Describle：
function PopupCommentGuideEx:onEnter()
	self:_c2sShopCommentAction(1)

end

-- Describle：
function PopupCommentGuideEx:onExit()

end


function PopupCommentGuideEx:_onClickBtnCancel()
	self:close()
end

function PopupCommentGuideEx:_onClickBtnOk()
	local urlJson = G_ConfigManager:getStoreCommentUrl()
	local urlList = json.decode(urlJson)
	assert(urlList, "storeCommentUrl not configure")
	local nativeType = G_NativeAgent:getNativeType()
	local url = urlList[nativeType]
	assert(url, "storeCommentUrl not configure for "..nativeType)
	G_NativeAgent:openURL(url)
    self:_c2sShopCommentAction(2)
	self:close()
end

-- 1 已弹出界面 2 领奖
function PopupCommentGuideEx:_c2sShopCommentAction(action)
	G_NetworkManager:send(MessageIDConst.ID_C2S_ShopCommentAction, {
		store_comment_action = action
	})
end

function PopupCommentGuideEx:showAwardItem()
	if Lang.checkLang(Lang.TW) then
		local nameType = "type"
		local nameValue = "value"
		local nameSize = "size"
		local comment = require("app.config.comment")
		local data = comment.indexOf(1)
		if data[nameType] ~= 0 then
			local CSHelper = require("yoka.utils.CSHelper")
			local sp = CSHelper.loadResourceNode(Path.getCSB("CommonIconTemplate", "common"))
			sp:initUI(data[nameType], data[nameValue], data[nameSize])
			sp:setTouchEnabled(true)
			self._resourceNode:addChild(sp)
			sp:setPosition(160,10)
		end
	end
end

return PopupCommentGuideEx