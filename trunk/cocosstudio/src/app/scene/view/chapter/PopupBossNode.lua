local ViewBase = require("app.ui.ViewBase")
local PopupBossNode = class("ChapterView", ViewBase)
local StoryEssenceBoss = require("app.config.story_essence_boss")
local Color = require("app.utils.Color")
-- local TypeConvertHelper = require("app.utils.TypeConvertHelper")

function PopupBossNode:ctor(chapterData)
    self._chapterData = chapterData

    self._imageChapterBG = nil      --章数bg
    self._txtChapter = nil          --章节数
    self._txtChapterName = nil      --章节名
    self._imageLock = nil           --锁
    self._iconBossImg = nil         --BOSS形象
    self._imageBossBG = nil         --boss名字背景
    self._bossName = nil            --boss名字
    self._btnFight = nil            --攻击
    self._imageKill = nil           --已击杀图案
    self._nodeUI = nil              --除了icon,其他的ui根节点
    local fileName = Path.getCSB("PopupBossNode", "chapter")
    if Lang.checkUI("ui4") then 
        fileName =  Path.getCSB("PopupBossNode1", "chapter")
    end
	local resource = {
		file = fileName,
		binding = {
			_btnFight = {
				events = {{event = "touch", method = "_onFightClick"}}
			},
		}
	}
	PopupBossNode.super.ctor(self, resource)
end

function PopupBossNode:onCreate()
    -- i18n change lable
    self:_swapImageByI18n()
    -- i18n pos lable
    self:_dealPosByI18n()

    self._btnFight:setString(Lang.get("elite_challenge"))
end

function PopupBossNode:onEnter()
    self._nodeUI:setVisible(false)
    self._imageLock:setVisible(true)
    self._iconBossImg:setVisible(false)
    self:refreshData(self._chapterData)
end

function PopupBossNode:onExit()
end

function PopupBossNode:refreshData(chapterData)
    self._chapterData = chapterData
   
    if not self._chapterData then
        self._nodeUI:setVisible(false)
        self._imageLock:setVisible(true)
        self._iconBossImg:setVisible(false)
        return
    end
    local config = self._chapterData:getConfigData()
    self._txtChapter:setString(config.chapter)
    self._txtChapterName:setString(config.name)
    local data = StoryEssenceBoss.get(self._chapterData:getBossId())
    self._iconBossImg:updateUI(data.res_id)
    self._iconBossImg:setQuality(data.color)
    self._iconBossImg:setVisible(true)
    self._imageLock:setVisible(false)
    
    self._bossName:setString(data.name)
    self._bossName:setColor(Color.getColor(data.color))
	-- self._bossName:enableOutline(Color.getColorOutline(data.color), 2)	
    local state = self._chapterData:getBossState()
    if state == 0 then
        self._imageKill:setVisible(false)
        self._btnFight:setVisible(true)
    else
        self._imageKill:setVisible(true)
        self._btnFight:setVisible(false)
    end
    self._nodeUI:setVisible(true)
end

function PopupBossNode:_onFightClick()
    local state = self._chapterData:getBossState()
    if state == 1 then
        return
    end    
    G_SceneManager:showScene("stage", self._chapterData:getId(), 0, true, true)
end


-- i18n change lable
function PopupBossNode:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then

        local UIHelper  = require("yoka.utils.UIHelper")	
        self._imageKill = UIHelper.swapSignImage(self._imageKill,
		{ 
			 style = "signet_9", 
			 text = Lang.getImgText("img_seal_yijisha01") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))

	end
end



-- i18n pos lable
function PopupBossNode:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        
        local imageSword = UIHelper.seekNodeByName(self._btnFight,"Image_Sword")
        local text = UIHelper.seekNodeByName(self._btnFight,"Text")
		imageSword:setPositionX(imageSword:getPositionX())
        text:setPositionX(text:getPositionX()+16)

        self._txtChapterName:setFontSize(
            self._txtChapterName:getFontSize()-2
        )
	end
end


return PopupBossNode