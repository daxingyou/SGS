
-- Author: hedili
-- Date:2018-05-02 15:59:38
-- Describle：
local HomelandHelp = {}
local HomelandConst = require("app.const.HomelandConst")

function HomelandHelp.getSubTreeCfg(treeData)
	local subTreeType, currLevel = treeData.treeId, treeData.treeLevel
	local currData =  G_UserData:getHomeland():getSubTreeCfg(subTreeType,currLevel)
	if G_UserData:getHomeland():isSubTreeLevelMax(subTreeType,currLevel) then
		return currData
	end
	local nextData =  G_UserData:getHomeland():getSubTreeCfg(subTreeType,currLevel + 1 )
	return currData, nextData
end


function HomelandHelp.getMainTreeCfg(treeData)
	local currLevel = treeData.treeLevel
	local currData =  G_UserData:getHomeland():getMainTreeCfg(currLevel)
	if G_UserData:getHomeland():isMainTreeLevelMax(currLevel) then
		return currData
	end
	local nextData =  G_UserData:getHomeland():getMainTreeCfg(currLevel + 1 )
	return currData, nextData
end



function HomelandHelp.getSelfSubTreeCfg(subTreeType)
	local currLevel = G_UserData:getHomeland():getSubTreeLevel(subTreeType)
	--dump(currLevel)
	local currData =  G_UserData:getHomeland():getSubTreeCfg(subTreeType,currLevel)
	if G_UserData:getHomeland():isSubTreeLevelMax(subTreeType) then
		return currData
	end
	local nextData =  G_UserData:getHomeland():getSubTreeCfg(subTreeType,currLevel + 1 )
	return currData, nextData
end


function HomelandHelp.getSelfMainTreeCfg()
	local currLevel = G_UserData:getHomeland():getMainTreeLevel()
	local currData =  G_UserData:getHomeland():getMainTreeCfg(currLevel)
	if G_UserData:getHomeland():isMainTreeLevelMax() then
		return currData
	end
	local nextData =  G_UserData:getHomeland():getMainTreeCfg(currLevel + 1 )
	return currData, nextData
end


function HomelandHelp.getPromptContent(attrId, value)
	local TextHelper = require("app.utils.TextHelper")
	local absValue = math.abs(value)
	local attrName, attrValue = TextHelper.getAttrBasicText(attrId, absValue)
	local color = value >= 0 and Colors.colorToNumber(Colors.getColor(2)) or Colors.colorToNumber(Colors.getColor(6))
	local outlineColor = value >= 0 and Colors.colorToNumber(Colors.getColorOutline(2)) or Colors.colorToNumber(Colors.getColorOutline(6))
	attrValue = value >= 0 and " + "..attrValue or " - "..attrValue
	local attrContent = Lang.get("homeland_all_text")..attrName..attrValue
	dump(attrContent)
	local content = Lang.get("summary_attr_change", {attr = attrContent, color = color, outlineColor = outlineColor})
	return content
end

function HomelandHelp.getPromptPower(allPower)


	local value = math.abs(allPower)
	local attrValue = allPower
	local color = value >= 0 and Colors.colorToNumber(Colors.getColor(2)) or Colors.colorToNumber(Colors.getColor(6))
	local outlineColor = value >= 0 and Colors.colorToNumber(Colors.getColorOutline(2)) or Colors.colorToNumber(Colors.getColorOutline(6))
	attrValue = value >= 0 and " + "..attrValue or " - "..attrValue
	local attrContent = Lang.get("homeland_power")..attrValue

	local content = Lang.get("summary_attr_change", {attr = attrContent, color = color, outlineColor = outlineColor})
	return content
end


function HomelandHelp.getSubTreeAttrList( subTreeType )
	-- body
	local currData = HomelandHelp.getSelfSubTreeCfg(subTreeType)
	local power = currData["all_combat"]
	local attrList = {}
	for i = 1, 4 do 
		local attrType = currData["attribute_type"..i]
		local attrValue = currData["attribute_value"..i]
		if attrType > 0 then
			table.insert( attrList, {type = attrType, value = attrValue} )
		end
	end
	return attrList,power
end

