--
-- Author: Liangxu
-- Date: 2017-03-01 14:18:22
-- 武将详情 觉醒模块
local ListViewCellBase = require("app.ui.ListViewCellBase")
local HeroDetailAwakeModule = class("HeroDetailAwakeModule", ListViewCellBase)
local CSHelper = require("yoka.utils.CSHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local HeroConst = require("app.const.HeroConst")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local FunctionConst = require("app.const.FunctionConst")

function HeroDetailAwakeModule:ctor(heroUnitData, rangeType)
	self._heroUnitData = heroUnitData
	self._rangeType = rangeType

	local resource = {
		file = Path.getCSB("HeroDetailDynamicModule", "hero"),
		binding = {

		},
	}
	HeroDetailAwakeModule.super.ctor(self, resource)
end

function HeroDetailAwakeModule:onCreate()
	local title = self:_createTitle()
	self._listView:pushBackCustomItem(title)

	local desInfo = UserDataHelper.getHeroAwakeTalentDesInfo(self._heroUnitData)
	for i, info in ipairs(desInfo) do
		local des = self:_createDes(info, i)
		self._listView:pushBackCustomItem(des)
	end

	self._listView:doLayout()
	local contentSize = self._listView:getInnerContainerSize()
	self._listView:setContentSize(contentSize)
	self:setContentSize(contentSize)
end

function HeroDetailAwakeModule:_createTitle()
	local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitleWithBg", "common"))
	if Lang.checkUI("ui4") then -- i18n ja change
        ccui.Helper:seekNodeByName(title, "ImageBase"):loadTexture(Path.getTextTeam("img_zr_di03"))
		ccui.Helper:seekNodeByName(title, "ImageBase"):setContentSize(cc.size(398, 37))  
		self._listView:removeBackGroundImage() 	
	end
	title:setFontSize(24)
	title:setTitle(Lang.get("hero_detail_title_awake"))
	local widget = ccui.Widget:create()
	local titleSize = cc.size(402, 36)
	local widgetSize = cc.size(402, 36 + 10)
	widget:setContentSize(widgetSize)
	title:setPosition(titleSize.width / 2, titleSize.height / 2 + 7)
	widget:addChild(title)

	return widget
end

function HeroDetailAwakeModule:_createDes(info, index)
	local widget = ccui.Widget:create()
	local isActive = info.isActive
	local desColor = isActive and Colors.BRIGHT_BG_GREEN or Colors.BRIGHT_BG_TWO

	local name = "[觉醒天赋"..index.."]"
	if not Lang.checkLang(Lang.CN) then
		name ="[".. Lang.getImgText("awake_talent") ..index.."]"
	end
	local des = info.des
	local labelName = cc.Label:createWithTTF(name, Path.getCommonFont(), 20)
	labelName:setAnchorPoint(cc.p(0, 1))
	labelName:setLineHeight(30)
	labelName:setWidth(125)
	labelName:setColor(desColor)

	local labelDes = cc.Label:createWithTTF(des, Path.getCommonFont(), 20)
	labelDes:setAnchorPoint(cc.p(0, 1))
	labelDes:setWidth(250)
	labelDes:setLineHeight(30)
	labelDes:setColor(desColor)

	local height = labelDes:getContentSize().height

	if not Lang.checkLang(Lang.CN) then
		labelName:setWidth(125+18)
		height = math.max(height,labelName:getContentSize().height)
	end
	
	if not Lang.checkLang(Lang.CN) then
		labelName:setPosition(cc.p(24 - 6, height + 10))
		labelDes:setPosition(cc.p(145 + 12, height + 10))
	else
		labelName:setPosition(cc.p(24, height + 10))
		labelDes:setPosition(cc.p(145, height + 10))
	end
	
	widget:addChild(labelName)
	widget:addChild(labelDes)
 
	
	local size = cc.size(402, height + 10)
	widget:setContentSize(size)

	return widget
end

--i18n
function HeroDetailAwakeModule:_createDesI18n(info, index)
	local widget = ccui.Widget:create()
	local isActive = info.isActive
	local desColor = isActive and Colors.BRIGHT_BG_GREEN or Colors.BRIGHT_BG_TWO

	local des = "[".. Lang.getImgText("awake_talent") ..index.."]"..info.des
	local labelDes = cc.Label:createWithTTF(des, Path.getCommonFont(), 20)
	labelDes:setAnchorPoint(cc.p(0, 1))
	labelDes:setWidth(375)
	labelDes:setLineHeight(30)
	labelDes:setColor(desColor)
	local height = labelDes:getContentSize().height
	labelDes:setPosition(cc.p(14, height + 10))

	widget:addChild(labelDes)
	
	local size = cc.size(402, height + 10)
	widget:setContentSize(size)

	return widget
end

return HeroDetailAwakeModule