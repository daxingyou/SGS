
local PathEx = Path

PathEx._getFont = Path.getFont

local png_suffix = ".png"
local jpg_suffix = ".jpg"
local json_suffix = ".json"
local mp3_suffix = ".mp3"
local csb_suffix = ".csb"
local plist_suffix = ".plist"
local ttf_suffix = ".ttf"
local sab_suffix = ".sab"
local lua_suffix = ".lua"

local fnt_suffix = ".fnt"
local shader_suffix = ".fsh"
local lang_base_path = "base"
local server_init_index = "__index__"

PathEx.lang_base_path = lang_base_path
PathEx.lang_server_init_index = server_init_index

-- if Lang.lang ~= "cn" and cc.FileUtils:getInstance():isFileExist("app/i18n/".. _lang .."/config/accountcode.lua") then _isExist =  true end
function PathEx.isExist(Path)
	return cc.FileUtils:getInstance():isFileExist(Path)
end

function PathEx.getFont(id)
    local lang = Lang.lang
    if Lang.checkChannel(Lang.CHANNEL_SEA) then
        lang = Lang.ZH
    end
    local langPath = "i18n/" .. lang .. "/fonts/" .. id .. ttf_suffix
	if not Lang.checkLang(Lang.CN) and PathEx.isExist(langPath) then
		return langPath
	else
		return "fonts/" .. id .. ttf_suffix
    end
end

-- 新增查找优先级  多语言 先检查lang_base_path路径下是否存在对应资源
--[[
function PathEx.getLangBaseEx(fullPath, langPath, basePath)
    local basePath = string.gsub(fullPath,langPath,basePath)
    local isExist = PathEx.isExist(basePath) or PathEx.isExist(fullPath)
    -- print("langPath: " .. fullPath .. "     isExist: " .. tostring(PathEx.isExist(fullPath)))
    -- print("basePath: " .. basePath .. "     isExist: " .. tostring(PathEx.isExist(basePath)))
    return isExist,basePath
end
--]]
function PathEx.getLangBaseEx( fullPath )
    --先检查当前语言路径
    if PathEx.isExist(fullPath) then
        return true,fullPath,Lang.lang
    end
    local langPath = "i18n/" .. Lang.lang .. "/"
    local basePath = "i18n/" .. lang_base_path .. "/"
    local fullPathBase = string.gsub(fullPath,langPath,basePath)
    --再检查lang_base_path路径
    if PathEx.isExist(fullPathBase) then
        return true,fullPathBase,lang_base_path
    end
end

function PathEx.getImgFont(id)
    local langPath = "i18n/" .. Lang.lang .. "/fonts/" .. id .. fnt_suffix
    -- local basePath = "i18n/" .. lang_base_path .. "/fonts/" .. id .. fnt_suffix
    -- local isExist = PathEx.isExist(basePath) or PathEx.isExist(langPath)
    local isExist,resultPath = Path.getLangBaseEx(langPath)
    if not Lang.checkLang(Lang.CN) and isExist then
        return resultPath
    else
		return "fonts/" .. id .. ttf_suffix
    end
end

function PathEx.getLangImgTextJson(id)
    local langPath = "i18n/" .. Lang.lang .. "/json/" .. id .. json_suffix
	if not Lang.checkLang(Lang.CN) and PathEx.isExist(langPath) then
        return langPath
    else
        return langPath    
    end
end

function PathEx.getLangServerKeyJson(id,suffix)
    suffix = suffix or json_suffix
    local langPath = "i18n/" .. Lang.lang .. "/json/server_key/" .. id .. suffix
	if not Lang.checkLang(Lang.CN) and PathEx.isExist(langPath) then
        return langPath
    else
        return langPath    
    end
end

function PathEx.getLangConfig(id)
    local langPath = "i18n/" .. Lang.lang .. "/json/" .. id .. json_suffix
    if not Lang.checkLang(Lang.CN) and Lang.isFileExist("app/i18n/".. Lang.lang .."/config/" .. id .. lua_suffix ) then 
        return require( "app.i18n.".. Lang.lang ..".config." .. id )
    else
        return require("app.config." .. id)
    end
end