function HomelandHelp.checkMainTreeLevel(  nextCfg, showPrompt )
	local limitList = {}
	local function subTreeType( name )
		-- body
		if showPrompt then
			G_Prompt:showTip(Lang.get("homeland_sub_tree_limit",{name = name}))
		end
		return false
	end

	for i = 1 , 2 do
		local subType = nextCfg["adorn_type_"..i]
		local subLevel = nextCfg["adorn_level_"..i]
		if subType and subType > 0 and subLevel and subLevel > 0 then
			local subCfg = G_UserData:getHomeland():getSubTreeCfg(subType, subLevel)
			table.insert(limitList, {type = subType, level = subLevel, name = subCfg.name})
		end
	end
	local mainTreeLevel = G_UserData:getHomeland():getMainTreeLevel()
	
	for i, value in ipairs(limitList) do
		local subLevel = G_UserData:getHomeland():getSubTreeLevel(value.type)
		if subLevel < value.level then
			return subTreeType(value.name)
		end
	end
	return true
end

function HomelandHelp.checkSubTreeLevel(  nextCfg, showPrompt )
	-- body
	local function subTreeType( name )
		-- body
		if showPrompt then
			G_Prompt:showTip(Lang.get("homeland_sub_tree_limit",{name = name}))
		end
		return false
	end

	local limitList= {}
	if nextCfg.limit_tree_level > 0 then
		table.insert(limitList, {type = 0, level = nextCfg.limit_tree_level, name = Lang.get("homeland_main_tree")})
	end

	for i = 1 , 2 do
		local subType = nextCfg["adorn_type_"..i]
		local subLevel = nextCfg["adorn_level_"..i]
		if subType and subType > 0 and subLevel and subLevel > 0 then
			local subCfg = G_UserData:getHomeland():getSubTreeCfg(subType, subLevel)
			dump(subCfg.name)
			table.insert(limitList, {type = subType, level = subLevel, name = subCfg.name})
		end
	end
	
	for i, value in ipairs(limitList) do
		if value.type == 0 then
			local mainTreeLevel = G_UserData:getHomeland():getMainTreeLevel()
			if mainTreeLevel < value.level then
				return subTreeType(value.name)
			end
		else
			local subLevel = G_UserData:getHomeland():getSubTreeLevel(value.type)
			if subLevel < value.level then
				return subTreeType(value.name)
			end
		end

	end
	return true
end

--检查神树升级条件
function HomelandHelp.checkMainTreeUp( treeData, showPrompt )
	-- body
	if showPrompt == nil then
		showPrompt = true
	end

	local currLevel = treeData.treeLevel


	if G_UserData:getHomeland():isMainTreeLevelMax(currLevel) then
		return false
	end
	
	local cfg = treeData.treeCfg
	local nextCfg = G_UserData:getHomeland():getMainTreeCfg(currLevel + 1)
	local currCfg = G_UserData:getHomeland():getMainTreeCfg(currLevel)

	if HomelandHelp.checkMainTreeLevel(nextCfg,showPrompt) == false then
		return false
	end

	local LogicCheckHelper = require("app.utils.LogicCheckHelper")
	local enoughCheck = LogicCheckHelper.enoughValue(currCfg.type,currCfg.value,currCfg.size, showPrompt)

	local function prompt(cfg)
		if showPrompt then
			local PopupItemGuider = require("app.ui.PopupItemGuider").new(Lang.get("way_type_get"))
			PopupItemGuider:updateUI(cfg.type,cfg.value)
			PopupItemGuider:openWithAction()
		end
	end

	if enoughCheck == false then
		--prompt(cfg)
		return false
	end


	return true
end

function HomelandHelp.checkSubTreeUpLevelEnough( subCfg )

	local mainTreeLevel = G_UserData:getHomeland():getMainTreeLevel()
	if mainTreeLevel  < nextCfg.limit_tree_level then
		return true
	end
	return false
end

function HomelandHelp.checkSubTreeUp( treeData , showPrompt)
	-- body

	if showPrompt == nil then
		showPrompt = true
	end

	local currLevel = treeData.treeLevel


	local nextCfg = G_UserData:getHomeland():getSubTreeCfg(treeData.treeId,currLevel+1)
	if nextCfg == nil then
		return false
	end

	if HomelandHelp.checkSubTreeLevel(nextCfg,showPrompt) == false then
		return false
	end
	
	if not Lang.checkLang(Lang.CN) and currLevel == 0 then
		return false
	end
	local currCfg = G_UserData:getHomeland():getSubTreeCfg(treeData.treeId,currLevel)
	local mainTreeLevel = G_UserData:getHomeland():getMainTreeLevel()

