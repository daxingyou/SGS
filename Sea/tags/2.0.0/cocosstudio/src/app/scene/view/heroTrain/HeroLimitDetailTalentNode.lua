local ListViewCellBase = require("app.ui.ListViewCellBase")
local HeroLimitDetailTalentNode = class("HeroLimitDetailTalentNode", ListViewCellBase)
local CSHelper = require("yoka.utils.CSHelper")
local HeroDataHelper = require("app.utils.data.HeroDataHelper")

function HeroLimitDetailTalentNode:ctor(heroUnitData, limitLevel1, limitLevel2)
	self._heroUnitData = heroUnitData
	self._limitLevel1 = limitLevel1
	self._limitLevel2 = limitLevel2

	HeroLimitDetailTalentNode.super.ctor(self)
end

function HeroLimitDetailTalentNode:onCreate()
	self._listView = self:_createListView()
	self:addChild(self._listView)

	self._listView1 = self:_createListView()
	self._listView2 = self:_createListView()
	for i = 1, 2 do
		self:_updateSubView(i)
	end

	local widget = ccui.Widget:create()

	local bg1 = self:_createBg()
	local bg2 = self:_createBg()
	widget:addChild(bg1)
	widget:addChild(bg2)

	widget:addChild(self._listView1)
	widget:addChild(self._listView2)
	local height1 = self._listView1:getContentSize().height
	local height2 = self._listView2:getContentSize().height
	local height = math.max(height1, height2)

	local posYListView1 = height1 == height and 0 or height-height1
	local posYListView2 = height2 == height and 0 or height-height2
	local posList1X = 7
	local posList2X = 456+73
	self._listView1:setPosition(cc.p(posList1X, posYListView1))
	self._listView2:setPosition(cc.p(posList2X, posYListView2))
	local size = cc.size(940, height)
	widget:setContentSize(size)

	self._listView:pushBackCustomItem(widget)

	self._listView:doLayout()
	local contentSize = self._listView:getInnerContainerSize()
	contentSize.width = 940
	contentSize.height = contentSize.height + 10
	
	self._listView:setContentSize(contentSize)
	self:setContentSize(contentSize)

	local bgWidth = self._listView1:getContentSize().width
	self:_setBgSize(bg1, cc.size(bgWidth, height1))
	self:_setBgSize(bg2, cc.size(bgWidth, height2))
	bg1:setPosition(cc.p(posList1X, posYListView1))
	bg2:setPosition(cc.p(posList2X, posYListView2))
end

function HeroLimitDetailTalentNode:_createListView()
	local listView = ccui.ListView:create()
	listView:setScrollBarEnabled(false)
	listView:setSwallowTouches(false)
	listView:setAnchorPoint(cc.p(0, 0))
	listView:setPosition(cc.p(0, 0))
	return listView
end

function HeroLimitDetailTalentNode:_updateSubView(index)
	local title = self:_createTitle(index)
	self["_listView"..index]:pushBackCustomItem(title)

	local rankMax = self._heroUnitData:getConfig().rank_max
	local limitLevel = self["_limitLevel"..index]
	for i = 1, rankMax do
		local des = self:_createDes(i, limitLevel)
		if des then
			self["_listView"..index]:pushBackCustomItem(des)
		end
	end
	self["_listView"..index]:doLayout()
	local contentSize = self["_listView"..index]:getInnerContainerSize()
	contentSize.width = 402
	contentSize.height = contentSize.height + 10
	self["_listView"..index]:setContentSize(contentSize)
end

function HeroLimitDetailTalentNode:_createTitle(index)
	local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitleWithBg", "common"))
	title:setFontSize(24)
	title:setTitle(Lang.get("hero_limit_detail_talent_title"))

	local widget = ccui.Widget:create()
	local titleSize = cc.size(402, 34)
	local widgetSize = cc.size(402, 34 + 10)
	widget:setContentSize(widgetSize)
	title:setPosition(201, titleSize.height / 2 + 10)
	widget:addChild(title)

	return widget
end

function HeroLimitDetailTalentNode:_isActiveWithRank(rank)
	local needLimitLevel = HeroDataHelper.getNeedLimitLevelWithRank(rank)
	if needLimitLevel == nil then
		return false, needLimitLevel
	end
	local curLimitLevel = self._heroUnitData:getLimit_level()
	if curLimitLevel >= needLimitLevel then
		return true
	else
		return false, needLimitLevel
	end
end

function HeroLimitDetailTalentNode:_createDes(rank, limitLevel)
	local widget = ccui.Widget:create()
	local isActive = true
	local needLimitLevel = HeroDataHelper.getNeedLimitLevelWithRank(rank)
	if limitLevel == 3 then
		isActive, needLimitLevel = self:_isActiveWithRank(rank)
	end

	local color = Colors.colorToNumber(Colors.BRIGHT_BG_TWO) --Colors.colorToNumber(Colors.BRIGHT_BG_GREEN)

	local baseId = self._heroUnitData:getBase_id()
	local config = HeroDataHelper.getHeroRankConfig(baseId, rank, limitLevel)
	if config == nil then
		return nil
	end

	local name = "["..config.talent_name..rank.."] "
	local des = config.talent_description

	local breakDes = ""
	if limitLevel == 3 and needLimitLevel ~= nil and isActive == false then
		breakDes = Lang.get("hero_limit_txt_break_des", {limit = needLimitLevel})
	end
	local isFeature = config.talent_target == 0 --天赋属性目标为0，标记此行描述为“特性”
	local content = ""
	if isFeature then
		content = Lang.get("hero_limit_talent_des_2", {
			urlIcon = Path.getTextSignet("txt_tianfu_texing"),
			name = name,
			des = des,
			breakDes = breakDes,
			color1 = color,
			color2 = Colors.colorToNumber(Colors.SYSTEM_TARGET_RED),
		})
	else
		content = Lang.get("hero_limit_talent_des_1", {
			name = name,
			des = des,
			breakDes = breakDes,
			color1 = color,
			color2 = Colors.colorToNumber(Colors.SYSTEM_TARGET_RED),
		})
	end

	local label = ccui.RichText:createWithContent(content)
	label:setAnchorPoint(cc.p(0, 1))
	label:ignoreContentAdaptWithSize(false)
	label:setContentSize(cc.size(360,0))
	if Lang.checkLang(Lang.TH) then
		label:setVerticalSpace(10)
	end
	label:formatText()

	local height = label:getContentSize().height
	label:setPosition(cc.p(24, height + 10))
	widget:addChild(label)
 
	local size = cc.size(402, height + 10)
	widget:setContentSize(size)

	return widget
end

function HeroLimitDetailTalentNode:_createBg()
	local node = CSHelper.loadResourceNode(Path.getCSB("TreasureTrainLimitBg", "treasure"))
	return node
end

function HeroLimitDetailTalentNode:_setBgSize(node, size)
	local bg = ccui.Helper:seekNodeByName(node, "Image_1")
	bg:setContentSize(size)
end

return HeroLimitDetailTalentNode