function PathEx.get(id,dir,src,suffix,isSpine)
    src = src or "ui3/text"
    suffix = suffix or png_suffix
    local filePath =  src .. "/" .. dir
    if not src or src == "" then
        filePath =  dir
    end
    if string.sub(filePath,-1) == "/" then
        filePath = string.sub(filePath,1,-2)
    end
    isSpine = isSpine or false
    local langPath = "i18n/" .. Lang.lang .. "/" .. filePath  .."/".. id ..suffix
    -- dump(langPath,"---------- langPath: ")
    -- dump(PathEx.isExist(langPath),"---------- isExist: ")
    -- dump({langPath=langPath,isExist=PathEx.isExist(langPath)},"PathEx.get: ")
    -- if not Lang.checkLang(Lang.CN) and PathEx.isExist(langPath) then
    --     local langSabPath = "i18n/" .. Lang.lang .. "/" ..  filePath .."/".. id ..sab_suffix
    --     if isSpine and  PathEx.isExist(langSabPath) then
    --         local spinePath = "i18n/" .. Lang.lang .. "/" ..  filePath .."/".. id
    --         return spinePath
    --     else
    --         return langPath
    --     end
    -- else
    --     if isSpine then
    --         return filePath .."/"..id
    --     else
    --         return filePath .."/"..id..suffix
    --     end
    -- end
    local isExist,resultPath = PathEx.getLangBaseEx(langPath)
    if not Lang.checkLang(Lang.CN) and isExist then
        local langSabPath = "i18n/" .. Lang.lang .. "/" ..  filePath .."/".. id ..sab_suffix
        local isSabExist,resultSabPath,langName = PathEx.getLangBaseEx(langSabPath)
        if isSpine and isSabExist then
            local spinePath = "i18n/" .. langName .. "/" ..  filePath .."/".. id
            return spinePath
        else
            return resultPath
        end
    else
        if isSpine then
            return filePath .."/"..id
        else
            return filePath .."/"..id..suffix
        end
    end
end


function PathEx.getEditorSrc(src)
    local langPath = "i18n/" .. Lang.lang .. "/" ..  src
	if not Lang.checkLang(Lang.CN) and PathEx.isExist(langPath) then
        return langPath
    else
        return src    
    end
end

function PathEx.getAudio(id,dir,src,suffix)
    local lang = Lang.lang
    if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.ENID) then
        lang = Lang.ZH
    end
    local langPath = src .. "/" .. lang .. "/" .. dir .."/".. id .. suffix
    dump({langPath=langPath,isExist=PathEx.isExist(langPath)},"PathEx.getAudio: ")
    if not Lang.checkLang(Lang.CN) and PathEx.isExist(langPath) then
        return langPath
    else
        return src .. "/" .. Lang.CN .. "/" .. dir .."/"..id.. suffix
    end
end

function PathEx.getAudioFullPath(path)
    local lang = Lang.lang
    if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.ENID) then
        lang = Lang.ZH
    end
    local newPath = string.gsub(path,"audio/","audio/" .. lang .."/")
    if newPath and cc.FileUtils:getInstance():isFileExist(newPath) then
        logWarn("getAudioFullPath  ".. newPath)
        return newPath
    end
    newPath = string.gsub(path,"audio/","audio/"..Lang.CN .."/")
    if newPath and cc.FileUtils:getInstance():isFileExist(newPath) then
        logWarn("getAudioFullPath  ".. newPath)
        return newPath
    end
    logWarn("getAudioFullPath  "..path)
    return path
end


--
-- function Path.getAttackerAction(id)
-- 	return "fight/action/" .. id .. "_attacker.ani"
-- end

-- --
-- function Path.getTargetAction(id, cell)
-- 	if cell then
-- 		return "fight/action/" .. id .. "_target_" .. cell .. ".ani"
-- 	end
-- 	return "fight/action/" .. id .. "_target.ani"
-- end

-- --
-- function Path.getSceneAction(id)
-- 	return "fight/action/" .. id .. "_scene.ani"
-- end

--
-- function Path.getSpine(id)
-- 	return "spine/" .. id
-- end

--
function PathEx.getEffectSpine(id)
-- 	return "effect/spine/" .. id
    -- dump( PathEx.get(id,"spine","effect",png_suffix,true),"---- PathEx.getEffectSpine: ")
    return PathEx.get(id,"spine","effect",png_suffix,true)
end

function PathEx.getFightEffectSpine(id)
    -- return "fight/effect/" .. id
    return PathEx.get(id,"effect","fight",png_suffix,true)
end

function PathEx.getImgRunway(id)
    return PathEx.get(id,"runway","ui3","")
end

-- --
function PathEx.getUICommon(id)
    -- return "ui3/common/" .. id .. png_suffix
    return PathEx.get(id,"common","ui3")
end

-- --注：该函数路径是临时的，将来需要调整
-- function PathEx.getUIText(id)
-- 	return "newui/text/" .. id .. png_suffix
-- end