--	dump(cfg)
--	dump(mainTreeLevel)
	if mainTreeLevel  < nextCfg.limit_tree_level then
		if showPrompt then
			G_Prompt:showTip(Lang.get("homeland_main_tree_limit"))
		end
		return false
	end

	local function prompt(type, value)
		if showPrompt then
			local PopupItemGuider = require("app.ui.PopupItemGuider").new(Lang.get("way_type_get"))
			PopupItemGuider:updateUI(type,value)
			PopupItemGuider:openWithAction()
		end
	end

	local function checkEnoughValue()
		local LogicCheckHelper = require("app.utils.LogicCheckHelper")
		for i = 1 , 2 do
			if currCfg["type_"..i] > 0 then
				local type = currCfg["type_"..i]
				local value = currCfg["value_"..i]
				local size = currCfg["size_"..i]
				local enoughCheck = LogicCheckHelper.enoughValue(type,value,size, showPrompt)
				if enoughCheck == false then
					prompt(type,value)
					return false
				end
			end
		end
		return true
	end

	if checkEnoughValue() == false then
		return false
	end

	return true
end


function HomelandHelp.createSpine( cfgData )

	local spineNode = require("yoka.node.SpineNode").new()
	spineNode:setAsset( Path.getEffectSpine(data.name) )
	--spineNode:setPosition(cc.p(data.x_coordinate, data.y_coordinate))
	spineNode:setAnimation(data.animation,true)
	spineNode:setScaleX(data.orientation)
	return spineNode
	

	-- body
end

function HomelandHelp.getSubTreeFontHeight( treeData )
	-- body
	if treeData.treeId == 1 then
		return cc.size(28,95)
	elseif treeData.treeId == 2 or treeData.treeId == 3 or 
			treeData.treeId == 4 then
		return cc.size(28,118)
	elseif treeData.treeId == 5 or treeData.treeId == 6 then
		return cc.size(28,146)
	end
	return cc.size(28,146)
