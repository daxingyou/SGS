local function replaceRequire()
    local OLD_REQUIRE = require
    cc.enable_global( function() 
        SAVE_LIST = {}
    end)

    local function saveOldRequire()
        for k, _ in pairs(package.loaded) do
            SAVE_LIST = k
        end
    end
    local function newRequire(key)
        if not SAVE_LIST[key] then
            package.loaded[key] = nil
            return OLD_REQUIRE(key)
        end
        return OLD_REQUIRE(k)
    end
    saveOldRequire()
    require = newRequire
end

--打开lua文件重加载功能，方便代码编写测试
replaceRequire()