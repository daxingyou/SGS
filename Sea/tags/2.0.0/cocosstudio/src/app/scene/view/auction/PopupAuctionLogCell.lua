
-- Author: hedili
-- Date:2017-10-11 20:47:43
-- Describle：

local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupAuctionLogCell = class("PopupAuctionLogCell", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")

function PopupAuctionLogCell:ctor()

	--csb bind var name
	self._textTime = nil  --Text
	self._textItemName = nil  --Text
	self._comItemPrice = nil  --CommonResourceInfo
	self._textPayDesc = nil  --Text
	self._panelBase = nil  --Panel
	self._imageBG = nil  --ImageView

	local resource = {
		file = Path.getCSB("PopupAuctionLogCell", "auction"),

	}
	PopupAuctionLogCell.super.ctor(self, resource)
end

function PopupAuctionLogCell:onCreate()
	-- body
-- i18n pos lable
	self:_dealPosByI18n()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
end

function PopupAuctionLogCell:updateUI(index, data)
	-- body
	self._cellValue = data
	--dump(data)

	local passTimeStr = self:getDHMS(data.deal_time)
	self._textTime:setString(passTimeStr)

	local item = data.item
    local itemParams = TypeConvertHelper.convert(item.type, item.value, item.size)
    if itemParams == nil then
        return
    end

	self._textItemName:setString(itemParams.name)
    self._textItemName:setColor(itemParams.icon_color)

	if itemParams.cfg.color == 7 then    -- 金色物品加描边
		if itemParams.icon_color_outline then
			self._textItemName:enableOutline(itemParams.icon_color_outline, 2)
		end
    else
        self._textItemName:disableEffect(cc.LabelEffect.OUTLINE)
    end


	--竞拍价
	self._comItemPrice:setVisible(false)
	self._textPayDesc:setString(Lang.get("auction_log_des"..data.price_type))
	if data.price_type == 1 or data.price_type == 2 then
		local currPrice = data.price
		self._comItemPrice:setVisible(true)
    	self._comItemPrice:updateUI(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_DIAMOND, currPrice)
	end

	if not Lang.checkLang(Lang.CN) then
		self:_updateResPosByI18n()
	end

	if index % 2 == 1 then
		self:updateImageView("_imageBG", { visible = true, texture = Path.getCommonImage("img_com_board_list01a") })
	elseif index % 2 == 0 then
		self:updateImageView("_imageBG", { visible = true, texture = Path.getCommonImage("img_com_board_list01b")})
	end
end

--根据时间获取描述内容
function PopupAuctionLogCell:getDHMS(t)
    --需要根据时区计算
    local localdate = os.date('*t',t)
	local localdate2 = os.date('*t', G_ServerTime:getTime() )
	if localdate.day ~= localdate2.day then
		return  string.format(Lang.get("auction_layday_DHMS"), localdate.hour, localdate.min)
	end
	return string.format(Lang.get("auction_today_DHMS"), localdate.hour, localdate.min)
end


-- i18n pos lable
function PopupAuctionLogCell:_dealPosByI18n()
	if Lang.checkLang(Lang.TW) then
    elseif not Lang.checkLang(Lang.CN) then

        self._comItemPrice:setPositionX(
			 self._comItemPrice:getPositionX() + 14
		)

	end
	-- 英文名字右移一点
	if Lang.checkLang(Lang.EN) then
		self._textItemName:setPositionX(
			self._textItemName:getPositionX() + 18
	   )
	end
	
end

function PopupAuctionLogCell:_updateResPosByI18n()
	if  Lang.checkChannel(Lang.CHANNEL_SEA)  then
		self._comItemPrice:setPositionX(self._textPayDesc:getPositionX() +
			self._textPayDesc:getContentSize().width+3)
	end
end


return PopupAuctionLogCell
