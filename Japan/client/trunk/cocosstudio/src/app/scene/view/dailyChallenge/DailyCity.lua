local ViewBase = require("app.ui.ViewBase")
local DailyCity = class("ChallengeView", ViewBase)
local ShaderHalper = require("app.utils.ShaderHelper")
local PopupDailyChoose = require("app.scene.view.dailyChallenge.PopupDailyChoose")
local DailyDungeon = require("app.config.daily_dungeon")

function DailyCity:ctor(info)
    self._info = info
    self._btnCity = nil     --城市按钮
    -- self._textOpenDate = nil   --开启时间
   
    self._imageName = nil  --名字图片
    self._openDays = {}     --开放时间
    self._open = false      --今天是否开放
    self._tipString = ""    --关闭时候点击提示
    self._commonRedPointNum = nil--红点组件
    self._firstLevel = 0    --初次开放等级
    self._imageCloseBG = nil    --关闭背景
    self._textCloseTip = nil    --关闭提示
    self._bLevelEnough = false --是否够等级开放
	local resource = {
		file = Path.getCSB("DailyCity", "dailyChallenge"),
		size = {1136, 640},
		binding = {
            _btnCity = {
				events = {{event = "touch", method = "_onCityClick"}}
			},
		}
	}
    self:setName("DailyCity"..info.id)
	DailyCity.super.ctor(self, resource)
end

function DailyCity:onCreate()
    --self._textName:setString(self._info.name)
-- i18n change lable
    self:_swapImageByI18n()


    local cityNameX = self._info.x_position
    local cityNameY = self._info.y_position
    --日文特殊处理
    if Lang.checkLang(Lang.JA) then
      
        self:_dealCityFormatByI18n(cityNameX,cityNameY)
    else
        -- i18n change lable
        if not Lang.checkLang(Lang.CN) then
            self._imageName:setString(Lang.getImgText(self._info.pic))
        else
            self._imageName:loadTexture(Path.getChallengeText(self._info.pic))
            self._imageName:ignoreContentAdaptWithSize(true)
        end
    
        local imageNameSize = self._imageName:getContentSize()
        local imageNameBgSize = self._imageNameBG:getContentSize()
        imageNameBgSize.height = imageNameSize.height + 40

        self._imageNameBG:setContentSize(imageNameBgSize)
        self._imageNameBG:setPosition(cityNameX,cityNameY)

        -- i18n change lable
        if not Lang.checkLang(Lang.CN) then
            self._imageName:setPositionX(imageNameBgSize.width*0.5)
        end

        self._imageName:setPositionY(imageNameBgSize.height*0.5)
        self._commonRedPointNum:setPositionY(imageNameBgSize.height-6)
    end
	self._openDays = {}
	for i = 1,string.len(self._info.week_open_queue) do
		self._openDays[i] = string.byte(self._info.week_open_queue,i) == 49
	end

end

function DailyCity:refreshData()
    local todayLevel = G_UserData:getBase():getToday_init_level()--登陆时等级
    local nowLevel = G_UserData:getBase():getLevel()--当前等级
    if not self:_isLevelEnough() then
        self._open = false
    else
        if self:_isOpenToday() then
            self._open = true
        elseif todayLevel < self._firstLevel and nowLevel >= self._firstLevel then
            --上线等级小于进入等级，升级后大于进入等级
            self._open = true
        else
            local days = self:_getOpenDays()
            local strDays = ""
            local strDays2 = ""
            for i = 1, #days-1 do
                strDays = strDays..Lang.get("open_days")[days[i]]..", "
                strDays2 = strDays..Lang.get("open_days")[days[i]]
            end
            strDays = strDays..Lang.get("open_days")[days[#days]]
            self._tipString = Lang.get("open_string", {str = strDays})
            self._open = false
        end
    end
    --self._imageCloseBG:setVisible(not self._open)
    self._textCloseTip:setString(self._tipString)
    --self._textCloseTip:setVisible(not self._open)

    self:_refreshState()

end

function DailyCity:_refreshState()
    -- self._imageRes:loadTexture(Path.getDailyChallengeIcon("build"..self._info.build))
    -- self._imageRes:ignoreContentAdaptWithSize(true)
    -- i18n change lable
    if not Lang.checkLang(Lang.CN) then
        if Lang.checkUI("ui4") then   
            local UIHelper  = require("yoka.utils.UIHelper")
            UIHelper.setLabelStyle(self._imageName,{
                style = self._open and "challenge_2_ui4" or "challenge_4_ui4",
                text = Lang.getImgText(self._info.pic  ),
            })
            self:setNameBgGray(not self._open)
        else
            local UIHelper  = require("yoka.utils.UIHelper")
            UIHelper.setLabelStyle(self._imageName,{
                style = self._open and "challenge_2" or "challenge_3",
                text = Lang.getImgText(self._info.pic  ),
            })
            --i18n
            self:_dealHorizontal()
        end
        
    else
       self._imageName:loadTexture(Path.getChallengeText(
		        self._open and self._info.pic or self._info.pic.."b" 
	   ))
    end

    if self._open then

     
    elseif not self._open and not self._bLevelEnough then
       
    else
    
    end

end

--今天是否开放
function DailyCity:_isOpenToday()
    local TimeConst = require("app.const.TimeConst")
	local data = G_ServerTime:getDateObject(nil,TimeConst.RESET_TIME_SECOND)
	return self._openDays[data.wday]
end

-- 所有开放日期
function DailyCity:_getOpenDays( )
	local openDays = {}
	for i,open in ipairs(self._openDays) do
		if open then
			table.insert(openDays,i)
		end
	end
    local sortfunction = function(obj1,obj2)
        if obj1 == 1 or obj2 == 1 then
            return obj1 ~= 1
        end
        return obj1 < obj2
    end
    table.sort( openDays, sortfunction )
	return openDays
end

--等级是否到达
function DailyCity:_isLevelEnough()
    local myLevel = G_UserData:getBase():getLevel()
    local firstLevel = self:_getFirstLevel()
    self._tipString = Lang.get("daily_open_tips", {count = firstLevel, name = self._info.name})
    self._bLevelEnough = (myLevel >= firstLevel)
    return myLevel >= firstLevel
end

--获得第一个难度的等级
function DailyCity:_getFirstLevel()
    local DailyDungeonCount = DailyDungeon.length()
	for i = 1, DailyDungeonCount do
		local info = DailyDungeon.indexOf(i)
		if info.type == self._info.id and info.pre_id == 0 then
            self._firstLevel = info.level
            return self._firstLevel
		end
	end
end

--点击
function DailyCity:_onCityClick()
    if self._open then
        local popupDailyChoose = PopupDailyChoose.new(self._info)
        popupDailyChoose:openWithAction()
    else
        G_Prompt:showTip(self._tipString)
    end
end

function DailyCity:onEnter()
    self._signalRedPointUpdate = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self,self._onEventRedPointUpdate))
    self._signalDailyDungeonEnter = G_SignalManager:add(SignalConst.EVENT_DAILY_DUNGEON_ENTER, handler(self,self._onEventDailyDungeonEnter))
    
    self:refreshData()

    self:_refreshRedPoint()
