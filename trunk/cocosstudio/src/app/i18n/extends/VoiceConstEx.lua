local VoiceConst = require("app.const.VoiceConst")
--GCloudVoiceErrno
--common base err
VoiceConst.GCLOUD_VOICE_MODE_ERR 			            = 4109  -- The mode is not support

--realtime err
VoiceConst.GCLOUD_VOICE_ROOMNAME_ERR 		            = 8195  -- quit room err  -- the quit roomname not equal join roomname

--message err
VoiceConst.GCLOUD_VOICE_PATH_ACCESS_ERR 		        = 12290  -- the path can not access   --may be path file not exists or deny to access
VoiceConst.GCLOUD_VOICE_NOTHING_TO_REPORT               = 12300  -- no sound to report

--other functions in realtime err
VoiceConst.GCLOUD_VOICE_COORDINATE_ROOMNAME_ERROR 		= 36867  -- update coordinate in a non-exist room

VoiceConst.GCLOUD_VOICE_SAVEDATA_DOWNLOADING 			= 40961  -- dowloading file for lgame save voice data, need no nothing, just let userinterface know.
VoiceConst.GCLOUD_VOICE_SAVEDATA_INDEXNOTFOUND 			= 40962  -- this file index not found in file map, may not set, have not in this video
VoiceConst.GCLOUD_VOICE_NOENABGLE_WXMINI 			    = 45058  -- need enable WeChat MiniApp
VoiceConst.GCLOUD_VOICE_DEVICE_TVE_ERR 			        = 36866  -- query with a small roomname

--VoiceCompleteCode
--common code
VoiceConst.GV_ON_NET_ERR 						        = 4097  -- network error, maybe can't connect to network
VoiceConst.GV_ON_UNKNOWN 						        = 4098  --
VoiceConst.GV_ON_INTERNAL_ERR 					        = 4099  -- this error needs log for problem location
VoiceConst.GV_ON_BUSINESS_NOT_FOUND 			        = 4100  -- the business not found, maybe you do not open the service
--realtime code
VoiceConst.GV_ON_JOINROOM_SUCC 					        = 8193  -- join room success
VoiceConst.GV_ON_JOINROOM_TIMEOUT 				        = 8194  -- join room timeout
VoiceConst.GV_ON_JOINROOM_SVR_ERR 				        = 8195  -- communication with svr meets some error, such as wrong data received from svr
VoiceConst.GV_ON_JOINROOM_UNKNOWN 				        = 8196  -- reserved, GVoice internal unknown error
VoiceConst.GV_ON_JOINROOM_RETRY_FAIL 			        = 8197  -- join room try again fail
VoiceConst.GV_ON_QUITROOM_SUCC 					        = 8198  -- quitroom success, if you have joined room success first, quit room will alway return success
VoiceConst.GV_ON_ROOM_OFFLINE					        = 8199  -- dropped from the room
VoiceConst.GV_ON_ROLE_SUCC						        = 8200  -- change role success
VoiceConst.GV_ON_ROLE_TIMEOUT 					        = 8201  -- change role timeout
VoiceConst.GV_ON_ROLE_MAX_AHCHOR 				        = 8202  -- too many anchors, no more than 5 anchors in the same time are allowed in a national room
VoiceConst.GV_ON_ROLE_NO_CHANGE 				        = 8203  -- the same role as before
VoiceConst.GV_ON_ROLE_SVR_ERROR 				        = 8204  -- server's error in change role

