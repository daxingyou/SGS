-- Author: hedili
-- Date:2017-10-14 14:31:09
-- Describle：

local BaseData = require("app.data.BaseData")
local HandBookData = class("HandBookData", BaseData)
local HeroConst = require("app.const.HeroConst")

local schema = {}
--schema
HandBookData.schema = schema

HandBookData.HERO_TYPE = 1
HandBookData.EQUIP_TYPE = 2
HandBookData.TREASURE_TYPE = 3
HandBookData.PET_TYPE = 6
HandBookData.SILKBAG_TYPE = 7
HandBookData.HORSE_TYPE = 8
HandBookData.HISTORICALHERO_TYPE = 9	-- 历代名将
HandBookData.JADE_STONE_TYPE = 11

function HandBookData:ctor(properties)
	HandBookData.super.ctor(self, properties)

	self._recvGetResPhoto = G_NetworkManager:add(MessageIDConst.ID_S2C_GetResPhoto, handler(self, self._s2cGetResPhoto))
	self._handbookList = {}

	self._heroInfos  = {}
	self._treasureInfos = {}
	self._equipInfos = {}
	self._heroOwnerCount = {}
	self._treasureOwnerCount = {}
	self._equipOwnerCount = {}
	self._silkbagInfos = {}
	self._silkbagOwnerCount = {}
	self._horseInfos = {}
	self._horseOwnerCount = {}

	self._petInfos = {}
	self._petList = {}
	self._petOwnerCount = {}
end

function HandBookData:clear()
end

function HandBookData:reset()
end

-- Describle：
-- Param:

function HandBookData:c2sGetResPhoto()
	G_NetworkManager:send(MessageIDConst.ID_C2S_GetResPhoto, {})
end
-- Describle：
function HandBookData:_s2cGetResPhoto(id, message)
	if message.ret ~= MessageErrorConst.RET_OK then
		return
	end
	--check data
	local res_photo = rawget(message, "res_photo")
	if not res_photo then
		return
	end

	for i, value in ipairs(res_photo) do
		self._handbookList["k"..value.res_type] = self._handbookList["k"..value.res_type] or {}
		if self._handbookList["k"..value.res_type]["k"..value.res_id] == nil then
			self._handbookList["k"..value.res_type]["k"..value.res_id] = true
		end
		
		if value.res_lv == HeroConst.HERO_LIMIT_MAX_LEVEL then
			self._handbookList["k"..value.res_type]["k"..value.res_id] = value.res_lv
		end
	end
	
	self:_initHeroInfos()
	self:_initEquipInfos()
	self:_initTreasureInfos()
	self:_initPetInfos()
	self:_initSilkbagInfos()
	self:_initHorseInfos()
	self:_initJadeStoneInfos()
	
	G_SignalManager:dispatch(SignalConst.EVENT_GET_RES_PHOTO_SUCCESS)
end

function HandBookData:isHeroHave(baseId, limitLevel)
	local typeMap = self._handbookList["k"..HandBookData.HERO_TYPE] or {}
	local isHave = typeMap["k"..baseId]
	if isHave then
		if limitLevel then
			return isHave == limitLevel
		end
		return true
	else
		return false
	end
end

function HandBookData:isEquipHave(baseId)
	local typeMap = self._handbookList["k"..HandBookData.EQUIP_TYPE] or {}
	local isHave = typeMap["k"..baseId]
	if isHave then
		return true
	end
	return false
end

function HandBookData:isTreasureHave(baseId)
	local typeMap = self._handbookList["k"..HandBookData.TREASURE_TYPE] or {}
	local isHave = typeMap["k"..baseId]
	if isHave then
		return true
	end
	return false
end

function HandBookData:isPetHave(baseId)
	local typeMap = self._handbookList["k"..HandBookData.PET_TYPE] or {}
	local isHave = typeMap["k"..baseId]
	if isHave then
		return true
	end
	return false
end

function HandBookData:isSilkbagHave(baseId)
	local typeMap = self._handbookList["k"..HandBookData.SILKBAG_TYPE] or {}
	local isHave = typeMap["k"..baseId]
	if isHave then
		return true
	end
	return false
end

function HandBookData:isHorseHave(baseId)
	local typeMap = self._handbookList["k"..HandBookData.HORSE_TYPE] or {}
	local isHave = typeMap["k"..baseId]
	if isHave then
		return true
	end
	return false