end

function DailyCity:onExit()
    self._signalRedPointUpdate:remove()
    self._signalRedPointUpdate = nil

    self._signalDailyDungeonEnter:remove()
    self._signalDailyDungeonEnter  = nil
end


function DailyCity:_onEventRedPointUpdate(event,funcId,param)
	if funcId ==  FunctionConst.FUNC_DAILY_STAGE then	
		self:_refreshRedPoint()
    end
end

function DailyCity:_onEventDailyDungeonEnter(event)
    self:refreshData()

end

function DailyCity:_refreshRedPoint()
    local showRedPoint = G_UserData:getDailyDungeonData():dungeonIsHasRemainCountRedPoint(self._info.id)
    self._commonRedPointNum:setVisible(showRedPoint)
    self._commonRedPointNum:showNum(G_UserData:getDailyDungeonData():getRemainCount(self._info.id) )
end


-- i18n change lable
function DailyCity:_swapImageByI18n()
   if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imageName = UIHelper.swapWithLabel(self._imageName,{
			 style = "challenge_2",
			--  text = Lang.getImgText("txt_baowuijinglianshi03") , -- i18n ja
		})

        self._imageName:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)

   
    end
    if Lang.checkHorizontal() then
        self._imageNameBG:setScale(1)
		self._imageNameBG:setScale9Enabled(true)
		self._imageNameBG:setCapInsets(cc.rect(40,10,55,1))
        self._imageNameBG:loadTexture(Path.getHomelandUI("img_homeland_02_h"))
        self._imageName:ignoreContentAdaptWithSize(true)
        self._imageName:setFontSize(20)
    end
    if Lang.checkUI("ui4") then
        self._imageName:getVirtualRenderer():setMaxLineWidth(26)
    end
end

-- i18n
function DailyCity:_dealHorizontal()
    if Lang.checkHorizontal() then
        
        local width = self._imageName:getContentSize().width + 50
        self._imageNameBG:setContentSize(cc.size(width,28))
        self._imageName:setPosition(width/2,14)
        self._commonRedPointNum:setPosition(width,28)
	end
end

-- i18n
function DailyCity:_dealCityFormatByI18n(cityNameX,cityNameY)
    if  Lang.checkUI("ui4") then  
        self._imageNameBG:setScale(1)
        self._imageNameBG:setScale9Enabled(false)
        local UIHelper  = require("yoka.utils.UIHelper")
        UIHelper.setLabelStyle(self._imageName,{
            style = "challenge_2_ui4" ,
            text = Lang.getImgText(self._info.pic  ),
        })  
        self._imageName:setAnchorPoint(cc.p(0.5, 1))   
        self._imageName:getVirtualRenderer():setMaxLineWidth(24)  
        UIHelper.loadCommonBgImageByI18n( self._imageNameBG,Lang.getImgText(self._info.pic))
        self._imageNameBG:ignoreContentAdaptWithSize(true)
        local imageNameBgSize = self._imageNameBG:getContentSize()
        local imageNameBgVirtualSize = self._imageNameBG:getVirtualRendererSize()

        self._imageName:setPositionY(imageNameBgVirtualSize.height-36)
        self._imageName:setPositionX(imageNameBgVirtualSize.width/2)
        self._imageNameBG:setPosition(cc.p(cityNameX,cityNameY))

        self._commonRedPointNum:setPositionY(imageNameBgVirtualSize.height-8)
	end
end

-- i18n
function DailyCity:setCitySize(size)
    self._btnCity:setContentSize(size)
end

-- i18n ja
function DailyCity:setNameBgGray(bGray)
    local state = "ShaderPositionTextureColor_noMVP"
    if bGray then
        state = "ShaderUIGrayScale"
    end
    local p_state = cc.GLProgramState:getOrCreateWithGLProgramName(state)
    local render = self._imageNameBG:getVirtualRenderer():getSprite()
    render:setGLProgramState(p_state)
end

return DailyCity