local HeroShowOld = require("app.scene.view.heroShow.HeroShowOld")
local HeroShowTrue = require("app.scene.view.heroShow.HeroShowTrue")

local HeroShow = {}

-- i18n ui4 新增参数 isFight
function HeroShow.create(heroId, callback, needAutoClose, isRight,isFight)
  
    if Lang.checkUI("ui4") then
        local className = require("app.scene.view.heroShow.PopupHeroShow")
        local heroShow = className.new(heroId, callback, needAutoClose, isRight,isFight)
        heroShow:open()
        return  heroShow 
    else
        local className
        if isRight then
            className = HeroShowOld
        else
            className = HeroShowTrue
        end
        -- assert(spriteFrames and num, "spriteFrames and num could not be nil !")
        local heroShow = className.new(heroId, callback, needAutoClose, isRight)
        heroShow:open()
    end

end


return HeroShow