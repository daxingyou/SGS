#!/bin/sh

filepath=$(cd "$(dirname "$0")"; pwd)
echo $filepath
cd $filepath
$filepath/runtime/mac/xgame-desktop.app/Contents/MacOS/xgame-desktop  -workdir ${filepath}/cocosstudio -writable-path ${filepath}/documents -console disable
# exit 0

# #!/bin/sh
# SCRIPT_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
# DIR=$SCRIPT_DIR/..
# $DIR/runtime/mac/xgame-desktop.app/Contents/MacOS/luagame-desktop \
# -workdir $DIR \
# -writable-path $DIR/userdata \
# -console disable
