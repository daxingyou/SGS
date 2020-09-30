--
-- Author: Liangxu
-- Date: 2017-03-23 17:01:27
-- 武将缘分Cell
local ListViewCellBase = require("app.ui.ListViewCellBase")
local HeroKarmaCell = class("HeroKarmaCell", ListViewCellBase)
local HeroKarmaCellTitle = require("app.scene.view.heroTrain.HeroKarmaCellTitle")
local HeroKarmaCellIcon = require("app.scene.view.heroTrain.HeroKarmaCellIcon")
local AttributeConst = require("app.const.AttributeConst")

local COLOR_KARMA = {
	{cc.c3b(0xff, 0xde, 0x6d), cc.c4b(0xd4, 0x4d, 0x08, 0xff)}, --未激活
	{cc.c3b(0xf3, 0xff, 0x2b), cc.c4b(0x64, 0xbd, 0x0d, 0xff)}, --已激活
}

local ICON_POS = {
	[1] = {cc.p(152, 131)},
	[2] = {cc.p(105, 131), cc.p(199, 131)}
}

function HeroKarmaCell:ctor()
	local resource = {
		file = Path.getCSB("HeroKarmaCell", "hero"),
		binding = {
			
		}
	}
	HeroKarmaCell.super.ctor(self, resource)
end

function HeroKarmaCell:onCreate()
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
		self["_title"..i] = HeroKarmaCellTitle.new(self["_fileNodeTitle"..i], handler(self, self["_onButtonActive"..i]))
		self["_icon"..i.."_1"] = HeroKarmaCellIcon.new(self["_fileNodeIcon"..i.."_1"])
		self["_icon"..i.."_2"] = HeroKarmaCellIcon.new(self["_fileNodeIcon"..i.."_2"])
	end
end

function HeroKarmaCell:update(data1, data2, data3)
	local function updateCell(index, data)
		if data then
			self["_fileNodeTitle"..index]:setName("HeroKarmaCellTitle"..data.id)
			self._map[data.id] = index
			self["_karmaId"..index] = data.id
			self["_item"..index]:setVisible(true)

			local isCanActivate = true
			local heroIds = data.heroIds
			local visibleCount = 0
			for i = 1, 2 do
				local heroId = heroIds[i]
				if heroId then
					self["_fileNodeIcon"..index.."_"..i]:setVisible(true)
					local isHaveHero = G_UserData:getKarma():isHaveHero(heroId)
					self["_icon"..index.."_"..i]:updateIcon(heroId, not isHaveHero)
					isCanActivate = isCanActivate and isHaveHero
					visibleCount = visibleCount + 1
				else
					self["_fileNodeIcon"..index.."_"..i]:setVisible(false)
				end
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
				end
			end

			local des = Lang.get("hero_karma_attr_title", {attrName = data.attrName, attrValue = data.attrValue})
			local isActivated = G_UserData:getKarma():isActivated(data.id)
			self["_title"..index]:setDes(des, isActivated, isCanActivate, data.attrId)

			local titleBgRes = isActivated and Path.getFetterRes("img_namebg_light") or Path.getFetterRes("img_namebg_nml")
			local titleColor = isActivated and COLOR_KARMA[2][1] or COLOR_KARMA[1][1]
			local titleOutline = isActivated and COLOR_KARMA[2][2] or COLOR_KARMA[1][2]
			if Lang.checkHorizontal() then
				titleBgRes = isActivated and Path.getFetterRes("img_namebg_light_h") or Path.getFetterRes("img_namebg_nml_h")
				self["_imageTitle"..index]:setScale9Enabled(false)
				self["_imageTitle"..index]:setContentSize(cc.size(118,118))
				self["_imageTitle"..index]:setPosition(-3,256)
				self["_imageMark"..index]:setVisible(false)
				self["_textTitle"..index]:setRotation(-45)
				self["_textTitle"..index]:setPosition(41,74)
				self["_textTitle"..index]:setFontSize(20)
				if Lang.checkLang(Lang.ZH) then
					self["_textTitle"..index]:setFontSize(22)
				end
				self["_textTitle"..index]:setString(data.karmaName)
				self["_textTitle"..index]:ignoreContentAdaptWithSize(true)
			elseif not Lang.checkLang(Lang.CN) then
				-- local UIHelper  = require("yoka.utils.UIHelper")
				--   UIHelper.dealVTextWidget(self["_textTitle"..index],data.karmaName)
				
				-- self["_textTitle"..index]:setString(data.karmaName)
				-- self["_textTitle"..index]:getVirtualRenderer():setMaxLineWidth( self["_textTitle"..index]:getFontSize()*3 )
	 
				-- i18n ja change line
				local strContent = ""     
				local UTF8 = require("app.utils.UTF8")
				local len = UTF8.utf8len(data.karmaName)
				if string.find(data.karmaName, "%(") then
					for i=1, len - 3 do  
						local strEle = UTF8.utf8sub(data.karmaName, i, i)
						strEle = strEle .. "\n"
						strContent = strContent .. strEle
					end
					strContent = strContent .. UTF8.utf8sub(data.karmaName, len - 2, len)
					self["_textTitle"..index]:setContentSize(cc.size(26*4, 150))
				else   
					for i=1, len do  
						local strEle = UTF8.utf8sub(data.karmaName, i, i)
						if i ~= len then
							strEle = strEle .. "\n"
						end
						strContent = strContent .. strEle
					end
				end
				self["_textTitle"..index]:getVirtualRenderer():setLineSpacing(-1)
				self["_textTitle"..index]:setString( strContent )
			else
				self["_textTitle"..index]:setString(data.karmaName)
			end
			self["_imageTitle"..index]:loadTexture(titleBgRes)
			self["_textTitle"..index]:setColor(titleColor)
			self["_textTitle"..index]:enableOutline(titleOutline, 2)

			local markRes = self:_getMarkRes(isActivated, data.attrId)
			if markRes then
				self["_imageMark"..index]:loadTexture(markRes)
			end
		else
			self["_item"..index]:setVisible(false)
		end
	end

	updateCell(1, data1)
	updateCell(2, data2)
	updateCell(3, data3)
