local ViewBase = require("app.ui.ViewBase")
local SwitchAvatarLayer = class("SwitchAvatarLayer", ViewBase)
local SwitchAvatarNode = require("app.scene.view.main.SwitchAvatarNode")
local SwitchSceneNode = require("app.scene.view.main.SwitchSceneNode")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local Hero = require("app.config.hero")
local MainUIHelper = require("app.scene.view.main.MainUIHelper")

local countryTexture = {
	{normal="text_visible2",highlight="text_visible1"},
	{normal="text_visible4",highlight="text_visible3"},
	{normal="text_visible6",highlight="text_visible5"},
	{normal="text_visible8",highlight="text_visible7"},
}

local dayTexture = {
	day="visble_baitian",night="visble_yewan"
}

function SwitchAvatarLayer:ctor(callback,sceneId)
	self._topbarBase = nil
	self._callback = callback
	self._listView = nil
	self._isScene = false


	self._selectAvatarId = G_UserData:getBase():getKanBanNiang()
	self._selectSceneId = G_UserData:getMainScene():getSceneId()
	self._submitSceneId = self._selectSceneId

	if sceneId then
		self._isScene = true
		self._selectSceneId = sceneId
		G_SignalManager:dispatch(SignalConst.EVENT_SWITCH_SCENE, {id=sceneId})
	end

    local resource = {
        file = Path.getCSB("SwitchAvatarLayer", "main"),
        size = G_ResolutionManager:getDesignSize(),
        binding = {
            _btnChangeAvatar = {
                events = {{event = "touch", method = "_onClickChangeAvatar"}}
			},
			_btnChangeScene = {
                events = {{event = "touch", method = "_onClickChangeScene"}}
			},
			_btnDayNight = {
                events = {{event = "touch", method = "_onDayBtn"}}
			},
			_commonTip = {
                events = {{event = "touch", method = "_onCommonTip"}}
			},
			_commonTipAvatar = {
                events = {{event = "touch", method = "_onCommonTipAvatar"}}
			}
		}
    }
    SwitchAvatarLayer.super.ctor(self, resource)
end

function SwitchAvatarLayer:onCreate()
	-- local commonHelp = ccui.Helper:seekNodeByName(self._topbarBase, "FileNode_2")
	-- commonHelp:setPositionX(170)
	-- commonHelp:updateLangName("HELP_SWITCH_AVATAR")
	-- commonHelp:setVisible(true)
	-- self._topbarBase:setItemListVisible(false)
	self._topbarBase:setCallBackOnBack(handler(self,self.onBack))
	self:setName("SwitchAvatarLayer")
	-- self._changeAvatarLabel:setString(Lang.get("switch_avatar_label"))
	-- self._changeSceneLabel:setString(Lang.get("switch_scene_label"))

	for i = 1, 4 do
		self["_btnCountry"..i]:setTag(i)
		self["_btnCountry"..i]:addClickEventListenerEx(handler(self, self._onCountryBtn))
	end
	-- self:_initData()
	-- self:_initListView()
	-- self:_showScene(self._isScene)
	-- self:_updateCountryBtn()
	-- self:_updateDayBtn()
	G_UserData:getHandBook():c2sGetHeroResPhoto()

	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topbarBase:updateUI(TopBarStyleConst.STYLE_BACKGROUND, false)
end

function SwitchAvatarLayer:_updateView()
	self:_initData()
	local data = G_UserData:getHandBook():getMainAvatarDataById(self._selectAvatarId)
	self._countryIndex = self:_getHeroCountry(data)
	self:_initListView()
	self:_showScene(self._isScene)
	self:_updateCountryBtn()
	self:_updateDayBtn()
end

function SwitchAvatarLayer:_onCountryBtn(sender)
	local tag = sender:getTag()
	if tag == self._countryIndex then
		return
	end
	self._countryIndex = tag
	self:_updateCountryBtn()
	self:_updateListView()
end

function SwitchAvatarLayer:_updateCountryBtn()
	for i = 1, 4 do
		local normal = Path.getMain2(countryTexture[i].normal)
		local highlight = Path.getMain2(countryTexture[i].highlight)
		if self._countryIndex == i then
			self["_btnCountry"..i]:loadTextureNormal(highlight)
		else
			self["_btnCountry"..i]:loadTextureNormal(normal)
		end
	end
end

