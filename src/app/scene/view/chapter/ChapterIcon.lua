local ViewBase = require("app.ui.ViewBase")
local ChapterIcon = class("ChapterIcon", ViewBase)
local Path = require("app.utils.Path")
local UserDataHelper = require("app.utils.UserDataHelper")
local ParameterIDConst = require("app.const.ParameterIDConst")
local StoryEssenceBoss = require("app.config.story_essence_boss")
local ChapterConst = require("app.const.ChapterConst")

function ChapterIcon:ctor(initEffectName)
	self._chapterData = nil
	self._beforeData = nil
	self._configData = nil
	self._imageKill = nil	--已击杀
	self._isBossAlive = false
	self._isOpen = true
	self._imageRedPoint = nil
	self._nodeSword = nil
	self._isFinish = false
	self._dropPanelSize = nil
	self._dropHeroData = {}
	self._isNeedRefresh = false
	self._swordEffect = nil
	self._initEffectName = initEffectName

	self._canUse = true
	self._effect = nil

	self._closeBG = nil
	self._closeText = nil

	-- i18n ja
	self._numberWidth = 0
	self._numberHeight = 0

	local resource = {
		file = Path.getCSB("ChapterCity", "chapter"),
		binding = {
			-- _panelCity = {
			-- 	events = {{event = "touch", method = "_onButtonChapterClick"}}
			-- },
			_panelBoss = {
				events = {{event = "touch", method = "_onBossClick"}}
			},
		}
	}
	ChapterIcon.super.ctor(self, resource)
end



-- i18n change text fnt
function ChapterIcon:onLangHandle()
	local UIHelper = require("yoka.utils.UIHelper")
	local TypeConst = require("app.i18n.utils.TypeConst")
	self._chapterNameBg = UIHelper.swap(self._chapterNameBg,{style="city",typeConst="label"})

	if Lang.checkLang(Lang.ZH) then
		self._chapterNameBg:setFontSize(34)
	end

	if Lang.checkHorizontal() then
		self._numberBG:loadTexture(Path.get("img_zhangjie01_h","city","mline"))
		self._numberBG:ignoreContentAdaptWithSize(true)
		self._numberBG:setPosition(0,280)
		self._numberBG:setContentSize(cc.size(166,50))
		self._number:setPosition(83,25)
		self._number:setContentSize(cc.size(166,50))
	end
end

function ChapterIcon:onCreate()
	-- i18n change lable
	self:_swapImageByI18n()
	self:_dealPosByI18n()
	self._chapterNameBg:ignoreContentAdaptWithSize(true)
	self._panelCity:setSwallowTouches(false)
	self._panelCity:addClickEventListenerEx(handler(self, self._onButtonChapterClick), nil, 1000)
	if self._initEffectName then
		self._effect = G_EffectGfxMgr:createPlayMovingGfx(self._panelCity, self._initEffectName)
	end
	self:_showConditionText(false)
	self:_createUIGuideRootNode()
	-- i18n change text
	if not Lang.checkLang(Lang.CN) then self:onLangHandle() end

	-- i18n ja
	self._numberWidth = self._number:getContentSize().width
	self._numberHeight = self._number:getContentSize().height
end

function ChapterIcon:onEnter()
    self._signalRedPointUpdate = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self,self._onEventRedPointUpdate))	
end

function ChapterIcon:onExit()
    self._signalRedPointUpdate:remove()
    self._signalRedPointUpdate = nil
end

function ChapterIcon:setData(chapterData)
	self._chapterData = chapterData
	self._configData = chapterData:getConfigData()
	self:setName("ChapterIcon"..self._configData.id)
	self:setPosition(cc.p(self._configData.island_x, self._configData.island_y))
	self:_createNode()
	self:_use()
end

function ChapterIcon:_createNode()
	self._uiGuideRootNode:unbindAllUIGuide()
	-- self:_refreshEffect()
	self:_refreshInfo()
	self:_refreshHeroGet()
	self:_refreshFinishState()
	self:_refreshBossInfo()
	self:_refreshRedPoint()
	self:showSword(false)
	self:_refreshLevelLimit()

