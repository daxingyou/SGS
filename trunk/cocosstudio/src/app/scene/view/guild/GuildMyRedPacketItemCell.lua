
local ListViewCellBase = require("app.ui.ListViewCellBase")
local GuildMyRedPacketItemCell = class("GuildMyRedPacketItemCell", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst =  require("app.const.DataConst")
local GuildConst =  require("app.const.GuildConst")

function GuildMyRedPacketItemCell:ctor()
    self._textRedPacketName = nil
    self._resInfo = nil
	local resource = {
		file = Path.getCSB("GuildMyRedPacketItemCell", "guild"),
		binding = {
			_imageRedPacket = {
				events = {{event = "touch", method = "_onButton"}}
			},
		}
	}
	GuildMyRedPacketItemCell.super.ctor(self, resource)
end

function GuildMyRedPacketItemCell:onCreate()
    -- i18n pos lable
    self:_dealPosByI18n()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

    self._imageRedPacket:setSwallowTouches(false)
end

function GuildMyRedPacketItemCell:update(data)
    local config = data:getConfig()
    local money = data:getTotal_money() *  data:getMultiple()
    local state = data:getRed_bag_state()

    self._textRedPacketName:setString(config.name)
   
    self._resInfo:updateUI(TypeConvertHelper.TYPE_RESOURCE,DataConst.RES_DIAMOND,money)
    self._resInfo:setTextColor(Colors.BRIGHT_BG_TWO)
    self._resInfo:showResName(false)

    if state == GuildConst.GUILD_RED_PACKET_NO_SEND then
       -- self._imageBg:loadTexture(Path.getCommonImage("img_com_board04b"))
        self:updateImageView("_imageBg", { visible = true, texture = Path.getCommonImage("img_com_board04b") })
        self._textStageName:setString(Lang.get("guild_red_packet_btn_send"))
       -- self._textStageName:setTextColor(Colors.OBVIOUS_YELLOW)
        self._imageRedPacket:loadTexture(Path.getGuildRes("img_lit_hongbao_03"))
    elseif state == GuildConst.GUILD_RED_PACKET_NO_RECEIVE then
       -- self._imageBg:loadTexture(Path.getCommonImage("img_com_board04"))
        self:updateImageView("_imageBg", { visible = true, texture = Path.getCommonImage("img_com_board04") })
        self._textStageName:setString(Lang.get("guild_red_packet_btn_open"))
       -- self._textStageName:setTextColor(Colors.BUTTON_WHITE)
        local bgRes=config.show==1 and "img_lit_hongbao_03" or "img_lit_hongbao_03_2"
        self._imageRedPacket:loadTexture(Path.getGuildRes(bgRes))
    else
        --self._imageBg:loadTexture(Path.getCommonImage("img_com_board04"))
        self:updateImageView("_imageBg", { visible = true, texture = Path.getCommonImage("img_com_board04") })
        self._textStageName:setString(Lang.get("guild_red_packet_btn_see"))
       -- self._textStageName:setTextColor(Colors.BUTTON_WHITE)
        local bgRes=config.show==1 and "img_lit_hongbao_03" or "img_lit_hongbao_04_2"
        self._imageRedPacket:loadTexture(Path.getGuildRes(bgRes))
    end
    local color = config.show == 1 and Colors.OBVIOUS_YELLOW or Colors.CLASS_WHITE
    self._textStageName:setColor(color)
   -- self._resourceNode:setContentSize(cc.size(294,108))
end

function GuildMyRedPacketItemCell:_onButton(sender)
    local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
	local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
	if offsetX < 20 and offsetY < 20  then
		self:dispatchCustomCallback()
	end
end



-- i18n pos lable
function GuildMyRedPacketItemCell:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        local text2 = UIHelper.seekNodeByName(self._resourceNode,"Text_2")
        text2:setAnchorPoint(cc.p(0,0.5))
        text2:setPositionX(text2:getPositionX()-20-18)
        if Lang.checkUI("ui4") then
            text2:setPositionX(self._textRedPacketName:getPositionX())
        else
            self._textRedPacketName:setPositionX(
                self._textRedPacketName:getPositionX()-18
            )
        end
		self._resInfo:setPositionX(text2:getPositionX() + text2:getContentSize().width+5)

        text2:setFontSize(
            text2:getFontSize()-2
        )

        self._textRedPacketName:setFontSize(
            self._textRedPacketName:getFontSize()-2
        )

        local text = UIHelper.seekNodeByName(self._resInfo,"Text")
        text:setFontSize(
            text:getFontSize()-2
        )

    end
    if Lang.checkUI("ui4") then
        self._textRedPacketName:setFontSize(18)
        self._textRedPacketName:getVirtualRenderer():setMaxLineWidth(170)
    end
end


return GuildMyRedPacketItemCell