end
function HomelandHelp.updateNodeTreeTitle( rootNode, treeData )
	if Lang.checkHorizontal() then
		HomelandHelp.updateNodeTreeTitleHorizontal(rootNode, treeData)
		return
	end
	-- body
	local Node_treeTitle = rootNode:getSubNodeByName("Node_treeTitle")
	if treeData.treeId == 0 then
		local Image_bk = Node_treeTitle:getSubNodeByName("Image_bk")
		local path =  Path.getTextHomeland("txt_homeland_tree0"..treeData.treeLevel)

		if treeData.treeLevel >= 10 then
			path = Path.getTextHomeland("txt_homeland_tree"..treeData.treeLevel) 
		end
		dump(path)
		

		if not Lang.checkLang(Lang.CN) then
			local UIHelper  = require("yoka.utils.UIHelper")
			local image1 = UIHelper.seekNodeByName(Node_treeTitle,"Image_title")
	
			
			if image1.loadTexture then
				 local label = UIHelper.swapWithLabel(image1,{
					style = "homeland_tree_"..treeData.treeLevel,
					fontSize = 22,
					text = Lang.getImgText("txt_homeland_tree",{value = treeData.treeLevel}) ,
				})
				label:setAnchorPoint(cc.p(0.5,0.5))
				label:setPositionY(-57)
				label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		
			else
				UIHelper.setLabelStyle(image1,{
					style = "homeland_tree_"..treeData.treeLevel,
					text = Lang.getImgText("txt_homeland_tree",{value = treeData.treeLevel}) ,
				})	
			end

			
		else
			Node_treeTitle:updateImageView("Image_title", {
				texture = path
			})
		end

		if treeData.treeLevel > 10 then
			Image_bk:setContentSize(cc.size(34,174))
		else
			Image_bk:setContentSize(cc.size(34,146))
		end

		if not Lang.checkLang(Lang.CN) then
			local UIHelper  = require("yoka.utils.UIHelper")
			local image1 = UIHelper.seekNodeByName(Node_treeTitle,"Image_title")
			image1:setPositionY(57-Image_bk:getContentSize().height*0.5)
		end
		
	else
		if treeData.treeLevel == 0 then
			Node_treeTitle:setVisible(false)
			return
		end
		Node_treeTitle:setVisible(true)
		local Image_bk = Node_treeTitle:getSubNodeByName("Image_bk")
		--local Image_level = Node_treeTitle:getSubNodeByName("Image_level")
		
		-- i18n change lable
		if not Lang.checkLang(Lang.CN) then
			local UIHelper  = require("yoka.utils.UIHelper")
			local image1 = UIHelper.seekNodeByName(Node_treeTitle,"Image_title")

			if image1.loadTexture then
				local label = UIHelper.swapWithLabel(image1,{
					style = "homeland_1",
					fontSize = 20,
					text = Lang.getImgText("txt_homeland_decorate"..treeData.treeId) ,
				})
				label:setAnchorPoint(cc.p(0.5,0.5))
				label:setPositionY(-57)
				label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
			else
				UIHelper.setLabelStyle(image1,{
					style = "homeland_1",
					text = Lang.getImgText("txt_homeland_decorate"..treeData.treeId) ,
				})	
			end

			
		else
			Node_treeTitle:updateImageView("Image_title", {
				texture = Path.getTextHomeland("txt_homeland_decorate"..treeData.treeId)
			})
	
		end


		Image_bk:setContentSize(HomelandHelp.getSubTreeFontHeight(treeData))

		if not Lang.checkLang(Lang.CN) then
			local UIHelper  = require("yoka.utils.UIHelper")
			local image1 = UIHelper.seekNodeByName(Node_treeTitle,"Image_title")
			image1:setPositionY(57-Image_bk:getContentSize().height*0.5)
		end
		Node_treeTitle:updateLabel("Text_level", Lang.get("homeland_sub_tree_level"..treeData.treeLevel))
		if Lang.checkLang(Lang.TW) then
			
		elseif not Lang.checkLang(Lang.CN) then
			local label = ccui.Helper:seekNodeByName(Node_treeTitle, "Text_level" )
			local size = label:getContentSize()
			label:setContentSize(cc.size(90,size.height))
			label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		end

	end

end
function HomelandHelp.isTreeProduceMax( ... )
	-- body
	local treeMgr = G_UserData:getHomeland():getTreeManager()
    local serverMoney = treeMgr.total
	local serverMoneyTime = treeMgr.lastStartTime
	local serverGetMoneyTime = treeMgr.lastHarvestTime
	local ParameterIDConst = require("app.const.ParameterIDConst")
    local timeLimit = tonumber(require("app.config.parameter").get(ParameterIDConst.HOMELAND_TIME_LIMIT).content)
	local nowTime = G_ServerTime:getTime()
	local timeDiff = nowTime - serverMoneyTime      --服务器结算金币得时间
    local getTimeDiff = nowTime - serverGetMoneyTime        --玩家点击获得金币得时间

	if getTimeDiff >= timeLimit then 
		return true
	end

	return false
end
--神树产出计算
function HomelandHelp.getTreeProduce()

    local output = HomelandHelp.getSelfMainTreeCfg().output_efficiency / 100000
	--dump(output)
	local treeMgr = G_UserData:getHomeland():getTreeManager()
    local serverMoney = treeMgr.total
	local serverMoneyTime = treeMgr.lastStartTime
	local serverGetMoneyTime = treeMgr.lastHarvestTime
	local nowTime = G_ServerTime:getTime()

	local timeDiff = nowTime - serverMoneyTime      --服务器结算金币得时间
    local getTimeDiff = nowTime - serverGetMoneyTime        --玩家点击获得金币得时间
    
	local ParameterIDConst = require("app.const.ParameterIDConst")
    local timeLimit = tonumber(require("app.config.parameter").get(ParameterIDConst.HOMELAND_TIME_LIMIT).content)
	
	if getTimeDiff > timeLimit then 
		getTimeDiff = timeLimit
		local overTime = nowTime - serverGetMoneyTime - timeLimit
		timeDiff = timeDiff - overTime
		if timeDiff < 0 then 
			timeDiff = 0
		end
	end

	--dump(timeDiff * output)

    local moneyCount = math.floor( serverMoney + timeDiff * output)
    local nowMoneyDetail = serverMoney + timeDiff * output - moneyCount        --钱币的小数部分
	--dump(nowMoneyDetail)
    local percent = nowMoneyDetail*100 

    if getTimeDiff == timeLimit then 
        percent = 100
    end
	--dump(percent)
    return moneyCount, percent
