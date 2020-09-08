local ViewBase = require("app.ui.ViewBase")
local EventAnswerNode = class("EventAnswerNode", ViewBase)

local ExploreAnswer = require("app.config.explore_answer")
local EventAnswerCell = require("app.scene.view.exploreMap.EventAnswerCell")
local scheduler = require("cocos.framework.scheduler")

EventAnswerNode.ANSWER_COUNT = 4

function EventAnswerNode:ctor(eventData)
    self._eventData = eventData
    self._configData = ExploreAnswer.get(eventData:getValue1())
	assert(self._configData ~= nil, "can not find answer config id = "..eventData:getValue1())
    self._answerPanels = {}
    self._myAnswer = eventData:getParam()      --我的答案

    --ui
    self._nodeCell1 = nil       --答案节点1
    self._nodeCell2 = nil       --答案节点2
    self._nodeCell3 = nil       --答案节点3
    self._nodeCell4 = nil       --答案节点4
    self._nodeRight = nil       --正确奖励
    self._talkQuestion = nil    --问题
    self._isVisible = nil
    self._leftTimeLabel = nil --倒计时

    local resource = {
		file = Path.getCSB("EventAnswerNode", "exploreMap"),
        binding = {
        }
	}
    self:setName("EventAnswerNode")
	EventAnswerNode.super.ctor(self, resource)
end

function EventAnswerNode:onCreate()
    self._leftTimeLabel:setString(G_ServerTime:getLeftSecondsString(self._eventData:getEndTime(), "00:00:00"))
    if not Lang.checkLang(Lang.CN) then
        self:_updatePosByI18n()
    end
    -- i18n change lable
    self:_swapImageByI18n()
    self:_dealPosByI18n()
    --i18n
    self:_createQuestionByI18n()
end

function EventAnswerNode:onEnter()
    self:_setReward()
    self:_setQuestion()
    self:_setAnswer()
    if self._myAnswer ~= 0 then
        self:_showAnswer()
    end
    self._isVisible = true
    --抛出新手事件出新手事件
    self._countDownScheduler = scheduler.scheduleGlobal(handler(self, self._onTimer), 0.5)
    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
end

function EventAnswerNode:onExit()
    self._isVisible = nil
    scheduler.unscheduleGlobal(self._countDownScheduler)
    self._countDownScheduler = nil
end

--设置答对答错奖励
function EventAnswerNode:_setReward()
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local rightItemParams = TypeConvertHelper.convert(self._configData.right_type, self._configData.right_resource)
    if rightItemParams.res_mini then
        self._rightResIcon:loadTexture(rightItemParams.res_mini)
    end
    self._rightResSize:setString(self._configData.right_size)

    local wrongItemParams = TypeConvertHelper.convert(self._configData.wrong_type, self._configData.wrong_resource)
    if wrongItemParams.res_mini then
        self._wrongResIcon:loadTexture(wrongItemParams.res_mini)
    end
    self._wrongResSize:setString(self._configData.wrong_size)

    
    if not Lang.checkLang(Lang.CN) then
        self:_updateRightWrongPosByI18n()
    end
end

--设置问题
function EventAnswerNode:_setQuestion()
    local question = self._configData.description
    self._talkQuestion:setString(question)
    --i18n
    self:_updateQuestionByI18n()
end

--设置回答
function EventAnswerNode:_setAnswer()
    for i= 1, EventAnswerNode.ANSWER_COUNT do
        local eventAnswerCell = EventAnswerCell.new(self._configData, i, handler(self, self._onAnswerClick))
        self["_nodeCell"..i]:addChild(eventAnswerCell)
        table.insert(self._answerPanels, eventAnswerCell)
    end
end

--点击答案
function EventAnswerNode:_onAnswerClick(index)
    --如果已经有答案了，拒绝输入
    -- 超出游历时间
    local endTime = self._eventData:getEndTime()
    local curTime =  G_ServerTime:getTime()
    if curTime > endTime then
        G_Prompt:showTip(Lang.get("explore_event_time_over"))
        return
    end

    --如果已经有答案了，拒绝输入
    if self._myAnswer ~= 0 then
        return
    end
    self._myAnswer = index
    -- self._eventData:setParam(self._myAnswer)

    G_UserData:getExplore():c2sExploreDoEvent(self._eventData:getEvent_id(), self._myAnswer)
