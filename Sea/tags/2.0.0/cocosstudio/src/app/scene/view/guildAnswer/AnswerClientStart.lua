
-- Author: nieming
-- Date:2018-01-30 20:17:37
-- Describle：
local ViewBase = require("app.ui.ViewBase")
local AnswerClientStart = class("AnswerClientStart", ViewBase)
local UIActionHelper = require("app.utils.UIActionHelper")
local GuildAnswerHelper = require("app.scene.view.guildAnswer.GuildAnswerHelper")
local GuildAnswerConst = require("app.const.GuildAnswerConst")

function AnswerClientStart:ctor(questions, countDownCallback)
	--csb bind var name
	self._countDownTime = nil  --Text
	self._loadingBarProgress = nil  --LoadingBar
	self._questionContent = nil  --
	self._questionIndexText = nil  --Text
	self._questionIndexParent = nil  --SingleNode
	self._questionOptionsParent = nil
	self._curSelectAnswerOptionIndex = nil
	self._curBeginTime = 0
	self._curEndTime = 0

	self._questions = questions
	self._countDownCallback = countDownCallback

	local resource = {
		file = Path.getCSB("AnswerClientStart", "guildAnswer")
	}
	AnswerClientStart.super.ctor(self, resource)
end

-- Describle：
function AnswerClientStart:onCreate()
	if not Lang.checkLang(Lang.CN) then
		self:_dealPosByI18n()
	end


	local renderLabel = self._questionContent:getVirtualRenderer()
	if Lang.checkLang(Lang.CN) then
		renderLabel:setWidth(400)
	elseif Lang.checkChannel(Lang.CHANNEL_SEA) then
		renderLabel:setWidth(400+90)
	else
		renderLabel:setWidth(400+60)
	end
	renderLabel:setLineSpacing(3)
	
	local ExaminationIndex = require("app.scene.view.guildAnswer.ExaminationIndex")
	local ExaminationOption = require("app.scene.view.guildAnswer.ExaminationOption")
	self._indexs = {}
	local indexGap = 60
	for i = 1, GuildAnswerConst.QUESTION_NUM do
		local indexNode = ExaminationIndex.new(i)
		indexNode:setPositionX((i-1)* indexGap)
		self._questionIndexParent:addChild(indexNode)
		self._indexs[i] = indexNode
	end

	self._options = {}
	local optionXGap = 300
	local optionYGap = 80
	for i = 1, 4 do
		local optionNode = ExaminationOption.new(i, handler(self, self._onSelectOption))
		optionNode:setPosition(cc.p(((i-1)%2)* optionXGap, -math.floor(((i-1)/2)) * optionYGap))
		self._questionOptionsParent:addChild(optionNode)
		self._options[i] = optionNode
	end
	self._respondTime = GuildAnswerHelper.getRespondTime()
	self._awardTime = GuildAnswerHelper.getAwardTime()
	self._curIndex, self._isAwardTime = GuildAnswerHelper.getCurQuestionIndex(self._questions)
	-----测试代码
	-- self:getTestData()
	-- self._curIndex = 1
	---
	self._curQuestion = self._questions[self._curIndex]
	-- print("============================111=="..self._curIndex)

	if not self._curQuestion then
		assert(false, "self._curQuestion == nil")
		return
	end

	self._curSelectOption = self._curQuestion:getSelectOption()
	self:_updateQuestionContent()
	self:_startCountDown()
end

-- Describle：
function AnswerClientStart:onEnter()
	self._answerSignal =
		G_SignalManager:add(SignalConst.EVENT_ANSWER_GUILD_QUESTION_SUCCESS, handler(self, self._onEventAnswerResult))
end

-- Describle：
function AnswerClientStart:onExit()
	self._answerSignal:remove()
	self._answerSignal = nil
end

function AnswerClientStart:_updateQuestionContent()
	self:_updateQuestionsIndex()
	self:_updateOptions()
end

function AnswerClientStart:_updateQuestionsIndex()
	for i = 1, GuildAnswerConst.QUESTION_NUM do
		local questionData = self._questions[i]
		local isRight = questionData:getRightAnswer() == questionData:getSelectOption()
		local isAnswer = questionData:getSelectOption() ~= 0
		self._indexs[i]:updateUI(self._curIndex, isRight, isAnswer)
		if self._curIndex == i then
			self._questionIndexText:setString(Lang.get("lang_guild_answer_start_question_index", {num = i}))
			self._questionContent:setString(questionData:getQuestionDes())
		end
	end
end

