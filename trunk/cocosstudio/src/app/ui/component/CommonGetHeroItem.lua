
local CommonGetHeroItem = class("CommonGetHeroItem")

local EXPORTED_METHODS = {
    "playAnimation",
}


local COLOR_BG_LIST = {
    "img_herobg_01",
    "img_herobg_01",
    "img_herobg_02",
    "img_herobg_03",
    "img_herobg_04",
    "img_herobg_05",
    "img_herobg_05",
}
local COLOR_TITLE_LIST = {
    "img_com_grade_lv",
    "img_com_grade_lv",
    "img_com_grade_lan",
    "img_com_grade_zi",
    "img_com_grade_cheng",
    "img_com_grade_hong",
    "img_com_grade_jin",
}

CommonGetHeroItem.COLOR_QUALITY = {
    cc.c3b(0xff, 0xff, 0xff),----未提供金色
    cc.c3b(0xc0, 0xe9, 0xc1), --绿色
    cc.c3b(0xb4, 0xec, 0xf6), --蓝色
    cc.c3b(0xfa, 0xce, 0xff), --紫色
    cc.c3b(0xff, 0xe9, 0xa7), --橙色
    cc.c3b(0xff, 0xed, 0xed), --红色
    cc.c3b(0xff, 0xff, 0xff),----未提供金色
}

CommonGetHeroItem.COLOR_QUALITY_OUTLINE = {
    cc.c3b(0xff, 0xff, 0xff),----未提供金色
    cc.c4b(0x29, 0x8b, 0x2c, 0xff), --绿色
    cc.c4b(0x38, 0x6a, 0xe8, 0xff), --蓝色
    cc.c4b(0xb1, 0x2e, 0xe6, 0xff), --紫色
    cc.c4b(0xf4, 0x72, 0x06, 0xff), --橙色
    cc.c4b(0xe2, 0x20, 0x00, 0xff), --红色
    cc.c3b(0xff, 0xff, 0xff),----未提供金色
}

function CommonGetHeroItem:ctor()
	self._target = nil
end

function CommonGetHeroItem:_init()
end

function CommonGetHeroItem:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonGetHeroItem:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonGetHeroItem:playAnimation(heroId,isNew)
    local Hero = require("app.config.hero")
    local HeroRes = require("app.config.hero_res")
    self._heroData = Hero.get(heroId)       --英雄表格数据
    self._heroRes = HeroRes.get(self._heroData.res_id)
    self._isNew = isNew
    assert(self._heroData, "wrong hero id = "..heroId)
    self:_createAnimation()
end

function CommonGetHeroItem:_getCardImg(color)
    return Path.getDrawCard2(COLOR_BG_LIST[color])
end

function CommonGetHeroItem:_getQualityImg(color)
    return Path.getTextTeam(COLOR_TITLE_LIST[color])
end

--卡牌等级图标
function CommonGetHeroItem:_smoving_n_lv()
    local color = self._heroData.color
    if color == 6 then
        local node = cc.Node:create()
        local imagePath = self:_getQualityImg(color)
        local sprite = display.newSprite(imagePath)
        node:addChild(sprite)
        G_EffectGfxMgr:createPlayGfx(node,"effect_ur_icontx" ,nil,false)
        node:setLocalZOrder(4)
        return node
    elseif color == 5 then
        local node = cc.Node:create()
        local imagePath = self:_getQualityImg(color)
        local sprite = display.newSprite(imagePath)
        node:addChild(sprite)
        G_EffectGfxMgr:createPlayGfx(node,"effect_ssr_icontx",nil,false)
        node:setLocalZOrder(4)
        return node
    else
        local imagePath = self:_getQualityImg(color)
        local sprite = display.newSprite(imagePath)
        sprite:setLocalZOrder(4)
        return sprite
    end
end

--New图标特效
function CommonGetHeroItem:_new_kk()
    local isHas = self._isNew
    local node = cc.Node:create()
    if isHas then
        G_EffectGfxMgr:createPlayGfx(node, "effect_new_tx",nil,nil)

        local image = Path.getDrawCard2("NEW")
        local sprite = display.newSprite(image)
       -- sprite:setScaleX(-1)
        node:addChild(sprite)
    end
    return node
end

--立绘切图
function CommonGetHeroItem:_smoving_zhaojiang_ssr()
    local imagePath = Path.getShowRes(self._heroRes.icon)
    if Path.isExist(imagePath) then
        local sprite = display.newSprite(imagePath)
        return sprite
    else
        return cc.Node:create()
    end
end

--名字
function CommonGetHeroItem:_smoving_namewj()
    local name = self._heroData.name
    local color = self._heroData.color
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local itemParams = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO ,self._heroData.id)
    local label = cc.Label:createWithTTF(name, Path.getCommonFont(), 26)
    label:setColor(CommonGetHeroItem.COLOR_QUALITY[color])
    label:enableOutline(CommonGetHeroItem.COLOR_QUALITY_OUTLINE[color],  2)
    label:setAnchorPoint(cc.p(0.5, 0.5))
    label:setPosition(0,0)

    return label
end
--底板
function CommonGetHeroItem:_smoving_kapai_idle(index)
    local color = self._heroData.color
    local imagePath =  self:_getCardImg(color)
    local sprite = display.newSprite(imagePath)
    sprite:setLocalZOrder(9)
    return sprite
end

function CommonGetHeroItem:_smoving_kapai_idle1()
    return self:_smoving_kapai_idle(1)
end
function CommonGetHeroItem:_smoving_kapai_idle2()
    return self:_smoving_kapai_idle(2)
end

function CommonGetHeroItem:_smoving_kapai_idle3()
    return self:_smoving_kapai_idle(3)
end

function CommonGetHeroItem:_smoving_kapai_idle4()
    return self:_smoving_kapai_idle(4)  
end
function CommonGetHeroItem:_smoving_kapai_idle5()
    return self:_smoving_kapai_idle(5)
end

function CommonGetHeroItem:_createActionNode(effect)
    local funcName = "_"..effect
	if funcName then
		local func = self[funcName]
		assert(func, "has not func name = "..funcName)
        local node = func(self)
        local TextHelper = require("app.utils.TextHelper")
        if TextHelper.stringStartsWith(effect,"smoving_") then
            
            G_EffectGfxMgr:applySingleGfx(node, effect)

            local parentNode = cc.Node:create()
            local zOrder = node:getLocalZOrder()
            parentNode:setLocalZOrder(zOrder)
            parentNode:addChild(node)
            return parentNode

            --return node
        else
            return node
        end
       
    else
        return cc.Node:create()
	end
end

function CommonGetHeroItem:_createAnimation()
    local function effectFunction(effect)
        return self:_createActionNode(effect)    
    end
    local function eventFunction(event)
        if event == "finish" then
        end
    end
    local color = self._heroData.color
    print(self._heroData.id.."CommonGetHeroItem  "..color)
    if color > 6 then
        color = 6
    end
    local movingName = "moving_zhaojiang_kapai"..(color-1)
    local effect = G_EffectGfxMgr:createPlayMovingGfx(self._target, movingName, effectFunction, eventFunction , false )
    self._effectShow = effect
end

return CommonGetHeroItem