--message mode
VoiceConst.GV_ON_MESSAGE_KEY_APPLIED_SUCC 		        = 12289  -- apply message authkey succ
VoiceConst.GV_ON_MESSAGE_KEY_APPLIED_TIMEOUT 	        = 12290	 -- apply message authkey timeout
VoiceConst.GV_ON_MESSAGE_KEY_APPLIED_SVR_ERR 	        = 12291  -- communication with svr meets some error, such as wrong data received
VoiceConst.GV_ON_MESSAGE_KEY_APPLIED_UNKNOWN 	        = 12292  -- reserved, GVoice internal unknown error
VoiceConst.GV_ON_UPLOAD_RECORD_DONE 			        = 12293  -- upload record file success
VoiceConst.GV_ON_UPLOAD_RECORD_ERROR 			        = 12294  -- upload record file meets some error
VoiceConst.GV_ON_DOWNLOAD_RECORD_DONE 			        = 12295  -- download record file success
VoiceConst.GV_ON_DOWNLOAD_RECORD_ERROR 			        = 12296  -- download record file meets some error
VoiceConst.GV_ON_PLAYFILE_DONE 					        = 12297  -- the record file have played to the end
-- translate mode
VoiceConst.GV_ON_STT_SUCC 						        = 16385  -- speech to text success
VoiceConst.GV_ON_STT_TIMEOUT 					        = 16386  -- speech to text timeout
VoiceConst.GV_ON_STT_APIERR 					        = 16387  -- server's error
-- rstt mode
VoiceConst.GV_ON_RSTT_SUCC						        = 20481  -- stream speech to text success
VoiceConst.GV_ON_RSTT_TIMEOUT					        = 20482  -- stream speech to text timeout
VoiceConst.GV_ON_RSTT_APIERR					        = 20483 --  server's error in stream speech to text
VoiceConst.GV_ON_RSTT_RETRY 					        = 20484  -- need retry stt


--voice report
VoiceConst.GV_ON_REPORT_SUCC 					        = 24577  -- report other player succ
VoiceConst.GV_ON_DATA_ERROR 					        = 24578  -- receive illegal or invalid data from serve
VoiceConst.GV_ON_PUNISHED 					            = 24579  -- the player is punished because of being reported
VoiceConst.GV_ON_NOT_PUNISHED 					        = 24580  -- the player
VoiceConst.GV_ON_KEY_DELECTED 					        = 24581  --
--for LGame
VoiceConst.GV_ON_SAVEDATA_SUCC 					        = 28673  -- LGame save rec
--member synchornize
VoiceConst.GV_ON_ROOM_MEMBER_INROOM 					= 32769  -- member join or in room
VoiceConst.GV_ON_ROOM_MEMBER_OUTROOM 					= 32770  -- member out of room
VoiceConst.GV_ON_DEVICE_EVENT_ADD 					    = 33025  -- device event notify
VoiceConst.GV_ON_DEVICE_EVENT_UNUSABLE 					= 33026  -- device unusable event
VoiceConst.GV_ON_DEVICE_EVENT_DEFAULTCHANGE 		    = 33027  -- default event changed
--for civilized voice
VoiceConst.GV_ON_UPLOAD_REPORT_INFO_ERROR 				= 36865  -- civilized voice reporting error
VoiceConst.GV_ON_UPLOAD_REPORT_INFO_TIMEOUT 			= 36866  -- civilized voice reporting timeout
--for speech translation
VoiceConst.GV_ON_ST_SUCC 			                    = 40961  -- speech translate success
VoiceConst.GV_ON_ST_HTTP_ERROR 			                = 40962  -- http failed
VoiceConst.GV_ON_ST_SERVER_ERROR 			            = 40963  -- server error
VoiceConst.GV_ON_ST_INVALID_JSON 			            = 40964  -- parse rsp json faild.
--for wx mini app
VoiceConst.GV_ON_WX_UPLOAD_SUCC 			            = 45057  -- upload self info to wx success
VoiceConst.GV_ON_WX_UPLOAD_ERR 			                = 45058  -- upload self info to wx failed
VoiceConst.GV_ON_WX_ROOM_SUCC 			                = 45059  -- query wx room members success
VoiceConst.GV_ON_WX_ROOM_ERR 			                = 45060  -- query wx room members failed
VoiceConst.GV_ON_WX_USER_SUCC 			                = 45061  -- query wx user info success
VoiceConst.GV_ON_WX_USER_ERR 			                = 45062  -- query wx user info failed
--for realtime translate
VoiceConst.GV_ON_TRANSLATE_SUCC 			            = 49153  -- realtime enable translate ok
VoiceConst.GV_ON_TRANSLATE_SERVER_ERR 			        = 49154  -- realtime enable translate server error



