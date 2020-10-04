
-- Author: liangxu
-- Date:2019-3-7
-- Describle：

local ViewBase = require("app.ui.ViewBase")
local GroupsTipBar = class("GroupsTipBar", ViewBase)

function GroupsTipBar:ctor()
	local resource = {
		file = Path.getCSB("GroupsMainNode", "groups"),
		binding = {
			_btnCancel = {
				events = {{event = "touch", method = "onBtnCancel"}}
			},
			_btnOk = {
				events = {{event = "touch", method = "onBtnOk"}}
			},
		},
	}
	GroupsTipBar.super.ctor(self, resource)
end

function GroupsTipBar:onCreate()
	if not Lang.checkLang(Lang.CN) then
		self:_createLabelByI18n()
	end

	self._rootY = 0

	self._btnCancel:setString(Lang.get("groups_refuse"))
	self._btnOk:setString(Lang.get("groups_accept"))
	self._checkBoxTip:addEventListener(handler(self, self.onCheckBoxClicked))

	local sceneSize = self:getSceneSize()
	local noteSize = self._panelRoot:getContentSize()
	self._rootX = self._panelRoot:getPositionX()
	self._rootY = sceneSize.height - noteSize.height - 66
	self._panelRoot:setPositionY(self._rootY)
end

function GroupsTipBar:onEnter()
	
end

function GroupsTipBar:onExit()

end

function GroupsTipBar:_checkFilter(filterNames)
	filterNames = filterNames or {}
	local runningScene = G_SceneManager:getRunningScene()
	local sceneName = runningScene:getName()
	for i, filterName in ipairs(filterNames) do
		if sceneName == filterName then
			return true
		end
	end
	return false
end

function GroupsTipBar:slideOut(data, filterViewNames)
	if self:_checkFilter(filterViewNames) then
		return
	end
	G_TopLevelNode:addToGroupNoticeLayer(self)
	self:_updateUI(data)
	self:_moveOut()
end

function GroupsTipBar:_updateUI(data)
	local show = data.showImageTips or false
	self._imageTips:setVisible(show)
	if data.imageRes then
		-- i18n change to lable
		if  Lang.checkLang(Lang.CN) then
			self._imageInvite:loadTexture(data.imageRes)
		else
			local UIHelper  = require("yoka.utils.UIHelper")
			UIHelper.setSignStyle(self._imageInvite,{
				style = data.style,
				text =  data.text,
			},data.imageRes)
		end
	end
	if data.name then
		self._leaderName:setString(data.name)
	end
	if data.nameColor then
		self._leaderName:setColor(data.nameColor)
	end
	if data.targetName then
		self._targetName:setString(data.targetName)
	end
	if data.covertId then
		self._icon:updateUI(data.covertId, nil, data.limitLevel)
	end
	if data.headFrameId then
		self._headFrame:updateUI(data.headFrameId,self._icon:getScale())
	end
	if data.level then
		self._headFrame:setLevel(data.level)
	end
	if data.endTime then-- i18n pos lable
		self._btnCancel:startCountDown(data.endTime, handler(self, self._countDownEnd), handler(self, self._countDownFormatStr),true)
	end
	if data.imageBg then
		self._imageBg:loadTexture(data.imageBg)
	end

end

function GroupsTipBar:_countDownEnd()
	self:closeWindow()
end

function GroupsTipBar:_countDownFormatStr(endTime)
	local time = G_ServerTime:getLeftSeconds(endTime)
	local str = ""
	if time < 10 then 
		str = " " 
	end
	str = str .. time .. "s"
	return str
end

function GroupsTipBar:_moveOut()
	local sceneSize = self:getSceneSize()
	local noteSize = self._panelRoot:getContentSize()
	local posX = sceneSize.width - noteSize.width
	local posY = self._rootY
	local callAction = cc.CallFunc:create(function()

	end)
	local action = cc.MoveTo:create(0.3,cc.p(posX,posY))
	local runningAction = cc.Sequence:create(action,callAction)
	self._panelRoot:runAction(runningAction)
end

function GroupsTipBar:closeWindow()
	local sceneSize = self:getSceneSize()
	local posX = sceneSize.width + 10
	local callAction = cc.CallFunc:create(function()
		self:removeFromParent()
	end)
	local action = cc.MoveBy:create(0.3,cc.p(posX,0))
	local runningAction = cc.Sequence:create(action,callAction)
	self._panelRoot:runAction(runningAction)
end

function GroupsTipBar:onBtnCancel()
	
end

function GroupsTipBar:onBtnOk()
	
end

function GroupsTipBar:onCheckBoxClicked()
	
end

-- i18n change to lable
function GroupsTipBar:_createLabelByI18n()
	if Lang.checkChannel(Lang.CHANNEL_SEA) then
		local size = self._imageBg:getContentSize()
		self._imageBg:setContentSize(cc.size(size.width,126))
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imageInvite = UIHelper.swapSignImage(self._imageInvite,{
			style = "qintomb_7",
			text =  Lang.getImgText("img_qintomb_shouye2"),
			anchorPoint = cc.p(0,0.5),
			position = cc.p(15 ,18)
		},Path.getQinTomb("img_qintomb_shouye2"))
		self._imageInvite:setPosition(215,108)
		self._headFrame:setPositionX(self._headFrame:getPositionX()-35)
		self._icon:setPositionX(self._icon:getPositionX()-35)
		self._leaderName:setPositionX(self._leaderName:getPositionX()-35)
		self._targetName:setPositionX(self._targetName:getPositionX()-35)
	elseif not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local size = self._imageInvite:getContentSize()
		self._imageInvite = UIHelper.swapSignImage(self._imageInvite,{
			style = "qintomb_7",
			text =  Lang.getImgText("img_qintomb_shouye2"),
			h_align = cc.TEXT_ALIGNMENT_CENTER ,
			position = cc.p(size.width * 0.5 -3 ,size.height * 0.5)
		},Path.getQinTomb("img_qintomb_shouye2"))

	end
end


return GroupsTipBar