function SwitchAvatarLayer:_onDayBtn(sender)
	if self._dayIndex == 1 then
		self._dayIndex = 2
	else
		self._dayIndex = 1
	end
	local isDay = self._dayIndex == 1
	self:_updateDayBtn(isDay)
	G_SignalManager:dispatch(SignalConst.EVENT_SWITCH_SCENE, {id=self._selectSceneId,dayNight = self._dayIndex})
	local items = self._listView:getItems()
	for i, value in ipairs(items) do
		if value._data.config.id == self._selectSceneId then
			value:switchIcon(self._dayIndex)
		end
	end
end

function SwitchAvatarLayer:_updateDayBtn(isDay)
	local hasNight = MainUIHelper.isSceneHasNight(self._selectSceneId)
	self._btnDayNight:setVisible(hasNight)
	if isDay == nil then
		isDay = MainUIHelper.isInDaytime()
	end
	if isDay then
		self._dayIndex = 1
		self._btnDayNight:loadTextureNormal(Path.getMain2(dayTexture.day))
	else
		self._dayIndex = 2
		self._btnDayNight:loadTextureNormal(Path.getMain2(dayTexture.night))
	end
end

function SwitchAvatarLayer:_initListView()
	self._listView:setCallback(handler(self, self._onItemUpdate))
end

function SwitchAvatarLayer:_onItemUpdate(item, index)
	local data = self._datas[index+1]
	local id = self._selectAvatarId
	if self._isScene then
		id = self._selectSceneId
	end
	item:updateIcon(data,id,handler(self, self._onItemTouch),self._dayIndex)
end

function SwitchAvatarLayer:_onItemTouch(data)
	-- print("lkm111",data:getBase_id(),data:getId(),G_UserData:getBase():getId())
	if self._isScene then
		local id = data.config.id
		if self._selectSceneId == id then
			return
		end
		G_SignalManager:dispatch(SignalConst.EVENT_SWITCH_SCENE, {id=id})
		local items = self._listView:getItems()
		for i, value in ipairs(items) do
			value:setSelected(value._data.config.id == id)
			if value._data.config.id == self._selectSceneId then
				value:switchIcon()
			end
		end
		self._selectSceneId = id
		if data.isHas then
			self._submitSceneId = id
		end
		self:_updateDayBtn()
	else
		if self._selectAvatarId == data.id then
			return
		end
		-- self._selectSpineResId = data:getStoryResSpine()
		self._selectAvatarId = data.id
		G_SignalManager:dispatch(SignalConst.EVENT_SWITCH_AVATAR, data)
		local items = self._listView:getItems()
		for i, value in ipairs(items) do
			value:setSelected(value._data.id == self._selectAvatarId)
		end
	end

end

