local CSHelper = require("yoka.utils.CSHelper")
local PopupAlert = require("app.ui.PopupAlert")

local SwitchLanguageHelper = {}

function SwitchLanguageHelper.showSwitchButton(target)
    local platform = G_NativeAgent:getNativeType()
    if platform == "windows" or platform == "mac" or CONFIG_SHOW_SWITCH_LANGUAGE then
        local function onSwitchBtn()
            local alert = PopupAlert.new("ChooseLanguage", "")
            alert:openWithAction()
            local listView = SwitchLanguageHelper._createListView()
            alert._descBG:addChild(listView)
            alert._btnOK:setVisible(false)
            alert._btnCancel:setVisible(false)
        end
        local btn = CSHelper.loadResourceNode(Path.getCSB("CommonButtonLevel0Highlight", "common"))
        btn:setString("SwitchLang")
        btn:addClickEventListenerEx(onSwitchBtn)
        target:addChild(btn)
        btn:setPosition(110,580)
    end
end

function SwitchLanguageHelper._createListView()
    local listView = ccui.ListView:create()
    listView:setScrollBarEnabled(false)
    listView:setSwallowTouches(false)
    listView:setAnchorPoint(cc.p(0, 0))
    listView:setPosition(cc.p(0, 0))
    listView:setDirection(ccui.ScrollViewDir.horizontal)

    -- local langList = SwitchLanguageHelper._getLangList()
    local langList = table.values(Lang.langList)
    table.sort(langList)
    for i,v in ipairs(langList) do
        local btn = SwitchLanguageHelper._createLangBtn(v)
        listView:pushBackCustomItem(btn)
    end

    listView:doLayout()
    local contentSize = listView:getInnerContainerSize()
    contentSize.width = 442
    contentSize.height = 159
    listView:setContentSize(contentSize)
    return listView
end

function SwitchLanguageHelper._createLangBtn(lang)
    local function onLangBtn(sender)
        local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
        local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
        if moveOffsetX < 20 and moveOffsetY < 20 then
            if Lang.lang == lang then
                return
            end
            Lang.lang = lang
            Lang._writeStorage()
            G_GameAgent:reloadModule()
        end
    end
    local csb = "CommonButtonLevel2Highlight"
    if Lang.lang == lang then
        csb = "CommonButtonLevel2Normal"
    end
    local btn = CSHelper.loadResourceNode(Path.getCSB(csb, "common"))
    btn:setString(lang)
    btn:setSwallowTouches(false)
    btn:addClickEventListenerEx(onLangBtn)

    local widget = ccui.Widget:create()
    local widgetSize = cc.size(140, 80)
    widget:setContentSize(widgetSize)
    btn:setPosition(70, 40)
    widget:addChild(btn)

    return widget
end

function SwitchLanguageHelper._getLangList()
    local langList = {}
    local langFolder = "res/i18n/"
    local fileUtils = cc.FileUtils:getInstance()
    local files = fileUtils:listFiles(langFolder)
    for i, value in ipairs(files) do
        if fileUtils:isDirectoryExist(value) then
            local start,stop = string.find(value,langFolder)
            local name = string.sub(value,stop+1,-2)
            if name ~= "." and name ~= ".." and name ~= "base" then
                table.insert(langList,name)
            end
        end
    end
    if #langList <= 0 then
        langList = {Lang.VN,Lang.CN,Lang.ZH,Lang.JA}
    end
    return langList
end

return SwitchLanguageHelper