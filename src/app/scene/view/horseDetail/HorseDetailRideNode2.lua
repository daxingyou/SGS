

local ListViewCellBase = require("app.ui.ListViewCellBase")
local HorseDetailRideNode = class("HorseDetailRideNode", ListViewCellBase)
local CSHelper = require("yoka.utils.CSHelper")
local HorseDataHelper = require("app.utils.data.HorseDataHelper")

function HorseDetailRideNode:ctor(data)
	self._data = data
	local resource = {
		file = Path.getCSB("HorseDetailDynamicModule2", "horse"),
		binding = {

		}
	}
	HorseDetailRideNode.super.ctor(self, resource)
end

function HorseDetailRideNode:onCreate()
	local title = self:_createTitle()
	self._listView:pushBackCustomItem(title)

	local des = self:_createDes()
	self._listView:pushBackCustomItem(des)

	self._listView:doLayout()
	local contentSize = self._listView:getInnerContainerSize()
	self._listView:setContentSize(contentSize)
	self:setContentSize(contentSize)
end

function HorseDetailRideNode:_createTitle()
	local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitleWithBg2", "common"))
	title:setFontSize(22)
	title:setTitle(Lang.get("horse_detail_title_ride"))
	local widget = ccui.Widget:create()
	local titleSize = cc.size(self._listView:getContentSize().width, 50)
	widget:setContentSize(titleSize)
	title:setPosition(titleSize.width / 2, 30)
	widget:addChild(title)

	return widget
end

function HorseDetailRideNode:_createDes()
	local rideDes = ""
	local heroIds, isSuitAll = G_UserData:getHorse():getHeroIdsWithHorseId(self._data:getBase_id())
	if isSuitAll then
		rideDes = Lang.get("horse_suit_ride_all")
	else
		local strNames = ""
		local names = HorseDataHelper.getHeroNameByFilter(heroIds)
		for i, name in ipairs(names) do
			strNames = strNames..name
			if i ~= #names then
				-- i18n change punc
				if not Lang.checkLang(Lang.CN) then
					strNames = strNames..", "
				else
					strNames = strNames.."、"
				end
			end
		end
		rideDes = Lang.get("horse_suit_ride_heros", {heroNames = strNames})
	end

	local color = Colors.BRIGHT_BG_TWO

	local widget = ccui.Widget:create()
	local labelDes = cc.Label:createWithTTF(rideDes, Path.getCommonFont(), 18)
	labelDes:setAnchorPoint(cc.p(0, 1))
	labelDes:setLineHeight(22)
	labelDes:setWidth(326-20)   -- setWidth会使得setContentSize（）.width=326 不是实际宽度
	labelDes:setColor(color)

	local height = labelDes:getContentSize().height
	labelDes:setPosition(cc.p(10, height + 15))
	-- if rideDes == Lang.get("horse_suit_ride_all") then  
	-- 	labelDes:setPositionX((326-144)*0.5  ) -- 调整位置 居中
	-- end
	widget:addChild(labelDes)

	local size = cc.size(self._listView:getContentSize().width, height + 20)
	widget:setContentSize(size)

	return widget
end

return HorseDetailRideNode