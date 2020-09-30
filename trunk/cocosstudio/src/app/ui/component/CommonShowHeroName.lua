
local CommonShowHeroName = class("CommonShowHeroName")

local EXPORTED_METHODS = {
	"updateData",
}


local COLOR_BG_LIST = {"","","","sr_name_bg","ssr_name_bg","ur_name_bg"}
local COLOR_TITLE_LIST = {"img_com_grade_lv","img_com_grade_lv","img_com_grade_lan","img_com_grade_zi",
    "img_com_grade_cheng","img_com_grade_hong","img_com_grade_jin"}

function CommonShowHeroName:ctor()
	self._target = nil
end

function CommonShowHeroName:_init()
    self._imageColorBg = ccui.Helper:seekNodeByName(self._target, "ImageColorBg")
    self._imageColor = ccui.Helper:seekNodeByName(self._target, "ImageColor")
	self._imageName = ccui.Helper:seekNodeByName(self._target, "ImageName")
    self._text1 = ccui.Helper:seekNodeByName(self._target, "Text_1")
    self._text2 = ccui.Helper:seekNodeByName(self._target, "Text_2")
    self._textCv = ccui.Helper:seekNodeByName(self._target, "TextCv")
    self._imageCountry = ccui.Helper:seekNodeByName(self._target, "ImageCountry")
    
    self._imageName:ignoreContentAdaptWithSize(true)
end

function CommonShowHeroName:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonShowHeroName:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonShowHeroName:updateData(heroId)
    local Hero = require("app.config.hero")
    self._heroData = Hero.get(heroId)       --英雄表格数据
    assert(self._heroData, "wrong hero id = "..heroId)
    local color = self._heroData.color
    self._imageColorBg:loadTexture(self:_getQualityBgImg(color))
    self._imageColor:loadTexture(self:_getQualityImg(color))

    local HeroRes = require("app.config.hero_res")
    local heroResConfig = HeroRes.get(heroId)
    self._imageName:loadTexture(Path.getShowHeroNameTrue(heroResConfig.show_name))
    
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local itemParams = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO , heroId, nil)
   

    self._text1:setString("CV")
    self._text2:setString(".")
    self._textCv:setString(heroResConfig.cast_name)
    self._imageCountry:loadTexture(itemParams.country_text_2_highlight)

end

function CommonShowHeroName:_getQualityBgImg(color)
    return Path.getDrawCard2(COLOR_BG_LIST[color])
end

function CommonShowHeroName:_getQualityImg(color)
    return Path.getTextTeam(COLOR_TITLE_LIST[color])
end


return CommonShowHeroName