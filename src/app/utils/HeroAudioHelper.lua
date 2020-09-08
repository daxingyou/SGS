local HeroAudioHelper = {}
local HeroDataHelper = require("app.utils.data.HeroDataHelper")
local SchedulerHelper = require("app.utils.SchedulerHelper")

function HeroAudioHelper.getVoiceResNames(id)
	local heroInfo = HeroDataHelper.getHeroConfig(id)
	local resId = heroInfo.res_id
	
	local names = HeroAudioHelper.getVoiceResNamesWithResId(resId)
	return names
end

function HeroAudioHelper.getVoiceResNamesWithResId(resId)
	local resInfo = require("app.config.hero_res").get(resId)
	assert(resInfo, string.format("hero_res config can not find id = %d", resId))
	
	local names = {}
	local voice = resInfo.voice
	if voice ~= "" and voice ~= "0" then
		names = string.split(voice,"|")
	end
	return names
end

function HeroAudioHelper.getRandomVoiceName(id)
	local names = HeroAudioHelper.getVoiceResNames(id)
	local index = math.random(#names)
	return names[index]
end

function HeroAudioHelper.getVoiceRes(id)
	local res = nil
	local name = HeroAudioHelper.getRandomVoiceName(id)
	if name then
		res = Path.getHeroVoice(name)
	end
	return res,name
end

-- i18n ja voice
function HeroAudioHelper.getSpineVoiceRes(id)
	local heroInfo = HeroDataHelper.getHeroConfig(id)
	local resId = heroInfo.res_id
	local resInfo = require("app.config.hero_res").get(resId)
	assert(resInfo, string.format("hero_res config can not find id = %d", resId))
	return resInfo.voice_b  
end

-- i18n ja get spine voice
function HeroAudioHelper.getVoiceByAction(heroId, actionName) 
	local voices = HeroAudioHelper.getSpineVoiceRes(heroId)

	if voices == "" then 
		return  ""
	end

	-- 默认动作(秀将动作)对应的随机音效   
	if actionName == nil then  
		local vList1 = string.split(voices, ";")
		local action = string.split(vList1[1], ",")
		if #action > 1 then  
			local voiceList = string.split(action[2], "|")
			local index = math.random(1, #voiceList)
			return Path.getHeroVoice(voiceList[index])
		end
		
		return ""
	end

	-- 指定动作对应的随机音效列表
	local vList1 = string.split(voices, ";")
	for i=1, #vList1 do 
		local action = string.split(vList1[i], ",")
		if #action > 1 and action[1] == actionName then  
			local v = string.split(action[2], "|")
			local index = math.random(1, #v)
			return v[index]
		end
	end
end

return HeroAudioHelper