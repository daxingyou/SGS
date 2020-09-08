
local CSHelper = require("yoka.utils.CSHelper")
local PopupAlert = require("app.ui.PopupAlert")
local PopupCommunity = class("PopupCommunity", PopupAlert)
local UIHelper  = require("yoka.utils.UIHelper")
local Community = require("app.config.communitysea")

local maxWidth = 570
local maxHeight = 250
local cellHeight = 90

function PopupCommunity:ctor()
    self.lang = Lang.lang
    self.optionList = {}
	PopupCommunity.super.ctor(self,Lang.getImgText("txt_community_title"), "")
end

-- Describle：
function PopupCommunity:onCreate()
	PopupCommunity.super.onCreate(self)
    
    local imgLine = UIHelper.seekNodeByName(self,"imgLine")
    imgLine:setVisible(false)
    self._descBG:setVisible(false)
	self._btnCancel:setVisible(false)
    self._btnOK:setVisible(false)
    
    local listView = self:_createListView()
    self._popupBG:addChild(listView)
end

function PopupCommunity:_createListView()
    local listView = ccui.ListView:create()
    listView:setScrollBarEnabled(false)
    listView:setSwallowTouches(false)
    listView:setAnchorPoint(cc.p(0.5, 0.5))
    listView:setPosition(cc.p(0, -20))
    listView:setDirection(ccui.ScrollViewDir.vertical)

    local len = Community.length()
    for i = 1,len,1 do
        local config = Community.indexOf(i)
        local cell = self:_createCell(config,i)
        listView:pushBackCustomItem(cell)
    end

    listView:doLayout()
    local contentSize = listView:getInnerContainerSize()
    contentSize.width = maxWidth
    local height = len*cellHeight
    if height > maxHeight then
        height = maxHeight
    end
    contentSize.height = height
    listView:setContentSize(contentSize)
    return listView
end

function PopupCommunity:_createCell(data,idx)
	local icon = UIHelper.createImage({texture = Path.get(data.res,"communitysea","ui3") })
    icon:setAnchorPoint(0,0.5)
    icon:setPosition(70,cellHeight/2)

	local desc = UIHelper.createLabel({
		text = data.webname,
		position = cc.p(160,cellHeight/2),
		color = cc.c3b(0xb4, 0x64, 0x14),
		size = 20,
		anchorPoint = cc.p(0,0.5)
	})

    local function onLangBtn(sender)
        G_NativeAgent:openURL(data.web)
    end
    local btn = CSHelper.loadResourceNode(Path.getCSB("CommonButtonLevel1Normal", "common"))
    btn:setString(Lang.get("common_btn_go_to"))
    btn:setSwallowTouches(false)
    btn:addClickEventListenerEx(onLangBtn)

    local widget = ccui.Widget:create()
    local widgetSize = cc.size(maxWidth, cellHeight)
    widget:setContentSize(widgetSize)
    btn:setPosition(maxWidth-130, cellHeight/2)
    widget:addChild(btn)
	widget:addChild(icon)
	widget:addChild(desc)

    if idx < Community.length() then
        local line = UIHelper.createImage({texture = Path.getUICommon("img_com_line01_board") })
        line:setScale9Enabled(true)
        line:setCapInsets(cc.rect(10,10,1,1))
        line:setContentSize(536,5)
        line:setPosition(maxWidth/2,0)
        widget:addChild(line)
    end

    return widget
end



return PopupCommunity