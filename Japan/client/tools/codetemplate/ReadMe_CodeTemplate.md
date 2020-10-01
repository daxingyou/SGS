## 这是一个lua 的脚本模板
> 需要安装Python2.7 版本 并且需要配置python 的运行环境(保证在控制台可以直接运行python)
### 文件说明
* CodeTemplate_run.exe 可直接执行不需要安装
* CodeTemplate_install.exe 需要安装 有点就是打开更快
* Script 文件夹 放着模板脚本代码 和 模板文件

### 使用说明
#### 打开执行文件 需要设置
* username 用户名(随便 不要中文)
* clientPath 客户端代码位置 例如：E:\work\client\trunk\cocosstudio
* scriptPath 脚本位置（只要设置到Script那层目录） 例如：C:\Users\nieming\Desktop\codetemplate\Script
* protoPath protobuf文件夹路径(预留 待完善) 例如：E:\work\common\proto\release
#### 使用
> 可以单独使用Script/codeTemplate/codeTemplate.py 独立运行
* 目前就只有一个功能 就是根据csd 文件路径生成对应的lua文件 减少代码编写量
#### 扩展其他控件模板
* 所有模板在Script/codeTemplate/template下面
