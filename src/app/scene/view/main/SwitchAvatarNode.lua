
local ListViewCellBase = require("app.ui.ListViewCellBase")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local SwitchAvatarNode = class("SwitchAvatarNode", ListViewCellBase)
local colorList = {
	[2] = cc.c3b(0xd7 , 0xff  , 0xb4),
	[3] = cc.c3b(0xfa , 0xce  , 0xff),
	[4] = cc.c3b(0xb4 , 0xec  , 0xf6),
	[5] = cc.c3b(0xff , 0xe9  , 0xa7),
	[6] = cc.c3b(0xff , 0xe7  , 0xe7),
	[7] = cc.c3b(0xff , 0xf9  , 0xcd),
}


function SwitchAvatarNode:ctor()
	local resource = {
		file = Path.getCSB("SwitchAvatarNode", "main"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onPanelTouch"}}
			},
		}
	}

	SwitchAvatarNode.super.ctor(self, resource)
end

function SwitchAvatarNode:onCreate()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
	self._imageSelected:setVisible(false)
	self._panelTouch:setSwallowTouches(false)
end

function SwitchAvatarNode:onEnter()

end

function SwitchAvatarNode:onExit()
	
end

function SwitchAvatarNode:updateIcon(data,selectId,onClick)
	self._data = data
	self._onClick = onClick
	local type = TypeConvertHelper.TYPE_HERO
    -- local value, isEquipAvatar, avatarLimitLevel, arLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(data)
    -- local limitLevel = avatarLimitLevel or data:getLimit_level()
	-- local limitRedLevel = arLimitLevel or data:getLimit_rtg()
	local value = data:getBase_id()
    local limitLevel = data:getLimit_level()
    local limitRedLevel = data:getLimit_rtg()
	local itemParams = TypeConvertHelper.convert(type, value, nil, nil, limitLevel, limitRedLevel)
	local color = itemParams.color
	local bg = Path.getMain2("cardbg0" .. color)
	local bottom = Path.getMain2("cardbottom0" .. color)
	self._imageBg:loadTexture(bg)
	self._imageBottom:loadTexture(bottom)
	if itemParams.bustIcon ~= nil then
		self._imageIcon:loadTexture(itemParams.bustIcon)
	end
	self._nameLabel:setString(itemParams.name)
	self._nameLabel:setColor(colorList[color])
    if color == 7 then
        self._nameLabel:enableOutline(cc.c3b(0xff , 0x8a  , 0x00), 2)
    else
        self._nameLabel:disableEffect(cc.LabelEffect.OUTLINE)
	end
	self:setSelected(selectId == data:getStoryResSpine())
end

function SwitchAvatarNode:_onPanelTouch(sender, state)
	local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
	local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
	if offsetX < 20 and offsetY < 20  then
		if self._onClick then
			self._onClick(self._data)
		end
	end
end

function SwitchAvatarNode:setSelected(selected)
	self._imageSelected:setVisible(selected)
end

return SwitchAvatarNode