end




--获取升当前等级所需经验
function HomelandHelp.getMainTreeExp(currLevel)
	local config =  G_UserData:getHomeland():getMainTreeCfg(currLevel)
	return config.experience
end


function HomelandHelp.getSubTreePower(subType,subLevel)
	local allPower = 0
	local subCfg = require("app.config.tree_decorate_add")
	for level= 1, subLevel do
		local data = subCfg.get(subType,level)
		if data then
			allPower = data.all_combat + allPower
		end
	end
	return allPower
end

function HomelandHelp.getMainTreePower(mainLevel)
		-- body
	local allPower = 0
	local subCfg = require("app.config.tree_info")
	for level= 1, mainLevel do
		local data = subCfg.get(level)
		if data then
			allPower = data.all_combat + allPower
		end
	end
	return allPower
	-- body
end
--获取神树战力
function HomelandHelp.getAllPower( ... )
	-- body
	local allPower = 0
	for i =1 , HomelandConst.MAX_SUB_TREE do
		local subTree = G_UserData:getHomeland():getSubTree(i)
		allPower = allPower + HomelandHelp.getSubTreePower(i, subTree.treeLevel)
	end
	local mainTree = G_UserData:getHomeland():getMainTree()
	local retPower = allPower + HomelandHelp.getMainTreePower(mainTree.treeLevel)
	return retPower
end


--获取神树战力
function HomelandHelp.getFriendAllPower( friendId )
	-- body

	local subPower = 0
	for i =1 , HomelandConst.MAX_SUB_TREE do
		local subTree = G_UserData:getHomeland():getInviteFriendSubTree(friendId, i)
		if subTree then
			subPower = subPower + HomelandHelp.getSubTreePower(i, subTree.treeLevel)
		end
	end

	local mainTree = G_UserData:getHomeland():getInviteFriendMainTree(friendId)

	local mainPower = HomelandHelp.getMainTreePower(mainTree.treeLevel)
	local retPower = subPower + mainPower


	return retPower
end



function HomelandHelp.getHomelandAttr()
	local attrAllList = {}
	local AttrDataHelper = require("app.utils.data.AttrDataHelper")

	for i = 1, HomelandConst.MAX_SUB_TREE do
		local currLevel = G_UserData:getHomeland():getSubTreeLevel(i)
		for level= 1, currLevel do
			local currData = G_UserData:getHomeland():getSubTreeCfg(i,level)
			if currData then
				local attrList = {}
				for i = 1, 4 do 
					local attrType = currData["attribute_type"..i]
					local attrValue = currData["attribute_value"..i]
					if attrType > 0 then
						table.insert( attrList, {type = attrType, value = attrValue} )
					end
				end
				for k, attrValue in ipairs(attrList) do
					AttrDataHelper.formatAttr(attrAllList, attrValue.type, attrValue.value)
				end
			end
		end
	end

	local currLevel = G_UserData:getHomeland():getMainTreeLevel()
	for level= 1, currLevel do
		local currData = G_UserData:getHomeland():getMainTreeCfg(level)
		if currData then
			local attrList = {}
			for i = 1, 4 do 
				local attrType = currData["attribute_type"..i]
				local attrValue = currData["attribute_value"..i]
				if attrType > 0 then
					table.insert( attrList, {type = attrType, value = attrValue} )
				end
			end
			for k, attrValue in ipairs(attrList) do
				AttrDataHelper.formatAttr(attrAllList, attrValue.type, attrValue.value)
			end
		end
	end
	--[[
	for attrType , attrValue in pairs(attrAllList) do
		

		local totalValue = attrValue
		if currCfg then
			totalValue = attrValue * currCfg.attribute_percentage*0.01 + attrValue
		end
		attrAllList[attrType] = totalValue
	end 
	]]
	return attrAllList
end