function PathEx.getTextTeam(id)
    -- return "ui3/text/team/" .. id .. png_suffix
    return PathEx.get(id,"team")
end
function PathEx.getTextSign(id)
    -- return "ui3/text/sign/" .. id .. png_suffix
    return PathEx.get(id,"sign")
end

function PathEx.getTextSignet(id)
    -- return "ui3/text/signet/" .. id .. png_suffix
    return PathEx.get(id,"signet")
end

function PathEx.getImgTitle(id)
    -- return "ui3/text/title/" ..id .. png_suffix
    return PathEx.get(id,"title")
end

function PathEx.getDiscountImg(discount)
	return PathEx.getTextSignet("txt_sys_activity_sale0"..discount)
end

function PathEx.getTextSystemBigTab(id)
    -- return "ui3/text/system/big_tab/" .. id .. png_suffix
    return PathEx.get(id,"system/big_tab")
end

function PathEx.getTextSystem(id)
    -- return "ui3/text/system/" .. id .. png_suffix
    return PathEx.get(id,"system")
end

function PathEx.getUICommonFrame(id)
    -- return "ui3/common/frame/"..id..png_suffix
    return PathEx.get(id,"common/frame","ui3")
end

function PathEx.getCommonIcon(module,id)
    -- return "icon/" ..module.."/".. id .. png_suffix
    return PathEx.get(id,module,"icon")
end

function PathEx.getTextHero(id)
    -- return "ui3/text/hero/" .. id ..png_suffix
    return PathEx.get(id,"hero")
end

function PathEx.getTextEquipment(id)
    -- return "ui3/text/quipment/"..id..png_suffix
    return PathEx.get(id,"quipment")
end

function PathEx.getText(id)
    -- return "ui3/text/" .. id .. png_suffix
    return PathEx.get(id,"text","ui3")
end

function PathEx.getEmbattle(id)
    -- return "ui3/embattle/"..id..png_suffix
    return PathEx.get(id,"embattle","ui3")
end

function PathEx.getBuffText(id)
    -- return "ui3/text/buff/"..id..png_suffix
    return PathEx.get(id,"buff")
end

-- function PathEx.getChapterIcon(id)
-- 	return "mline/chapter/"..id..png_suffix
-- end

function PathEx.getChallengeIcon(id)
    -- return "ui3/challenge/"..id..png_suffix
    return PathEx.get(id,"challenge","ui3")
end

function PathEx.getChallengeText(id)
    -- return "ui3/text/challenge/"..id..png_suffix
    return PathEx.get(id,"challenge")
end

function PathEx.getDailyChallengeIcon(id)
    -- return "ui3/challenge/daily/"..id..png_suffix
    return PathEx.get(id,"challenge/daily","ui3")
end

function PathEx.getTowerChallengeIcon(id)
    -- return "ui3/challenge/tower/"..id..png_suffix
    return PathEx.get(id,"challenge/tower","ui3")
end

-- function PathEx.getChatRoleRes(id)
-- 	return "storyres/"..id..png_suffix
-- end

-- function PathEx.getStorySpine(id)
-- 	return "storyspine/" ..id.."_big"
-- end

function PathEx.getChatFaceRes(id)
    -- return "ui3/face/mini/"..id..png_suffix
    return PathEx.get(id,"face/mini","ui3")
end

function PathEx.getChatFormRes(id)
    -- return "ui3/chat/form"..id..png_suffix
    return PathEx.get("form"..id,"chat","ui3")
end

function PathEx.getTowerSurpriseBG(id)
    -- return "ui3/challenge/tower/img_bg_"..id..png_suffix
    return PathEx.get( "img_bg_"..id,"challenge/tower","ui3")
end

function PathEx.getBuffFightIcon(id)
    -- return "ui3/battle/buffcard/"..id..png_suffix
    return PathEx.get(id,"battle/buffcard","ui3")
end

-- function PathEx.getShader(id)
-- 	return "shaders/"..id..shader_suffix
-- end

-- function PathEx.getStageMap(id)
-- 	return "mline/stage/"..id..jpg_suffix
-- end


-- function PathEx.getStageBG(id)
-- 	return "ui3/stage/"..id..jpg_suffix
-- end

-- function PathEx.getExploreMainBG()
-- 	return "ui3/stage/img_explore_map1"..jpg_suffix
-- end

function PathEx.getExploreCityRes(id)
    -- return "ui3/explore/img_city"..id..png_suffix
    return PathEx.get("img_city"..id,"explore","ui3")
end

