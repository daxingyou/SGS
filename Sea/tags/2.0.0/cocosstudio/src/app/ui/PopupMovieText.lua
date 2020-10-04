--黑屏字幕效果
local PopupBase = require("app.ui.PopupBase")
local PopupMovieText = class("PopupMovieText", PopupBase)
local SchedulerHelper = require("app.utils.SchedulerHelper")
local UIHelper = require("yoka.utils.UIHelper")
local UTF8 = require("app.utils.UTF8")


local MovieConst = require("app.const.MovieConst")
function PopupMovieText:ctor(movieType, callback)
	self._movieType = movieType or MovieConst.TYPE_LOGIN_START
	self._callback = callback

	self._nodeLoginStart = nil
	self._nodeLoginEnd = nil
	self._nodeChapterStart = nil
	self._nodeChapterEnd = nil
	self._imageStart = nil
	--
	local resource = {
		file = Path.getCSB("PopupMovieText", "common"),
		binding = {
		--	 size =  G_ResolutionManager:getDesignSize(),
		}
	}
	self:setName("PopupMovieText")
	PopupMovieText.super.ctor(self, resource,false, true)
end

--
function PopupMovieText:onCreate()
	self:_dealByI18n()
	self._panelRoot:addClickEventListenerEx(handler(self,self.onClickPanel))
	self._commonContinueNode:setVisible(false)
	self._nodeLoginStart:setVisible(false)
	self._nodeLoginEnd:setVisible(false)
	self._nodeChapterStart:setVisible(false)
	self._nodeChapterEnd:setVisible(false)
	--dump(G_ResolutionManager:getDesignCCSize())
	self._panelbk:setContentSize(G_ResolutionManager:getDesignCCSize())
	self._panelRoot:setContentSize(G_ResolutionManager:getDesignCCSize())
	ccui.Helper:doLayout(self._panelRoot)

	if G_ConfigManager:isDalanVersion() then
		self._nodeChapterStart:getSubNodeByName("Image_7"):setVisible(false)
		self._nodeChapterEnd:getSubNodeByName("Image_title"):setVisible(false)
	end
end

function PopupMovieText:_show(fun)
    self._imageStart:setOpacity(255)
    self._imageStart:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.FadeOut:create(0.4), cc.CallFunc:create(function() 
		fun()
	end)))
end

function PopupMovieText:showUI(chapterNum, chapterName, chapterContent)
	self:open()
	if self._movieType ==  MovieConst.TYPE_LOGIN_START then
		self._nodeLoginStart:setVisible(true)
		self:_show( handler(self, self.updateNodeLoginStart) )
	end

	if self._movieType ==  MovieConst.TYPE_LOGIN_END then
		self:updateNodeLoginEnd()
	end

	if self._movieType ==  MovieConst.TYPE_CHAPTER_START then
		self:updateNodeChapterStart(chapterNum, chapterName )
	end

	if self._movieType ==  MovieConst.TYPE_CHAPTER_END then
		self:updateNodeChapterEnd(chapterNum, chapterName, chapterContent)
	end

	if self._movieType == MovieConst.TYPE_CREATE_ROLE_START then
		self:updateNodeCreateRoleStart()
	end

end

function PopupMovieText:updateNodeLoginStart()
	
	local descStr = Lang.get("movie_text_start")
	self:updateMovieText(self._nodeLoginStart, descStr,handler(self,self.onMovieFinish))
end


function PopupMovieText:updateNodeCreateRoleStart()
	self._nodeCreateRoleStart:setVisible(true)
	local descStr = Lang.get("movie_create_role")
	self:updateMovieText(self._nodeCreateRoleStart, descStr,handler(self,self.onMovieFinish))
end

function PopupMovieText:updateNodeLoginEnd()
	self._nodeLoginEnd:setVisible(true)
	local descStr = Lang.get("movie_text_end")
	self:updateMovieText(self._nodeLoginEnd, descStr,handler(self,self.onMovieFinish))
end

function PopupMovieText:updateNodeChapterStart(chapterNum, chapterName)
	self._nodeChapterStart:setVisible(true)
	local descStr = Lang.get("chapter_start",{chapterNum = chapterNum, chapterName = chapterName})
	self:updateMovieText(self._nodeChapterStart, descStr, handler(self,self.onMovieFinish))
end

