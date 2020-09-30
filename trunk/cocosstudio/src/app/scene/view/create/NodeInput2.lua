local NodeInput2 = class("NodeInput2")

function NodeInput2:ctor(target, sex, defaultName)
    self._sex = sex
    self._defaultName = defaultName
    self._target = target
	self:_init()
end

function NodeInput2:_init()
  
    self._nameText = ccui.Helper:seekNodeByName(self._target, "NameText")
    self._panelInput = ccui.Helper:seekNodeByName(self._target, "PanelInput")
    self._textPlaceHolder = ccui.Helper:seekNodeByName(self._target, "TextPlaceHolder")

    

	local maxLen = 6
	-- i18n change text filtration
	--if not Lang.checkLang(Lang.CN) then
	--	local UIHelper  = require("yoka.utils.UIHelper")
	--	maxLen = UIHelper.getInputLimitedConfig().role_length
    --end
    
    self._textPlaceHolder:setString(
        Lang.get("txt_check_error_too_long", {count = maxLen})
    )

    local InputUtils = require("app.utils.InputUtils")
	self._editBox = InputUtils.createInputView(
		{ 	
			bgPanel = self._panelInput,
			fontSize = 26,
			fontColor = Colors.INPUT_CREATE_ROLE,
			placeholder = Lang.get("lang_input_name_tip"),
            textLabel = self._nameText,
            textEmpty = self._textPlaceHolder,
            inputEvent = function(event, edit)
				if event == "return" then
                    local name = self._nameText:getString()
					if not name or name == ""  then
                       --self:_onPlaceRandomName()
                    else 
                        self._defaultName = name                
					end
				end
			end,
			maxLength = maxLen,-- i18n
		}
	)

    if not self._defaultName then 
        --self:_onRandomClick()
    else
        self:_setName(self._defaultName)
    end
end

function NodeInput2:_onRandomClick()
	local randomName = nil
	local count = 10
	while(count > 0) do
		randomName = self:_getRandomName()
		local BlackList = require("app.utils.BlackList")
		if not BlackList.isMatchText(randomName) then
			break
		end
		count = count -1
	end
    self:_setName(randomName)
    self._defaultName = nil
end

function NodeInput2:_getRandomName()
	local Name1Place = require("app.config.name1_place")
	local Name2Surname = require("app.config.name2_surname")
	local Name3Name = require("app.config.name3_name")
	
	--math.randomseed(tostring(timer:getms()):reverse():sub(1, 6))  
	local index01 = math.random(Name1Place.length())
	local index02 = math.random(Name2Surname.length())
	local index03 = math.random(Name3Name.length())
	local name01 = Name1Place.indexOf(index01)
	local name02 = Name2Surname.indexOf(index02)
	local name03 = Name3Name.indexOf(index03)

	assert(name01,"name1_place config not find id "..index01)
	assert(name02,"name2_surname config not find id "..index02)
	assert(name03,"name3_name config not find id "..index03)

	local name = name01.place..name02.surname
	logWarn("create name :"..index01.." "..index02.." "..index03)

	-- i18n change name length
	if not Lang.checkLang(Lang.CN)  then
		name = name02.surname
	end
	--i18n 英泰地区随机名显示名+姓
	if self._sex == 1 then
		name = name..name03.name_boy
	else
		name = name..name03.name_girl
	end

	return name --tostring(timer:getms()):reverse():sub(1, 6)
end

function NodeInput2:_setName(name)
	self._nameText:setString(name)
	self._editBox:setText(name)
	self._textPlaceHolder:setVisible(name == nil or name == "")
end

function NodeInput2:_onPlaceRandomName()
	local randomName = nil
	local count = 10
	while(count > 0) do
		randomName = self:_getRandomName()
		local BlackList = require("app.utils.BlackList")
		if not BlackList.isMatchText(randomName) then
			break
		end
		count = count -1
	end
    self:_setName(randomName)
end

function NodeInput2:getDefaultName()
    return self._defaultName
end

function NodeInput2:getName()
    return self._nameText:getString()
end

return NodeInput2