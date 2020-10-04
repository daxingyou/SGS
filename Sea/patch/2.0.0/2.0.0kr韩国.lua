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

end

end,function( ... )
end)

xpcall(function ()
   local item = require("app.i18n.kr.config.item")
   item._data[123] = {159,"금줄올가미","관공훈마 이벤트 및 펫 교환 시 사용","관공훈마 이벤트 및 펫 교환 시 사용","사용","",}
end,function( ... )
end)


xpcall(function ()
    Lang.getLangTxtFromChannel = function(txt)
        local jsonUrl = json.decode(txt)
        if not jsonUrl or jsonUrl == txt then
            local temp = txt
            temp = string.gsub(temp, "\\\"", "\"")
            temp = string.gsub(temp, "\"{", "{")
            temp = string.gsub(temp, "}\"", "}")
            jsonUrl = json.decode(temp)
        end
        if jsonUrl and jsonUrl ~= txt and type(jsonUrl) == "table" then
            return jsonUrl[Lang.lang] or jsonUrl[table.keys(jsonUrl)[1]]
        end
        return txt
    end
end,function( ... )
end)

xpcall(function ()
    local CakeActivityNoticeData = require("app.data.CakeActivityNoticeData")
    CakeActivityNoticeData.updateData = function(self,data)
        self:setProperties(data)
        self._contentDes = {}
        local contents = rawget(data, "contents") or {}
        for i, content in ipairs(contents) do
            local key = rawget(content, "key")
            local value = rawget(content, "value")
            self._contentDes[key] = Lang.getLangTxtFromChannel(value)
        end
    end
end,function( ... )
end)


xpcall(function ()
    local Version = require("yoka.utils.Version")
    local r = Version.compare("0.0.1", VERSION_RES)
    if r == Version.CURRENT then
        local guild_purview = require("app.config.guild_purview")
        guild_purview._data[2] = {2,"副团长","2|5|6|7|8|9|11|12|15"}
    end

 end,function( ... )
 end)