end

--处理事件
function EventAnswerNode:doEvent(message)
    local function callback()
		if rawget(message, "awards") then
			local rewards = {}
			for i, v in pairs(message.awards) do
				local reward =
				{
					type = v.type,
					value = v.value,
					size = v.size,
				}
				table.insert(rewards, reward)
			end
            G_Prompt:showAwards(rewards)

            --引导下一步
            if G_TutorialManager:isDoingStep(19) and self._isVisible then
                local delayAction = cc.DelayTime:create(0.4)
                local function callStepAction( ... )
                    --抛出新手事件

                    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
                end

                local callAction = cc.CallFunc:create(callStepAction)
                self:runAction(cc.Sequence:create(delayAction,callAction))
            end
			-- local PopupGetRewards = require("app.ui.PopupGetRewards").new()
			-- PopupGetRewards:showRewards(rewards)
		end
    end
	G_UserData:getExplore():setEventParamById(self._eventData:getEvent_id(), self._myAnswer)
    local isRight = self:_showAnswer()
    -- callback()
    if isRight then
        G_Prompt:showTip(Lang.get("explore_answer_right"), callback)
    else
        G_Prompt:showTip(Lang.get("explore_answer_wrong"), callback)
    end
end

--显示答案
function EventAnswerNode:_showAnswer()
    for _, v in pairs(self._answerPanels) do
        v:disableAnswer()
    end
    -- local rightAnswer = self._configData.right_answer
    local rightAnswer = self._eventData:getValue2()
    if self._myAnswer ~= rightAnswer then
        self._answerPanels[self._myAnswer]:setRight(false)
        self._answerPanels[rightAnswer]:setRight(true)
    else
        self._answerPanels[self._myAnswer]:setRight(true)
    end
    return self._myAnswer == rightAnswer
end

function EventAnswerNode:_onTimer()
    self._leftTimeLabel:setString(G_ServerTime:getLeftSecondsString(self._eventData:getEndTime(), "00:00:00"))
    if not Lang.checkLang(Lang.CN) then
        self:_updatePosByI18n()
    end
end

-- i18n change lable
function EventAnswerNode:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        local image1 = UIHelper.seekNodeByName(self,"BG","Image_29")
    
		UIHelper.swapWithLabel(image1,{
			 style = "explore_1",
			 text = Lang.getImgText("txt_shuijingxuetang01") ,
		})
	end
end

function EventAnswerNode:_dealPosByI18n()
    if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        local rightNode = UIHelper.seekNodeByName(self._resourceNode,"RightNode")
        local wrongNode = UIHelper.seekNodeByName(self._resourceNode,"WrongNode")
        local rightDes = UIHelper.seekNodeByName(rightNode,"Des")
        local wrongDes = UIHelper.seekNodeByName(wrongNode,"Des")
        

        
        rightNode:setPositionX(rightNode:getPositionX() + 4)
		wrongNode:setPositionX(wrongNode:getPositionX() +35)

        rightDes:setPositionX(rightDes:getPositionX() - 22)
		wrongDes:setPositionX(wrongDes:getPositionX() - 16)

        self._talkQuestion:setFontSize(self._talkQuestion:getFontSize()-2)
        self._talkQuestion:setPositionY(
             self._talkQuestion:getPositionY()+6
        )
         self._talkQuestion:setPositionX(
             self._talkQuestion:getPositionX()-7
        )
        local size = self._talkQuestion:getContentSize()
        self._talkQuestion:setContentSize(cc.size(size.width+20,size.height+14))


    end

    
    if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        local image1 = UIHelper.seekNodeByName(self._resourceNode,"BG","Image_29")
        local rightNode = UIHelper.seekNodeByName(self._resourceNode,"RightNode")
        local wrongNode = UIHelper.seekNodeByName(self._resourceNode,"WrongNode")

        local worldPos = image1:convertToWorldSpace(cc.p(0,0))
        local pos1 =  rightNode:convertToNodeSpace(worldPos)
        local pos2 =  wrongNode:convertToNodeSpace(worldPos)
       

        
        local des1 = UIHelper.seekNodeByName(self._resourceNode,"RightNode","Des")
        local des2 = UIHelper.seekNodeByName(self._resourceNode,"WrongNode","Des")
        des1:setAnchorPoint(cc.p(0,0.5))
        des2:setAnchorPoint(cc.p(0,0.5))

        des1:setPositionX(pos1.x)
        
      
        self._rightResIcon:setPositionX(des1:getPositionX()+des1:getContentSize().width+3)
        self._rightResSize:setAnchorPoint(cc.p(0,0.5))
        self._rightResSize:setPositionX(self._rightResIcon:getPositionX()+self._rightResIcon:getContentSize().width+3)

        des2:setPositionX(self._rightResSize:getPositionX() + 30 )
        self._wrongResIcon:setPositionX(des2:getPositionX()+des2:getContentSize().width+3)
        self._wrongResSize:setAnchorPoint(cc.p(0,0.5))
        self._wrongResSize:setPositionX(self._wrongResIcon:getPositionX()+self._wrongResIcon:getContentSize().width+3)

        if Lang.checkLang(Lang.JA) then
            image1:setPositionX(image1:getPositionX()-40)
        end
    end

