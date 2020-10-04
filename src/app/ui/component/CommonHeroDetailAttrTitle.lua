-- i18n ja add class
-- Author: Liangxu
-- Date: 2017-07-12 13:59:22
-- 通用武将国家级别名字控件
local CommonHeroDetailAttrTitle = class("CommonHeroDetailAttrTitle")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

local EXPORTED_METHODS = {
	"updateUI",
	"getBg",
	"showLevelUp",
}

function CommonHeroDetailAttrTitle:ctor()
	self._target = nil
end

function CommonHeroDetailAttrTitle:_init()
	self._imgBg = ccui.Helper:seekNodeByName(self._target, "imgBg")	  
	self._Textlevel = ccui.Helper:seekNodeByName(self._target, "Textlevel")	                	--等级
	
	self._fileNodeCountry = ccui.Helper:seekNodeByName(self._target, "fileNodeCountry")  	    --国家
	cc.bind(self._fileNodeCountry, "CommonHeroCountry") 
	self._fileNodeHeroName2 = ccui.Helper:seekNodeByName(self._target, "fileNodeHeroName2")    	--名字、品质
	cc.bind(self._fileNodeHeroName2, "CommonHeroName")
	self._fileNodeHeroName2:getChildByName("TextName"):setFontSize(22)  
end

function CommonHeroDetailAttrTitle:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonHeroDetailAttrTitle:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonHeroDetailAttrTitle:updateUI(heroUnitData)
	local rank = heroUnitData:getRank_lv()
	local heroBaseId = heroUnitData:getBase_id()
	local limitLevel = heroUnitData:getLimit_level()
	local limitRedLevel = heroUnitData:getLimit_rtg()
	self._fileNodeHeroName2:setName(heroBaseId, rank, limitLevel, nil, limitRedLevel)

	self._fileNodeCountry:updateUI(heroBaseId)
	self._Textlevel:setString("LV." .. heroUnitData:getLevel())

	-- 金奖无等级
	local HeroGoldHelper = require("app.scene.view.heroGoldTrain.HeroGoldHelper")
	local isGold = HeroGoldHelper.isPureHeroGold(heroUnitData)
	self._Textlevel:setVisible(not isGold)
end

function CommonHeroDetailAttrTitle:getBg( )
	return self._imgBg 
end

function CommonHeroDetailAttrTitle:showLevelUp(bShow)
	self._Textlevel:setVisible(bShow)
end



return CommonHeroDetailAttrTitle

 