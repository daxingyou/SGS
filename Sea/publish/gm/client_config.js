
var opOptionConfig = [
    {
        name: 'popupUrl',
        title:'公告网页地址',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'defaultServer',
        title:'默认服务器ID（数字）',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'appVersion',
        title:'app版本号（x.x.x）',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'appVersionDesc',
        title:'app更新提示（文本）',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'appVersionUrl',
        title:'app更新地址',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'appVersionType',
        title:'app更新类型',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'json',
                name:'json格式'
            },
            {
                id: 'download',
                name:'整包下载'
            },
            {
                id: 'url',
                name:'打开网页'
            },
        ]
    },
    {
        name: 'resVersion',
        title:'内更新版本号（x.x.x）',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'resVersionUrl',
        title:'内更新地址',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'runCode',
        title: "可运行版本（数字）",
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'runCodeDesc',
        title: "可运行版本提示（文本）",
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'reportFight',
        title:'错误战报上传开关',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            },
        ]
    }, 
    {
        name: 'error',
        title:'LUA报错弹框开关',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            },
        ]
    }, 
    {
        name: 'errorTip',
        title:'LUA报错提示（文本）',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'serverNotAllowedTip',
        title:'未开服提示（文本）',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'serverUnknownErrorTip',
        title:'未知错误提示（文本）',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'giftcode',
        title:'礼品码开关',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            },
        ]
    }, 
    {
        name: 'alwaysShowToolBar',
        title:'永远显示SDK悬浮窗',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            },
        ]
    }, 
    {
        name: 'showBindWeChat',
        title: "绑定微信公众号开关",
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name: "关闭"
            },
            {
                id: 'true',
                name: "打开"
            }
        ]
    }, 
    {
        name: 'share',
        title: "分享开关",
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name: "关闭"
            },
            {
                id: 'true',
                name: "打开"
            }
        ]
    }, 
    {
        name: 'review',
        title: "评论开关",
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name: "关闭"
            },
            {
                id: 'true',
                name: "打开"
            }
        ]
    }, 
    {
        name: 'recharge',
        title:'充值开关',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            },
        ]
    },
    {
        name: 'rechargeTip',
        title:'充值稍候提示',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            },
        ]
    },
    {
        name: 'sandbox',
        title:'appstore沙盒',
        type: 'select',
        checked: 0,
        option: [
        	{
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'appstore',
        title:'appstore审核',
        type: 'select',
        checked: 0,
        option: [
        	{
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'remoteServer',
        title:'远程服务器列表开关',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'serverCacheTime',
        title:'server刷新时间（秒）',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'listServer',
        title:'指定服务器列表（json格式）',
        type: 'textarea',
        checked: 0,
        option: []
    },
    {
        name: 'addServer',
        title:'附加服务器列表（json格式）',
        type: 'textarea',
        checked: 0,
        option: []
    },
    {
        name: 'remoteGateway',
        title:'远程网关列表开关',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'gatewayCacheTime',
        title:'gateway刷新时间（秒）',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'listGateway',
        title:'指定网关列表（xxx|port,xxx|port）',
        type: 'textarea',
        checked: 0,
        option: []
    },
    {
        name: 'addGateway',
        title:'附加网关列表（xxx|port,xxx|port）',
        type: 'textarea',
        checked: 0,
        option: []
    },
    {
        name: 'blackList',
        title:'附加屏蔽字（逗号分隔）',
        type: 'textarea',
        checked: 0,
        option: []
    },
    {
        name: 'patchCode',
        title:'紧急处理代码（lua）',
        type: 'textarea',
        checked: 0,
        option: []
    },
    {
        name: 'specialVersions',
        title:'特殊版本号（逗号分隔）',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'specialDevices',
        title:'特殊设备ID（json格式）',
        type: 'text',
        checked: 0,
        option: []
    },        
    {
        name: 'specialConfig',
        title:'指定配置（根据特殊版本和特殊设备）',
        type: 'select',
        checked: 0,
        option: [
            {
                id: '',
                name:'无'
            },
            {
                id: '99998',
                name:'99998'
            },
            {
                id: '99997',
                name:'99997'
            },
            {
                id: '99996',
                name:'99996'
            },
            {
                id: '99995',
                name:'99995'
            },
            {
                id: '99994',
                name:'99994'
            },
            {
                id: '99993',
                name:'99993'
            },
            {
                id: '99992',
                name:'99992'
            },
            {
                id: '99991',
                name:'99991'
            },
            {
                id: '99990',
                name:'99990'
            },
            {
                id: '99989',
                name:'99989'
            }
        ]
    },
    {
        name: 'rechargeLimit',
        title:'充值限制',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'realName',
        title:'开启实名认证',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'avoidHooked',
        title:'开启防沉迷',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'avoidOnlineTime',
        title:'防沉迷开启游戏时间',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'svipOpen',
        title:'开启大蓝专属VIP',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'svipQQ',
        title:'大蓝专属Vip客服QQ号',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'svipImage',
        title:'大蓝专属Vip客服图片',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'svipRegisteOpen',
        title:'开启高级VIP认证',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'largeCashReCharge',
        title:'开启大额充值',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'downloadThreeKindoms',
        title:'手杀联动',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'downloadThreeKindomsUrl',
        title:'手杀下载跳转地址',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'yearsOldWarn',
        title:'18+岁提示图片显示',
        type: 'select',
        checked: 1,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'goBack',
        title:'android返回键控制游戏返回上一层',
        type: 'select',
        checked: 1,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'blackListOpen',
        title:'屏蔽字系统',
        type: 'select',
        checked: 1,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'voiceOpen',
        title:'开启语音功能',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'skipChapterText',
        title:'跳过每章关卡文字',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'googleFeatureOpen',
        title:'Google推荐功能开关，战斗暂停、剧情对话',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'appstoreFeatureOpen',
        title:'Appstore推荐位功能开关',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'storeCommentOpen',
        title:'商店评论开关',
        type: 'select',
        checked: 1,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'storeCommentUrl',
        title:'商店评论url（json格式{"android":"http:..","ios":"http:.."}）',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'centerForumUrl',
        title:'客户中心、官方论坛url（json格式{"center":"http:..","forum":"http:.."}）',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'vipPhotoUrl',
        title:'Vip客服照片地址',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'strategyOpen',
        title:'攻略区开关',
        type: 'select',
        checked: 0,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'voiceAutoPay',
        title:'语音自动播放开关',
        type: 'select',
        checked: 1,
        option: [
            {
                id: 'false',
                name:'关闭'
            },
            {
                id: 'true',
                name:'打开'
            }
        ]
    },
    {
        name: 'audioVersion',
        title:'语音分包版本号（x.x.x）',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'audioVersionUrl',
        title:'语音分包地址',
        type: 'text',
        checked: 0,
        option: []
    },
    {
        name: 'popupRedUrl',
        title:'公告红点网页地址',
        type: 'text',
        checked: 0,
        option: []
    },
]