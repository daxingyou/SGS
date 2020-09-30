
local ViewBase = require("app.ui.ViewBase")
local HomelandNodeTreeTitle = class("HomelandNodeTreeTitle", ViewBase)
local HomelandConst = require("app.const.HomelandConst")
local HomelandHelp = require("app.scene.view.homeland.HomelandHelp")
local AudioConst = require("app.const.AudioConst")

function HomelandNodeTreeTitle:ctor(treeData,type)
	self.treeData = treeData
	--  "mainCell" "subCell" "materialcell"
	self.treeType = type
	local resource = {
		file = Path.getCSB("HomelandNodeTreeTitle", "homeland"),
	}
	HomelandNodeTreeTitle.super.ctor(self, resource)
	
end

function HomelandNodeTreeTitle:onCreate()
	self:updateUI()
end


-- i18n
function HomelandNodeTreeTitle:updateUI()
 		local treeData = self.treeData
		local UIHelper  = require("yoka.utils.UIHelper")
		local level = UIHelper.seekNodeByName(self,"Text_level")
		local image_level = UIHelper.seekNodeByName(self,"Image_level")
		local textName = UIHelper.seekNodeByName(self,"Text_1")
		local redPoint = UIHelper.seekNodeByName(self,"_redPoint")
		local image_bk = UIHelper.seekNodeByName(self,"Image_bk")
		local Node_treeTitle = UIHelper.seekNodeByName(self,"Node_treeTitle")
		--先隐藏红点
		redPoint:setVisible(false)
		textName:getVirtualRenderer():setMaxLineWidth(26)
		-- imageBk
		
		if treeData.treeId == 0 then
			-- mainCell 主UI
			image_level:setVisible(false)
			redPoint:setPositionY(redPoint:getPositionY()-30)
			local text =  Lang.getImgText("txt_homeland_tree",{value = treeData.treeLevel})
			 image_bk:ignoreContentAdaptWithSize(true)
			 UIHelper.loadCommonBgImageByI18n( image_bk,text )
			if treeData.treeLevel< 10 then
				textName:getVirtualRenderer():setLineSpacing(-4)
				textName:setString(text)
				UIHelper.setLabelStyle(textName,{
					style = "homeland_tree_ui4_"..treeData.treeLevel,
					fontSize = 22,
					text =text ,
				})
			else
				textName:setVisible(false)
				local splitText = Lang.getImgText("txt_homeland_tree")
				local strSplit = self:split(splitText,"#")
				local posy = 5;
				for i,v in ipairs(strSplit) do
					--创建图片
					local  node = nil
					if v == "value" then
						node = UIHelper.createImage({texture = Path.getHomelandUI(("txt_homeland_"..treeData.treeLevel)) })
						node:setAnchorPoint(0.5,1)
					else
						node = UIHelper.createLabel({
							text =v,
							style = "homeland_tree_ui4_"..treeData.treeLevel,
							fontSize = 22,
							anchorPoint = cc.p(0.5,1)
						})
						node:getVirtualRenderer():setMaxLineWidth(26)
						node:getVirtualRenderer():setLineSpacing(-4)
					end
					if node then
						node:setPosition(0,posy)
						local  offset  = node:getVirtualRendererSize().height
						posy = posy - offset
						Node_treeTitle:addChild(node)
					end

				end

			end
			

		else
			if treeData.treeLevel == 0 then
				Node_treeTitle:setVisible(false)
				return
			end
			Node_treeTitle:setVisible(true)
			local text = Lang.getImgText("txt_homeland_decorate"..treeData.treeId)
			textName:setString(text)
			image_bk:ignoreContentAdaptWithSize(true)
			UIHelper.loadCommonBgImageByI18n( image_bk,text )
			level:setString(self.treeData.treeLevel)
			if(self.treeType == "materialcell") then
				image_level:setPosition(cc.p(105,45))
				image_bk:setPosition(cc.p(-7,50))
				textName:setPosition(cc.p(-7,12))

			end
		end
	
end

function HomelandNodeTreeTitle:split(str, flag)
    local tab = {}
    while true do
        -- 在字符串中查找分割的标签
        local n = string.find(str, flag)
        if n then
            -- 截取分割标签之前的字符串
            local first = string.sub(str, 1, n-1) 
            -- str 赋值为分割之后的字符串
            str = string.sub(str, n+1, #str) 
            -- 把截取的字符串 保存到table中
            table.insert(tab, first)
        else
            table.insert(tab, str)
            break
        end
    end
    return tab
end


return HomelandNodeTreeTitle