-- Author: liangxu
-- Date:2018-3-13 09:20:37
-- Describle：

local ListViewCellBase = require("app.ui.ListViewCellBase")
local PackageJadeCell = class("PackageJadeCell", ListViewCellBase)
local SilkbagDataHelper = require("app.utils.data.SilkbagDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UIHelper  = require("yoka.utils.UIHelper")

function PackageJadeCell:ctor()
    local resource = {
        file = Path.getCSB("PackageJadeCell", "package"),
        binding = {
            _button1 = {
                events = {{event = "touch", method = "_onClickButton1"}}
            },
            _button2 = {
                events = {{event = "touch", method = "_onClickButton2"}}
            }
        }
    }
    PackageJadeCell.super.ctor(self, resource)
end

function PackageJadeCell:onCreate()
    --i18n
    self:_dealByI18n()
    local size = self._resourceNode:getContentSize()
    self:setContentSize(size.width, size.height)

    if  Lang.checkLang(Lang.VN) then
        for i = 1, 2 do
           -- self["_textDes" .. i]:setFontSize(self["_textDes" .. i]:getFontSize()-1)
            
            self["_textDes" .. i]:setPositionX(self["_textDes" .. i]:getPositionX()-3)
            self["_textDes" .. i]:setPositionY(self["_textDes" .. i]:getPositionY()+6)
            local size1 = self["_textDes" .. i]:getContentSize()
            self["_textDes" .. i]:setContentSize(cc.size(size1.width + 6,size1.height + 12))

            self["_textDes" .. i]:getVirtualRenderer():setLineSpacing(-2)
        end
    end
end

function PackageJadeCell:updateUI(index, itemLine)
    for i = 1, 2 do
        local item = self["_item" .. i]
        item:setVisible(false)
    end
    local function updateCell(i, data)
        if data then
            self["_item" .. i]:setVisible(true)
            local baseId = data:getSys_id()
            local info = data:getConfig()
            local nameStr = info.name
            self["_item" .. i]:updateUI(TypeConvertHelper.TYPE_JADE_STONE, baseId)
            self["_item" .. i]:setName(nameStr)
            self["_textDes" .. i]:setString(info.bag_description)
            self["_button" .. i]:setString(info.button_txt)

            local heroBaseId = data:getEquipHeroBaseId()
            if heroBaseId and heroBaseId > 0 then
                local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId)
                self["_textHeroName" .. i]:setVisible(true)
                self["_textHeroName" .. i]:setString(heroParam.name)
                self["_textHeroName" .. i]:setColor(heroParam.icon_color)
                UIHelper.updateTextOutline(self["_textHeroName" .. i], heroParam)
            else
                self["_textHeroName" .. i]:setVisible(false)
            end
        end
    end

    for i, data in ipairs(itemLine) do
        updateCell(i, data)
    end
end

function PackageJadeCell:_onClickButton1()
    self:dispatchCustomCallback(1)
end

function PackageJadeCell:_onClickButton2()
    self:dispatchCustomCallback(2)
end

-- i18n
function PackageJadeCell:_dealByI18n()
	if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
		self._textHeroName1:setPositionY(self._textHeroName1:getPositionY()-25)
		self._textHeroName2:setPositionY(self._textHeroName2:getPositionY()-25)
		self._textHeroName1:getVirtualRenderer():setMaxLineWidth(0)
		self._textHeroName2:getVirtualRenderer():setMaxLineWidth(0)
		for i = 1, 2 do
			local line = self["_item"..i]:getSubNodeByName("ImageLine")
			line:setVisible(false)
			local img = self["_item"..i]:getSubNodeByName("Image_1")
			img:setAnchorPoint(0,1)
			img:setPosition(115,80)
			img:setContentSize(cc.size(204,70))
			self["_textDes" .. i]:setContentSize(cc.size(194,70))
			self["_textDes" .. i]:setPosition(120,77)
		end
	end
end

return PackageJadeCell