end

function ChapterIcon:refreshUI()
	self:_refreshFinishState()
	self:_refreshBossInfo()
	self:_refreshRedPoint()
	self:_refreshLevelLimit()
end

function ChapterIcon:_refreshEffect()
	if not self._effect then 
		self._effect = G_EffectGfxMgr:createPlayMovingGfx(self._panelCity, self._configData.island_eff, nil, nil, false )
	end
end

function ChapterIcon:_refreshInfo()
	if not Lang.checkLang(Lang.CN) and not Lang.checkHorizontal() then
		local UIHelper  = require("yoka.utils.UIHelper")
		UIHelper.dealVTextWidget(self._number,self._configData.chapter)
	else
		self._number:setString(self._configData.chapter)
	end

	-- i18n ja
	self:_refreshNumberPos()
	
	self._chapterName:setString(self._configData.name)
	-- i18n change text fnt   
	if not Lang.checkLang(Lang.CN) then
		self._chapterNameBg:setString(self._configData.name)
	else
		self._chapterNameBg:loadTexture(Path.getChapterNameIcon(self._configData.title))
	end

	if self._configData.type == ChapterConst.CHAPTER_TYPE_FAMOUS then
		self._starBg:setVisible(false)
		self._numberBG:setVisible(false)
	else 
		self._starBg:setVisible(true)
		self._numberBG:setVisible(true)
	end	
end

function ChapterIcon:_refreshNumberPos()
	-- 只针对于3位数以上的数字微调
	local chapterId = self:getChapterId()
	if Lang.checkLang(Lang.JA) and chapterId then
		local del = 100
		if chapterId >= 1000 then  -- 精英副本
			del = chapterId % 1000
		else  -- 主线
			del = chapterId
		end
		if del >= 100 then
			self._number:setContentSize(cc.size(self._numberWidth + 14, self._numberHeight))
		else
			self._number:setContentSize(cc.size(self._numberWidth, self._numberHeight))
		end
	end
end

