--排行榜
local CampRaceRankNode = class("CampRaceRankNode")
local CampRaceRankCell = require("app.scene.view.campRace.CampRaceRankCell")
local CampRaceHelper = require("app.scene.view.campRace.CampRaceHelper")

function CampRaceRankNode:ctor(target)
    self._target = target
    self._imageCountry = nil
    self._imageRankTitle = nil
    self._listRank = nil
    self._textMyPoint = nil
    self._textMyRank = nil
    self._textMyName = nil
    self:_init()
end

function CampRaceRankNode:_init()
    self._imageCountry = ccui.Helper:seekNodeByName(self._target, "ImageCountry")
    self._imageRankTitle = ccui.Helper:seekNodeByName(self._target, "ImageRankTitle")
    self._listRank = ccui.Helper:seekNodeByName(self._target, "ListRank")
    cc.bind(self._listRank, "ScrollView")
    self._listRank:setTemplate(CampRaceRankCell)
    self._listRank:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
    self._listRank:setCustomCallback(handler(self, self._onItemTouch))
    self._textMyPoint = ccui.Helper:seekNodeByName(self._target, "TextMyPoint")
    self._textMyRank = ccui.Helper:seekNodeByName(self._target, "TextMyRank")
    self._textMyName = ccui.Helper:seekNodeByName(self._target, "TextMyName")

    -- i18n change lable
    self:_swapImageByI18n()

    self:_setMyInfo()
    self:_setTitle()
end

function CampRaceRankNode:onEnter()
end

function CampRaceRankNode:onExit()
end

function CampRaceRankNode:_setMyInfo()
    local myName = G_UserData:getBase():getName()
    self._textMyName:setString(myName)
    local myOfficerLevel = G_UserData:getBase():getOfficer_level()
    self._textMyName:setColor(Colors.getOfficialColor(myOfficerLevel)) 
end

function CampRaceRankNode:_setTitle()
    local camp = G_UserData:getCampRaceData():getMyCamp()

    local smallCamps = {4, 1, 3, 2}
	local campSmall = Path.getTextSignet("img_com_camp0"..smallCamps[camp])
    self._imageCountry:loadTexture(campSmall)
    
    local titleEnd = {"", "b", "c", "d"}
    -- i18n change lable
    if not Lang.checkLang(Lang.CN) then
         self._imageRankTitle:setString(Lang.getImgText("txt_camp_01"..titleEnd[camp]))
    else
         local titleText = Path.getTextCampRace("txt_camp_01"..titleEnd[camp])
         self._imageRankTitle:loadTexture(titleText)
    end

    self:_adjustPosByI18n()
end

function CampRaceRankNode:setRankData(rankData)
    self._rankData = rankData
    self._listRank:clearAll()
    self._listRank:resize(#rankData)
end

function CampRaceRankNode:refreshMyRank()
    local camp = G_UserData:getCampRaceData():getMyCamp()
    local preRankData = G_UserData:getCampRaceData():getPreRankWithCamp(camp)
    local myRank = preRankData:getSelf_rank()
    self._textMyRank:setString(myRank)
    local myPoint = preRankData:getSelf_score()
    self._textMyPoint:setString(myPoint)

    if not Lang.checkLang(Lang.CN) and not Lang.checkLang(Lang.TW) then
		local UIHelper  = require("yoka.utils.UIHelper")    
        self._textMyName:setPositionX(
            self._textMyRank:getPositionX()+15+self._textMyRank:getContentSize().width*0.5
        )
    end

end

function CampRaceRankNode:_onItemUpdate(item, index)
    item:updateUI(index+1, self._rankData[ index+1 ] )
end

function CampRaceRankNode:_onItemSelected(item, index)
end


-- i18n change lable
function CampRaceRankNode:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imageRankTitle = UIHelper.swapWithLabel(self._imageRankTitle,{style = "camp_race_1"})

        
        local image1 = UIHelper.seekNodeByName(self._target , "ImageRank")
		local image2 = UIHelper.seekNodeByName(self._target , "ImageName")
		local image3 = UIHelper.seekNodeByName(self._target , "ImagePoint")

	
		UIHelper.swapWithLabel(image1,{
			 style = "guild_dungeon_1",
			 text = Lang.getImgText("txt_camp_04")
		})
	
        UIHelper.swapWithLabel(image2,{
			 style = "guild_dungeon_2",
			 text = Lang.getImgText("txt_camp_02")
		})
	
        UIHelper.swapWithLabel(image3,{
			 style = "guild_dungeon_1",
			 text = Lang.getImgText("txt_camp_03")
		})
	


	end
end

function CampRaceRankNode:_adjustPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")    


        local imageBG = ccui.Helper:seekNodeByName(self._target, "ImageBG")
        local size = imageBG:getContentSize()
        local size1 = self._imageCountry:getContentSize()
        local size2 =  self._imageRankTitle:getContentSize()

       self._imageCountry:setPositionX(  - size2.width * 0.5  )
       self._imageRankTitle:setPositionX(size1.width * 0.5  )

        if Lang.checkLang(Lang.TW) then
            local img1 = ccui.Helper:seekNodeByName(self._target, "Image_1")
            self._textMyName:setPositionX(img1:getContentSize().width * 0.5)
            self._textMyName:setAnchorPoint(0.5,0.5)
        end
	end
end


return CampRaceRankNode