function PathEx.getExploreCloud()
    -- return "ui3/explore/img_cloud"..png_suffix
    return PathEx.get("img_cloud"..id,"explore","ui3")
end


function PathEx.getExploreBlock(id)
	if not id then
        -- return "ui3/explore/img_road"..png_suffix
        return PathEx.get("img_road"..id,"explore","ui3")
	end
    -- return "ui3/explore/"..id..png_suffix
    return PathEx.get(id,"explore","ui3")
end

function PathEx.getExploreDiscover(id)
    -- return "ui3/explore/discover/"..id..png_suffix
    return PathEx.get(id,"explore/discover","ui3")
end

-- function PathEx.getExploreMapBG()
-- 	return "ui3/stage/img_dfwddt"..jpg_suffix
-- end

function PathEx.getActDinnerRes(id)
    -- return "ui3/activity/dinner/"..id..png_suffix
    return PathEx.get(id,"activityy/dinner","ui3")
end

function PathEx.getAnswerImage(id)
    -- return "ui3/explore/discover/answe/"..id..png_suffix
    return PathEx.get(id,"explore/discover/answe","ui3")
end

function PathEx.getDay7ActivityRes(id)
    -- return "ui3/activity/carnival/"..id..png_suffix
    return PathEx.get(id,"activityy/carnival","ui3")
end

function PathEx.getExploreImage(id)
    -- return "ui3/explore/"..id..png_suffix
    return PathEx.get(id,"explore","ui3")
end

function PathEx.getExploreTreasureBigIcon(id)
    -- return "icon/treasurebig/"..id..png_suffix
    return PathEx.get(id,"treasurebig","icon")
end

function PathEx.getResourceMiniIcon(id)
    -- return "icon/resourcemini/"..id..png_suffix
    return PathEx.get(id,"resourcemini","icon")
end

function PathEx.getExploreOrnament(id)
    -- return "ui3/explore/img_"..id..png_suffix
    return PathEx.get("img_"..id,"explore","ui3")
end


function PathEx.getTutorialVoice(id)
    -- return "audio/voice/"..id..mp3_suffix
    return PathEx.getAudio(id,"voice","audio",mp3_suffix)
end

function PathEx.getSkillVoice(id)
    -- return "audio/voice/"..id..mp3_suffix
    return PathEx.getAudio(id,"voice","audio",mp3_suffix)
end

function PathEx.getFightSound(id)
    -- return "audio/fight/" .. id .. mp3_suffix
    return PathEx.getAudio(id,"fight","audio",mp3_suffix)
end

function PathEx.getCreateRoleRes(id)
    -- return "ui3/create/"..id..png_suffix
    return PathEx.get(id,"create","ui3")
end

function PathEx.getChapterBox(id)
    -- return "icon/common/"..id..png_suffix
    return PathEx.get(id,"common","icon")
end

--排行榜背景
function PathEx.getRankBG(id)
    -- return "ui3/common/img_com_ranking0"..id..png_suffix
    return PathEx.get("img_com_ranking0"..id,"common","ui3")
end

--排行榜前面排名图标
function PathEx.getRankIcon(id)
    -- return "ui3/common/icon_com_ranking0"..id..png_suffix
    return PathEx.get("icon_com_ranking0"..id,"common","ui3")
end

-- --恭喜获得资源
function PathEx.getPopupReward(id)
    -- return "ui3/gain/"..id..png_suffix
    return PathEx.get(id,"gain","ui3")
end

-- --获得章节地图背景
-- function PathEx.getChapterBG(id)
-- 	return "mline/img_mline_bg0"..id..jpg_suffix
-- end

-- --获得系统字图案
function PathEx.getSystemImage(id)
    -- return "ui3/text/system/"..id..png_suffix
    return PathEx.get(id,"system")
end

-- --获得战斗中ui资源
function PathEx.getBattleRes(id)
    -- return "ui3/battle/"..id..png_suffix
    return PathEx.get(id,"battle","ui3")
end

-- --获得标记
function PathEx.getBattleMark(id)
    -- return "ui3/battle/showmark/"..id..png_suffix
    return PathEx.get(id,"battle/showmark","ui3")
end

--获得战斗字体
function PathEx.getBattleFont(id)
    -- return "ui3/text/battle/"..id..png_suffix
    return PathEx.get(id,"battle")
end

--获得抽奖积分宝箱图
function PathEx.getRecruitImage(id)
    -- return "ui3/drawcard/"..id..png_suffix
    return PathEx.get(id,"drawcard","ui3")
end