function HomelandHelp.getMainLevelAttrList( level )
	-- body
	local tempCfg = G_UserData:getHomeland():getMainTreeCfg(level)
	local valueList = {}
	local attrConfig = require("app.config.attribute")	
	valueList[1] = { name = Lang.get("official_all_all_combat") , value = tempCfg.all_combat}
	for i = 1,4,1 do
		if tempCfg["attribute_type"..i] > 0 then
			local nameStr = attrConfig.get(tempCfg["attribute_type"..i]).cn_name 
			if Lang.checkLang(Lang.TH) then
				nameStr = nameStr..Lang.get("official_all")
			else
				nameStr = Lang.get("official_all")..nameStr --TextHelper.expandTextByLen(nameStr,3)+
			end
			table.insert(valueList, {name= nameStr, value = tempCfg["attribute_value"..i]})
		end
	end
	table.insert(valueList, {name= attrConfig.get(tempCfg["output_type"]).cn_name, value = tempCfg.output_efficiency})
	return valueList
end

function HomelandHelp.getSubLevelAttrList( type, level )
	-- body
	local tempCfg = G_UserData:getHomeland():getSubTreeCfg(type, level)
	local valueList = {}
	local attrConfig = require("app.config.attribute")	
	valueList[1] = { name = Lang.get("official_all_all_combat") , value = tempCfg.all_combat}
	for i = 1,4,1 do
		if tempCfg["attribute_type"..i] > 0 then
			local nameStr = attrConfig.get(tempCfg["attribute_type"..i]).cn_name 
			if Lang.checkLang(Lang.TH) then
				nameStr = nameStr..Lang.get("official_all")
			else
				nameStr = Lang.get("official_all")..nameStr --TextHelper.expandTextByLen(nameStr,3)
			end
			valueList[i+1] = { name = nameStr, value = tempCfg["attribute_value"..i]}
		end
	end
	return valueList
end


--根据tree_preview的data数据展开结构
function HomelandHelp.getTreeItemList( data )
	-- body
	local UserCheck = require("app.utils.logic.UserCheck")
	if UserCheck.enoughOpenDay(data.day_min) == false then
		return nil
	end

	local function convertStringToNumber(convetStr)
		if convetStr ~= "" then
			local condition = string.split(convetStr,"|")
			local treeType, minLevel, maxLevel = unpack(condition)
			return tonumber(treeType),tonumber(minLevel),tonumber(maxLevel)
		end
		return 0
	end
	--材料结构
	-- name = xxx
	-- type = xxx
	-- matrial = {
	-- [1] = {type,value,size}
	-- [2] = {type,value,size}
	--}
	local function makeMaterialTable(treeType, minLevel, maxLevel)
		local matrialTable = {}
		matrialTable.list = {}
		for i = minLevel+1, maxLevel do
			local cfgData = G_UserData:getHomeland():getSubTreeCfg(treeType, i-1)	
			local item = {}
			item.lv = Lang.get("homeland_level_desc",{num1 =i-1, num2=i})
			item.list = {}
			for i=1, 2 do
				local type = cfgData["type_"..i]
				local value = cfgData["value_"..i]
				local size = cfgData["size_"..i]
				if type > 0 then
					table.insert( item.list, {type= type, value = value, size = size} )
				end
			end

			table.insert( matrialTable.list, item)
		end

		local cfgData = G_UserData:getHomeland():getSubTreeCfg(treeType, maxLevel)
		matrialTable.cfg = cfgData
		return matrialTable
	end

	local matrialList = {}
	for i= 1, 6 do 
		local condition = data["condition_"..i]
		local treeType, minLevel, maxLevel = convertStringToNumber(condition)
		if treeType > 0 then
			local retTable = makeMaterialTable(treeType,minLevel, maxLevel)
			table.insert( matrialList, retTable)
		end
	end

	return matrialList
	
end


--神树材料预览数据结构
function HomelandHelp.getTreePreviewList( ... )
	-- body
	local tree_preview = require("app.config.tree_preview")
	local treePreviewList = {}

	for i = 1, tree_preview.length() do
		local data = tree_preview.indexOf(i)
		local treeItemList = HomelandHelp.getTreeItemList(data)
		if treeItemList then
			table.insert( treePreviewList, {
				id = data.id,
				list = treeItemList 
			})
		end
	end
	
	dump(treePreviewList)
	return treePreviewList
end

