local NativeConst = {}

--
NativeConst.STATUS_SUCCESS 					= 0
NativeConst.STATUS_FAILED 					= 1
NativeConst.STATUS_ERROR 					= 2
NativeConst.STATUS_CANCEL 					= 3
NativeConst.STATUS_PROCESS 					= 4

-- 初始化
NativeConst.NETWORK_TYPE_RESTRICTED 		= 101 --  网络受限
NativeConst.NETWORK_TYPE_NOTRESTRICTED 		= 102 --  网络不受限

-- 初始化
NativeConst.INIT_TYPE_SUCCESS 				= 1000 -- 检查到有版本更新
NativeConst.INIT_TYPE_FAILED 				= 1001 -- 检查到没有版本更新

-- 检查版本
NativeConst.CHECK_VERSION_TYPE_NEW 			= 1200 -- 检查到有版本更新
NativeConst.CHECK_VERSION_TYPE_WITHOUT_NEW 	= 1201 -- 检查到没有版本更新
NativeConst.CHECK_VERSION_TYPE_WITHOUT 		= 1202 -- 没有版本更新接口

-- 注销弹窗类型
NativeConst.LOGOUT_TYPE_UNKNOWN 			= 1300 -- 注销弹窗类型，由于某种原因未知
NativeConst.LOGOUT_TYPE_UNAVAILABLE 		= 1301 -- 渠道SDK没有提供注销接口，默认注销成功
NativeConst.LOGOUT_TYPE_NO_DIALOG 			= 1302 -- 渠道SDK有注销接口，注销时不会弹出是否注销的选择界面
NativeConst.LOGOUT_TYPE_HAS_DIALOG 			= 1303 -- 渠道SDK存在注销接口，注销时弹出注销选择确认界面

-- 注销之后是否打开登录界面
NativeConst.LOGOUT_HAS_LOGIN_UNKNOWN 		= 1400 -- 注销后是否打开登录界面，由于某种原因未知
NativeConst.LOGOUT_HAS_LOGIN 				= 1401 -- 注销后会打开登录界面
NativeConst.LOGOUT_HAS_LOGIN_NO 			= 1402 -- 注销后不会打开登录界面

--
NativeConst.EXIT_TYPE_UNKOWN 				= 1500 	--退出弹窗类型，未知
NativeConst.EXIT_TYPE_UNAVAILABLE			= 1501 	--渠道SDK没有提供退出接口
NativeConst.EXIT_TYPE_NO_DIALOG 			= 1502 	--渠道SDK有退出接口，退出时不会弹出退出对话框界面
NativeConst.EXIT_TYPE_HAS_DIALOG 			= 1503 	--渠道SDK存在退出接口，退出时弹出退出选择界面

--
NativeConst.SHARE_TYPE_WECHAT_SESSION		= 1	--分享至微信好友
NativeConst.SHARE_TYPE_WECHAT_TIMELINE		= 2	--分享至微信朋友圈
NativeConst.SHARE_TYPE_WECHAT_FAVORITE		= 3	--分享至微信收藏
NativeConst.SHARE_TYPE_QQ_SESSION			= 4	--分享至QQ好友
NativeConst.SHARE_TYPE_QZONE				= 5	--分享至QQ空间

--
NativeConst.ID_TYPE_YOUNG                   = 1 --实名认证的时候未满18岁

-- 
NativeConst.SDKAgentVersion 				= "NativeAgentVersion"
NativeConst.SDKCheckVersionResult 			= "SDKCheckVersionResult"
NativeConst.SDKLoginResult 					= "SDKLoginResult"
NativeConst.SDKLogoutResult 				= "SDKLogoutResult"
NativeConst.SDKExitResult 					= "SDKExitResult"
NativeConst.SDKPayResult 					= "SDKPayResult"
NativeConst.SDKShareResult					= "SDKShareResult"
NativeConst.SDKIdResult                     = "SDKIdResult"


NativeConst.DeviceToken					    = "DeviceToken"                     --i18n ios推送token
NativeConst.SDKBindGuestResult		        = "SDKBindGuestResult"              --i18n 渠道sdk绑定游客账户

NativeConst.SDKTranslateWithTextResult      = "SDKTranslateWithTextResult"      --i18n  翻译
NativeConst.SDKGenCitationCodeResult        = "SDKGenCitationCodeResult"        --i18n  获取引继码
NativeConst.SDKLoginWithCitationCodeResult  = "SDKLoginWithCitationCodeResult"  --i18n  使用引继码
NativeConst.SDKSavePhotoResult              = "SDKSavePhotoResult"              --i18n  保存图片到相册


NativeConst.SDK_SYSTEM_BIND 				= "bind"     --i18n sdk 绑定账户界面
NativeConst.SDK_SYSTEM_SWITCH 			    = "switch"   --i18n sdk 切换账户界面

NativeConst.SDK_CHANNEL_GUEST 			    = "guest"           --i18n sdk 游客
NativeConst.SDK_CHANNEL_FACEBOOK 			= "facebook"        --i18n sdk facebook
NativeConst.SDK_CHANNEL_TWITTER 			= "twitter"         --i18n sdk twitter
NativeConst.SDK_CHANNEL_LINE       			= "line"            --i18n sdk line
NativeConst.SDK_CHANNEL_GAMECENTER			= "gamecenter"      --i18n sdk gamecenter
NativeConst.SDK_CHANNEL_GOOGLE			    = "google"          --i18n sdk google
NativeConst.SDK_CHANNEL_APPLE			    = "apple"           --i18n sdk apple
NativeConst.SDK_CHANNEL_CITATIONCODE		= "citationcode"    --i18n sdk 引继码

NativeConst.SDK_SHARE_IMAGE                 = "image"           --i18n sdk 分享图片
NativeConst.SDK_SHARE_TEXT                  = "text"            --i18n sdk 分享文本
NativeConst.SDK_SHARE_URL                   = "url"             --i18n sdk 分享链接

NativeConst.SDK_SHARE_IMG_NAME              = "week_share.jpg"              --i18n sdk 分享图片名字
NativeConst.SDK_TEMP_CITATIONCODE_IMG       = "temp_citationcode.jpg"       --i18n sdk 保存引继码图片名字
NativeConst.SDK_DOWNLOAD_IMG_NAME           = "#name#.jpg"       --i18n sdk 下载图片名称


return NativeConst