--技能展示
function PathEx.getSkillShow(id)
    -- return "ui3/text/skill/"..id..png_suffix
    return PathEx.get(id,"skill")
end

--返回ui数字以及plist
function PathEx.getBattleNum(id)
    -- return "ui3/text/battle/"..id..png_suffix, "ui3/text/battle/"..id..plist_suffix
    local langPngPath = "i18n/" .. Lang.lang .. "/ui3/text/battle/" .. id .. json_suffix
    local langPlistPath = "i18n/" .. Lang.lang .. "/ui3/text/battle/" .. id .. json_suffix
	if not Lang.checkLang(Lang.CN) and PathEx.isExist(langPngPath) and PathEx.isExist(langPlistPath) then
        return langPngPath, langPlistPath
    else
        return "ui3/text/battle/"..id..png_suffix, "ui3/text/battle/"..id..plist_suffix
    end
end

--返回展示资源
function PathEx.getShowHero(id)
    -- return "ui3/showhero/"..id..png_suffix
    return PathEx.get(id,"showhero","ui3")
end

--展示名字
function PathEx.getShowHeroName(id)
    -- return "ui3/showhero/show_name/"..id..png_suffix
    return PathEx.get(id,"showhero/show_name","ui3")
end

--神兵图片
function PathEx.getInstrument(id)
    -- return "icon/instrumentbig/"..id..png_suffix
    return PathEx.get(id,"instrumentbig","icon")
end

-- --无差别竞技段位图片
function PathEx.getSeasonDan(id)
    -- return "ui3/fight/"..id..png_suffix
    return PathEx.get(id,"fight","ui3")
end

--无差别竞技星级txt图片
function PathEx.getSeasonStar(id)
    -- return "ui3/text/fight/"..id..png_suffix
    return PathEx.get(id,"fight")
end

-- --故事剧情表情
-- function PathEx.getStoryChatFace(id)
-- 	return "ui3/face/"..id..png_suffix
-- end


function PathEx.getArenaUI(id)
    -- return "ui3/arena/"..id..png_suffix
    return PathEx.get(id,"arena","ui3")
end

-- function PathEx.getStageMapPath(path)

-- 	local function getfile(path, fileName)
-- 		local fileUtils = cc.FileUtils:getInstance()
-- 		local picName = "mline/stage/"..path..fileName..jpg_suffix
-- 		if not fileUtils:isFileExist(picName) then
-- 			picName = "mline/stage/"..path..fileName..png_suffix
-- 		end
-- 		if not fileUtils:isFileExist(picName) then
-- 			picName = nil
-- 		end
-- 		return picName
-- 	end
-- 	local back = getfile(path, "/back")
-- 	local mid = getfile(path, "/mid")
-- 	local front = getfile(path, "/front")
-- 	return back, mid, front

-- 	-- local fileUtils = cc.FileUtils:getInstance()
-- 	-- local back = "ui3/mline/stage/"..path.."/back"..jpg_suffix
-- 	-- if not fileUtils:isFileExist(back) then
-- 	-- 	back = "ui3/mline/stage/"..path.."/back"..png_suffix
-- 	-- end
-- 	-- if not fileUtils:isFileExist(back) then
-- 	-- 	back = nil
-- 	-- end

-- 	-- local mid = "ui3/mline/stage/"..path.."/mid"..png_suffix
-- 	-- if not fileUtils:isFileExist(mid) then
-- 	-- 	mid = nil
-- 	-- end

-- 	-- local front = "ui3/mline/stage/"..path.."/front"..png_suffix
-- 	-- if not fileUtils:isFileExist(front) then
-- 	-- 	front = nil
-- 	-- end

-- 	-- return back, mid, front
-- end

-- function PathEx.getStageSceneName(scene)
-- 	return "app.scene.view.stage.scene.Scene"..scene
-- end

-- function PathEx.getComplexRankUI(id)
-- 	return "ui3/complexrank/"..id..png_suffix
-- end

function PathEx.getWorldBossUI(id)
    -- return "ui3/challenge/world_boss/"..id..png_suffix
    return PathEx.get(id,"challenge/world_boss","ui3")
end

-- function PathEx.getFightSceneEffect(effect)
-- 	return "moving_"..effect
-- end

-- function PathEx.getFightSceneBackground(id)
-- 	return "fight/scene/"..id
-- end

function PathEx.getCommonFrame(id)
    -- return "ui3/common/frame/"..id..png_suffix
    return PathEx.get(id,"common/frame","ui3")
end

function PathEx.getCommonImage(id)
    -- return "ui3/common/"..id..png_suffix
    return PathEx.get(id,"common","ui3")
