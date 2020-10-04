-- Author: conley
-- Date:2018-11-23 17:08:00
-- @Rebuild by Panhoa
-- Describle：

local ViewBase = require("app.ui.ViewBase")
local HistoryHeroAttrLayer = class("HistoryHeroAttrLayer", ViewBase)
local HistoryHeroDataHelper = require("app.utils.data.HistoryHeroDataHelper")
local HistoryHeroDetailAttrModule = require("app.scene.view.historyhero.HistoryHeroDetailAttrModule")
local HistoryHeroDetailSkillModule = require("app.scene.view.historyhero.HistoryHeroDetailSkillModule")


function HistoryHeroAttrLayer:ctor()
	self._propertyNode = nil

	local resource = {
		file = Path.getCSB("HistoryHeroAttrLayer", "historyhero"),

	}
	HistoryHeroAttrLayer.super.ctor(self, resource)
end

function HistoryHeroAttrLayer:onCreate()
	self._listViewContentSize = self._listView:getContentSize()
end

function HistoryHeroAttrLayer:onEnter()
end

function HistoryHeroAttrLayer:onExit()
end

function HistoryHeroAttrLayer:setNodeVisible(bVisible)
	self._propertyNode:setVisible(bVisible)
end

-- @Role 	适配详情界面
function HistoryHeroAttrLayer:updateScrollHeight()
	self._listView:setContentSize(self._listViewContentSize.width, self._listViewContentSize.height - 53)
end

-- @Role
function HistoryHeroAttrLayer:updateUI(data)
	if data == nil then
		return
	end

	self._listView:removeAllChildren()
	self:_updateAttrModule(data:getSystem_id(), data:getBreak_through())
	self:_updateSkillDesc(data:getSystem_id(), data:getBreak_through())
end

-- @Role 
function HistoryHeroAttrLayer:updateUIForNoraml(systemId)
	if systemId == nil then
		return
	end

	self._listView:removeAllChildren()
	self:_updateAttrModule(systemId, 1)
	self:_updateSkillDesc(systemId, 1)
end

-- @Role
function HistoryHeroAttrLayer:_updateAttrModule(baseId, breakthrough)
	local stepCfg = HistoryHeroDataHelper.getHistoryHeroStepByHeroId(baseId, breakthrough)
	if stepCfg == nil then
		return
	end
	local attrModule = HistoryHeroDetailAttrModule.new()
	self._listView:pushBackCustomItem(attrModule)
	attrModule:updateUI(stepCfg)
end

-- @Role
function HistoryHeroAttrLayer:_updateSkillDesc(baseId, breakthrough)
	local skilist = HistoryHeroDataHelper.getHistoricalSkills(baseId)
	if #skilist > 0 then
		local skillModule = HistoryHeroDetailSkillModule.new(skilist, breakthrough)
		self._listView:pushBackCustomItem(skillModule)
	end
end


return HistoryHeroAttrLayer