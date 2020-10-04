--世界boss
local ListViewCellBase = require("app.ui.ListViewCellBase")
local WorldBossRankCell = class("WorldBossRankCell", ListViewCellBase)

local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")

local WorldBossConst = require("app.const.WorldBossConst")
local TextHelper = require("app.utils.TextHelper")

function WorldBossRankCell:ctor()
    --
	--左边控件
    self._nodeGuild = nil
    self._nodePersonal = nil
    local resource = {
        file = Path.getCSB("WorldBossRankCell", "worldBoss"),
        binding = {
		}
    }

    WorldBossRankCell.super.ctor(self, resource)
end


function WorldBossRankCell:onCreate()
    -- i18n pos lable
    self:_dealPosByI18n()

	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
end



function WorldBossRankCell:updateUI(index, data, tabIndex)
    self._cellData = data
    if data.rank <= 3 and data.rank > 0 then
		self:updateImageView("Image_rank_bk", { visible = true,  texture = Path.getArenaUI("img_qizhi0"..data.rank)})
		self:updateLabel("Text_rank_num", {visible = false})
	else
		self:updateLabel("Text_rank_num", {visible = true, text = data.rank })
		self:updateImageView("Image_rank_bk",{ visible = true, texture = Path.getArenaUI("img_qizhi04") })
	end
    local function getRankColor(rank)
        if rank <=3 and rank > 0  then
            return Colors["WORLD_BOSS_RANK_COLOR"..rank]
        end
        return Colors["WORLD_BOSS_RANK_COLOR4"]
    end

	self._nodeGuild:setVisible(false)
    self._nodePersonal:setVisible(false)
    if tabIndex == WorldBossConst.TAB_INDEX_GUILD then
        self._nodeGuild:setVisible(true)
        self._textGuildName:setString(data.name)
        self._textGuildCount:setString(data.num)
        self._textGuildPoint:setString(TextHelper.getAmountText(data.point))
    else
        self._nodePersonal:setVisible(true)
        self._fileNodePlayerName:updateUI(data.name, data.official)
        self._fileNodePlayerName:setFontSize(18)
        self._textPoint:setString(TextHelper.getAmountText(data.point))
    end

    if not Lang.checkLang(Lang.CN) then
         self._fileNodePlayerName:updateNameGap(-10)
    end
end

-- i18n pos lable
function WorldBossRankCell:_dealPosByI18n()
   if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        local imageRankBk = UIHelper.seekNodeByName(self._resourceNode,"Image_rank_bk")
        local textRankNum = UIHelper.seekNodeByName(self._resourceNode,"Text_rank_num")

        imageRankBk:setPositionX(imageRankBk:getPositionX()-5)
        textRankNum:setPositionX(textRankNum:getPositionX()-5)

        self._textGuildName:setPositionX(self._textGuildName:getPositionX()-5)
        self._fileNodePlayerName:setPositionX(self._fileNodePlayerName:getPositionX()-11)

        self._textGuildCount:setPositionX(self._textGuildCount:getPositionX()+25)
        local textPeople = UIHelper.seekNodeByName(self._resourceNode,"Text_people")
       
        textPeople:setAnchorPoint(cc.p(1,0.5))
        textPeople:setPositionX(self._textGuildCount:getPositionX()-2)

        imageRankBk:setScale(0.80)
        self._textGuildName:setFontSize(self._textGuildName:getFontSize()-2)
        self._fileNodePlayerName:setOfficialScale(0.8)
        --日本版本特殊处理
        if  Lang.checkLang(Lang.JA) then
            -- self._textPoint:setPositionX(self._textPoint:getPositionX()+10)
            local imageBk = UIHelper.seekNodeByName(self._nodeGuild,"Image_bk_0")
            imageBk:setPositionX(imageBk:getPositionX()+18)
            local Text_total_point = UIHelper.seekNodeByName(imageBk,"Text_total_point")
             Text_total_point:setPositionX(Text_total_point:getPositionX()-12)

        end
    end
end

return WorldBossRankCell