end

function HandBookData:isHostoricalHeroHave(baseId)
	local typeMap = self._handbookList["k"..HandBookData.HISTORICALHERO_TYPE] or {}
	local isHave = typeMap["k"..baseId]
	if isHave then
		return true
	end
	return false
end

function HandBookData:isJadeStoneHave(baseId)
	local typeMap = self._handbookList["k" .. HandBookData.JADE_STONE_TYPE] or {}
	local isHave = typeMap["k" .. baseId]
	if isHave then
		return true
	end
	return false
end

function HandBookData:getHeroList()
	return self._heroList
end

function HandBookData:getPetList()
	return self._petList
end

function HandBookData:getTreasureList()
	return self._treasureList
end

function HandBookData:getEquipList()
	return self._equipList
end

function HandBookData:getSilkbagList()
	return self._silkbagList
end

function HandBookData:getHorseList()
	return self._horseList
end

function HandBookData:getJadeStoneList()
	return self._jadeStoneList
end

function HandBookData:getHeroInfos()
	return self._heroInfos, self._heroOwnerCount
end

function HandBookData:getTreasureInfos()
	return self._treasureInfos, self._treasureOwnerCount
end

function HandBookData:getEquipInfos()
	return self._equipInfos, self._equipOwnerCount
end

function HandBookData:getSilkbagInfos()
	return self._silkbagInfos, self._silkbagOwnerCount
end

function HandBookData:getHorseInfos()
	return self._horseInfos, self._horseOwnerCount
end

function HandBookData:getJadeInfos()
	return self._jadeStoneInfos, self._jadeStoneOwnerCount
end

function HandBookData:getInfosByType(type)
	-- body
	local HandBookHelper = require("app.scene.view.handbook.HandBookHelper")
	if type == HandBookHelper.TBA_HERO then
		return self:getHeroInfos()
	end
	if type == HandBookHelper.TBA_EQUIP then
		return self:getEquipInfos()
	end
	if type == HandBookHelper.TBA_TREASURE then
		return self:getTreasureInfos()
	end
	if type == HandBookHelper.TBA_SILKBAG then
		return self:getSilkbagInfos()
	end
	if type == HandBookHelper.TBA_HORSE then
		return self:getHorseInfos()
	end
	if type == HandBookHelper.TBA_JADE_STONE then
		return self:getJadeInfos()
	end
end
--数据结构
--[[
	heroInfo = {
		[1] = { --国家拥有 colorList
			[1] = { hero1， hero2,},
			[2] = { hero1， hero2}
		}
	}
]]
function HandBookData:_initHeroInfos()
	local openServerDay = G_UserData:getBase():getOpenServerDayNum()
	local function processData(heroData, limitLevel)
		local heroCountry = heroData.country
		local heroColor = heroData.color

		if heroColor ~= 1 and heroData.is_show == 1  then --过滤白将
			self._heroInfos[heroCountry] =  self._heroInfos[heroCountry] or {}
			self._heroOwnerCount[heroCountry] =  self._heroOwnerCount[heroCountry] or {}
			self._heroOwnerCount[heroCountry][heroColor] = self._heroOwnerCount[heroCountry][heroColor] or {}

			if self._heroInfos[heroCountry][heroColor] == nil then
				self._heroInfos[heroCountry][heroColor] = {}
			end
			local handData = {
				cfg = heroData,
				isHave = self:isHeroHave(heroData.id, limitLevel),
				limitLevel = limitLevel
			}
			table.insert(self._heroInfos[heroCountry][heroColor], handData)
			table.insert(self._heroList, handData )

			table.sort(
				self._heroInfos[heroCountry][heroColor],
				function(item1, item2)
					return item1.cfg.id < item2.cfg.id
				end
			)
			
			if handData.isHave == true then
				self._heroOwnerCount[heroCountry][heroColor].ownNum = self._heroOwnerCount[heroCountry][heroColor].ownNum  or 0
				self._heroOwnerCount[heroCountry][heroColor].ownNum = self._heroOwnerCount[heroCountry][heroColor].ownNum + 1
			end
			self._heroOwnerCount[heroCountry][heroColor].totalNum = self._heroOwnerCount[heroCountry][heroColor].totalNum  or 0
			self._heroOwnerCount[heroCountry][heroColor].totalNum = self._heroOwnerCount[heroCountry][heroColor].totalNum + 1
		end
	end

	local heroInfo = require("app.config.hero")
	self._heroInfos = {}
	self._heroList = {}
	self._heroOwnerCount = {}

    for loopi = 1, heroInfo.length()  do 
        local heroData = heroInfo.indexOf(loopi)
		local showDay = heroData.show_day
		if openServerDay >= showDay then
			processData(heroData)

			local isLimitHero = heroData.limit == 1 --是界限武将
			if isLimitHero then
				local tempData = clone(heroData)
				tempData.color = 6 --颜色变红色
				processData(tempData, require("app.const.HeroConst").HERO_LIMIT_MAX_LEVEL)
			end
		end
	end
	
	table.sort(
		self._heroList,
		function(item1, item2)
			if item1.cfg.color ~= item2.cfg.color then
				return item1.cfg.color > item2.cfg.color
			end
			return item1.cfg.id < item2.cfg.id
		end
	)

    for i, country in ipairs(self._heroOwnerCount) do
        local countryOwn = 0
        local countryTotal = 0
        for j, color in pairs(country) do
			if type(color) == "table" then
				if color.ownNum == nil then
					color.ownNum = 0
				end
				if color.totalNum == nil then
					color.totalNum = 0
				end
				countryOwn = countryOwn + color.ownNum
				countryTotal = countryTotal + color.totalNum
			end
        end
        self._heroOwnerCount[i].ownNum = countryOwn
        self._heroOwnerCount[i].totalNum = countryTotal
    end
