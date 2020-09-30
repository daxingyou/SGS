--世界boss
local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupWorldBossRobCell = class("PopupWorldBossRobCell", ListViewCellBase)

local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")

local WorldBossConst = require("app.const.WorldBossConst")
local TextHelper = require("app.utils.TextHelper")

function PopupWorldBossRobCell:ctor()
    --
	--左边控件

    local resource = {
        file = Path.getCSB("PopupWorldBossRobCell", "worldBoss"),
        binding = {
		}
    }
    -- i18n ja change CSB
	if Lang.checkUI("ui4") then
        resource.file = Path.getCSB("PopupWorldBossRobCell2", "worldBoss")
    end
    PopupWorldBossRobCell.super.ctor(self, resource)
end


function PopupWorldBossRobCell:onCreate()
    -- i18n change lable
    self:_swapImageByI18n()
    -- i18n pos lable
    self:_dealPosByI18n()

	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
    self._commonButton:addClickEventListenerEx(handler(self,self._onButtonClick))
end


function PopupWorldBossRobCell:onEnter()

	
end

function PopupWorldBossRobCell:onExit()

end

function PopupWorldBossRobCell:updateUI( index, data )
    -- body
    self._cellValue = data
    self._playerName:updateUI(data.name, data.official)
    if data.rank <=3 and data.rank >= 1 then
        self:updateImageView("Image_top_rank", {visible = true, texture = Path.getArenaUI("img_qizhi0"..data.rank)})
        self:updateImageView("Image_rank_bk", {visible = true, texture = Path.getComplexRankUI("img_midsize_ranking0"..data.rank)})
        self:updateLabel("Text_rank", {visible = false})
    else
        self:updateImageView("Image_top_rank", {visible = false})
        self:updateImageView("Image_rank_bk", {visible = true, texture = Path.getComplexRankUI("img_midsize_ranking04")})
        self:updateLabel("Text_rank", {visible =true, text = data.rank})
    end

    self._textPoint:setString( TextHelper.getAmountText( data.point) )
    if data.userId == G_UserData:getBase():getId() then
        self._commonButton:setString(Lang.get("worldboss_grob_self_btn"))
        self._commonButton:setEnabled(false)
    else
        self._commonButton:setString(Lang.get("worldboss_grob_btn"))
        --self._commonButton:switchToHightLight()
        self._commonButton:setEnabled(true)
    end

    if data.guildName == nil or data.guildName == "" then
        self._textGuildName:setString(" ")
     
    else
        self._textGuildName:setString("("..data.guildName..")")
    end
    

    --self._commonButton:setButtonTag(data.userId)
    

    local scrollView = self._scrollView
	local commonHeroArr = scrollView:getChildren()

    for index, commHero in ipairs(commonHeroArr) do
        commHero:setVisible(false)

        local heroData = data.heroList[index]
        if heroData then
            local baseId, limit = unpack(heroData)
            cc.bind(commHero,"CommonHeroIcon")

            if baseId and baseId > 0 then
                commHero:setVisible(true)
                commHero:updateUI(baseId, nil, limit)
            end
        end
	end
	  if not Lang.checkLang(Lang.CN) then
        self._playerName:updateNameGap(-10)

        if Lang.checkLang(Lang.JA) then -- i18n ja change
            self._playerName:updateNameGap(-10)
            
            if self._textGuildName:getString() == " " then
                self._txtGuild:setString(" ")
            end
            
            self._imgPower:setPositionX(30 + self._playerName:getWidth() + 10)
            self._txtPower:setString(tostring(data.power))   
            self._txtPower:setColor(ccui.Helper:seekNodeByName(self._playerName, "TextPlayerName"):getColor()) 
        end
    end

    if Lang.checkUI("ui4") then
        self._textCondition:setPositionX(self._textPoint:getPositionX()-self._textPoint:getContentSize().width-3)
    end
end

function PopupWorldBossRobCell:_onButtonClick(sender)
	local userId = sender:getTag()
    self:dispatchCustomCallback(self._cellValue.userId)
end

-- i18n change lable
function PopupWorldBossRobCell:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then

        local UIHelper  = require("yoka.utils.UIHelper")	
		local image = UIHelper.seekNodeByName(self,"Image_text")
        UIHelper.swapSignImage(image,
		{ 
			 style = "signet_8", 
			 text = Lang.getImgText("txt_yichaoshi01") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_red"))

	end
end


-- i18n change lable
function PopupWorldBossRobCell:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then

        local UIHelper  = require("yoka.utils.UIHelper")	
        local nodeRank = UIHelper.seekNodeByName(self._resourceNode,"Node_rank")
        
        nodeRank:setPositionX(nodeRank:getPositionX()-18)
        self._playerName:setFontSize(18)
        self._playerName:setPositionX(self._playerName:getPositionX()-21)
       
        self._textGuildName:setFontSize(self._textGuildName:getFontSize()-2)
       
        local imageTopRank = UIHelper.seekNodeByName(nodeRank,"Image_top_rank")
        imageTopRank:setScale(0.6)
        local text_rank = UIHelper.seekNodeByName(nodeRank,"Text_rank")
        imageTopRank:setPositionX(imageTopRank:getPositionX()-4)
        text_rank:setPositionX(text_rank:getPositionX()-4)

        self._textCondition:setFontSize(self._textCondition:getFontSize()-2)
    end
   
    if Lang.checkUI("ui4") then
        local posX = 560
        self._textPoint:setAnchorPoint(1,0.5)
        self._textPoint:setPositionX(posX)
        self._textCondition:setAnchorPoint(1,0.5)
        self._textCondition:setPositionX(posX-self._textPoint:getContentSize().width-3)
        local UIHelper  = require("yoka.utils.UIHelper")	

        local title = UIHelper.seekNodeByName(self._playerName,"Image_title")
        if title then
            title:setPositionY(title:getPositionY()-5)
        end
        self._txtGuild:setString(Lang.get("worldbossGuildName"))   
        self._textGuildName:setPositionX( self._txtGuild:getPositionX()+ self._txtGuild:getContentSize().width)
    end
    
end

return PopupWorldBossRobCell
