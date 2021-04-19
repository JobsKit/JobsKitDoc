#!/bin/bash
# 项目名
PROJECT_NAME=JobsIM.app

# 项目根目录
ROOT_DIR=/Users/jobs/Desktop/JobsIM

# build 文件夹的位置
BUILD_DIR=${ROOT_DIR}/Build

# ipa 存放的路径
IPA_DIR=${BUILD_DIR}/ipas

# Debug app的位置
DEBUG_DIR=${BUILD_DIR}/Products/Debug-iphoneos

# Release app的位置
RELEASE_DIR=${BUILD_DIR}/Products/Release-iphoneos

# 生成ipa的个数
GENERATE_COUNT=1;

# ipa 包名前缀
IPA_NAME_PRE=JobsIM_0417_Release_ios

cd $ROOT_DIR
#先查看是否存在 用于存放生成ipa的文件夹，没有就创建一个
if [ ! -d $IPA_DIR ]; then
    mkdir $IPA_DIR
fi

for ((i = 1; i <= ${GENERATE_COUNT}; i++))
do
    echo "【序号${i}】开始生成包：${IPA_NAME_PRE}${i}.ipa"
    xcodebuild -workspace JobsIM.xcworkspace -scheme JobsIM -configuration Release -sdk iphoneos14.4 #JOBS_TEST='\@\"乔布斯测试_'${i}'\"'  #(可接参数)
    xcrun -sdk iphoneos -v PackageApplication ${RELEASE_DIR}/${PROJECT_NAME} -o ${IPA_DIR}/${IPA_NAME_PRE}${i}.ipa
    
done

