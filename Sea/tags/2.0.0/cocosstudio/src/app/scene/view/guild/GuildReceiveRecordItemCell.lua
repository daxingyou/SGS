
local ListViewCellBase = require("app.ui.ListViewCellBase")
local GuildReceiveRecordItemCell = class("GuildReceiveRecordItemCell", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst =  require("app.const.DataConst")

function GuildReceiveRecordItemCell:ctor()
    self._resourceNode = nil
    self._textName = nil
    self._imageBest = nil
    self._resInfo = nil
	local resource = {
		file = Path.getCSB("GuildReceiveRecordItemCell", "guild"),
		binding = {
		}
	}
	GuildReceiveRecordItemCell.super.ctor(self, resource)
end

function GuildReceiveRecordItemCell:onCreate()
	local size = self._resourceNode:getContentSize()
    self:setContentSize(size.width, size.height)
    
    -- i18n pos lable
    self:_dealPosByI18n()
end


function GuildReceiveRecordItemCell:update(data)
	self._data = data
    local money = data:getGet_money()
    local userName = data:getUser_name()
    local showBestImg = data:isIs_best()
    self._textName:setString(userName)
    self._imageBest:setVisible(showBestImg)
    self._resInfo:updateUI(TypeConvertHelper.TYPE_RESOURCE,DataConst.RES_DIAMOND,money)
    self._resInfo:setTextColor(Colors.BRIGHT_BG_ONE)
    self._resInfo:setTextCountSize(24)
    self._resInfo:showResName(false)
    -- i18n pos lable
    self:_adjustPosByI18n()
end

-- i18n pos lable
function GuildReceiveRecordItemCell:_adjustPosByI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
    
        local width = self._resInfo:getWidth()

        local size = self._resourceNode:getContentSize()
        self._resInfo:setPositionX( size.width - width - 7)
        self._imageBest:setPositionX(self._resInfo:getPositionX()-self._imageBest:getContentSize().width*0.5-7)
	end
end

-- i18n pos lable
function GuildReceiveRecordItemCell:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
        self._textName:setPositionX(self._textName:getPositionX() - 4)
	end
end

return GuildReceiveRecordItemCell