end

-- function PathEx.getParticle(id)
-- 	return "effect/particle/"..id..plist_suffix
-- end

function PathEx.getRanking(id)
    -- return "ui3/ranking/"..id..png_suffix
    return PathEx.get(id,"ranking","ui3")
end

function PathEx.getVipNum(id)
    -- return "ui3/vip/vip_"..id..png_suffix
    return PathEx.get("vip_"..id,"vip","ui3")
end

function PathEx.getHeroVoice(id)
    -- return "audio/voice/"..id..mp3_suffix
    return PathEx.getAudio(id,"voice","audio",mp3_suffix)
end

function PathEx.getNextFunctionOpen(id)
    -- return "ui3/newopen/"..id..png_suffix
    return PathEx.get(id,"newopen","ui3")
end


function PathEx.getChooseServerRes(id)
    -- return "ui3/chooseserver/"..id..png_suffix
    return PathEx.get(id,"chooseserver","ui3")
end

-- function PathEx.getServerStatusIcon(status)
-- 	local img = SERVER_STATUS_IMGS[status]
-- 	local statusIcon =  PathEx.getChooseServerRes(img)
-- 	return statusIcon,img and img ~= ""
-- end

-- function PathEx.getServerStatusBigIcon(status)
-- 	return PathEx.getChooseServerRes(SERVER_STATUS_IMGS_2[status])
-- end

-- function PathEx.getGuildRes(id)
-- 	return "ui3/guild/"..id..png_suffix
-- end

function PathEx.getRechargeRmb(id)
    -- return "ui3/vip/rmb_" .. id .. png_suffix
    return PathEx.get("rmb_"..id,"vip","ui3")
end


function PathEx.getRechargeVip(id)
    -- return "ui3/vip/vip_" .. id .. png_suffix
    return PathEx.get("vip_"..id,"vip","ui3")
end

function PathEx.getFetterRes(id)
    -- return "ui3/fetter/"..id..png_suffix
    return PathEx.get(id,"fetter","ui3")
end

function PathEx.getBackground(id, suffix)
    suffix = suffix or jpg_suffix
 	return PathEx.get(id,"background","ui3",suffix)
end

function PathEx.getMonthlyCardRes(id)
    -- return "ui3/activity/"..id..png_suffix
    return PathEx.get(id,"activity","ui3")
end


function PathEx.getActivityRes(id)
    -- return "ui3/activity/"..id..png_suffix
    return PathEx.get(id,"activity","ui3")
end

function PathEx.getActivityTextRes(id)
	-- return "ui3/text/activity/"..id..png_suffix
    return PathEx.get(id,"activity")
end


-- function PathEx.getVoiceRes(id)
-- 	return "ui3/voice/"..id..png_suffix
-- end


function PathEx.getTextMain(id)
    -- return "ui3/text/main/"..id..png_suffix
    return PathEx.get(id,"text/main","ui3")
end

function PathEx.getDrawCard(id)
    -- return "ui3/drawcard/"..id..png_suffix
    return PathEx.get(id,"drawcard","ui3")
end

function PathEx.getGuide(id)
    -- return "ui3/guide/"..id..png_suffix
    return PathEx.get(id,"guide","ui3")
end

function PathEx.getChatFaceMiniRes(id)
    -- return "ui3/face/mini/"..id..png_suffix
    return PathEx.get(id,"face/mini","ui3")
end

-- function PathEx.getBackgroundEffect(id)
-- 	return "ui3/background/effects/"..id..png_suffix
-- end


function PathEx.getTextBattle(id)
    -- return "ui3/text/battle/" .. id ..png_suffix
    return PathEx.get(id,"battle")
end

function PathEx.getPlayerVip(id)
    -- return "ui3/main/img_main_vip" .. id .. png_suffix
    return PathEx.get("img_main_vip"..id,"main","ui3")
end

function PathEx.getPlayerIcon(id)
    -- return "ui3/main/" .. id .. png_suffix
    return PathEx.get(id,"main","ui3")
end

 function PathEx.getMainDir()
     -- return "ui3/text/main/"
 	if not Lang.checkLang(Lang.CN) then
 		return "i18n/" .. Lang.lang .. "/ui3/text/main/"
 	else
         return "ui3/text/main/"
     end
 end

-- function PathEx.getBattleDir()
--     -- return "ui3/text/battle/"
-- 	if not Lang.checkLang(Lang.CN) then
-- 		return "i18n/" .. Lang.lang .. "/ui3/text/battle/"
-- 	else
--         return "ui3/text/battle/"
--     end
-- end