function ChapterIcon:_refreshHeroGet()	
	local level = UserDataHelper.getParameter(ParameterIDConst.STAGE_SHOW_HERO)
	if G_UserData:getBase():getLevel() < level then
		self._panelGet:setVisible(false)
		return
	end
	self._dropPanelSize = cc.size(40, 78)
	local ChapterCityDropHeroCell = require("app.scene.view.chapter.ChapterCityDropHeroCell")
	local dropHeroDatas = self._chapterData:getDropHintDatas()--耗时比较长
	if self:_isDropDataSame(self._dropHeroData,dropHeroDatas) then
		self._panelGet:setVisible(#self._dropHeroData > 0)
		return
	end
	self._dropHeroData = dropHeroDatas
	self._listItem:clearAll()
	self._listItem:setContentSize(cc.size(59, 71))
	for i, data in ipairs(dropHeroDatas) do
		local cell = ChapterCityDropHeroCell.new()
		cell:updateUI(data.type,data.value,data.size)
		self._listItem:pushBackCustomItem(cell)
	end
	if #dropHeroDatas <= 0 then
		self._panelGet:setVisible(false)
		return
	end
	self._panelGet:setVisible(true)
	self._listItem:doLayout()
	local size = self._listItem:getInnerContainer():getContentSize()
	self._listItem:setContentSize(size)
	self._panelGet:setContentSize(self._dropPanelSize.width + size.width ,self._dropPanelSize.height)
end

function ChapterIcon:_refreshFinishState()
	local isFinish, getStar, totalStar = self._chapterData:getChapterFinishState()
	self:_showFlag(getStar >= totalStar)
	self._starCount:setString(""..getStar.."/"..totalStar)
end

function ChapterIcon:canUse()
	return self._canUse
end

function ChapterIcon:_use()
	self._canUse = false
	self:setVisible(true)
end

function ChapterIcon:unUse()
	self._canUse = true
	self:setVisible(false)
	self._chapterData = nil
	self._configData = nil
end

function ChapterIcon:getChapterId()
	if self._configData then 
		return self._configData.id
	end
	return nil
end

function ChapterIcon:goToStage()
	local success = G_UserData:getBase():getLevel() >= self._configData.need_level
	if  not success then
		G_Prompt:showTip(Lang.get("chapter_open_level_condition",{level = self._configData.need_level}))
		return
	end
	

	G_SceneManager:showScene("stage", self._chapterData:getId())
end

function ChapterIcon:_onButtonChapterClick(sender)
	local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
	local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
	if offsetX < 20 and offsetY < 20  then
		-- i18n ja
		if Lang.checkUI("ui4") then
			local AudioPatchHelper = require("app.scene.view.audiopatch.AudioPatchHelper")
			if AudioPatchHelper.checkShowDownload() then
				return
			end
		end
		self:goToStage()
	end
end

function ChapterIcon:_createUIGuideRootNode()
	local UIGuideConst = require("app.const.UIGuideConst")
	local UIGuideRootNode = require("app.scene.view.uiguide.UIGuideRootNode")
	if not self._uiGuideRootNode then
		self._uiGuideRootNode = UIGuideRootNode.new()
		self:addChild(self._uiGuideRootNode)
	end
end

function ChapterIcon:_showFlag(visible)
	if visible and (not self._flagSpine) then
		self:_createFlagSpine()
	end
	if self._flagSpine then
		self._flagSpine:setVisible(visible)
	end
end

function ChapterIcon:_createFlagSpine()
	if self._flagSpine then
		self._flagSpine:removeFromParent()
		self._flagSpine = nil
	end
	local node = G_EffectGfxMgr:createPlayMovingGfx(self._nodeStatic2, "moving_fudaowancheng_qizi", nil, nil, false)
	node:setVisible(true)
	self._flagSpine = node
end

--刷新boss信息
function ChapterIcon:_refreshBossInfo()
	local bossid = self._chapterData:getBossId()
	local bossState = self._chapterData:getBossState()
	if bossid ~= 0 then
		local bossData = StoryEssenceBoss.get(bossid)
		assert(bossData, "bossid "..bossid.." error")
		self:_refreshBossPanel(bossData)
		if bossState == 1 then
			self._imageKill:setVisible(true)
		else
			self._imageKill:setVisible(false)
			self._isBossAlive = true
		end
	else
		self._panelBoss:setVisible(false)
	end
end

function ChapterIcon:_refreshBossPanel(bossData)
	self._bossName:setString(bossData.name)
	self._bossName:setColor(Colors.getColor(bossData.color))
	self._bossName:enableOutline(Colors.getColorOutline(bossData.color), 2)	
	self._bossIcon:updateUI(bossData.res_id)
	self._bossIcon:setQuality(bossData.color)
	self._panelBoss:setVisible(true)
end

function ChapterIcon:_createSwordEft()
	local EffectGfxNode = require("app.effect.EffectGfxNode")
	local function effectFunction(effect)
        if effect == "effect_shuangjian"then
            local subEffect = EffectGfxNode.new("effect_shuangjian")
            subEffect:play()
            return subEffect 
        end
    end
    self._swordEffect = G_EffectGfxMgr:createPlayMovingGfx( self._nodeSword, "moving_shuangjian", effectFunction, nil, false )
end

function ChapterIcon:showSword(s)
	if not self._swordEffect then 
		self:_createSwordEft()
	end
	local show = G_UserData:getBase():getLevel() >= self._configData.need_level
	self._swordEffect:setVisible(s and show)
end

function ChapterIcon:_isDropDataSame(dropHeroData,newDropHeroData)
	if #dropHeroData ~= #newDropHeroData then
	 	return false
	end
	for k,v in ipairs(dropHeroData)	do
		local v2 = newDropHeroData[k]
		if v.type ~= v2.type or  v.value ~= v2.value then
			return false
		end
	end
	return true
end

function ChapterIcon:_onBossClick(sender)
	local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
	local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
	if offsetX < 20 and offsetY < 20  then
		if self._isBossAlive then
	 		G_SceneManager:showScene("stage", self._chapterData:getId(), 0, true, true)
		end
	end
end

function ChapterIcon:_refreshRedPoint()
	local redPoint = G_UserData:getChapter():hasRedPointForChapter(self._chapterData:getId())
	self._imageRedPoint:setVisible(redPoint)

	if redPoint then
		local UIActionHelper = require("app.utils.UIActionHelper")
		UIActionHelper.playSkewFloatEffect(self._imageRedPoint)
	else
		self._imageRedPoint:stopAllActions()
	end

end

function ChapterIcon:_onEventRedPointUpdate(event,funcId,param)
	if not self:canUse() and funcId ==  FunctionConst.FUNC_NEW_STAGE then
		self:_refreshRedPoint()
    end
end

function ChapterIcon:startPassAnim()
	self._nodeStatic2:setVisible(false)
	local function eventFunction(event,frameIndex, movingNode)
		if event == "chaqi" then
			--满星才播放
		local isFinish, getStar, totalStar = self._chapterData:getChapterFinishState()
		if getStar >= totalStar then
			G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, "moving_fudao_qiziluoxia", nil, nil, true)
		end


        elseif event == "qizi" then
			self._nodeStatic2:setVisible(true)
        end
    end
	G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, "moving_fudaowancheng", nil, eventFunction, true)
