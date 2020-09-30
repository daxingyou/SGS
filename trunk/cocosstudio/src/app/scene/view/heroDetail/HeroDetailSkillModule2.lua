--
-- Author: Liangxu
-- Date: 2017-03-01 19:49:34
-- 武将详情 技能模块
-- i18n ja add Lua
local ListViewCellBase = require("app.ui.ListViewCellBase")
local HeroDetailSkillModule = class("HeroDetailSkillModule", ListViewCellBase)
local HeroDetailSkillCell = require("app.scene.view.heroDetail.HeroDetailSkillCell2")
local CSHelper = require("yoka.utils.CSHelper")

function HeroDetailSkillModule:ctor(skillIds)
	self._skillIds = skillIds

	local resource = {
		file = Path.getCSB("HeroDetailDynamicModule2", "hero"),
		binding = {

		},
	}

	HeroDetailSkillModule.super.ctor(self, resource)
end

function HeroDetailSkillModule:onCreate()
	local title = self:_createTitle()
	self._listView:pushBackCustomItem(title)

	for i, skillId in ipairs(self._skillIds) do
		local cell = HeroDetailSkillCell.new(skillId)
		self._listView:pushBackCustomItem(cell)
	end

	self._listView:doLayout()
	local contentSize = self._listView:getInnerContainerSize()
	self._listView:setContentSize(contentSize)
	self:setContentSize(contentSize)
end

function HeroDetailSkillModule:_createTitle()
	local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitleWithBg2", "common")) --"CommonDetailTitleWithBg1", "common")) 为了减少修改使用
	title:setTitle(Lang.get("hero_detail_title_skill"))
	title:setFontSize(22)
 
	local widget = ccui.Widget:create()
	local titleSize = cc.size(326, 41)
	widget:setContentSize(titleSize)
	title:setPosition(titleSize.width / 2, titleSize.height / 2)
	widget:addChild(title)



	return widget
end

return HeroDetailSkillModule