--i18n
function HomelandHelp.updateNodeTreeTitleHorizontal( rootNode, treeData )
	local Node_treeTitle = rootNode:getSubNodeByName("Node_treeTitle")
	if treeData.treeId == 0 then
		local Image_bk = Node_treeTitle:getSubNodeByName("Image_bk")
		Image_bk:setScale9Enabled(true)
		Image_bk:setCapInsets(cc.rect(50,10,14,1))
		Image_bk:loadTexture(Path.getHomelandUI("img_homeland_01_h"))
		Image_bk:setAnchorPoint(0.5,0.5)

		local UIHelper  = require("yoka.utils.UIHelper")
		local image1 = UIHelper.seekNodeByName(Node_treeTitle,"Image_title")
		if image1.loadTexture then
				local label = UIHelper.swapWithLabel(image1,{
				style = "homeland_tree_"..treeData.treeLevel,
				fontSize = 22,
				text = Lang.getImgText("txt_homeland_tree",{value = treeData.treeLevel}) ,
			})
			label:setAnchorPoint(cc.p(0.5,0.5))
			label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		else
			UIHelper.setLabelStyle(image1,{
				style = "homeland_tree_"..treeData.treeLevel,
				text = Lang.getImgText("txt_homeland_tree",{value = treeData.treeLevel}) ,
			})
		end
		local title = UIHelper.seekNodeByName(Node_treeTitle,"Image_title")
		title:ignoreContentAdaptWithSize(true)
		title:setAnchorPoint(0.5,0.5)
		title:setPosition(0,0)
		Image_bk:setPosition(0,0)
		Image_bk:setContentSize(cc.size(title:getContentSize().width+60,33))
		if rootNode._redPoint then
			rootNode._redPoint:setPosition(Image_bk:getContentSize().width/2,Image_bk:getContentSize().height/2)
		end
	else
		if treeData.treeLevel == 0 then
			Node_treeTitle:setVisible(false)
			return
		end
		Node_treeTitle:setVisible(true)

		local UIHelper  = require("yoka.utils.UIHelper")
		local Image_bk = Node_treeTitle:getSubNodeByName("Image_bk")
		Image_bk:setScale9Enabled(true)
		Image_bk:setCapInsets(cc.rect(40,10,15,1))
		Image_bk:setAnchorPoint(0.5,0.5)
		Image_bk:loadTexture(Path.getHomelandUI("img_homeland_02_h"))
		local Image_level = Node_treeTitle:getSubNodeByName("Image_level")
		Image_level:ignoreContentAdaptWithSize(true)
		Image_level:loadTexture(Path.getHomelandUI("img_homeland_02b_h"))
		Image_level:setAnchorPoint(1,0.5)
		Image_level:setPosition(0,8)

		local image1 = UIHelper.seekNodeByName(Node_treeTitle,"Image_title")
		if image1.loadTexture then
			local label = UIHelper.swapWithLabel(image1,{
				style = "homeland_1",
				fontSize = 20,
				text = Lang.getImgText("txt_homeland_decorate"..treeData.treeId) ,
			})
			label:setAnchorPoint(cc.p(0.5,0.5))
			label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		else
			UIHelper.setLabelStyle(image1,{
				style = "homeland_1",
				text = Lang.getImgText("txt_homeland_decorate"..treeData.treeId) ,
			})
		end
		local title = UIHelper.seekNodeByName(Node_treeTitle,"Image_title")
		title:ignoreContentAdaptWithSize(true)
		title:setAnchorPoint(0.5,0.5)
		title:setPosition(0,0)
		Image_bk:setPosition(0,0)
		Image_bk:setContentSize(cc.size(title:getContentSize().width+60,33))
		if rootNode._redPoint then
			rootNode._redPoint:setPosition(Image_bk:getContentSize().width/2,Image_bk:getContentSize().height/2)
		end
		local level = UIHelper.seekNodeByName(Image_level,"Text_level")
		level:ignoreContentAdaptWithSize(true)
		level:setAnchorPoint(0.5,0.5)
		local size = Image_level:getContentSize()
		level:setPosition(size.width/2,size.height/2+5)
		Node_treeTitle:updateLabel("Text_level", Lang.get("homeland_sub_tree_level"..treeData.treeLevel))
	end
end

return HomelandHelp