end

function ChapterIcon:startNewChapterAnim(callback)
	local function closeUI(visible)
		self:showSword(visible)
		self._nodeStatic:setVisible(visible)
		self["_starBg"]:setVisible(visible)
		self["_chapterNameBg"]:setVisible(visible)
		self["_panelCity"]:setVisible(visible)
		if self._configData.type == ChapterConst.CHAPTER_TYPE_FAMOUS then
			self._starBg:setVisible(false)
			self._numberBG:setVisible(false)
		end	
	end
	closeUI(false)
    local function effectFunction(effect)
        if effect == "smoving_fudao_zhangjiezi" then
			self["_starBg"]:setVisible(true)
			if self._configData.type == ChapterConst.CHAPTER_TYPE_FAMOUS then
				self._starBg:setVisible(false)
				self._numberBG:setVisible(false)
			end	
			self["_chapterNameBg"]:setVisible(true)

			G_EffectGfxMgr:applySingleGfx(self["_starBg"], effect,nil, nil, nil)
			G_EffectGfxMgr:applySingleGfx(self["_chapterNameBg"], effect,nil, nil, nil)
		elseif effect == "smoving_fudao_jianzhu" then	  
			self["_panelCity"]:setVisible(true)
			G_EffectGfxMgr:applySingleGfx(self["_panelCity"], effect,nil, nil, nil)
		end
		return cc.Node:create()
    end
   	local function eventFunction(event,frameIndex, movingNode)
        if event == "shuangjian" then
			self:showSword(true)
		elseif event == "finish" then	
			closeUI(true)
			if callback then callback() end
		elseif event == "yan" then	--烟在最底层，单独拿出来播放
			G_EffectGfxMgr:createPlayMovingGfx(self._nodeBgEffect, "moving_fudaokaiqi_yan", nil, nil, true)	
        end
    end
	G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, "moving_fudaokaiqi", effectFunction, eventFunction, true)
end

function ChapterIcon:getEffectName()
	return self._initEffectName
end

function ChapterIcon:_refreshLevelLimit()
	local show = G_UserData:getBase():getLevel() < self._configData.need_level
	self:_showConditionText(show,Lang.get("chapter_open_level_condition",{level = self._configData.need_level}))
end



function ChapterIcon:_showConditionText(visible,txt)
	self._closeBG:setVisible(visible)
	if visible then
		self._closeText:setString(txt)
	end
	
end


-- i18n change lable
function ChapterIcon:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		self._imageKill = UIHelper.swapSignImage(self._imageKill,
		{ 
			 style = "sign_2", 
			 text = Lang.getImgText("img_kill") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_red"))
	end
end

function ChapterIcon:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		self._number:setFontSize(
			self._number:getFontSize()-4
		)
	end
end



return ChapterIcon