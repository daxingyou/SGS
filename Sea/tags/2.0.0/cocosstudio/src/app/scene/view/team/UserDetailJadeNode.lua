--
-- Author: Liangxu
-- Date: 2017-9-13 15:49:15
-- 查看玩家羁绊模块
local ViewBase = require("app.ui.ViewBase")
local UserDetailJadeNode = class("UserDetailJadeNode", ViewBase)
local TeamEquipIcon = require("app.scene.view.team.TeamEquipIcon")
local EquipJadeIcon = require("app.scene.view.equipmentJade.EquipJadeIcon")

function UserDetailJadeNode:ctor(parentView)
	self._parentView = parentView
	local resource = {
		file = Path.getCSB("UserDetailJadeNode", "team"),
		binding = {
			_buttonEquip = {
				events = {{event = "touch", method = "_onButtonEquipClicked"}}
			}
		}
	}

	UserDetailJadeNode.super.ctor(self, resource)
end

function UserDetailJadeNode:onCreate()
	self._equipments = {}
	self._equipmentJades = {}
	for i = 1, 4 do --4个装备
		local equip = TeamEquipIcon.new(self["_fileNode" .. i])
		equip:setNameWidth(200)
		table.insert(self._equipments, equip)
		self._equipmentJades[i] = {}
		for j = 1, 4 do
			local jade = EquipJadeIcon.new(self["_E" .. i .. "_fileJade" .. j], i)
			jade:setTouchEnabled(false)
			table.insert(self._equipmentJades[i], jade)
		end
	end
end

function UserDetailJadeNode:onEnter()
end

function UserDetailJadeNode:onExit()
end

function UserDetailJadeNode:updateView(detailData, pos)
	self._detailData = detailData
	self._pos = pos
	self:_updateEquipment()
end

--装备信息
function UserDetailJadeNode:_updateEquipment()
	local curPos = self._pos
	for i = 1, 4 do
		local equipIcon = self._equipments[i]
		local equipData = self._detailData:getEquipData(curPos, i)
		local isShow = self._detailData:isShowEquipJade()
		equipIcon:onlyShow(i, equipData, isShow)
		self:_updateJade(equipData, i)
	end
end

-- 玉石信息
function UserDetailJadeNode:_updateJade(data, pos)
	for i = 1, 4 do
		self._equipmentJades[pos][i]:onlyShow()
	end
	if not data then
		self["_canNotInjectJade" .. pos]:setVisible(false)
		self["_slotBar" .. pos]:setVisible(false)
		return
	end
	local config = require("app.config.equipment").get(data:getBase_id())
	if config then
		local equipmentJadeInfo = string.split(config.inlay_type, "|")
		local jadeDatas = data:getUserDetailJades() or {0, 0, 0, 0}
		local index = 1
		for i = 1, #equipmentJadeInfo do
			if tonumber(equipmentJadeInfo[i]) > 0 then
				self._equipmentJades[pos][index]:onlyShow(jadeDatas[i] or 0, i == 1)
				index = index + 1
			end
		end
		if index == 1 then
			self["_canNotInjectJade" .. pos]:setVisible(true)
			self["_slotBar" .. pos]:setVisible(false)
		else
			self["_canNotInjectJade" .. pos]:setVisible(false)
			self["_slotBar" .. pos]:setVisible(true)
		end
	end
end

function UserDetailJadeNode:_onButtonEquipClicked()
	self._parentView:switchToHeroNode()
end

return UserDetailJadeNode
