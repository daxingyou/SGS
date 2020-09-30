
local ListViewCellBase = require("app.ui.ListViewCellBase")
local GuildDungeonPlaybackItemNode = class("GuildDungeonPlaybackItemNode", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst =  require("app.const.DataConst")
local UserDataHelper = require("app.utils.UserDataHelper")
function GuildDungeonPlaybackItemNode:ctor()
    self._resourceNode = nil
    self._imageBg = nil
    self._textRank = nil
    self._imageOfficial = nil
    self._textName = nil
    self._record01 = nil
    self._textTime = nil
    self._commonSeeBtn = nil
	local resource = {
		file = Path.getCSB("GuildDungeonPlaybackItemNode", "guildDungeon"),
		binding = {
            _commonSeeBtn = {
				events = {{event = "touch", method = "_onButtonSee"}}
			},
		}
	}
	GuildDungeonPlaybackItemNode.super.ctor(self, resource)
end

function GuildDungeonPlaybackItemNode:onCreate()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

    self:_dealPosByI18n()

    self._commonSeeBtn:setString(Lang.get("common_btn_playback"))
end


function GuildDungeonPlaybackItemNode:_onButtonSee()
    local record =  self._data.record
    local member =  self._data.member
	self:dispatchCustomCallback(record:getReport_id())
end

function GuildDungeonPlaybackItemNode:update(data,index)
	self._data = data
    local record =  data.record
    local member =  data.member

    local officialName, officialColor,officialInfo = UserDataHelper.getOfficialInfo(record:getPlayer_officer())

    self._imageBg:setVisible(index % 2 == 0)
    if member then
        self._textRank:setString(tostring(member:getRankPower())..".")
        self._textRank:setColor(officialColor)
        require("yoka.utils.UIHelper").updateTextOfficialOutline(self._textRank, record:getPlayer_officer())
    else
        self._textRank:setString("")
    end
    
    self._imageOfficial:loadTexture(Path.getTextHero(officialInfo.picture))
	self._imageOfficial:ignoreContentAdaptWithSize(true)
    self._textName:setString(record:getPlayer_name())
    self._textName:setColor(officialColor)
    require("yoka.utils.UIHelper").updateTextOfficialOutline(self._textName, record:getPlayer_officer())
 
    self._record01:updateView(
        record:isIs_win(),
        tostring(record:getTarget_rank()) .. "." .. record:getTarget_name(),
        Colors.getOfficialColor(record:getTarget_officer()),
        Colors.getOfficialColorOutlineEx(record:getTarget_officer())
    )

   
    self._textTime:setString(G_ServerTime:getPassTime(record:getTime()))

end




function GuildDungeonPlaybackItemNode:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
      --  local size = self._imageOfficial:getContentSize()
        --self:_textName:setPositionX(size.width+self:_imageOfficial:getPositionX())
        
        
        --self._textRank:setPositionX(self._textRank:getPositionX() - 10)
        --self._imageOfficial:setPositionX(self._imageOfficial:getPositionX() + 17)

        self._textName:setFontSize(self._textName:getFontSize()-4)
        self._textName:setPositionX(self._textName:getPositionX() + 29)

        self._textTime:setPositionX(self._textTime:getPositionX() + 35)
       
        
        self._record01:setPositionX(self._record01:getPositionX() + 90)
	end
end


return GuildDungeonPlaybackItemNode