end

function HandBookData:_initEquipInfos()
	local equipInfo = require("app.config.equipment")

	self._equipInfos = {}
	self._equipList = {}
	self._equipOwnerCount = {}
	local sortList = {}
	for loopi = 1, equipInfo.length()  do
		local equipData = equipInfo.indexOf(loopi)
		if Lang.checkLang(Lang.CN) or (not Lang.checkLang(Lang.CN) and equipData.is_work == 1) then
			table.insert(sortList, equipData)
		end
	end

	table.sort(
		sortList,
		function(data1, data2)
			if data1.potential ~= data2.potential then
				return data1.potential > data2.potential
			end
			if data1.id ~= data2.id then
				return data1.id < data2.id
			end
		end
	)

    for loopi, value in ipairs(sortList) do 
        local equipData = value
		local equipColor = equipData.color

		self._equipInfos =  self._equipInfos or {}
		self._equipOwnerCount =  self._equipOwnerCount or {}
		self._equipOwnerCount[equipColor] = self._equipOwnerCount[equipColor] or {}

		if self._equipInfos[equipColor] == nil then
			self._equipInfos[equipColor] = {}
		end
		local handData = {
			cfg = equipData,
			isHave = self:isEquipHave(equipData.id)
		}
		table.insert(self._equipInfos[equipColor], handData)

		table.sort(
			self._equipInfos[equipColor],
			function(item1, item2)
				return item1.cfg.id < item2.cfg.id
			end
		)

		table.insert(self._equipList, handData)
		self._equipOwnerCount[equipColor].ownNum = self._equipOwnerCount[equipColor].ownNum  or 0
		if handData.isHave == true then
			self._equipOwnerCount[equipColor].ownNum = self._equipOwnerCount[equipColor].ownNum + 1
		end

		self._equipOwnerCount[equipColor].totalNum = self._equipOwnerCount[equipColor].totalNum  or 0
		self._equipOwnerCount[equipColor].totalNum = self._equipOwnerCount[equipColor].totalNum + 1
    end

	table.sort(
		self._equipList,
		function(item1, item2)
		if item1.cfg.color ~= item2.cfg.color then
			return item1.cfg.color > item2.cfg.color
		end
		return item1.cfg.id < item2.cfg.id
		end
	)
	
	local colorOwn = 0
    local colorTotal = 0
    for i, colorArray in pairs(self._equipOwnerCount) do
		if type(colorArray) == "table" then
			if colorArray.ownNum == nil then
				colorArray.ownNum = 0
			end
			if colorArray.totalNum == nil then
				colorArray.totalNum = 0
			end
			colorOwn = colorOwn + colorArray.ownNum
			colorTotal = colorTotal + colorArray.totalNum
		end
    end
	self._equipOwnerCount.ownNum = colorOwn
	self._equipOwnerCount.totalNum = colorTotal
end

