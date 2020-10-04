local SingleRaceReplayVSNode = class("SingleRaceReplayVSNode")
local SingleRaceConst = require("app.const.SingleRaceConst")
local TextHelper = require("app.utils.TextHelper")

function SingleRaceReplayVSNode:ctor(target, callback)
    self._target = target
    self._callback = callback
    self._nodeUp = nil
    self._nodeDown = nil
    self._imageCount = nil
    self._btnLook = nil
    self:_init()
end

function SingleRaceReplayVSNode:_init()
    self._nodeUp = ccui.Helper:seekNodeByName(self._target, "NodeUp")
    for i = 1, 6 do
        local heroIcon = self._nodeUp:getSubNodeByName("Hero"..i)
        cc.bind(heroIcon,"CommonHeroIcon")
    end
    self._nodeDown = ccui.Helper:seekNodeByName(self._target, "NodeDown")
    for i = 1, 6 do
        local heroIcon = self._nodeDown:getSubNodeByName("Hero"..i)
        cc.bind(heroIcon,"CommonHeroIcon")
    end
    self._imageCount = ccui.Helper:seekNodeByName(self._target, "ImageCount")
    self._btnLook = ccui.Helper:seekNodeByName(self._target, "BtnLook")
    cc.bind(self._btnLook, "CommonButtonLevel1Highlight")
    self._btnLook:addClickEventListenerEx(handler(self, self._onWatchClick))

    -- i18n change lable
    if not Lang.checkLang(Lang.CN) then
        self:_swapImageByI18n()
    end

end

function SingleRaceReplayVSNode:updateUI(replay, round, isLast)
    self._replay = replay
    if self._replay then
        self:_refreshHeros()
        self._target:setVisible(true)
        self:_refreshPlayer()
        self:_refreshWinPos()
        self:_refreshRound(round, isLast)
        self._btnLook:setString(Lang.get("camp_play_report"))
    else
        self._target:setVisible(false)
    end
end

function SingleRaceReplayVSNode:_refreshHeros()
    local upHeros = self._replay:getAtk_heros()
    for i, v in pairs(upHeros) do 
        self:_refreshSingleHero(1, i, v)
    end

    local downHeros = self._replay:getDef_heros()
    for i, v in pairs(downHeros) do 
        self:_refreshSingleHero(2, i, v)
    end
end

function SingleRaceReplayVSNode:_refreshPlayer()
    local upPlayer = G_UserData:getSingleRace():getUserDataWithId(self._replay:getAtk_user())
    local downPlayer = G_UserData:getSingleRace():getUserDataWithId(self._replay:getDef_user())
    local function updatePlayer(node, player, power)
        local textName = ccui.Helper:seekNodeByName(node, "TextName")
        textName:setString(player:getUser_name())
        textName:setColor(Colors.getOfficialColor(player:getOfficer_level()))
        local textPower = ccui.Helper:seekNodeByName(node, "TextPower")
        local strPower = TextHelper.getAmountText3(power)
        textPower:setString(strPower)
    end
    updatePlayer(self._nodeUp, upPlayer, self._replay:getAtk_power())
    updatePlayer(self._nodeDown, downPlayer, self._replay:getDef_power())
end

function SingleRaceReplayVSNode:_refreshWinPos()
    local nodes = {
        self._nodeUp,
        self._nodeDown,
    }
    local images = {}
    for i = 1, 2 do 
        local winImage = nodes[i]:getSubNodeByName("ImageWin")
        winImage:setVisible(false)
        images[i] = winImage
    end
    local winSide = self._replay:getWinnerSide()
    if winSide == SingleRaceConst.REPORT_SIDE_1 then 
        images[1]:setVisible(true)
    elseif winSide == SingleRaceConst.REPORT_SIDE_2 then 
        images[2]:setVisible(true)
    end
end

function SingleRaceReplayVSNode:_refreshRound(round, isLast)
    local round2Name = {
        "txt_camp_bt01",
        "txt_camp_bt02",
        "txt_camp_bt02a",
        "txt_camp_bt02b",
    }
    local imageName = ""
    if isLast then
        imageName = "txt_camp_bt03"
    else
        imageName = round2Name[round]
    end
    
    -- i18n change lable
    if Lang.checkLang(Lang.CN) then
    local image = Path.getTextCampRace(imageName)
    self._imageCount:loadTexture(image)
    else
        self._imageCount:setString( Lang.getImgText(imageName) )
end

end

function SingleRaceReplayVSNode:_refreshSingleHero(camp, pos, heroId)
    local node = self._nodeUp
    if camp == 2 then
        node = self._nodeDown 
    end
    local heroIcon = node:getSubNodeByName("Hero"..pos)
    if heroId > 0 then
        heroIcon:updateUI(heroId)
        heroIcon:showHeroUnknow(false)
    else
        heroIcon:showHeroUnknow(true)
    end
end

function SingleRaceReplayVSNode:_onWatchClick()
    if self._callback then
        self._callback(self._replay:getReport_id())
    end
end


-- i18n change lable
function SingleRaceReplayVSNode:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imageCount = UIHelper.swapWithLabel(self._imageCount,{
			 style = "single_race_3",
			 text = Lang.getImgText("txt_camp_bt01") ,
		})
        
        local nodeUp = UIHelper.seekNodeByName(self._target, "NodeUp","ImagePower")
        local nodeDown = UIHelper.seekNodeByName(self._target, "NodeDown","ImagePower")
		UIHelper.swapWithLabel(nodeUp,{
			 style = "camp_race_4",
			 text = Lang.getImgText("img_camp_com02"),
             fontSize = 20
		})
		UIHelper.swapWithLabel(nodeDown,{
			 style = "camp_race_4",
			 text = Lang.getImgText("img_camp_com02"),
             fontSize = 20
		})
    end
end

return SingleRaceReplayVSNode