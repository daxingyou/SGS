xpcall(function (  )

    local avatar_mapping = require("app.config.avatar_mapping")
    avatar_mapping.setLang = function(id, key, value)
        local record = avatar_mapping.get(id)
        if record then
            local keyIndex =  record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
            end
        end
    end

    avatar_mapping.setLang(119,"description", "받는 스킬 피해의 20% 생명전환, 자신치료" )

end,function( ... )
end)

xpcall(
    function()
        CONFIG_TUTORIAL_ENABLE = true
    end,
    function(...)
    end
)

