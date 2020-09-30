local ViewBase = require("app.ui.ViewBase")
local GiftCodeNode = class("GiftCodeNode", ViewBase)
local InputUtils = require("app.utils.InputUtils")

function GiftCodeNode:ctor()
	local resource = {
		file = Path.getCSB("GiftCodeNode", "playerDetail"),
		binding = {
			_btnOK = {
				events = {{event = "touch", method = "_onClickOK"}}
			},
		}
	}
	self:setName("GiftCodeNode")
	GiftCodeNode.super.ctor(self, resource)
end

function GiftCodeNode:onCreate()
	self._textDesc:setString(Lang.get("player_detail_gift_code_text"))
	self._textDesc:getVirtualRenderer():setWidth(326)

	self._btnOK:setString(Lang.get("player_detail_gift_code_exchange"))

	self._editBox = InputUtils.createInputView(
		{
			bgPanel = self._imageInput,
			fontSize = 18,
            fontColor = cc.c3b(0xc8 , 0xd4  , 0xf6 ),
            placeholderFontColor = cc.c3b(0xc8 , 0xd4  , 0xf6 ),
			maxLength = 18,
			placeholder = Lang.get("player_detail_gift_code_input")
		}
	)
end

function GiftCodeNode:_onClickOK()
    local code = self._editBox:getText()
    code = string.trim(code)
    if code == "" then
         G_Prompt:showTip(Lang.get("gift_code_input_placeholder"))
         return
    end
    G_UserData:getBase():c2sGetGameGiftBag(code)
end

function GiftCodeNode:onEnter()
    self._signalGiftCodeReward = G_SignalManager:add(SignalConst.EVENT_GIFT_CODE_REWARD, handler(self,self._onEventGiftCodeReward))
end

function GiftCodeNode:onExit()
	self._signalGiftCodeReward:remove()
	self._signalGiftCodeReward = nil
end

function GiftCodeNode:_onEventGiftCodeReward(event,message)
    self:_onShowRewardItems(message)
end

function GiftCodeNode:_onShowRewardItems(message)
    local awards = rawget(message, "awards")
	if awards then
		if not (#awards==1 and TypeConvertHelper.getTypeClass(awards[1].type) == nil)  then-- 只有一个通用框的时候 不弹
			local popupGetRewards = require("app.ui.PopupGetRewards").new()
			popupGetRewards:showRewards(awards)
		end
		G_Prompt:showTip(Lang.get("exchange_success"))
	end
end

return GiftCodeNode