function AnswerClientStart:_updateOptions()
	if not self._curQuestion then
		return
	end
	local options = self._curQuestion:getOptions()
	for j = 1, 4 do
		local isNeedShowRight = self._isAwardTime
		local isSelect = self._curQuestion:getSelectOption() == j
		local isRight = self._curQuestion:getRightAnswer() == j
		self._options[j]:updateUI(options[j], isNeedShowRight, isSelect, isRight)
	end
end

function AnswerClientStart:_updateOptionByIndex(index)
	if not self._curQuestion then
		return
	end
	local options = self._curQuestion:getOptions()
	for j = 1, 4 do
		if j == index then
			-- local isNeedShowRight = self._isAwardTime
			local isSelect = self._curQuestion:getSelectOption() == j
			local isRight = self._curQuestion:getRightAnswer() == j
			self._options[j]:updateUI(options[j], true, isSelect, isRight)
			break
		end
	end
end

function AnswerClientStart:_onSelectOption(index)
	if self._isAwardTime then
		return
	end

	if not self._curQuestion then
		assert(false, "self._curQuestion  == nil ")
		return
	end

	if self._curSelectAnswerOptionIndex then
		return
	end

	-- 如果被踢出军团 不能答题
	local isInGuild = G_UserData:getGuild():isInGuild()
	if not isInGuild then
		G_Prompt:showTip(Lang.get("lang_guild_answer_no_guild"))
		return
	end
	-- logError("====================="..index)
	G_UserData:getGuildAnswer():c2sAnswerGuildQuestion(self._curQuestion:getQuestionNo(), index)
end

function AnswerClientStart:_setLoadingBarProgress(curTime)
	if self._isAwardTime then
		self._loadingBarProgress:setPercent(0)
	else
		local percent = 100 * (self._curEndTime - curTime)/(self._curEndTime - self._curBeginTime)
		if percent < 0 then
			percent = 0
		end
		self._loadingBarProgress:setPercent(percent)
	end
end
--开始倒计时
function AnswerClientStart:_startCountDown()
	if not self._curQuestion then
		return
	end
	self._countDownTime:stopAllActions()
	self._curBeginTime = GuildAnswerHelper.getQuestionBeginTime(self._curQuestion)
	if self._isAwardTime then
		--结算时间
		self._awardTimeLabel:setVisible(false) -- 策划大哥不需要 结算中  暂时设为false
		self._countDownParentNode:setVisible(false)
		self._curBeginTime = self._curBeginTime + self._respondTime
		self._curEndTime = self._curBeginTime + self._awardTime
	else
		--答题时间
		self._countDownParentNode:setVisible(true)
		self._awardTimeLabel:setVisible(false)
		self._curEndTime = self._curBeginTime + self._respondTime
	end
	-- logError("============================")
	-- print(self._isAwardTime, self._curBeginTime, self._curEndTime, self._curIndex)

	local curTime = G_ServerTime:getTime()

	local action =
		UIActionHelper.createUpdateAction(
		function()
		local curTime2 = G_ServerTime:getTime()
		local diffTime = self._curEndTime - curTime2
		if diffTime < 0 then
			diffTime = 0
		end
		self._countDownTime:setString(diffTime)
		self:_setLoadingBarProgress(curTime2)
		if curTime2 >= self._curEndTime then
			self:_next()
		end
		end,
		0.02
	)

	self._countDownTime:setString(self._curEndTime - curTime)
	self:_setLoadingBarProgress(curTime)
	self._countDownTime:runAction(action)
end
--
function AnswerClientStart:_addScorePromptTips(questionData , callback)
	if questionData then
		if questionData:getSelectOption() ~= 0 then
			if questionData:getRightAnswer() == questionData:getSelectOption() then
				local score = GuildAnswerHelper.getRightPoint()
				local str = Lang.get("lang_guild_answer_start_right_score_add", {num = score})
				self:_showTips(str, true, callback)
			else
				local score = GuildAnswerHelper.getWrongPoint()
				local str = Lang.get("lang_guild_answer_start_wrong_score_add", {num = score})
				self:_showTips(str, false, callback)
			end
		else
			local str = Lang.get("lang_guild_answer_start_not_answer")
			self:_showTips(str, false, callback)
		end
	else
		callback()
	end
end

function AnswerClientStart:_next()
	--主要 处理 切换到后台在切换回来导致题目序号不对 需要从新推算
	self._curIndex, self._isAwardTime = GuildAnswerHelper.getCurQuestionIndex(self._questions)

	if not self._curIndex or self._curIndex > #self._questions then
		self._countDownTime:stopAllActions()
		if self._countDownCallback then
			self._countDownCallback()
		end
		return
	end
	-- 进入下一题前 清除选项
	if not self._isAwardTime then
		self._curSelectAnswerOptionIndex = nil
	end

	self._curQuestion = self._questions[self._curIndex]
	self:_updateQuestionContent()
	self:_startCountDown()
