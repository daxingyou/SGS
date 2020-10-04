--
-- Author: Liangxu
-- Date: 2017-02-28 15:09:42
-- 查看立绘
local ViewBase = require("app.ui.ViewBase")
local HeroDetailCheckDrawing = class("HeroDetailCheckDrawing", ViewBase)
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local Hero = require("app.config.hero")
local HeroRes = require("app.config.hero_res")
local CSHelper = require("yoka.utils.CSHelper")
 
 
local EventDispatcher = cc.Director:getInstance():getEventDispatcher()
 
 
function HeroDetailCheckDrawing:ctor(value)
	--self._value = value

	local resource = {
		file = Path.getCSB("HeroDetailCheckDrawing", "hero"), 
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonSwitch = {
				events = {{event = "touch", method = "_onButtonSwitchScreenClicked"}}
			},
			_buttonLager = {
				events = {{event = "touch", method = "_onButtonEnlargeClicked"}}  
			},
			_buttonSmall = {
				events = {{event = "touch", method = "_onButtonSmallClicked"}}
			}
		}
	}

	HeroDetailCheckDrawing.super.ctor(self, resource)
end

function HeroDetailCheckDrawing:onCreate()
	-- 背景图
	self._imageBg:setOpacity(255) 
	self._imageBg2:setOpacity(0) 

	-- 头像
	self:_createHeroSpine()
	self._nodeAvatar:setVisible(true)  
	self.origPos = cc.p(self._nodeAvatar:getPositionX(), self._nodeAvatar:getPositionY())
 
	self.isMoving = false
	-- 添加Touch   (下面多点触摸相关 暂时无用)
	-- self:setMultipleTouchEnabled(true) 需要在native代码开启，
	self.bgOrigin = self._nodeAvatar:getPosition() --初始化数据
	self.m_scale = 1.0
	self.distance = 0.0
end

function HeroDetailCheckDrawing:_createHeroSpine()
	local heroId = G_UserData:getHero():getCurHeroId()
	local unitData = G_UserData:getHero():getUnitDataWithId(heroId)
	local heroBaseId, isEquipAvatar, avatarLimitLevel, arLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(unitData)
	local limitLevel = avatarLimitLevel or unitData:getLimit_level()
	local limitRedLevel = arLimitLevel or unitData:getLimit_rtg()
 
	local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId, nil, nil, limitLevel, limitRedLevel)
	local resData = param.res_cfg
	if resData.story_res_spine ~= 0 then
		local avatar = CSHelper.loadResourceNode(Path.getCSB("CommonStoryAvatar", "common"))
		avatar:updateChatUI(heroBaseId, limitLevel, limitRedLevel)
		avatar:setPosition(cc.p(0, 0)) 
		avatar:getChildByName("Panel_1"):setClippingEnabled(false)
		 ccui.Helper:seekNodeByName(avatar, "NodeAvatar"):setPositionY(avatar:getChildByName("Panel_1"):getContentSize().height*-0.1) 
		self._nodeAvatar:addChild(avatar)
	else   
		if not (heroBaseId and heroBaseId > 0) then
			return	 
		end
		local image = ccui.ImageView:create()
		image:ignoreContentAdaptWithSize(true)   
		image:loadTexture(Path.getHeroImage(heroBaseId))
		image:setPosition(cc.p(0, 0)) 
		self._nodeAvatar:addChild(image)
	end	
end

function HeroDetailCheckDrawing:onEnter()

	if self._listener == nil then
        local listener = cc.EventListenerTouchOneByOne:create()
        listener:setSwallowTouches(false)
        listener:registerScriptHandler(handler(self, self._onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
        listener:registerScriptHandler(handler(self, self._onTouchMoved), cc.Handler.EVENT_TOUCH_MOVED)
        listener:registerScriptHandler(handler(self, self._onTouchEnded), cc.Handler.EVENT_TOUCH_ENDED)
        listener:registerScriptHandler(handler(self, self._onTouchCancelled), cc.Handler.EVENT_TOUCH_CANCELLED)
        EventDispatcher:addEventListenerWithSceneGraphPriority(listener, self._imageBg) 
        self._listener = listener
    end
end 

--
function HeroDetailCheckDrawing:_onTouchBegan(touch, event)
  	do return true end
	-- return false
end
 
function HeroDetailCheckDrawing:_onTouchMoved(touch, event)
		self.isMoving = true

		local pDeltaX, pDeltaY = touch:getDelta()
		local posX, posY = self._nodeAvatar:getPosition() 
		self._nodeAvatar:setPosition( cc.pAdd( cc.p(posX, posY), cc.p(pDeltaX , pDeltaY) ) )
		--print("----------------------------_onTouchMoved", posX, posY, pDeltaX, pDeltaY)
end

function HeroDetailCheckDrawing:_onTouchEnded(touch, event)
	print("----------------------------_onTouchEnded", touch, event)

	if not self.isMoving then    -- 没有moveing时  默认退出立绘
		self:removeFromParent()
	end
	self.isMoving = false
end
 
function HeroDetailCheckDrawing:_onTouchCancelled(touch, event)
	if not self.isMoving then     
		self:removeFromParent()
	end
	self.isMoving = false
end

function HeroDetailCheckDrawing:onExit()
	self:clear()
end

function HeroDetailCheckDrawing:clear()
    if self._listener then
        EventDispatcher:removeEventListener(self._listener)
        self._listener = nil
    end
end

function HeroDetailCheckDrawing:_onButtonSwitchScreenClicked()
	local angel = self._nodeAvatar:getRotation() 
	if angel == -90 then
		angel = 0
	else 
		angel = -90	
	end
	self._nodeAvatar:setRotation(angel)
	self._nodeAvatar:setPosition(self.origPos)

	-- 调整背景图
	-- local bgName = ""
	-- if angel == 0 then
	-- 	bgName = Path.getStageBG("heroP_bj")
	-- 	self._imageBg:loadTexture(bgName)
	-- 	self._imageBg:setContentSize(cc.size(G_ResolutionManager:getDesignSize().width, G_ResolutionManager:getDesignSize().height))
	-- else
	-- 	bgName = Path.getStageBG("img_check_spine_bg")   
	-- 	self._imageBg:loadTexture(bgName)
	-- 	self._imageBg:setContentSize(cc.size(G_ResolutionManager:getDesignSize().width, G_ResolutionManager:getDesignSize().height))
	-- end
	-- self._imageBg:setRotation(angel)

	local bgName = ""
	if angel == 0 then
		self._imageBg:setOpacity(255) 
		self._imageBg2:setOpacity(0) 
	else
		self._imageBg:setOpacity(0) 
		self._imageBg2:setOpacity(255) 
	end
end

function HeroDetailCheckDrawing:_onButtonEnlargeClicked()
	self._nodeAvatar:setScale(self._nodeAvatar:getScale() + 0.03)
end

function HeroDetailCheckDrawing:_onButtonSmallClicked()
	self._nodeAvatar:setScale(self._nodeAvatar:getScale() - 0.03)
end


 
return HeroDetailCheckDrawing


--1 放2按钮横竖屏切换  2 多点先不做容易出问题  3 有moveing时end正常走， 无moving时退出