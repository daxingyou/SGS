
-- Author: nieming
-- Date:2018-04-24 16:06:13
-- Describle：

local ViewBase = require("app.ui.ViewBase")
local FriendEnemyList = class("FriendEnemyList", ViewBase)
local EnemyHelper = require("app.scene.view.friend.EnemyHelper")
function FriendEnemyList:ctor()

	--csb bind var name
	self._btnPopLog = nil  --CommonButtonHighLight
	self._imageRoot = nil  --ImageView
	self._listView = nil  --ScrollView
	self._num = nil  --Text
	self._enemysData = {}
	local resource = {
		file = Path.getCSB("FriendEnemyList", "friend"),
		binding = {
			_btnPopLog = {
				events = {{event = "touch", method = "_onBtnPopLog"}}
			},
		},
	}
	FriendEnemyList.super.ctor(self, resource)
end

-- Describle：
function FriendEnemyList:onCreate()
	-- i18n  lable
	self:_dealI18n()
	self:_dealPosByI18n()
	self:_initListView()
	self._btnPopLog:setString(Lang.get("lang_friend_enemy_btn_log"))
end

-- Describle：
function FriendEnemyList:onEnter()

end

-- Describle：
function FriendEnemyList:onExit()

end

-- Describle：
function FriendEnemyList:_onBtnPopLog()
	-- body
	-- local pop = require("app.scene.view.friend.PopupEnemyLog").new()
	-- pop:openWithAction()
	G_SceneManager:showDialog("app.scene.view.friend.PopupEnemyLog")
end
function FriendEnemyList:_initListView()
	-- body
	local FriendEnemyListViewCell = require("app.scene.view.friend.FriendEnemyListViewCell")
	self._listView:setTemplate(FriendEnemyListViewCell)
	self._listView:setCallback(handler(self, self._onListViewItemUpdate), handler(self, self._onListViewItemSelected))
	self._listView:setCustomCallback(handler(self, self._onListViewItemTouch))

end



function FriendEnemyList:updateView()
	self._enemysData = G_UserData:getEnemy():getEnemysData()
	self._listView:resize(#self._enemysData)
	self._num:setString(string.format("%s/%s", G_UserData:getEnemy():getCount(), EnemyHelper.getDayMaxRevengeNum()))
end

-- Describle：
function FriendEnemyList:_onListViewItemUpdate(item, index)
	local data = self._enemysData[index + 1]
	item:updateUI(data, index + 1)
end

-- Describle：
function FriendEnemyList:_onListViewItemSelected(item, index)

end

-- Describle：
function FriendEnemyList:_onListViewItemTouch(index, params)

end



-- i18n  lable
function FriendEnemyList:_dealI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		local text1 = UIHelper.seekNodeByName(self._resourceNode,"Text_1")
		local size = text1:getContentSize()
		self._num:setAnchorPoint(cc.p(0,0.5))
		self._num:setPositionX(text1:getPositionX() + size.width)

		local text1 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_0")
		local text2 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_1")
		local text3 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_2")
		local text4 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_2_0")
		local text5 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_2_0_0")
	
		
		
		local image1 = UIHelper.seekNodeByName(self._imageRoot,"Image_13")
		local image2 = UIHelper.seekNodeByName(self._imageRoot,"Image_13_2")
		local image3 = UIHelper.seekNodeByName(self._imageRoot,"Image_13_2_0")
		local image4 = UIHelper.seekNodeByName(self._imageRoot,"Image_13_2_0_0")
		local image5 =  UIHelper.seekNodeByName(self._imageRoot,"Image_13_2_0_1")
	

		
		text2:setPositionX(text2:getPositionX() - 55 )
		text3:setPositionX(text3:getPositionX() - 67 )
		text4:setPositionX(text4:getPositionX() - 27-4)
		text5:setPositionX(text5:getPositionX() + 10)

		image1:setPositionX(image1:getPositionX() - 40-6)
		image2:setPositionX(image2:getPositionX() - 70+6)
		image3:setPositionX(image3:getPositionX() - 55-6)
		image4:setPositionX(image4:getPositionX()+6)
		image5:setPositionX(image5:getPositionX()+11)
	end
end

-- i18n pos lable
function FriendEnemyList:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        local image132 = UIHelper.seekNodeByName(self._imageRoot,"Image_13_2_0_1")
        --image132:setVisible(false)
	end
end


return FriendEnemyList