end

function HeroKarmaCell:_getMarkRes(isActivated, attrId)
	local res = {
		[AttributeConst.ATK_PER] = {"img_attackicon_light", "img_attackicon_nml"}, --已激活， 未激活
		[AttributeConst.DEF_PER] = {"img_deficon_light", "img_deficon_nml"},
		[AttributeConst.HP_PER] = {"img_healicon_light", "img_healicon_nml"},
	}

	local info = res[attrId]
	if info then
		local name = isActivated and info[1] or info[2]
		return Path.getFetterRes(name)
	else
		return nil
	end
end

function HeroKarmaCell:_onButtonActive( id )
	local index = self._map[id]
	self:dispatchCustomCallback(index)
end
function HeroKarmaCell:_onButtonActive1()
	self:dispatchCustomCallback(1)
end

function HeroKarmaCell:_onButtonActive2()
	self:dispatchCustomCallback(2)
end

function HeroKarmaCell:_onButtonActive3()
	self:dispatchCustomCallback(3)
end

function HeroKarmaCell:getKarmaId1()
	return self._karmaId1
end

function HeroKarmaCell:getKarmaId2()
	return self._karmaId2
end

function HeroKarmaCell:getKarmaId3()
	return self._karmaId3
end


-- i18n pos lable
function HeroKarmaCell:_dealPosByI18n()
	if Lang.checkSquareLanguage() then
		
	elseif not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		for i = 1,3,1 do
			--self["_textTitle"..i]:setContentSize(cc.size(400,24))
			--self["_textTitle"..i]:setAnchorPoint(cc.p(0,0.5))
			--self["_textTitle"..i]:setPosition(cc.p(20,152))
			--self["_textTitle"..i]:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT  )
			--self["_textTitle"..i]:setRotation(90)

			self["_textTitle"..i]:setFontSize(
				self["_textTitle"..i]:getFontSize()-2
			)
			self["_imageTitle"..i]:setPositionX(
				self["_imageTitle"..i]:getPositionX()+12
			)
			--[[
			self["_fileNodeIcon"..i.."_1"]:setPositionX(
				self["_fileNodeIcon"..i.."_1"]:getPositionX()+15
			)
			
			self["_fileNodeIcon"..i.."_2"]:setPositionX(
				self["_fileNodeIcon"..i.."_2"]:getPositionX()+15
			)
			
			
			]]

			local textDes = UIHelper.seekNodeByName(self["_fileNodeTitle"..i],"TextDes")
			
			textDes:setPositionX(textDes:getPositionX()+22)
			
		end
    
	end

	-- i18n ja change line
	if Lang.checkLang(Lang.JA) then  
		local UIHelper  = require("yoka.utils.UIHelper")
		for i = 1,3,1 do
			self["_textTitle"..i]:setFontSize(
				self["_textTitle"..i]:getFontSize()-4
			)
			self["_textTitle"..i]:getVirtualRenderer():setLineSpacing(-10)
		end
	end
end



return HeroKarmaCell
