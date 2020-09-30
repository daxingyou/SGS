local ViewBase = require("app.ui.ViewBase")
local TextHelper = require("app.utils.TextHelper")
local TowerChooseCell = class("TowerChooseCell", ViewBase)

local Path = require("app.utils.Path")

function TowerChooseCell:ctor(layerConfig, difficulty, callback)
	self._layerConfig = layerConfig 	--表格
	self._difficulty = difficulty		--难度
	self._callback = callback			--回调

	--ui
	self._btnFight = nil	--战斗按钮
	-- self._textTitle = nil	--难度文字
	self._starNode1 = nil	--1星面板
	self._starNode2 = nil	--2星面板
	self._starNode3 = nil	--3星面板
	self._btnFight = nil	--战斗按钮
	self._textPower = nil	--推荐战力

	self._reward1 = nil		--奖励1
	self._reward2 = nil		--奖励2

	--
	local filePath = Path.getCSB("TowerChooseCell", "tower")
    if Lang.checkUI("ui4") then
        filePath = Path.getCSB("TowerChooseCell1", "tower")
    end
	local resource = {
		file = filePath,
		size = {1136, 640},
		binding = {
			_btnFight = {
				events = {{event = "touch", method = "_onFightClick"}}
			},
		}
	}
	TowerChooseCell.super.ctor(self, resource)
end

function TowerChooseCell:onCreate()
	-- cc.bind(self._btnFight, "CommonButtonMediumNormal")
    -- self._btnFight:addTouchEventListenerEx(handler(self, self._onFightClick))
    self._btnFight:setString(Lang.get("challenge_button"))
	for i = 1, 3 do
		if i ~= self._difficulty then
			self["_starNode"..i]:setVisible(false)
		else
			self["_starNode"..i]:setVisible(true)
		end		
	end

	local battlePoint = self._layerConfig["team"..self._difficulty.."_combat"]
	self._textPower:setString(TextHelper.getAmountText2(battlePoint)  )

	local drop = require("app.utils.DropHelper").getTowerDrop(self._layerConfig.id, self._difficulty)
	for i = 1, 2 do
		if drop[i] then
			self["_reward"..i]:updateUI(drop[i].type, drop[i].value, drop[i].size)
			-- self["_reward"..i]:showResName(true, Lang.get("challenge_daily_reward"))
		end		
	end

	local titleColor = self._difficulty
	-- local titleBG = Path.getDailyChallengeIcon("img_level0"..titleColor)
	if Lang.checkUI("ui4") then
		local UIHelper  = require("yoka.utils.UIHelper")
		local nodeBG = UIHelper.seekNodeByName(self,"NodeBG")
		local titleBG = Path.getTowerChallengeIcon("img_levelbg0"..titleColor)
		nodeBG:loadTexture(titleBG)
	else
		local titleBG = Path.getTowerChallengeIcon("img_level0"..titleColor)
		self._imageBG:loadTexture(titleBG)
	end

	-- self._textTitle:setString(Lang.get("challenge_tower_difficulty_"..self._difficulty))
    -- local colorInfo = Colors.getDailyChooseColor(titleColor)
    -- self._textTitle:setColor(colorInfo.color)
	-- self._textTitle:enableOutline(colorInfo.outlineColor, 2)

	-- i18n change lable
	self:_createDifficultyLabelByI18n()

		-- i18n change lable
	self:_adjustPosI18n()
end

-- i18n change lable
function TowerChooseCell:_createDifficultyLabelByI18n()
	if not Lang.checkLang(Lang.CN) then
		local TypeConst = require("app.i18n.utils.TypeConst")
		local UIHelper  = require("yoka.utils.UIHelper")
		local size = self._imageBG:getContentSize()
		local label = UIHelper.createLabel({
			style = "challenge_tower_".. self._difficulty,
			styleType = TypeConst.TEXT,
			text = Lang.getImgText("challenge_tower_".. self._difficulty),
			position = cc.p(size.width * 0.5,size.height * 0.5),
			anchorPoint = cc.p(0.5,0.5),
		})
		if Lang.checkUI("ui4") then
			label = UIHelper.createLabel({
				style = "challenge_tower_new_".. self._difficulty,
				text = Lang.getImgText("challenge_tower_".. self._difficulty),
				position = cc.p(size.width * 0.5,size.height * 0.5),
				anchorPoint = cc.p(0.5,0.5),
			})
		end
		self._imageBG:addChild(label)
	end
end

function TowerChooseCell:_onFightClick(sender, event)
	-- if event == 2 then
		if self._callback then
			self._callback(self._difficulty)
		end
	-- end
end



-- i18n change lable
function TowerChooseCell:_adjustPosI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")

		self._reward1:setPositionX(self._reward1:getPositionX()+10)
		self._reward2:setPositionX(self._reward2:getPositionX()+10)

		local nodeBG = UIHelper.seekNodeByName(self,"NodeBG")
		local textPower = UIHelper.seekNodeByName(nodeBG,"TextPower")

		local size = nodeBG:getContentSize()
		local size1 = textPower:getContentSize()
		local size2 = self._textPower:getContentSize()
		
		textPower:setPositionX(size.width * 0.5-size2.width*0.5)
		self._textPower:setPositionX(size.width * 0.5+size1.width*0.5)
		if Lang.checkUI("ui4") then
			textPower:setPositionX(size.width * 0.5-size2.width*0.5-5)
            self._textPower:setPositionX(size.width * 0.5+size1.width*0.5+5)
        end
	end
end

return TowerChooseCell