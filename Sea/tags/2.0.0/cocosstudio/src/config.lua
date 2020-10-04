
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 2

-- use framework, will disable all deprecated API, false - use legacy API
CC_USE_FRAMEWORK = true

-- for module display
CC_DESIGN_RESOLUTION = {
    width = 1136,
    height = 640,
    autoscale = "FIXED_WIDTH", --"FIXED_HEIGHT",
    callback = function(framesize)
        local ratio = framesize.width / framesize.height
        print(framesize.width, framesize.height, ratio)
        -- self._designSize = cc.size(math.min(CC_DESIGN_RESOLUTION.width, display.width),math.min(CC_DESIGN_RESOLUTION.height, display.height))
        -- if framesize.height >= 640 and ratio <= 1.8 then
        --     _width = math.min(framesize.width, 1136)
        --     if _width < 1136 then _width = 1136 end
        --     return {width = _width, height = 640,autoscale = "EXACT_FIT"}
        --     -- return {width = math.min(framesize.width, 1136), height = 640,autoscale = "EXACT_FIT"}
        -- end
        if ratio > 1.8 then
            return {width = 1400, height = 640,autoscale = "FIXED_HEIGHT"}
        end
    end
}

MAIN_FRAME_MAX = 45


-- 资源版本号
VERSION_RES = "99.99.99"

-- GM配置文件url
CONFIG_URL_TEMPLATE = "#domain#/api?service=cfg&cmd=get&o=#o#&g=#g#&v=#v#&r=#r#&d=#d#&p=#p#&t=#t#"
CONFIG_URL = ""

-- 服务器列表url
SERVERLIST_URL_TEMPLATE = "#domain#/scenes?userId=#userId#&gameId=#gameId#&gameOpId=#gameOpId#&opId=#opId#&time=#time#&columns=name%7Cfirst_opentime"
SERVERLIST_URL = ""

-- 网关列表url
GATEWAYLIST_URL_TEMPLATE = "#domain#/gates"
GATEWAYLIST_URL = ""

-- 角色列表url
ROLELIST_URL_TEMPLATE = "#domain#/getroleinfo?uuid=#uuid#&opid=#opId#&opgameid=#gameOpId#"
ROLELIST_URL = ""