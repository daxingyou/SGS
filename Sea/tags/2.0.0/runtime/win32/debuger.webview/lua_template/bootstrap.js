// WebKit的编码转换有点奇怪的

window.lua = window.lua || {}
window.lua.template = 
{
    "测试驱动" : 
    {
        "luaRequire重载": 
        {
            "luaRequire": "reload_require/reload_require.lua",
        },
        "打印测试": 
        {
            "测试": "test/test/test_action.lua",
        },
        "UI控件测试界面" : 
        {
     	    "测试界面": "UIControlScene/testScene.lua",
        },
        "模拟服务器协议" : 
        {
     	    "世界boss": "server_message/worldboss/msg.lua",
        },
 	"返回登录界面" : 
        {
     	    "返回": "returnToLogin/code.lua",
        },
    }
};