function SwitchAvatarLayer:_updateListView(noAction)
	self:_getData()
	if self._isScene then
		self._listView:setTemplate(SwitchSceneNode)
	else
		self._listView:setTemplate(SwitchAvatarNode)
	end
	self._listView:clearAll()
	self._listView:resize(#self._datas)

	if not noAction then
		self._listView:setPositionY(-200)
		local moveAction = cc.MoveTo:create(0.15, cc.p(0, 0))
		self._listView:runAction(moveAction)
	end
end

function SwitchAvatarLayer:_initData()
	-- local heroDatas = G_UserData:getHero():getHeroListByFiltSameRes()
	self._heroDatas = {{},{},{},{}}
	-- for i, value in ipairs(heroDatas) do
	-- 	local heroCountry = self:_getHeroCountry(value)
	-- 	table.insert(self._heroDatas[heroCountry],value)
	-- end

	local heroDatas = G_UserData:getHandBook():getMainAvatarList()
	for key, value in pairs(heroDatas) do
		local heroCountry = self:_getHeroCountry(value)
		table.insert(self._heroDatas[heroCountry],value)
	end
	local sortFun = function(a, b)
		if a.config.type ~= b.config.type then
			if a.config.type == 1 then
				return true
			end
			if b.config.type == 1 then
				return false
			end
		end
		if a.color ~= b.color then
			return a.color > b.color
		else
			return a.baseId < b.baseId
		end
	end
	for i = 1, 4 do
		table.sort(self._heroDatas[i],sortFun)
	end

	self:_updateSceneData()
end

function SwitchAvatarLayer:_updateSceneData()
	self._sceneDatas = {}
	local MainScene = require("app.config.main_scene")
	local count = MainScene.length()
	for i = 1, count do
		local info = MainScene.indexOf(i)
		local isHas = false
		local list = G_UserData:getMainScene():getSceneList()
		for i, value in ipairs(list) do
			if value == info.id then
				isHas = true
				break
			end
		end
		table.insert(self._sceneDatas,{config = info,isHas = isHas})
	end
    table.sort(
        self._sceneDatas,
		function(item1, item2)
			if item1.isHas ~= item2.isHas then
				if item1.isHas == true then
					return true
				end
				return false
			end
            return item1.config.order < item2.config.order
        end
    )
end

function SwitchAvatarLayer:_getData()
	if self._isScene then
		self._datas = self._sceneDatas
	else
		self._datas = self._heroDatas[self._countryIndex]
	end
end

function SwitchAvatarLayer:_showScene(bShow)
	self._changeAvatar:setVisible(bShow)
	self._changeScene:setVisible(not bShow)
	self._isScene = bShow
	self._btnCountryList:setVisible(not bShow)
	self._btnDayList:setVisible(bShow)
	self:_updateListView()
	self._topbarBase:setItemListVisible(bShow)
end

function SwitchAvatarLayer:_onClickChangeAvatar()
	self:_showScene(false)
end

function SwitchAvatarLayer:_onClickChangeScene()
	self:_showScene(true)
end

function SwitchAvatarLayer:onEnter()
	self._signalGetHeroResPhoto =
		G_SignalManager:add(SignalConst.EVENT_GET_HERO_RES_PHOTO_SUCCESS, handler(self, self._updateView))
	self._signalBuyMainScene =
		G_SignalManager:add(SignalConst.EVENT_BUY_MAIN_SCENE, handler(self, self._onSignalBuyMainScene))
end

function SwitchAvatarLayer:onExit()
	self._signalBuyMainScene:remove()
	self._signalBuyMainScene = nil
	self._signalGetHeroResPhoto:remove()
	self._signalGetHeroResPhoto = nil

	if self._selectAvatarId ~= G_UserData:getBase():getKanBanNiang() then
		G_UserData:getBase():c2sKanbanNiang(self._selectAvatarId)
	end
	if self._submitSceneId ~= G_UserData:getMainScene():getSceneId() then
		G_UserData:getMainScene():c2sMainScene(self._submitSceneId)
	end
	G_SignalManager:dispatch(SignalConst.EVENT_SWITCH_SCENE, {id=self._submitSceneId})
end

function SwitchAvatarLayer:onBack()
	self._callback(true)
	self:removeFromParent()
end

function SwitchAvatarLayer:_getHeroCountry(data)
	local heroCountry = data.config.country
	if data.config.type == 1 then
		-- local heroBaseId = AvatarDataHelper.getShowHeroBaseIdByCheck(data)
		-- local heroConfig = Hero.get(heroBaseId)
		-- heroCountry = heroConfig.country
		-- if heroCountry == 0 then
		-- 	heroCountry = 2
		-- end
		heroCountry = 2
	end
	return heroCountry
end

function SwitchAvatarLayer:_onSignalBuyMainScene(_, param)
	local list = G_UserData:getMainScene():getSceneList()
	for i, value in ipairs(list) do
		if value == self._selectSceneId then
			self._submitSceneId = self._selectSceneId
			break
		end
	end
	self:_updateSceneData()
	self:_updateListView(true)
	-- G_Prompt:showTip(Lang.get("common_item_buy_success"))
	local PopupGetSceneShow = require("app.scene.view.main.PopupGetSceneShow")
	local popupGetSceneShow = PopupGetSceneShow.new(self._selectSceneId)
	popupGetSceneShow:open()
end

function SwitchAvatarLayer:_onCommonTip(sender)
	local posX = self._btnDayList:getPositionX() - 70 - G_ResolutionManager:getBangDesignWidth()/2 - 240
	local popup = require("app.scene.view.main.PopupSceneTip").new(cc.p(posX, 250),Lang.get("HELP_SWITCH_AVATAR"))
	popup:open()
end

function SwitchAvatarLayer:_onCommonTipAvatar(sender)
	local posX = self._changeScene:getPositionX() - 0 - G_ResolutionManager:getBangDesignWidth()/2 - 240
	local popup = require("app.scene.view.main.PopupSceneTip").new(cc.p(posX, 250),Lang.get("HELP_SWITCH_AVATAR_1"))
	popup:open()
end

return SwitchAvatarLayer