function PopupMovieText:updateNodeChapterEnd(chapterNum, chapterName,chapterContent)

	self._chapterNum = chapterNum
	self._chapterName = chapterName
	self._chapterContent = chapterContent

	local nodeMovie = self._nodeChapterEnd

	local function initMovie(nodeMovie)
		local textContent = nodeMovie:getSubNodeByName("Text_content")
		textContent:setString(" ")
		local textStart = nodeMovie:getSubNodeByName("Text_start")
		textStart:setString(" ")
		local imageTitle = nodeMovie:getSubNodeByName("Image_title")
		imageTitle:setVisible(false)
	end

	initMovie(nodeMovie)
	self._nodeChapterEnd:setVisible(true)
	self:_playMingJiangling()
end

function PopupMovieText:_playFinishStage()
	if self._isSkipped then
		return
	end
	self._isSkipped = true
	local nodeMovie = self._nodeChapterEnd
    local function eventFunction(event)
        if event == "finish" then
			self:onMovieFinish()
        end
    end
	local nodeFinish = nodeMovie:getSubNodeByName("Node_finish")

	if not Lang.checkLang(Lang.CN)  then
		local textStart = nodeMovie:getSubNodeByName("Text_start")
		nodeFinish:setPositionX(textStart:getPositionX()+textStart:getContentSize().width+50)
	end



    local effect = G_EffectGfxMgr:createPlayGfx( nodeFinish, "effect_mingjiangling_tongguan", eventFunction, false )
	effect:play()
end

function PopupMovieText:_playChapterContent()
	local nodeMovie = self._nodeChapterEnd
	local function onContentFinish()
		self:_playFinishStage()
	end
	local textContent = nodeMovie:getSubNodeByName("Text_content")
	local descStr = self._chapterContent
	self:playMoviveText(textContent, descStr, onContentFinish)
end

function PopupMovieText:_playChapterTitle()
	local nodeMovie = self._nodeChapterEnd

	local imageTitle = nodeMovie:getSubNodeByName("Image_title")
	imageTitle:setVisible(true)
	if G_ConfigManager:isDalanVersion() then 
		imageTitle:setVisible(false)
	end

	local textStart = nodeMovie:getSubNodeByName("Text_start")
	local descTitle = Lang.get("chapter_start",{chapterNum = self._chapterNum , chapterName = self._chapterName})
	self:playMoviveText(textStart, descTitle, handler(self, self._playChapterContent))
end

function PopupMovieText:_playMingJiangling()
	local nodeMovie = self._nodeChapterEnd
    local function eventFunction(event)
        if event == "finish" and not self._isSkipped then
			self:_playChapterTitle()
        end
    end
	
	local nodeMingjiangling = nodeMovie:getSubNodeByName("Node_mingjiangling")
    local effect = G_EffectGfxMgr:createPlayGfx( nodeMingjiangling, "effect_mingjiangling", eventFunction, false )
	effect:play()
end




function PopupMovieText:updateMovieText(nodeMovie,descStr,callBack)
	self._commonContinueNode:setVisible(false)
   
	local textMovie = nodeMovie:getSubNodeByName("Text_movie")
	textMovie:setString(" ")
	self:playMoviveText(textMovie, descStr,callBack)

end

function PopupMovieText:onMovieFinish()
	self._commonContinueNode:setVisible(true)
end

function PopupMovieText:playMoviveText(textMovie,descStr, callBack)

	local showWordNum = 0
    local playSpeed = MovieConst.PLAY_SPEED
	
	if self._countKey then
		SchedulerHelper.cancelSchedule(self._countKey)
		self._countKey = nil
	end
	local descCount = string.utf8len(descStr)

	local currTime = 0
	local totalTime = playSpeed * (descCount - showWordNum) + MovieConst.PLAY_DEALY_PEND

	local function checkCancelUpdate(currTime)
		if currTime > totalTime then
 			SchedulerHelper.cancelSchedule(self._countKey)
            self._countKey = nil
			if callBack then
				callBack()
			end
		end
	end

	local function updateCallBack(dt)
		checkCancelUpdate(currTime)
		currTime = currTime + dt
		local currShowNum = math.floor(currTime / playSpeed)
		--showWordNum = showWordNum + MovieConst.SHOW_WORD_NUM
		textMovie:setString(UTF8.utf8sub(descStr, 1, currShowNum))
	end


    self._countKey = SchedulerHelper.newSchedule(updateCallBack, playSpeed)
end

