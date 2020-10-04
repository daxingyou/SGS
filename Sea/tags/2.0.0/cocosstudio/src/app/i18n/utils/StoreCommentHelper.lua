local StoreCommentHelper = {}

function StoreCommentHelper.setShowFlag()
    if Lang.checkLang(Lang.KR) or Lang.checkLang(Lang.TW) or Lang.checkChannel(Lang.CHANNEL_SEA) then
    	if not G_ConfigManager:isStoreCommentOpen() then
    		return
    	end
        local curLevel = G_UserData:getBase():getLevel()
        local commentCfg = require("app.config.comment").get(1)
        local commentLevel = commentCfg.level
        local flag = G_UserData:getBase():getStore_comment_flag()
        -- print("lkm111111=-=------------------------------1",flag,commentLevel,curLevel)
        if flag == 0 and curLevel == commentLevel then
        	G_UserData:getBase():setShowCommentFlag(true)
		end
    end
end

function StoreCommentHelper.checkComment()
    if Lang.checkLang(Lang.KR) or Lang.checkLang(Lang.TW) or Lang.checkChannel(Lang.CHANNEL_SEA) then
    	if G_UserData:getBase():getShowCommentFlag() then
	    	local noTutorial = not G_TutorialManager:isDoingStep()
	    	local isMain = G_SceneManager:getRunningSceneName() == "main"
	        if noTutorial and isMain then
	            local popup = require("app.i18n.extends.ui.PopupCommentGuideEx").new()
	            popup:openWithAction()
        		G_UserData:getBase():setShowCommentFlag(false)
	        end
    	end
    end
end

return StoreCommentHelper