-- function PathEx.getBattlePowerDir()
--     -- return "ui3/text/battlepower/"
-- 	if not Lang.checkLang(Lang.CN) then
-- 		return "i18n/" .. Lang.lang .. "/ui3/text/battlepower/"
-- 	else
--         return "ui3/text/battlepower/"
--     end
-- end

function PathEx.getChapterNameIcon(id)
    -- return "ui3/text/city/" .. id .. png_suffix
    return PathEx.get(id,"city")
end

function PathEx.getTeamUI(id)
    -- return "ui3/team/"..id..png_suffix
    return PathEx.get(id,"team","ui3")
end

function PathEx.getTextGuild(id)
    -- return "ui3/text/guild/" .. id .. png_suffix
    return PathEx.get(id,"guild")
end

-- function PathEx.getFamousImage(id)
-- 	return "mline/general/"..id..png_suffix
-- end

-- function PathEx.getPreBattleImg(id)
-- 	return "ui3/prebattle/"..id..png_suffix
-- end

function PathEx.getTimeActivities(id)
    -- return "ui3/time_activities/"..id..png_suffix
    return PathEx.get(id,"time_activities","ui3")
end

function PathEx.getTurnscard(id, suffix)
	suffix = suffix or png_suffix
    -- return "ui3/turnscard/"..id..suffix
    return PathEx.get(id,"turnscard","ui3",suffix)
end

-- function PathEx.getTask(id)
-- 	return "ui3/task/"..id..png_suffix
-- end

-- function PathEx.getMail(id)
-- 	return "ui3/mail/"..id..png_suffix
-- end

function PathEx.getPet( id )
    -- return "ui3/beast/"..id..png_suffix
    return PathEx.get(id,"beast","ui3")
end

-- function PathEx.getCrystalShop( id )
-- 	-- body
-- 	return "ui3/crystalshop/"..id..png_suffix
-- end

function PathEx.getCrystalShopText( id )
	-- body
    -- return "ui3/text/activity/"..id..png_suffix
    return PathEx.get(id,"activity")
end

-- function PathEx.getGuildDungeonUI( id )
-- 	return "ui3/guilddungeon/"..id..png_suffix
-- end

-- function PathEx.getGuildDungeonJPG( id )
-- 	return "ui3/guilddungeon/"..id..jpg_suffix
-- end

function PathEx.getTalent( id )
    -- return "ui3/text/talent/"..id..png_suffix
    return PathEx.get(id,"talent")
end

function PathEx.getMineNodeTxt(id)
    -- return "ui3/text/mine_craft/"..id..png_suffix
    return PathEx.get(id,"mine_craft")
end

function PathEx.getMineImage(id)
    -- return "ui3/minecraft/"..id..png_suffix
    return PathEx.get(id,"minecraft","ui3")
end

function PathEx.getGuildAnswerText(id)
    -- return "ui3/text/answer/"..id..png_suffix
    return PathEx.get(id,"answer")
end

function PathEx.getLimitActivityIcon(id)
    -- return "icon/time_limit/"..id..png_suffix
    return PathEx.get(id,"time_limit","icon")
end

function PathEx.getCustomActivityUI(id)
    -- return "ui3/activity/limit/"..id..png_suffix
    return PathEx.get(id,"activity/limit","ui3")
end

-- function PathEx.getGuildFlagImage(index)
-- 	return string.format("ui3/guild/img_flag_colour%02d%s",index,png_suffix)
-- end

-- function PathEx.getGuildVerticalFlagImage(index)
-- 	return string.format("ui3/guild/img_flag_colour%02da%s",index,png_suffix)
-- end

-- function PathEx.getGuildFlagColorImage(index)
-- 	return string.format("ui3/guild/img_colour%02d%s",index,png_suffix)
-- end


function PathEx.getShareImage(id)
    -- return "ui3/share/"..id..jpg_suffix
    return PathEx.get(id,"share","ui3")
end

function PathEx.getCountryBossText(id)
    -- return "ui3/text/guild/"..id..png_suffix
    return PathEx.get(id,"guild")
end

-- function PathEx.getCountryBossImage(id)
-- 	return "ui3/countryboss/"..id..png_suffix
-- end


function PathEx.getLinkageActivity(id)
	return "ui3/gang_activity/"..id..png_suffix
end

function PathEx.getTextHomeland(id)
    -- return "ui3/text/homeland/"..id..png_suffix
    return PathEx.get(id,"homeland")
end