end

function AnswerClientStart:_onEventAnswerResult(id, message)
	local question_no = rawget(message, "question_no")
	if question_no then
		local questionData = self._questions[question_no]
		if not questionData then
			assert(false, "questionData == nil")
			return
		end
		local answer_id = rawget(message, "answer_id")
		local awards = rawget(message, "reward") or {}
		if answer_id then
			questionData:setSelectOption(answer_id)
			self._curSelectAnswerOptionIndex = answer_id
			self:_addScorePromptTips(
				questionData,
				function()
				G_Prompt:showAwards(awards)
				end
			) --弹出积分
			--更新选项
			if questionData:getQuestionNo() == self._curQuestion:getQuestionNo() then
				self:_updateOptionByIndex(answer_id)
			end
		end
	end
end

function AnswerClientStart:_showTips(str, isRight, callback)
	-- local function effectFunction(effect)
	-- 	if string.find(effect, "effect_") then
	-- 		local subEffect = EffectGfxNode.new(effect)
	-- 		subEffect:play()
	-- 		return subEffect
	-- 	elseif effect == "txt_huida" then
	-- 		-- local richtext = ccui.RichText:createRichTextByFormatString2(str, Colors.BRIGHT_BG_ONE, 22)
	-- 		-- richtext:setAnchorPoint(0.5, 0.5)
	-- 		local sprite
	-- 		if isRight then
	-- 			sprite = cc.Sprite:create(Path.getGuildAnswerText("txt_answer_01"))
	-- 		else
	-- 			sprite = cc.Sprite:create(Path.getGuildAnswerText("txt_answer_02"))
	-- 		end
	-- 		return sprite
	-- 	end
	-- end

	-- i18n change effect
	local effectFunction = nil
	local function effectFunctionWrong(effect)
		if  not Lang.checkLang(Lang.CN) and effect == "routine_word_juntuandati_wrong" then
			local TypeConst = require("app.i18n.utils.TypeConst")
			local UIHelper = require("yoka.utils.UIHelper")
			local subLabel = UIHelper.createLabel({text=Lang.getEffectText("effect_juntuandati_wrong"),style="effect_text_15_2",styleType=TypeConst.EFFECT})
			return subLabel
		end	
	end
	-- i18n change effect
	local function effectFunctionRight(effect)
		if  not Lang.checkLang(Lang.CN) and effect == "routine_word_juntuandati_right" then
			local TypeConst = require("app.i18n.utils.TypeConst")
			local UIHelper = require("yoka.utils.UIHelper")
			local subLabel = UIHelper.createLabel({text=Lang.getEffectText("effect_juntuandati_right"),style="effect_text_15_1",styleType=TypeConst.EFFECT})
			return subLabel
		end	
	end
	local function eventFunction(event)
		if event == "finish" then
			if callback then
				callback()
			end
		end
	end
	local movingName = "moving_juntuandati_zhengque"
	effectFunction = effectFunctionRight
	if not isRight then
		effectFunction = effectFunctionWrong
		movingName = "moving_juntuandati_cuowu"
	end
	local effect = G_EffectGfxMgr:createPlayMovingGfx( self._effectTipsNode, movingName, effectFunction, eventFunction ,true )
end


-- i18n pos lable
function AnswerClientStart:_dealPosByI18n()
    if not Lang.checkLang(Lang.CN) then
		if Lang.checkChannel(Lang.CHANNEL_SEA) then
			self._questionIndexText:setPositionX(self._questionIndexText:getPositionX()-20)
			self._questionContent:setPositionX(self._questionContent:getPositionX()-20)
			self._questionIndexText:setPositionY(self._questionIndexText:getPositionY()+40)
			self._questionContent:setPositionY(self._questionContent:getPositionY()+40)
			self._questionIndexText:setFontSize(self._questionIndexText:getFontSize()-4)
			self._questionContent:setFontSize(self._questionContent:getFontSize()-4)
		else
			self._questionIndexText:setPositionX(self._questionIndexText:getPositionX()-20)
			self._questionContent:setPositionX(self._questionContent:getPositionX()-20)
		end
		if Lang.checkLang(Lang.TW) or Lang.checkChannel(Lang.CHANNEL_SEA) then
			self._questionIndexText:setAnchorPoint(1,1)
			self._questionIndexText:setPositionY(self._questionContent:getPositionY())
		end
	end
end



return AnswerClientStart
