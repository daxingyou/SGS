-- Author: conley
--单笔充值
local ListViewCellBase = require("app.ui.ListViewCellBase")
local CSHelper = require("yoka.utils.CSHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")
local CommonConst = require("app.const.CommonConst")
local CustomActivityConst = require("app.const.CustomActivityConst")
local CarnivalActivitySingleRechargeItemCell = class("CarnivalActivitySingleRechargeItemCell", ListViewCellBase)
local TextHelper = require("app.utils.TextHelper")

 CarnivalActivitySingleRechargeItemCell.LINE_ITEM_NUM = 1


 CarnivalActivitySingleRechargeItemCell.ITEM_GAP = 106--奖励道具之间的间隔
 CarnivalActivitySingleRechargeItemCell.ITEM_ADD_GAP = 132--+道具之间的间隔
 CarnivalActivitySingleRechargeItemCell.ITEM_OR_GAP = 132--可选奖励道具之间间隔
 CarnivalActivitySingleRechargeItemCell.SCROLL_WIDTH = 582 --滚动距离
 
function CarnivalActivitySingleRechargeItemCell:ctor()
	self._commonRewardListNode  = nil --奖励列表
	self._commonButtonLargeNormal  = nil--领取按钮
    self._textTaskDes = nil--任务描述
	self._nodeProgress = nil--进度富文本的父节点

	self._callback = nil
    self._data = data

	local resource = {
		file = Path.getCSB("CarnivalActivitySingleRechargeItemCell", "carnivalActivity"),
		binding = {
			_commonButtonLargeNormal = {
				events = {{event = "touch", method = "_onTouchCallBack"}}
			}
		},
	}
	CarnivalActivitySingleRechargeItemCell.super.ctor(self,resource)
end

function CarnivalActivitySingleRechargeItemCell:onCreate()
	-- i18n change lable
	self:_swapImageByI18n()

    local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
	self._commonButtonLargeNormal:setSwallowTouches(false)
end

function CarnivalActivitySingleRechargeItemCell:onClickBtn()
    if self._callback then
        self._callback(self)
    end

    self:_onItemClick(self)
end

function CarnivalActivitySingleRechargeItemCell:_onItemClick(sender)
	local curSelectedPos = sender:getTag()
	logWarn("CarnivalActivitySingleRechargeItemCell:_onIconClicked  "..curSelectedPos)
	self:dispatchCustomCallback(curSelectedPos,self._data)
end


function CarnivalActivitySingleRechargeItemCell:_onTouchCallBack(sender,state)
	-----------防止拖动的时候触发点击
	if(state == ccui.TouchEventType.ended) or not state then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
		if moveOffsetX < 20 and moveOffsetY < 20 then
			self:onClickBtn()
		end
	end

end

function CarnivalActivitySingleRechargeItemCell:onClickItem(sender)
	local tag = self:getTag()
end