end

function EventAnswerNode:_updatePosByI18n()
    if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        local image1 = UIHelper.seekNodeByName(self._countDownNode,"Image_27")
        local image2 = UIHelper.seekNodeByName(self._countDownNode,"Image_33")
        local textActTimeLabel = UIHelper.seekNodeByName(self._countDownNode,"TextActTimeLabel")
        UIHelper.alignCenter(image1,{image2,textActTimeLabel,self._leftTimeLabel})
    end
end


function EventAnswerNode:_updateRightWrongPosByI18n()
    if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
  
        local rightNode = UIHelper.seekNodeByName(self._resourceNode,"RightNode")
        local wrongNode = UIHelper.seekNodeByName(self._resourceNode,"WrongNode")
       

        local des1 = UIHelper.seekNodeByName(self._resourceNode,"RightNode","Des")
        local des2 = UIHelper.seekNodeByName(self._resourceNode,"WrongNode","Des")
    

        UIHelper.alignCenter(self._talkQuestion,{des1,self._rightResIcon,self._rightResSize,des2,self._wrongResIcon,self._wrongResSize},{5,5,20,5,5,0})
        if Lang.checkUI("ui4") then
            local talk = UIHelper.seekNodeByName(self._resourceNode,"Talk")
            UIHelper.alignCenter(talk,{des1,self._rightResIcon,self._rightResSize,des2,self._wrongResIcon,self._wrongResSize},{5,5,20,5,5,0})
        end
    end
end

--i18n
function EventAnswerNode:_createQuestionByI18n()
    if not Lang.checkUI("ui4") then
        return
    end
    local UIHelper  = require("yoka.utils.UIHelper")
    local talk = UIHelper.seekNodeByName(self._resourceNode,"Talk")
    local size = talk:getContentSize()
    local addX = 33
    local addY = 33
    talk:setScale9Enabled(true)
    talk:setCapInsets(cc.rect(81,35,221,49))
    talk:setContentSize(cc.size(size.width+addX,size.height+addY))

    local listView = ccui.ListView:create()
    listView:setScrollBarEnabled(false)
    listView:setSwallowTouches(false)
    listView:setAnchorPoint(cc.p(0, 1))
    local offsetX = 30
    local offsetY = 25
    listView:setPosition(cc.p(offsetX, size.height+addY-offsetY))
    listView:setDirection(ccui.ScrollViewDir.vertical)
    listView:setContentSize(cc.size(size.width+addX-offsetX*2,size.height+addY-offsetY*2))
    talk:addChild(listView)
    local render = self._talkQuestion:getVirtualRenderer()
    render:setMaxLineWidth(size.width+addX-offsetX*2)
    self._talkQuestion:ignoreContentAdaptWithSize(true)
    self._listView = listView
end

--i18n
function EventAnswerNode:_updateQuestionByI18n()
    if not Lang.checkUI("ui4") then
        return
    end
    self._listView:removeAllChildren()
    local render = self._talkQuestion:getVirtualRenderer()
    local size = render:getContentSize()
    self._talkQuestion:removeSelf()
    local widget = ccui.Widget:create()
    local widgetSize = cc.size(size.width, size.height)
    widget:setContentSize(widgetSize)
    self._talkQuestion:setPosition(0,size.height)
    widget:addChild(self._talkQuestion)
    self._listView:pushBackCustomItem(widget)
    self._listView:doLayout()
end

return EventAnswerNode
