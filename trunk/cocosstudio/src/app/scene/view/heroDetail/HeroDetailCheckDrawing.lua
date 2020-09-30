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
 
HeroDetailCheckDrawing.POS_OFFSET = 0.1
function HeroDetailCheckDrawing:ctor(value)
	--self._value = value

	local resource = {
		file = Path.getCSB("HeroDetailCheckDrawing", "hero"), 
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonSwitch = {
				events = {{event = "touch", method = "_onButtonSwitchScreenClicked"}}
			},
			_buttonClose = {
				events = {{event = "touch", method = "_onButtonCloseClicked"}}  
			},
		}
	}

	HeroDetailCheckDrawing.super.ctor(self, resource)
end

function HeroDetailCheckDrawing:onCreate()
	self._slider:addEventListener(handler(self, self._onSlider))
	self._slider:setPercent(50)

	-- 隐藏进度条
	self._bSlidering = false
	self:_startTimer()
	-- 背景图
	self._imageBg:setOpacity(255) 
	self._imageBg2:setOpacity(0) 

	-- 头像
	self:_createHeroSpine()
	self._nodeAvatar:setVisible(true)  
	self.origPos = cc.p(self._nodeAvatar:getPositionX(), self._nodeAvatar:getPositionY())
 
	self._isMoving = false
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
	self:_endTimer()
	self._nodeSlider:setVisible(true)
  	do return true end
	-- return false
end
 
function HeroDetailCheckDrawing:_onTouchMoved(touch, event)
		self._isMoving = true

		local pDeltaX, pDeltaY = touch:getDelta()
		local posX, posY = self._nodeAvatar:getPosition() 

		self._nodeAvatar:setPosition( cc.pAdd( cc.p(posX, posY), cc.p(pDeltaX , pDeltaY) ) )
		if self._nodeAvatar:getPositionX() < -1*HeroDetailCheckDrawing.POS_OFFSET then
			self._nodeAvatar:setPositionX(-1*HeroDetailCheckDrawing.POS_OFFSET)
			return 
		end
		if self._nodeAvatar:getPositionX() > self._panelDesign:getContentSize().width + HeroDetailCheckDrawing.POS_OFFSET then
			self._nodeAvatar:setPositionX(self._panelDesign:getContentSize().width + HeroDetailCheckDrawing.POS_OFFSET)
			return 
		end
		if self._nodeAvatar:getPositionY() < -1*HeroDetailCheckDrawing.POS_OFFSET then
			self._nodeAvatar:setPositionY(-1*HeroDetailCheckDrawing.POS_OFFSET) 
			return
		end
		if self._nodeAvatar:getPositionY() > self._panelDesign:getContentSize().height + HeroDetailCheckDrawing.POS_OFFSET then
			self._nodeAvatar:setPositionY(self._panelDesign:getContentSize().height + HeroDetailCheckDrawing.POS_OFFSET)
			return
		end
		--print("----------------------------_onTouchMoved", posX, posY, pDeltaX, pDeltaY)
end

function HeroDetailCheckDrawing:_onTouchEnded(touch, event)
	print("----------------------------_onTouchEnded", touch, event)

	if not self._isMoving then    -- 没有moveing时  默认退出立绘
		--self:removeFromParent()
	end
	self._isMoving = false
	self:_startTimer()
end
 
function HeroDetailCheckDrawing:_onTouchCancelled(touch, event)
	if not self._isMoving then     
		--self:removeFromParent()
	end
	self._isMoving = false
	self:_startTimer()
end

function HeroDetailCheckDrawing:onExit()
	self:clear()
	self:_endTimer()
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
	if self._nodeAvatar:getScale() > 2 then  
		return 
	end
	self._nodeAvatar:setScale(self._nodeAvatar:getScale() + 0.03)
end

function HeroDetailCheckDrawing:_onButtonSmallClicked()
	if self._nodeAvatar:getScale() < 0.25 then  
		return 
	end
	self._nodeAvatar:setScale(self._nodeAvatar:getScale() - 0.03)
end


function HeroDetailCheckDrawing:_onSlider(sender,event)
    local value = self._slider:getPercent()
	if event == ccui.SliderEventType.percentChanged then
		self._bSlidering = true
		local scaleRate = 0
		
		if value > 50 then
			scaleRate = (value-50)*2/100
			--print("scaleRate 0==== ", scaleRate)
			scaleRate = scaleRate > 1 and 1 or scaleRate -- 最大为1 <0~1>
		elseif value < 50 then  
			scaleRate = 0.75 * (math.abs(value - 50) * 2 / 100 )
			--print("scaleRate 0==== ", -1*scaleRate)
			scaleRate =  scaleRate >= 0.75 and -0.75 or -1*scaleRate -- 最小为0.75 <0~0.75>
		end 

	   self._nodeAvatar:setScale(1 + scaleRate)
	elseif event == ccui.SliderEventType.slideBallUp then
		 -- 手指不滑动时 消失
		self._bSlidering = false
		self:_endTimer()
		self:_startTimer() 
    end
end

function HeroDetailCheckDrawing:_onButtonCloseClicked()
	self:removeFromParent()
end

--------------------
function HeroDetailCheckDrawing:_startTimer()
	local SchedulerHelper = require("app.utils.SchedulerHelper")
	if self._refreshHandler ~= nil then
        return
	end
	self._refreshHandler = SchedulerHelper.newScheduleOnce(handler(self,self._onRefreshTick), 3)
end

function HeroDetailCheckDrawing:_endTimer()
	local SchedulerHelper = require("app.utils.SchedulerHelper")
	if self._refreshHandler ~= nil then
		SchedulerHelper.cancelSchedule(self._refreshHandler)
		self._refreshHandler = nil
	end
end

function HeroDetailCheckDrawing:_onRefreshTick(dt)
	if self._bSlidering or self._isMoving then  -- 正在滑动进度条中/触摸屏幕
		self._nodeSlider:setVisible(true)
		return
	end 

	self._nodeSlider:setVisible(false)
end

 
return HeroDetailCheckDrawing


--1 放2按钮横竖屏切换  2 多点先不做容易出问题  3 有moveing时end正常走， 无moving时退出