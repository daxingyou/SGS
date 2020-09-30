local PopupBase = require("app.ui.PopupBase")
local PopupBossDetail = class("PopupBossDetail", PopupBase)

local Drop = require("app.config.drop")

local UIHelper = require("yoka.utils.UIHelper")
local Color = require("app.utils.Color")

local UserDataHelper = require("app.utils.UserDataHelper")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local DataConst = require("app.const.DataConst")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local Parameter = require("app.config.parameter")
local DropHelper = require("app.utils.DropHelper")
local ParameterIDConst = require("app.const.ParameterIDConst")


function PopupBossDetail:ctor(chapterType,chapterId, bossData, isBossPage, isPopStageView)
    self._chapterType = chapterType
    self._chapterId = chapterId
    self._bossData = bossData
    self._isBossPage = isBossPage
	self._isPopStageView = isPopStageView
    self._btnFormation = nil    --阵容
    self._btnFight = nil        --战斗
    self._btnClose = nil        --关闭按钮

    self._listenerBossFight = nil

    self._detailBG = nil    --详细面板
    self._drop1 = nil       --经验掉落
    self._drop2 = nil       --金币掉落
    self._listDrop = nil    --掉落列表
	local resource = {
		file = Path.getCSB("PopupBossDetail", "stage"),
		binding = {
			_btnAttack = {
				events = {{event = "touch", method = "_onFightClick"}}
			},
            _btnFormation = 
            {
                events = {{event = "touch", method = "_onFormationClick"}}
            },
            _btnClose = 
            {
                events = {{event = "touch", method = "_onCloseClick"}}
            }
		}
    }
    
    if Lang.checkUI("ui4") then
        resource.file = Path.getCSB("PopupBossDetail2", "stage")
    end

	PopupBossDetail.super.ctor(self, resource)
end

function PopupBossDetail:onCreate()
    -- i18n change lable
    self:_swapImageByI18n()
    -- i18n pos lable
    self:_dealPosByI18n()
    -- i18n horizontal
    self:_dealHorizontal()

    self:_createHeroSpine()
    self._btnAttack:setString(Lang.get("stage_fight"))
    -- i18n ui4
    self:_dealUi4()
end

function PopupBossDetail:onEnter()
    self._listenerBossFight = G_NetworkManager:add(MessageIDConst.ID_S2C_ActDailyBoss, handler(self, self._recvBossFight))

    local myLevel = G_UserData:getBase():getLevel()
    local exp = Parameter.get(ParameterIDConst.MISSION_DROP_EXP).content * myLevel * self._bossData.cost
    local money = Parameter.get(ParameterIDConst.MISSION_DROP_MONEY).content * myLevel * self._bossData.cost

    self._drop1:updateUI(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_EXP, exp)
    self._drop2:updateUI(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_GOLD, money)

    self._cost:updateUI(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_VIT, self._bossData.cost)

   
    if not Lang.checkLang(Lang.CN) and not Lang.checkHorizontal() then
         local UIHelper  = require("yoka.utils.UIHelper")
         UIHelper.dealVTextWidget(self._textTitle,self._bossData.name)
    else
        self._textTitle:setString(self._bossData.name)
    end

    self:_updateDropList()
end

function PopupBossDetail:onExit()
    if self._listenerBossFight then
        self._listenerBossFight:remove()
        self._listenerBossFight = nil
    end
end

--英雄spine
function PopupBossDetail:_createHeroSpine()
    self._ImageHero:updateUI(self._bossData.res_id)
    -- self._ImageHero:setBubble(self._stageInfo.talk, nil, 2, true)
end

--关闭按钮
function PopupBossDetail:_onCloseClick()
    self:closeWithAction()

    if self._isPopStageView then
        G_SceneManager:popScene()
    end
end

--战斗按钮
function PopupBossDetail:_onFightClick()
    local chapterId = self._chapterId
    local bossId = self._bossData.id
    local needVit = self._bossData.cost
    --检查BOSS是否存在

    local chapterData = G_UserData:getChapter():getChapterByTypeId( self._chapterType,chapterId)
    if chapterData:getBossId() == 0 or chapterData:getBossState() ~= 0 then
        G_Prompt:showTip(Lang.get("chapter_boss_not_find"))
        return 
    end

    local success = LogicCheckHelper.enoughValue(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_VIT, needVit)
    if success then 
        G_NetworkManager:send(MessageIDConst.ID_C2S_ActDailyBoss, 
            {
                chapter_id = chapterId,
                boss_id = bossId,
            })
    end
end


--点击阵容
function PopupBossDetail:_onFormationClick()
	local popupEmbattle = require("app.scene.view.team.PopupEmbattle").new()
	popupEmbattle:openWithAction() 
end