function HandBookData:_initPetInfos()
	self._petInfos = {}
	self._petOwnerCount = {}
	self._petList = {}

	local petIdList = G_UserData:getPet():getAllPetMapId()
	dump(petIdList)
	local petInfo = require("app.config.pet")
	for loopi = 1, #petIdList  do 
        local itemData = petInfo.get( petIdList[loopi] )
		local itemColor = itemData.color

		self._petInfos =  self._petInfos or {}
		self._petOwnerCount =  self._petOwnerCount or {}

		if self._petInfos[itemColor] == nil then
			self._petInfos[itemColor] = {}
		end

		local handData = {
			cfg = itemData,
			isHave = self:isPetHave(itemData.id)
		}
		table.insert(self._petInfos[itemColor], handData)

		table.sort(
			self._petInfos[itemColor],
			function(item1, item2)
				return item1.cfg.id < item2.cfg.id
			end
		)

		table.insert(self._petList, handData)
    end

	local colorOwn = 0
    local colorTotal = 0
    for i, colorArray in pairs(self._petOwnerCount) do
		if type(colorArray) == "table" then
			if colorArray.ownNum == nil then
				colorArray.ownNum = 0
			end
			if colorArray.totalNum == nil then
				colorArray.totalNum = 0
			end
			colorOwn = colorOwn + colorArray.ownNum
			colorTotal = colorTotal + colorArray.totalNum
		end
    end
	self._petOwnerCount.ownNum = colorOwn
	self._petOwnerCount.totalNum = colorTotal
end

function HandBookData:_initTreasureInfos()
	local itemInfo = require("app.config.treasure")
	local openServerDay = G_UserData:getBase():getOpenServerDayNum()

	self._treasureInfos = {}
	self._treasureOwnerCount = {}
	self._treasureList = {}
    for loopi = 1, itemInfo.length()  do 
        local itemData = itemInfo.indexOf(loopi)
		local showDay = itemData.show_day
		if openServerDay >= showDay and (Lang.checkLang(Lang.CN) or (not Lang.checkLang(Lang.CN) and itemData.is_work == 1)) then
			local itemColor = itemData.color
			self._treasureInfos =  self._treasureInfos or {}
			self._treasureOwnerCount =  self._treasureOwnerCount or {}
			self._treasureOwnerCount[itemColor] = self._treasureOwnerCount[itemColor] or {}

			if self._treasureInfos[itemColor] == nil then
				self._treasureInfos[itemColor] = {}
			end
			
			local handData = {
				cfg = itemData,
				isHave = self:isTreasureHave(itemData.id)
			}
			table.insert(self._treasureInfos[itemColor], handData)

			table.sort(
				self._treasureInfos[itemColor],
				function(item1, item2)
					return item1.cfg.id < item2.cfg.id
				end
			)

			table.insert(self._treasureList, handData)

			self._treasureOwnerCount[itemColor].ownNum = self._treasureOwnerCount[itemColor].ownNum  or 0

			if handData.isHave == true then
				self._treasureOwnerCount[itemColor].ownNum = self._treasureOwnerCount[itemColor].ownNum + 1
			end

			self._treasureOwnerCount[itemColor].totalNum = self._treasureOwnerCount[itemColor].totalNum  or 0
			self._treasureOwnerCount[itemColor].totalNum = self._treasureOwnerCount[itemColor].totalNum + 1
		end
    end

	table.sort(
		self._treasureList,
		function(item1, item2)
			if item1.cfg.color ~= item2.cfg.color then
				return item1.cfg.color > item2.cfg.color
			end
			return item1.cfg.id < item2.cfg.id
		end
	)

	local colorOwn = 0
    local colorTotal = 0
    for i, colorArray in pairs(self._treasureOwnerCount) do
		if type(colorArray) == "table" then
			if colorArray.ownNum == nil then
				colorArray.ownNum = 0
			end
			if colorArray.totalNum == nil then
				colorArray.totalNum = 0
			end
			colorOwn = colorOwn + colorArray.ownNum
			colorTotal = colorTotal + colorArray.totalNum
		end
    end
	self._treasureOwnerCount.ownNum = colorOwn
	self._treasureOwnerCount.totalNum = colorTotal
end

