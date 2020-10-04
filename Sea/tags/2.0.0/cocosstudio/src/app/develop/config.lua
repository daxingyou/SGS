--
require "socket"
print = release_print
-- 开发模式
APP_DEVELOP_MODE = false

-- 开启新手引导
CONFIG_TUTORIAL_ENABLE = false

--开启直接读假战报以及场景
CONFIG_READ_REPORT = true

--开启消息buff输出
CONFIG_OPEN_DUMP_MESSAGE = true

--是否隐藏战斗ui
CONFIG_HIDE_FIGHT_UI = false

-- 开启跳过战斗
CONFIG_JUMP_BATTLE_ENABLE = true

-- 开启假战报输出
CONFIG_FAKE_REPORT_ENABLE = true

-- 开启战斗调速
CONFIG_SHOW_SPEED_ADJUST = true

-- 开启剧情对话
CONFIG_SHOW_STORY_CHAT = true

--
CONFIG_TUTORIAL_DARK_ALPHA = 127

--游历是否可以自由拖动地图
CONFIG_EXPLORE_FREE_MOVE = true

--node ref 引用计数检测(内存泄漏的相关)
ENABLE_RECORD_REF_COUNT = false

--node ref 引用计数检测(内存泄漏的相关)
ENABLE_LUA_AUTO_RELOAD = true

--虚拟跑马
FAKE_HORCE_RUN = false

--客户端强制不需要实名
-- NO_REAL_NAME = false

-- 测试充值地址
--i18n change
-- RECHARGE_TEST_URL_TEMPLATE = "http://url/platform/recharge?gameID=#gameID#&extension=#extension#&productID=#productID#&orderID=#orderID#&sign=#sign#&platformID=#platformID#&userName=#userName#&serverID=#serverID#&orderTime=#orderTime#&money=#money#&signType=md5&currency=RMB&channelID=#channelID#"
RECHARGE_TEST_URL_TEMPLATE = "http://url/platform/recharge?gameID=#gameID#&extension=#extension#&productID=#productID#&orderID=#orderID#&cp_order_id=#cp_order_id#&sign=#sign#&platformID=#platformID#&userName=#userName#&serverID=#serverID#&orderTime=#orderTime#&money=#money#&signType=md5&currency=RMB&channelID=#channelID#"
-- RECHARGE_TEST_URL = "10.235.102.205:9499" --内网
RECHARGE_TEST_URL = "10.235.200.13:9999" --海外

-- 本地开发
-- 运营商
SPECIFIC_OP_ID = 1
-- SPECIFIC_OP_ID = 2       --ios & 永测
-- SPECIFIC_OP_ID = 3
-- SPECIFIC_OP_ID = 83
-- SPECIFIC_OP_ID = 90
-- SPECIFIC_OP_ID = 105       --越南 版署


-- 运营平台
SPECIFIC_GAME_OP_ID = 1000
-- SPECIFIC_GAME_OP_ID = 1004       --ios
-- SPECIFIC_GAME_OP_ID = 1001      --安卓&永测
-- SPECIFIC_GAME_OP_ID = 1006       --大蓝
-- SPECIFIC_GAME_OP_ID = 3001       --越南 版署

-- 游戏id
SPECIFIC_GAME_ID = 1

-- 测试token
TOKEN_KEY = "9d4923d485d78a95503d7979173a2876"    --海外
-- TOKEN_KEY = "31b751398deb6435f14adba54ae8a9b8"  --海外 版署
-- TOKEN_KEY = "31b751398deb6435f14adba54ae8a9b8"  --海外 测试
-- TOKEN_KEY = "9d4923d485d78a95503d7979173a2876"   --内网
-- TOKEN_KEY = "31b751398deb6435f14adba54ae8a9b8"   --ios&永测

-- GM配置文件
CONFIG_URL = "http://10.235.200.13:8080"            --海外
-- CONFIG_URL = "http://47.244.89.96:8080"            --海外 版署
-- CONFIG_URL = "http://47.244.89.96:8080"            --海外 测试
-- CONFIG_URL = "http://10.235.102.205:8080"       --内网
-- CONFIG_URL = "https://configmjz.sanguosha.com"       --ios
-- CONFIG_URL = "http://139.196.109.209:8080"      --永测
-- CONFIG_URL = "https://configmjzml.sanguosha.com"     --大蓝

