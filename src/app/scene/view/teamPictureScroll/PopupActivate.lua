local PopupBase = require("app.ui.PopupBase")
local PopupActivate = class("PopupActivate", PopupBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

function PopupActivate:ctor(type, info)
	self._type = type
	self._info = info
	
    local resource = {
		file = Path.getCSB("PopupActivate", "teamPictureScroll"),
		binding = {
			_btnClose = {
				events = {{event = "touch", method = "onBtnClose"}}
			}
		}
	}
	PopupActivate.super.ctor(self, resource)
end

function PopupActivate:onCreate()
	self._panel1:setVisible(false)
	self._panel2:setVisible(false)
	self._panel4:setVisible(false)
	self._panel5:setVisible(false)

	if self._type == -1 then -- 没这张英雄卡
		self._panel1:setVisible(true)
		self._title:setString("未登用")
		for index = 1, 4 do
			self["_leftAttack" .. index]:setString("+0")
			self["_rightAttack" .. index]:setString("+" .. self._info["active_value" .. index])
		end
		self._leftIcon:initUI(TypeConvertHelper.TYPE_HERO, self._info.id)
		self._leftIcon:setIconMask(true)
		self._rightIcon:initUI(TypeConvertHelper.TYPE_HERO, self._info.id)
	elseif self._type == 1 then  -- 已经激活
		self._panel2:setVisible(true)
		self._title:setString("已登用")

		for index = 1, 4 do
			self["_attack" .. index]:setString("+" .. self._info["active_value" .. index])
		end
		self._iconActivate:initUI(TypeConvertHelper.TYPE_HERO, self._info.id)
	elseif self._type == 2 then -- 已经升级
		self._panel4:setVisible(true)
		self._title:setString("已升级")
		for index = 1, 4 do
			self["_upattack" .. index]:setString("+" .. self._info["lv_up_value" .. index])
		end
		self._iconLevelUp:initUI(TypeConvertHelper.TYPE_HERO, self._info.id)
	elseif self._type == 5 then -- 全体属性
		self._panel5:setVisible(true)
		self._title:setString("ステータス")
		for index = 1, 4 do
			self["_sumAttack" .. index]:setString("+" .. self._info[index])
		end
	end
end

function PopupActivate:onBtnClose()
    self:removeFromParent(true)
end

return PopupActivate