function HandBookData:_initSilkbagInfos()
	local itemInfo = require("app.config.silkbag")
	local openServerDay = G_UserData:getBase():getOpenServerDayNum()

	self._silkbagInfos = {}
	self._silkbagOwnerCount = {}
	self._silkbagList = {}
    for loopi = 1, itemInfo.length()  do 
        local itemData = itemInfo.indexOf(loopi)
        local showDay = itemData.show_day
        if openServerDay >= showDay then
        	local itemColor = itemData.color
			self._silkbagInfos = self._silkbagInfos or {}
			self._silkbagOwnerCount =  self._silkbagOwnerCount or {}
			self._silkbagOwnerCount[itemColor] = self._silkbagOwnerCount[itemColor] or {}

			if self._silkbagInfos[itemColor] == nil then
				self._silkbagInfos[itemColor] = {}
			end
			
			local handData = {
				cfg = itemData,
				isHave = self:isSilkbagHave(itemData.id)
			}
			table.insert(self._silkbagInfos[itemColor], handData)

			table.sort(
				self._silkbagInfos[itemColor],
				function(item1, item2)
					if item1.cfg.order ~= item2.cfg.order then
						return item1.cfg.order < item2.cfg.order
					else
						return item1.cfg.id < item2.cfg.id
					end
				end
			)

			table.insert(self._silkbagList, handData)

			self._silkbagOwnerCount[itemColor].ownNum = self._silkbagOwnerCount[itemColor].ownNum  or 0

			if handData.isHave == true then
				self._silkbagOwnerCount[itemColor].ownNum = self._silkbagOwnerCount[itemColor].ownNum + 1
			end

			self._silkbagOwnerCount[itemColor].totalNum = self._silkbagOwnerCount[itemColor].totalNum  or 0
			self._silkbagOwnerCount[itemColor].totalNum = self._silkbagOwnerCount[itemColor].totalNum + 1
        end
    end

	table.sort(
		self._silkbagList,
		function(item1, item2)
			if item1.cfg.color ~= item2.cfg.color then
				return item1.cfg.color > item2.cfg.color
			elseif item1.cfg.order ~= item2.cfg.order then
				return item1.cfg.order < item2.cfg.order
			end
			return item1.cfg.id < item2.cfg.id
		end
	)

	local colorOwn = 0
    local colorTotal = 0
    for i, colorArray in pairs(self._silkbagOwnerCount) do
		if type(colorArray) == "table" then
			if colorArray.ownNum == nil then
				colorArray.ownNum = 0
			end
			if colorArray.totalNum == nil then
				colorArray.totalNum = 0
			end
			colorOwn = colorOwn + colorArray.ownNum
			colorTotal = colorTotal + colorArray.totalNum
		end
    end
	self._silkbagOwnerCount.ownNum = colorOwn
	self._silkbagOwnerCount.totalNum = colorTotal
end

function HandBookData:_initHorseInfos()
	local itemInfo = require("app.config.horse")
	local openServerDay = G_UserData:getBase():getOpenServerDayNum()

	self._horseInfos = {}
	self._horseOwnerCount = {}
	self._horseList = {}
    for loopi = 1, itemInfo.length()  do 
        local itemData = itemInfo.indexOf(loopi)
        local showDay = itemData.show_day
        if openServerDay >= showDay then
	    	local itemColor = itemData.color
			self._horseInfos = self._horseInfos or {}
			self._horseOwnerCount =  self._horseOwnerCount or {}
			self._horseOwnerCount[itemColor] = self._horseOwnerCount[itemColor] or {}

			if self._horseInfos[itemColor] == nil then
				self._horseInfos[itemColor] = {}
			end
			
			local handData = {
				cfg = itemData,
				isHave = self:isHorseHave(itemData.id)
			}
			table.insert(self._horseInfos[itemColor], handData)

			table.sort(
				self._horseInfos[itemColor],
				function(item1, item2)
					return item1.cfg.id < item2.cfg.id
				end
			)

			table.insert(self._horseList, handData)

			self._horseOwnerCount[itemColor].ownNum = self._horseOwnerCount[itemColor].ownNum  or 0

			if handData.isHave == true then
				self._horseOwnerCount[itemColor].ownNum = self._horseOwnerCount[itemColor].ownNum + 1
			end

			self._horseOwnerCount[itemColor].totalNum = self._horseOwnerCount[itemColor].totalNum  or 0
			self._horseOwnerCount[itemColor].totalNum = self._horseOwnerCount[itemColor].totalNum + 1
		end
    end

	table.sort(
		self._horseList,
		function(item1, item2)
			if item1.cfg.color ~= item2.cfg.color then
				return item1.cfg.color > item2.cfg.color
			end
			return item1.cfg.id < item2.cfg.id
		end
	)

	local colorOwn = 0
    local colorTotal = 0
    for i, colorArray in pairs(self._horseOwnerCount) do
		if type(colorArray) == "table" then
			if colorArray.ownNum == nil then
				colorArray.ownNum = 0
			end
			if colorArray.totalNum == nil then
				colorArray.totalNum = 0
			end
			colorOwn = colorOwn + colorArray.ownNum
			colorTotal = colorTotal + colorArray.totalNum
		end
    end
	self._horseOwnerCount.ownNum = colorOwn
	self._horseOwnerCount.totalNum = colorTotal
