--
-- Author: JerryHe
-- Date: 2019-01-29
-- Desc: 战马图鉴Cell
-- 
local ListViewCellBase = require("app.ui.ListViewCellBase")
local HorseKarmaCell = class("HorseKarmaCell", ListViewCellBase)
local HorseKarmaCellTitle = require("app.scene.view.horseTrain.HorseKarmaCellTitle")
local HorseKarmaCellIcon = require("app.scene.view.horseTrain.HorseKarmaCellIcon")
local HorseConst = require("app.const.HorseConst")
local TextHelper = require("app.utils.TextHelper")
local AttributeConst = require("app.const.AttributeConst")

local COLOR_KARMA = {
	{cc.c3b(0xff, 0xde, 0x6d), cc.c4b(0xd4, 0x4d, 0x08, 0xff)}, --未激活
	{cc.c3b(0xf3, 0xff, 0x2b), cc.c4b(0x64, 0xbd, 0x0d, 0xff)}, --已激活
}

local ICON_POS = {
	[1] = {cc.p(152, 131)},
	[2] = {cc.p(105, 131), cc.p(199, 131)}
}

local ATTR_NUM = 4

function HorseKarmaCell:ctor()
	local resource = {
		file = Path.getCSB("HorseKarmaCell", "horse"),
		binding = {
			
		}
    }
    
	HorseKarmaCell.super.ctor(self, resource)
end

function HorseKarmaCell:onCreate()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

	if not Lang.checkLang(Lang.CN) then
		self:_dealPosByI18n()
	end

	self._karmaId1 = nil
	self._karmaId2 = nil
	self._karmaId3 = nil
	self._map = {}

	for i = 1, 3 do
		self["_title"..i] = HorseKarmaCellTitle.new(self["_fileNodeTitle"..i], handler(self, self["_onButtonActive"..i]))
		self["_icon"..i.."_1"] = HorseKarmaCellIcon.new(self["_fileNodeIcon"..i.."_1"])
		self["_icon"..i.."_2"] = HorseKarmaCellIcon.new(self["_fileNodeIcon"..i.."_2"])
	end
end

function HorseKarmaCell:update(data1, data2, data3)
	local function updateCell(index, data)
        if data then
            local photoId = data.photoId
            local state = data.state
            local karmaData = G_UserData:getHorse():getHorsePhotoDetailInfo(photoId)

			self["_fileNodeTitle"..index]:setName("HorseKarmaCellTitle"..photoId)
			self._map[photoId] = index
			self["_karmaId"..index] = photoId
			self["_item"..index]:setVisible(true)

            local isCanActivate = false
            local isActivated = false
            if state == HorseConst.HORSE_PHOTO_VALID then
                isCanActivate = true
            end

            if state == HorseConst.HORSE_PHOTO_DONE then
                isActivated = true
            end

			local visibleCount = 2
			for i = 1, 2 do
                local horseId = karmaData["horse"..i]
                local horseValid = G_UserData:getHandBook():isHorseHave(horseId)
                self["_icon"..index.."_"..i]:updateIcon(horseId,not horseValid)
			end
			local posInfo = ICON_POS[visibleCount]
			if posInfo then
				for i = 1, visibleCount do
					local pos = posInfo[i]
					
					if not Lang.checkLang(Lang.CN) and visibleCount == 2 then
						self["_fileNodeIcon"..index.."_"..i]:setPosition(pos.x+22,pos.y)
					else
						self["_fileNodeIcon"..index.."_"..i]:setPosition(pos)
					end
					if Lang.checkChannel(Lang.CHANNEL_SEA) then
						local offsetX = {-30,10}
						if visibleCount == 2 then
							self["_fileNodeIcon"..index.."_"..i]:setPositionX(self["_fileNodeIcon"..index.."_"..i]:getPositionX()+offsetX[i])
						end
					end
				end
			end

            local desInfo = {}
            for i = 1, ATTR_NUM do
                local attrType = karmaData["attribute_type_"..i]
                if attrType ~= 0 then
                    local attrValue = karmaData["attribute_value_"..i]
                    local name,value = TextHelper.getAttrBasicText(attrType,attrValue)
                    local attrStr = name..":"..value
                    table.insert(desInfo,attrStr)
                end
            end

			self["_title"..index]:setDes(desInfo, isActivated, isCanActivate)

			local titleBgRes = isActivated and Path.getFetterRes("img_namebg_light") or Path.getFetterRes("img_namebg_nml")
			local titleColor = isActivated and COLOR_KARMA[2][1] or COLOR_KARMA[1][1]
			local titleOutline = isActivated and COLOR_KARMA[2][2] or COLOR_KARMA[1][2]
			if Lang.checkHorizontal() then
				titleBgRes = isActivated and Path.getFetterRes("img_namebg_light_h") or Path.getFetterRes("img_namebg_nml_h")
				self["_imageTitle"..index]:setScale9Enabled(false)
				self["_imageTitle"..index]:setContentSize(cc.size(118,118))
				self["_imageTitle"..index]:setPosition(-3,268)
				self["_textTitle"..index]:setRotation(-45)
				self["_textTitle"..index]:setPosition(41,74)
				self["_textTitle"..index]:setFontSize(20)
				if Lang.checkLang(Lang.ZH) then
					self["_textTitle"..index]:setFontSize(22)
				end
				self["_textTitle"..index]:setString(karmaData.name)
				self["_textTitle"..index]:ignoreContentAdaptWithSize(true)
			elseif not Lang.checkLang(Lang.CN) then
				local UIHelper  = require("yoka.utils.UIHelper")
				 UIHelper.dealVTextWidget(self["_textTitle"..index],karmaData.name)
			else
				self["_textTitle"..index]:setString(karmaData.name)
			end
			self["_imageTitle"..index]:loadTexture(titleBgRes)
			self["_textTitle"..index]:setColor(titleColor)
			self["_textTitle"..index]:enableOutline(titleOutline, 2)
		end
	end

	updateCell(1, data1)
	updateCell(2, data2)
	updateCell(3, data3)
end

function HorseKarmaCell:_onButtonActive( id )
	local index = self._map[id]
	self:dispatchCustomCallback(index)
end
function HorseKarmaCell:_onButtonActive1()
	self:dispatchCustomCallback(1)
end

function HorseKarmaCell:_onButtonActive2()
	self:dispatchCustomCallback(2)
end

function HorseKarmaCell:_onButtonActive3()
	self:dispatchCustomCallback(3)
end

function HorseKarmaCell:getKarmaId1()
	return self._karmaId1
end

function HorseKarmaCell:getKarmaId2()
	return self._karmaId2
end

function HorseKarmaCell:getKarmaId3()
	return self._karmaId3
end

-- i18n pos lable
function HorseKarmaCell:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		for i = 1,3,1 do
			self["_textTitle"..i]:setFontSize(
				self["_textTitle"..i]:getFontSize()-2
			)
			self["_imageTitle"..i]:setPositionX(
				self["_imageTitle"..i]:getPositionX()+12
			)
		
			
		end
    
	end
end

return HorseKarmaCell
