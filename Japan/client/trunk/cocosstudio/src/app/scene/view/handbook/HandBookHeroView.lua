
-- Author: hedili
-- Date:2017-10-14 12:53:45
-- Describle：

local ViewBase = require("app.ui.ViewBase")
local HandBookHeroView = class("HandBookHeroView", ViewBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local HandBookViewCell = import(".HandBookViewCell")

local START_COLOR = 6

function HandBookHeroView:ctor(owner, index)

	--csb bind var name
	self._listViewTab = nil  --ScrollView
	self._commonFullScreen = nil  --CommonFullScreen
	self._tabGroup2 = nil  --CommonTabGroup

	self._title = title or Lang.get("handbook_tab"..index)
	self._callback = callback

	self._selectTabIndex = 0
	local resource = {
		file = Path.getCSB("HandBookHeroView", "handbook"),
		
	}
	HandBookHeroView.super.ctor(self, resource)
end

-- Describle：
function HandBookHeroView:onCreate()
	
-- i18n change lable
	self:_dealByI18n()
	--self._commonFullScreen:addCloseEventListener(handler(self, self.onBtnCancel))
	self._commonFullScreen:setTitle(self._title)

	local param = {
		callback = handler(self, self._onTabSelect),
		isVertical = 2,
		textList = { Lang.get("handbook_country_tab1"),
		Lang.get("handbook_country_tab2"),
		Lang.get("handbook_country_tab3"),
		Lang.get("handbook_country_tab4")}
	}

	self._nodeTabRoot:recreateTabs(param)

	self._nodeTabRoot:setTabIndex(1)
end

--
function HandBookHeroView:_onTabSelect(index, sender)
	if self._selectTabIndex == index then
		return
	end
	self._selectTabIndex = index


	self:_updateListView(index)
end

function HandBookHeroView:_updateListView(index)
	local infos, counts = G_UserData:getHandBook():getHeroInfos()


	self._heroInfos = infos
	self._heroOwnerCount = counts

	if self._heroInfos[index] == nil then
		return
	end
	self._listViewTab:clearAll()
	self:_updateSelectTab(index)
	for color = START_COLOR, 2, -1 do
		local heroArray = self._heroInfos[index][color]
		local heroOwnerCount = self._heroOwnerCount[index][color]
		if heroArray and type(heroArray) == "table" then
			local cell = HandBookViewCell.new()
			cell:updateUI(TypeConvertHelper.TYPE_HERO, color, heroArray, heroOwnerCount)
			self._listViewTab:pushBackCustomItem(cell)
		end
	end
	self._listViewTab:jumpToTop()
end


function HandBookHeroView:_updateSelectTab(index)
	local country =  self._heroOwnerCount[index]
	country.totalNum = country.totalNum or 0
	if country and country.ownNum and  country.totalNum then
	--	local percent = math.floor(country.ownNum / country.totalNum * 100)
		--self._loadingBarExp:setPercent(percent)
	end

	if country.ownNum == country.totalNum then
		self._textCountryNum1:setColor(Colors.DARK_BG_TWO)
		self._textCountryNum2:setColor(Colors.DARK_BG_TWO )
	else
		self._textCountryNum1:setColor(Colors.DARK_BG_RED)
		self._textCountryNum2:setColor(Colors.DARK_BG_TWO )
	end

	self._textCountryNum1:setString(country.ownNum)

	local num2Pos = self._textCountryNum1:getPositionX() + self._textCountryNum1:getContentSize().width
	self._textCountryNum2:setString("/"..country.totalNum)
	self._textCountryNum2:setPositionX(num2Pos+2)
	self._textCountryProcess:setString(Lang.get("handbook_country"..index))
end


function HandBookHeroView:onEnter()

end

function HandBookHeroView:onExit()

end

-- i18n change lable
function HandBookHeroView:_dealByI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._textCountryProcess:setPositionX(self._textCountryProcess:getPositionX() - 14 )	
	end
end



return HandBookHeroView
