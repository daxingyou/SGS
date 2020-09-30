
local CSHelper = require("yoka.utils.CSHelper")
local PopupBase = require("app.ui.PopupBase")
local PopupDailyGift = class("PopupDailyGift", PopupBase)

function PopupDailyGift:ctor(data)
	self.data = data
	local resource = {
		file = Path.getCSB("PopupCommentGuide", "common"),
		binding = {
			_buttonOk = {
				events = {{event = "touch", method = "_onClickBtnOk"}}
			},
		},
	}
	PopupDailyGift.super.ctor(self, resource,true)
end

-- Describle：
function PopupDailyGift:onCreate()
	self._buttonCancel:setVisible(false)
	self._buttonOk:setString(Lang.get("get_box_reward"))
	self._buttonOk:setPositionX(151)

	self._Text_4 = ccui.Helper:seekNodeByName(self, "Text_4")
    self._Text_4:setVisible(false)
	self._Text_4_0 = ccui.Helper:seekNodeByName(self, "Text_4_0")
	-- self._Text_4_0:setContentSize()
    self._Text_4_0:setString(Lang.getImgText("txt_daily_gift"))
	self._Text_4_0:setFontSize(20)
	self._Text_4_0:setPosition(151,105)
	self._Text_4_0:setFontName(Path.getCommonFont())
    self._Text_4_1 = ccui.Helper:seekNodeByName(self, "Text_4_1")
    self._Text_4_1:setVisible(false)

	self.awards = {}
	local spList = {}
	for i=1,3 do
        local nameType = "type_"..i
        local nameValue = "value_"..i
		local nameSize = "size_"..i
		local data = self.data
		if data[nameType] ~= 0 then
			local sp = CSHelper.loadResourceNode(Path.getCSB("CommonIconTemplate", "common"))
			sp:initUI(data[nameType], data[nameValue], data[nameSize])
			sp:setTouchEnabled(true)
			self._resourceNode:addChild(sp)
			table.insert(self.awards,{type = data[nameType],value = data[nameValue],size = data[nameSize]})
			table.insert(spList,sp)
        end
	end
	for i,v in ipairs(spList) do
		v:setPosition(151+110*(i-(#spList+1)/2),20)
	end

end

-- Describle：
function PopupDailyGift:onEnter()
    self._listenerGetDailyGiftAward = G_NetworkManager:add(MessageIDConst.ID_S2C_GetDailyGiftAward, handler(self, self._getDailyGiftAward))
end

-- Describle：
function PopupDailyGift:onExit()
    if self._listenerGetDailyGiftAward then
        self._listenerGetDailyGiftAward:remove()
        self._listenerGetDailyGiftAward = nil
    end
end

function PopupDailyGift:_onClickBtnOk()
    self:_c2sGetDailyGiftAward()
end

function PopupDailyGift:_c2sGetDailyGiftAward()
	G_NetworkManager:send(MessageIDConst.ID_C2S_GetDailyGiftAward, {
		daily_gift_id = self.data.id
	})
end

function PopupDailyGift:_getDailyGiftAward(id, message)
    if message.ret ~= 1 then
        return
	end
	local popupGetRewards = require("app.ui.PopupGetRewards").new()
	popupGetRewards:showRewards(self.awards)
	self:close()
end

return PopupDailyGift