end

function HandBookData:_initJadeStoneInfos()
	local itemInfo = require("app.config.jade")

	self._jadeStoneInfos = {}
	self._jadeStoneOwnerCount = {}
	self._jadeStoneList = {}
	for loopi = 1, itemInfo.length() do
		local itemData = itemInfo.indexOf(loopi)
		local equipmentType = itemData.equipment_type
		local itemColor = itemData.color

		-- self._heroInfos[heroCountry] = self._heroInfos[heroCountry] or {}
		-- self._heroOwnerCount[heroCountry] = self._heroOwnerCount[heroCountry] or {}
		-- self._heroOwnerCount[heroCountry][heroColor] = self._heroOwnerCount[heroCountry][heroColor] or {}

		self._jadeStoneInfos = self._jadeStoneInfos or {}
		self._jadeStoneInfos[equipmentType] = self._jadeStoneInfos[equipmentType] or {}
		self._jadeStoneInfos[equipmentType][itemColor] = self._jadeStoneInfos[equipmentType][itemColor] or {}
		self._jadeStoneOwnerCount = self._jadeStoneOwnerCount or {}
		self._jadeStoneOwnerCount[equipmentType] = self._jadeStoneOwnerCount[equipmentType] or {}
		self._jadeStoneOwnerCount[equipmentType][itemColor] = self._jadeStoneOwnerCount[equipmentType][itemColor] or {}

		local handData = {
			cfg = itemData,
			isHave = self:isJadeStoneHave(itemData.id)
		}
		table.insert(self._jadeStoneInfos[equipmentType][itemColor], handData)

		table.sort(
			self._jadeStoneInfos[equipmentType][itemColor],
			function(item1, item2)
				return item1.cfg.sort > item2.cfg.sort
			end
		)

		table.insert(self._jadeStoneList, handData)

		self._jadeStoneOwnerCount[equipmentType][itemColor].ownNum =
			self._jadeStoneOwnerCount[equipmentType][itemColor].ownNum or 0
		if handData.isHave == true then
			self._jadeStoneOwnerCount[equipmentType][itemColor].ownNum =
				self._jadeStoneOwnerCount[equipmentType][itemColor].ownNum + 1
		end
		self._jadeStoneOwnerCount[equipmentType][itemColor].totalNum =
			self._jadeStoneOwnerCount[equipmentType][itemColor].totalNum or 0
		self._jadeStoneOwnerCount[equipmentType][itemColor].totalNum =
			self._jadeStoneOwnerCount[equipmentType][itemColor].totalNum + 1
	end

	table.sort(
		self._jadeStoneList,
		function(item1, item2)
			if item1.cfg.color ~= item2.cfg.color then
				return item1.cfg.color > item2.cfg.color
			end
			return item1.cfg.sort > item2.cfg.sort
		end
	)

	for i, equipmentType in ipairs(self._jadeStoneOwnerCount) do
		local equipmentTypeOwn = 0
		local equipmentTypeTotal = 0
		for j, color in pairs(equipmentType) do
			if type(color) == "table" then
				if color.ownNum == nil then
					color.ownNum = 0
				end
				if color.totalNum == nil then
					color.totalNum = 0
				end
				equipmentTypeOwn = equipmentTypeOwn + color.ownNum
				equipmentTypeTotal = equipmentTypeTotal + color.totalNum
			end
		end
		self._jadeStoneOwnerCount[i].ownNum = equipmentTypeOwn
		self._jadeStoneOwnerCount[i].totalNum = equipmentTypeTotal
	end
end

return HandBookData