function PathEx.getHomelandUI(id)
    -- return "ui3/homeland/"..id..png_suffix
    dump( PathEx.get(id,"homeland","ui3"),"---- PathEx.getHomelandUI: ")
    return PathEx.get(id,"homeland","ui3")
end

function PathEx.getTextCampRace(id)
    -- return "ui3/text/camp_battle/"..id..png_suffix
    return PathEx.get(id,"camp_battle")
end

function PathEx.getCampImg(id)
    -- return "ui3/camp_battle/"..id..png_suffix
    return PathEx.get(id,"camp_battle","ui3")
end

function PathEx.getCampJpg(id)
    -- return "ui3/camp_battle/"..id..jpg_suffix
    return PathEx.get(id,"camp_battle","ui3",jpg_suffix)
end

function PathEx.getRunningMan( id )
    -- return "ui3/runway/"..id..png_suffix
    return PathEx.get(id,"runway","ui3")
end

function PathEx.getGuildWar( id )
    -- return "ui3/war/"..id..png_suffix
    return PathEx.get(id,"war","ui3")
end

function PathEx.getTextLimit(id)
    -- return "ui3/text/limit/"..id..png_suffix
    return PathEx.get(id,"limit")
end

function PathEx.getLimitImg(id)
    -- return "ui3/limit/"..id..png_suffix
    return PathEx.get(id,"limit","ui3")
end

-- function PathEx.getHorseRaceImg(id)
-- 	return "ui3/horserace/"..id..png_suffix
-- end

function PathEx.getSvip(id)
    -- return "ui3/service/"..id..jpg_suffix
    return PathEx.get(id,"service","ui3")
end

function PathEx.getMineDoubleImg(id)
    -- return "ui3/text/signet/img_mine_craft0"..id..png_suffix
    return PathEx.get("img_mine_craft0"..id,"signet")
end


function PathEx.getQinTomb( id )
    -- return "ui3/qintomb/"..id..png_suffix
    return PathEx.get(id,"qintomb","ui3")
end

function PathEx.getTextQinTomb(id)
    -- return "ui3/text/qintomb/"..id..png_suffix
    return PathEx.get(id,"qintomb")
end

-- function PathEx.getLinkageActivity(id)
-- 	return "ui3/linkageactivity/"..id..png_suffix
-- end

function PathEx.getBattlePet(id)
    -- return "ui3/battle/pet/"..id..png_suffix
    return PathEx.get(id,"battle/pet","ui3")
end


function PathEx.getTowerChallengeIcon(id)
    -- return "ui3/challenge/tower/"..id..png_suffix
    return PathEx.get(id,"challenge/tower/","ui3")
end

function PathEx.getFullPath(path)
    local newPath = string.gsub(path,"res/ui3/","i18n/" .. Lang.lang .. "/ui3/" )
    if newPath and cc.FileUtils:getInstance():isFileExist(newPath) then
        logWarn("getFullPath  "..newPath)
        return newPath
    end
     logWarn("getFullPath  "..path)
    return path
end


function PathEx.getLoginImg(id)
	return PathEx.get(id,"login","ui3")
end


function PathEx.getGuildRes(id)
	return PathEx.get(id,"guild","ui3") 
end

function PathEx.getGuildWar( id )
	return PathEx.get(id,"war","ui3") 
end


function PathEx.getStageBG(id)
	return PathEx.get(id,"stage","ui3",jpg_suffix)
end

function Path.getCreateImage(id)
    return PathEx.get(id,"create","ui3") 
end

function Path.getVip(id)
	return PathEx.get(id,"vip","ui3")
end

-- 获得英雄等级图片
function Path.getOfficialImg(id)
    return PathEx.get(id,"official","ui3")
end

--金将文本图片
function Path.getGoldHeroTxt(id)
     return PathEx.get(id,"gold_hero")
end

function Path.getRedBagImg(id)
	return PathEx.get(id,"redbag","ui3")
end

function Path.getTextAnniversaryImg(id, suffix)
	return  PathEx.get(id,"anniversary","ui3/text",suffix) 
end

function Path.getGoldHero(id)
    return  PathEx.get(id,"gold_hero","ui3")
end
--替换individual_competitive按钮背景
function Path.getIndividualCompetitiveImg(id)
    return PathEx.get(id,"individual_competitive","ui3")
end

--i18n 获取翻译相关的图片
function Path.getTranslate(id)
    return  PathEx.get(id,"translate","ui3")
end


--i18n 小额充值资源
function PathEx.getSmallRechargeRes(id)
    return  PathEx.get(id,"little_charge_res","ui3")
end
