
local ListViewCellBase = require("app.ui.ListViewCellBase")
local UIHelper  = require("yoka.utils.UIHelper")
local CSHelper = require("yoka.utils.CSHelper")
local CommonConst = require("app.const.CommonConst")
local CustomActivityConst = require("app.const.CustomActivityConst")
local LateRegistItemCell = class("LateRegistItemCell", ListViewCellBase)
local TextHelper = require("app.utils.TextHelper")

 LateRegistItemCell.LINE_ITEM_NUM = 1


 LateRegistItemCell.ITEM_GAP = 106--奖励道具之间的间隔
 LateRegistItemCell.ITEM_ADD_GAP = 132--+道具之间的间隔
 LateRegistItemCell.ITEM_OR_GAP = 132--可选奖励道具之间间隔

function LateRegistItemCell:ctor()
	self._commonRewardListNode  = nil --奖励列表
	self._commonButtonLargeNormal  = nil--领取按钮
    self._textTaskDes = nil--任务描述
	self._nodeProgress = nil--进度富文本的父节点

	self._callback = nil

	self:_initUI()
end

function LateRegistItemCell:_initUI()
	local bgSize = cc.size(924,164)
	local bg = UIHelper.createImage({texture = Path.getUICommon("img_com_board04") })
	bg:setScale9Enabled(true)
	bg:setCapInsets(cc.rect(13,13,1,1))
	bg:setContentSize(bgSize)
	bg:setAnchorPoint(0,0)
	self:addChild(bg)

	local upBg = UIHelper.createImage({texture = Path.getUICommon("img_com_title05") })
	upBg:setScale9Enabled(true)
	upBg:setCapInsets(cc.rect(200,15,1,1))
	upBg:setContentSize(cc.size(bgSize.width-4,41))
	upBg:setAnchorPoint(0,1)
	upBg:setPosition(2,162)
	bg:addChild(upBg)

	self._commonRewardListNode = CSHelper.loadResourceNode( Path.getCSB("CommonRewardListNode", "common"))
	self._commonRewardListNode:setPosition(64,64)
	bg:addChild(self._commonRewardListNode)

	self._textTaskDes = UIHelper.createLabel({
		text = "",
		position = cc.p(17,141),
		color = cc.c3b(0xb7, 0x63, 0x18),
		size = 22,
		anchorPoint = cc.p(0,0.5)
	})
	bg:addChild(self._textTaskDes)

	self._commonButtonLargeNormal = CSHelper.loadResourceNode( Path.getCSB("CommonButtonLevel1Highlight", "common"))
	self._commonButtonLargeNormal:setPosition(bgSize.width-84,64)
	bg:addChild(self._commonButtonLargeNormal)
	self._commonButtonLargeNormal:addClickEventListenerEx(handler(self, self._onTouchCallBack))

	self._imageReceive = UIHelper.createImage({texture = Path.getTextSignet("img_common_lv") })
	self._imageReceive:setPosition(bgSize.width-82,60)
	bg:addChild(self._imageReceive)
	local size = self._imageReceive:getContentSize()
	local textReceive = UIHelper.createLabel({
		text = Lang.getImgText("txt_yilingqu02"),
		position = cc.p(size.width*0.5,size.height*0.5),
		style = "signet_8",
		anchorPoint = cc.p(0.5,0.5)
	})
	textReceive:setRotation(-10)
	self._imageReceive:addChild(textReceive)

	self._nodeProgress = display.newNode():addTo(bg)
	self._nodeProgress:setPosition(bgSize.width-24,142)

	self:setContentSize(bgSize.width, bgSize.height)
	self._commonButtonLargeNormal:setSwallowTouches(false)
end

function LateRegistItemCell:onClickBtn()
    if self._callback then
        self._callback(self)
    end

    self:_onItemClick(self)
end

function LateRegistItemCell:_onItemClick(sender)
	local curSelectedPos = sender:getTag()
	logWarn("LateRegistItemCell:_onIconClicked  "..curSelectedPos)
	self:dispatchCustomCallback(curSelectedPos)
end


function LateRegistItemCell:_onTouchCallBack(sender,state)
	-----------防止拖动的时候触发点击
	if(state == ccui.TouchEventType.ended) or not state then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
		if moveOffsetX < 20 and moveOffsetY < 20 then
			self:onClickBtn()
		end
	end

end

function LateRegistItemCell:onClickItem(sender)
	local tag = self:getTag()
end

function LateRegistItemCell:_updateRewards(data)
	local fixRewards = data:getRewardItems()
	local rewardNum = #fixRewards
	local rewards = {}
    local rewardTypes = {}
    for i = 1,rewardNum,1 do
		rewards[i] = fixRewards[i]
		rewardTypes[i] = CustomActivityConst.REWARD_TYPE_ALL
    end
    self._commonRewardListNode:setGaps(LateRegistItemCell.ITEM_GAP,LateRegistItemCell.ITEM_ADD_GAP ,
        LateRegistItemCell.ITEM_OR_GAP)
    self._commonRewardListNode:updateInfo(rewards,rewardTypes)
end

--创建富文本
function LateRegistItemCell:_createProgressRichText(richText)
	self._nodeProgress:removeAllChildren()
    local widget = ccui.RichText:createWithContent(richText)
    widget:setAnchorPoint(cc.p(1,0.5))
    self._nodeProgress:addChild(widget)
end

function LateRegistItemCell:updateInfo(data)
    local reachReceiveCondition = data:isReachReceiveCondition()
    local canReceive = data:isCanReceive()
    local buttonTxt = data:getButtonTxt()
	local taskDes = data:getDescription()
	local progressTitle = data:getProgressTitle()
	local value01,value02,onlyShowMax = data:getProgressValue()
    local notShowProgress =  data:getShowRate() ~= CommonConst.TRUE_VALUE

	--奖励
    self:_updateRewards(data)
    --任务条件
	self._textTaskDes:setString(taskDes)

	--刷新进度
    self._nodeProgress:setVisible(not notShowProgress)
	if not notShowProgress then
		if onlyShowMax then
			local richText = Lang.get("customactivity_task_progress_03",
			{title = progressTitle,max = TextHelper.getAmountText2(value02)})
			self:_createProgressRichText(richText)
		elseif reachReceiveCondition then
			local richText = Lang.get("customactivity_task_progress_02",
				{title = progressTitle,curr = TextHelper.getAmountText2(value01),max = TextHelper.getAmountText2(value02)})
			self:_createProgressRichText(richText)
		else
			--不满条件
			local richText = Lang.get("customactivity_task_progress_01",
			{title = progressTitle,curr = TextHelper.getAmountText2(value01),max = TextHelper.getAmountText2(value02)})
			self:_createProgressRichText(richText)
		end
	end


    --按钮和领取标记
    self._commonButtonLargeNormal:setVisible(true)
    self._commonButtonLargeNormal:setEnabled(true)
    self._commonButtonLargeNormal:setString(buttonTxt)
    self._imageReceive:setVisible(false)
    if reachReceiveCondition then
		if canReceive then
            --可领取
            self._commonButtonLargeNormal:setString(Lang.get("days7activity_btn_receive"))
		else--已经领取了
			 self._commonButtonLargeNormal:setString(Lang.get("days7activity_btn_already_receive"))
			 -- self._commonButtonLargeNormal:setEnabled(false)
             self._commonButtonLargeNormal:setVisible(false)
             self._imageReceive:setVisible(true)
		end
	else
		self._commonButtonLargeNormal:setEnabled(false)
    end
end


function LateRegistItemCell:setCallBack(callback)
	if callback then
		self._callback = callback
	end
end

return LateRegistItemCell
