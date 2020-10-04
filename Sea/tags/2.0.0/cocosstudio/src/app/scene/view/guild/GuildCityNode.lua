local ViewBase = require("app.ui.ViewBase")
local GuildCityNode = class("GuildCityNode", ViewBase)
local GuildConst = require("app.const.GuildConst")

function GuildCityNode:ctor(cityCfg,listener)
    self._cityCfg = cityCfg
	self._listener = listener
    self._redPoint = nil
    self._button = nil
	self._imageNameBg = nil
	self._imageName = nil
	self._nodeDecorate = nil
	self._nodeWorldBoss = nil
	self._panelTouch = nil
	local resource = {
		file = Path.getCSB("GuildCityNode", "guild"),
		binding = {
			_button = {
				events = {{event = "touch", method = "_onCityClick"}}
			},
			_panelTouch = {
				events = {{event = "touch", method = "_onCityClick"}}
			},
		}
	}
	GuildCityNode.super.ctor(self, resource)
end

function GuildCityNode:onCreate()
	-- i18n change lable
	self:_swapImageByI18n()
	if  Lang.checkLang(Lang.KR) then
		self._imageNameBg:setTouchEnabled(true)
		self._imageNameBg:setSwallowTouches(false)
		self._imageNameBg:addClickEventListenerEx(handler(self,self._onCityClick))
	end

	local cityNameX = self._cityCfg.name_postion_x-self._cityCfg.postion_x
	local cityNameY = self._cityCfg.name_postion_y-self._cityCfg.postion_y
	local isCityShow = self._cityCfg.open == 1
	self:setPosition(self._cityCfg.postion_x,self._cityCfg.postion_y)
	self._panelTouch:setSwallowTouches(false)
	self._button:setSwallowTouches(false)
	self._button:ignoreContentAdaptWithSize(true)
	self._button:loadTexture(Path.getGuildRes(self._cityCfg.pic))

	self._imageNameBg:setVisible(isCityShow )
	self._imageName:setVisible(isCityShow )
	self._redPoint:setVisible(isCityShow )
	self._nodeDecorate:setVisible(isCityShow )




	-- i18n change lable
    if not Lang.checkLang(Lang.CN) then
        self._imageName:setString(Lang.getImgText(self._cityCfg.name_pic))
    else
      	self._imageName:loadTexture(Path.getTextGuild(self._cityCfg.name_pic))
		self._imageName:ignoreContentAdaptWithSize(true)
    end

	local nameSize = self._imageName:getContentSize()
	local bgSize = self._imageNameBg:getContentSize()
	bgSize.height = nameSize.height + 40
	self._imageNameBg:setContentSize(bgSize)
	self._imageNameBg:setPosition(cityNameX,cityNameY)
	self._imageName:setPosition(cityNameX,cityNameY)

	self._redPoint:setPosition(cityNameX + bgSize.width*0.5 -3,cityNameY + bgSize.height*0.5-6)

	--i18n
	if Lang.checkHorizontal() then
		self._imageNameBg:setScale9Enabled(true)
		self._imageNameBg:setCapInsets(cc.rect(18,10,1,1))
		self._imageNameBg:loadTexture(Path.getGuildRes("img_juntuan_txtbg01_h"))
		self._imageName:setAnchorPoint(0.5,0.5)
		local width = self._imageName:getContentSize().width+60
		self._imageNameBg:setContentSize(cc.size(width,28))
		self._imageName:ignoreContentAdaptWithSize(true)
		local posX,posY = self._imageNameBg:getPosition()
		self._redPoint:setPosition(posX+width/2-10,posY+14)
	end
end

function GuildCityNode:onEnter()
	if self._cityCfg.id == GuildConst.CITY_BOSS_ID then--世界BOSS
		self._signalWorldBossGetInfo = G_SignalManager:add(SignalConst.EVENT_WORLDBOSS_GET_INFO, handler(self, self._onEventWorldBossGetInfo))
	end
	
end

function GuildCityNode:onExit()
	if self._signalWorldBossGetInfo then
		self._signalWorldBossGetInfo:remove()
		self._signalWorldBossGetInfo = nil
	end

end

function GuildCityNode:refreshRedPoint(showRedPoint)
	if self._cityCfg.open == 1 then
		self._redPoint:setVisible(showRedPoint)
	end
end

function GuildCityNode:refreshCityView()
	if self._cityCfg.open ~= 1 then
		return
	end
	local openNeedLevel = self._cityCfg.show_level--开放需要的军团等级
	local guildLevel = G_UserData:getGuild():getMyGuildLevel()
	local isOpen = openNeedLevel <= guildLevel

	-- i18n change lable
	if not Lang.checkLang(Lang.CN) then
        
        local UIHelper  = require("yoka.utils.UIHelper")
        UIHelper.setLabelStyle(self._imageName,{
             style = isOpen and "guild_1" or "guild_2",
			 text = Lang.getImgText(self._cityCfg.name_pic ),
        })
        
    else
      	self._imageName:loadTexture(Path.getTextGuild(
			isOpen and self._cityCfg.name_pic or (self._cityCfg.name_pic.."b")
		))

    end
	if self._cityCfg.id == GuildConst.CITY_BOSS_ID  then--世界BOSS建筑
		if isOpen and not self._nodeWorldBoss then
			self:_createWorldBoss()
		elseif not isOpen and self._nodeWorldBoss then
			self._nodeWorldBoss:removeFromParent()
			self._nodeWorldBoss = nil
			
		end
	end
	
end

function GuildCityNode:_doClick()
	if self._listener and self._cityCfg.open == 1  then
		self._listener(self,self:getCityData())
	end
end

function GuildCityNode:_onCityClick(sender)
	local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
	local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
	if offsetX < 20 and offsetY < 20  then
		self:_doClick()
		return true
	else
		return false	
	end
end

function GuildCityNode:getCityData()
	return self._cityCfg
end

function GuildCityNode:_createWorldBoss()
	local CSHelper = require("yoka.utils.CSHelper")-- 创建弹框
    local node =  CSHelper.loadResourceNode(Path.getCSB("CommonHeroAvatar", "common"))
	--node:setCallBack(handler(self,self._doClick))
	--node:setTouchEnabled(true)
	node:setScale(0.5)
	node:setPositionY(-5)
	self._nodeDecorate:addChild(node)
	self._nodeWorldBoss = node

	self:_onEventWorldBossGetInfo()
end

function GuildCityNode:_onEventWorldBossGetInfo(event)
	if self._nodeWorldBoss then
		local bossInfo = G_UserData:getWorldBoss():getBossInfo()
		self._nodeWorldBoss:updateUI(bossInfo.hero_id)
	end
end



-- i18n change lable
function GuildCityNode:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imageName = UIHelper.swapWithLabel(self._imageName,{
			 style = "guild_1",
			 text = Lang.getImgText("txt_guild_boss04") ,
		})
		self._imageName:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	end
	if Lang.checkSquareLanguage() and not Lang.checkHorizontal() then
		self._imageName:getVirtualRenderer():setMaxLineWidth(26)
	end
end


return GuildCityNode