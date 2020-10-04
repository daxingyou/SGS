local SingleRaceGuessTabNode = class("SingleRaceGuessTabNode")

function SingleRaceGuessTabNode:ctor(target, index, callback)
	self._target = target
	self._index = index
	self._callback = callback

	self._imageBg = ccui.Helper:seekNodeByName(self._target, "ImageBg")
	self._imageBg:addClickEventListenerEx(handler(self, self._onClick))
	self._imagePoint = ccui.Helper:seekNodeByName(self._target, "ImagePoint")
	self._textTip = ccui.Helper:seekNodeByName(self._target, "TextTip")
	self._textTip:setString(Lang.get("single_race_guess_tab_title"..index))
	self._imageRP = ccui.Helper:seekNodeByName(self._target, "ImageRP")
	--处理位置
	self:dealPosByI18n()
end

function SingleRaceGuessTabNode:setSelected(selected)
	if selected then
		self._imageBg:loadTexture(Path.getIndividualCompetitiveImg("img_guessing_topic01"))
	else
		self._imageBg:loadTexture(Path.getIndividualCompetitiveImg("img_guessing_topic02"))
	end
end

function SingleRaceGuessTabNode:setVoted(voted)
	self._imagePoint:setVisible(voted)
end

function SingleRaceGuessTabNode:_onClick()
	if self._callback then
		self._callback(self._index)
	end
end

function SingleRaceGuessTabNode:showRP(show)
	self._imageRP:setVisible(show)
end

--更换图片和文本
function SingleRaceGuessTabNode:dealPosByI18n()
	if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.ZH) or Lang.checkLang(Lang.TH) or Lang.checkLang(Lang.ENID) then
	 self._textTip:setAnchorPoint(cc.p(0,0.5))
	 self._textTip:setContentSize(cc.size(230,46))
	 self._textTip:ignoreContentAdaptWithSize(false)
	 -- self._textTip:getVirtualRenderer():setMaxLineWidth(230)
	 -- self._textTip:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_LEFT )
	 -- self._textTip:getVirtualRenderer():setLineBreakWithoutSpace(true)
	 self._textTip:setPositionX(self._textTip:getPositionX()-10)
	 self._imagePoint:setPositionX(self._imagePoint:getPositionX() - 11)
	 self._imagePoint:setPositionY(self._imagePoint:getPositionY() + 1)


 end
end
return SingleRaceGuessTabNode