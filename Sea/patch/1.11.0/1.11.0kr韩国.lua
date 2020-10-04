xpcall(function (  )

    local function_level = require("app.config.function_level")
    function_level.setLang = function(id, key, value)
        local record = function_level.get(id)
        if record then
            local keyIndex =  record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
            end
        end
    end

    function_level.setLang(89,"show_level",999)
    function_level.setLang(89,"level",999)

end,function( ... )
end)

xpcall(function ()

local Version = require("yoka.utils.Version")
local r = Version.compare("0.0.1", VERSION_RES)
if r == Version.CURRENT then
    local paomadeng = require("app.i18n.kr.config.paomadeng")
    paomadeng._data[29] =  {131," #legion#군단에서 #number#금화로 적색장수 #hero#을(를) 입찰하는데 성공했습니다!",}
    paomadeng._data[93] =  {511,"패왕강림! 우리군단#name#님이 결승에서 승리하여 【#country#패왕】이 되었습니다.",}
    paomadeng._data[98] =  {605,"#legion#군단에서 #number#금화로 적색영혼 #hero#을(를) 입찰하는데 성공했습니다!",}

    local festival_res = require("app.i18n.kr.config.festival_res")
    festival_res._data[20] = {20,"신년",}
        local LangTemplate = require("app.i18n.kr.LangTemplate")
        LangTemplate[ "funds_actived_weekdesc"] = "  7일 동안 매일 선물획득"
end

end,function( ... )
end)

