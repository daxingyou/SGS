
local CommonCvName = class("CommonCvName")

local EXPORTED_METHODS = {
	"updateData",
}


function CommonCvName:ctor()
	self._target = nil
end

function CommonCvName:_init()
  
    self._text1 = ccui.Helper:seekNodeByName(self._target, "Text_1")
    self._text2 = ccui.Helper:seekNodeByName(self._target, "Text_2")
    self._textCv = ccui.Helper:seekNodeByName(self._target, "TextCv")
   
end
function CommonCvName:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonCvName:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonCvName:updateData(heroId)
    local Hero = require("app.config.hero")
    self._heroData = Hero.get(heroId)       --英雄表格数据
    assert(self._heroData, "wrong hero id = "..heroId)
  
    local HeroRes = require("app.config.hero_res")
    local heroResConfig = HeroRes.get(heroId)
    

    self._text1:setString("CV")
    self._text2:setString(".")
    self._textCv:getVirtualRenderer():setMaxLineWidth(22)
    self._textCv:setString(heroResConfig.cast_name)
    
    local size1 = self._text1:getContentSize()
    local size2 = self._text2:getContentSize()
    local size3 = self._textCv:getContentSize()
    local text2Height = 4
    local totalHeight = size1.height + text2Height + size3.height + 8
    local startPos =  totalHeight * 0.5

    print("CommonCvName totalHeight " ..size1.height)
    print("CommonCvName totalHeight " ..size2.height)
    print("CommonCvName totalHeight " ..size3.height)
    print("CommonCvName totalHeight " ..totalHeight)
    
    self._text1:setPositionY(startPos)
    startPos = startPos - size1.height
    self._text2:setPositionY(startPos+11)
    startPos = startPos - text2Height - 8
    self._textCv:setPositionY(startPos)
end



return CommonCvName