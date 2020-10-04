
local ListViewCellBase = require("app.ui.ListViewCellBase")
local GuildWarRecordItemCell = class("GuildWarRecordItemCell", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst =  require("app.const.DataConst")
local UserDataHelper = require("app.utils.UserDataHelper")
local GuildWarMemberData = require("app.data.GuildWarMemberData")

local CELL_SIZE     = cc.size(944,74)
function GuildWarRecordItemCell:ctor()
    self._resourceNode = nil
    self._panel = nil
  
    self._textRank = nil
    self._official = nil
    self._name = nil
  
   
    self._textContribution = nil
    self._textAttackCrystal = nil
    self._textAttackGate = nil
    self._textAttack = nil
    self._textKill = nil    
    self._textReward = nil
    self._commonItemIcon = nil
    self._imageBox = nil
	local resource = {
		file = Path.getCSB("GuildWarRecordItemCell", "guildwarbattle"),
		binding = {
           
		}
	}
	GuildWarRecordItemCell.super.ctor(self, resource)
end

function GuildWarRecordItemCell:onCreate()
    -- i18n pos lable
    self:_dealPosByI18n()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)


end


function GuildWarRecordItemCell:_onButtonSee()
    local record =  self._data.record
    local member =  self._data.member
	self:dispatchCustomCallback(record:getReport_id())
end

function GuildWarRecordItemCell:update(data,index)
	self._data = data
  

    local officialName, officialColor,officialInfo = UserDataHelper.getOfficialInfo(data:getOfficer_level())

    

    self._textRank:setString(index..".")
    self._textRank:setColor(officialColor)
    
    self._official:loadTexture(Path.getOfficialImg(officialInfo.picture))
	self._official:ignoreContentAdaptWithSize(true)

    self._name:setString(data:getUser_name())
    self._name:setColor(officialColor)
   

    self._textContribution:setString(data:getValue(GuildWarMemberData.KEY_CONTRIBUTION))
    --self._textAttackCrystal:setString(data:getValue(4))
   -- self._textAttackGate:setString(data:getValue(3))
    self._textAttack:setString(data:getValue(GuildWarMemberData.KEY_ATTACK))
    self._textKill:setString(data:getValue(GuildWarMemberData.KEY_KILL ))

    local GuildWarDataHelper = require("app.utils.data.GuildWarDataHelper")
	local config = GuildWarDataHelper.getRecordConfigByMerit(
        data:getValue(GuildWarMemberData.KEY_CONTRIBUTION)
    )
    
    if config then
        self._commonItemIcon:unInitUI()
        self._commonItemIcon:initUI(config.type, config.value, config.size)
        self._commonItemIcon:setTouchEnabled(true)
        self._textReward:setString(Lang.get("guildwar_record_item_num",{value = config.size}))
        self._imageBox:setVisible(false)
    else
        self._imageBox:setVisible(true)
        self._textReward:setString(Lang.get("guildwar_record_item_num",{value = 0}))   
    end
  


    
    --self._panel:setVisible(index % 2 == 0)
    if index % 2 == 0 then
		self._panel:loadTexture(Path.getUICommon("img_com_board_list01b"))
	else
		self._panel:loadTexture(Path.getUICommon("img_com_board_list01a"))
    end
    self._panel:setContentSize(CELL_SIZE)

end

-- i18n pos lable
function GuildWarRecordItemCell:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        if Lang.checkLang(Lang.TH) then
            self._name:setPositionX(self._name:getPositionX() + 22)
        else
            self._name:setPositionX(self._name:getPositionX() + 18)
        end
		
	end
end



return GuildWarRecordItemCell