function CarnivalActivitySingleRechargeItemCell:_updateRewards(actTaskUnitData)
    local fixRewards = actTaskUnitData:getRewardItems()
	local selectRewards = actTaskUnitData:getSelectRewardItems()
	local rewardNum = #fixRewards + #selectRewards
	local rewards = {}
    local rewardTypes = {}
    for i = 1,rewardNum,1 do
         if i <= #fixRewards then
		 	rewards[i] = fixRewards[i]
		 	rewardTypes[i] = CustomActivityConst.REWARD_TYPE_ALL
         else
		 	rewards[i] = selectRewards[i-#fixRewards]
            rewardTypes[i] = CustomActivityConst.REWARD_TYPE_SELECT
         end
    end

	if not Lang.checkLang(Lang.CN) then
		self._commonRewardListNode:setGaps(CarnivalActivitySingleRechargeItemCell.ITEM_GAP,CarnivalActivitySingleRechargeItemCell.ITEM_ADD_GAP ,
			152, CarnivalActivitySingleRechargeItemCell.SCROLL_WIDTH)
	else
    self._commonRewardListNode:setGaps(CarnivalActivitySingleRechargeItemCell.ITEM_GAP,CarnivalActivitySingleRechargeItemCell.ITEM_ADD_GAP ,
        CarnivalActivitySingleRechargeItemCell.ITEM_OR_GAP, CarnivalActivitySingleRechargeItemCell.SCROLL_WIDTH)
	end

    self._commonRewardListNode:updateInfo(rewards,rewardTypes)
end

--创建富文本
function CarnivalActivitySingleRechargeItemCell:_createProgressRichText(richText)
	self._nodeProgress:removeAllChildren()
    local widget = ccui.RichText:createWithContent(richText)
    widget:setAnchorPoint(cc.p(0.5,0.5))
    self._nodeProgress:addChild(widget)
end

function CarnivalActivitySingleRechargeItemCell:updateInfo(data)
    self._data = data
	local customActTaskUnitData = data.actTaskUnitData
    local activityUnitData = data.actUnitData
    local reachReceiveCondition = data.reachReceiveCondition
	local hasReceive = data.hasReceive
    local canReceive = data.canReceive
    local hasLimit = data.hasLimit
    local timeLimit = data.timeLimit
    local buttonTxt = customActTaskUnitData:getButtonTxt()
	local taskDes = customActTaskUnitData:getDescription()
	local progressTitle = customActTaskUnitData:getProgressTitle()
	local value01,value02,onlyShowMax = customActTaskUnitData:getProgressValue()
    local functionId = customActTaskUnitData:getQuestNotFinishJumpFunctionID()
    local notShowProgress =  activityUnitData:getShow_schedule() ~= CommonConst.TRUE_VALUE

	--奖励
    self:_updateRewards(customActTaskUnitData)
    --任务条件
	self._textTaskDes:setString(taskDes)

	--刷新进度
    self._nodeProgress:setVisible(not notShowProgress)
	if not notShowProgress then
		if onlyShowMax then
			local richText = Lang.get("customactivity_task_progress_03",
			{title = progressTitle,max = TextHelper.getAmountText2(value02)})
			if not Lang.checkLang(Lang.CN) then
				local UIHelper = require("yoka.utils.UIHelper")
				local _,currency02 =  UIHelper.convertCurrency(value02)
				richText =  Lang.get("customactivity_task_progress_03",{title = progressTitle,max = currency02})
			end

			self:_createProgressRichText(richText)
		elseif value01 > 0 then
			local richText = Lang.get("customactivity_task_progress_02",
				{title = progressTitle,curr = TextHelper.getAmountText2(value01),max = TextHelper.getAmountText2(value02)})

			if not Lang.checkLang(Lang.CN) then
				local UIHelper = require("yoka.utils.UIHelper")
				local _,currency01 =  UIHelper.convertCurrency(value01)	
				local _,currency02 =  UIHelper.convertCurrency(value02)
				richText =  Lang.get("customactivity_task_progress_02",{title = progressTitle,curr = currency01,max = currency02})
			end

			self:_createProgressRichText(richText)
		else
			--不满条件
			local richText = Lang.get("customactivity_task_progress_01",
			{title = progressTitle,curr = TextHelper.getAmountText2(value01),max = TextHelper.getAmountText2(value02)})

			if not Lang.checkLang(Lang.CN) then
				local UIHelper = require("yoka.utils.UIHelper")
				local _,currency01 =  UIHelper.convertCurrency(value01)	
				local _,currency02 =  UIHelper.convertCurrency(value02)
				richText = Lang.get("customactivity_task_progress_01",{title = progressTitle,curr = currency01,max = currency02})
			end
			self:_createProgressRichText(richText)
		end
	end


    --按钮和领取标记
    self._commonButtonLargeNormal:setVisible(true)
    self._commonButtonLargeNormal:setEnabled(true)
    self._commonButtonLargeNormal:setString(buttonTxt)
	self._commonButtonLargeNormal:switchToNormal()
    self._imageReceive:setVisible(false)


    if canReceive then --可领取
        self._commonButtonLargeNormal:setString(Lang.get("days7activity_btn_receive"))
    elseif hasReceive then--已经领取
		self._commonButtonLargeNormal:setVisible(false)
		self._imageReceive:setVisible(true)
    elseif hasLimit or timeLimit then--次数限制，活动当前只是预览     
		self._commonButtonLargeNormal:setEnabled(false)
    else--条件不满足
        if functionId ~= 0 or activityUnitData:getQuest_type() == CustomActivityConst.CUSTOM_QUEST_TYPE_PAY_SELL_ITEM then
			--要跳转
			self._commonButtonLargeNormal:switchToHightLight()
		else
			self._commonButtonLargeNormal:setEnabled(false)
		end
    end

end


function CarnivalActivitySingleRechargeItemCell:setCallBack(callback)
	if callback then
		self._callback = callback
	end
end


-- i18n change lable
function CarnivalActivitySingleRechargeItemCell:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")	
        self._imageReceive = UIHelper.swapSignImage(self._imageReceive,
		{ 
			 style = "signet_8", 
			 text = Lang.getImgText("txt_yilingqu02") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))

	end
end




return CarnivalActivitySingleRechargeItemCell