-- 服务器列表
SERVERLIST_URL = "http://10.235.200.13:38434"          --海外 1.8版本
-- SERVERLIST_URL = "http://61.28.254.67:38434"          --海外 版署
-- SERVERLIST_URL = "http://61.28.254.66:38434"          --海外 测试
-- SERVERLIST_URL = "http://10.235.102.205:38434"      --内网
-- SERVERLIST_URL = "https://eaglemjz.sanguosha.com"       --ios
-- SERVERLIST_URL = "http://139.196.109.209:38434"     --用测
-- SERVERLIST_URL = "https://eaglemjzml.sanguosha.com"     --大蓝

-- 网关列表
GATEWAYLIST_URL = "http://10.235.200.13:38434"          --海外 1.8版本
-- GATEWAYLIST_URL = "http://61.28.254.67:38434"          --海外 版署
-- GATEWAYLIST_URL = "http://61.28.254.66:38434"          --海外 测试
-- GATEWAYLIST_URL = "http://10.235.102.205:38434"          --内网
-- GATEWAYLIST_URL = "https://eaglemjz.sanguosha.com"      --ios
-- GATEWAYLIST_URL = "http://139.196.109.209:38434"        --永测
-- GATEWAYLIST_URL = "https://eaglemjzml.sanguosha.com"    --大蓝

-- 角色列表
ROLELIST_URL = "http://10.235.200.13:10167"             --海外
-- ROLELIST_URL = "http://61.28.254.67:10167"             --海外 版署
-- ROLELIST_URL = "http://61.28.254.67:10167"             --海外 测试 
-- ROLELIST_URL = "http://10.235.102.205:10167"             --内网
-- ROLELIST_URL = "https://eaglemjz.sanguosha.com"       --ios
-- ROLELIST_URL = "https://lyrolemjz.sanguosha.com"        --大蓝
-- ROLELIST_URL = "https://rolemjz.sanguosha.com"

--[[
RECHARGE_TEST_URL = "10.235.200.19:9999"                --海外     1.11版本
CONFIG_URL = "http://10.235.200.19:8080"            --海外
GATEWAYLIST_URL = "http://10.235.200.19:38434"          --海外  1.11版本
SERVERLIST_URL = "http://10.235.200.19:38434"          --海外  1.11版本
ROLELIST_URL = "http://10.235.200.19:10167"             --海外 1.11版本
]]

RECHARGE_TEST_URL = "10.235.200.20:27999"                --海外    2.0版本
CONFIG_URL = "http://10.235.200.20:8088"                --海外
GATEWAYLIST_URL = "http://10.235.200.20:27434"          --海外  2.0版本
SERVERLIST_URL = "http://10.235.200.20:27434"          --海外  2.0版本
ROLELIST_URL = "http://10.235.200.20:10167"             --海外 2.0版本


--先锋
--[[
-- 运营商
SPECIFIC_OP_ID = 1

-- 运营平台
SPECIFIC_GAME_OP_ID = 2001

-- 游戏id
SPECIFIC_GAME_ID = 1

-- 测试token
TOKEN_KEY = "31b751398deb6435f14adba54ae8a9b8"

-- GM配置文件
CONFIG_URL = "123.206.106.195:8080"

-- 服务器列表
SERVERLIST_URL = "115.159.113.30:38434"

-- 网关列表
GATEWAYLIST_URL = "115.159.113.30:38434"
]]


--大蓝
--[[
SPECIFIC_OP_ID = 90

-- 运营平台
SPECIFIC_GAME_OP_ID = 1006

-- 游戏id
SPECIFIC_GAME_ID = 1

-- 测试token
TOKEN_KEY = "31b751398deb6435f14adba54ae8a9b8"

-- GM配置文件
CONFIG_URL = "http://106.14.242.139:8080"

-- 服务器列表
SERVERLIST_URL = "http://106.14.245.44:38434"

-- 网关列表
GATEWAYLIST_URL = "http://106.14.245.44:38434"

ROLELIST_URL = "https://lyrolemjz.sanguosha.com"
]]

-- i18n 显示切换语言按钮
CONFIG_SHOW_SWITCH_LANGUAGE = false
-- i18n 附加服务器列表
SPECIFIC_ADD_SERVER = ""