function PopupMovieText:onClickPanel(sender)
	if self._commonContinueNode:isVisible()== true then
		self:onCloseEvent()
	elseif self._movieType == MovieConst.TYPE_CHAPTER_END then
		self:_skipChapterEnd()
	end
	
end


--
function PopupMovieText:onEnter()
    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_BEGIN)
end

function PopupMovieText:onExit()

	if self._countKey then
		SchedulerHelper.cancelSchedule(self._countKey)
		self._countKey = nil
	end

    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_END)
	--只有章节通关，movie结束后，才通知引导进行
	if self._movieType == MovieConst.TYPE_CHAPTER_END then
		G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP,self.__cname)
	end
end

function PopupMovieText:onCloseEvent()
	if self._callback then
		self._callback()
	end
	self:close()
end

function PopupMovieText:_dealByI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image1 = UIHelper.seekNodeByName(self,"Image_title")
		local image2 = UIHelper.seekNodeByName(self._nodeChapterStart,"Image_7")
		

		local lable1 = UIHelper.swapWithLabel(image1,{
			style = "chatper_game_name_1",
			text = Lang.getImgText("game_name") ,
		})
		local lable2 = UIHelper.swapWithLabel(image2,{
			style = "chatper_game_name_1",
			text = Lang.getImgText("game_name") ,
		})
		local textContent = UIHelper.seekNodeByName(self._nodeChapterEnd,"Text_content")
		local size = textContent:getContentSize()
		textContent:setContentSize(cc.size(size.width+220,size.height)) 
		textContent:setAnchorPoint(cc.p(0.5,1))
		textContent:setPositionX(40)

		
	
		
	end
	if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
		local textContent = UIHelper.seekNodeByName(self._nodeChapterEnd,"Text_content")
		textContent:setContentSize(cc.size(800,260)) 
		textContent:setAnchorPoint(cc.p(0.5,1))
		textContent:setPosition(0,100)
		textContent:setFontSize(26)
		textContent:disableEffect(cc.LabelEffect.OUTLINE)
		local textStart = UIHelper.seekNodeByName(self._nodeChapterEnd,"Text_start")
		textStart:setFontSize(30)
		textStart:setAnchorPoint(cc.p(0.5,1))
		textStart:setPosition(0,190)
		textStart:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER )
		textStart:enableOutline(cc.c3b(0x6d , 0x2f  , 0x0c ), 2)
		local nodeMingjiangling = UIHelper.seekNodeByName(self._nodeChapterEnd,"Node_mingjiangling")
		nodeMingjiangling:setPositionY(-160)
		-- local imageTitle = UIHelper.seekNodeByName(self._nodeChapterEnd,"Image_title")
		-- imageTitle:disableEffect(cc.LabelEffect.OUTLINE)

		local textMovie = UIHelper.seekNodeByName(self._nodeChapterStart,"Text_movie")
		textMovie:setAnchorPoint(cc.p(0.5,1))
		textMovie:setPosition(0,70)
		textMovie:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER )
		textMovie:enableOutline(cc.c3b(0x6d , 0x2f  , 0x0c ), 2)
		-- local image7 = UIHelper.seekNodeByName(self._nodeChapterStart,"Image_7")
		-- image7:disableEffect(cc.LabelEffect.OUTLINE)
		if Lang.checkLang(Lang.TH) then
			textContent:getVirtualRenderer():setLineBreakWithoutSpace(true)
		end
	end
end

-- 点击跳过每章关卡结束的文本
function PopupMovieText:_skipChapterEnd()
	local isSkipOpen = G_ConfigManager:isSkipChapterText()
	if not isSkipOpen then
		return
	end
	if self._isSkipped then
		return
	end
	if self._countKey then
		SchedulerHelper.cancelSchedule(self._countKey)
		self._countKey = nil
	end
	local nodeMovie = self._nodeChapterEnd
	local textStart = nodeMovie:getSubNodeByName("Text_start")
	local descTitle = Lang.get("chapter_start",{chapterNum = self._chapterNum , chapterName = self._chapterName})
	textStart:setString(descTitle)
	local textContent = nodeMovie:getSubNodeByName("Text_content")
	local descStr = self._chapterContent
	textContent:setString(descStr)
	local imageTitle = nodeMovie:getSubNodeByName("Image_title")
	imageTitle:setVisible(true)
	self:_playFinishStage()
end




return PopupMovieText