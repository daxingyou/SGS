local BlackList = {}

function BlackList.isMatchText(text)
	local UTF8 = require("app.utils.UTF8")
	local BlackUnits = require("app.config.black_units")
	-- i18n change config
	if not Lang.checkLang(Lang.CN) then
		BlackUnits = Path.getLangConfig("black_units")
	end
	
	if text == nil or type(text) ~= "string" then
		assert("传入值为空或非string类型")
		return false
	end
	local len = UTF8.utf8len(text)
	for i=1,len do
		local tmp = UTF8.utf8sub (text,i,i)
		local _t = BlackUnits:get(tmp)
		if _t and #_t>0 then
			for i,v in ipairs(_t) do
				for x in string.gmatch(text,v) do
					return true
				end
			end
		end
	end

	
	--GM配置屏蔽字
	local blackList = G_ConfigManager:getBlackList()
	if blackList and blackList ~= "" then
		blackList = string.gsub(blackList,"[\n%s\r]","")
		local matches = string.split(blackList,",")

		for i,v in ipairs(matches) do
			for x in string.gmatch(text,v) do
				return true
			end
		end
	end
	

	return false
end

function BlackList.filterBlack(text)
	--i18n 字库外的特殊字符替换
	local blackListOpen = G_ConfigManager:isBlackListOpen()
	if not blackListOpen then
		return text
	end
	local UTF8 = require("app.utils.UTF8")
	local BlackUnits = require("app.config.black_units")
	-- i18n change config
	if not Lang.checkLang(Lang.CN) then
		BlackUnits = Path.getLangConfig("black_units")
	end
	if text == nil or type(text) ~= "string" then
		assert("传入值为空或非string类型")
		return text
	end
	local len = UTF8.utf8len(text)
	for i=1,len do
		local tmp = UTF8.utf8sub(text,i,i)
		local _t = BlackUnits:get(tmp)
		if _t and #_t>0 then
			for i,v in ipairs(_t) do
				--保存一份tmpText
				local tmpText = text
				local old_v = v
				 ---先把魔法字符换成其他
				v = string.gsub(v, "%.", "%%%.") 
				v = string.gsub(v, "%%", "%%%%")  
				v = string.gsub(v, "%+", "%%%+")  
				v = string.gsub(v, "%*", "%%%*")  
				v = string.gsub(v, "%-", "%%%-") 
				v = string.gsub(v, "%?", "%%%?")  
				v = string.gsub(v, "%[", "%%%[")  
				v = string.gsub(v, "%]", "%%%]")  
				v = string.gsub(v, "%^", "%%%^")
				v = string.gsub(v, "%(", "%%%(")
				v = string.gsub(v, "%)", "%%%)")
				v = string.gsub(v, "%$", "%%%$")
				for x in string.gmatch(tmpText,v) do
					local len = UTF8.utf8len(old_v)
					local replace = ""
					for j=1,len do
						replace = replace .. "*"
					end
					text = string.gsub(text,v,replace)
				end
			end
		end
	end
	
	--GM配置屏蔽字
	local blackList = G_ConfigManager:getBlackList()
	if blackList and blackList ~= "" then
		blackList = string.gsub(blackList,"[\n%s\r]","")
		local matches = string.split(blackList,",")

		for i,v in ipairs(matches) do
			text = string.gsub(text,v,"*")
		end
	end

	return text
end

return BlackList