--跟新掉落列表
function PopupBossDetail:_updateDropList()
   
    local awards = DropHelper.getDropReward(self._bossData.drop)
    self._listDrop:setListViewSize(450, 100)
    for i, v in pairs(awards) do
        v.size = 1
    end

    -- i18n ui4
    local scale = 1
    local margin = 20
    if Lang.checkUI("ui4") then
        scale = 0.8
        margin = 13
    end
    self._listDrop:updateUI(awards, scale, false, true)
    self._listDrop:setItemsMargin(margin)
    self._awardsList = awards
end

--打副本消息处理
function PopupBossDetail:_recvBossFight(id, message)

    if message.ret ~= 1 then
        return
    end

    local ReportParser = require("app.fight.report.ReportParser")
    local reportData = ReportParser.parse( message.battle_report )
    local BattleDataHelper = require("app.utils.BattleDataHelper")
    local battleData = BattleDataHelper.parseDailyBossData(message, self._bossData.in_res,true)

    local win = reportData:isWin()
    local isPop = self._isPopStageView
    if win then
        local chapterData = G_UserData:getChapter()
        chapterData:defeatBoss(message.chapter_id)
        self:close()
    end

    G_SceneManager:showScene("fight", reportData, battleData, false, isPop)
end


-- i18n change lable
function PopupBossDetail:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        local image1 = UIHelper.seekNodeByName(self,"ImageGetBG","ImageGet")
        local image2 = UIHelper.seekNodeByName(self,"ImageGetBG2","ImageGet")
 

		UIHelper.swapWithLabel(image1,{
			 style = "reward_1",
			 text = Lang.getImgText("txt_essence_huodejiangli") ,
		})

        UIHelper.swapWithLabel(image2,{
			 style = "reward_1",
			 text = Lang.getImgText("txt_essence_huodejiangli") ,
		})

        self._textTitle:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)


        local image3 = UIHelper.seekNodeByName(self._btnFormation,"Image_11")
        if image3 then
             local label = UIHelper.swapWithLabel(image3,{
                style = "icon_txt_3_ui4",
                text = Lang.getImgText("img_btn_embattletxt01") ,
                offsetY = -37,
            })
            label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
            label:getVirtualRenderer():setLineSpacing(-7)
        end

	end
end



-- i18n change lable
function PopupBossDetail:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        local imageSword = UIHelper.seekNodeByName(self._btnAttack,"Image_Sword")
        local text = UIHelper.seekNodeByName(self._btnAttack,"Text")
		imageSword:setPositionX(imageSword:getPositionX())
        text:setPositionX(text:getPositionX()+16)
	end

end

-- i18n
function PopupBossDetail:_dealHorizontal()
    if Lang.checkHorizontal() then
        local UIHelper  = require("yoka.utils.UIHelper")
        local titleBg = UIHelper.seekNodeByName(self._panelBase,"ImageTitleBG")
        titleBg:setRotation(90)
        titleBg:setPosition(290,177)
        self._textTitle:setRotation(-90)
        self._textTitle:setPosition(25,121)
        self._textTitle:ignoreContentAdaptWithSize(true)
    end
end

-- i18n ui4
function PopupBossDetail:_dealUi4()
    if Lang.checkUI("ui4") then
        local UIHelper  = require("yoka.utils.UIHelper")
        local image1 = UIHelper.seekNodeByName(self,"ImageGetBG","ImageGet")
        local image2 = UIHelper.seekNodeByName(self,"ImageGetBG2","ImageGet")
        image1:setVisible(false)
        image2:setVisible(false)

        self._text1:setString(Lang.getImgText("txt_essence_huodejiangli"))
        self._text2:setString(Lang.getImgText("txt_essence_huodejiangli"))
        self._drop1:setTextCountSize(20)
        self._drop2:setTextCountSize(20)
        self._cost:setTextCountSize(20)

        self._textTitle:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
        self._textTitle:getVirtualRenderer():setLineSpacing(6)

        if Lang.checkLang(Lang.JA) or Lang.checkLang(Lang.ZH) then
            local UIHelper  = require("yoka.utils.UIHelper")
            local titleBg = UIHelper.seekNodeByName(self._panelBase,"ImageTitleBG")
            local bgPosY = titleBg:getPositionY()
            titleBg:ignoreContentAdaptWithSize(true)
            local UTF8 = require("app.utils.UTF8")
            local len = UTF8.utf8len(self._bossData.name)
            local titlePosY = self._textTitle:getPositionY()
            if len == 3 then
                titleBg:loadTexture(Path.getElitechapterUI("img_com_labelbg_02"))
                self._textTitle:setPositionY(titlePosY + 9)
            elseif len == 4 then
                titleBg:loadTexture(Path.getElitechapterUI("img_com_labelbg_03"))
                self._textTitle:getVirtualRenderer():setLineSpacing(2)
                titleBg:setPositionY(bgPosY - 14)
                self._textTitle:setPositionY(titlePosY + 22)
            elseif len >= 5 then
                titleBg:loadTexture(Path.getElitechapterUI("img_com_labelbg_04"))   
                self._textTitle:getVirtualRenderer():setLineSpacing(2)
                self._textTitle:setPositionY(titlePosY + 35)
            end
        end
    end
end

return PopupBossDetail